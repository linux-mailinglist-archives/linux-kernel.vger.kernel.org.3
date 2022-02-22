Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6B4BF429
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiBVI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBVI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:57:01 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5F3E32
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:56:35 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2E3202223B;
        Tue, 22 Feb 2022 09:56:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645520193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6zJLwKD8mteSJCqw/Hgoapillakx5pXLYT/IbB3NP0=;
        b=snHDnfUH33ZLMCcGSlZri5MaeRT9i6WesHez28YmECSpKlhb1D+Z3v1TGJ9r8y61867uog
        8yr4aGx2PcvFg6kquA0zBQjRInUMYvc2RLOfpePf4AcMVnAnZKbj5RFqxmyZNl5YWPJBd+
        +p7BtofPhZ3fVN6ivcxGd4AacPXd0Go=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Feb 2022 09:56:32 +0100
From:   Michael Walle <michael@walle.cc>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrick Williams <patrick@stwcx.xyz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
In-Reply-To: <20220222085148.21594-1-potin.lai@quantatw.com>
References: <20220222085148.21594-1-potin.lai@quantatw.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <3acadcc73688086c5ed204c058f28de7@walle.cc>
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

Am 2022-02-22 09:51, schrieb Potin Lai:
> Add support for winbond w25q01jv-iq chip
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> 
> ---
> 
> v2: 
> https://lore.kernel.org/all/20220222064227.16724-1-potin.lai@quantatw.com/
> v1: 
> https://lore.kernel.org/all/20211224104522.24615-1-potin.lai@quantatw.com/
> 
> Changes v2 --> v3:
> - move spi-nor flash information to comment area
> root@bletchley:~# cat
> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
> ef4021
> root@bletchley:~# cat
> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
> winbond
> root@bletchley:~# cat
> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/partname
> w25q01jv-iq
> root@bletchley:~# md5sum
> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> a7b9dbf76e99a33db99e557b6676588a
> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> root@bletchley:~# hexdump -C
> /sys/devices/platform/ahb/1e620000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp
> 00000000 53 46 44 50 06 01 01 ff 00 06 01 10 80 00 00 ff 
> |SFDP............|
> 00000010 84 00 01 02 d0 00 00 ff 03 00 01 02 f0 00 00 ff 
> |................|
> 00000020 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> |................|
> *
> 00000080 e5 20 fb ff ff ff ff 3f 44 eb 08 6b 08 3b 42 bb |. 
> .....?D..k.;B.|
> 00000090 fe ff ff ff ff ff 00 00 ff ff 40 eb 0c 20 0f 52 |..........@.. 
> .R|
> 000000a0 10 d8 00 00 36 02 a6 00 82 ea 14 e2 e9 63 76 33 
> |....6........cv3|
> 000000b0 7a 75 7a 75 f7 a2 d5 5c 19 f7 4d ff e9 70 f9 a5 
> |zuzu...\..M..p..|
> 000000c0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> |................|
> 000000d0 ff 0a f0 ff 21 ff dc ff |....!...|
> 000000d8
> 
> Changes v1 --> v2:
> - rework patch to work with new flags
> 
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index 59d53b4c39c8..4c088250fe96 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -131,6 +131,8 @@ static const struct flash_info winbond_parts[] = {
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> +	{ "w25q01jv-iq", INFO(0xef4021, 0, 64 * 1024, 2048)
> +		PARSE_SFDP },

You've seemed to miss my comment in v2 here. name should be w25q01jvq.

With that you can already add:
Reviewed-by: Michael Walle <michael@walle.cc>

-michael
