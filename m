Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76958003D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiGYNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGYNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:55:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381139583
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:55:23 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658757321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IUnC4wIOdfPRZ/lPTRoy99qEexu5zzUe3TeYAREMMks=;
        b=3nmCFGO/ohpNVKHsyw2Bm+XssmtkytXOEdQ42VKo8qBaSxFcmSZQ6/5zBJ/zKzzker9Z1b
        ehRrTYtzeroOGKRoZVGMWN9HXYpRsV8cz1FULZDZajQrku/2ngRhRbjfPvdlZn8cuouOuu
        kkdTpzGRPxI4J1pN3zOpgzIFhL+GGWXEWk8qrkj7VK5QXZr2A9OkEM1vHKmbJtCrNsnxaa
        XrBSDSa0Ar+MjgsqBNREuSyFgEZba0BnrIXZ8dpCax5JaKPo71WrjZQ7FDHgdNbUB/Ki7e
        E+468jDOanLaKqhHdxWGGgiEk06Q2dXg5vsn6gjcYEqDngkiS1h4NSKKO3c1Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658757321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IUnC4wIOdfPRZ/lPTRoy99qEexu5zzUe3TeYAREMMks=;
        b=BL0zBAAr6s7fgqxckylGJHf+4tMmkEkli9zXFvcSh6SuMxCa48+49r/65HlMrbgoozvFcu
        WEAttLhib1q9TiCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] printk: Skip console drivers on PREEMPT_RT.
Message-ID: <Yt6gxxRxDZ/wFHrA@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de>
 <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de>
 <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley>
 <YtrYdXWGb0NQLKNA@linutronix.de>
 <Yt6MzEEFfpyTBIIj@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yt6MzEEFfpyTBIIj@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-25 14:30:04 [+0200], Petr Mladek wrote:
> This is what I have missed. It might be obvious for people living by RT
> kernel. But spinlocks do not sleep in normal kernel. So I did not get
> that the spinlocks are the culprit. Please, make it more obvious
> in the commit message, for example:
>=20
> --- cut ---
> Console drivers use spinlocks that might sleep in PREEMPT_RT. As a
> result they must not be called with interrupts enabled...
> --- cut ---

It is not only the sleeping lock by itself but also the fact that
polling on 115200 or 9600 to print a line is simply takes too much time.
Even if the line consists of four letters.

> > > > Disable console printing until the return of atomic consoles and the
> > > > printing thread. This allows to retrieve the log buffer from user s=
pace
> > > > which is not possible by disable printk.
> > >=20
> > > I guess that this is for RT tree because the kthreads and the atomic
> > > consoles are still not in the mainline.
> >=20
> > I would like to have this applied to the v5.20 upstream tree and then
> > revoked once the missing bits have been  merged. Based on what I see,
> > there shouldn't be any road blocks.
>=20
> Huh, I do not think that it is a good idea. There are neither atomic
> consoles nor printk kthreads in upstream. The patch effectively
> completely disables the consoles in PREEMPT_RT. All consoles
> will be _empty all the time_.

I am aware of that, I tested that patch (as in I didn't just send it).
This is what I see on bare metal's UART:

|  Booting `Debian GNU/Linux'
|
| Loading Linux RT ...
| Loading initial ramdisk ...
| No EFI environment detected.
| early console in extract_kernel
| input_data: 0x00000000031d12e0
| input_len: 0x0000000000c283e1
| output: 0x0000000001000000
| output_len: 0x00000000025f49f8
| kernel_total_size: 0x0000000002e26000
| needed_size: 0x0000000003000000
| trampoline_32bit: 0x0000000000099000
|=20
| Decompressing Linux... Parsing ELF... done.
| Booting the kernel.
| Loading, please wait...
| Starting version 251.3-1
| Begin: Loading essential drivers ... done.
=E2=80=A6

and this is okay for me at this point. This means that v5.20 could have
RT enabled for x86 and people can start test it without additional
patches. They can enable it and if it boots they can check dmesg's
output for anything odd. If it doesn't boot they can either wait for the
next release or grab the patchset with the missing bits for debugging.
This is way better than letting printk depend on !RT which would provide
no insight at all. The RT option is still hidden behind EXPERT.

> Also the consoles were never tested with interrupts enabled. I am
> pretty sure that interrupts has to be disabled in some locations,
> for example, when sending some data sequences on the ports. Are we
> sure that they are always explicitly disabled inside the drivers?

The 8250 did disable interrupts via local_irq_disable() and this is not
desired on RT since it *really* disables interrupts. This was long ago
addressed in commit
   ebade5e833eda ("serial: 8250: Clean up the locking for -rt")

The interrupts are enabled in general on RT and they have to. I did not
remove this pattern (local_irq_disable() + try_lock()) from all console
drivers because five years ago we were talking about explicit entry
points for magic-sysrq and oops_in_progress and I didn't want to patch
around until it is done. I don't know what John's plans here are but I
did mention this to him a while ago.
A few other (ARM related drivers) are patched as part of the RT queue.

> This is one reason why we reverted the console kthreads in 5.19-rc4.
> AFAIK, John is doing some inspection of all drivers.

The console drivers (or drivers in general) never *really* disable
interrupts on RT via spin_lock_irq*() and this is intended.=20

> That said, I am going to leave the decision on John. I am not sure
> what are the expectations of RT users in mainline.
>
> From my point, this patch does not make much sense. IMHO, it will
> not make mainline usable with PREEMPT_RT. Any serious RT user will
> need to revert it and apply a better printk solution from
> the out-of-tree RT patchset.

The lack of the console probably makes RT not production ready as of
v5.20 but I was debugging systems without a UART so.
It might not be production ready without a console. Also ARM and PowerPC
can not be enabled so there will be a queue for a while unless people
device that they don't care about what is left. However it will
hopefully will attract x86 people to give it a spin. Then we may receive
bug reports and or patches which we did not before and so get better.

> Best Regards,
> Petr

Sebastian
