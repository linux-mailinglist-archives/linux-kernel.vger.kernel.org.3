Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA83B46ED7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbhLIQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:52:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237125AbhLIQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639068563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mg8+iEUfPF/CePHIH5JohT0gTramgBtXXX/yELufpBo=;
        b=fWlKvtIjtQ05ol1ZGxfSFl+PEhpvTlsdREQ1gDpII+Ntc0amivMWPKKhzQ97O1LwC3F8K0
        dDhAMKrBzI/tZt0mGvTQFo9wScjmFpzDadzS0TFqBlfmP2YHqkkapbLXlQCKgAKPHCEAWe
        2PsoRS8z/ZZRGJw/4GlGSk9KBCRf5rE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-kXFNESeUMNOyTtr7d-xTsQ-1; Thu, 09 Dec 2021 11:49:22 -0500
X-MC-Unique: kXFNESeUMNOyTtr7d-xTsQ-1
Received: by mail-wr1-f70.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso1611793wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 08:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mg8+iEUfPF/CePHIH5JohT0gTramgBtXXX/yELufpBo=;
        b=R7Pya6QbNwbpNEQLGD+BendYdz6Ksg2KZxUs+yMny4IxNNGr2D50dX+AJRCfuV/+UO
         Wux/pzWx1KWqTH8K8nSzrhvX7KLUle/KFdAIUd8rWDXU9c/0t24IC6CQsITuEHWqHefQ
         c0wkgELdBVOx6g8NKH7ZYPJTd2KIJeBnJHSCaBb3tSvcz/QnbPP65bFDefCf7zu5220s
         F5bjN+TjHe+T4dvr2LIn3YxMQy7l6+iLlqqGlSNwwg+wG9XVCEAMRw+8JboyazKYtKBt
         Hwc/qYtxkcyCmKEUBLq2QolxIY4LlnZMfGZg8Qlg77HR0hcK9zDFLYh7Veq4luWNIQ4e
         QVsA==
X-Gm-Message-State: AOAM533GAwa6vru+fF+lCzbA58unBQ3jOG9AtPSARNgwJibKfb5bfxM5
        GqFYVEulhX+OCt/P9DSfPZ6sN4hXpJffVLAQLCPBU746NfEc8KPm6/ZMP1nszcYMICYvURZzLkl
        nXF4SIRI7gJOJHcweeoA9pxc=
X-Received: by 2002:a1c:5409:: with SMTP id i9mr8245878wmb.146.1639068560547;
        Thu, 09 Dec 2021 08:49:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJww4HkfvDrBJRRyTvEeeTYWMN09n614ytN7RahqQN3rMmXjAYZ2kgyuxHWMM7aBTmq4IWh+Ig==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr8245779wmb.146.1639068559645;
        Thu, 09 Dec 2021 08:49:19 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g5sm301212wri.45.2021.12.09.08.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:19 -0800 (PST)
Date:   Thu, 9 Dec 2021 16:49:17 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>, Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-12-08 12:47 -0800, Luis Chamberlain wrote:
> Hey Aaron thanks for your patch!

Hi Luis,

Firstly, thank you for your review and feedback thus far.

> Please Cc the folks I added in future iterations.

All right.

> > If the previously unloaded module is loaded once again it will be removed
> > from the list only if the taints bitmask is the same.
> 
> That doesn't seem to be clear. What if say a user loads a module which
> taints the kernel, and then unloads it, and then tries to load a similar
> module with the same name but that it does not taint the kernel?
> 
> Would't we loose visibility that at one point the tainting module was
> loaded? OK I see after reviewing the patch that we keep track of each
> module instance unloaded with an attached unsigned long taints. So if
> a module was unloaded with a different taint, we'd see it twice. Is that
> right?

Indeed - is this acceptable to you? I prefer this approach rather than
remove it from the aforementioned list solely based on the module name.

> > The number of tracked modules is not fixed and can be modified accordingly.
> 
> The commit should mention what happens if the limit is reached.

I will mention this accordingly.

