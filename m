Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707084B27AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350750AbiBKOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:18:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBKOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:18:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD14188;
        Fri, 11 Feb 2022 06:18:24 -0800 (PST)
Date:   Fri, 11 Feb 2022 15:18:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644589101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0cpXkqDGW3JQTmb6djLKzXDglKrwfkZ8bupjlc3z/TQ=;
        b=ax7fuI2IZlUWXX6X3GQhGkOp5AxIei3vjDU5l0iw7Uu1jSRR0GsX7YmTOyDZ8mxqDsRtx6
        AAuwiBpkrtZZuD7olqj5XclYVqaiHCE6qevf3ZRKkgYjK6BrS2o1ml6Dlu8BiSW8YFbd1Y
        ipXOFQF+SYBThdoRMXtVgawRX1Owh6R3wtE2R9AcPnRcX3oATLqPfu6jQyHBSr/B+/vU8k
        j7MBrTP/9Ps8ZOfNOhVG/sOxi9wVpokUUtYtyrKpLnYMY6BEuXVkSX/Ssz+AztkuSVZXNU
        OzrQZVPe/kIwGujtz7WqcPrWm8ykg7LmkLO8Gt95uPztSaonebKOCrT2aJE0xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644589101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0cpXkqDGW3JQTmb6djLKzXDglKrwfkZ8bupjlc3z/TQ=;
        b=09CLKclCQ9Q++DBefs4Ff4baJZD3lSRtcn+qkPYoogjtnnn5ljfzZU8BcL9NT7mQ+/VWNl
        A3ivc2XZK8CoTNAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v4 2/2] random: defer fast pool mixing to worker
Message-ID: <YgZwLM9hhcUHYT0P@linutronix.de>
References: <20220209125644.533876-1-Jason@zx2c4.com>
 <20220209125644.533876-3-Jason@zx2c4.com>
 <YgVTpI/sYLecyWa3@linutronix.de>
 <YgYdXLg4bo6E7Bit@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YgYdXLg4bo6E7Bit@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 09:25:00 [+0100], Dominik Brodowski wrote:
> That's a hw rng (such as a tpm chip or the virtio-rng driver) providing s=
ome
> entropy; if it's 64 bytes of input, crng_init progresses to 1, and
> crng_fast_load() should never be called again.[*] I'm a bit suprised that=
 the
