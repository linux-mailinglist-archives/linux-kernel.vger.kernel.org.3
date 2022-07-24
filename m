Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3177A57F5EB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiGXP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGXP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:59:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52125E0E3;
        Sun, 24 Jul 2022 08:59:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D782C34C60;
        Sun, 24 Jul 2022 15:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658678369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxvex5bGw+e3+6CFw4jkNhrpNowUtS9AgtNeRXWKTkA=;
        b=GdIEqA2ysDLUgucN7UH6ziilC6kEZ9rNQC6tSdrlyxkttgr1jj2qeJvMQVDruV5f/C709N
        nNQ+rcQ7jDnNeeYwcO8qxKHpirsnGUJiWUW0ZjHCiicrEfMy4x8vw47i0tYliQ9Xp/9gBr
        8ChbJjIt+bvy3EUj7UT9osWLZSRXuwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658678369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxvex5bGw+e3+6CFw4jkNhrpNowUtS9AgtNeRXWKTkA=;
        b=htFrnRKw5thq/VIxymIR7zbZRaYJ+2HwW18cB/XvFhRUzGTamCVInI97Xs2bC1ACPV59/6
        KS7TRLtoXWMEkQBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E52192C174;
        Sun, 24 Jul 2022 15:59:27 +0000 (UTC)
Date:   Sun, 24 Jul 2022 17:59:26 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Michael Walle <michael@walle.cc>
Cc:     Pratyush Yadav <p.yadav@ti.com>, linux-sunxi@lists.linux.dev,
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
Message-ID: <20220724155926.GI17705@kitsune.suse.cz>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
 <20220714205529.GE17705@kitsune.suse.cz>
 <33abf7b84860049c4a22605578303ff2@walle.cc>
 <20220714220744.GF17705@kitsune.suse.cz>
 <20220715092017.2ftoyzm22i4amrbt@ti.com>
 <20220716082027.GK17705@kitsune.suse.cz>
 <c6955eed3a445f4b87920fe0d47e7230@walle.cc>
 <20220716093850.GL17705@kitsune.suse.cz>
 <50ec7bf33d8eca5eb68a079f7bcc12b7@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50ec7bf33d8eca5eb68a079f7bcc12b7@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 11:44:48AM +0200, Michael Walle wrote:
> Am 2022-07-16 11:38, schrieb Michal Suchánek:
> > On Sat, Jul 16, 2022 at 11:30:12AM +0200, Michael Walle wrote:
> > > Am 2022-07-16 10:20, schrieb Michal Suchánek:
> > > 
> > > > > So if DT says there isn't a flash on a specific CS when there is, then
> > > > > DT should be fixed to describe the flash, and then we can probe it.
> > > > > You
> > > > > both seem to be saying the same thing here, and I agree.
> > > >
> > > > The disagreement is about the situation when there is sometimes a flash
> > > > chip.
> > > 
> > > No. The disagreement is what should happen if the DT says there is
> > > a device but there isn't. Which right now is an error and it should
> > > stay that way. Your hardware description says there is a flash
> > > but it cannot be probed, so it is an error. What about a board
> > > which has an actual error and the flash isn't responding? You
> > > trade one use case for another.
> > 
> > And what if you have a SATA controller with a bad cable?
> > 
> > Or a bad connection to a mmc card?
> 
> Again. You don't tell the kernel via the DT that there is an
> MMC card nor that there is a SATA SDD. In contrast to SPI-NOR..

So what?

there is some firmware table that can enable/disable individual SATA
ports, and some BIOSes have the option to disable individual ports.

Sure, you could insist that users should disable unused ports, and
having enabled port with no disk is an error but it's unreasonable - the
users would have to flip the setting unnecessarily because the kernel
can probe the presence of the disk but insists on assuming there is
one on every port. So people would rightfully point out that it's not
inherently an error to have a SATA port but no disk attached.

What I want is merely the same level of service for SPI NOR - that the
user does not need to switch the devicetrees when the presence of a
flash chip can be probed.

You keep repeting that devicetree describes the hardware but that's not
what it does.

