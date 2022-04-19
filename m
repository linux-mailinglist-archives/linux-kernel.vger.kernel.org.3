Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9450689E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350627AbiDSKV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiDSKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:21:27 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A715FD7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:18:45 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0976C2223A;
        Tue, 19 Apr 2022 12:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650363523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrEeMN9hF7GCeakXOW/eAFY+DlHb48AaOGpylclP/cU=;
        b=H4k0m1LY19571X2FaPU2N8jIeRtOGOovVkCIVDb2sDorgEJmNe7SBEcKhTOhrHux25ggwS
        56lRUMJkEw0whQOA5rKr77p/fXFakpHdpPOWDP3VV7WbdYzFcRoOCymJkZtalTDG4xUa/m
        7itzCKp+W2vxUxU7KJA1tOPFHmOF/OY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Apr 2022 12:18:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 3/9] mtd: spi-nor: core: Use auto-detection only once
In-Reply-To: <20220411091033.98754-4-tudor.ambarus@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-4-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8a12e7d841827388d1f8839d8afdfe5c@walle.cc>
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

Am 2022-04-11 11:10, schrieb Tudor Ambarus:
> In case spi_nor_match_name() returned NULL, the auto detection was
> issued twice. There's no reason to try to detect the same chip twice,
> do the auto detection only once.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3:
> - caller of spi_nor_get_flash_info now handles NULL and translates it 
> to
> ENOENT.
> 
>  drivers/mtd/spi-nor/core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index b9cc8bbf1f62..b55d922d46dd 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2896,13 +2896,14 @@ static const struct flash_info
> *spi_nor_get_flash_info(struct spi_nor *nor,
>  {
>  	const struct flash_info *info = NULL;
> 
> -	if (name)
> +	if (name) {
>  		info = spi_nor_match_name(nor, name);
> +		if (IS_ERR(info))
> +			return info;
> +	}

That is unnecessary, as spi_nor_match_name() doesn't
return an error code, just NULL or a valid pointer.

Apart from that:
Reviewed-by: Michael Walle <michael@walle.cc>

>  	/* Try to auto-detect if chip name wasn't specified or not found */
>  	if (!info)
> -		info = spi_nor_read_id(nor);
> -	if (IS_ERR_OR_NULL(info))
> -		return ERR_PTR(-ENOENT);
> +		return spi_nor_read_id(nor);
> 
>  	/*
>  	 * If caller has specified name of flash model that can normally be
> @@ -2994,7 +2995,9 @@ int spi_nor_scan(struct spi_nor *nor, const char 
> *name,
>  		return -ENOMEM;
> 
>  	info = spi_nor_get_flash_info(nor, name);
> -	if (IS_ERR(info))
> +	if (!info)
> +		return -ENOENT;
> +	else if (IS_ERR(info))
>  		return PTR_ERR(info);
> 
>  	nor->info = info;
