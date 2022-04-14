Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2250099E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiDNJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbiDNJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:24:19 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC6D50458
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:21:54 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1719C2223A;
        Thu, 14 Apr 2022 11:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649928113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuHb8XTtomchg7Wt1V7cWuPTosd89yhrLtbFPGpuEFM=;
        b=iNm9G2cOC5ItU4EwMF4hlS6D+qlTkw1IuOESG7ITyrYAJE50h5DrFeiIIBGQNN6kuM5Dmv
        y+vvnsZzYPrnAIq0Sp8T/Rxfy0ZzGnNigU8v+huiowMW8cDnL+FpCJGFNG4h/qsHCd13fo
        KWKUIgmhNrYPxHs3wdOHT2B6xI8bW+E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Apr 2022 11:21:52 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: Favor the BFPT-parsed
 set_4byte_addr_mode method
In-Reply-To: <20220411125346.118274-4-tudor.ambarus@microchip.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-4-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a6519a1ce39534c35760334cd69396b3@walle.cc>
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

Am 2022-04-11 14:53, schrieb Tudor Ambarus:
> JESD216 SFDP defines in the BFPT standard methods to enter and exit the
> 4-Byte Address Mode. The flash parameters and settings that are 
> retrieved
> from SFDP have higher precedence than the static initialized ones, 
> because
> they should be more accurate and less error prone than those 
> initialized
> statically. Favor the BFPT-parsed set_4byte_addr_mode method and use 
> the
> generic core methods where possible.
> This patch may introduce regressions in case BFPT contains wrong data. 
> The
> fix is to introduce a post_bfpt() fixup hook and update the wrong BFPT
> data.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> ---
> v3: no changes
> 
>  drivers/mtd/spi-nor/core.c      |  7 ++++++-
>  drivers/mtd/spi-nor/macronix.c  | 10 ++++++++--
>  drivers/mtd/spi-nor/micron-st.c |  9 ++++++---
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4d45cda4f9d3..888516d98884 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2416,6 +2416,8 @@ static void spi_nor_init_fixup_flags(struct 
> spi_nor *nor)
>   */
>  static void spi_nor_late_init_params(struct spi_nor *nor)
>  {
> +	struct spi_nor_flash_parameter *params = nor->params;
> +
>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>  	    nor->manufacturer->fixups->late_init)
>  		nor->manufacturer->fixups->late_init(nor);
> @@ -2423,6 +2425,10 @@ static void spi_nor_late_init_params(struct 
> spi_nor *nor)
>  	if (nor->info->fixups && nor->info->fixups->late_init)
>  		nor->info->fixups->late_init(nor);
> 
> +	/* Default method kept for backward compatibility. */
> +	if (!params->set_4byte_addr_mode)
> +		params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;

Can this be moved past..

> +
>  	spi_nor_init_flags(nor);
>  	spi_nor_init_fixup_flags(nor);

.. these two lines, so it is next to the "set default
locking ops"?

> 
> @@ -2490,7 +2496,6 @@ static void spi_nor_init_default_params(struct
> spi_nor *nor)
>  	struct device_node *np = spi_nor_get_flash_node(nor);
> 
>  	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
> -	params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_brwr;
>  	params->otp.org = &info->otp_org;
> 
>  	/* Default to 16-bit Write Status (01h) Command */
> diff --git a/drivers/mtd/spi-nor/macronix.c 
> b/drivers/mtd/spi-nor/macronix.c
> index 85e8655d362c..c267cbcc7f1d 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -105,12 +105,18 @@ static const struct flash_info 
> macronix_nor_parts[] = {
>  static void macronix_nor_default_init(struct spi_nor *nor)
>  {
>  	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
> -	nor->params->set_4byte_addr_mode =
> -		spi_nor_set_4byte_addr_mode_en4b_ex4b;
> +}
> +
> +static void macronix_nor_late_init(struct spi_nor *nor)
> +{
> +	if (!nor->params->set_4byte_addr_mode)
> +		nor->params->set_4byte_addr_mode =
> +			spi_nor_set_4byte_addr_mode_en4b_ex4b;

This is more of a general question. Can we have this in one
line? IMHO this looks awful and since linux nowadays relaxed the
80 chars rule a bit and we have such long names.. I think it makes
sense to allow some lines to be longer than 80 chars.

>  }
> 
>  static const struct spi_nor_fixups macronix_nor_fixups = {
>  	.default_init = macronix_nor_default_init,
> +	.late_init = macronix_nor_late_init,
>  };
> 
>  const struct spi_nor_manufacturer spi_nor_macronix = {
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index 2d1cbb1f37c8..9e9b107f2018 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -414,14 +414,17 @@ static void micron_st_nor_default_init(struct
> spi_nor *nor)
>  	nor->flags |= SNOR_F_HAS_LOCK;
>  	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
>  	nor->params->quad_enable = NULL;
> -	nor->params->set_4byte_addr_mode =
> -		spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;
>  }
> 
>  static void micron_st_nor_late_init(struct spi_nor *nor)
>  {
> +	struct spi_nor_flash_parameter *params = nor->params;
> +
>  	if (nor->info->mfr_flags & USE_FSR)
> -		nor->params->ready = micron_st_nor_ready;
> +		params->ready = micron_st_nor_ready;
> +	if (!params->set_4byte_addr_mode)
> +		params->set_4byte_addr_mode =
> +			spi_nor_set_4byte_addr_mode_wren_en4b_ex4b;

same here.

-michael
