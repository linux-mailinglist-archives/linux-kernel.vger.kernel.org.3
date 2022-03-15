Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB34D97B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346642AbiCOJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346640AbiCOJdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:33:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FD04ECFF;
        Tue, 15 Mar 2022 02:32:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 57BBF1F43621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647336720;
        bh=QE/YbRmb8tZucb45FCoOsfQ+iIuuTe3bEnOlGJc219M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PwTm2ystHVQqrE7oJkq3lebCs09xm0AIRE5RM3D3XtTSMfacCKD+Z7RYNEeGbvZTk
         A/DPtUD7N32kEAAFoDsKy1D9dyBsyV7uVQNWkYNKH2AfR6WUnWypyRxTm8ceVPPYQZ
         G+gfOWjmy1xSoSXxgA1F3eIQH2nkuKq+GTyeMkGAWEdiq7ig4uavwS223BnIIYH9/u
         uFvAIB2C2QHzaXIy47HKbu5dAG3Y5NimtTbipf3E+Ku1PjHMmbO9Fs80ccMIkPi5gu
         WnU8IV92fOPqUkZ3xnR40U2mC40cZjGdX3xPNAnilVEJ11/dyw1gihQ7lJDR99ZI2A
         vjGHGzR3lV7PA==
Message-ID: <b237c1fe-9ddd-0a2e-ecf2-05bfb984c5dd@collabora.com>
Date:   Tue, 15 Mar 2022 10:31:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V4 4/6] spi: mediatek: add spi memory support for ipm
 design
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
 <20220315032411.2826-5-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315032411.2826-5-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/22 04:24, Leilk Liu ha scritto:
> this patch add the support of spi-mem for ipm design.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c | 349 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 348 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 1a0b3208dfca..8958c3fa4fea 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c

...snip...

> +
> +static void of_mtk_spi_parse_dt(struct spi_master *master, struct device_node *nc)
> +{
> +	struct mtk_spi *mdata = spi_master_get_devdata(master);
> +	u32 value;
> +
> +	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {

Hello Leilk,

thanks for considering my advice about "spi-{tx,rx}-bus-width", but there's
something that you have misunderstood about it.

Simply, you don't need this function at all. Whatever you are doing here is
already being performed in the Linux SPI framework: at the end of the probe
function, this driver is calling the (legacy) devm_spi_register_master(),
which calls devm_spi_register_controller().

In drivers/spi/spi.c, function spi_register_controller(), will in turn call
of_register_spi_devices(ctlr) -> of_register_spi_device(ctlr, nc)... that
will end up finally calling function of_spi_parse_dt(ctlr, spi, nc).

The last mentioned function already contains the logic and setup to check
devicetree properties "spi-tx-bus-width" and "spi-rx-bus-width" (and some
others, as well).

This means that spi-mt65xx.c already probed these even before your IPM
implementation, hence ***function of_mtk_spi_parse_dt() is not needed***.

Simply drop it and don't check for these properties: that's already done.


Regards,
Angelo

> +		switch (value) {
> +		case 1:
> +			break;
> +		case 2:
> +			master->mode_bits |= SPI_TX_DUAL;
> +			break;
> +		case 4:
> +			master->mode_bits |= SPI_TX_QUAD;
> +			break;
> +		default:
> +			dev_warn(mdata->dev,
> +				 "spi-tx-bus-width %d not supported\n",
> +				value);
> +			break;
> +		}
> +	}
> +
> +	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
> +		switch (value) {
> +		case 1:
> +			break;
> +		case 2:
> +			master->mode_bits |= SPI_RX_DUAL;
> +			break;
> +		case 4:
> +			master->mode_bits |= SPI_RX_QUAD;
> +			break;
> +		case 8:
> +			master->mode_bits |= SPI_RX_OCTAL;
> +			break;
> +		default:
> +			dev_warn(mdata->dev,
> +				 "spi-rx-bus-width %d not supported\n",
> +				value);
> +			break;
> +		}
> +	}
> +}
> +
>   static int mtk_spi_probe(struct platform_device *pdev)
>   {
>   	struct spi_master *master;
> @@ -830,6 +1170,13 @@ static int mtk_spi_probe(struct platform_device *pdev)
>   	if (mdata->dev_comp->ipm_design)
>   		master->mode_bits |= SPI_LOOP;
>   
> +	if (mdata->dev_comp->ipm_design) {
> +		mdata->dev = &pdev->dev;
> +		master->mem_ops = &mtk_spi_mem_ops;
> +		of_mtk_spi_parse_dt(master, pdev->dev.of_node);
> +		init_completion(&mdata->spimem_done);
> +	}
> +
>   	if (mdata->dev_comp->need_pad_sel) {
>   		mdata->pad_num = of_property_count_u32_elems(
>   			pdev->dev.of_node,
