Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6C533396
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiEXWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiEXWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:37:20 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50275338BE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:37:18 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 53AF4221D4;
        Wed, 25 May 2022 00:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653431836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCs0HAhZARemmsGo2G3uYjUYYZKrxsWqOtnmQSTd4i4=;
        b=qPSxEn4u8PQszAO0bIWyhCcQ2fFkT1WRWKaFop4Ned9HNlrWohdTRSlwViw9Uw2wVywxYD
        QA9m0ZXsWTsfY/HgMqkRqQesg5m2Ej4NQpUxSUhqGLoSPPf+RjlcYl8+MADAad+IFX/c3p
        sOy3B/P1jOT4sO8fNi2cQ6ZhXg5xtBs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 May 2022 00:37:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     chf.fritz@googlemail.com
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ClaudiuBeznea <claudiu.beznea@microchip.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: atmel: Add at25ql641 support
In-Reply-To: <48b49de3712267780916b665d3b2a3323e6f10ce.camel@googlemail.com>
References: <48b49de3712267780916b665d3b2a3323e6f10ce.camel@googlemail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0123ee0e70df13b340230a38cb44548f@walle.cc>
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

Am 2022-05-24 21:20, schrieb Christoph Fritz:
> This patch adds AT25QL641 to the list of supported nor flashs.

Please mention on which spi host controller this flash was
tested.

> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/mtd/spi-nor/atmel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
> index 656dd80a0be7..dfbc12071093 100644
> --- a/drivers/mtd/spi-nor/atmel.c
> +++ b/drivers/mtd/spi-nor/atmel.c
> @@ -186,6 +186,8 @@ static const struct flash_info atmel_nor_parts[] = 
> {
>  		.fixups = &atmel_nor_global_protection_fixups },
>  	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "at25ql641",	INFO(0x1f4317, 0, 64 * 1024, 128)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },

This flash supports SFDP, please use either SNOR_ID3() (you'll
have to pick my pending patches first [1]) or use
   { "at25ql641", INFO(0x1f4317, 0, 0, 0) PARSE_SFDP },
which will then be replaced with SNOR_ID3() once it is available.

>  	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16)

-michael

[1] https://lore.kernel.org/r/966de7ad5f563f9a29db91c5309a71c6@walle.cc/
