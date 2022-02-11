Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C384B2BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiBKRYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:24:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiBKRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:24:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8DCDB;
        Fri, 11 Feb 2022 09:24:21 -0800 (PST)
Date:   Fri, 11 Feb 2022 18:24:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644600259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xby/277p0PYtQwCatM3qedV1BJVm17l7RSVzLWxr3g8=;
        b=iUZhNCrzxIYmmcZx0K8FjSwwbpoZejai6BCLy/2SpOPTMwa94R3LPaWhLnFcupF7VJ/9Gm
        YWRNXFytUMDy6PbAe/KxmzmIC3wP2DkO9qMXOWd0k4nT9gWGDBbkvxQyBcv5qvI50zuZJP
        2A+UF3bADn3/W1xw8B2Iz6lKYAtxuSFGp1YqRg6apu4i81LddDV2CHraQbIPoqQCokk5PW
        RSHAz0lJChS75qpyuqjb67BlgUyWkV1EtYw2+HajIPTGJC1M4TsXKOB/504ddWOLWeEZH1
        7KwCN/p0kZuvN7yUnSdnUIkj5kxBVo6Gg0hB6zvKkQI7GxLLyd4ADGO3A8VxVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644600259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xby/277p0PYtQwCatM3qedV1BJVm17l7RSVzLWxr3g8=;
        b=8RccvtE7jG31F556KgNWkhuPwsfJrW1ooMTxsxJeo7LTGuhNSbTebFq8SCXVj40mN6Th+L
        NB4p9sT3h7fl72Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v7] random: defer fast pool mixing to worker
Message-ID: <YgabwjHlVnKBLpwV@linutronix.de>
References: <CAHmME9rC_q4LGq2JaAAeGbtRA2cibTe9bnvhMLng+QnzAy2DVg@mail.gmail.com>
 <20220211170732.571775-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220211170732.571775-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 18:07:32 [+0100], Jason A. Donenfeld wrote:
> On PREEMPT_RT, it's problematic to take spinlocks from hard irq
> handlers. We can fix this by deferring to a workqueue the dumping of
> the fast pool into the input pool.
>=20
> We accomplish this with some careful rules on fast_pool->count:
>=20
>   - When it's incremented to >=3D 64, we schedule the work.
>   - If the top bit is set, we never schedule the work, even if >=3D 64.
>   - The worker is responsible for setting it back to 0 when it's done.
>=20
> There are two small issues around using workqueues for this purpose that
> we work around.
>=20
> The first issue is that mix_interrupt_randomness() might be migrated to
> another CPU during CPU hotplug. This issue is rectified by checking that
> it hasn't been migrated (after disabling irqs). If it has been migrated,
> then we set the count to zero, so that when the CPU comes online again,
> it can requeue the work. As part of this, we switch to using an
> atomic_t, so that the increment in the irq handler doesn't wipe out the
> zeroing if the CPU comes back online while this worker is running.
>=20
> The second issue is that, though relatively minor in effect, we probably
> want to make sure we get a consistent view of the pool onto the stack,
> in case it's interrupted by an irq while reading. To do this, we don't
> reenable irqs until after the copy. There are only 18 instructions
> between the cli and sti, so this is a pretty tiny window.
>=20
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Cc: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> ---
> Sebastian - as requested, we now disable irqs for a very short 18
> instructions rather than fishing into migrate_disable() and upsetting
> PeterZ. Might this be the lucky patch? -Jason

I think we good. I'm not going to comment on the 90 char wide comment :)

Sebastian
