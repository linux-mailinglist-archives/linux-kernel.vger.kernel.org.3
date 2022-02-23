Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401724C0770
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiBWBw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiBWBw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:52:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E581141;
        Tue, 22 Feb 2022 17:51:53 -0800 (PST)
X-UUID: 08f0cd9317294c4cabb126ea836f5f00-20220223
X-UUID: 08f0cd9317294c4cabb126ea836f5f00-20220223
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1968855812; Wed, 23 Feb 2022 09:51:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 23 Feb 2022 09:51:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Feb 2022 09:51:44 +0800
Message-ID: <048044adfba3786bd94ec1878832376979fc9513.camel@mediatek.com>
Subject: Re: [PATCH V2 2/6] spi: mediatek: add IPM single mode design support
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Wed, 23 Feb 2022 09:51:44 +0800
In-Reply-To: <3d333da3-82cb-acdd-fba0-d555d94fbfa2@collabora.com>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
         <20220221040717.3729-3-leilk.liu@mediatek.com>
         <3d333da3-82cb-acdd-fba0-d555d94fbfa2@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 11:09 +0100, AngeloGioacchino Del Regno wrote:
> Il 21/02/22 05:07, Leilk Liu ha scritto:
> > this patch add the support of IPM single mode design.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >   drivers/spi/spi-mt65xx.c | 103 +++++++++++++++++++++++++++++++++-
> > -----
> >   1 file changed, 87 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > index bbfeb8046c17..5fa677a589a4 100644
> > --- a/drivers/spi/spi-mt65xx.c
> > +++ b/drivers/spi/spi-mt65xx.c
> > @@ -31,6 +31,7 @@
> >   #define SPI_CFG2_REG                      0x0028
> >   #define SPI_TX_SRC_REG_64                 0x002c
> >   #define SPI_RX_DST_REG_64                 0x0030
> > +#define SPI_CFG3_IPM_REG                  0x0040
> >   
> >   #define SPI_CFG0_SCK_HIGH_OFFSET          0
> >   #define SPI_CFG0_SCK_LOW_OFFSET           8
> > @@ -48,6 +49,7 @@
> >   #define SPI_CFG1_CS_IDLE_MASK             0xff
> >   #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
> >   #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
> > +#define SPI_CFG1_IPM_PACKET_LENGTH_MASK   GENMASK(31, 16)
> >   #define SPI_CFG2_SCK_HIGH_OFFSET          0
> >   #define SPI_CFG2_SCK_LOW_OFFSET           16
> >   
> > @@ -68,7 +70,13 @@
> >   #define SPI_CMD_TX_ENDIAN            BIT(15)
> >   #define SPI_CMD_FINISH_IE            BIT(16)
> >   #define SPI_CMD_PAUSE_IE             BIT(17)
> > +#define SPI_CMD_IPM_NONIDLE_MODE     BIT(19)
> > +#define SPI_CMD_IPM_SPIM_LOOP        BIT(21)
> > +#define SPI_CMD_IPM_GET_TICKDLY_OFFSET    22
> >   
> > +#define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
> > +#define SPI_CFG3_IPM_HALF_DUPLEX_DIR		BIT(2)
> > +#define SPI_CFG3_IPM_HALF_DUPLEX_EN		BIT(3)
> >   #define MT8173_SPI_MAX_PAD_SEL 3
> >   
> >   #define MTK_SPI_PAUSE_INT_STATUS 0x2
> > @@ -78,6 +86,7 @@
> >   
> >   #define MTK_SPI_MAX_FIFO_SIZE 32U
> >   #define MTK_SPI_PACKET_SIZE 1024
> > +#define MTK_SPI_IPM_PACKET_SIZE SZ_64K
> >   #define MTK_SPI_32BITS_MASK  (0xffffffff)
> >   
> >   #define DMA_ADDR_EXT_BITS (36)
> > @@ -93,6 +102,9 @@ struct mtk_spi_compatible {
> >   	bool dma_ext;
> >   	/* some IC no need unprepare SPI clk */
> >   	bool no_need_unprepare;
> > +	/* IPM design improve some single mode features */
> > +	bool ipm_design;
> > +
> >   };
> >   
> >   struct mtk_spi {
> > @@ -116,6 +128,12 @@ static const struct mtk_spi_compatible
> > mt2712_compat = {
> >   	.must_tx = true,
> >   };
> >   
> > +static const struct mtk_spi_compatible ipm_compat_single = {
> > +	.enhance_timing = true,
> > +	.dma_ext = true,
> > +	.ipm_design = true,
> > +};
> > +
> >   static const struct mtk_spi_compatible mt6765_compat = {
> >   	.need_pad_sel = true,
> >   	.must_tx = true,
> > @@ -157,6 +175,9 @@ static const struct mtk_chip_config
> > mtk_default_chip_info = {
> >   };
> >   
> >   static const struct of_device_id mtk_spi_of_match[] = {
> > +	{ .compatible = "mediatek,ipm-spi-single",
> > +		.data = (void *)&ipm_compat_single,
> > +	},
> >   	{ .compatible = "mediatek,mt2701-spi",
> >   		.data = (void *)&mtk_common_compat,
> >   	},
> > @@ -275,12 +296,11 @@ static int mtk_spi_set_hw_cs_timing(struct
> > spi_device *spi)
> >   	return 0;
> >   }
> >   
> > -static int mtk_spi_prepare_message(struct spi_master *master,
> > -				   struct spi_message *msg)
> > +static int mtk_spi_hw_init(struct spi_master *master,
> > +			   struct spi_device *spi)
> >   {
> >   	u16 cpha, cpol;
> >   	u32 reg_val;
> > -	struct spi_device *spi = msg->spi;
> >   	struct mtk_chip_config *chip_config = spi->controller_data;
> >   	struct mtk_spi *mdata = spi_master_get_devdata(master);
> >   
> > @@ -288,6 +308,15 @@ static int mtk_spi_prepare_message(struct
> > spi_master *master,
> >   	cpol = spi->mode & SPI_CPOL ? 1 : 0;
> >   
> >   	reg_val = readl(mdata->base + SPI_CMD_REG);
> > +	if (mdata->dev_comp->ipm_design) {
> > +		/* SPI transfer without idle time until packet length
> > done */
> > +		reg_val |= SPI_CMD_IPM_NONIDLE_MODE;
> > +		if (spi->mode & SPI_LOOP)
> > +			reg_val |= SPI_CMD_IPM_SPIM_LOOP;
> > +		else
> > +			reg_val &= ~SPI_CMD_IPM_SPIM_LOOP;
> > +	}
> > +
> >   	if (cpha)
> >   		reg_val |= SPI_CMD_CPHA;
> >   	else
> > @@ -344,18 +373,33 @@ static int mtk_spi_prepare_message(struct
> > spi_master *master,
> >   		writel(mdata->pad_sel[spi->chip_select],
> >   		       mdata->base + SPI_PAD_SEL_REG);
> >   
> > -	/* tick delay */
> > -	reg_val = readl(mdata->base + SPI_CFG1_REG);
> > -	reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
> > -	reg_val |= ((chip_config->tick_delay & 0x7)
> > -		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
> > -	writel(reg_val, mdata->base + SPI_CFG1_REG);
> 
> Hello Leilk,
> 
> with this change, you are excluding this code from MT2712: is that
> intentional?
> If it is, then this should reside in a different commit with a Fixes
> tag, also explaining the reason for not setting the tick delay on
> that SoC.
It's different for MT2712 and the other ICs for tick delay. I'll send a
patch with fixes tag, thanks

> 
> Also, please don't remove the /* tick delay */ comment.
> 
OK, I'll fix it,thanks

> Regards,
> Angelo
> 
> > +	if (mdata->dev_comp->enhance_timing) {
> > +		if (mdata->dev_comp->ipm_design) {
> > +			reg_val = readl(mdata->base + SPI_CMD_REG);
> > +			reg_val &= ~SPI_CMD_IPM_GET_TICKDLY_MASK;
> > +			reg_val |= ((chip_config->tick_delay & 0x7)
> > +				   << SPI_CMD_IPM_GET_TICKDLY_OFFSET);
> > +			writel(reg_val, mdata->base + SPI_CMD_REG);
> > +		} else {
> > +			reg_val = readl(mdata->base + SPI_CFG1_REG);
> > +			reg_val &= ~SPI_CFG1_GET_TICK_DLY_MASK;
> > +			reg_val |= ((chip_config->tick_delay & 0x7)
> > +				<< SPI_CFG1_GET_TICK_DLY_OFFSET);
> > +			writel(reg_val, mdata->base + SPI_CFG1_REG);
> > +		}
> > +	}
> >   
> >   	/* set hw cs timing */
> >   	mtk_spi_set_hw_cs_timing(spi);
> >   	return 0;
> >   }
> 
> 

