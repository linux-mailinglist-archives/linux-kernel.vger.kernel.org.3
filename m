Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FCE54D114
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349308AbiFOSog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOSoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:44:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D6C340F4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:44:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id p63so9391276qkd.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F+DGM8o8Zn45hSbzSY35HzK/vbjQGnTANH1Bt8EkX5w=;
        b=JEZN7GvNEzufQhnj5M+09pKzIE1oQV4hsoD9Q8IZAl54fxgEVjh1hp0CfGrjF3DVR3
         8kqcANUupPT/K9orIaIv8uo6J4MqQairMRK1KNpeNik7if/ULSDeW2Fir8lhPWA2Zqli
         Lce3nMmDV+cng9OOHfrObILhRAE6H21/hHx0R90Kr3ibi+v340MK1A9HXFM9XzKnH8lW
         lURmYabQWMg707cDfSjfMuw7WeWDYFyLJ3jUGhlr0l5sPNj3xtqCB/8jW6a57VjlxMm9
         mOBA/vI+9iKIGbJfSJroSixFrV5PRm8wDHAfZYn+AKHibVyz3MZ1uqhdRZ7jadRSy2TI
         YztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F+DGM8o8Zn45hSbzSY35HzK/vbjQGnTANH1Bt8EkX5w=;
        b=lxYngk5VBQIyVXPsuB66nwpUfBtPYiC6Wpd0kE8nQYI8A8TQIP7PU0wLNYvcnNoLyF
         q2QHp9VlJdLQ84hmCThiSkLQ7O9QZI4jDpds37+rUdbSj8L0kNd5DiJeWzc8IBJyKuM5
         H76m4w4HHeKgy7ZAm44Jv6dvUmXgoc9T+YE2tcanISHSt3aT9qeThCx3QQwHdvmVKw7m
         zSNRdKazcJ/NjXIJiNoSsyjjfVxsDwaiXxl1Ly7mhTkwIJE24FBU06w3+Uw3P6NlItPM
         5F6EaFpOP7peYdaTtWmiajyC8bSr1kdbgFeSQJYamrBAPsRUOtfsADtAs+IhGj+rlXFS
         +gxg==
X-Gm-Message-State: AJIora/fQx1tHPeDPrcfIC0bp9yfw41hJh6oFc7q1soJeHGkpvJwt7J8
        9jJObr5QjR1K2iRGY1ON8vGPQ2nIsTSH2Ug=
X-Google-Smtp-Source: AGRyM1tH7FIgSf4reVX9Qu761+qXfkvrSe/8PWdSMT/APzVL28xuK/8uWeL5V5DBQ4tXR2wVSPHitg==
X-Received: by 2002:a37:454:0:b0:6a7:7eb1:7c65 with SMTP id 81-20020a370454000000b006a77eb17c65mr899777qke.474.1655318671155;
        Wed, 15 Jun 2022 11:44:31 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a455000b006a6ce613c7csm13676842qkp.89.2022.06.15.11.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 11:44:30 -0700 (PDT)
Message-ID: <ba8d21b8-7aae-6bfb-3553-3baba2bbeee1@gmail.com>
Date:   Wed, 15 Jun 2022 14:44:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 03/33] vsprintf: Convert to printbuf
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Cc:     pmladek@suse.com, rostedt@goodmis.org
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
 <20220604193042.1674951-4-kent.overstreet@gmail.com>
 <bc5daffb-e144-2a43-4657-eaf663e94750@rasmusvillemoes.dk>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <bc5daffb-e144-2a43-4657-eaf663e94750@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 05:09, Rasmus Villemoes wrote:
> On 04/06/2022 21.30, Kent Overstreet wrote:
>> This converts vsnprintf() to printbufs: instead of passing around raw
>> char * pointers for current buf position and end of buf, we have a real
>> type!
>>
>> This makes the calling convention for our existing pretty printers a lot
>> saner and less error prone, plus printbufs add some new helpers that
>> make the code smaller and more readable, with a lot less crazy pointer
>> arithmetic.
>>
>> There are a lot more refactorings to be done: this patch tries to stick
>> to just converting the calling conventions, as that needs to be done all
>> at once in order to avoid introducing a ton of wrappers that will just
>> be deleted.
>>
>> Thankfully we have good unit tests for printf, and they have been run
>> and are all passing with this patch.
> 
> So, as the primary author of those tests, a somewhat active contributor
> to vsprintf.c and being listed as R: for both files, why wasn't I cc'ed
> on this?

Apologies for the oversight.

> Anyway, my main concern with this is that performance goes down the
> drain and the generated code will be awful. Have you done any
> measurements and/or looked at disassembly? Thanks to
> -fno-strict-aliasing (or perhaps just because we're writing through a
> char* pointer which IIRC may alias anything), I think the compiler will
> be forced to reload prt->pos and prt->size over and over and over. I may
> be wrong, of course, that happens often. Perhaps __restrict could help, IDK.

If we care that much about sprintf performance we must have some 
benchmarks somewhere - could you point me at them?


>> ---
>>   include/linux/kernel.h |    4 +
> 
> Please don't expand that dumping ground. Please, if printbufs will
> become a thing (whether or not vsprintf internally will be refactored to
> use them), add a new linux/printf.h where these things can go, and the
> declarations of vsprintf() and close friends can eventually be moved.

kernel.h is indeed a dumping ground that needs to be reorganized, but 
this patch series is about printbufs, not reorganizing header files (and 
my doctor tells me I need to be taking my blood pressure meds more 
regularly before taking something like that on). For now, prt_printf() 
goes with the other printf() functions.