> wc -l kernel/*.c| sort -r -n -k 1| head
> 84550 total
> 6143 kernel/workqueue.c
> 4810 kernel/module.c
> 4789 kernel/signal.c
> 3170 kernel/fork.c
> 2997 kernel/auditsc.c
> 2902 kernel/kprobes.c
> 2857 kernel/sysctl.c
> 2760 kernel/sys.c
> 2712 kernel/cpu.c
> 
> I think it is time we start splitting module.c out into components,
> and here we might have a good opportunity to do that. There are tons
> of nasty cob webs I'd like to start cleaning up from module.c. So
> how about we start by moving module stuff out to kernel/modules/main.c
> and then you can bring in your taint friend into that directory.
> 
> That way we can avoid the #ifdefs, which seem to attract huge spiders.

Agreed. This makes sense. I'll work on it.

> Maybe live patch stuff go in its own file too?

At first glance, I believe this is possible too.

> 
> > +static LIST_HEAD(unloaded_tainted_modules);
> > +static int tainted_list_count;
> > +int __read_mostly tainted_list_max_count = 20;
> 
> Please read the guidance for __read_mostly on include/linux/cache.h.
> I don't see performance metrics on your commit log to justify this use.
> We don't want people to just be using that for anything they think is
> read often... but not really in the context of what it was originally
> desinged for.

Understood.

> Loading and unloading modules... to keep track of *which ones are
> tainted*. I'd find it extremely hard to believe this is such a common
> thing and hot path that we need this.
> 
> In any case, since a linked list is used, I'm curious why did you
> decide to bound this to an arbitrary limit of say 20? If this
> feature is enabled why not make this boundless?

It can be, once set to 0. Indeed, the limit specified above is arbitrary.
Personally, I prefer to have some limit that can be controlled by the user.
In fact, if agreed, I can incorporate the limit [when specified] into the
output generated via print_modules().

> 
> > +struct mod_unloaded_taint {
> > +	struct list_head list;
> > +	char name[MODULE_NAME_LEN];
> > +	unsigned long taints;
> > +};
> > +#endif
> >  
> >  /* Work queue for freeing init sections in success case */
> >  static void do_free_init(struct work_struct *w);
> > @@ -310,6 +321,47 @@ int unregister_module_notifier(struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL(unregister_module_notifier);
> >  
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +
> > +static int try_add_tainted_module(struct module *mod)
> > +{
> > +	struct mod_unload_taint *mod_taint;
> > +
> > +	module_assert_mutex_or_preempt();
> > +
> > +	if (tainted_list_max_count >= 0 && mod->taints) {
> > +		if (!tainted_list_max_count &&
> > +			tainted_list_count >= tainted_list_max_count) {
> > +			pr_warn_once("%s: limit reached on the unloaded tainted modules list (count: %d).\n",
> > +				     mod->name, tainted_list_count);
> > +			goto out;
> > +		}
> > +
> > +		mod_taint = kmalloc(sizeof(*mod_taint), GFP_KERNEL);
> > +		if (unlikely(!mod_taint))
> > +			return -ENOMEM;
> > +		else {
> > +			strlcpy(mod_taint->name, mod->name,
> > +				MODULE_NAME_LEN);
> > +			mod_taint->taints = mod->taints;
> > +			list_add_rcu(&mod_taint->list,
> > +				&unloaded_tainted_modules);
> > +			tainted_list_count++;
> > +		}
> > +out:
> > +	}
> > +	return 0;
> > +}
> > +
> > +#else /* MODULE_UNLOAD_TAINT_TRACKING */
> > +
> > +static int try_add_tainted_module(struct module *mod)
> > +{
> > +	return 0;
> > +}
> > +
> > +#endif /* MODULE_UNLOAD_TAINT_TRACKING */
> > +
> >  /*
> >   * We require a truly strong try_module_get(): 0 means success.
> >   * Otherwise an error is returned due to ongoing or failed
> > @@ -579,6 +631,23 @@ struct module *find_module(const char *name)
> >  {
> >  	return find_module_all(name, strlen(name), false);
> >  }
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +struct mod_unload_taint *find_mod_unload_taint(const char *name, size_t len,
> > +					    unsigned long taints)
> > +{
> > +	struct mod_unload_taint *mod_taint;
> > +
> > +	module_assert_mutex_or_preempt();
> > +
> > +	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
> > +				lockdep_is_held(&module_mutex)) {
> > +		if (strlen(mod_taint->name) == len && !memcmp(mod_taint->name,
> > +			name, len) && mod_taint->taints & taints) {
> > +			return mod_taint;
> > +		}
> > +	}
> > +	return NULL;
> > +#endif
> >  
> >  #ifdef CONFIG_SMP
> >  
> > @@ -1121,13 +1190,13 @@ static inline int module_unload_init(struct module *mod)
> >  }
> >  #endif /* CONFIG_MODULE_UNLOAD */
> >  
> > -static size_t module_flags_taint(struct module *mod, char *buf)
> > +static size_t module_flags_taint(unsigned long taints, char *buf)
> >  {
> >  	size_t l = 0;
> >  	int i;
> >  
> >  	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
> > -		if (taint_flags[i].module && test_bit(i, &mod->taints))
> > +		if (taint_flags[i].module && test_bit(i, &taints))
> >  			buf[l++] = taint_flags[i].c_true;
> >  	}
> 
> Please make this its own separate patch. This makes it easier to review
> the other changes.

No problem, will do.

> >  
> > @@ -1194,7 +1263,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
> >  {
> >  	size_t l;
> >  
> > -	l = module_flags_taint(mk->mod, buffer);
> > +	l = module_flags_taint(mk->mod->taints, buffer);
> >  	buffer[l++] = '\n';
> >  	return l;
> >  }
> > @@ -2193,6 +2262,9 @@ static void free_module(struct module *mod)
> >  	module_bug_cleanup(mod);
> >  	/* Wait for RCU-sched synchronizing before releasing mod->list and buglist. */
> >  	synchronize_rcu();
> > +	if (try_add_tainted_module(mod))
> > +		pr_error("%s: adding tainted module to the unloaded tainted modules list failed.\n",
> > +			 mod->name);
> >  	mutex_unlock(&module_mutex);
> >  
> >  	/* Clean up CFI for the module. */
> > @@ -3670,6 +3742,9 @@ static noinline int do_init_module(struct module *mod)
> >  {
> >  	int ret = 0;
> >  	struct mod_initfree *freeinit;
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +	struct mod_unload_taint *old;
> > +#endif
> >  
> >  	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
> >  	if (!freeinit) {
> > @@ -3703,6 +3778,16 @@ static noinline int do_init_module(struct module *mod)
> >  	mod->state = MODULE_STATE_LIVE;
> >  	blocking_notifier_call_chain(&module_notify_list,
> >  				     MODULE_STATE_LIVE, mod);
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +	mutex_lock(&module_mutex);
> > +	old = find_mod_unload_taint(mod->name, strlen(mod->name),
> > +				mod->taints);
> > +	if (old) {
> > +		list_del_rcu(&old->list);
> > +		synchronize_rcu();
> > +	}
> > +	mutex_unlock(&module_mutex);
> 
> But here we seem to delete an old instance of the module taint
> history if it is loaded again and has the same taint properties.
> Why?

At first glance, in this particular case, I believe this makes sense to
avoid duplication i.e. the taint module would be stored in the 'modules'
list thus should be shown once via print_modules(). So, the initial
objective was to only track a "tainted" module when unloaded and once
added/or loaded again [with the same taint(s)] further tracking cease.

> I mean, if a taint happened once, and our goal is to keep track
> of them, I'd imagine I'd want to know that this had happened
> before, so instead how about just an increment counter for this,
> so know how many times this has happened? Please use u64 for that.
> I have some test environments where module unloaded happens *a lot*.

If I understand correctly, I do not like this approach but indeed it could
work. Personally, I would like to incorporate the above idea i.e. track
the unload count, into the initial goal.

> 
> > +#endif
> >  
> >  	/* Delay uevent until module has finished its init routine */
> >  	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
> > @@ -4511,7 +4596,7 @@ static char *module_flags(struct module *mod, char *buf)
> >  	    mod->state == MODULE_STATE_GOING ||
> >  	    mod->state == MODULE_STATE_COMING) {
> >  		buf[bx++] = '(';
> > -		bx += module_flags_taint(mod, buf + bx);
> > +		bx += module_flags_taint(mod->taints, buf + bx);
> 
> This change can be its own separate patch.

Will do.

> 
> >  		/* Show a - for module-is-being-unloaded */
> >  		if (mod->state == MODULE_STATE_GOING)
> >  			buf[bx++] = '-';
> > @@ -4735,6 +4820,10 @@ void print_modules(void)
> >  {
> >  	struct module *mod;
> >  	char buf[MODULE_FLAGS_BUF_SIZE];
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +	struct mod_unload_taint *mod_taint;
> > +	size_t l;
> > +#endif
> >  
> >  	printk(KERN_DEFAULT "Modules linked in:");
> >  	/* Most callers should already have preempt disabled, but make sure */
> > @@ -4744,6 +4833,15 @@ void print_modules(void)
> >  			continue;
> >  		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
> >  	}
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +	printk(KERN_DEFAULT "\nUnloaded tainted modules:");
> > +	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
> > +				list) {
> > +		l = module_flags_taint(mod_taint->taints, buf);
> > +		buf[l++] = '\0';
> > +		pr_cont(" %s(%s)", mod_taint->name, buf);
> > +	}
> > +#endif
> 
> Ugh yeah no, this has to be in its own file. Reading this file
> is just one huge effort right now. Please make this a helper so we
> don't have to see this eye blinding code.

Sure, no problem.

> 
> >  	preempt_enable();
> >  	if (last_unloaded_module[0])
> >  		pr_cont(" [last unloaded: %s]", last_unloaded_module);
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 272f4a272f8c..290ffaa5b553 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2078,6 +2078,16 @@ static struct ctl_table kern_table[] = {
> >  		.extra1		= SYSCTL_ONE,
> >  		.extra2		= SYSCTL_ONE,
> >  	},
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +	{
> > +		.procname	= "tainted_list_max_count",
> > +		.data		= &tainted_list_max_count,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= &neg_one,
> > +	},
> > +#endif
> >  #endif
> >  #ifdef CONFIG_UEVENT_HELPER
> 
> Please see kernel/sysctl.c changes on linux-next, we're moving away
> from everyone stuffing their sysclts in kernel/sysctl.c and there
> you can find helpers and examples of how *not* to do this. Its
> on the kernel table so you should be able to just
> register_sysctl_init("kernel", modules_sysctls) and while at it,
> if you spot any sysctls for module under the kern_table, please
> move those over and then your patch would be adding just one new
> entry to that new local modules_sysctls table.
> 
> We'll have to coordinate with Andrew given that if your changes
> depend on those changes then we might as well get all your
> changes through Andrew for the next release cycle.

All right. I will make the required changes. Thanks once again.



Regards,

-- 
Aaron Tomlin