"A |spec|-compliant devicetree describes device information in a system
that cannot necessarily be dynamically detected by a client program."

So it does not describe 'hardware', it describes hardware properties
that cannot be probed.

Let's dissect the mmc situation in a bit more detail:

If the device tree describes a MMC bus it means that there are some
traces attached to some hardware pins, and that the pinmux should be
configured to expose a mmc peripherial on these pins.

The decision to use these pins for mmc is somewhat arbitrary. It must be
specified in the devicetree because it cannot be probed but on many
boards you could use the same pins for different hardware peripherial
such as an UART, and with bitbanging low-speed protocols the
possibilities are endless. Even if there is a SD socket that does not
really mean anything - there are many abuses of standard connectors for
non-standard purposes all around.

Nonetheless, if at least some boards come with a MMC device soldered to
the pins or the documentation advises to use a SD/SDIO card then the
pins should be configured as MMC, and it is not invalidated by the fact
that the pins could theoretically be abused for other purposes.

Also on some boards there is always a MMC device soldered, and lack of
the device could be considered an error. Nonetheless, on other boards
the device may be present only on some boards or socketed. The mmc
driver is driver for all of these boards so it has to deal with missing
device gracefully.

Sure, it means that for some boards that have damaged hardware no error
is reported. That's the result of drivers being general purpose, not
baord specific. The same way on some PC mainboards you could consider
missing SATA drive on a specific port an error but the driver is
generic, and should handle also boards that don't necessarily always
come with all ports populated.

There is also the possibility that you have a SDIO WiFi card that does
not have an eeprom with a MAC address, and an EEPROM is mounted
somewhere on the board to store it. In thios case although the MMC bus
is 'discoverable', and the presence and type of the SDIO card can be
probed all right the relationship to the eeprom cannot, and has to be
recorded in the device tree. Will missing the SDIO card cause an error?
I doubt it, MMC is the great 'discoverable' bus after all so here you
have it - a hardware is described, it's missing, and it's not an error.

So for SPI NOR we similarily have some traces that are connected to some
hardware pins, and given that the board comes with a SPI NOR at least
sometimes, or it is documented that these traces should be used for
mounting a SPI NOR that should be described in the device tree. It is
not invalidated by the fact that not all boards come with the SPI NOR or
that it comes in an optional separate bag with accessories or that the
pins coud be theoretically abused for something else.

Now because SPI bus is not 'discoverable' not only the arbitrary
decision to mux the SPI peripehrial on those pins needs to be recorded
but also the arbitrary decision to use the pins to acces a SPI NOR, and
not any other random SPI peripherial.

Again, the spi-nor driver is driver not only the boards that always come
with the flash soldered but also for the boards where it is mounted only
sometimes. It should deal gracefully with the flash missing as much as
it deals gracefully with different flash memory sizes, erase block
sizes, etc. It's a parameter that can be probed.

> > Then the kernel also does not say there is an error and simply does not
> > see the device.
> > 
> > This is normal. Not all devices that can potentially exist do exist. It
> > is up to the user to decide if it's an error that the device is missing.
> > 
> > > Also I've looked at the PHY subsystem and there, if a PHY is described
> > > in the DT but isn't there, the following error will be printed:
> > >   dev_err(&mdio->dev, "MDIO device at address %d is missing.\n",
> > > addr);
> > > 
> > > And that is for a bus which can even be automatically be
> > > probed/detected.
> > 
> > If there is no use case for having a card with unpopulated PHY then it
> > makes sense.
> > 
> > Here we do have a use case so the comparison is moot.
> 
> And what use case is that? You are just demoting an error

Boards with optional SPI NOR device.

> to an info. Apparently you just want to see that error
> go away, there is no change in functionality.

Yes, it's a sign of a bad assumption on the part of the driver. Sure, it
might have been true in the past but with new hardware it's no longer
the case so the driver should adjust.

Currently the driver problem is worked around by being over-specific
in devicetree but ultimately the driver is broken and should be fixed.

Thanks

Michal
