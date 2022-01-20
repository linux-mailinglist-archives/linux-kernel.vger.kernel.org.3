Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB58494BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376295AbiATKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359821AbiATKbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:31:40 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F79DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:31:40 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0AF9F22247;
        Thu, 20 Jan 2022 11:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1642674697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEg3Wy9lMSlCUog5GgyYmwZTgnrkPWGBbrgutH/M48Y=;
        b=P5HQHjUt8Ice1UEEBvkEu+0e/ELZClOXUkO+hOCCY4uJj38IuLZwrZmF5oZwrJiXFrfOqL
        OcQEDW0yjL0SewNy4Uk663a8yGu9cAenf/i+CRIhblC77X3/nrsqVrIWWd/9dz1KcbxBW9
        loWl25DIj9jvjKmc/DJO8cCxc4Lq8eM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Jan 2022 11:31:36 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     dianders@chromium.org, tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org
Subject: Re: [PATCH V4] mtd: spi-nor: winbond: Add support for winbond chip
In-Reply-To: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1642672491-30067-1-git-send-email-quic_c_sbhanu@quicinc.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <db1d17bbdcf7af2b8b58f6e7fa82062c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-01-20 10:54, schrieb Shaik Sajida Bhanu:
> Add support for winbond W25Q512NW-IM chip.
> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
> 
> Changes since V1:
> 	- Added space before name of the flash part as suggested by Doug.
> 
> Changes since V2:
> 	- Updated chip name as w25q512nwm as suggested by Doug.
> 
> Changes since V3:
> 	- Updated flash_info flags passing according to below patch

Thanks!

Please note, that you also have to supply a SFDP dump, see [1].

> https://lore.kernel.org/all/20211207140254.87681-7-tudor.ambarus@microchip.com/
> 	 As suggested by Tudor Ambarus.
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index 675f32c..c4be225 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] = {
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },

Could you try adding OTP_INFO(256, 3, 0x1000, 0x1000), this
should enable OTP support. Could you please test this using the
flash_otp_{dump,info,erase,write} tools and add that line?

I've checked ID duplications, because there is the w25qNNjw
series. There doesn't seem to exist a w25q512jw, so we are
safe for now. There is only a w25q512jv and it has the id
0xef4020.

fun fact.. the w25q512nwm describes the OTP lock bit for
the first OTP region (the one which is not documented and
I've found out that its used for storing the SFDP) as
SFDP lock bit. See ch "7.1.1 Security Register Lock Bits
(LB3, LB2, LB1, SFDP Lock bit)". So we finally have
evidence :)

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
