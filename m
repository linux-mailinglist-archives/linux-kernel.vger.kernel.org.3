Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F8C575761
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiGNWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiGNWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:07:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED866A9D1;
        Thu, 14 Jul 2022 15:07:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ABCAD1F944;
        Thu, 14 Jul 2022 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657836466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxL2Skx8UbFEzQGYad/BuKmDMwwk8ncManhq+noClII=;
        b=nxO/VsiByIQUvVw8J3ec8bA9Eu0GqyfKAIeitip/+JUq3wxLXLPc3ZEP0m4Y0l2sN+FfFY
        2mbmtaRnK98LtjaY5ZMVb38Luz5E/d25hhVK0JUJJd1DJQXRo5L8nkqORD4WoZ18GrHsq+
        ZSM//84UURlzTy+CWZ12ZyXCHYIeZEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657836466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxL2Skx8UbFEzQGYad/BuKmDMwwk8ncManhq+noClII=;
        b=1oHnFx62By/T3EA1ZD0f6lyFebUWlXX0tED1o5Z6GDaSWFHJ9N8iImlQQ6/zhyj++TDBQz
        +2qz/Orr3TcT/+Cg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3E4C2C141;
        Thu, 14 Jul 2022 22:07:45 +0000 (UTC)
Date:   Fri, 15 Jul 2022 00:07:44 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20220714220744.GF17705@kitsune.suse.cz>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
 <20220714205529.GE17705@kitsune.suse.cz>
 <33abf7b84860049c4a22605578303ff2@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33abf7b84860049c4a22605578303ff2@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:51:56PM +0200, Michael Walle wrote:
> Am 2022-07-14 22:55, schrieb Michal Suchánek:
> > On Thu, Jul 14, 2022 at 09:41:48PM +0200, Michael Walle wrote:
> > > Hi,
> > > 
> > > Am 2022-07-14 21:19, schrieb Michal Suchanek:
> > > > It is normal that devices are designed with multiple types of storage,
> > > > and only some types of storage are present.
> > > >
> > > > The kernel can handle this situation gracefully for many types of
> > > > storage devices such as mmc or ata but it reports and error when spi
> > > > flash is not present.
> > > >
> > > > Only print a notice that the storage device is missing when no response
> > > > to the identify command is received.
> > > >
> > > > Consider reply buffers with all bits set to the same value no response.
> > > 
> > > I'm not sure you can compare SPI with ATA and MMC. I'm just speaking
> > > of
> > > DT now, but there, for ATA and MMC you just describe the controller
> > > and
> > > it will auto-detect the connected storage. Whereas with SPI you
> > > describe
> > 
> > Why does mmc assume storage and SDIO must be descibed? Why the special
> > casing?
> 
> I can't follow you here. My SDIO wireless card just works in an SD
> slot and doesn't have to be described.
> 
> > > both the controller and the flash. So I'd argue that your hardware
> > > description is wrong if it describes a flash which is not present.
> > 
> > At any rate the situation is the same - the storage may be present
> > sometimes. I don't think assuming some kind of device by defualt is a
> > sound practice.
> 
> Where is the assumption when the DT tells you there is a flash
> on a specific chip select but actually there it isn't. Shouldn't
> the DT then be fixed?

The DT says there isn't a flash on a specific chip select when there is.
Shouldn't that be fixed?

> Maybe I don't understand your problem. What are you trying to
> solve? I mean this just demotes an error to an info message.

Many boards provide multiple storage options - you get a PCB designed to
carry different kinds of storage, some may be socketed, some can be
soldered on in some production batches and not others.

The kernel can handle this for many kinds of storage but not SPI flash.

I don't see any reason why SPI flash should be a second class storage.

> > However, when the board is designed for a specific kind of device which
> > is not always present, and the kernel can detect the device, it is
> > perfectly fine to describe it.
> > 
> > The alternative is to not use the device at all, even when present,
> > which is kind of useless.
> 
> Or let the bootloader update your device tree and disable the device
> if it's not there?

But then it must be in the device tree?

And then people will complain that if the bootloader does not have this
feature then the kernel prints an error message?

> Or load an overlay if it is there?

Or maybe the kernel could just detect if the storage is present?

It's not like we don't have an identify command.

Thanks

Michal
