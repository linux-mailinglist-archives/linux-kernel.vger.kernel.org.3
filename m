Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E713546DD44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhLHUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLHUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:51:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF1C061746;
        Wed,  8 Dec 2021 12:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hzqUexwlu7GDGwVcfQWNWE7JauX4sDTdUpZR7CngkdM=; b=dsThMxV1wZAiorQEbsJyzrHF+m
        SHWnR8layCL3xn5dEZZi/j7kaDyLszDQgc2CCf26MZbLhb3Vl5/tMJ1u7G04O0AWFbIEzkgfY6B2w
        BQCZkWx+8Brc9YbjlKxbc2gMCqNPVDRB8OAV/eMor/8FsIz4CGDdflafqJVsy0434jTPxFg5gomRs
        M+v8AwvFjwhpZeztln5gldxNvHXBert8MW+b6LeBl9GUDRnTX7S20PHrfC4A8t4TJWk6rchWjXUE1
        OsL+JvtVc3SS8+Ns1PBfsr3pw972bv4GYade3WKrEjClO4bS2s5tAdMTVJ2Ij8qlkOhMdxocMLJL5
        /lUY/duQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv3qa-00EE33-1R; Wed, 08 Dec 2021 20:47:28 +0000
Date:   Wed, 8 Dec 2021 12:47:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
References: <20211124173327.3878177-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124173327.3878177-1-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Aaron thanks for your patch! Please Cc the folks I added in future
iterations. My review below.

Andrew,

just Cc'ing you in case the sysctl changes in here need to rely on
your changes. If so then we'll have these changes (if and once reviewed)
go through your tree.

On Wed, Nov 24, 2021 at 05:33:27PM +0000, Aaron Tomlin wrote:
> Currently, only the initial module that tainted the kernel is
> recorded e.g. when an out-of-tree module is loaded.
> 
> So the purpose of this patch is to allow the kernel to maintain a record of
> each unloaded module that taints the kernel. Now, in addition to displaying
> a list of linked modules (see print_modules()) e.g. in the event of an
> Oops, unloaded modules that carried a taint/or taints are also displayed.

This all does indeed seem useful to me.

> If the previously unloaded module is loaded once again it will be removed
> from the list only if the taints bitmask is the same.

That doesn't seem to be clear. What if say a user loads a module which
taints the kernel, and then unloads it, and then tries to load a similar
module with the same name but that it does not taint the kernel?

Would't we loose visibility that at one point the tainting module was
loaded? OK I see after reviewing the patch that we keep track of each
module instance unloaded with an attached unsigned long taints. So if
a module was unloaded with a different taint, we'd see it twice. Is that
right?

> The number of tracked modules is not fixed and can be modified accordingly.

The commit should mention what happens if the limit is reached.

> This feature is disabled by default.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  include/linux/module.h |   5 ++
>  init/Kconfig           |   9 ++++
>  kernel/module.c        | 106 +++++++++++++++++++++++++++++++++++++++--
>  kernel/sysctl.c        |  10 ++++
>  4 files changed, 126 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8a298d820dbc..6f089953f28a 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -672,6 +672,11 @@ static inline bool is_livepatch_module(struct module *mod)
>  bool is_module_sig_enforced(void);
>  void set_module_sig_enforced(void);
>  
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +
> +extern int tainted_list_max_count; /* for sysctl */
> +
> +#endif
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> diff --git a/init/Kconfig b/init/Kconfig
> index bb0d6e6262b1..699c6cf948d8 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2087,6 +2087,15 @@ config MODULE_FORCE_UNLOAD
>  	  rmmod).  This is mainly for kernel developers and desperate users.
>  	  If unsure, say N.
>  
> +config MODULE_UNLOAD_TAINT_TRACKING
> +	bool "Tainted module unload tracking"
> +	default n
> +	help
> +          This option allows you to maintain a record of each unloaded
> +          module that taints the kernel. Now in addition to displaying a
> +          list of linked modules e.g. in the event of an Oops, the
> +          aforementioned details are also displayed. If unsure, say N.
> +
>  config MODVERSIONS
>  	bool "Module versioning support"
>  	help
> diff --git a/kernel/module.c b/kernel/module.c
> index ed13917ea5f3..11e10b571d64 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -90,6 +90,17 @@
>   */
>  static DEFINE_MUTEX(module_mutex);
>  static LIST_HEAD(modules);
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING

