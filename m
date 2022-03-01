Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279224C87CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiCAJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCAJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:26:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392896AA65
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:25:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBA1CB81855
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD7DC340EE;
        Tue,  1 Mar 2022 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646126742;
        bh=PBRGer/QifePZvXIkO8YwafXH3wl9OoKR3+OKNX7UZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlOiZlvZdwnAzG2CPvTFckv5zB8WUQdTwZ0vWPIDfLeUJgWa7PZ0CV7Yy/HvpFdO+
         G0K2tCRWA3kNG+Z0QxQHgnoYv++plQh8+cFCwWhpuhzrqSzj0GyLcAHtJTR+vqj/5C
         /Frl4+TTPDfMeObadRfEpZObcACzTuq9JXxKDb5JyMR10XIHI7OfxGfQSvn+iQjZMJ
         UiigAJwTm08vDwhQa0b+tdR+/y3MENwUTkIyct10f0dFJsDYy3IKT3IpfrlO4qRFru
         HltJmtEVNMXWdWMhkVSYIkfVQfzE2iOJTisM1mh13wJbFKdGN2kiiQXNokV+KYinA/
         QtRrcmtILVpmA==
Received: by pali.im (Postfix)
        id 2C06AC77; Tue,  1 Mar 2022 10:25:39 +0100 (CET)
Date:   Tue, 1 Mar 2022 10:25:39 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
Message-ID: <20220301092539.lru7hsaqxrjqz32r@pali>
References: <20220218212526.16021-1-pali@kernel.org>
 <87o82r0zjh.fsf@BL-laptop>
 <875yoz0wpw.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yoz0wpw.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 February 2022 17:42:03 Gregory CLEMENT wrote:
> > Hello Pali,
> >
> >> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> >> device-tree in order to support legacy I/O port based cards which have
> >> hardcoded I/O ports in low address space.
> >>
> >> Some legacy PCI I/O based cards do not support 32-bit I/O addressing.
> >>
> >> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> >> 'ranges' DT property") this driver can work with I/O windows which
> >> have
> >
> > Should we add a "Fixes: 64f160e19e92 ("PCI: aardvark: Configure PCIe
> > resources from 'ranges' DT property")" tag ?
> 
> Waiting for your confirmation I tried to applied it but it failed.
> 
> Did you base this patch on v5.17-rc1 ?
> 
> Gregory

Hello! This change is breaking booting of Turris Mox kernel with older
bootloader due to bugs in bootloader. So it is not possible to remap
PCI I/O space for turris-mox.dts file. I will send a new version of this
patch just for 37xx.dtsi file and add a comment into turris-mox.dts file
it is not possible here.

> >
> > Gregory
> >
> >> a different address for CPU than for PCI bus (unless there is some
> >> conflict with other A37xx mapping), without needing additional support
> >> for this in the firmware.
> >>
> >> Note that DDR on A37xx is mapped to bus address 0x0 and that mapping of
> >> I/O space can be set to address 0x0 too because MEM space and I/O space
> >> are separate and so they do not conflict.
> >>
> >> Signed-off-by: Pali Rohár <pali@kernel.org>
> >> Reported-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
> >>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> >> index 6581092c2c90..7d1b9153a901 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> >> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> >> @@ -163,7 +163,7 @@
> >>  	 */
> >>  	#address-cells = <3>;
> >>  	#size-cells = <2>;
> >> -	ranges = <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* Port 0 IO */
> >> +	ranges = <0x81000000 0 0x00000000   0 0xe8000000   0 0x01000000   /* Port 0 IO */
> >>  		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 MEM */
> >>  
> >>  	/* enabled by U-Boot if PCIe module is present */
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> >> index 549c3f7c5b27..a099b7787429 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> >> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> >> @@ -515,7 +515,7 @@
> >>  			 * (totaling 127 MiB) for MEM.
> >>  			 */
> >>  			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
> >> -				  0x81000000 0 0xeff00000   0 0xeff00000   0 0x00100000>; /* Port 0 IO*/
> >> +				  0x81000000 0 0x00000000   0 0xeff00000   0 0x00100000>; /* Port 0 IO */
> >>  			interrupt-map-mask = <0 0 0 7>;
> >>  			interrupt-map = <0 0 0 1 &pcie_intc 0>,
> >>  					<0 0 0 2 &pcie_intc 1>,
> >> -- 
> >> 2.20.1
> >>
> >
> > -- 
> > Gregory Clement, Bootlin
> > Embedded Linux and Kernel engineering
> > http://bootlin.com
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
