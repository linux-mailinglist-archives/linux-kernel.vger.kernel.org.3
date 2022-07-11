Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF857067F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiGKPBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGKPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:00:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A9747A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:00:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u14so6537911ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YqYSis0dzps0Hu3sEYU7x6EiSn+FFHsjpFPSSZoDxpQ=;
        b=ZQA4SgK1uR/bFkzOiDKAMrTDxrtQifItmGEnWg6uUFsapghbuGHuyaqeAmYGh5nqS4
         C+Kn1QjmPNIeGN/kPPHKJ2gUB8xrc8ocaqGlRhLoYPU8Jst3efONbf0xNlfAbIW7gy13
         2+6IZieXkiBfQ3FMFX0BD60BdZShKFWN2lfoFC2r3r7cXAjc9j3zshluY6vg4TSrUIqC
         2z8mSgq/2yA8kphbzuVwBLBZeGibFSZ0R/KluieN23w/4lwib753HL5jPhP1YPDz8XjJ
         00S67/iqtC9Wy6vVedchzGhUzGJjFBGt9sI65LESYSqQA1Ru1Axsa2bDFIs9PzNnrEGl
         YqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YqYSis0dzps0Hu3sEYU7x6EiSn+FFHsjpFPSSZoDxpQ=;
        b=yrudnU8f26fSlOSrrCz019VBOMFXGXMGBWtWYqQ02iY+6vdjNPIdCXS0wsf74c55qr
         KEMyqLi5QiQQgNdL9yXiYHWqPE3n8kVwfq4l7fdgSQqyUK6cFLn4jTPLOM8WmzgEknBC
         CVCPYQBmaWeIhFZjsf8rnv83Nm2dQctmqx+15k1GbslxXrfeAkdQNOW1AfUdq25s5aOc
         ugWo5u6WJIX/DBE9tbD8byYWFu5Nc3uuOgm6N8eM4gG71OISNuh29+fBIGVcvQPFcNDJ
         CAy68X9Nq5lYLf52VEuDErJFvUbULC5FFE2KJNzApzUHE1TXVQCdR2wHRD36UIgeRqHC
         I0BQ==
X-Gm-Message-State: AJIora9ixDDIco6cWrOelccwWCoqmPX+nypVIopOyPWcWXQmpxzz+NTj
        +Cid/1MpNgQsJLnjDqndhwo=
X-Google-Smtp-Source: AGRyM1v9BaQF8wSojXxoljdxFeMK8gBv0mEmiOGCFOc6oCjhrMELxdYr9icuTuYhpuJjyKdBgULoVQ==
X-Received: by 2002:a2e:3015:0:b0:25d:51a1:25ea with SMTP id w21-20020a2e3015000000b0025d51a125eamr10426899ljw.320.1657551628596;
        Mon, 11 Jul 2022 08:00:28 -0700 (PDT)
Received: from [192.168.1.4] (broadband-188-32-106-30.ip.moscow.rt.ru. [188.32.106.30])
        by smtp.gmail.com with ESMTPSA id q5-20020a2e5c05000000b0025d67ee6eafsm1260147ljb.130.2022.07.11.08.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 08:00:28 -0700 (PDT)
Message-ID: <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
Date:   Mon, 11 Jul 2022 18:00:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
Content-Language: en-US
To:     Yu-Jen Chang <arthurchang09@gmail.com>
Cc:     andy@kernel.org, akinobu.mita@gmail.com,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        linux-kernel@vger.kernel.org
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com>
 <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
In-Reply-To: <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 17:52, Yu-Jen Chang wrote:
> Andrey Semashev <andrey.semashev@gmail.com> 於 2022年7月11日 週一 凌晨4:01寫道：
>>
>> On 7/10/22 17:28, Yu-Jen Chang wrote:
>>> The original version of memchr() is implemented with the byte-wise
>>> comparing technique, which does not fully use 64-bits or 32-bits
>>> registers in CPU. We use word-wide comparing so that 8 characters
>>> can be compared at the same time on CPU. This code is base on
>>> David Laight's implementation.
>>>
>>> We create two files to measure the performance. The first file
>>> contains on average 10 characters ahead the target character.
>>> The second file contains at least 1000 characters ahead the
>>> target character. Our implementation of “memchr()” is slightly
>>> better in the first test and nearly 4x faster than the orginal
>>> implementation in the second test.
>>>
>>> Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
>>> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
>>> ---
>>>  lib/string.c | 28 +++++++++++++++++++++-------
>>>  1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/lib/string.c b/lib/string.c
>>> index 80469e6c3..8ca965431 100644
>>> --- a/lib/string.c
>>> +++ b/lib/string.c
>>> @@ -905,21 +905,35 @@ EXPORT_SYMBOL(strnstr);
>>>  #ifndef __HAVE_ARCH_MEMCHR
>>>  /**
>>>   * memchr - Find a character in an area of memory.
>>> - * @s: The memory area
>>> + * @p: The memory area
>>>   * @c: The byte to search for
>>> - * @n: The size of the area.
>>> + * @length: The size of the area.
>>>   *
>>>   * returns the address of the first occurrence of @c, or %NULL
>>>   * if @c is not found
>>>   */
>>> -void *memchr(const void *s, int c, size_t n)
>>> +void *memchr(const void *p, int c, unsigned long length)

I didn't comment on this initially, but is the change of length type
intentional? Why?

>>>  {
>>> -     const unsigned char *p = s;
>>> -     while (n-- != 0) {
>>> -             if ((unsigned char)c == *p++) {
>>> -                     return (void *)(p - 1);
>>> +     u64 mask, val;
>>> +     const void *end = p + length;
>>> +
>>> +     c &= 0xff;
>>> +     if (p <= end - 8) {
>>> +             mask = c;
>>> +             MEMCHR_MASK_GEN(mask);
>>> +
>>> +             for (; p <= end - 8; p += 8) {
>>> +                     val = *(u64 *)p ^ mask;
>>
>> What if p is not aligned to 8 (or 4 on 32-bit targets) bytes? Not all
>> targets support (efficient) unaligned loads, do they?
> 
> I think it works if p is not aligned to 8 or 4 bytes.
> 
> Let's say the string is 10 bytes. The for loop here will search the first
> 8 bytes. If the target character is in the last 2 bytes, the second for
> loop will find it. It also work like this on 32-bit machine.

I think you're missing the point. Loads at unaligned addresses may not
be allowed by hardware using conventional load instructions or may be
inefficient. Given that this memchr implementation is used as a fallback
when no hardware-specific version is available, you should be
conservative wrt. hardware capabilities and behavior. You should
probably have a pre-alignment loop.

>>
>>> +                     if ((val + 0xfefefefefefefeffu) &
>>> +                         (~val & 0x8080808080808080u))
>>> +                             break;
>>>               }
>>>       }
>>> +
>>> +     for (; p < end; p++)
>>> +             if (*(unsigned char *)p == c)
>>> +                     return (void *)p;
>>> +
>>>       return NULL;
>>>  }
>>>  EXPORT_SYMBOL(memchr);
>>

