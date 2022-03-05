Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52C54CE394
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 09:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiCEIXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 03:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCEIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 03:23:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F258221BB5;
        Sat,  5 Mar 2022 00:22:15 -0800 (PST)
X-UUID: 3f0045f906424d1d869dd924349f3313-20220305
X-UUID: 3f0045f906424d1d869dd924349f3313-20220305
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 754612243; Sat, 05 Mar 2022 16:22:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Mar 2022 16:22:04 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Mar 2022 16:22:04 +0800
Message-ID: <88c09cbb11c76e17ce78376103d17ac408f3cfd5.camel@mediatek.com>
Subject: Re: [PATCH V2 4/6] spi: mediatek: add spi memory support
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Sat, 5 Mar 2022 16:22:04 +0800
In-Reply-To: <2c1a0925aeb1f3ba640a29e0f6f9765eb609293b.camel@mediatek.com>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
         <20220221040717.3729-5-leilk.liu@mediatek.com>
         <2e994be0-8b60-a3dc-2ab7-34d93192dc09@collabora.com>
         <2c1a0925aeb1f3ba640a29e0f6f9765eb609293b.camel@mediatek.com>
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

On Wed, 2022-02-23 at 09:59 +0800, Leilk Liu wrote:
> On Tue, 2022-02-22 at 11:49 +0100, AngeloGioacchino Del Regno wrote:
> > Il 21/02/22 05:07, Leilk Liu ha scritto:
> > > this patch add the support of spi-mem.
> > > 
> > > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > > ---
> > >   drivers/spi/spi-mt65xx.c | 310
> > > ++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 309 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > > index 5fa677a589a4..852fc008329a 100644
> > > --- a/drivers/spi/spi-mt65xx.c
> > > +++ b/drivers/spi/spi-mt65xx.c
> > > @@ -17,6 +17,7 @@
> > >   #include <linux/platform_data/spi-mt65xx.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/spi/spi.h>
> > > +#include <linux/spi/spi-mem.h>
> > >   #include <linux/dma-mapping.h>
> > >   
> > >   #define SPI_CFG0_REG                      0x0000
> > > @@ -75,8 +76,21 @@
> > >   #define SPI_CMD_IPM_GET_TICKDLY_OFFSET    22
> > >   
> > >   #define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
> > > +
> > > +#define PIN_MODE_CFG(x)	((x) / 2)
> > > +
> > > +#define SPI_CFG3_IPM_PIN_MODE_OFFSET		0
> > >   #define SPI_CFG3_IPM_HALF_DUPLEX_DIR		BIT(2)
> > >   #define SPI_CFG3_IPM_HALF_DUPLEX_EN		BIT(3)
> > > +#define SPI_CFG3_IPM_XMODE_EN			BIT(4)
> > > +#define SPI_CFG3_IPM_NODATA_FLAG		BIT(5)
> > > +#define SPI_CFG3_IPM_CMD_BYTELEN_OFFSET		8
> > > +#define SPI_CFG3_IPM_ADDR_BYTELEN_OFFSET	12
> > > +
> > > +#define SPI_CFG3_IPM_CMD_PIN_MODE_MASK		GENMASK(1, 0)
> > > +#define SPI_CFG3_IPM_CMD_BYTELEN_MASK		GENMASK(11, 8)
> > > +#define SPI_CFG3_IPM_ADDR_BYTELEN_MASK		GENMASK(15, 12)
> > > +
> > >   #define MT8173_SPI_MAX_PAD_SEL 3
> > >   
> > >   #define MTK_SPI_PAUSE_INT_STATUS 0x2
> > > @@ -87,6 +101,8 @@
> > >   #define MTK_SPI_MAX_FIFO_SIZE 32U
> > >   #define MTK_SPI_PACKET_SIZE 1024
> > >   #define MTK_SPI_IPM_PACKET_SIZE SZ_64K
> > > +#define MTK_SPI_IPM_PACKET_LOOP SZ_256
> > > +
> > >   #define MTK_SPI_32BITS_MASK  (0xffffffff)
> > >   
> > >   #define DMA_ADDR_EXT_BITS (36)
> > > @@ -104,7 +120,8 @@ struct mtk_spi_compatible {
> > >   	bool no_need_unprepare;
> > >   	/* IPM design improve some single mode features */
> > >   	bool ipm_design;
> > > -
> > > +	/* IPM design that support quad mode */
> > > +	bool support_quad;
> > >   };
> > >   
> > >   struct mtk_spi {
> > > @@ -120,6 +137,11 @@ struct mtk_spi {
> > >   	u32 tx_sgl_len, rx_sgl_len;
> > >   	const struct mtk_spi_compatible *dev_comp;
> > >   	u32 spi_clk_hz;
> > > +	struct completion spimem_done;
> > > +	bool use_spimem;
> > > +	struct device *dev;
> > > +	dma_addr_t tx_dma;
> > > +	dma_addr_t rx_dma;
> > >   };
> > >   
> > >   static const struct mtk_spi_compatible mtk_common_compat;
> > > @@ -134,6 +156,13 @@ static const struct mtk_spi_compatible
> > > ipm_compat_single = {
> > >   	.ipm_design = true,
> > >   };
> > >   
> > > +static const struct mtk_spi_compatible ipm_compat_quad = {
> > > +	.enhance_timing = true,
> > > +	.dma_ext = true,
> > > +	.ipm_design = true,
> > > +	.support_quad = true,
> > > +};
> > > +
> > >   static const struct mtk_spi_compatible mt6765_compat = {
> > >   	.need_pad_sel = true,
> > >   	.must_tx = true,
> > > @@ -178,6 +207,9 @@ static const struct of_device_id
> > > mtk_spi_of_match[] = {
> > >   	{ .compatible = "mediatek,ipm-spi-single",
> > >   		.data = (void *)&ipm_compat_single,
> > >   	},
> > > +	{ .compatible = "mediatek,ipm-spi-quad",
> > > +		.data = (void *)&ipm_compat_quad,
> > > +	},
> > >   	{ .compatible = "mediatek,mt2701-spi",
> > >   		.data = (void *)&mtk_common_compat,
> > >   	},
> > > @@ -694,6 +726,13 @@ static irqreturn_t mtk_spi_interrupt(int
> > > irq,
> > > void *dev_id)
> > >   	else
> > >   		mdata->state = MTK_SPI_IDLE;
> > >   
> > > +	/* SPI-MEM ops */
> > > +	if (mdata->use_spimem) {
> > > +		complete(&mdata->spimem_done);
> > > +
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > 
> > I would instead make a new ISR for the SPI-MEM case... as you're
> > bypassing the
> > entire mtk_spi_interrupt() function like that.
> > 
> > Example:
> > 
> > static void mtk_spi_check_and_set_state(struct mtk_spi *mdata)
> > {
> > 	u32 reg_val;
> > 
> > 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
> > 
> > 	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
> > 
> > 		mdata->state = MTK_SPI_PAUSED;
> > 
> > 	else
> > 
> > 		mdata->state = MTK_SPI_IDLE;
> > }
> > 
> > static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
> > 
> > {
> > 	u32 cmd, reg_val, cnt, remainder, len;
> > 
> > 	struct spi_master *master = dev_id;
> > 
> > 	struct mtk_spi *mdata = spi_master_get_devdata(master);
> > 
> > 	struct spi_transfer *trans = mdata->cur_transfer;
> > 
> > 	mtk_spi_check_and_set_state(mdata);
> > 
> > 	if (!master->can_dma(........
> > 	.... blurb...
> > }
> > 
> > static irqreturn_t mtk_spimem_interrupt(int irq, void *dev_id)
> > {
> > 	struct spi_master *master = dev_id;
> > 
> > 	struct mtk_spi *mdata = spi_master_get_devdata(master);
> > 
> > 	mtk_spi_check_and_set_state(mdata);
> > 	complete(&mdata->spimem_done);
> > 
> > 	return IRQ_HANDLED;
> > }
> > 
> > ... of course, in mtk_spi_probe(), you would do something like
> > 
> > if (mdata->use_spimem)
> > 	ret = devm_request_irq(&pdev->dev, irq, mtk_spimem_interrupt,
> > 		...... blah ......
> > else
> > 	ret = devm_request_irq(&pdev->dev, irq, mtk_spi_interrupt,
> > 		..... blah ......
> > 
> > This way, you're separating the two - increasing human readability
> > and showing
> > the simplifications (in that regard) in the IPM IP's SPI-MEM
> > handling.
> > 
> 
> thanks for your advise, I'll do it in the next version.
Hi AngeloGioacchino,
 It can't request mtk_spimem_interrupt() only while support spimem
core, since spi driver should support spi_sync and spi_mem_exec_op
both.

> 
> > >   	if (!master->can_dma(master, NULL, trans)) {
> > >   		if (trans->rx_buf) {
> > >   			cnt = mdata->xfer_len / 4;
> > > @@ -777,6 +816,266 @@ static irqreturn_t mtk_spi_interrupt(int
> > > irq,
> > > void *dev_id)
> > >   	return IRQ_HANDLED;
> > >   }
> > >   
> > > +static int mtk_spi_mem_adjust_op_size(struct spi_mem *mem,
> > > +				      struct spi_mem_op *op)
> > > +{
> > > +	int opcode_len;
> > > +
> > > +	if (op->data.dir != SPI_MEM_NO_DATA) {
> > > +		opcode_len = 1 + op->addr.nbytes + op->dummy.nbytes;
> > > +		if (opcode_len + op->data.nbytes >
> > > MTK_SPI_IPM_PACKET_SIZE) {
> > > +			op->data.nbytes = MTK_SPI_IPM_PACKET_SIZE -
> > > opcode_len;
> > > +			/* force data buffer dma-aligned. */
> > > +			op->data.nbytes -= op->data.nbytes % 4;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static bool mtk_spi_mem_supports_op(struct spi_mem *mem,
> > > +				    const struct spi_mem_op *op)
> > > +{
> > > +	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
> > > +	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4)
> > > +		return false;
> > > +
> > > +	if (op->addr.nbytes && op->dummy.nbytes &&
> > > +	    op->addr.buswidth != op->dummy.buswidth)
> > > +		return false;
> > > +
> > > +	if (op->addr.nbytes + op->dummy.nbytes > 16)
> > > +		return false;
> > > +
> > > +	if (op->data.nbytes > MTK_SPI_IPM_PACKET_SIZE) {
> > > +		if (op->data.nbytes / MTK_SPI_IPM_PACKET_SIZE >
> > > +		    MTK_SPI_IPM_PACKET_LOOP ||
> > > +		    op->data.nbytes % MTK_SPI_IPM_PACKET_SIZE != 0)
> > > +			return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +static void mtk_spi_mem_setup_dma_xfer(struct spi_master
> > > *master,
> > > +				       const struct spi_mem_op *op)
> > > +{
> > > +	struct mtk_spi *mdata = spi_master_get_devdata(master);
> > > +
> > > +	writel((u32)(mdata->tx_dma & MTK_SPI_32BITS_MASK),
> > > +	       mdata->base + SPI_TX_SRC_REG);
> > > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > > +	if (mdata->dev_comp->dma_ext)
> > > +		writel((u32)(mdata->tx_dma >> 32),
> > > +		       mdata->base + SPI_TX_SRC_REG_64);
> > > +#endif
> > > +
> > > +	if (op->data.dir == SPI_MEM_DATA_IN) {
> > > +		writel((u32)(mdata->rx_dma & MTK_SPI_32BITS_MASK),
> > > +		       mdata->base + SPI_RX_DST_REG);
> > > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > > +		if (mdata->dev_comp->dma_ext)
> > > +			writel((u32)(mdata->rx_dma >> 32),
> > > +			       mdata->base + SPI_RX_DST_REG_64);
> > > +#endif
> > > +	}
> > > +}
> > > +
> > > +static int mtk_spi_transfer_wait(struct spi_mem *mem,
> > > +				 const struct spi_mem_op *op)
> > > +{
> > > +	struct mtk_spi *mdata = spi_master_get_devdata(mem->spi-
> > > > master);
> > > 
> > > +	unsigned long long ms = 1;
> > 
> > Initializing ms to 1 here is useless, as you're anyway
> > reinitializing
> > it
> > right after. I would do it as following:
> > 
> > u64 ms = 8000LL;
> > 
> > if (op->data.dir == SPI_MEM_NO_DATA)
> > 	ms *= 32;
> > else
> > 	ms *= op->data.nbytes;
> > 
> 
> OK,I'll fix it.
> 
> > Besides, can you please add a comment to the code explaining why
> > the
> > reason for the waits (why 8, why 1000, why 32)?
> > 
> 
> OK,THANKS
> 
> > > +
> > > +	if (op->data.dir == SPI_MEM_NO_DATA)
> > > +		ms = 8LL * 1000LL * 32;
> > > +	else
> > > +		ms = 8LL * 1000LL * op->data.nbytes;
> > > +	do_div(ms, mem->spi->max_speed_hz);
> > 
> > I appreciate the usage of safe division helpers, but this is the
> > wrong one:
> > you have a unsigned long long (64-bits) dividend and a u32 divisor,
> > so the
> > right function to use here is div_u64().
> > 
> 
> OK, I'll fix it. thanks!
> 
> > 	ms = div_u64(ms, mem->spi->max_speed_hz);
> > 
> > > +	ms += ms + 1000; /* 1s tolerance */
> > > +
> > > +	if (ms > UINT_MAX)
> > > +		ms = UINT_MAX;
> > > +
> > > +	if (!wait_for_completion_timeout(&mdata->spimem_done,
> > > +					 msecs_to_jiffies(ms))) {
> > > +		dev_err(mdata->dev, "spi-mem transfer timeout\n");
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mtk_spi_mem_exec_op(struct spi_mem *mem,
> > > +			       const struct spi_mem_op *op)
> > > +{
> > > +	struct mtk_spi *mdata = spi_master_get_devdata(mem->spi-
> > > > master);
> > > 
> > > +	u32 reg_val, nio = 1, tx_size;
> > > +	char *tx_tmp_buf, *rx_tmp_buf;
> > > +	int ret = 0;
> > > +
> > > +	mdata->use_spimem = true;
> > > +	reinit_completion(&mdata->spimem_done);
> > > +
> > > +	mtk_spi_reset(mdata);
> > > +	mtk_spi_hw_init(mem->spi->master, mem->spi);
> > > +	mtk_spi_prepare_transfer(mem->spi->master, mem->spi-
> > > > max_speed_hz);
> > > 
> > > +
> > > +	reg_val = readl(mdata->base + SPI_CFG3_IPM_REG);
> > > +	/* opcode byte len */
> > > +	reg_val &= ~SPI_CFG3_IPM_CMD_BYTELEN_MASK;
> > > +	reg_val |= 1 << SPI_CFG3_IPM_CMD_BYTELEN_OFFSET;
> > > +
> > > +	/* addr & dummy byte len */
> > > +	reg_val &= ~SPI_CFG3_IPM_ADDR_BYTELEN_MASK;
> > > +	if (op->addr.nbytes || op->dummy.nbytes)
> > > +		reg_val |= (op->addr.nbytes + op->dummy.nbytes) <<
> > > +			    SPI_CFG3_IPM_ADDR_BYTELEN_OFFSET;
> > > +
> > > +	/* data byte len */
> > > +	if (op->data.dir == SPI_MEM_NO_DATA) {
> > > +		reg_val |= SPI_CFG3_IPM_NODATA_FLAG;
> > > +		writel(0, mdata->base + SPI_CFG1_REG);
> > > +	} else {
> > > +		reg_val &= ~SPI_CFG3_IPM_NODATA_FLAG;
> > > +		mdata->xfer_len = op->data.nbytes;
> > > +		mtk_spi_setup_packet(mem->spi->master);
> > > +	}
> > > +
> > > +	if (op->addr.nbytes || op->dummy.nbytes) {
> > > +		if (op->addr.buswidth == 1 || op->dummy.buswidth == 1)
> > > +			reg_val |= SPI_CFG3_IPM_XMODE_EN;
> > > +		else
> > > +			reg_val &= ~SPI_CFG3_IPM_XMODE_EN;
> > > +	}
> > > +
> > > +	if (op->addr.buswidth == 2 ||
> > > +	    op->dummy.buswidth == 2 ||
> > > +	    op->data.buswidth == 2)
> > > +		nio = 2;
> > > +	else if (op->addr.buswidth == 4 ||
> > > +		 op->dummy.buswidth == 4 ||
> > > +		 op->data.buswidth == 4)
> > > +		nio = 4;
> > 
> > 	else
> > 		nio = 1;
> > 
> > ...so that you can avoid double initialization of the `nio`
> > variable.
> > 
> 
> OK, I'll fix it,thanks
> 
> > > +
> > > +	reg_val &= ~SPI_CFG3_IPM_CMD_PIN_MODE_MASK;
> > > +	reg_val |= PIN_MODE_CFG(nio) << SPI_CFG3_IPM_PIN_MODE_OFFSET;
> > > +
> > 
> > Regards,
> > Angelo
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

