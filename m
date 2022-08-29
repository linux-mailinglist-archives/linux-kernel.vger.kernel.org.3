Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3725A46C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiH2KEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiH2KEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:04:47 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561C4F182;
        Mon, 29 Aug 2022 03:04:41 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1C99838F;
        Mon, 29 Aug 2022 12:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1661767479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCIErdxtYSs48v8IzFvX4Iwt90EXPm6+TYmgBg9KbBw=;
        b=x9jrPLve1l3tLiKr84DdJ/XSBTPHTkqiUwKL5ANRrnhHyyd7yRhxcaVjU9g36XlmI4ny2/
        seE3vX2yFczl11K63REpyr7kegG/cW4jgHEAwwGi8jvrBcNEFai6161Qboa6jiHGW/klJu
        7DT+tA6hyKb5w47L2wOf21ILsqP3bR7lFJyL2PjRkJ/6SFDoLa89Ag9HrGCqXismm27f30
        qGJDNKdMmZnG9Tj8470tB9Uro+qxOwm+AfmbvRW3c3ePH5GNENxrmBvpMB+TXg7UQUcMgr
        XZj99YtAtqZWQ1ksZ1hkzTe+OXE6JHknvbbgxw/CZKpUjlpiPjdd/n13aNYtoQ==
MIME-Version: 1.0
Date:   Mon, 29 Aug 2022 12:04:38 +0200
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
Subject: Re: [PATCH 2/2] mtd: spi-nor: Add support for flash reset
In-Reply-To: <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
References: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
 <20220829090528.21613-3-sai.krishna.potthuri@amd.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <be7f0b7bbb25d86ac079502babbf5f1b@walle.cc>
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

Hi,

Am 2022-08-29 11:05, schrieb Sai Krishna Potthuri:
> Add support for spi-nor flash reset via GPIO controller by reading the
> reset-gpio property. If there is a valid GPIO specifier then reset will
> be performed by asserting and deasserting the GPIO using gpiod APIs
> otherwise it will not perform any operation.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  drivers/mtd/spi-nor/core.c | 50 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f2c64006f8d7..d4703ff69ad0 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2401,12 +2401,8 @@ static void spi_nor_no_sfdp_init_params(struct
> spi_nor *nor)
>   */
>  static void spi_nor_init_flags(struct spi_nor *nor)
>  {
> -	struct device_node *np = spi_nor_get_flash_node(nor);
>  	const u16 flags = nor->info->flags;
> 
> -	if (of_property_read_bool(np, "broken-flash-reset"))
> -		nor->flags |= SNOR_F_BROKEN_RESET;
> -
>  	if (flags & SPI_NOR_SWP_IS_VOLATILE)
>  		nor->flags |= SNOR_F_SWP_IS_VOLATILE;
> 
> @@ -2933,9 +2929,47 @@ static void spi_nor_set_mtd_info(struct spi_nor 
> *nor)
>  	mtd->_put_device = spi_nor_put_device;
>  }
> 
> +static int spi_nor_hw_reset(struct spi_nor *nor)
> +{
> +	struct gpio_desc *reset;
> +	int ret;
> +
> +	reset = devm_gpiod_get_optional(nor->dev, "reset", GPIOD_ASIS);

devm_gpiod_get_optional(nor->dev, "reset", GPIOD_OUT_HIGH);

> +	if (IS_ERR_OR_NULL(reset))
> +		return PTR_ERR_OR_ZERO(reset);
> +
> +	/* Set the direction as output and enable the output */
> +	ret = gpiod_direction_output(reset, 1);

Not necessary then.

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Experimental Minimum Chip select high to Reset delay value
> +	 * based on the flash device spec.
> +	 */

Which flash device spec?

> +	usleep_range(1, 5);
> +	gpiod_set_value(reset, 0);

Mh, is your logic inverted here? If I read the code correctly,
you should use a value of 1 to take the device into reset. The
device tree should then have a flag "active low", which will
invert the value here. Also please use the cansleep() variant.

> +	/*
> +	 * Experimental Minimum Reset pulse width value based on the
> +	 * flash device spec.
> +	 */
> +	usleep_range(10, 15);
> +	gpiod_set_value(reset, 1);
> +
> +	/*
> +	 * Experimental Minimum Reset recovery delay value based on the
> +	 * flash device spec.
> +	 */
> +	usleep_range(35, 40);
> +
> +	return 0;
> +}
> +
>  int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		 const struct spi_nor_hwcaps *hwcaps)
>  {
> +	struct device_node *np = spi_nor_get_flash_node(nor);
>  	const struct flash_info *info;
>  	struct device *dev = nor->dev;
>  	struct mtd_info *mtd = &nor->mtd;
> @@ -2965,6 +2999,14 @@ int spi_nor_scan(struct spi_nor *nor, const char 
> *name,
>  	if (!nor->bouncebuf)
>  		return -ENOMEM;
> 
> +	if (of_property_read_bool(np, "broken-flash-reset")) {
> +		nor->flags |= SNOR_F_BROKEN_RESET;
> +	} else {
> +		ret = spi_nor_hw_reset(nor);
> +		if (ret)
> +			return ret;
> +	}

This should be done unconditionally, no? Even if the reset
pin is broken, we know we have one (otherwise the device
tree would be broken) and we can do a reset in any case.

Also, which tree are you using? That was moved into
spi_nor_init_flags() some time ago. Please rebase to latest
spi-next.

-michael

> +
>  	info = spi_nor_get_flash_info(nor, name);
>  	if (IS_ERR(info))
>  		return PTR_ERR(info);
