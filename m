Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C154C77C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiB1S3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiB1S3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:29:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5ADE6D85;
        Mon, 28 Feb 2022 10:13:04 -0800 (PST)
Date:   Mon, 28 Feb 2022 19:12:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646071959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yu+oKc/jlEU/pryQqAsVcrxYwdQgjNADy+5OiJTkgJA=;
        b=Xrw7w4vAmGFlrfQfFnprBLUlm9gjJPldZC3VSPMenPWNwN+QOgPDlbfw1xCILAV4aOKgCj
        gU+h4pYpcvR2mQ4tS6FDw7EUYkFFRQe/a8Bfu9Mt/52i+6shRHl/ZiJ7zedRxvFBbM8y7+
        mV9P4QSpqgKpmhDFxMcclesrJ7ClvsY6iQFXEv1q9NpdHm1SPUS+8toIsAF+H4dxN9b3Qj
        r5xMkWGEZuSE2j5cbTqPKeD6Pa6CzXF/nhITGiuImi5q1PSKkT+AmIgOEIGj7m/Ud9FZBc
        P92VKlSLAFHvFUR7hA0nXg9ol8xB3HRDVndz4/byWmhVOEgx+r+A6Li+DL50Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646071959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yu+oKc/jlEU/pryQqAsVcrxYwdQgjNADy+5OiJTkgJA=;
        b=ctCnfR1hDdTMQDvfO7wa9Jkz004BwarLRXCcNsl1iIptbF0Yyj3MRvad5/g7RxA3GMMJNQ
        GwlnQFbVuYy/7kAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: RFC: Intervals to schedule the worker for mix_interrupt_randomness().
Message-ID: <Yh0QlQ8aqttjlnKt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

I was debugging my backport and looking for a bug but then I figured out
that everything works as intended.

add_interrupt_randomness() has this piece:
|         if (new_count < 64 && (!time_after(now, fast_pool->last + HZ) ||
|                                unlikely(crng_init =3D=3D 0)))
|                 return;

I was reading this wrong the whole time as in (with context):
   If new_count is greater or equal to 64 and a second passed by
   schedule the worker for mix_interrupt_randomness().

Which means a worker once a second on a CPU or longer intervals if the
CPU is idle. But in reality this is:
   If new_count is greater _or_ equal to 64 or a at least second passed
   by then schedule the worker for mix_interrupt_randomness().

This explains why there are some many worker pending/ running for
mix_interrupt_randomness() in my testing. To give you an example why
this got my attention:

| [   15.763823] random: mix_interrupt_randomness() CPU16, HAZ: 2
| [   15.763823] random: mix_interrupt_randomness() CPU17, HAZ: 2
| [   15.763826] random: mix_interrupt_randomness() CPU07, HAZ: 2
| [   15.763827] random: mix_interrupt_randomness() CPU06, HAZ: 4
| [   15.763827] random: mix_interrupt_randomness() CPU04, HAZ: 2
| [   18.579328] random: mix_interrupt_randomness() CPU18, HAZ: 3
| [   18.579357] random: mix_interrupt_randomness() CPU16, HAZ: 1
| [   18.579358] random: mix_interrupt_randomness() CPU03, HAZ: 2
| [   18.579358] random: mix_interrupt_randomness() CPU17, HAZ: 1
| [   18.579359] random: mix_interrupt_randomness() CPU04, HAZ: 1
| [   18.579360] random: mix_interrupt_randomness() CPU05, HAZ: 1
| [   18.579361] random: mix_interrupt_randomness() CPU06, HAZ: 1
| [   18.579362] random: mix_interrupt_randomness() CPU07, HAZ: 1
| [   20.531244] random: mix_interrupt_randomness() CPU18, HAZ: 2
| [   20.531266] random: mix_interrupt_randomness() CPU16, HAZ: 1
| [   20.531267] random: mix_interrupt_randomness() CPU03, HAZ: 2
| [   20.531267] random: mix_interrupt_randomness() CPU17, HAZ: 1
| [   20.531269] random: mix_interrupt_randomness() CPU04, HAZ: 1
| [   20.531270] random: mix_interrupt_randomness() CPU05, HAZ: 1
| [   20.531270] random: mix_interrupt_randomness() CPU06, HAZ: 1
| [   20.531271] random: mix_interrupt_randomness() CPU07, HAZ: 1
| [   22.515212] random: mix_interrupt_randomness() CPU18, HAZ: 2
| [   22.515240] random: mix_interrupt_randomness() CPU16, HAZ: 2
| [   22.515240] random: mix_interrupt_randomness() CPU17, HAZ: 1
| [   22.515241] random: mix_interrupt_randomness() CPU03, HAZ: 1
| [   22.515242] random: mix_interrupt_randomness() CPU04, HAZ: 1
| [   22.515242] random: mix_interrupt_randomness() CPU05, HAZ: 1
| [   22.515244] random: mix_interrupt_randomness() CPU06, HAZ: 1
| [   22.515244] random: mix_interrupt_randomness() CPU07, HAZ: 1
| [   23.948447] random: mix_interrupt_randomness() CPU18, HAZ: 1
| [   23.948744] random: mix_interrupt_randomness() CPU16, HAZ: 1
| [   24.531151] random: mix_interrupt_randomness() CPU17, HAZ: 1
| [   24.531152] random: mix_interrupt_randomness() CPU03, HAZ: 1
| [   24.531153] random: mix_interrupt_randomness() CPU04, HAZ: 1
| [   24.531153] random: mix_interrupt_randomness() CPU05, HAZ: 1
| [   24.531154] random: mix_interrupt_randomness() CPU06, HAZ: 1
| [   24.531155] random: mix_interrupt_randomness() CPU07, HAZ: 1
| [   25.034401] random: mix_interrupt_randomness() CPU16, HAZ: 2
| [   25.074542] random: mix_interrupt_randomness() CPU18, HAZ: 38
| [   25.566450] random: mix_interrupt_randomness() CPU03, HAZ: 19
| [   25.598532] random: mix_interrupt_randomness() CPU05, HAZ: 15
| [   25.726046] random: mix_interrupt_randomness() CPU18, HAZ: 64
| [   25.802257] random: mix_interrupt_randomness() CPU18, HAZ: 64
| [   26.085382] random: mix_interrupt_randomness() CPU18, HAZ: 64

