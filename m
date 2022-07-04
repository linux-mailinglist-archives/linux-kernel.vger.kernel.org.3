Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25D565769
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiGDNdB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jul 2022 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiGDNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:32:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D0F12AD1;
        Mon,  4 Jul 2022 06:31:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9625F23A;
        Mon,  4 Jul 2022 06:31:11 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED6363F66F;
        Mon,  4 Jul 2022 06:31:09 -0700 (PDT)
Date:   Mon, 4 Jul 2022 14:30:57 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20220704143057.76163208@donnerap.cambridge.arm.com>
In-Reply-To: <2985997.CbtlEUcBR6@jernej-laptop>
References: <20220428230933.15262-1-andre.przywara@arm.com>
        <3165164.aeNJFYEL58@kista>
        <20220630010410.38fc117f@slackpad.lan>
        <2985997.CbtlEUcBR6@jernej-laptop>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jul 2022 23:16:53 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

> Dne četrtek, 30. junij 2022 ob 02:04:10 CEST je Andre Przywara napisal(a):
> > On Tue, 03 May 2022 21:05:11 +0200
> > Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
> > 
> > Hi Jernej,
> > 
> > many thanks for taking the time to wade through this file!
> >   
> > > Dne petek, 29. april 2022 ob 01:09:30 CEST je Andre Przywara napisal(a):  
> > > > This (relatively) new SoC is similar to the H6, but drops the (broken)
> > > > PCIe support and the USB 3.0 controller. It also gets the management
> > > > controller removed, which in turn removes *some*, but not all of the
> > > > devices formerly dedicated to the ARISC (CPUS).
> > > > And while there is still the extra sunxi interrupt controller, the
> > > > package lacks the corresponding NMI pin, so no interrupts for the PMIC.
> > > > 
> > > > The reserved memory node is actually handled by Trusted Firmware now,
> > > > but U-Boot fails to propagate this to a separately loaded DTB, so we
> > > > keep it in here for now, until U-Boot learns to do this properly.
> > > > 
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > ---
> > > > 
> > > >  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi | 574 ++++++++++++++++++
> > > >  1 file changed, 574 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > b/arch/arm64/  
> > > 
> > > boot/dts/allwinner/sun50i-h616.dtsi
> > >   
> > > > new file mode 100644
> > > > index 000000000000..cc06cdd15ba5
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> > > > @@ -0,0 +1,574 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +// Copyright (C) 2020 Arm Ltd.
> > > > +// based on the H6 dtsi, which is:
> > > > +//   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > > > +
> > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > > > +#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
> > > > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > > > +#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
> > > > +
> > > > +/ {
> > > > +	interrupt-parent = <&gic>;
> > > > +	#address-cells = <2>;
> > > > +	#size-cells = <2>;
> > > > +
> > > > +	cpus {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +
> > > > +		cpu0: cpu@0 {
> > > > +			compatible = "arm,cortex-a53";
> > > > +			device_type = "cpu";
> > > > +			reg = <0>;
> > > > +			enable-method = "psci";
> > > > +			clocks = <&ccu CLK_CPUX>;
> > > > +		};
> > > > +
> > > > +		cpu1: cpu@1 {
> > > > +			compatible = "arm,cortex-a53";
> > > > +			device_type = "cpu";
> > > > +			reg = <1>;
> > > > +			enable-method = "psci";
> > > > +			clocks = <&ccu CLK_CPUX>;
> > > > +		};
> > > > +
> > > > +		cpu2: cpu@2 {
> > > > +			compatible = "arm,cortex-a53";
> > > > +			device_type = "cpu";
> > > > +			reg = <2>;
> > > > +			enable-method = "psci";
> > > > +			clocks = <&ccu CLK_CPUX>;
> > > > +		};
> > > > +
> > > > +		cpu3: cpu@3 {
> > > > +			compatible = "arm,cortex-a53";
> > > > +			device_type = "cpu";
> > > > +			reg = <3>;
> > > > +			enable-method = "psci";
> > > > +			clocks = <&ccu CLK_CPUX>;
> > > > +		};
> > > > +	};
> > > > +
> > > > +	reserved-memory {
> > > > +		#address-cells = <2>;
> > > > +		#size-cells = <2>;
> > > > +		ranges;
> > > > +
> > > > +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> > > > +		secmon_reserved: secmon@40000000 {
> > > > +			reg = <0x0 0x40000000 0x0 0x80000>;
> > > > +			no-map;
> > > > +		};
> > > > +	};  
> > > 
> > > I'm not a fan of above. If anything changes in future in BL31, U-Boot
> > > would
> > > need to reconfigure it anyway. Can we just skip it?  
> > 
> > I am not a fan neither, but last time I checked this is needed to boot.
> > Indeed TF-A inserts this node, with the right values, into U-Boot's DT.
> > And that's nicely preserved if you use that DT ($fdtcontroladdr) for
> > the kernel as well.
> > But if someone *loads* a DTB into U-Boot (to $fdt_addr_r), then
> > U-Boot fails to propagate the /reserved-memory node into that copy.
> > There does not seem to be a global notion of reserved memory in U-Boot.
> > Some commands (like tftp) explicitly parse the control DT to find and
> > respect reserved memory regions. bootm does that also, but only to
> > avoid placing the ramdisk or DTB into reserved memory. The information
> > ends up in images->lmb, but is not used to generate or amend nodes in
> > the target DT.
> > So the bits and pieces are there, but it will require some code to be
> > added to the generic U-Boot code.
> > 
> > So what do you think? Leaving this out will prevent loading DTBs into
> > U-Boot, at the moment, which sounds bad. I suggest we keep it in, for
> > now, it should not really hurt. U-Boot will hopefully start to do the
> > right thing soon, then we can either phase it out here (maybe when we
> > actually change something in TF-A), or let U-Boot fix it.  
> 
> TBH, if "soon" is really soon, I would rather wait with H616 DT until U-Boot 
> supports carrying over reserved memory nodes.

But this also carries compatibility issues. U-Boot support the H616 for
more than a year now, and the earliest possible U-Boot release having that
propagation code would be the one released in October. And then people
would still need to update first, so that's quite some months out.
And I was actually hoping to get at least the H616 DT patches off my
plate, and get them into the tree to have a stable and agreed upon base
(before this series turns into a teenager ;-)
Then we could for instance update the U-Boot H616 support.

> Whatever we do now, it will have 
> compatibility issues. If we introduce reserved memory node now, we can't 
> easily drop it later. Bootloaders are not very often updated, but kernels and 
> DTB files are, at least in my experience. So when we decide to drop the node?

I think of the three possibilities:
- Drop the node now, and ask people to not load DTBs explicitly
- Drop the node when U-Boot learned to propagate the reservation
- Keep the node
the last one is the least painful: having this node in does not really
hurt, so we can be very relaxed with this removal decision:
- If U-Boot does not add the reserved node, we are covered.
- If U-Boot adds the node, it will do so in a way where it deals with
existing reservations. So either it doesn't actually change anything, or
it extends the reservation.
- Should the TF-A location actually move (and we have no plans or needs to
do that), people would only get this by updating the firmware, at which
point the U-Boot part would surely be in place already. We don't really
support updating just BL31 in an existing binary firmware image, so you
would get an updated U-Boot as well.

I think the worst case scenario is that users end up with an unneeded 512K
reservation. If they care, a firmware update should solve this problem.

As for the time to remove that node: we could do that at the time when
(or rather: if) we actually change the TF-A reservation. At the moment
there are no plans to do this, and the size reservation is more than
generous (the current debug build is actually 77 KB or so only). If there
is no change, and the node stays in the .dtsi, it doesn't really hurt, see
above.

> After 10 years? Alternatively, reserved memory node can be just dropped and 
> anyone loading DTB file from outside would need to make sure it's patched. But 
> that's unexpected from user perspective, although patching DT files is done by 
> some distros.

Yeah, let's not go there. As you know, I already dislike the idea of
explicitly loading DTBs at all, but I understand this is what people, and
distributions, do, so I'd rather have them covered. Hence the node to
work with existing firmware.

Does that make sense?

Cheers,
Andre
