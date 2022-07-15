Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F59D576136
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiGOMUW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Jul 2022 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiGOMUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:20:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00D577B372;
        Fri, 15 Jul 2022 05:20:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FDFA1474;
        Fri, 15 Jul 2022 05:20:18 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93C003F73D;
        Fri, 15 Jul 2022 05:20:15 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:20:06 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     Michael Walle <michael@walle.cc>, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not
 report an error
Message-ID: <20220715132006.077c90f8@donnerap.cambridge.arm.com>
In-Reply-To: <20220714220744.GF17705@kitsune.suse.cz>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
        <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
        <20220714205529.GE17705@kitsune.suse.cz>
        <33abf7b84860049c4a22605578303ff2@walle.cc>
        <20220714220744.GF17705@kitsune.suse.cz>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 00:07:44 +0200
Michal Suchánek <msuchanek@suse.de> wrote:

Hi,

> On Thu, Jul 14, 2022 at 11:51:56PM +0200, Michael Walle wrote:
> > Am 2022-07-14 22:55, schrieb Michal Suchï¿½nek:  
> > > On Thu, Jul 14, 2022 at 09:41:48PM +0200, Michael Walle wrote:  
> > > > Hi,
> > > > 
> > > > Am 2022-07-14 21:19, schrieb Michal Suchanek:  
> > > > > It is normal that devices are designed with multiple types of storage,
> > > > > and only some types of storage are present.
> > > > >
> > > > > The kernel can handle this situation gracefully for many types of
> > > > > storage devices such as mmc or ata but it reports and error when spi
> > > > > flash is not present.
> > > > >
> > > > > Only print a notice that the storage device is missing when no response
> > > > > to the identify command is received.
> > > > >
> > > > > Consider reply buffers with all bits set to the same value no response.  
> > > > 
> > > > I'm not sure you can compare SPI with ATA and MMC. I'm just speaking
> > > > of
> > > > DT now, but there, for ATA and MMC you just describe the controller
> > > > and
> > > > it will auto-detect the connected storage. Whereas with SPI you
> > > > describe  
> > > 
> > > Why does mmc assume storage and SDIO must be descibed? Why the special
> > > casing?  
> > 
> > I can't follow you here. My SDIO wireless card just works in an SD
> > slot and doesn't have to be described.

I think the difference is that MMC (so also SDIO) is a discoverable bus,
whereas SPI is not.
It's conceptually dangerous to blindly probe for SPI chips, and the kernel
tries to stay out of guessing games, in general, and leaves that up to
firmware.

> > > > both the controller and the flash. So I'd argue that your hardware
> > > > description is wrong if it describes a flash which is not present.  
> > > 
> > > At any rate the situation is the same - the storage may be present
> > > sometimes. I don't think assuming some kind of device by defualt is a
> > > sound practice.  
> > 
> > Where is the assumption when the DT tells you there is a flash
> > on a specific chip select but actually there it isn't. Shouldn't
> > the DT then be fixed?  
> 
> The DT says there isn't a flash on a specific chip select when there is.
> Shouldn't that be fixed?
> 
> > Maybe I don't understand your problem. What are you trying to
> > solve? I mean this just demotes an error to an info message.

The particular problem at hand is that on those cheap development boards
SPI flash is somewhat optional. The PCB often has the footprint for it, but
sometimes it is not populated, because the vendor wants to save pennies.

In this case (OrangePi Zero) there was no SPI chip soldered on the first
batches, but later boards are shipped with a flash chip. The footprint is
on every version, and I for instance soldered a chip on an early board.

> Many boards provide multiple storage options - you get a PCB designed to
> carry different kinds of storage, some may be socketed, some can be
> soldered on in some production batches and not others.
> 
> The kernel can handle this for many kinds of storage but not SPI flash.
> 
> I don't see any reason why SPI flash should be a second class storage.

See above, SPI is not discoverable, you need to know about the slave
devices.

> > > However, when the board is designed for a specific kind of device which
> > > is not always present, and the kernel can detect the device, it is
> > > perfectly fine to describe it.
> > > 
> > > The alternative is to not use the device at all, even when present,
> > > which is kind of useless.  
> > 
> > Or let the bootloader update your device tree and disable the device
> > if it's not there?  

Yes, this is what I was suggesting already: U-Boot can do the job, because
a U-Boot build is device specific, and we can take certain risks that the
generic and single-image kernel wants to avoid.
In this case we know that there is a SPI flash footprint, and it does no
harm in trying to check on CS0. So I was thinking about introducing a
U-Boot Kconfig variable to probe for and potentially disable the SPI flash
DT node. We would set this variable in defconfigs of boards with optional
SPI flash.

> But then it must be in the device tree?

However this indeed means that the SPI flash DT node must be in and enabled
in the DT, because we (try hard to) only use original Linux DT files, and
DTs must have been reviewed through the kernel ML first. The U-Boot driver
relies on the DT as well, so the official kernel DT copy would need to come
with that node enabled. Ideally U-Boot would disable it, if needed, and
the kernel error message would never appear.

> And then people will complain that if the bootloader does not have this
> feature then the kernel prints an error message?

This should not happen, if people follow the advice and use U-Boot's
device tree directly ($fdtcontroladdr) instead of loading some DTB from
somewhere. Then the U-Boot code (doing the check) and the DT (having
it enabled) should be in sync, and we don't see kernel error messages.

If it happens anyways (because people load some DTB), then it's a matter of
either "live with it" or "update your firmware".

Cheers,
Andre

> > Or load an overlay if it is there?  
> 
> Or maybe the kernel could just detect if the storage is present?
> 
> It's not like we don't have an identify command.
> 
> Thanks
> 
> Michal
> 

