Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0474B4CFC44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiCGLIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241931AbiCGLH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:07:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24DC7E4A;
        Mon,  7 Mar 2022 02:29:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 084031F43910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646648933;
        bh=ubDDcRsBY8hq/HNKN5ZLqctS0m6TTgeM8kkuJN+7rnc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZdPjxL42/EtC95u2ilJLnDzPsXUhoYOFYNkaY7fGA/B2/0HBqe2Q1z753afQCHUAP
         RkiN62wI3E8VgdttdBbUQ6nDVw07t6yXSTMpZFGsdwTUDz1y5yEHp9oFDzOfYQLhH/
         G/04KIL5SQeoNqTIG6Ddpj0TxF2wB7tsaZ0TYvMso4tyMm+NXdd0AtNLvcuhaxc/5H
         SP8YGbkghTj89WYp+Z4CA/k0k0rxHGj0cbZMrvdIYvmOlvia2jGA9iXmTenFI8hkzL
         OUcLovkKNlEp6M8I4df66UKXFFyTJt3RNYXoBoI3wWMahuBHvZemGw7Z0iZ8TohTyM
         MvE+xknEW/DxA==
Message-ID: <bb705a6b-282d-5f9e-9231-036329cca5ef@collabora.com>
Date:   Mon, 7 Mar 2022 11:28:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V3 1/7] spi: mediatek: support tick_delay without
 enhance_timing
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220307065230.12655-1-leilk.liu@mediatek.com>
 <20220307065230.12655-2-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220307065230.12655-2-leilk.liu@mediatek.com>
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

Il 07/03/22 07:52, Leilk Liu ha scritto:
> this patch support tick_delay bit[31:30] without enhance_timing feature.
> 
> Fixes: f84d866ab43f("spi: mediatek: add tick_delay support")
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/spi/spi-mt65xx.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index bbfeb8046c17..3fd89548ec3c 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -43,8 +43,11 @@
>   #define SPI_CFG1_PACKET_LOOP_OFFSET       8
>   #define SPI_CFG1_PACKET_LENGTH_OFFSET     16
>   #define SPI_CFG1_GET_TICK_DLY_OFFSET      29
> +#define SPI_CFG1_GET_TICK_DLY_OFFSET_V1   30
>   
>   #define SPI_CFG1_GET_TICK_DLY_MASK        0xe0000000
> +#define SPI_CFG1_GET_TICK_DLY_MASK_V1     0xc0000000
> +
>   #define SPI_CFG1_CS_IDLE_MASK             0xff
>   #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
>   #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
> @@ -346,9 +349,15 @@ static int mtk_spi_prepare_message(struct spi_master *master,
>   
>   	/* tick delay */
>   	reg_val = readl(mdata->base + SPI_CFG1_REG);
> -	reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
> -	reg_val |= ((chip_config->tick_delay & 0x7)
> -		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
> +	if (mdata->dev_comp->enhance_timing) {
> +		reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
> +		reg_val |= ((chip_config->tick_delay & 0x7)
> +			    << SPI_CFG1_GET_TICK_DLY_OFFSET);
> +	} else {
> +		reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK_V1;
> +		reg_val |= ((chip_config->tick_delay & 0x3)
> +			    << SPI_CFG1_GET_TICK_DLY_OFFSET_V1);
> +	}
>   	writel(reg_val, mdata->base + SPI_CFG1_REG);
>   
>   	/* set hw cs timing */
