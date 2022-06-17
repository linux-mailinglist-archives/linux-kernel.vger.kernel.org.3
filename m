Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54B54F1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380559AbiFQHQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380558AbiFQHP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:15:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8581A13DEC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:15:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r24so3830881ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nCXTiSXIa6VZd+sgUkAbHZ+KTe0Z37C/bputo1uDhXI=;
        b=BAArAmCenEHg6LD90XC12T8L2DajyIDpwPTMkGTA1PxVXkX55YokJR8h4IVTzob3Gi
         nXJAJcuvCykMvUrMbYOSAORrk+TD4Yrs1jrGexsUR+cJiY1Uacgu3kJTQ3yX/bbt+Z2r
         cEucls6ZPewssAVvR8C81iH/kOqku4Fyss7Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nCXTiSXIa6VZd+sgUkAbHZ+KTe0Z37C/bputo1uDhXI=;
        b=6D8nqCrtIIH4bdezPM2D2m2E9T9FJYbrbnt61Mb/RESLLYvfxOQ69pmd+Zu+4J/lWJ
         Mdy7LHtIXEbC/V2mLbKZoxVtoex/pYRtqm6ItwzAMEPOmf6ySE7yu+qcXPkiC46R8tkq
         doo5mxNS6sGvZdLvZXy9MjR9U9isyyftDSjR03ZI9N44mll1yvjE7HF8Tnbv/pSol2Mg
         kHNM/pnhoUZzGfnJP8XbdPnUUI1+LwMfk5d9EfI5yXkiUWW87Yx2y+G1QrTz05zETRr4
         b2X+TM0XRtuqWNSUxLBZuIJ8/0FnuNnyKDYHz1vAmGMUh1nNeBh5/gZRn05Lubx9KTBN
         ZFgw==
X-Gm-Message-State: AJIora+AhYAW5Uv95u/QXxFpcEgXUdO5XJZvMTvoUGd7eN3MD+hi6l52
        E0sTcKCw/VT4bI5qk/t8ylWlhStxjs9A1gw7
X-Google-Smtp-Source: AGRyM1sfSqFa7LRrxVhIQobqHlZS8rNikbm1y7T3Fg6d5VUiCPfGy4SG5EsY2q52tIBRh3gONpP3TA==
X-Received: by 2002:a2e:bf1c:0:b0:259:f33:a4db with SMTP id c28-20020a2ebf1c000000b002590f33a4dbmr4180159ljr.454.1655450155437;
        Fri, 17 Jun 2022 00:15:55 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l1-20020a194941000000b0047255d21205sm528170lfj.308.2022.06.17.00.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:15:54 -0700 (PDT)
Message-ID: <d0798b26-9c77-7209-8c16-0d067ea5720c@rasmusvillemoes.dk>
Date:   Fri, 17 Jun 2022 09:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFCv4 3/4] lib/test_printf.c: split write-beyond-buffer
 check in two
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, Jia He <justin.he@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-4-justin.he@arm.com> <YMtZcVy4gvmMtYv+@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YMtZcVy4gvmMtYv+@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 16.17, Petr Mladek wrote:
> On Tue 2021-06-15 23:49:51, Jia He wrote:
>> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>
>> Before each invocation of vsnprintf(), do_test() memsets the entire
>> allocated buffer to a sentinel value. That buffer includes leading and
>> trailing padding which is never included in the buffer area handed to
>> vsnprintf (spaces merely for clarity):
>>
>>   pad  test_buffer      pad
>>   **** **************** ****
>>
>> Then vsnprintf() is invoked with a bufsize argument <=
>> BUF_SIZE. Suppose bufsize=10, then we'd have e.g.
>>
>>  |pad |   test_buffer    |pad |
>>   **** pizza0 **** ****** ****
>>  A    B      C    D           E
>>
>> where vsnprintf() was given the area from B to D.
>>
>> It is obviously a bug for vsnprintf to touch anything between A and B
>> or between D and E. The former is checked for as one would expect. But
>> for the latter, we are actually a little stricter in that we check the
>> area between C and E.
>>
>> Split that check in two, providing a clearer error message in case it
>> was a genuine buffer overrun and not merely a write within the
>> provided buffer, but after the end of the generated string.
>>
>> So far, no part of the vsnprintf() implementation has had any use for
>> using the whole buffer as scratch space, but it's not unreasonable to
>> allow that, as long as the result is properly nul-terminated and the
>> return value is the right one. However, it is somewhat unusual, and
>> most %<something> won't need this, so keep the [C,D] check, but make
>> it easy for a later patch to make that part opt-out for certain tests.
> 
> Excellent commit message.
> 
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Tested-by: Jia He <justin.he@arm.com>
>> Signed-off-by: Jia He <justin.he@arm.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Hi Petr

It seems Justin's series got stalled, but I still think this patch makes
sense on its own (especially since another series in flight mucks about
in this area), so can you please pick it up directly?

The lore link for the above is
https://lore.kernel.org/lkml/20210615154952.2744-4-justin.he@arm.com/ ,
while my original submission is at
https://lore.kernel.org/lkml/20210615085044.1923788-1-linux@rasmusvillemoes.dk/
.

Rasmus
