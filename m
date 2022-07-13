Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D75733AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiGMKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiGMKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:02:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A6F5108
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:02:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y11so11706054lfs.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=FcdZtxlfGHBvxGWnTjaxeALMraCtTgZBf+0Hn+oyr0g=;
        b=lodQZaMJNoMosnJp42At8SzsOtgrrUlTOd8JN7tdVpOBYvXaSYY78W+ln7IEr6UDWd
         eLCDXxnebWeP699RvQlkzrcr4Wus+5VDDYUxuxRhBrFY4j6+OVzwxct5sa9a4+N092ku
         TyV5AN5hmk+QplcVcLSfsuZmWbg2CTR/TJ79mOTkF5juXA1aP70h88cPhB2sCLAXiF38
         5GEnOLtj2wnjSm6kMloeqbFim0OVVwkmg15pjHvcE6Yul+SUo9P7ON8pIsPI1jy9QDpL
         IEqfB7nJjDy/r0zseZ5yl5RN9DtDWvM5eT+HCSDNBKrAX81WLWUSXaEbxCwAzEjg6i9I
         H0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=FcdZtxlfGHBvxGWnTjaxeALMraCtTgZBf+0Hn+oyr0g=;
        b=fACfjyrxueN7jKeodb3KMBLEwQqXhyDp/6o1A0/i9gNUncg2qQ9PunPhsy+VolTdq8
         Q5Faon/O+NINunVoRIkrqCubvqbmK3tcuCuzT+NfyWcA0Cd6e8Pbka7G0aRoR1R0ofa5
         bD5T/F343m402X9rh4224ZJQfK4OLRVIfLRRqJII9Bao2xHzCXfda5rGOGU2MJsDSM7M
         ceIOVoUvAnIcYgbLBH5KWbpf8v2NkOomzvYoiFOnypalyl9mUJEfNr7JAkiBEZE4+28A
         snzHHaP5HKJOh8hSSL89xvtRrqdUOJdNSM5QQGUxghCZagsWDakxRoh4ad/meYpgGCAC
         qsjg==
X-Gm-Message-State: AJIora/ixKicRg01X+B5DwoHrdQ0QqbjCHMI5yEgTf0xi1IniwSciNOW
        zNveJ/gCUn2BXOLqw78X0B8=
X-Google-Smtp-Source: AGRyM1sWwi9TMsCvKkJm95EXKR9I4T/O9hHNhU5AjMUb26SZrYxsIyiCuW7ia3MLSecqLZ/ftTfF8A==
X-Received: by 2002:a19:670e:0:b0:489:f69c:3a2d with SMTP id b14-20020a19670e000000b00489f69c3a2dmr1503697lfc.51.1657706568830;
        Wed, 13 Jul 2022 03:02:48 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-32-106-30.ip.moscow.rt.ru. [188.32.106.30])
        by smtp.gmail.com with ESMTPSA id v16-20020a056512349000b00489d1896c06sm2322895lfr.125.2022.07.13.03.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 03:02:48 -0700 (PDT)
Message-ID: <999057a9-d209-323b-90eb-5756b7c0e91e@gmail.com>
Date:   Wed, 13 Jul 2022 13:02:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
Content-Language: en-US
From:   Andrey Semashev <andrey.semashev@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Yu-Jen Chang' <arthurchang09@gmail.com>
Cc:     "andy@kernel.org" <andy@kernel.org>,
        "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com>
 <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
 <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
 <CAD4RrFPfwu4Ascj5tdz8qq2Qgnu5GN2eHjVwMW5AqUa1H7JapA@mail.gmail.com>
 <49a8be9269ee47de9fc2d0d7f09eb0b1@AcuMS.aculab.com>
 <5d14cf64-46b7-dc37-bbb8-dd6be82d06af@gmail.com>
In-Reply-To: <5d14cf64-46b7-dc37-bbb8-dd6be82d06af@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/22 12:49, Andrey Semashev wrote:
> On 7/13/22 12:39, David Laight wrote:
>> From: Yu-Jen Chang
>>> Sent: 12 July 2022 15:59
>> ...
>>>> I think you're missing the point. Loads at unaligned addresses may not
>>>> be allowed by hardware using conventional load instructions or may be
>>>> inefficient. Given that this memchr implementation is used as a fallback
>>>> when no hardware-specific version is available, you should be
>>>> conservative wrt. hardware capabilities and behavior. You should
>>>> probably have a pre-alignment loop.
>>>
>>> Got it. I add  pre-alignment loop. It aligns the address to 8 or 4bytes.
>>
>> That should be predicated on !HAS_EFFICIENT_UNALIGNED_ACCESS.
>>
>> ...
>>>         for (; p <= end - 8; p += 8) {
>>>             val = *(u64*)p ^ mask;
>>>             if ((val + 0xfefefefefefefeffull)
>>> & (~val & 0x8080808080808080ull))
>>>                 break;
>>
>> I would add a couple of comments, like:
>> 	// Convert to check for zero byte.
>> 	// Standard check for a zero byte in a word.
>> (But not the big 4 line explanation you had.
>>
>> It is also worth looking at how that code compiles
>> on 32bit arch that don't have a carry flag.
>> That is everything based on MIPS, including riscv.
> 
> It may be worth looking at how glibc does it:
> 
> https://sourceware.org/git/?p=glibc.git;a=blob;f=string/memchr.c;h=422bcd0cd646ea46711a57fa3cbdb8a3329fc302;hb=refs/heads/release/2.35/master#l46
> 
> They do use 32-bit words on 32-bit targets and 64-bit on 64-bit ones. I
> think memchr in the kernel should follow this.

Also, if by chance this optimization is aimed for x86-64, it may be
worth adding an arch-specific version that uses ERMS.