wc -l kernel/*.c| sort -r -n -k 1| head
84550 total
6143 kernel/workqueue.c
4810 kernel/module.c
4789 kernel/signal.c
3170 kernel/fork.c
2997 kernel/auditsc.c
2902 kernel/kprobes.c
2857 kernel/sysctl.c
2760 kernel/sys.c
2712 kernel/cpu.c

I think it is time we start splitting module.c out into components,
and here we might have a good opportunity to do that. There are tons
of nasty cob webs I'd like to start cleaning up from module.c. So
how about we start by moving module stuff out to kernel/modules/main.c
and then you can bring in your taint friend into that directory.

That way we can avoid the #ifdefs, which seem to attract huge spiders.

Maybe live patch stuff go in its own file too?

> +static LIST_HEAD(unloaded_tainted_modules);
> +static int tainted_list_count;
> +int __read_mostly tainted_list_max_count = 20;

Please read the guidance for __read_mostly on include/linux/cache.h.
I don't see performance metrics on your commit log to justify this use.
We don't want people to just be using that for anything they think is
read often... but not really in the context of what it was originally
desinged for.

Loading and unloading modules... to keep track of *which ones are
tainted*. I'd find it extremely hard to believe this is such a common
thing and hot path that we need this.

In any case, since a linked list is used, I'm curious why did you
decide to bound this to an arbitrary limit of say 20? If this
feature is enabled why not make this boundless?

> +struct mod_unloaded_taint {
> +	struct list_head list;
> +	char name[MODULE_NAME_LEN];
> +	unsigned long taints;
> +};
> +#endif
>  
>  /* Work queue for freeing init sections in success case */
>  static void do_free_init(struct work_struct *w);
> @@ -310,6 +321,47 @@ int unregister_module_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL(unregister_module_notifier);
>  
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +
> +static int try_add_tainted_module(struct module *mod)
> +{
> +	struct mod_unload_taint *mod_taint;
> +
> +	module_assert_mutex_or_preempt();
> +
> +	if (tainted_list_max_count >= 0 && mod->taints) {
> +		if (!tainted_list_max_count &&
> +			tainted_list_count >= tainted_list_max_count) {
> +			pr_warn_once("%s: limit reached on the unloaded tainted modules list (count: %d).\n",
> +				     mod->name, tainted_list_count);
> +			goto out;
> +		}
> +
> +		mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
> +		if (unlikely(!mod_taint))
> +			return -ENOMEM;
> +		else {
> +			strlcpy(mod_taint->name, mod->name,
> +				MODULE_NAME_LEN);
> +			mod_taint->taints = mod->taints;
> +			list_add_rcu(&mod_taint->list,
> +				&unloaded_tainted_modules);
> +			tainted_list_count++;
> +		}
> +out:
> +	}
> +	return 0;
> +}
> +
> +#else /* MODULE_UNLOAD_TAINT_TRACKING */
> +
> +static int try_add_tainted_module(struct module *mod)
> +{
> +	return 0;
> +}
> +
> +#endif /* MODULE_UNLOAD_TAINT_TRACKING */
> +
>  /*
>   * We require a truly strong try_module_get(): 0 means success.
>   * Otherwise an error is returned due to ongoing or failed
> @@ -579,6 +631,23 @@ struct module *find_module(const char *name)
>  {
>  	return find_module_all(name, strlen(name), false);
>  }
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +struct mod_unload_taint *find_mod_unload_taint(const char *name, size_t len,
> +					    unsigned long taints)
> +{
> +	struct mod_unload_taint *mod_taint;
> +
> +	module_assert_mutex_or_preempt();
> +
> +	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
> +				lockdep_is_held(&module_mutex)) {
> +		if (strlen(mod_taint->name) == len && !memcmp(mod_taint->name,
> +			name, len) && mod_taint->taints & taints) {
> +			return mod_taint;
> +		}
> +	}
> +	return NULL;
> +#endif
>  
>  #ifdef CONFIG_SMP
>  
> @@ -1121,13 +1190,13 @@ static inline int module_unload_init(struct module *mod)
>  }
>  #endif /* CONFIG_MODULE_UNLOAD */
>  
> -static size_t module_flags_taint(struct module *mod, char *buf)
> +static size_t module_flags_taint(unsigned long taints, char *buf)
>  {
>  	size_t l = 0;
>  	int i;
>  
>  	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
> -		if (taint_flags[i].module && test_bit(i, &mod->taints))
> +		if (taint_flags[i].module && test_bit(i, &taints))
>  			buf[l++] = taint_flags[i].c_true;
>  	}

Please make this its own separate patch. This makes it easier to review
the other changes.

