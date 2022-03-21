Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C814E3388
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiCUW4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiCUWzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:55:53 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB43B2059
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:37:35 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2FFE4223F6;
        Mon, 21 Mar 2022 23:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647900848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxBe0AcSzdEDFixOtEFUcP9GEYOEHXL7qMX0u+vesV0=;
        b=e7Z50GM3rWGlajH1EKMYYY5zGQLcICLEOif796Mgja1Xyc241LO0vYEL5mCnsxs10uORnW
        iRp4VSuN+QOI2MQT29S4ltdMgZkLBr0USHLVFG0ZYkIAaSalGdcTwn8Wds11jk8Is+cWLF
        +MZN+ZAcgUmGiwfKb2vziUpi0EYl40U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Mar 2022 23:14:07 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 1/8] mtd: spi-nor: Rename method,
 s/spi_nor_match_id/spi_nor_match_name
In-Reply-To: <20220228111712.111737-2-tudor.ambarus@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-2-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1836a22dbff076d4f49095c9d59cb05f@walle.cc>
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

Am 2022-02-28 12:17, schrieb Tudor Ambarus:
> The method is matching a flash_info entry by searching by name. Rename
> the method for better clarity.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Michael Walle <michael@walle.cc>

> ---
>  drivers/mtd/spi-nor/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 9014008e60b3..f3c359d03163 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2876,8 +2876,8 @@ void spi_nor_restore(struct spi_nor *nor)
>  }
>  EXPORT_SYMBOL_GPL(spi_nor_restore);
> 
> -static const struct flash_info *spi_nor_match_id(struct spi_nor *nor,
> -						 const char *name)
> +static const struct flash_info *spi_nor_match_name(struct spi_nor 
> *nor,
> +						   const char *name)
>  {
>  	unsigned int i, j;
> 
> @@ -2899,7 +2899,7 @@ static const struct flash_info
> *spi_nor_get_flash_info(struct spi_nor *nor,
>  	const struct flash_info *info = NULL;
> 
>  	if (name)
> -		info = spi_nor_match_id(nor, name);
> +		info = spi_nor_match_name(nor, name);
>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info)
>  		info = spi_nor_read_id(nor);

-- 
-michael
