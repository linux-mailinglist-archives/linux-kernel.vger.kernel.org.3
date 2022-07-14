Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B895756A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiGNUzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiGNUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:55:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B8A6BC19;
        Thu, 14 Jul 2022 13:55:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C6B534D5B;
        Thu, 14 Jul 2022 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657832131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSgLilWzZarIXH8KzBy6OT9I39r0sIeov6Pzt1qEHic=;
        b=nSr8kGasBJrL9zy9v/TR8zRF6R/eRp45Pz+YgEV/RFQzJW2h0SpZrpKOcqhNVwNooxlDgb
        jHJICz0Mq9cQEvMm58k493YT6sDeuIWcyZwf1pGWJfz4lu/eO4WhjlHafw4r/o3mtUp6sv
        RCrIPzWp+W8io03l3sRAgmwebDr9pdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657832131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSgLilWzZarIXH8KzBy6OT9I39r0sIeov6Pzt1qEHic=;
        b=ufQJZG8R3C8c6LL3tJzJWynk44IsBIZWEuds+q7tjGpm8wJCEAt2d2e89HDT6IVJrn20kG
        YFOLLBrw4tZBTiAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 658E22C142;
        Thu, 14 Jul 2022 20:55:30 +0000 (UTC)
Date:   Thu, 14 Jul 2022 22:55:29 +0200
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
Message-ID: <20220714205529.GE17705@kitsune.suse.cz>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
 <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:41:48PM +0200, Michael Walle wrote:
> Hi,
> 
> Am 2022-07-14 21:19, schrieb Michal Suchanek:
> > It is normal that devices are designed with multiple types of storage,
> > and only some types of storage are present.
> > 
> > The kernel can handle this situation gracefully for many types of
> > storage devices such as mmc or ata but it reports and error when spi
> > flash is not present.
> > 
> > Only print a notice that the storage device is missing when no response
> > to the identify command is received.
> > 
> > Consider reply buffers with all bits set to the same value no response.
> 
> I'm not sure you can compare SPI with ATA and MMC. I'm just speaking of
> DT now, but there, for ATA and MMC you just describe the controller and
> it will auto-detect the connected storage. Whereas with SPI you describe

Why does mmc assume storage and SDIO must be descibed? Why the special
casing?

> both the controller and the flash. So I'd argue that your hardware
> description is wrong if it describes a flash which is not present.

At any rate the situation is the same - the storage may be present
sometimes. I don't think assuming some kind of device by defualt is a
sound practice.

However, when the board is designed for a specific kind of device which
is not always present, and the kernel can detect the device, it is
perfectly fine to describe it.

The alternative is to not use the device at all, even when present,
which is kind of useless.

Thanks

Michal

> 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  drivers/mtd/spi-nor/core.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 502967c76c5f..6bab540171a4 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -1652,6 +1652,24 @@ static const struct flash_info
> > *spi_nor_match_id(struct spi_nor *nor,
> >  	return NULL;
> >  }
> > 
> > +static const bool buffer_uniform(const u8 *buffer, size_t length)
> > +{
> > +	bool all0;
> > +	size_t i;
> > +
> > +	for (all0 = true, i = 0; i < length; i++)
> > +		if (buffer[i] != 0) {
> > +			all0 = false;
> > +			break;
> > +		}
> > +	if (all0)
> > +		return true;
> > +	for (i = 0; i < length; i++)
> > +		if (buffer[i] != 0xff)
> > +			return false;
> > +	return true;
> > +}
> 
> That seems unnecessarily complex.
> if (!memchr_inv(id, '\x00', SPI_NOR_MAX_ID_LEN) ||
>     !memchr_inv(id, '\xff', SPI_NOR_MAX_ID_LEN))
> 
> should be the same.
> 
> -michael
> 
> > +
> >  static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
> >  {
> >  	const struct flash_info *info;
> > @@ -1666,8 +1684,11 @@ static const struct flash_info
> > *spi_nor_detect(struct spi_nor *nor)
> > 
> >  	info = spi_nor_match_id(nor, id);
> >  	if (!info) {
> > -		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
> > -			SPI_NOR_MAX_ID_LEN, id);
> > +		if (buffer_uniform(id, SPI_NOR_MAX_ID_LEN))
> > +			dev_info(nor->dev, "No flash memory detected.\n");
> > +		else
> > +			dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
> > +				SPI_NOR_MAX_ID_LEN, id);
> >  		return ERR_PTR(-ENODEV);
> >  	}
> >  	return info;
