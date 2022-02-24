Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ADA4C2880
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiBXJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiBXJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:49:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA926674C4;
        Thu, 24 Feb 2022 01:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8109BB824F1;
        Thu, 24 Feb 2022 09:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC94EC340E9;
        Thu, 24 Feb 2022 09:49:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Do5PhtlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645696154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIXunQ0/AtwBaCePwIXP2qD27GW0DhIB45r4lJ1eLME=;
        b=Do5PhtlRKqEQujks44fyPi9kMT+LVGhcBDYS7nMxm0pWM2YKsy3UctvgLTxSBAs94u154k
        zj4iVzAyit10EWasQ5hm37bXPFfgA9aCTQb/WQezWlw8sIeBg13M2C4TgC0Rg1dVsVEYYf
        32kCAjFYJOtPYj1lA7e2Z8egCOsqnTM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 053d5ec8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Feb 2022 09:49:14 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id p19so2671697ybc.6;
        Thu, 24 Feb 2022 01:49:13 -0800 (PST)
X-Gm-Message-State: AOAM530J6pHZtn/TBfVROKhHC8op4Ge+TDiXexc9guSuQmQ8oayZJAPu
        TeoMlog/sgCwF2sA3WIsuBlf95UAF6Q5psqMM38=
X-Google-Smtp-Source: ABdhPJyOvLl5VmvQLFSBbWpUhA9AfJiUCFRoxcqCFbKEt2prfsXWWeXkViO9oqn3jcGnknwdnNFU+t+5KOTTYanL6dc=
X-Received: by 2002:a25:238d:0:b0:619:3e19:b06b with SMTP id
 j135-20020a25238d000000b006193e19b06bmr1621006ybj.382.1645696152959; Thu, 24
 Feb 2022 01:49:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:71a8:b0:167:24f9:2d40 with HTTP; Thu, 24 Feb 2022
 01:49:12 -0800 (PST)
In-Reply-To: <Yhc4LwK3biZFIqwQ@owl.dominikbrodowski.net>
References: <20220223185511.628452-1-Jason@zx2c4.com> <Yhc4LwK3biZFIqwQ@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Feb 2022 10:49:12 +0100
X-Gmail-Original-Message-ID: <CAHmME9oesPzz4ofe-wo_ZViM=uahL6WQo8-5ov7xjJN8ui1rsg@mail.gmail.com>
Message-ID: <CAHmME9oesPzz4ofe-wo_ZViM=uahL6WQo8-5ov7xjJN8ui1rsg@mail.gmail.com>
Subject: Re: [PATCH] random: do crng pre-init loading in worker rather than irq
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        bigeasy@linutronix.de, Sultan Alsawaf <sultan@kerneltoast.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> Am Wed, Feb 23, 2022 at 07:55:11PM +0100 schrieb Jason A. Donenfeld:
>> Taking spinlocks from IRQ context is problematic for PREEMPT_RT. That
>> is, in part, why we take trylocks instead. But apparently this still
>> trips up various lock dependency analyzers. That seems like a bug in the
>> analyzers that should be fixed, rather than having to change things
>> here.
>>
>> But maybe there's another reason to change things up: by deferring the
>> crng pre-init loading to the worker, we can use the cryptographic hash
>> function rather than xor, which is perhaps a meaningful difference when
>> considering this data has only been through the relatively weak
>> fast_mix() function.
>>
>> The biggest downside of this approach is that the pre-init loading is
>> now deferred until later, which means things that need random numbers
>> after interrupts are enabled, but before workqueues are running -- or
>> before this particular worker manages to run -- are going to get into
>> trouble. Hopefully in the real world, this window is rather small,
>> especially since this code won't run until 64 interrupts had occurred.
>>
>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> ---
>>  drivers/char/random.c | 62 ++++++++++++-------------------------------
>>  1 file changed, 17 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/char/random.c b/drivers/char/random.c
>> index 536237a0f073..9fb06fc298d3 100644
>> --- a/drivers/char/random.c
>> +++ b/drivers/char/random.c
>> @@ -1298,7 +1278,12 @@ static void mix_interrupt_randomness(struct
>> work_struct *work)
>>  	local_irq_enable();
>>
>>  	mix_pool_bytes(pool, sizeof(pool));
>> -	credit_entropy_bits(1);
>> +
>> +	if (unlikely(crng_init == 0))
>> +		crng_pre_init_inject(pool, sizeof(pool), true);
>> +	else
>> +		credit_entropy_bits(1);
>> +
>>  	memzero_explicit(pool, sizeof(pool));
>>  }
>
> Might it make sense to call crng_pre_init_inject() before mix_pool_bytes?

What exactly is the difference you see mattering in the order? I keep
chasing my tail trying to think about it.

Jason
