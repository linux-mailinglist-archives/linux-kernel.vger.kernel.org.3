Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC6531E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiEWWOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiEWWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:14:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9C56D945;
        Mon, 23 May 2022 15:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4A3CCE1941;
        Mon, 23 May 2022 22:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BD8C385A9;
        Mon, 23 May 2022 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653344057;
        bh=BtnYCdlUBKX6YqS/BraKh22u8nz1TCw7j+9R1vskYOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9BhonP0X+z778fxt/u02FGrHj5D510oCITyE4f6lDSzAPgfHnXUes/jfy4VfLrE/
         3QbasTeMap/V1oSB5s7BQ267SqGCKHWEc5s/yce5mwtQJluyG76bOMklKJ5vQedHxf
         UZfm7iH5QC6Nximri882B/sWSXl0jnfN6ea1UZh3zNCHSML5+0rVqGGnf7w04x01at
         F/dxZl77ZfP6VKQ0UNzEXcCS1hRU9XQfHPPtt1KIs1KwWohxf0SXgU2U2ODK2gtO9n
         0Kramiu5uPQ5tbNXMh/2cRhdp0/W3KdxANznXrGIncJHq16yDli+3UX74fpP9Rzqpu
         15hZuZYOOheFQ==
Date:   Mon, 23 May 2022 15:14:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
Message-ID: <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
 <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 01:04:03PM -0700, Saravana Kannan wrote:
> On Mon, May 23, 2022 at 8:17 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Fri, May 20, 2022 at 05:15:55PM -0700, Saravana Kannan wrote:
> > > On Fri, May 20, 2022 at 5:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > On Fri, May 20, 2022 at 04:49:48PM -0700, Saravana Kannan wrote:
> > > > > On Fri, May 20, 2022 at 4:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > > >
> > > > > > Hi Saravana,
> > > > > >
> > > > > > On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> > > > > > > The deferred probe timer that's used for this currently starts at
> > > > > > > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > > > > > > assumption being that all available drivers would be loaded and
> > > > > > > registered before the timer expires. This means, the
> > > > > > > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > > > > > > worst case. But if we set the default value for it to cover the worst
> > > > > > > case, it would significantly slow down the average case. For this
> > > > > > > reason, the default value is set to 0.
> > > > > > >
> > > > > > > Also, with CONFIG_MODULES=y and the current default values of
> > > > > > > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > > > > > > drivers will cause their consumer devices to always defer their probes.
> > > > > > > This is because device links created by fw_devlink defer the probe even
> > > > > > > before the consumer driver's probe() is called.
> > > > > > >
> > > > > > > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > > > > > > timer on every successful driver registration, with the expectation more
> > > > > > > modules would be loaded in the near future, then the default value of
> > > > > > > driver_deferred_probe_timeout only needs to be as long as the worst case
> > > > > > > time difference between two consecutive module loads.
> > > > > > >
> > > > > > > So let's implement that and set the default value to 10 seconds when
> > > > > > > CONFIG_MODULES=y.
> > > > > > >
> > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > > > Cc: Will Deacon <will@kernel.org>
> > > > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > > Cc: linux-gpio@vger.kernel.org
> > > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > > Cc: iommu@lists.linux-foundation.org
> > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > >
> > > > > > I bisected a boot hang with ARCH=s390 defconfig in QEMU down to this
> > > > > > change as commit 2b28a1a84a0e ("driver core: Extend deferred probe
> > > > > > timeout on driver registration") in next-20220520 (bisect log below).
> > > > > >
> > > > > > $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- defconfig bzImage
> > > > > >
> > > > > > $ timeout --foreground 15m stdbuf -oL -eL \
> > > > > > qemu-system-s390x \
> > > > > > -initrd ... \
> > > > > > -M s390-ccw-virtio \
> > > > > > -display none \
> > > > > > -kernel arch/s390/boot/bzImage \
> > > > > > -m 512m \
> > > > > > -nodefaults \
> > > > > > -serial mon:stdio
> > > > > > ...
> > > > > > [    2.077303] In-situ OAM (IOAM) with IPv6
> > > > > > [    2.077639] NET: Registered PF_PACKET protocol family
> > > > > > [    2.078063] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> > > > > > [    2.078795] Key type dns_resolver registered
> > > > > > [    2.079317] cio: Channel measurement facility initialized using format extended (mode autodetected)
> > > > > > [    2.081494] Discipline DIAG cannot be used without z/VM
> > > > > > [  260.626363] random: crng init done
> > > > > > qemu-system-s390x: terminating on signal 15 from pid 3815762 (timeout)
> > > > > >
> > > > > > We have a simple rootfs available if necessary:
> > > > > >
> > > > > > https://github.com/ClangBuiltLinux/boot-utils/raw/bc0d17785eb67f1edd0ee0a134970a807895f741/images/s390/rootfs.cpio.zst
> > > > > >
> > > > > > If there is any other information I can provide, please let me know!
> > > > >
> > > > > Hmm... strange. Can you please try the following command line options
> > > > > and tell me which of these has the issue and which don't?
> > > >
> > > > Sure thing!
> > > >
> > > > > 1) deferred_probe_timeout=0
> > > >
> > > > No issue.
> > > >
> > > > > 2) deferred_probe_timeout=1
> > > > > 3) deferred_probe_timeout=300
> > > >
> > > > Both of these appear to hang in the same way, I let each sit for five
> > > > minutes.
> > >
> > > Strange that a sufficiently large timeout isn't helping. Is it trying
> > > to boot off a network mount? I'll continue looking into this next
> > > week.
> >
> > I don't think so, it seems like doing that requires some extra flags
> > that we do not have:
> >
> > https://wiki.qemu.org/Features/S390xNetworkBoot
> >
> > If you need any additional information or want something tested, please
> > let me know!
> 
> I'll try to get qemu going on my end, but I'm not too confident I'll
> be able to get to it in a timely fashion. So if you can help figure
> out where this boot process is hanging, that'd be very much
> appreciated.

