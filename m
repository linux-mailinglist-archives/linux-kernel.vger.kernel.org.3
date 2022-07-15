Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234F575E63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiGOJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGOJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:21:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0DC60521;
        Fri, 15 Jul 2022 02:21:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26F9KI0r094953;
        Fri, 15 Jul 2022 04:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657876818;
        bh=79+15PhDBbaYfjRz4Da0CiyiPsDJzQ/ow0y1Q7+aARk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kku9VDBbVMWl9g0xa3sStuUIr4MfzM0QTmdvBlm/S2Z7YPaldmgSrAsxASMklZLRQ
         NVZfyuAwCazMKJkkJvxJ5Ubh9vpImw4d7WrajJW1p47vrCR2QgnoPH6a+JXkZH3KXS
         lHEO39TeX6H63j7cAr36m8Jy3dUjk78ULwbzSliI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26F9KIQ0004595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jul 2022 04:20:18 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Jul 2022 04:20:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Jul 2022 04:20:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26F9KHi9108271;
        Fri, 15 Jul 2022 04:20:18 -0500
Date:   Fri, 15 Jul 2022 14:50:17 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
CC:     Michael Walle <michael@walle.cc>, <linux-sunxi@lists.linux.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: When a flash memory is missing do not
 report an error
Message-ID: <20220715092017.2ftoyzm22i4amrbt@ti.com>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
 <20220714205529.GE17705@kitsune.suse.cz>
 <33abf7b84860049c4a22605578303ff2@walle.cc>
 <20220714220744.GF17705@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714220744.GF17705@kitsune.suse.cz>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/22 12:07AM, Michal Suchánek wrote:
> On Thu, Jul 14, 2022 at 11:51:56PM +0200, Michael Walle wrote:
> > Am 2022-07-14 22:55, schrieb Michal Suchánek:
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
> > 
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

If the board has a flash chip, then DT should describe it. The it does 
not have one, then DT should not describe it.

So if DT says there isn't a flash on a specific CS when there is, then 
DT should be fixed to describe the flash, and then we can probe it. You 
both seem to be saying the same thing here, and I agree.

> 
> > Maybe I don't understand your problem. What are you trying to
> > solve? I mean this just demotes an error to an info message.
> 
> Many boards provide multiple storage options - you get a PCB designed to
> carry different kinds of storage, some may be socketed, some can be
> soldered on in some production batches and not others.

Usually for non-enumerable components you can plug in or out, you should 
use DT overlays to add the correct nodes as needed. For example, CSI 
cameras just plug into a slot on the board. So you can easily remove one 
and add another. That is why we do not put the camera node in the board 
dts, but instead apply it as an overlay from the bootloader.

> 
> The kernel can handle this for many kinds of storage but not SPI flash.
> 
> I don't see any reason why SPI flash should be a second class storage.
> 
> > > However, when the board is designed for a specific kind of device which
> > > is not always present, and the kernel can detect the device, it is
> > > perfectly fine to describe it.
> > > 
> > > The alternative is to not use the device at all, even when present,
> > > which is kind of useless.
> > 
> > Or let the bootloader update your device tree and disable the device
> > if it's not there?
> 
> But then it must be in the device tree?
> 
> And then people will complain that if the bootloader does not have this
> feature then the kernel prints an error message?

Then add the feature to the bootloader? Adding a node in DT for a flash 
that is not present is wrong.

> 
> > Or load an overlay if it is there?
> 
> Or maybe the kernel could just detect if the storage is present?

It can't. This is a non-enumerable bus, unlike USB or PCI. And there is 
no way you can actually detect the presence or absence of a flash 
reliably. For example, TI chips come with a flash that is capable of 
8D-8D-8D mode. If the flash is handed to the kernel in 8D-8D-8D mode, 
the read ID command will return all 0xff bytes since the kernel expacts 
communication in 1S-1S-1S mode. With your patch you will say that no 
flash memory is detected. In reality the flash is present but the kernel 
just failed to properly detect it.

> 
> It's not like we don't have an identify command.

We do, but it does not let us detect the _absence_ of a flash.

> 
> Thanks
> 
> Michal

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
