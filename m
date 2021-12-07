Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B984746B520
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhLGIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhLGIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:10:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A3C061746;
        Tue,  7 Dec 2021 00:06:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7794B80E8B;
        Tue,  7 Dec 2021 08:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D47C341C1;
        Tue,  7 Dec 2021 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638864391;
        bh=U4v9xIVGbQYq4t+PNusV28a4UNhxsV7kkB8XIoPhDD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKLr/aDZthCAYPqyUT7iM1FEU77Op4+wmpZFzQHqM+lq0MP8t6ge4mDHyIUyu9gRu
         FDkVvDLKjaMp8NS+wg25SWLq6wjoAqR9NXdbCvLQncaoUitDgE1oaJZNzIlXzb0nan
         gEU5cC1ixd/137ot18A6T785IWFVg4ouiztMKwrk=
Date:   Tue, 7 Dec 2021 09:06:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Apple SoC PMGR device power states driver
Message-ID: <Ya8WBUBvaNnH72RL@kroah.com>
References: <20211124073419.181799-1-marcan@marcan.st>
 <8fdf7a68-1a24-89eb-96d6-93c3f334621c@marcan.st>
 <009b3350-4424-76d5-66d6-7393cdd8cd8a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009b3350-4424-76d5-66d6-7393cdd8cd8a@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 08:53:33AM +0100, Krzysztof Kozlowski wrote:
