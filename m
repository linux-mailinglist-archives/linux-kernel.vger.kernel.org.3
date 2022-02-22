Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E24BF57F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiBVKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiBVKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:09:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE11C935;
        Tue, 22 Feb 2022 02:09:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DAA191F442C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645524562;
        bh=JxbXr9ACueoKHRqZRjfnrevBI7Jf+2vW88nX1Uz2Uiw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RiFfI5jInD+h90OnlAlKkj5f+sczBcQFJNBi9knbaDNKGUg2IgKrCVVelakbbbCt8
         XgqWi16ODlh84vZmd1BEyWnPlKEkBtvctlyI14Pp6M0M+IY0gQZqhR20Em5c8ITtPp
         NSoDxEHm2gVh6N8X6XYVRwvkupWYTf5C6oJstHt7/c/RsI6nynCoH2pn1gE3CioSTS
         IBLlT7Pm3/2VZcFdR8ZD00LaEIlB0j8Qn961vdiZgW0cjiWhG49eIZrvEPoKePdIF9
         vFlzkYKkrtRMD6mZ1PyOCQqNEjAoLKAKUifrz4qQRzyBDQF/d95Dzjtn6LiKnSRS9x
         lDfbuzkKxCRDg==
Message-ID: <3d333da3-82cb-acdd-fba0-d555d94fbfa2@collabora.com>
Date:   Tue, 22 Feb 2022 11:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V2 2/6] spi: mediatek: add IPM single mode design support
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
 <20220221040717.3729-3-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220221040717.3729-3-leilk.liu@mediatek.com>
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

