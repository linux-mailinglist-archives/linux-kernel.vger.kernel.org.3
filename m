Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC39757F004
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiGWPQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiGWPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:16:05 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A90F12AAE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:16:03 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id FGr4o1zigAZYmFGr4oQ8Sf; Sat, 23 Jul 2022 17:16:01 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Jul 2022 17:16:01 +0200
X-ME-IP: 90.11.190.129
Message-ID: <c522ee04-4183-c2ff-8c35-ce2bbbc1bc95@wanadoo.fr>
Date:   Sat, 23 Jul 2022 17:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
Content-Language: fr
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
Newsgroups: gmane.linux.ports.mips,gmane.linux.drivers.mtd,gmane.linux.kernel.spi.devel,gmane.linux.kernel,gmane.linux.drivers.devicetree
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/07/2022 à 18:48, 周琰杰 (Zhou Yanjie) a écrit :
> Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC
> from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>   drivers/spi/Kconfig           |   9 +
>   drivers/spi/Makefile          |   1 +
>   drivers/spi/spi-ingenic-sfc.c | 662 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 672 insertions(+)
>   create mode 100644 drivers/spi/spi-ingenic-sfc.c
> 

[...]

> +static int ingenic_sfc_probe(struct platform_device *pdev)
> +{
> +	struct ingenic_sfc *sfc;
> +	struct spi_controller *ctlr;
> +	int ret;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sfc));
> +	if (!ctlr)
> +		return -ENOMEM;

devm_spi_alloc_master()? (+ error handling simplification)
Or there should be a .remove() function.

CJ

> +
> +	sfc = spi_controller_get_devdata(ctlr);
> +
> +	sfc->soc_info = of_device_get_match_data(&pdev->dev);
> +	if (!sfc->soc_info) {
> +		dev_err(&pdev->dev, "No of match data provided\n");
> +		ret = -ENODEV;
> +		goto err_put_master;
> +	}
> +

[...]
