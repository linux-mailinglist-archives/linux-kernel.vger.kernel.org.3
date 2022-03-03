Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6914CC5F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiCCTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiCCTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:22:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF319DE8F;
        Thu,  3 Mar 2022 11:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=08w/JDc6qYmmd6ovLlMzlRArZfgwr+xAOgxsS/BhhsA=; b=KKQxlDmoKr87TIhmd/vvDz8YxI
        lye7zT8OUNIA1y2tPc+aoZxCeR+bRqOYVXpp6JC6hiM5zuaoIb68Gmm9b11YOU7JTIW9uZu+dhfmi
        41Dq8AIa2jmYj/MyeOStSXAwbhFXPEfhNknkxttwleckZu5cHpEyP1b2NK+R5eZn6S7vrw8j2cLGq
        micWjVxpvAmflE+tY3/+lhMiuobASej5rGt9E9mM2PheRHz3TaCJGX4gRs5Yb1Yxb1qQIpWP3emoM
        uKtznUa3WFOtpWKE7oLpavguGDVASYMiw63jofAyhUUXXNZgDkKGW5ctXUKX0ItGqKVPm4c4WeY1g
        sRo7k6rw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPr1A-007ZIm-6q; Thu, 03 Mar 2022 19:21:40 +0000
Date:   Thu, 3 Mar 2022 11:21:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <YiEVRFl3uOTO4uw9@bombadil.infradead.org>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
 <20220303145949.inaz2tecmfuek2hf@maple.lan>
 <YiEAxgVYx552UQFS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiEAxgVYx552UQFS@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:54:14AM -0800, Christoph Hellwig wrote:
