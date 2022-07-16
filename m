Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D4576D28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiGPJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiGPJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:39:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A70E19026;
        Sat, 16 Jul 2022 02:38:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15F583467D;
        Sat, 16 Jul 2022 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657964333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjjB2Tj1v7P2/Hzk3+SDyFTeccso1IKFKW5WqPOEy9o=;
        b=FYLcjTomd9RwzKd0WH1grD27nlv90mrvwHhBqMpTwZ84b+ud/KCg/G66kuAwXewZT9WNZU
        KUoXV78aY9h0pGD3tU6wC1NUWMnnTut96DlEP8y9eH50+DJF9g9B7MqJejwpseg6NN+3AP
        aztwoEHqp/val4a46OzLLJze3puCCvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657964333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjjB2Tj1v7P2/Hzk3+SDyFTeccso1IKFKW5WqPOEy9o=;
        b=4zswoA0zLnplqlg+Z+74ZePirnVjDWStv2fDsZyruYBHwedU1AwvfDaucAqi2kwIgvOWD+
        zq/RYOljlEdPZGDQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 592212C141;
        Sat, 16 Jul 2022 09:38:51 +0000 (UTC)
Date:   Sat, 16 Jul 2022 11:38:50 +0200
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
Message-ID: <20220716093850.GL17705@kitsune.suse.cz>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
 <20220714205529.GE17705@kitsune.suse.cz>
 <33abf7b84860049c4a22605578303ff2@walle.cc>
 <20220714220744.GF17705@kitsune.suse.cz>
 <20220715092017.2ftoyzm22i4amrbt@ti.com>
 <20220716082027.GK17705@kitsune.suse.cz>
 <c6955eed3a445f4b87920fe0d47e7230@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6955eed3a445f4b87920fe0d47e7230@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 11:30:12AM +0200, Michael Walle wrote:
> Am 2022-07-16 10:20, schrieb Michal Suchánek:
> 
> > > So if DT says there isn't a flash on a specific CS when there is, then
> > > DT should be fixed to describe the flash, and then we can probe it.
> > > You
> > > both seem to be saying the same thing here, and I agree.
> > 
> > The disagreement is about the situation when there is sometimes a flash
> > chip.
> 
> No. The disagreement is what should happen if the DT says there is
> a device but there isn't. Which right now is an error and it should
> stay that way. Your hardware description says there is a flash
> but it cannot be probed, so it is an error. What about a board
> which has an actual error and the flash isn't responding? You
> trade one use case for another.

And what if you have a SATA controller with a bad cable?

Or a bad connection to a mmc card?

Then the kernel also does not say there is an error and simply does not
see the device.

This is normal. Not all devices that can potentially exist do exist. It
is up to the user to decide if it's an error that the device is missing.

> Also I've looked at the PHY subsystem and there, if a PHY is described
> in the DT but isn't there, the following error will be printed:
>   dev_err(&mdio->dev, "MDIO device at address %d is missing.\n", addr);
> 
> And that is for a bus which can even be automatically be
> probed/detected.

If there is no use case for having a card with unpopulated PHY then it
makes sense.

Here we do have a use case so the comparison is moot.

Thanks

Michal
