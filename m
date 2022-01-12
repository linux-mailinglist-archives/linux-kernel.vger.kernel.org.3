Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A661D48C3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353085AbiALMMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:12:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47698 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiALMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:12:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B3B50212FE;
        Wed, 12 Jan 2022 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641989548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UliV21thczyW2gxEQPCwFwZW5bKIfoFm/GXU0HCUqY=;
        b=hMYSV2xhdCvSFQWq5Pm+gEjeQ6m9fDGYic5M6bfJ6dU0g1U2raUa0N1GuZGyPktvb4Vl00
        fcFmoou0jS+LUxa7yWS/ZsIuBEVBJ+J96tz27bR6ZX7g7a0hopimahe7HwRqK0gezdCW2V
        c/cIzQXPXcm56XRNAPTOKwOnaEyQyws=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B831A3B83;
        Wed, 12 Jan 2022 12:12:23 +0000 (UTC)
Date:   Wed, 12 Jan 2022 13:12:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Chris Down <chris@chrisdown.name>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Jim Cromie <jim.cromie@gmail.com>
Subject: Re: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between
 printk.h and dynamic_debug.h
Message-ID: <Yd7Fq6V1/Ynff6Qx@alley>
References: <20220111143046.14680-1-pmladek@suse.com>
 <20220111143046.14680-2-pmladek@suse.com>
 <996a7cf5-b047-5038-c86b-f10820364465@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996a7cf5-b047-5038-c86b-f10820364465@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-01-11 17:01:35, Rasmus Villemoes wrote:
> On 11/01/2022 15.30, Petr Mladek wrote:
> > `make headerdep` reports many circular dependencies with the same
> > pattern:
> > 
> > In file included from linux/printk.h,
> >                  from linux/dynamic_debug.h:188
> >                  from linux/printk.h:559 <-- here
> > 
> > It looks like false positive:
> > 
> >    + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
> >    + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE
> > 
> > Instead, this patch adds 'include/linux/printk_core.h' and moves some
> > lowlevel printk API there. Then the raw _printk() can be called from
> > the inlined code in 'dynamic_debug.h'.
> 
> Urgh, this doesn't look like the right approach.

It is not ideal. But it allows to handle these cycles without
complicating external code. It is not only about dynamic_debug.h.
The problem is also in include/asm-generic/bug.h and possibly other
headers included directly or indirectly from printk.h.

Another small advantage is that printk_core.h might define other
printk API that is not intended for general use.


> >  static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
> >  				    const char *modname)
> > @@ -202,9 +202,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
> >  						const char *modname)
> >  {
> >  	if (strstr(param, "dyndbg")) {
> > -		/* avoid pr_warn(), which wants pr_fmt() fully defined */
> > -		printk(KERN_WARNING "dyndbg param is supported only in "
> > -			"CONFIG_DYNAMIC_DEBUG builds\n");
> > +		/* Use raw _printk() to avoid cyclic dependency. */
> > +		_printk(KERN_WARNING "dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds\n");
> >  		return 0; /* allow and ignore */
> >  	}
> >  	return -EINVAL;
> 
> It looks like this has only one caller, kernel/module.c. I suggest
> simply moving the match logic into unknown_module_param_cb(), making it
> on par with the other "generic" module parameter async_probe. That is,
> do something like
> 
>   if (strstr(param, "dyndbg")) {
>     if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
>       return ddebug_dyndbg_module_param_cb(param, val, modname)
>     }
>     pr_warn("dyndbg param is supported only in ...");
>     return 0; /* allow and ignore */
>   }
> 
>   pr_warn("%s: unknown parameter '%s' ignored\n", modname, param);
>   return 0;
> 
> That makes it simpler to add more magic/generic module parameters in
> unknown_module_param_cb(). No need for a static inline stub, and no need
> for conditionally declaring ddebug_dyndbg_module_param_cb(). So all that
> is needed in dynamic_debug.h is to remove the static inline definition,
> and pull the declaration outside #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
> protection.

I do not have strong opinion here. The advantage of the current code
is that it keeps the complexity in dynamic_debug code.

Adding Jessica into CC to know her preferences.


> What's with the strstr, btw? Shouldn't it just be !strcmp()?

"dyndbg" parameter might be used as <module>.dyndbg[="val"].


> > @@ -223,7 +222,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
> >  
> >  static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
> >  {
> > -	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> > +	/* Use raw _printk() to avoid cyclic dependency. */
> > +	_printk(KERN_WARNING "kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> >  	return 0;
> >  }
> 
> And for this one I think the solution is even simpler, as I can't find
> any in-tree callers. Perhaps just nuke it entirely?

Adding Jim into Cc whether he still has any plans to use this API.

Best Regards,
Petr
