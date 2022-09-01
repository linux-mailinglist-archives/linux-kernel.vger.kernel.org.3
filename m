Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691C5A9081
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiIAHj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiIAHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:39:23 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36E61223A8;
        Thu,  1 Sep 2022 00:39:19 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 88D582164;
        Thu,  1 Sep 2022 09:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662017957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMEtvcM6R7qWErDv+zpeNYOr9cq3oBFA1JIMh558M60=;
        b=q/4wttpnf+Y01ithL9dlOUO6BYasi28m48j1xCoNp07VlkSa97v73f10YMFoHq7xzFswcr
        qkm+MbJzo2pDtQggEl3g5Z9LH1vpDMs6WJjB2RR+B0ZY/Xn/mzw64tR+2xsuuCDAS30k0n
        FOuyS/+YJmLPPaQv/ABYPJhBZzH6mcwp95F3bNiZzZKIKjHZdN1K/SdsJPQ6Uk9MAbNoGx
        qk0jPJvGtv8ZwBUuaxy8cIyZa5RBhfv8Vxo8W0d+Tir5G+YrB49sULfv7bJQ79fV45CVR6
        06ePGrJKsXZIrl8LUQhfflZc5Vvo3ux7tlDbYgdJ4tWOYY2TvquD8tIkXkUdUg==
MIME-Version: 1.0
Date:   Thu, 01 Sep 2022 09:39:17 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
        git@amd.com
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: Add support for flash reset
In-Reply-To: <20220901072914.30205-3-sai.krishna.potthuri@amd.com>
References: <20220901072914.30205-1-sai.krishna.potthuri@amd.com>
 <20220901072914.30205-3-sai.krishna.potthuri@amd.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f4c6e60a22a4252bcecdfb3a2c957b2a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-01 09:29, schrieb Sai Krishna Potthuri:
> Add support for spi-nor flash reset via GPIO controller by reading the
> reset-gpio property. If there is a valid GPIO specifier then reset will
> be performed by asserting and deasserting the GPIO using gpiod APIs
> otherwise it will not perform any operation.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Reviewed-by: Michael Walle <michael@walle.cc>

Just one comment, see below

> ---
>  drivers/mtd/spi-nor/core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f2c64006f8d7..a78ab9bae2be 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2933,6 +2933,27 @@ static void spi_nor_set_mtd_info(struct spi_nor 
> *nor)
>  	mtd->_put_device = spi_nor_put_device;
>  }
> 
> +static int spi_nor_hw_reset(struct spi_nor *nor)
> +{
> +	struct gpio_desc *reset;
> +
> +	reset = devm_gpiod_get_optional(nor->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR_OR_NULL(reset))
> +		return PTR_ERR_OR_ZERO(reset);
> +
> +	/*
> +	 * Experimental delay values by looking at different flash device
> +	 * vendors datasheets.
> +	 */
> +	usleep_range(1, 5);

I think this is superfluous, because parts of the kernel
will boot which should take longer than 1us. But I'm
fine with leaving it here.

-michael

> +	gpiod_set_value_cansleep(reset, 1);
> +	usleep_range(100, 150);
> +	gpiod_set_value_cansleep(reset, 0);
> +	usleep_range(1000, 1200);
> +
> +	return 0;
> +}
> +
>  int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		 const struct spi_nor_hwcaps *hwcaps)
>  {
> @@ -2965,6 +2986,10 @@ int spi_nor_scan(struct spi_nor *nor, const char 
> *name,
>  	if (!nor->bouncebuf)
>  		return -ENOMEM;
> 
> +	ret = spi_nor_hw_reset(nor);
> +	if (ret)
> +		return ret;
> +
>  	info = spi_nor_get_flash_info(nor, name);
>  	if (IS_ERR(info))
>  		return PTR_ERR(info);
