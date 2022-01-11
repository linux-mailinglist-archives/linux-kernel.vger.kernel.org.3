Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812CF48B180
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiAKQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349734AbiAKQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:01:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C2C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:01:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m1so24784668lfq.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q2AS3TycxvQevBVYSjYR4nMIYCUKzDFIHcZBkFvEUh8=;
        b=PEJK0uUzswSNHeEIUqeC8L1+7Mc20M0ZjBZuw5++ylPnGIp+qQ7sHzfLt1gdOAyTA7
         kaUGUTfHh2v/YlLeOYj7EVD/V0SCsTRjyQKDXii5zE0uhOaWP08q58KU6EXmQHaOPRIX
         BeBajHU/kBiX3LZMcRxOA2KQde7/GvH5bFXF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q2AS3TycxvQevBVYSjYR4nMIYCUKzDFIHcZBkFvEUh8=;
        b=TBonaHsZUcmocNGPuNWTITpK6nYu0A5PfYLTKe58z7n5RGggmHDjjzqgzNQSzuAzw4
         M76BNfrNoWMskqYxpjQrFZmdBhej1/2ae3SjVjPz4eoTyd2qesdY6dwQqnm6h5PRxwL5
         fc0KCNYKcTzvtv1pBCP0wSM44D/rF+8GAPK55paJlxuEHqyYMtOfD75uBLV/TWScP4rR
         nxp0uTvnr20q6LHpAvER4Bl73sb9Hhb8W8pmV7qej7nKCZAtZTqTaBiAunJwyszApRZQ
         z3XU7oFqD1qce/OQwIwaMHHEnNvI4RFowS3xvN3moFPUN2wPxq5dTJPnKAFrVv17i4u8
         /hUg==
X-Gm-Message-State: AOAM531qUDuPKE1VIaurDgLAFulddd1tYn2MEr0XAZVDZKDK3H9k/zX4
        3jrtXklxcwiFdm8sZLUGyJ+fgg==
X-Google-Smtp-Source: ABdhPJyU7ZLqlohFzOd47OnZPgm3hPrl0/6UYKuMwycVjGJc9vAxSJGYIov6dSe39xOdJKJ2SmVcIA==
X-Received: by 2002:ac2:4c45:: with SMTP id o5mr3921318lfk.687.1641916896972;
        Tue, 11 Jan 2022 08:01:36 -0800 (PST)
Received: from [172.16.11.17] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f6sm1373976lfg.67.2022.01.11.08.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:01:36 -0800 (PST)
Subject: Re: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between
 printk.h and dynamic_debug.h
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Chris Down <chris@chrisdown.name>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220111143046.14680-1-pmladek@suse.com>
 <20220111143046.14680-2-pmladek@suse.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <996a7cf5-b047-5038-c86b-f10820364465@rasmusvillemoes.dk>
Date:   Tue, 11 Jan 2022 17:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111143046.14680-2-pmladek@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 15.30, Petr Mladek wrote:
> `make headerdep` reports many circular dependencies with the same
> pattern:
> 
> In file included from linux/printk.h,
>                  from linux/dynamic_debug.h:188
>                  from linux/printk.h:559 <-- here
> 
> It looks like false positive:
> 
>    + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
>    + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE
> 
> Anyway, it would be great to get rid of this dependency because it is
> tricky and it might hit us in the future. Also it might hide another
> more complicated cyclic dependencies.
> 
> One solution would be to move the inlined ddebug_dyndbg_module_param_cb()
> and dynamic_debug_exec_queries() from 'dynamic_debug.h' into some .c so
> that it will not be needed to inline printk() in 'dynamic_debug.h'.
> 
> The obvious location would be 'lib/dynamic_debug.c'. But it is built
> only when CONFIG_DYNAMIC_DEBUG_CORE is set. And the problematic
> inline variants are used only when this config option is _not_ set.
> So that it is not that easy.
> 
> Instead, this patch adds 'include/linux/printk_core.h' and moves some
> lowlevel printk API there. Then the raw _printk() can be called from
> the inlined code in 'dynamic_debug.h'.


Urgh, this doesn't look like the right approach.

>  
>  static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>  				    const char *modname)
> @@ -202,9 +202,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
>  						const char *modname)
>  {
>  	if (strstr(param, "dyndbg")) {
> -		/* avoid pr_warn(), which wants pr_fmt() fully defined */
> -		printk(KERN_WARNING "dyndbg param is supported only in "
> -			"CONFIG_DYNAMIC_DEBUG builds\n");
> +		/* Use raw _printk() to avoid cyclic dependency. */
> +		_printk(KERN_WARNING "dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds\n");
>  		return 0; /* allow and ignore */
>  	}
>  	return -EINVAL;

It looks like this has only one caller, kernel/module.c. I suggest
simply moving the match logic into unknown_module_param_cb(), making it
on par with the other "generic" module parameter async_probe. That is,
do something like


  if (strstr(param, "dyndbg")) {
    if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
      return ddebug_dyndbg_module_param_cb(param, val, modname)
    }
    pr_warn("dyndbg param is supported only in ...");
    return 0; /* allow and ignore */
  }

  pr_warn("%s: unknown parameter '%s' ignored\n", modname, param);
  return 0;

That makes it simpler to add more magic/generic module parameters in
unknown_module_param_cb(). No need for a static inline stub, and no need
for conditionally declaring ddebug_dyndbg_module_param_cb(). So all that
is needed in dynamic_debug.h is to remove the static inline definition,
and pull the declaration outside #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
protection.

What's with the strstr, btw? Shouldn't it just be !strcmp()?

> @@ -223,7 +222,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
>  
>  static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
>  {
> -	pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> +	/* Use raw _printk() to avoid cyclic dependency. */
> +	_printk(KERN_WARNING "kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
>  	return 0;
>  }

And for this one I think the solution is even simpler, as I can't find
any in-tree callers. Perhaps just nuke it entirely?

Rasmus
