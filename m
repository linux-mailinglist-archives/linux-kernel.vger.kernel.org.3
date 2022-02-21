Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0264BD6E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346432AbiBUHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:41:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbiBUHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:41:04 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE741084
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:40:41 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5CFC12223A;
        Mon, 21 Feb 2022 08:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645429239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jk3lDnI8DX9v4V3hx6YghZovwYBmB0LKbO0lcLOwXUc=;
        b=J7kFqRXevRKTH+kNOmTACu4gS8Fb2rSygGQMfeeCOXbGzPzM8kVGbj8VsZu/NPo+nr2JyQ
        sasu4sTTfaRH1KGNGQvUCr+Ap3/uJCV4F4XdfjstQQSsYIHApkz7t7KNYh7D6zv+HzJhn5
        Y2gzf2QWXPL8MFtFu2pRs40MDE+c2YI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Feb 2022 08:40:39 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, broonie@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nicolas.ferre@microchip.com, zhengxunli@mxic.com.tw,
        jaimeliao@mxic.com.tw
Subject: Re: [PATCH 3/4] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from
 BFPT
In-Reply-To: <20220218145900.1440045-4-tudor.ambarus@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-4-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ac94e7628af971121921961fa4209683@walle.cc>
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

Am 2022-02-18 15:58, schrieb Tudor Ambarus:
> Parse BFPT in order to retrieve the byte order in 8D-8D-8D mode.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/sfdp.c | 3 +++
>  drivers/mtd/spi-nor/sfdp.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index a5211543d30d..551edbb039f0 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -633,6 +633,9 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		return -EOPNOTSUPP;
>  	}
> 
> +	if (bfpt.dwords[BFPT_DWORD(18)] & BFPT_DWORD18_BYTE_ORDER_SWAPPED)
> +		nor->flags |= SNOR_F_DTR_BSWAP16;
> +
>  	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
>  }
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
> index bbf80d2990ab..9a834ea31c16 100644
> --- a/drivers/mtd/spi-nor/sfdp.h
> +++ b/drivers/mtd/spi-nor/sfdp.h
> @@ -97,6 +97,7 @@ struct sfdp_bfpt {
>  #define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
>  #define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
>  #define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
> +#define BFPT_DWORD18_BYTE_ORDER_SWAPPED		BIT(31)
> 
>  struct sfdp_parameter_header {
>  	u8		id_lsb;

Reviewed-by: Michael Walle <michael@walle.cc>

-michael
