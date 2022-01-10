Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B985E489BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiAJPK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiAJPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:10:28 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33F1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:10:27 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6B6DC22239;
        Mon, 10 Jan 2022 16:10:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1641827425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XqbUeFSqsZFEDKOfae+exL8OedQU2w5DkolQaaFkuY=;
        b=cngTIyt20rM2M2mfFcW1T+/m1ts3nd+XolwWok0dzAfwrb/bJPHL/JNtW5FbXiO+aCKb8t
        cG1GcQLlkZaujjcnjfPVftm4asZ41/EJjAwmOkKDGLeCsobUctR+n5wS8iMLb+34wBpxaS
        fRjQnAzVOhIK5+CIhAup/2eXDAlNP4g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Jan 2022 16:10:22 +0100
From:   Michael Walle <michael@walle.cc>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25q512jvm
In-Reply-To: <20220109044418.4657-1-dphadke@linux.microsoft.com>
References: <20220109044418.4657-1-dphadke@linux.microsoft.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <262a03e185c29583450180e3dc8c4e6c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-01-09 05:44, schrieb Dhananjay Phadke:
> Add support for Winbond 64MB W25Q512JV-DTR NOR flash.
> Use PARSE_SFDP flag to init parameters during SFDP parsing.
> 
> Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index 675f32c136b3..ebc826e21f76 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -118,6 +118,8 @@ static const struct flash_info winbond_parts[] = {
>  		.fixups = &w25q256_fixups },
>  	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512)
>  		PARSE_SFDP },
> +	{ "w25q512jvm", INFO(0xef7020, 0, 64 * 1024, 1024),

OTP_INFO(256, 3, 0x1000, 0x1000)

should enable OTP support, could you please test this using the 
flash_otp_{dump,info,erase,write} tools and add that line?

> +		PARSE_SFDP },
>  	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },

-michael
