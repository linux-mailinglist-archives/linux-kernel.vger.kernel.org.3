Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031E506986
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350947AbiDSLRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350967AbiDSLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:17:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36264E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:14:54 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7529D2223A;
        Tue, 19 Apr 2022 13:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650366892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOmFS9aO47VVvSQgneAePnRstYH8GvaUVzpVYBw99LA=;
        b=XXxcDjx7zmn26130gcpxcwxX0vhgrnVRkqUJNjWKDqJOLeJXU4MXbQcWt0oCDyXmBrdhDh
        9WxgjurRqoYpox6m5tXra9ACsWLJz0d98Z5L4RF7Ckd6uo/80QrzwpRiajWNbwJJIun5rS
        MhYuQps0eg7r1qYEQFMKZT6Dhf1GDT0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Apr 2022 13:14:52 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 5/9] mtd: spi-nor: manufacturers: Use spi_nor_read_id()
 core method
In-Reply-To: <20220411091033.98754-6-tudor.ambarus@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-6-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e9fb855b93d814977838bf65a1e2a283@walle.cc>
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
> Use spi_nor_read_id() core method to avoid duplication of code. Now the 
> ID
> is read on the full SPI_NOR_MAX_ID_LEN instead of
> round_up(nor->info->id_len, 2), but it doesn't harm to read more ID 
> bytes,
> so the change comes with no secondary effects. dev_dbg messages in case
> spi_nor_read_id() fails, will be added in a further patch after we 
> split
> the octal DTR enable/disable methods.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

I like it, but maybe add a

/* SPI_NOR_MAX_ID_LEN is also used for octal readid and needs to be even 
*/
static_assert(SPI_NOR_MAX_ID_LEN % 2 == 0);

Reviewed-by: Michael Walle <michael@walle.cc>

> ---
> v3: collect R-b, update commit message
> 
>  drivers/mtd/spi-nor/micron-st.c | 13 +++----------
>  drivers/mtd/spi-nor/spansion.c  | 13 +++----------
>  2 files changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index 8a20475ce77a..41b87868ecf9 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -91,17 +91,10 @@ static int micron_st_nor_octal_dtr_enable(struct
> spi_nor *nor, bool enable)
>  		return ret;
> 
>  	/* Read flash ID to make sure the switch was successful. */
> -	op = (struct spi_mem_op)
> -		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
> -			   SPI_MEM_OP_NO_ADDR,
> -			   SPI_MEM_OP_DUMMY(enable ? 8 : 0, 1),
> -			   SPI_MEM_OP_DATA_IN(round_up(nor->info->id_len, 2),
> -					      buf, 1));
> -
>  	if (enable)
> -		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> -
> -	ret = spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_nor_read_id(nor, 0, 8, buf, SNOR_PROTO_8_8_8_DTR);
> +	else
> +		ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
>  	if (ret)
>  		return ret;
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c 
> b/drivers/mtd/spi-nor/spansion.c
> index f24e546e04a5..c5988312cc91 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -98,17 +98,10 @@ static int cypress_nor_octal_dtr_enable(struct
> spi_nor *nor, bool enable)
>  		return ret;
> 
>  	/* Read flash ID to make sure the switch was successful. */
> -	op = (struct spi_mem_op)
> -		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
> -			   SPI_MEM_OP_ADDR(enable ? 4 : 0, 0, 1),
> -			   SPI_MEM_OP_DUMMY(enable ? 3 : 0, 1),
> -			   SPI_MEM_OP_DATA_IN(round_up(nor->info->id_len, 2),
> -					      buf, 1));
> -
>  	if (enable)
> -		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> -
> -	ret = spi_mem_exec_op(nor->spimem, &op);
> +		ret = spi_nor_read_id(nor, 4, 3, buf, SNOR_PROTO_8_8_8_DTR);
> +	else
> +		ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
>  	if (ret)
>  		return ret;
