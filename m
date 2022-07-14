Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFA95755F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiGNTmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiGNTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:42:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C296C13E;
        Thu, 14 Jul 2022 12:42:01 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8758B22238;
        Thu, 14 Jul 2022 21:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657827716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ro6DsiZOyVl0p4EfjbReVqk2JZ+ojOAHyeH+zjJsEw=;
        b=iBPQLNv4oS0P3UsioZAiEjIeQk76v1WKPCD5H0BzEwm00wXbLr8bX/Ya43aeQ5023QJq2k
        4q5ldJ7b56ZzTlNLFYfJBNS0SE3Cpk9/hYEctK+IcAQ8s1yWUCUeHXT5KFE5rSHhco2K8k
        KjI4b29t+HcLCCg6PXHnUv2ihhDi6d4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Jul 2022 21:41:48 +0200
From:   Michael Walle <michael@walle.cc>
To:     Michal Suchanek <msuchanek@suse.de>
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
In-Reply-To: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
References: <701967b0c418db333c66b48d225df60aa9d03ead.1657826188.git.msuchanek@suse.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d8de86aa0331be697fbef33d5ab2c57a@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-07-14 21:19, schrieb Michal Suchanek:
> It is normal that devices are designed with multiple types of storage,
> and only some types of storage are present.
> 
> The kernel can handle this situation gracefully for many types of
> storage devices such as mmc or ata but it reports and error when spi
> flash is not present.
> 
> Only print a notice that the storage device is missing when no response
> to the identify command is received.
> 
> Consider reply buffers with all bits set to the same value no response.

I'm not sure you can compare SPI with ATA and MMC. I'm just speaking of
DT now, but there, for ATA and MMC you just describe the controller and
it will auto-detect the connected storage. Whereas with SPI you describe
both the controller and the flash. So I'd argue that your hardware
description is wrong if it describes a flash which is not present.

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/mtd/spi-nor/core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 502967c76c5f..6bab540171a4 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1652,6 +1652,24 @@ static const struct flash_info
> *spi_nor_match_id(struct spi_nor *nor,
>  	return NULL;
>  }
> 
> +static const bool buffer_uniform(const u8 *buffer, size_t length)
> +{
> +	bool all0;
> +	size_t i;
> +
> +	for (all0 = true, i = 0; i < length; i++)
> +		if (buffer[i] != 0) {
> +			all0 = false;
> +			break;
> +		}
> +	if (all0)
> +		return true;
> +	for (i = 0; i < length; i++)
> +		if (buffer[i] != 0xff)
> +			return false;
> +	return true;
> +}

That seems unnecessarily complex.
if (!memchr_inv(id, '\x00', SPI_NOR_MAX_ID_LEN) ||
     !memchr_inv(id, '\xff', SPI_NOR_MAX_ID_LEN))

should be the same.

-michael

> +
>  static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
>  {
>  	const struct flash_info *info;
> @@ -1666,8 +1684,11 @@ static const struct flash_info
> *spi_nor_detect(struct spi_nor *nor)
> 
>  	info = spi_nor_match_id(nor, id);
>  	if (!info) {
> -		dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
> -			SPI_NOR_MAX_ID_LEN, id);
> +		if (buffer_uniform(id, SPI_NOR_MAX_ID_LEN))
> +			dev_info(nor->dev, "No flash memory detected.\n");
> +		else
> +			dev_err(nor->dev, "unrecognized JEDEC id bytes: %*ph\n",
> +				SPI_NOR_MAX_ID_LEN, id);
>  		return ERR_PTR(-ENODEV);
>  	}
>  	return info;
