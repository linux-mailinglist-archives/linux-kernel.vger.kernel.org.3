Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D09576D5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 13:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiGPLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGPLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 07:00:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F0A51E3FF;
        Sat, 16 Jul 2022 04:00:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B8181063;
        Sat, 16 Jul 2022 04:00:03 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407D03F73D;
        Sat, 16 Jul 2022 04:00:00 -0700 (PDT)
Date:   Sat, 16 Jul 2022 11:58:49 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Michael Walle <michael@walle.cc>, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not
 report an error
Message-ID: <20220716115849.75a27753@slackpad.lan>
In-Reply-To: <2d4f200c-1ce3-19c6-179f-8d8e0545adfe@sholland.org>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
        <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
        <20220714205529.GE17705@kitsune.suse.cz>
        <33abf7b84860049c4a22605578303ff2@walle.cc>
        <20220714220744.GF17705@kitsune.suse.cz>
        <20220715132006.077c90f8@donnerap.cambridge.arm.com>
        <2d4f200c-1ce3-19c6-179f-8d8e0545adfe@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 21:28:57 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> On 7/15/22 7:20 AM, Andre Przywara wrote:
> >>>> However, when the board is designed for a specific kind of device which
> >>>> is not always present, and the kernel can detect the device, it is
> >>>> perfectly fine to describe it.
> >>>>
> >>>> The alternative is to not use the device at all, even when present,
> >>>> which is kind of useless.    
> >>>
> >>> Or let the bootloader update your device tree and disable the device
> >>> if it's not there?    
> > 
> > Yes, this is what I was suggesting already: U-Boot can do the job, because
> > a U-Boot build is device specific, and we can take certain risks that the
> > generic and single-image kernel wants to avoid.
> > In this case we know that there is a SPI flash footprint, and it does no
> > harm in trying to check on CS0. So I was thinking about introducing a
> > U-Boot Kconfig variable to probe for and potentially disable the SPI flash
> > DT node. We would set this variable in defconfigs of boards with optional
> > SPI flash.  
> 
> To support the "does no harm" assertion: the Allwinner Boot ROM will probe for
> NOR flash (and possibly SPI NAND) on SPI0 + CS0 if no bootable MMC device is
> found. So the board designer must already assume that JEDEC Read ID commands
> will be sent over that bus.
> 
> >> But then it must be in the device tree?  
> > 
> > However this indeed means that the SPI flash DT node must be in and enabled
> > in the DT, because we (try hard to) only use original Linux DT files, and
> > DTs must have been reviewed through the kernel ML first. The U-Boot driver
> > relies on the DT as well, so the official kernel DT copy would need to come
> > with that node enabled. Ideally U-Boot would disable it, if needed, and
> > the kernel error message would never appear.  
> 
> I don't think this works for newer SoCs where the Boot ROM supports both NOR and
> SPI NAND. If the board is sold with the flash chip unpopulated, the user could
> install either kind of chip. So we cannot statically assume which binding will
> be used. We would need to add a node with the right compatible string after
> probing for both in the bootloader.

If a *user* decides to *change* the board, it's up to the user
to make sure the DT matches. Overlays are the typical answer, or people
change the DT before they build U-Boot. If someone decides to hack
their board, they have to take care of the respective DT description
hack as well.

This case here is about the *vendor* shipping different versions of the
board, which I think is a different case. Technically we now would need
two DTs: one with, one without the SPI flash node, and let the user
decide which one to include in U-Boot at build time, depending on which
version they have.

What I was suggesting is a U-Boot config switch, which would only be
enabled on those boards where we have this situation (OPi Zero):
That avoids dangerous situations (because we know it's safe *on this
particular board*), and avoids the hassle of shipping two firmware
versions.

Cheers,
Andre