> On Thu, Mar 03, 2022 at 02:59:49PM +0000, Daniel Thompson wrote:
> > 
> > One of the best ways that we can common up code might be to dust
> > off some code I wrote a while back to display seq_files from
> > kdb.
> > 
> > The basic idea worked well enough but it often needs special
> > start/stop operatings to ensure the start meeds kdb's rather
> > odd locking restrictions. If there is a willingness for
> > something like the below to be included in the module code then we
> > could replace kdb_lsmod() with something that reused the code to
> >  format /proc/modules.
> 
> Displaying seq_files sounds nice to have, but in the short term I'm
> just thinking of something like this:
> 
> diff --git a/include/linux/kdb.h b/include/linux/kdb.h
> index ea0f5e580fac2..07dfb6a20a1c4 100644
> --- a/include/linux/kdb.h
> +++ b/include/linux/kdb.h
> @@ -222,5 +222,6 @@ enum {
>  
>  extern int kdbgetintenv(const char *, int *);
>  extern int kdb_set(int, const char **);
> +int kdb_lsmod(int argc, const char **argv);

Yes exactly.

>  #endif	/* !_KDB_H */
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 0852a537dad4c..292a407118a4f 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2004,54 +2004,6 @@ static int kdb_ef(int argc, const char **argv)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_MODULES)
> -/*
> - * kdb_lsmod - This function implements the 'lsmod' command.  Lists
> - *	currently loaded kernel modules.
> - *	Mostly taken from userland lsmod.
> - */
> -static int kdb_lsmod(int argc, const char **argv)
> -{
> -	struct module *mod;
> -
> -	if (argc != 0)
> -		return KDB_ARGCOUNT;
> -
> -	kdb_printf("Module                  Size  modstruct     Used by\n");
> -	list_for_each_entry(mod, kdb_modules, list) {
> -		if (mod->state == MODULE_STATE_UNFORMED)
> -			continue;
> -
> -		kdb_printf("%-20s%8u  0x%px ", mod->name,
> -			   mod->core_layout.size, (void *)mod);
> -#ifdef CONFIG_MODULE_UNLOAD
> -		kdb_printf("%4d ", module_refcount(mod));
> -#endif
> -		if (mod->state == MODULE_STATE_GOING)
> -			kdb_printf(" (Unloading)");
> -		else if (mod->state == MODULE_STATE_COMING)
> -			kdb_printf(" (Loading)");
> -		else
> -			kdb_printf(" (Live)");
> -		kdb_printf(" 0x%px", mod->core_layout.base);
> -
> -#ifdef CONFIG_MODULE_UNLOAD
> -		{
> -			struct module_use *use;
> -			kdb_printf(" [ ");
> -			list_for_each_entry(use, &mod->source_list,
> -					    source_list)
> -				kdb_printf("%s ", use->target->name);
> -			kdb_printf("]\n");
> -		}
> -#endif
> -	}
> -
> -	return 0;
> -}
> -
> -#endif	/* CONFIG_MODULES */
> -
>  /*
>   * kdb_env - This function implements the 'env' command.  Display the
>   *	current environment variables.
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index 0d2f9feea0a46..1f8c519a5f81c 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -226,10 +226,6 @@ extern void kdb_kbd_cleanup_state(void);
>  #define kdb_kbd_cleanup_state()
>  #endif /* ! CONFIG_KDB_KEYBOARD */
>  
> -#ifdef CONFIG_MODULES
> -extern struct list_head *kdb_modules;
> -#endif /* CONFIG_MODULES */
> -
>  extern char kdb_prompt_str[];
>  
>  #define	KDB_WORD_SIZE	((int)sizeof(unsigned long))
> diff --git a/kernel/module.c b/kernel/module.c
> index 6cea788fd965c..754ec20aab4f1 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -57,6 +57,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/audit.h>
> +#include <linux/kdb.h>
>  #include <uapi/linux/module.h>
>  #include "module-internal.h"
>  
> @@ -252,10 +253,6 @@ static void mod_update_bounds(struct module *mod)
>  		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
>  }
>  
> -#ifdef CONFIG_KGDB_KDB
> -struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
> -#endif /* CONFIG_KGDB_KDB */
> -
>  static void module_assert_mutex_or_preempt(void)
>  {
>  #ifdef CONFIG_LOCKDEP
> @@ -4808,3 +4805,45 @@ void module_layout(struct module *mod,
>  }
>  EXPORT_SYMBOL(module_layout);
>  #endif
> +
> +#ifdef CONFIG_KGDB_KDB

Yes! And then when we move all this crap to its own files on
kernel/module/Makefile:

obj-$(CONFIG_KGDB_KDB) += kdb.o

> +int kdb_lsmod(int argc, const char **argv)
> +{
> +	struct module *mod;
> +
> +	if (argc != 0)
> +		return KDB_ARGCOUNT;
> +
> +	kdb_printf("Module                  Size  modstruct     Used by\n");

Indeed, we need to do it this way because kdb_printf() which emits
messages directly to I/O drivers, bypassing the kernel log. Perhaps this
info should be added to the top of kernel/module/kdb.c

> +	list_for_each_entry(mod, &modules, list) {
> +		if (mod->state == MODULE_STATE_UNFORMED)
> +			continue;
> +
> +		kdb_printf("%-20s%8u  0x%px ", mod->name,
> +			   mod->core_layout.size, (void *)mod);
> +#ifdef CONFIG_MODULE_UNLOAD
> +		kdb_printf("%4d ", module_refcount(mod));
> +#endif

Yes and later this can be if IS_ENABLED(CONFIG_MODULE_UNLOAD)

> +		if (mod->state == MODULE_STATE_GOING)
> +			kdb_printf(" (Unloading)");
> +		else if (mod->state == MODULE_STATE_COMING)
> +			kdb_printf(" (Loading)");
> +		else
> +			kdb_printf(" (Live)");
> +		kdb_printf(" 0x%px", mod->core_layout.base);
> +
> +#ifdef CONFIG_MODULE_UNLOAD

and if IS_ENABLED(CONFIG_MODULE_UNLOAD) later

> +		{
> +			struct module_use *use;
> +			kdb_printf(" [ ");
> +			list_for_each_entry(use, &mod->source_list,
> +					    source_list)
> +				kdb_printf("%s ", use->target->name);
> +			kdb_printf("]\n");
> +		}
> +#endif
> +	}
> +
> +	return 0;
> +}
> +#endif	/* CONFIG_KGDB_KDB */

  Luis