Sure thing! Information included below, I am more than happy to continue
to test and debug as you need.

> Couple of suggestions for debugging:
> 
> Can you add a log to "wait_for_device_probe()" and see if that's
> getting called right before the boot process hangs? If it does, can
> you get a stacktrace (I just add a WARN_ON(1) when I need a stack
> trace)? It's unlikely this is the case because
> deferred_probe_timeout=1 still causes an issue for you, but I'd be
> good to rule out.

If I add a pr_info() call at the top of wait_for_device_probe(), I see
it right before the process hangs. Adding WARN_ON(1) right below that
reveals dasd_eckd_init() in drivers/s390/block/dasd_eckd.c calls
wait_for_device_probe():

[    4.610397] ------------[ cut here ]------------
[    4.610520] WARNING: CPU: 0 PID: 1 at drivers/base/dd.c:742 wait_for_device_probe+0x28/0x110
[    4.611134] Modules linked in:
[    4.611593] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-next-20220523-dirty #1
[    4.611830] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    4.612017] Krnl PSW : 0704c00180000000 0000000000ce4b3c (wait_for_device_probe+0x2c/0x110)
[    4.612258]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[    4.612387] Krnl GPRS: 80000000fffff071 0000000000000027 000000000000000c 00000000017f91d8
[    4.612457]            00000000fffff071 00000000017f9218 0000000001a655a0 0000000000000006
[    4.612521]            0000000000000002 0000000001965810 00000000019d51a0 0000000000000000
[    4.612585]            0000000002218000 000000000125bcc8 0000000000ce4b38 000003800000bc80
[    4.614814] Krnl Code: 0000000000ce4b2c: e3e0f0980024        stg     %r14,152(%r15)
[    4.614814]            0000000000ce4b32: c0e5ffff94cb        brasl   %r14,0000000000cd74c8
[    4.614814]           #0000000000ce4b38: af000000            mc      0,0
[    4.614814]           >0000000000ce4b3c: c0100054d1fa        larl    %r1,000000000177ef30
[    4.614814]            0000000000ce4b42: e31010000012        lt      %r1,0(%r1)
[    4.614814]            0000000000ce4b48: a784002d            brc     8,0000000000ce4ba2
[    4.614814]            0000000000ce4b4c: d727f0a0f0a0        xc      160(40,%r15),160(%r15)
[    4.614814]            0000000000ce4b52: 41b0f0a0            la      %r11,160(%r15)
[    4.615698] Call Trace:
[    4.616559]  [<0000000000ce4b3c>] wait_for_device_probe+0x2c/0x110
[    4.616744] ([<0000000000ce4b38>] wait_for_device_probe+0x28/0x110)
[    4.616841]  [<000000000196593e>] dasd_eckd_init+0x12e/0x178
[    4.616913]  [<0000000000100936>] do_one_initcall+0x46/0x1e8
[    4.616983]  [<0000000001920706>] do_initcalls+0x126/0x150
[    4.617046]  [<000000000192095e>] kernel_init_freeable+0x1ae/0x1f0
[    4.617110]  [<0000000000ce85a6>] kernel_init+0x2e/0x168
[    4.617171]  [<0000000000103320>] __ret_from_fork+0x40/0x58
[    4.617233]  [<0000000000cf5eaa>] ret_from_fork+0xa/0x40
[    4.617352] Last Breaking-Event-Address:
[    4.617393]  [<0000000000e0e098>] __s390_indirect_jump_r14+0x0/0xc
[    4.617481] ---[ end trace 0000000000000000 ]---

> Let's try to rule out if deferred_probe_extend_timeout() is causing
> some issues. So, without my patch, what happens if you set:
> deferred_probe_timeout=1
> deferred_probe_timeout=300

At commit 6ee60e9c9f2f ("MAINTAINERS: add Russ Weight as a firmware
loader maintainer"), both deferred_probe_timeout=1 and
deferred_probe_timeout=300 hang the boot.

> If deferred_probe_timeout=1 causes an issue even without my patch,
> then in addition, can you try commenting out the call to
> fw_devlink_drivers_done() inside deferred_probe_timeout_work_func()
> and try again?

Sure, that does not appear to make a difference with
deferred_probe_timeout=1.

Cheers,
Nathan
