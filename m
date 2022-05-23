Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB95312A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiEWPRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiEWPRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:17:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC0645AFA;
        Mon, 23 May 2022 08:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFE12B81170;
        Mon, 23 May 2022 15:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805EDC385AA;
        Mon, 23 May 2022 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653319037;
        bh=CkdrHOJbqrYgqtlzU2t1gwW8LyMTW1lRhpgrRcERREY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQ4C2SBU00YISTyG/4Kii6b9dKw5B4OgQjrQIfVb+h/D0JIHrQtmvSZqGSz6RH5cf
         eIRmFAn+a4sMuMRYarKkRLzHiyxIcLNNIpxDpJVIfaCPK0+6Od2vuqpGcci4z+3Gmf
         q8w2ex+5NLwAvVS8C8oslhibKtEUbJWST3P57jAT5DYi9e/ECQgtuQv2e5J9JxYOT2
         3smHTffI64ixT+yst/sdrc98yApf3DpzTd9tYGqcpdnqm3KS/FrJnsVWxdoe4uxgQh
         Y8+M/YGY+KqbTtSUh3zFrpS7Wu54pKVWW96Fv7ydJJATq2h9XwmvzCakn15AosS6QT
         E7/8VBw1H16Ig==
Date:   Mon, 23 May 2022 08:17:14 -0700
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
Message-ID: <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 05:15:55PM -0700, Saravana Kannan wrote:
> On Fri, May 20, 2022 at 5:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Fri, May 20, 2022 at 04:49:48PM -0700, Saravana Kannan wrote:
> > > On Fri, May 20, 2022 at 4:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > Hi Saravana,
> > > >
> > > > On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> > > > > The deferred probe timer that's used for this currently starts at
> > > > > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > > > > assumption being that all available drivers would be loaded and
> > > > > registered before the timer expires. This means, the
> > > > > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > > > > worst case. But if we set the default value for it to cover the worst
> > > > > case, it would significantly slow down the average case. For this
> > > > > reason, the default value is set to 0.
> > > > >
> > > > > Also, with CONFIG_MODULES=y and the current default values of
> > > > > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > > > > drivers will cause their consumer devices to always defer their probes.
> > > > > This is because device links created by fw_devlink defer the probe even
> > > > > before the consumer driver's probe() is called.
> > > > >
> > > > > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > > > > timer on every successful driver registration, with the expectation more
> > > > > modules would be loaded in the near future, then the default value of
> > > > > driver_deferred_probe_timeout only needs to be as long as the worst case
> > > > > time difference between two consecutive module loads.
> > > > >
> > > > > So let's implement that and set the default value to 10 seconds when
> > > > > CONFIG_MODULES=y.
> > > > >
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > Cc: linux-gpio@vger.kernel.org
> > > > > Cc: linux-pm@vger.kernel.org
> > > > > Cc: iommu@lists.linux-foundation.org
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > >
> > > > I bisected a boot hang with ARCH=s390 defconfig in QEMU down to this
> > > > change as commit 2b28a1a84a0e ("driver core: Extend deferred probe
> > > > timeout on driver registration") in next-20220520 (bisect log below).
> > > >
> > > > $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- defconfig bzImage
> > > >
> > > > $ timeout --foreground 15m stdbuf -oL -eL \
> > > > qemu-system-s390x \
> > > > -initrd ... \
> > > > -M s390-ccw-virtio \
> > > > -display none \
> > > > -kernel arch/s390/boot/bzImage \
> > > > -m 512m \
> > > > -nodefaults \
> > > > -serial mon:stdio
> > > > ...
> > > > [    2.077303] In-situ OAM (IOAM) with IPv6
> > > > [    2.077639] NET: Registered PF_PACKET protocol family
> > > > [    2.078063] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> > > > [    2.078795] Key type dns_resolver registered
> > > > [    2.079317] cio: Channel measurement facility initialized using format extended (mode autodetected)
> > > > [    2.081494] Discipline DIAG cannot be used without z/VM
> > > > [  260.626363] random: crng init done
> > > > qemu-system-s390x: terminating on signal 15 from pid 3815762 (timeout)
> > > >
> > > > We have a simple rootfs available if necessary:
> > > >
> > > > https://github.com/ClangBuiltLinux/boot-utils/raw/bc0d17785eb67f1edd0ee0a134970a807895f741/images/s390/rootfs.cpio.zst
> > > >
> > > > If there is any other information I can provide, please let me know!
> > >
> > > Hmm... strange. Can you please try the following command line options
> > > and tell me which of these has the issue and which don't?
> >
> > Sure thing!
> >
> > > 1) deferred_probe_timeout=0
> >
> > No issue.
> >
> > > 2) deferred_probe_timeout=1
> > > 3) deferred_probe_timeout=300
> >
> > Both of these appear to hang in the same way, I let each sit for five
> > minutes.
> 
> Strange that a sufficiently large timeout isn't helping. Is it trying
> to boot off a network mount? I'll continue looking into this next
> week.

I don't think so, it seems like doing that requires some extra flags
that we do not have:

https://wiki.qemu.org/Features/S390xNetworkBoot

If you need any additional information or want something tested, please
let me know!

Cheers,
Nathan