> On 07/12/2021 06:30, Hector Martin wrote:
> > On 24/11/2021 16.34, Hector Martin wrote:
> >> This series adds the driver for the Apple PMGR device power state
> >> registers. These registers can clockgate and (in some cases) powergate
> >> specific SoC blocks. They also control the reset line, and can have
> >> additional features such as automatic power management.
> >>
> >> The current driver supports only the lowest/highest power states,
> >> provided via the genpd framework, plus reset support provided via
> >> the reset subsystem.
> >>
> >> Apple's PMGRs (there are two in the T8103) have a uniform register
> >> bit layout (sometimes with varying features). To be able to support
> >> multiple SoC generations as well as express pd relationships
> >> dynamically, this binding describes each PMGR power state control
> >> as a single devicetree node. Future SoC generations are expected to
> >> retain backwards compatibility, allowing this driver to work on them
> >> with only DT changes.
> >>
> >> #1: MAINTAINERS updates, to go via the SoC tree to avert merge hell
> >> #2-#5: Adds power-domains properties to existing device bindings
> >> #6-#7: Adds the new pmgr device tree bindings
> >> #8: The driver itself.
> >> #9: Instantiates the driver in t8103.dtsi. This adds the entire PMGR
> >>      node tree and references the relevant nodes from existing devices.
> >> #7: Adds runtime-pm support to the Samsung UART driver, as a first
> >>      working consumer.
> >> #8: Instantiates a second UART, to more easily test this.
> >>
> >> There are currently no consumers for the reset functionality, so
> >> it is untested, but we will be testing it soon with the NVMe driver
> >> (as it is required to allow driver re-binding to work properly).
> >>
> >> == Changes since v2 ==
> >> - DT schema review comments & patch order fix
> >> - Added the power-domains properties to devices that already mainlined
> >> - Now adds the entire PMGR tree. This turns off all devices we do not
> >>    currently instantiate, and adds power-domains to those we do. The
> >>    nodes were initially generated with [1] and manually tweaked. all
> >>    the labels match the ADT labels (lowercased), which might be used
> >>    by the bootloader in the future to conditionally disable nodes
> >>    based on hardware configuration.
> >> - Dropped apple,t8103-minipmgr, since I don't expect we will ever need
> >>    to tell apart multiple PMGR instances within a SoC, and added
> >>    apple,t6000-pmgr{-pwrstate} for the new SoCs.
> >> - Driver now unconditionally enables auto-PM for all devices. This
> >>    seems to be safe and should save power (it is not implemented for
> >>    all devices; if not implemented, the bit just doesn't exist and is
> >>    ignored).
> >> - If an always-on device is not powered on at boot, turn it on and
> >>    print a warning. This avoids the PM core complaining. We still
> >>    want to know if/when this happens, but let's not outright fail.
> >> - Other minor fixes (use PS names instead of offsets for messages,
> >>    do not spuriously clear flag bits).
> >>
> >> On the way the parent node is handled: I've decided that these syscon
> >> nodes will only ever contain pwrstates and nothing else. We now size
> >> them based on the register range that contains pwrstate controls
> >> (rounded up to page size). t6000 has 3 PMGRs and t6001 has 4, and
> >> we shouldn't have to care about telling apart the multiple instances.
> >> Anything else PMGR does that needs a driver will be handled by
> >> entirely separate nodes in the future.
> >>
> >> Re t6001 and t6000 (and the rumored t6002), t6000 is basically a
> >> cut-down version of t6001 (and t6002 is rumored to be two t6001
> >> dies), down to the die floorplan, so I'm quite certain we won't need
> >> t6001/2-specific compatibles for anything shared. The t6000 devicetree
> >> will just #include the t6001 one and remove the missing devices.
> >> Hence, everything for this SoC series is going to have compatibles
> >> named apple,t6000-* (except the extra instances of some blocks in
> >> t6001 which look like they may have differences; PMGR isn't one of
> >> them, but some multimedia stuff might).
> >>
> >> [1] https://github.com/AsahiLinux/m1n1/blob/main/proxyclient/tools/pmgr_adt2dt.py
> >>
> >> Hector Martin (11):
> >>    MAINTAINERS: Add PMGR power state files to ARM/APPLE MACHINE
> >>    dt-bindings: i2c: apple,i2c: Add power-domains property
> >>    dt-bindings: iommu: apple,dart: Add power-domains property
> >>    dt-bindings: pinctrl: apple,pinctrl: Add power-domains property
> >>    dt-bindings: interrupt-controller: apple,aic: Add power-domains
> >>      property
> >>    dt-bindings: power: Add apple,pmgr-pwrstate binding
> >>    dt-bindings: arm: apple: Add apple,pmgr binding
> >>    soc: apple: Add driver for Apple PMGR power state controls
> >>    arm64: dts: apple: t8103: Add PMGR nodes
> >>    tty: serial: samsung_tty: Support runtime PM
> >>    arm64: dts: apple: t8103: Add UART2
> >>
> >>   .../bindings/arm/apple/apple,pmgr.yaml        |  134 ++
> >>   .../devicetree/bindings/i2c/apple,i2c.yaml    |    3 +
> >>   .../interrupt-controller/apple,aic.yaml       |    3 +
> >>   .../devicetree/bindings/iommu/apple,dart.yaml |    3 +
> >>   .../bindings/pinctrl/apple,pinctrl.yaml       |    3 +
> >>   .../bindings/power/apple,pmgr-pwrstate.yaml   |   71 ++
> >>   MAINTAINERS                                   |    3 +
> >>   arch/arm64/boot/dts/apple/t8103-j274.dts      |    5 +
> >>   arch/arm64/boot/dts/apple/t8103-pmgr.dtsi     | 1136 +++++++++++++++++
> >>   arch/arm64/boot/dts/apple/t8103.dtsi          |   36 +
> >>   drivers/soc/Kconfig                           |    1 +
> >>   drivers/soc/Makefile                          |    1 +
> >>   drivers/soc/apple/Kconfig                     |   21 +
> >>   drivers/soc/apple/Makefile                    |    2 +
> >>   drivers/soc/apple/apple-pmgr-pwrstate.c       |  317 +++++
> >>   drivers/tty/serial/samsung_tty.c              |   93 +-
> >>   16 files changed, 1798 insertions(+), 34 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> >>   create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
> >>   create mode 100644 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
> >>   create mode 100644 drivers/soc/apple/Kconfig
> >>   create mode 100644 drivers/soc/apple/Makefile
> >>   create mode 100644 drivers/soc/apple/apple-pmgr-pwrstate.c
> >>
> > 
> > Applied everything except the samsung_tty change to asahi-soc/dt (DT 
> > changes) and asahi-soc/pmgr (just the driver). Thanks everyone for the 
> > reviews!
> > 
> > Krzysztof: feel free to take that patch through tty if you think it's in 
> > good shape. I'm not sure how much power UART runtime-pm will save us, 
> > but at least it's a decent test case, so it's probably worth having.
> 
> The tty/serial driver change goes via Greg's tree.

I'll be glad to take it if you ack it :)

thanks,

greg k-h
