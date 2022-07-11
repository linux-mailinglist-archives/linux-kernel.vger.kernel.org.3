Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2191056FF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiGKKnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGKKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:43:04 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151123BE8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:50:53 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 846112223B;
        Mon, 11 Jul 2022 11:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657533050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMeX1vZTy7LXb6VdBKmKA4HS7JM9KLAcJ9+NNMAnB6I=;
        b=I4izBmkxo3qy/qgmt5u4bUud1eMkmJjka9XGuEOPNg0FVuMQ2idiXPbwjeqBiFBMdJXrqi
        3Hbz9B0J5JWvRrSVzQcOiYo5Y2oeNmuOV2QJLEU5IrTZMvcjVPqTAzv7ZBKwDDYcxtLDE6
        vwCSyAXi1ZaJ7dNhBf73F31cICI7jSo=
From:   Michael Walle <michael@walle.cc>
To:     quic_jaehyoo@quicinc.com
Cc:     clg@kaod.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        quic_ggregory@quicinc.com, quic_jiles@quicinc.com,
        tudor.ambarus@microchip.com, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
Date:   Mon, 11 Jul 2022 11:50:42 +0200
Message-Id: <20220711095042.2095360-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> Add support for Winbond W25Q512NW-IQ/IN
> 
> datasheet:
> https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf

Please add that as a Link: tag before your SoB tag.

> Test result on AST2600 SoC's SPI controller:
> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/jedec_id
> ef6020
> 
> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/manufacturer
> winbond
> 
> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/partname
> w25q512nwq
> 
> $ hexdump /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
> 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
> 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
> 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
> 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
> 00000d0 0aff fff0 ff21 ffdc
> 00000d8

This information goes below the --- line

> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index ffaa24055259..d6f1a3b7267e 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -133,6 +133,9 @@ static const struct flash_info winbond_nor_parts[] = {
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024)

Please use INFO(0xef6020, 0, 0, 0) and test wether it will still
work correctly. We will then be able to convert it to SNOR_ID3()
later.

> +		PARSE_SFDP
> +		OTP_INFO(256, 3, 0x1000, 0x1000) },

Did you test OTP?

-michael

>  	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
>  		PARSE_SFDP
>  		OTP_INFO(256, 3, 0x1000, 0x1000) },
> -- 
> 2.25.1

