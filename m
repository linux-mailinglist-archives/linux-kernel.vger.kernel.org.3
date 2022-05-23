Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA1530B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiEWIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiEWID0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:03:26 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E348F237F3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:03:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BEEB62223E;
        Mon, 23 May 2022 10:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1653292998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=viZm/10OcsyYDfI4zcvzPEqIUAuMcVQMGHS11NyoqCU=;
        b=rzyRiyMplNYpkNlTswdcfFl/9ZAlOULv3f4nYk5h8RoA8pS+DopSACMlctDaiwRs9rbBdW
        /tCLruXOiw5IZOCTpTkUS8LyV1DNhPsGmQHem8grzTsQQuy9zC9rACRQ/XgoCtTGppIQ23
        Thphe6d75F+ROTnQbFgL1UeHRHKnSqE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 May 2022 10:03:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: add support for gd25lq128e
In-Reply-To: <20220523055541.724422-1-tom@tom-fitzhenry.me.uk>
References: <20220523055541.724422-1-tom@tom-fitzhenry.me.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <65339d49135ffb578b5cd5ae459cea8a@walle.cc>
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

Am 2022-05-23 07:55, schrieb Tom Fitzhenry:
> The GD25LQ128EWIGR[0] reports an JEDEC id with a different vendor,
> otherwise it seems to fit neatly in the gigadevice list.

According to JEP106BC the vendor code 0x25 is Tristar. I'm
not sure what is going on here.

> Tested to work on the Pine64 PinePhone Pro[1].
> 
> Attribution: initial version was written by
> Martijn Braam <martijn@brixit.nl> for the Pine64 vendor kernel[2].
> 
> Also in use in vendor u-boot builds[3].
> 
> 0. https://www.gigadevice.com/flash-memory/gd25lq128e/
> 1. https://wiki.pine64.org/wiki/PinePhone_Pro
> 2. https://gitlab.com/pine64-org/linux/-/merge_requests/29
> 3.
> https://github.com/Tow-Boot/Tow-Boot/blob/b94838dfb8971cdeb841d3922051aaa8e108b085/boards/pine64-pinephonePro/0001-mtd-spi-nor-ids-Add-GigaDevice-GD25LQ128E-entry.patch

Do we need this? If you like you can provide a datasheet
with the Link: tag at the end of the commit.

This flash supports SFDP, please provide an SFDP dump, see [1].

> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---
>  drivers/mtd/spi-nor/gigadevice.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/gigadevice.c 
> b/drivers/mtd/spi-nor/gigadevice.c
> index 33895002eeea..871c9dee11dc 100644
> --- a/drivers/mtd/spi-nor/gigadevice.c
> +++ b/drivers/mtd/spi-nor/gigadevice.c
> @@ -56,6 +56,10 @@ static const struct flash_info 
> gigadevice_nor_parts[] = {
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "gd25lq128e", INFO(0x257018, 0, 64 * 1024, 256)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)

Did you test locking?

> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

As this flash supports SFDP, please use SNOR_ID3(0x257018)
and drop both the INFO() and the NO_SFDP_FLAGS(). You'll
need my SNOR_ID3() patches [2].

>  	{ "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256)
>  		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
[2] 
https://lore.kernel.org/linux-mtd/20220510140232.3519184-1-michael@walle.cc/
