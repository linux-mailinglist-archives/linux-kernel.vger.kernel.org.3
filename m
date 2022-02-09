Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91664AE621
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbiBIAhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIAhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:37:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27DC06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82CD2B81DBE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CEEC340E9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:36:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AyxGI2l0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644367015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZACSMpl1R+fey5auuBGB86zvtMqpo3Qv71y35Y0OdEY=;
        b=AyxGI2l04YZwx0CT9m0AUAeZKfDmMCtdzJWU+TFBTSWlnp0UA2/L3DgZA19+40xoYfX6Q5
        FZjmHmHYWefydlLq0C9JFpOG8PNhIj1rMf4hUNAH3wR/46kk7pDV+EafavIoqoVj9U7nZJ
        7VSWaEReQYfr1nAu6pmv2FETvIw39D8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8b3d8c7c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 9 Feb 2022 00:36:54 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id 192so1365295ybd.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 16:36:54 -0800 (PST)
X-Gm-Message-State: AOAM533Iihu8Jst7qTv7UOwR5J9TgV1AnJdbkWzJ8f1d8TfYEfDjQHLW
        DzKqVOPTrOJm5b7EK6UjITp2PmVgYZHSn9Q/WzU=
X-Google-Smtp-Source: ABdhPJxk4yNOMn7oqut+HdlxvsEYKCTUoRYH8/qd28ICc8B1M1EmRfBXEvR0KroTvWE4N/js52ySj6vGnbrtQhj69vs=
X-Received: by 2002:a81:3283:: with SMTP id y125mr7710993ywy.100.1644367013132;
 Tue, 08 Feb 2022 16:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20220207153914.365931-1-Jason@zx2c4.com> <20220207153914.365931-3-Jason@zx2c4.com>
 <YgMG7niyv2+zzSWf@sol.localdomain>
In-Reply-To: <YgMG7niyv2+zzSWf@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 9 Feb 2022 01:36:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9rNv78wKvTNEvKVoC_CcxtVJdDU0cJvxjTYans1eugZqw@mail.gmail.com>
Message-ID: <CAHmME9rNv78wKvTNEvKVoC_CcxtVJdDU0cJvxjTYans1eugZqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] random: defer fast pool mixing to worker
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
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

Hi Eric,

On Wed, Feb 9, 2022 at 1:12 AM Eric Biggers <ebiggers@kernel.org> wrote:
> So, add_interrupt_randomness() can execute on the same CPU re-entrantly at any
> time this is executing?  That could result in some pretty weird behavior, where
> the pool gets changed half-way through being used, so what is used is neither
> the old nor the new state of the pool.  Is there a reason why this is okay?

Yes, right, that's the "idea" of this patch, if you could call it such
a thing. The argument is that we set fast_pool->count to zero *after*
mixing in the existing bytes + whatever partial bytes might be mixed
in on an interrupt halfway through the execution of mix_pool_bytes.
Since we set the count to zero after, it means we do not give any
credit to those partial bytes for the following set of 64 interrupts.
What winds up being mixed in will contain at least as much as what was
there had it not been interrupted. And what gets mixed in the next
time will only have more mixed in than it otherwise would have, not
less.

> Is there a reason why the FAST_POOL_MIX_INFLIGHT is part of 'count' instead of a
> separate boolean?

So that we can clear it with a single WRITE_ONCE, and to save space in
the per-cpu crng.

> Also, a high level question.  Now that the call to mix_pool_bytes() would no
> longer occur in hard IRQ context, how much reason is there to minimize the
> amount of data passed to it?  Would it be feasible to just concatenate the
> interrupt data into an array, and pass the whole array to mix_pool_bytes() --
> eliminating the homebrew ARX thing entirely?

Indeed I'm working on replacing fast_mix() with something we can
actually reason about. I thought about a big array but I'm not quite
convinced that the memory overhead of this would be worth it. Right
now, each interrupt generates 16 bytes of data, and we ingest that
data after 64ish interrupts -- but sometimes more (and sometimes
less). So that's a whole kilobyte in the best case. That's not /tons/
but it's not nothing either. So while the big array idea is one
possibility, it's not the only one I'm evaluating. Hopefully in the
coming weeks I'll have some ideas ready to discuss on that.

Jason
