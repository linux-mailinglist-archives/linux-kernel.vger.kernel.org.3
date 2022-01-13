Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B672E48D4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiAMJCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiAMJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:02:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC8AC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:02:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x6so17144174lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7LyCS0IC5WFJqwSvmXcfoKgU+BI6lkWxIXEP7Epi/No=;
        b=I85TVLUwM33r3jhdgLIfrpTW4f9xNGRKZckAr0Ffq64qFMs6wcp2jkwrPFVS6v/qOC
         t3l3ZG2I/T+BQ7uc3Zc/h1k7nc8sB4yMM9w+2ftyyXFfTraE13aSTCMDhuM6OC0h20kz
         zNtTBAUfHPU1lwoL1eiFA2U6ejiDW4IsgGP/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7LyCS0IC5WFJqwSvmXcfoKgU+BI6lkWxIXEP7Epi/No=;
        b=vcu6oRHaKlghQVhr7b9U5dIU41oAUq4ZVaK3JIFJf63j/fM5bTShLFreVL54y9KyCZ
         aIgvW6qFCvFQTd2Pz74bumBBCxH3bt5Wzd7zxtrc3SSNMINkwkkADvCU+FsHDbK7BA5Y
         waz7T80W45jc4al3Ox2CpeueV7KYICsSHHcSUmq3PUfg4mePashm2+T9e47yPutnvt5z
         ywDpN2TIMu+rYZmp4eL0xQe4Ei/+iA/VMKwecvwEZnfdifh9U/bMxj1CDoja5wgvDkRb
         NVO4e49wFZ4OHfEUZMG22U7rVGtTtvPg51PsxPKLaTAh1vYD7jZXK8zQd16/InSFf1gS
         CCAg==
X-Gm-Message-State: AOAM533TSxjngBALk/ZmaiE2ORdNASqZzjCu5kmYbrhLtScgLNOZpOpe
        JH44LyrDio1x0h9v/iYzKpkLqg==
X-Google-Smtp-Source: ABdhPJxkeLJMNpbod4X8FBgzPNIwqQ762R9bGcRA5nLjPpXoOEfcZsdSkgYlY1MtdNtzg1ddVEzEbA==
X-Received: by 2002:a2e:b947:: with SMTP id 7mr2253104ljs.268.1642064554046;
        Thu, 13 Jan 2022 01:02:34 -0800 (PST)
Received: from [172.16.11.17] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b19sm226156lfb.292.2022.01.13.01.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 01:02:33 -0800 (PST)
Subject: Re: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between
 printk.h and dynamic_debug.h
To:     Petr Mladek <pmladek@suse.com>
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
References: <20220111143046.14680-1-pmladek@suse.com>
 <20220111143046.14680-2-pmladek@suse.com>
 <996a7cf5-b047-5038-c86b-f10820364465@rasmusvillemoes.dk>
 <Yd7Fq6V1/Ynff6Qx@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <614b08c0-268e-c688-2d99-33e96e5b9730@rasmusvillemoes.dk>
Date:   Thu, 13 Jan 2022 10:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yd7Fq6V1/Ynff6Qx@alley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 13.12, Petr Mladek wrote:
> On Tue 2022-01-11 17:01:35, Rasmus Villemoes wrote:
>> On 11/01/2022 15.30, Petr Mladek wrote:
>>> `make headerdep` reports many circular dependencies with the same
>>> pattern:
>>>
>>> In file included from linux/printk.h,
>>>                  from linux/dynamic_debug.h:188
>>>                  from linux/printk.h:559 <-- here
>>>
>>> It looks like false positive:
>>>
>>>    + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
>>>    + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE
>>>
>>> Instead, this patch adds 'include/linux/printk_core.h' and moves some
>>> lowlevel printk API there. Then the raw _printk() can be called from
>>> the inlined code in 'dynamic_debug.h'.
>>
>> Urgh, this doesn't look like the right approach.
> 
> It is not ideal. But it allows to handle these cycles without
> complicating external code. It is not only about dynamic_debug.h.

I'm not against splitting up printk.h, I'm very familiar with the
problems with too-large headers. But I think the specific problem with
dynamic_debug.h has a much smaller and simpler resolution (as I've
suggested), which would also clean up the code a bit, and make a later
refactoring of printk.h simpler - because there's one less user to care
about.

> Another small advantage is that printk_core.h might define other
> printk API that is not intended for general use.
> 
> 
>>>  static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>>>  				    const char *modname)
>>> @@ -202,9 +202,8 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
>>>  						const char *modname)
>>>  {
>>>  	if (strstr(param, "dyndbg")) {
>>> -		/* avoid pr_warn(), which wants pr_fmt() fully defined */
>>> -		printk(KERN_WARNING "dyndbg param is supported only in "
>>> -			"CONFIG_DYNAMIC_DEBUG builds\n");
>>> +		/* Use raw _printk() to avoid cyclic dependency. */
>>> +		_printk(KERN_WARNING "dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds\n");
>>>  		return 0; /* allow and ignore */
>>>  	}
>>>  	return -EINVAL;
>>
>> It looks like this has only one caller, kernel/module.c. I suggest
>> simply moving the match logic into unknown_module_param_cb(), making it
>> on par with the other "generic" module parameter async_probe. That is,
>> do something like
>>
>>   if (strstr(param, "dyndbg")) {
>>     if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
>>       return ddebug_dyndbg_module_param_cb(param, val, modname)
>>     }
>>     pr_warn("dyndbg param is supported only in ...");
>>     return 0; /* allow and ignore */
>>   }
>>
>>   pr_warn("%s: unknown parameter '%s' ignored\n", modname, param);
>>   return 0;
>>
>> That makes it simpler to add more magic/generic module parameters in
>> unknown_module_param_cb(). No need for a static inline stub, and no need
>> for conditionally declaring ddebug_dyndbg_module_param_cb(). So all that
>> is needed in dynamic_debug.h is to remove the static inline definition,
>> and pull the declaration outside #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
>> protection.
> 
> I do not have strong opinion here. The advantage of the current code
> is that it keeps the complexity in dynamic_debug code.

No, not really, anything in dynamic_debug.h is part of every TU that
includes that header, even if the static inline is only used by one of
them. And since the module code anyway needs to have some knowledge of
dyndbg, I don't see why we can't move the meat of that static inline
into module.c.

> Adding Jessica into CC to know her preferences.
> 
> 
>> What's with the strstr, btw? Shouldn't it just be !strcmp()?
> 
> "dyndbg" parameter might be used as <module>.dyndbg[="val"].

No, not if I'm reading the code and the old commit logs right. For a
built-in module, that thing gets handled by
ddebug_dyndbg_boot_param_cb(), just as the comment in
ddebug_dyndbg_param_cb() says.

But in the call from ddebug_dyndbg_module_param_cb(), param is expected
to be the plain parameter name; it is (userspace) modprobe which parses
/proc/cmdline for any occurrence of <module>.foo=bar and passes that on,
in the format foo=bar, along with any other module parameters given
explicitly in the modprobe call. So if I'm reading the code right, a
CONFIG_DYNAMIC_DEBUG=n kernel would print the "dyndbg param is supported
only in ..." warning if one loads a module and gives a
HALLEdyndbgLUJA=123 parameter.

Rasmus
