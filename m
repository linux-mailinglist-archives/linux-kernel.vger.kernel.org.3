Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557CA4A7BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiBBXdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348078AbiBBXdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:33:15 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B966C061714;
        Wed,  2 Feb 2022 15:33:15 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso980169ott.7;
        Wed, 02 Feb 2022 15:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/6Cf3W9mkudiHFUznEhVCKbOqbQxkWdOxnCU/ygpF28=;
        b=TWaEs79JtjrcHTSbcrAqPmFzFOOWnARfpwzPp2C5rcZCCDU3n1/MaPIHrcmUI9y0gb
         3BMP1lLY574eEgpFQrd8i6DEYYdh5A+AW2XUqCH/IHsnGbFbW8OGQMXStI2OSSEeNtnC
         2uDg2DUSa7Lho9RKJhIrCDYX76O78hlROcVy4v6YUKMMtvpNwh2nLT30uHlYJiRH7AzS
         Renh+llJVBBHKSdqelhdavlknNKWPUPZLkmbX5olI92+ek1EnkuVf3RW/4z4TmwshOJX
         1rUWCsOpUjvI5UjKeKR2QmD1I/U3iw93wQm3B950LOMR3jSQXL17hZURwqicshn6WFkY
         PjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/6Cf3W9mkudiHFUznEhVCKbOqbQxkWdOxnCU/ygpF28=;
        b=kuTFmWhyRy+AK/EKS+dKtRdSYYX+6hBBHgWbdDses5jlRpoRJ6QhzVO0uwUGW2g2bC
         am7e1tIHnq7h+kbh0+CGjBnZTxjEu6xB+74RlfTzOjwPP6+S3+eCyfKicCwaJ5AbnYDE
         AprA1cy7+g+pJ+0oHAfTRxWZjMsdPnU9MEK3UPZilXTv4RkiS+w4C11ljDu2RKqK9OgG
         VYfCarjex1o5osY9AEguvYNWkZYhByCyuBhrZVtg+L3UaCO5sXPlKgQvK3nNOttcEdeK
         oaaGAJsf3Vq0Q/ufme6ZAXL4Dlt1+Fz4DDIF7gm676kpVp+4vQPVe8Jh9bre30CedtX5
         TsPg==
X-Gm-Message-State: AOAM531S3lXmMyUwAAflJXwHMpkxNumAznRtXDcWdg+dLtu1LcFfq7gq
        76n722Jd+JXjagARu/4MLt8=
X-Google-Smtp-Source: ABdhPJxOgmXoa6PCzUc7JfZNj++eKlj2RApzxbX5R+TNdRwnor8TLrUrfkCNVsoYb2zA/cflqexsBA==
X-Received: by 2002:a9d:1f0:: with SMTP id e103mr14998061ote.234.1643844794500;
        Wed, 02 Feb 2022 15:33:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y4sm19010868otj.22.2022.02.02.15.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 15:33:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cbf0cf07-2350-ed23-f6be-b2686c6a0cea@roeck-us.net>
Date:   Wed, 2 Feb 2022 15:33:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] Makefile: Enable -Warray-bounds
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
References: <20210818081118.1667663-1-keescook@chromium.org>
 <20210818081118.1667663-5-keescook@chromium.org>
 <20220202160903.GA2337834@roeck-us.net> <202202021254.5A1FD4FFBF@keescook>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <202202021254.5A1FD4FFBF@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 12:56, Kees Cook wrote:
> On Wed, Feb 02, 2022 at 08:09:03AM -0800, Guenter Roeck wrote:
>> On Wed, Aug 18, 2021 at 01:11:17AM -0700, Kees Cook wrote:
>>> With the recent fixes for flexible arrays and expanded FORTIFY_SOURCE
>>> coverage, it is now possible to enable -Warray-bounds. Since both
>>> GCC and Clang include -Warray-bounds in -Wall, we just need to stop
>>> disabling it.
>>>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>>> Cc: linux-kbuild@vger.kernel.org
>>> Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>   Makefile | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index a4aca01a4835..af22b83cede7 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1072,7 +1072,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
>>>   
>>>   # We'll want to enable this eventually, but it's not going away for 5.7 at least
>>>   KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
>>> -KBUILD_CFLAGS += -Wno-array-bounds
>>>   KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
>>>   
>>>   # Another good warning that we'll want to enable eventually
>>
>> alpha:defconfig:
>>
>> In function '__memset',
>>      inlined from '__bad_pagetable' at arch/alpha/mm/init.c:79:2:
>> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>>     37 |                         return __builtin_memset(s, c, n);
>>        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
>> In function '__memset',
>>      inlined from '__bad_page' at arch/alpha/mm/init.c:86:2:
>> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>>     37 |                         return __builtin_memset(s, c, n);
>>        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
>> In function '__memset',
>>      inlined from 'paging_init' at arch/alpha/mm/init.c:256:2:
>> ./arch/alpha/include/asm/string.h:37:32: error: '__builtin_memset' offset [0, 8191] is out of the bounds [0, 0] [-Werror=array-bounds]
>>     37 |                         return __builtin_memset(s, c, n);
> 
> Thanks! I'll take a look. Every instance of the "[0, 0]" bounds means
> the compiler believes there's a way for the destination to be determined
> at compile-time to be NULL.
> 
>> xtensa:allmodconfig:
>> --------------
>> Error log:
>> In file included from include/linux/uaccess.h:11,
>>                   from include/linux/sched/task.h:11,
>>                   from arch/xtensa/kernel/process.c:21:
>> arch/xtensa/kernel/process.c: In function 'copy_thread':
>> arch/xtensa/kernel/process.c:262:52: error: array subscript 53 is above array bounds of 'long unsigned int[16]'
> 
> I assume this is a weird cast. I will also check this one out.
> 

                                 int callinc = (regs->areg[0] >> 30) & 3;
                                 int caller_ars = XCHAL_NUM_AREGS - callinc * 4;
                                 put_user(regs->areg[caller_ars+1],
                                          ^^^^^^^^^^^^^^^^^^^^^^^^
                                          (unsigned __user*)(usp - 12));

I think the problem is that XCHAL_NUM_AREGS can be up to 64,
but the size of struct pt_regs->areg[] is fixed to 16.

Guenter
