Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21831576C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiGPIUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:20:32 -0400
X-Greylist: delayed 127498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Jul 2022 01:20:31 PDT
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D23718C;
        Sat, 16 Jul 2022 01:20:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6A26433BFA;
        Sat, 16 Jul 2022 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657959629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HtmE+WcyQ4/KYYsr3vgJVMHchSAXne1Yk9HKQBPmTg=;
        b=WGbbB2RFvtZPv5fshJHB9RuT8uDTEsaJbab2mSSuRlfm3GJeqYtwi7Y1qp9HsvyOncg16E
        rXE2LBXSOhmerzpWVZ2cjqjyKPqoKC79zEGUCPZmjZ70CSdRZuryiC/nPGxG7mQ9Db2K4R
        Nt0q2GpTOn7XUyONmfmJztOobjBufoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657959629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6HtmE+WcyQ4/KYYsr3vgJVMHchSAXne1Yk9HKQBPmTg=;
        b=uejScnwajvD8zlb1tE1nVomNFmJAo7NyYdmtwctAC1/6gy5OKjpyR15RBPUbVTdkItA+eG
        Qqgra1AjAUgn3SCQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 01EAC2C141;
        Sat, 16 Jul 2022 08:20:28 +0000 (UTC)
Date:   Sat, 16 Jul 2022 10:20:27 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Michael Walle <michael@walle.cc>, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not
 report an error
Message-ID: <20220716082027.GK17705@kitsune.suse.cz>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
 <20220714205529.GE17705@kitsune.suse.cz>
 <33abf7b84860049c4a22605578303ff2@walle.cc>
 <20220714220744.GF17705@kitsune.suse.cz>
 <20220715092017.2ftoyzm22i4amrbt@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715092017.2ftoyzm22i4amrbt@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 02:50:17PM +0530, Pratyush Yadav wrote:
> On 15/07/22 12:07AM, Michal Suchánek wrote:
> > On Thu, Jul 14, 2022 at 11:51:56PM +0200, Michael Walle wrote:
> > > Am 2022-07-14 22:55, schrieb Michal Suchánek:
> > > > On Thu, Jul 14, 2022 at 09:41:48PM +0200, Michael Walle wrote:
> > > > > Hi,
> > > > > 
> > > > > Am 2022-07-14 21:19, schrieb Michal Suchanek:
> > > > > > It is normal that devices are designed with multiple types of storage,
> > > > > > and only some types of storage are present.
> > > > > >
> > > > > > The kernel can handle this situation gracefully for many types of
> > > > > > storage devices such as mmc or ata but it reports and error when spi
> > > > > > flash is not present.
> > > > > >
> > > > > > Only print a notice that the storage device is missing when no response
> > > > > > to the identify command is received.
> > > > > >
> > > > > > Consider reply buffers with all bits set to the same value no response.
> > > > > 
> > > > > I'm not sure you can compare SPI with ATA and MMC. I'm just speaking
> > > > > of
> > > > > DT now, but there, for ATA and MMC you just describe the controller
> > > > > and
> > > > > it will auto-detect the connected storage. Whereas with SPI you
> > > > > describe
> > > > 
> > > > Why does mmc assume storage and SDIO must be descibed? Why the special
> > > > casing?
> > > 
> > > I can't follow you here. My SDIO wireless card just works in an SD
> > > slot and doesn't have to be described.
> > > 
> > > > > both the controller and the flash. So I'd argue that your hardware
> > > > > description is wrong if it describes a flash which is not present.
> > > > 
> > > > At any rate the situation is the same - the storage may be present
> > > > sometimes. I don't think assuming some kind of device by defualt is a
> > > > sound practice.
> > > 
> > > Where is the assumption when the DT tells you there is a flash
> > > on a specific chip select but actually there it isn't. Shouldn't
> > > the DT then be fixed?
> > 
> > The DT says there isn't a flash on a specific chip select when there is.
> > Shouldn't that be fixed?
> 
> If the board has a flash chip, then DT should describe it. The it does 
> not have one, then DT should not describe it.
> 
> So if DT says there isn't a flash on a specific CS when there is, then 
> DT should be fixed to describe the flash, and then we can probe it. You 
> both seem to be saying the same thing here, and I agree.

The disagreement is about the situation when there is sometimes a flash
chip.

As of now the chip is described in the device tree but is disabled, and
there is no mechanism for enabling it.

If it were enabled the driver could probe it but it is not.

The only real argument against enabling it I head was that if it is
enabled and missing users would see the kernel printing an error nad
come here, wasting everyones time.

So here is a patch the makes the kernle not print an error when the chip
is missing, and limit the error only to the situation when a chip is
present but not recognized.

> 
> > 
> > > Maybe I don't understand your problem. What are you trying to
> > > solve? I mean this just demotes an error to an info message.
> > 
> > Many boards provide multiple storage options - you get a PCB designed to
> > carry different kinds of storage, some may be socketed, some can be
> > soldered on in some production batches and not others.
> 
> Usually for non-enumerable components you can plug in or out, you should 
> use DT overlays to add the correct nodes as needed. For example, CSI 
> cameras just plug into a slot on the board. So you can easily remove one 
> and add another. That is why we do not put the camera node in the board 
> dts, but instead apply it as an overlay from the bootloader.

However, here the device is already enumerated in the device tree, the
only missing bit of information is if the device is present.

Sure, device tree overlays are useful and the right tool for the job for
some jobs, but not this one.

Please don't fall into the thinking that when you have a hammer
everything looks like a nail.

> 
> > 
> > The kernel can handle this for many kinds of storage but not SPI flash.
> > 
> > I don't see any reason why SPI flash should be a second class storage.
> > 
> > > > However, when the board is designed for a specific kind of device which
> > > > is not always present, and the kernel can detect the device, it is
> > > > perfectly fine to describe it.
> > > > 
> > > > The alternative is to not use the device at all, even when present,
> > > > which is kind of useless.
> > > 
> > > Or let the bootloader update your device tree and disable the device
> > > if it's not there?
> > 
> > But then it must be in the device tree?
> > 
> > And then people will complain that if the bootloader does not have this
> > feature then the kernel prints an error message?
> 
> Then add the feature to the bootloader? Adding a node in DT for a flash 
> that is not present is wrong.

And how would the bootloader know that it shouild look for a flash if
it's not described in the device tree?

> 
> > 
> > > Or load an overlay if it is there?
> > 
> > Or maybe the kernel could just detect if the storage is present?
> 
> It can't. This is a non-enumerable bus, unlike USB or PCI. And there is 
> no way you can actually detect the presence or absence of a flash 
> reliably. For example, TI chips come with a flash that is capable of 
> 8D-8D-8D mode. If the flash is handed to the kernel in 8D-8D-8D mode, 
> the read ID command will return all 0xff bytes since the kernel expacts 
> communication in 1S-1S-1S mode. With your patch you will say that no 
> flash memory is detected. In reality the flash is present but the kernel 
> just failed to properly detect it.

This is a strawman argument. If your flash chip starts up in 8D-8D-8D
and you don't tell the kernel to talk to it in 8D-8D-8D it can't talk to
it no matter what. The id command will fail all the same if the chip is
there and try to probe it's type - all 0xff is not a valid id. The
problem is not that you are probing the presence of the chip but that
you did not describe the chip to the kernel correctly.

Not to mention that the controller in question does not support any
advanced modes, anyway.

> 
> > 
> > It's not like we don't have an identify command.
> 
> We do, but it does not let us detect the _absence_ of a flash.

Actually, it does.

Thanks

Michal
