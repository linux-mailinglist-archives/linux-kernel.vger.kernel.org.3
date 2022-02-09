Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7E4AEC6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbiBIIa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:30:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239756AbiBIIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:30:49 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A54C05CB8C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:30:53 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2DAC22222E;
        Wed,  9 Feb 2022 09:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644395449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWdm67gA7+zk9jlgZ1z7LIqczKn6nqGWLdX4mNABBpA=;
        b=sP8DEhoFsO/Gw8L9NMTquKBIGMi4HfGOmKl4/RoNlpvasb36cbmzpgbbcMKSzRGGnXRs7F
        4T2Gv9z5PofDXo/oGkKVpezhvSITuiuw2kwd6bfPmVYOpTGCap8GmsCsZ26EYGVZQiBXap
        UWw/8CnCw8deWcukGJjEclQup+DoJmY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Feb 2022 09:30:46 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     dianders@chromium.org, tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        quic_stummala@quicinc.com, quic_vbadigan@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com
Subject: Re: [PATCH V5] mtd: spi-nor: winbond: Add support for winbond chip
In-Reply-To: <1644350330-8809-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1644350330-8809-1-git-send-email-quic_c_sbhanu@quicinc.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <d343f7172f179ac2da96f80f54cc500d@walle.cc>
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

Am 2022-02-08 20:58, schrieb Shaik Sajida Bhanu:
> Add support for winbond W25Q512NW-IM chip.

Also please include that in the subject. Eg.

mtd: spi-nor: winbond: add support for W25Q512NW-IM

> 
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes since V1:
> 	- Added space before name of the flash part as suggested by Doug.
> 
> Changes since V2:
> 	- Updated chip name as w25q512nwm as suggested by Doug.
> 
> Changes since V3:
> 	- Updated flash_info flags passing according to below patch.
> 
> Changes since V4:
> 	- Added OTP support for SPI card as suggested by Michael Walle.
> 	- Updated SFDP flags passing as suggested by Pratyush Yadav.
> ---
>  drivers/mtd/spi-nor/winbond.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index 675f32c..315b9f6 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -124,6 +124,10 @@ static const struct flash_info winbond_parts[] = {
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +		PARSE_SFDP

This usually goes first, eg.

PARSE_SFDP
FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
OTP_INFO(256, 3, 0x1000, 0x1000)

> +		OTP_INFO(256, 3, 0x1000, 0x1000) },
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },

Otherwise the SFDP dump is still missing as requested in my
comment in v4. Please make sure you put it in the comment
section of the patch, that is under the "---" line.

Then I think, this patch is good.

-michael