>  
> @@ -1194,7 +1263,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
>  {
>  	size_t l;
>  
> -	l = module_flags_taint(mk->mod, buffer);
> +	l = module_flags_taint(mk->mod->taints, buffer);
>  	buffer[l++] = '\n';
>  	return l;
>  }
> @@ -2193,6 +2262,9 @@ static void free_module(struct module *mod)
>  	module_bug_cleanup(mod);
>  	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
>  	synchronize_rcu();
> +	if (try_add_tainted_module(mod))
> +		pr_error("%s: adding tainted module to the unloaded tainted modules list failed.\n",
> +			 mod->name);
>  	mutex_unlock(&module_mutex);
>  
>  	/* Clean up CFI for the module. */
> @@ -3670,6 +3742,9 @@ static noinline int do_init_module(struct module *mod)
>  {
>  	int ret = 0;
>  	struct mod_initfree *freeinit;
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +	struct mod_unload_taint *old;
> +#endif
>  
>  	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
>  	if (!freeinit) {
> @@ -3703,6 +3778,16 @@ static noinline int do_init_module(struct module *mod)
>  	mod->state = MODULE_STATE_LIVE;
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_LIVE, mod);
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +	mutex_lock(&module_mutex);
> +	old = find_mod_unload_taint(mod->name, strlen(mod->name),
> +				mod->taints);
> +	if (old) {
> +		list_del_rcu(&old->list);
> +		synchronize_rcu();
> +	}
> +	mutex_unlock(&module_mutex);

But here we seem to delete an old instance of the module taint
history if it is loaded again and has the same taint properties.
Why?

I mean, if a taint happened once, and our goal is to keep track
of them, I'd imagine I'd want to know that this had happened
before, so instead how about just an increment counter for this,
so know how many times this has happened? Please use u64 for that.
I have some test environments where module unloaded happens *a lot*.

> +#endif
>  
>  	/* Delay uevent until module has finished its init routine */
>  	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
> @@ -4511,7 +4596,7 @@ static char *module_flags(struct module *mod, char *buf)
>  	    mod->state == MODULE_STATE_GOING ||
>  	    mod->state == MODULE_STATE_COMING) {
>  		buf[bx++] = '(';
> -		bx += module_flags_taint(mod, buf + bx);
> +		bx += module_flags_taint(mod->taints, buf + bx);

This change can be its own separate patch.

>  		/* Show a - for module-is-being-unloaded */
>  		if (mod->state == MODULE_STATE_GOING)
>  			buf[bx++] = '-';
> @@ -4735,6 +4820,10 @@ void print_modules(void)
>  {
>  	struct module *mod;
>  	char buf[MODULE_FLAGS_BUF_SIZE];
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +	struct mod_unload_taint *mod_taint;
> +	size_t l;
> +#endif
>  
>  	printk(KERN_DEFAULT "Modules linked in:");
>  	/* Most callers should already have preempt disabled, but make sure */
> @@ -4744,6 +4833,15 @@ void print_modules(void)
>  			continue;
>  		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
>  	}
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +	printk(KERN_DEFAULT "\nUnloaded tainted modules:");
> +	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
> +				list) {
> +		l = module_flags_taint(mod_taint->taints, buf);
> +		buf[l++] = '\0';
> +		pr_cont(" %s(%s)", mod_taint->name, buf);
> +	}
> +#endif

Ugh yeah no, this has to be in its own file. Reading this file
is just one huge effort right now. Please make this a helper so we
don't have to see this eye blinding code.

>  	preempt_enable();
>  	if (last_unloaded_module[0])
>  		pr_cont(" [last unloaded: %s]", last_unloaded_module);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 272f4a272f8c..290ffaa5b553 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2078,6 +2078,16 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +	{
> +		.procname	= "tainted_list_max_count",
> +		.data		= &tainted_list_max_count,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &neg_one,
> +	},
> +#endif
>  #endif
>  #ifdef CONFIG_UEVENT_HELPER

Please see kernel/sysctl.c changes on linux-next, we're moving away
from everyone stuffing their sysclts in kernel/sysctl.c and there
you can find helpers and examples of how *not* to do this. Its
on the kernel table so you should be able to just
register_sysctl_init("kernel", modules_sysctls) and while at it,
if you spot any sysctls for module under the kern_table, please
move those over and then your patch would be adding just one new
entry to that new local modules_sysctls table.

We'll have to coordinate with Andrew given that if your changes
depend on those changes then we might as well get all your
changes through Andrew for the next release cycle.

  Luis
