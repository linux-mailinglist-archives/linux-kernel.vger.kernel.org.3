Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5CF50A286
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389242AbiDUOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389379AbiDUOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:32:09 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8452D44744
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:28:38 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 6ECEEE9E396;
        Thu, 21 Apr 2022 16:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1650551314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1izGaPHTx8ZX9q7VfNwdJR0QUIA8B8JKj1kURkLhVk=;
        b=BdJ5dahqbUG8L1PJ/+DtAEPNiEQtdieHtj/VXTX2vA/2Ct1lacqutHjSzo0mtPNboktvEU
        fPlh2h93HUv3D4Zn9ilGfJ0UkBknZfgAYM/Xw+YDFobbwKqv7nqEPNquwUHcpmP/dYcD9G
        cCCj25ZSfGfnQbUIGKNscNBiOYKlQpM=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     mcgrof@kernel.org, Aaron Tomlin <atomlin@redhat.com>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, neelx@redhat.com
Subject: Re: [PATCH v3 2/2] module: Introduce module unload taint tracking
Date:   Thu, 21 Apr 2022 16:28:32 +0200
Message-ID: <2100545.irdbgypaU6@natalenko.name>
In-Reply-To: <20220420115257.3498300-3-atomlin@redhat.com>
References: <20220420115257.3498300-1-atomlin@redhat.com> <20220420115257.3498300-3-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Thanks for this submission. Please see one comment inline.

On st=C5=99eda 20. dubna 2022 13:52:57 CEST Aaron Tomlin wrote:
> Currently, only the initial module that tainted the kernel is
> recorded e.g. when an out-of-tree module is loaded.
>=20
> The purpose of this patch is to allow the kernel to maintain a record of
> each unloaded module that taints the kernel. So, in addition to
> displaying a list of linked modules (see print_modules()) e.g. in the
> event of a detected bad page, unloaded modules that carried a taint/or
> taints are displayed too. A tainted module unload count is maintained.
>=20
> The number of tracked modules is not fixed. This feature is disabled by
> default.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  init/Kconfig         | 11 ++++++++
>  kernel/module/main.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>=20
> diff --git a/init/Kconfig b/init/Kconfig
> index ddcbefe535e9..6b30210f787d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2118,6 +2118,17 @@ config MODULE_FORCE_UNLOAD
>  	  rmmod).  This is mainly for kernel developers and desperate users.
>  	  If unsure, say N.
> =20
> +config MODULE_UNLOAD_TAINT_TRACKING
> +	bool "Tainted module unload tracking"
> +	depends on MODULE_UNLOAD
> +	default n
> +	help
> +	  This option allows you to maintain a record of each unloaded
> +	  module that tainted the kernel. In addition to displaying a
> +	  list of linked (or loaded) modules e.g. on detection of a bad
> +	  page (see bad_page()), the aforementioned details are also
> +	  shown. If unsure, say N.
> +
>  config MODVERSIONS
>  	bool "Module versioning support"
>  	help
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index ea78cec316dd..d7cc64172dd1 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -68,6 +68,16 @@
>   */
>  DEFINE_MUTEX(module_mutex);
>  LIST_HEAD(modules);
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +static LIST_HEAD(unloaded_tainted_modules);
> +
> +struct mod_unload_taint {
> +	struct list_head list;
> +	char name[MODULE_NAME_LEN];
> +	unsigned long taints;
> +	u64 count;
> +};
> +#endif
> =20
>  /* Work queue for freeing init sections in success case */
>  static void do_free_init(struct work_struct *w);
> @@ -150,6 +160,41 @@ int unregister_module_notifier(struct notifier_block=
 *nb)
>  }
>  EXPORT_SYMBOL(unregister_module_notifier);
> =20
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +static int try_add_tainted_module(struct module *mod)
> +{
> +	struct mod_unload_taint *mod_taint;
> +
> +	module_assert_mutex_or_preempt();
> +
> +	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
> +				lockdep_is_held(&module_mutex)) {
> +		size_t len =3D strlen(mod_taint->name);
> +
> +		if (len =3D=3D strlen(mod->name) && !memcmp(mod_taint->name, mod->name=
, len) &&

Here, two strings are compared, so I'd expect to see `strncmp()` instead of=
 `memcmp()`.

> +		    mod_taint->taints & mod->taints) {
> +			mod_taint->count++;
> +			goto out;
> +		}
> +	}
> +
> +	mod_taint =3D kmalloc(sizeof(*mod_taint), GFP_KERNEL);
> +	if (unlikely(!mod_taint))
> +		return -ENOMEM;
> +	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
> +	mod_taint->taints =3D mod->taints;
> +	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
> +	mod_taint->count =3D 1;
> +out:
> +	return 0;
> +}
> +#else /* MODULE_UNLOAD_TAINT_TRACKING */
> +static int try_add_tainted_module(struct module *mod)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * We require a truly strong try_module_get(): 0 means success.
>   * Otherwise an error is returned due to ongoing or failed
> @@ -1201,6 +1246,9 @@ static void free_module(struct module *mod)
>  	module_bug_cleanup(mod);
>  	/* Wait for RCU-sched synchronizing before releasing mod->list and bugl=
ist. */
>  	synchronize_rcu();
> +	if (try_add_tainted_module(mod))
> +		pr_err("%s: adding tainted module to the unloaded tainted modules list=
 failed.\n",
> +		       mod->name);
>  	mutex_unlock(&module_mutex);
> =20
>  	/* Clean up CFI for the module. */
> @@ -3126,6 +3174,9 @@ struct module *__module_text_address(unsigned long =
addr)
>  void print_modules(void)
>  {
>  	struct module *mod;
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +	struct mod_unload_taint *mod_taint;
> +#endif
>  	char buf[MODULE_FLAGS_BUF_SIZE];
> =20
>  	printk(KERN_DEFAULT "Modules linked in:");
> @@ -3136,6 +3187,20 @@ void print_modules(void)
>  			continue;
>  		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
>  	}
> +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> +	if (!list_empty(&unloaded_tainted_modules)) {
> +		printk(KERN_DEFAULT "Unloaded tainted modules:");
> +		list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
> +					list) {
> +			size_t l;
> +
> +			l =3D module_flags_taint(mod_taint->taints, buf);
> +			buf[l++] =3D '\0';
> +			pr_cont(" %s(%s):%llu", mod_taint->name, buf,
> +				mod_taint->count);
> +		}
> +#endif
> +	}
>  	preempt_enable();
>  	if (last_unloaded_module[0])
>  		pr_cont(" [last unloaded: %s]", last_unloaded_module);
>=20


=2D-=20
Oleksandr Natalenko (post-factum)