Il 21/02/22 05:07, Leilk Liu ha scritto:
> this patch add the support of IPM single mode design.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c | 103 +++++++++++++++++++++++++++++++++------
>   1 file changed, 87 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index bbfeb8046c17..5fa677a589a4 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -31,6 +31,7 @@
>   #define SPI_CFG2_REG                      0x0028
>   #define SPI_TX_SRC_REG_64                 0x002c
>   #define SPI_RX_DST_REG_64                 0x0030
> +#define SPI_CFG3_IPM_REG                  0x0040
>   
>   #define SPI_CFG0_SCK_HIGH_OFFSET          0
>   #define SPI_CFG0_SCK_LOW_OFFSET           8
> @@ -48,6 +49,7 @@
>   #define SPI_CFG1_CS_IDLE_MASK             0xff
>   #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
>   #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
> +#define SPI_CFG1_IPM_PACKET_LENGTH_MASK   GENMASK(31, 16)
>   #define SPI_CFG2_SCK_HIGH_OFFSET          0
>   #define SPI_CFG2_SCK_LOW_OFFSET           16
>   
> @@ -68,7 +70,13 @@
>   #define SPI_CMD_TX_ENDIAN            BIT(15)
>   #define SPI_CMD_FINISH_IE            BIT(16)
>   #define SPI_CMD_PAUSE_IE             BIT(17)
> +#define SPI_CMD_IPM_NONIDLE_MODE     BIT(19)
> +#define SPI_CMD_IPM_SPIM_LOOP        BIT(21)
> +#define SPI_CMD_IPM_GET_TICKDLY_OFFSET    22
>   
> +#define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
> +#define SPI_CFG3_IPM_HALF_DUPLEX_DIR		BIT(2)
> +#define SPI_CFG3_IPM_HALF_DUPLEX_EN		BIT(3)
>   #define MT8173_SPI_MAX_PAD_SEL 3
>   
>   #define MTK_SPI_PAUSE_INT_STATUS 0x2
> @@ -78,6 +86,7 @@
>   
>   #define MTK_SPI_MAX_FIFO_SIZE 32U
>   #define MTK_SPI_PACKET_SIZE 1024
> +#define MTK_SPI_IPM_PACKET_SIZE SZ_64K
>   #define MTK_SPI_32BITS_MASK  (0xffffffff)
>   
>   #define DMA_ADDR_EXT_BITS (36)
> @@ -93,6 +102,9 @@ struct mtk_spi_compatible {
>   	bool dma_ext;
>   	/* some IC no need unprepare SPI clk */
>   	bool no_need_unprepare;
> +	/* IPM design improve some single mode features */
> +	bool ipm_design;
> +
>   };
>   
>   struct mtk_spi {
> @@ -116,6 +128,12 @@ static const struct mtk_spi_compatible mt2712_compat = {
>   	.must_tx = true,
>   };
>   
> +static const struct mtk_spi_compatible ipm_compat_single = {
> +	.enhance_timing = true,
> +	.dma_ext = true,
> +	.ipm_design = true,
> +};
> +
>   static const struct mtk_spi_compatible mt6765_compat = {
>   	.need_pad_sel = true,
>   	.must_tx = true,
> @@ -157,6 +175,9 @@ static const struct mtk_chip_config mtk_default_chip_info = {
>   };
>   
>   static const struct of_device_id mtk_spi_of_match[] = {
> +	{ .compatible = "mediatek,ipm-spi-single",
> +		.data = (void *)&ipm_compat_single,
> +	},
>   	{ .compatible = "mediatek,mt2701-spi",
>   		.data = (void *)&mtk_common_compat,
>   	},
> @@ -275,12 +296,11 @@ static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
>   	return 0;
>   }
>   
> -static int mtk_spi_prepare_message(struct spi_master *master,
> -				   struct spi_message *msg)
> +static int mtk_spi_hw_init(struct spi_master *master,
> +			   struct spi_device *spi)
>   {
>   	u16 cpha, cpol;
>   	u32 reg_val;
> -	struct spi_device *spi = msg->spi;
>   	struct mtk_chip_config *chip_config = spi->controller_data;
>   	struct mtk_spi *mdata = spi_master_get_devdata(master);
>   
> @@ -288,6 +308,15 @@ static int mtk_spi_prepare_message(struct spi_master *master,
>   	cpol = spi->mode & SPI_CPOL ? 1 : 0;
>   
>   	reg_val = readl(mdata->base + SPI_CMD_REG);
> +	if (mdata->dev_comp->ipm_design) {
> +		/* SPI transfer without idle time until packet length done */
> +		reg_val |= SPI_CMD_IPM_NONIDLE_MODE;
> +		if (spi->mode & SPI_LOOP)
> +			reg_val |= SPI_CMD_IPM_SPIM_LOOP;
> +		else
> +			reg_val &= ~SPI_CMD_IPM_SPIM_LOOP;
> +	}
> +
>   	if (cpha)
>   		reg_val |= SPI_CMD_CPHA;
>   	else
> @@ -344,18 +373,33 @@ static int mtk_spi_prepare_message(struct spi_master *master,
>   		writel(mdata->pad_sel[spi->chip_select],
>   		       mdata->base + SPI_PAD_SEL_REG);
>   
> -	/* tick delay */
> -	reg_val = readl(mdata->base + SPI_CFG1_REG);
> -	reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
> -	reg_val |= ((chip_config->tick_delay & 0x7)
> -		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
> -	writel(reg_val, mdata->base + SPI_CFG1_REG);

Hello Leilk,

with this change, you are excluding this code from MT2712: is that
intentional?
If it is, then this should reside in a different commit with a Fixes
tag, also explaining the reason for not setting the tick delay on
that SoC.

Also, please don't remove the /* tick delay */ comment.

Regards,
Angelo

> +	if (mdata->dev_comp->enhance_timing) {
> +		if (mdata->dev_comp->ipm_design) {
> +			reg_val = readl(mdata->base + SPI_CMD_REG);
> +			reg_val &= ~SPI_CMD_IPM_GET_TICKDLY_MASK;
> +			reg_val |= ((chip_config->tick_delay & 0x7)
> +				   << SPI_CMD_IPM_GET_TICKDLY_OFFSET);
> +			writel(reg_val, mdata->base + SPI_CMD_REG);
> +		} else {
> +			reg_val = readl(mdata->base + SPI_CFG1_REG);
> +			reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
> +			reg_val |= ((chip_config->tick_delay & 0x7)
> +				<< SPI_CFG1_GET_TICK_DLY_OFFSET);
> +			writel(reg_val, mdata->base + SPI_CFG1_REG);
> +		}
> +	}
>   
>   	/* set hw cs timing */
>   	mtk_spi_set_hw_cs_timing(spi);
>   	return 0;
>   }