> hw_rng input occurred so early (it's only at device_initcall() level), and
> earlier than 64 interrupts. But that may differ from system to system.
>=20
> Note that crng_fast_load() will also never be called from
> add_interrupt_randomness() if
>=20
> 	EFI, DT or kexec provides bootloader entropy of at least 64 bytes,
> 	and CONFIG_RANDOM_TRUST_BOOTLOADER is set
>=20
> and/or	CONFIG_RANDOM_TRUST_CPU is set and the RDRAND/RDSEED instructions =
do
> 	not fail.
>=20
> If neither of these three conditions (hw_rng is run early, bootloader or =
CPU
> randomness) are met, the initial and early seeding of the base_crng depen=
ds
> on add_interrupt_randomness(), and should happen rather quickly.

Right.

> > I did move that crng_fast_load() into the worker and did made some
> > numbers:
> >            <idle>-0       [000] d..h1..     2.069924: add_interrupt_ran=
domness: Tick
> >=20
> > first interrupt
> > =E2=80=A6
> >         swapper/0-1       [000] d..h.11     2.341938: add_interrupt_ran=
domness: Tick
> >         swapper/0-1       [000] d..h.11     2.341938: add_interrupt_ran=
domness: work
> >=20
> > the 64th interrupt, scheduling the worker.
> >=20
> >         swapper/0-1       [000] d..h.11     2.345937: add_interrupt_ran=
domness: Tick
> >         swapper/0-1       [000] d..h111     2.349938: add_interrupt_ran=
domness: Tick
> >         swapper/0-1       [000] d..h.11     2.353939: add_interrupt_ran=
domness: Tick
> >         swapper/0-1       [000] d..h.11     2.357940: add_interrupt_ran=
domness: Tick
> >         swapper/0-1       [000] d..h111     2.361939: add_interrupt_ran=
domness: Tick
> >         swapper/0-1       [000] d..h111     2.365939: add_interrupt_ran=
domness: Tick
> >         swapper/0-1       [000] d..h.11     2.369941: add_interrupt_ran=
domness: Tick
> >      kworker/0:0H-6       [000] .......     2.384714: mix_interrupt_ran=
domness: load
> >      kworker/0:0H-6       [000] .......     2.384715: crng_fast_load: 16
> >            <idle>-0       [001] dn.h1..     3.205766: add_interrupt_ran=
domness: Tick
> >            <idle>-0       [019] dn.h1..     6.771047: add_interrupt_ran=
domness: Tick
> >=20
> > 7 interrupts got lost before the worker could run & load first 16 bytes.
> > The workqueue core gets initialized at that point and spawns first
> > worker.
>=20
> So the reason for the longer delay here is that the workqueue core had not
> been initialized beforehand?

Kind of, yes. workqueue_init_early() happens quite early so we don't
have to worry about NULL pointer for system_highpri_wq. The worker
started after workqueue_init() populated the worker pools.

> > After that the interrupts took a break.
> > And then the work-to-load delay was quite low:
> >=20
> >            <idle>-0       [019] dn.h1..     7.586234: add_interrupt_ran=
domness: Tick
> >            <idle>-0       [019] dn.h1..     7.586234: add_interrupt_ran=
domness: work
> >     kworker/19:0H-175     [019] .......     7.586504: mix_interrupt_ran=
domness: load
> >     kworker/19:0H-175     [019] .......     7.586507: crng_fast_load: 16
> >            <idle>-0       [020] dn.h1..     7.614649: add_interrupt_ran=
domness: Tick
> >            <idle>-0       [020] dn.h1..     7.614651: add_interrupt_ran=
domness: work
> >            <idle>-0       [020] dn.h1..     7.614736: add_interrupt_ran=
domness: Tick
> >     kworker/20:0H-183     [020] dn.h...     7.614859: add_interrupt_ran=
domness: Tick
> >     kworker/20:0H-183     [020] .......     7.614871: mix_interrupt_ran=
domness: load
> >     kworker/20:0H-183     [020] .......     7.614872: crng_fast_load: 16
> >            <idle>-0       [018] dn.h1..     8.352423: add_interrupt_ran=
domness: Tick
> >            <idle>-0       [018] dn.h1..     8.352423: add_interrupt_ran=
domness: work
> >     kworker/18:0H-167     [018] dn.h1..     8.352438: add_interrupt_ran=
domness: Tick
> >     kworker/18:0H-167     [018] dn.h1..     8.352448: add_interrupt_ran=
domness: Tick
> >     kworker/18:0H-167     [018] dn.h1..     8.352459: add_interrupt_ran=
domness: Tick
> >     kworker/18:0H-167     [018] dn.h1..     8.352491: add_interrupt_ran=
domness: Tick
> >     kworker/18:0H-167     [018] .......     8.352505: mix_interrupt_ran=
domness: load
> >     kworker/18:0H-167     [018] .......     8.352506: crng_fast_load: 16
> >=20
> > In total we lost 13 ticks.
>=20
> Was this still way before the initramfs was up and running?

After unpacked initramfs. From current boot:

| [    5.901462] Unpacking initramfs...
| [    6.758747] sd 1:0:0:0: [sda] Attached SCSI disk
| [    7.886651] Freeing initrd memory: 9532K
| [    7.893753] Freeing unused kernel image (initmem) memory: 2184K
| [    7.963519] Write protecting the kernel read-only data: 20480k
| [    7.971465] Freeing unused kernel image (text/rodata gap) memory: 2032K
| [    7.979711] Freeing unused kernel image (rodata/data gap) memory: 1980K
| [    7.987132] Run /init as init process
| Loading, please wait...
|=20
| Starting version 250.3-2
| [    8.157529] igb 0000:07:00.0 eno0: renamed from eth0
| [    8.203836] igb 0000:07:00.1 enp7s0f1: renamed from eth1
| [    8.219489] random: fast init done
| Begin: Loading essential drivers ... done.
| Begin: Running /scripts/init-premount ... done.
| Begin: Mounting root file system ... Begin: Running /scripts/local-top ..=
=2E done.
| Begin: Running /scripts/local-premount ... done.
| Warning: fsck not present, so skipping root file[    8.337554] XFS (sda2)=
: Mounting V5 Filesystem
| [    8.392151] XFS (sda2): Ending clean mount
| done.
| Begin: Running /scripts/local-bottom ... done.
| Begin: Running /scripts/init-bottom ... done.
| [    8.540708] systemd[1]: systemd 250.3-2 running in system mode =E2=80=
=A6
| [   12.207227] random: crng init done

I have to note that on this system there is a initramfs but all drivers
are built-in (you see sd, net _after_ "Unpacking initramfs" but there
are not drivers to load).

> Thanks,
> 	Dominik

Sebastian