This output comes from the hack at the end of the email (not properly
formatted). Since the box is idle and runs NO_HZ it is possible that a
CPU is idle for a second or longer. If you look at the begin of the
output, CPU16 scheduled the worker for mix_interrupt_randomness() with
fast_pool::count =3D 2. So did CPU 17, 7 and 6. At the end log you see
CPU18 got busy and scheduled the worker more frequently since it
acquired 64 interrupts. This is output includes 10 seconds and CPUs 0
and 1 are not part of the log.

Is this really what we want? With HAZ=3D1 the CPU was woken up from idle
poll routine so the registers should have always the same content since
it is always the same while() routine calling CPU's idle function. At
least get_reg() rotates them but instruction_pointer() would return
always the same value. (Side note: on 64bit the upper 32bit of the IP
register should be all 0xff=E2=80=A6ff for the kernel and 0x00=E2=80=A600 f=
or userland.
So this looks like one bit of entropy. I mention this now because I
noticed that 32bit throws an additional register to the mix to make up
for the small register)).

Wouldn't it make sense entropy wise to gather more entropy (say the 64)
before consuming it? And waiting at least a second if more entropy was
created?

With CONFIG_PERIODIC you have at least CONFIG_HZ interrupts on each CPU.
"At least" because you have the timer tick interrupt and you may have
additional interrupt for your device interrupts.  With HZ=3D1000 you have
1000 timer tick interrupts.
That is the one extreme. The other is NO_HZ and an idle box. [ Now that
I look around it appears that risc-v has no get_irq_regs() and
random_get_entropy() may return 0. Spooky. ]

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1254,6 +1254,7 @@ static unsigned long get_reg(struct fast_pool *f, str=
uct pt_regs *regs)
        return *ptr;
 }
=20
+enum { MIX_INFLIGHT =3D 1U << 31 };
 static void mix_interrupt_randomness(struct work_struct *work)
 {
        struct fast_pool *fast_pool =3D container_of(work, struct fast_pool=
, mix);
@@ -1271,6 +1272,9 @@ static void mix_interrupt_randomness(struct work_stru=
ct *work)
         * consistent view, before we reenable irqs again.
         */
        memcpy(pool, fast_pool->pool32, sizeof(pool));
+       pr_err("%s() CPU%02d, HAZ: %d\n", __func__, smp_processor_id(),
+              READ_ONCE(fast_pool->count) & ~MIX_INFLIGHT);
+       WARN_ON((READ_ONCE(fast_pool->count) & MIX_INFLIGHT) =3D=3D 0);
        fast_pool->count =3D 0;
        fast_pool->last =3D jiffies;
        local_irq_enable();
@@ -1288,7 +1292,6 @@ static void mix_interrupt_randomness(struct work_stru=
ct *work)
=20
 void add_interrupt_randomness(int irq)
 {
-       enum { MIX_INFLIGHT =3D 1U << 31 };
        cycles_t cycles =3D random_get_entropy();
        unsigned long now =3D jiffies;
        struct fast_pool *fast_pool =3D this_cpu_ptr(&irq_randomness);

Sebastian
