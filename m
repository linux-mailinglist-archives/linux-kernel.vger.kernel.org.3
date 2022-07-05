Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFCD567009
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiGENz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGENzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:55:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5739526111;
        Tue,  5 Jul 2022 06:36:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 606E166017ED;
        Tue,  5 Jul 2022 14:36:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657028198;
        bh=MMAIKfIlvMstdET+wRsyi4fUW3MunCrNX2414UwQPPg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VQxrkYI9vMJx7WXdp6vo47VkS6KfiUMdRHp51GzjLkJMhBq91peUvURdCodFuYnQm
         w+0G+4nRzWUPtcjz4W6SX1QLkZMlp4U/hlU0bX/iBuzYUrZwxRHkEXUnWWRhQJ55Dp
         5E1n2PrFbmpPJQq9xIFFTzUT1tz7hISXe9A1mkZL2QPqJBEoByRWvpK1GjFxFOCtsS
         QYuC0rnn1p4b5lM1mEL0OLU8nlmdnMBBaALbY+HJ3yvkt9WgwLMRzngcoNjPouJqsm
         YO0qto9xV+IXNZmiXJEwMJigIa8OVbjphTLTrHDQShyct8O6v9oxxgmJSuXR+Ai+YU
         W8207CDB+HWoA==
Message-ID: <2248d7b1-7986-26f8-044f-d4d7a5eb478d@collabora.com>
Date:   Tue, 5 Jul 2022 15:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PV4,3/8] media: mtk-jpegdec: manage jpegdec multi-hardware
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
References: <20220627025540.8901-1-irui.wang@mediatek.com>
 <20220627025540.8901-4-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220627025540.8901-4-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/06/22 04:55, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> manage each hardware information, including irq/clk/power.
> the hardware includes HW0/HW1/HW2.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>   drivers/media/platform/mediatek/jpeg/Makefile |   5 +-
>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  25 ++-
>   .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  38 ++++
>   .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 168 ++++++++++++++++++
>   4 files changed, 232 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/Makefile b/drivers/media/platform/mediatek/jpeg/Makefile
> index 69703db4b0a5..26e84852523e 100644
> --- a/drivers/media/platform/mediatek/jpeg/Makefile
> +++ b/drivers/media/platform/mediatek/jpeg/Makefile
> @@ -1,9 +1,10 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) += mtk_jpeg.o \
> -	mtk-jpeg-enc-hw.o
> +	mtk-jpeg-enc-hw.o \
> +	mtk-jpeg-dec-hw.o
>   
>   mtk_jpeg-y := mtk_jpeg_core.o \
> -		 mtk_jpeg_dec_hw.o \
>   		 mtk_jpeg_dec_parse.o
>   
>   mtk-jpeg-enc-hw-y := mtk_jpeg_enc_hw.o
> +mtk-jpeg-dec-hw-y := mtk_jpeg_dec_hw.o
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 2696651b457b..5683df94ac6a 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1467,8 +1467,14 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   	jpeg->variant = of_device_get_match_data(jpeg->dev);
>   
>   	if (of_property_read_bool(pdev->dev.of_node,
> -				  "mediatek,jpegenc-multi-core")) {
> +				  "mediatek,jpegenc-multi-core"))
>   		jpeg->is_jpgenc_multihw = true;
> +
> +	if (of_property_read_bool(pdev->dev.of_node,
> +				  "mediatek,jpegdec-multi-core"))
> +		jpeg->is_jpgdec_multihw = true;
> +
> +	if (jpeg->is_jpgenc_multihw || jpeg->is_jpgdec_multihw) {
>   		ret = devm_of_platform_populate(&pdev->dev);
>   		if (ret) {
>   			v4l2_err(&jpeg->v4l2_dev, "Master of platform populate failed.");
> @@ -1476,7 +1482,7 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	if (!jpeg->is_jpgenc_multihw) {
> +	if (!jpeg->is_jpgenc_multihw || jpeg->is_jpgdec_multihw) {


That's never going to work. I'm sure that you were meaning:

	if (!jpeg->is_jpgenc_multihw && !jpeg->is_jpgdec_multihw) {



>   		INIT_DELAYED_WORK(&jpeg->job_timeout_work,
>   				  mtk_jpeg_job_timeout_work);
>   
> @@ -1693,6 +1699,17 @@ static const struct mtk_jpeg_variant mtk8195_jpegenc_drvdata = {
>   	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
>   };
>   
> +static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
> +	.formats = mtk_jpeg_dec_formats,
> +	.num_formats = MTK_JPEG_DEC_NUM_FORMATS,
> +	.qops = &mtk_jpeg_dec_qops,
> +	.m2m_ops = &mtk_jpeg_dec_m2m_ops,
> +	.dev_name = "mtk-jpeg-dec",
> +	.ioctl_ops = &mtk_jpeg_dec_ioctl_ops,
> +	.out_q_default_fourcc = V4L2_PIX_FMT_JPEG,
> +	.cap_q_default_fourcc = V4L2_PIX_FMT_YUV420M,
> +};
> +
>   #if defined(CONFIG_OF)
>   static const struct of_device_id mtk_jpeg_match[] = {
>   	{
> @@ -1711,6 +1728,10 @@ static const struct of_device_id mtk_jpeg_match[] = {
>   		.compatible = "mediatek,mt8195-jpgenc",
>   		.data = &mtk8195_jpegenc_drvdata,
>   	},
> +	{
> +		.compatible = "mediatek,mt8195-jpgdec",
> +		.data = &mtk8195_jpegdec_drvdata,
> +	},
>   	{},
>   };
>   
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> index f8415b6b1618..29cd71fd713e 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> @@ -102,6 +102,13 @@ enum mtk_jpegenc_hw_id {
>   	MTK_JPEGENC_HW_MAX,
>   };
>   
> +enum mtk_jpegdec_hw_id {
> +	MTK_JPEGDEC_HW0,
> +	MTK_JPEGDEC_HW1,
> +	MTK_JPEGDEC_HW2,
> +	MTK_JPEGDEC_HW_MAX,
> +};
> +
>   /**
>    * struct mtk_vcodec_clk - Structure used to store vcodec clock information
>    */
> @@ -110,6 +117,14 @@ struct mtk_jpegenc_clk {
>   	int clk_num;
>   };
>   
> +/**
> + * struct mtk_vcodec_clk - Structure used to store vcodec clock information

This is not struct mtk_vcodec_clk, but mtk_jpegdec_clk. Please fix.

> + */
> +struct mtk_jpegdec_clk {
> +	struct clk_bulk_data *clks;
> +	int clk_num;
> +};
> +
>   /**
>    * struct mtk_jpegenc_comp_dev - JPEG COREX abstraction
>    * @dev:		JPEG device
> @@ -139,6 +154,25 @@ struct mtk_jpegenc_comp_dev {
>   	spinlock_t hw_lock;
>   };
>   
> +/**
> + * struct mtk_jpegdec_comp_dev - JPEG COREX abstraction
> + * @dev:		        JPEG device
> + * @plat_dev:		    platform device data
> + * @reg_base:		    JPEG registers mapping
> + * @master_dev:		    mtk_jpeg_dev device
> + * @jdec_clk:	        mtk_jpegdec_clk

Please fix indentation.

> + * @jpegdec_irq:	    jpeg decode irq num
> + */
> +struct mtk_jpegdec_comp_dev {
> +	struct device *dev;
> +	struct platform_device *plat_dev;
> +	void __iomem *reg_base;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegdec_clk jdec_clk;
> +	int jpegdec_irq;
> +	int hw_id;
> +};
> +
>   /**
>    * struct mtk_jpeg_dev - JPEG IP abstraction
>    * @lock:		the mutex protecting this structure
> @@ -171,6 +205,10 @@ struct mtk_jpeg_dev {
>   	bool is_jpgenc_multihw;
>   	wait_queue_head_t enc_hw_wq;
>   	atomic_t enchw_rdy;
> +
> +	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
> +	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
> +	bool is_jpgdec_multihw;
>   };
>   
>   /**
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> index d2f25f43e852..fc98fe122874 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> @@ -5,9 +5,24 @@
>    *         Rick Chang <rick.chang@mediatek.com>
>    */
>   
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <media/media-device.h>
>   #include <media/videobuf2-core.h>
> +#include <media/videobuf2-v4l2.h>
> +#include <media/v4l2-mem2mem.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-event.h>
>   
>   #include "mtk_jpeg_core.h"
>   #include "mtk_jpeg_dec_hw.h"
> @@ -24,6 +39,16 @@ enum mtk_jpeg_color {
>   	MTK_JPEG_COLOR_400		= 0x00110000
>   };
>   
> +#if defined(CONFIG_OF)
> +static const struct of_device_id mtk_jpegdec_hw_ids[] = {
> +	{
> +		.compatible = "mediatek,mt8195-jpgdec-hw",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_jpegdec_hw_ids);
> +#endif
> +
>   static inline int mtk_jpeg_verify_align(u32 val, int align, u32 reg)
>   {
>   	if (val & (align - 1)) {
> @@ -414,3 +439,146 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
>   	mtk_jpeg_dec_set_pause_mcu_idx(base, config->total_mcu);
>   }
>   EXPORT_SYMBOL_GPL(mtk_jpeg_dec_set_config);
> +
> +static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
> +{
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	struct mtk_jpeg_src_buf *jpeg_src_buf;
> +	enum vb2_buffer_state buf_state;
> +	struct mtk_jpeg_ctx *ctx;
> +	u32 dec_irq_ret;
> +	u32 irq_status;
> +	int i;
> +
> +	struct mtk_jpegdec_comp_dev *jpeg = priv;
> +	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
> +
> +	irq_status = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
> +	dec_irq_ret = mtk_jpeg_dec_enum_result(irq_status);
> +	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
> +		mtk_jpeg_dec_reset(jpeg->reg_base);
> +	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE)
> +		return IRQ_NONE;
> +
> +	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
> +	if (!ctx) {
> +		dev_err(jpeg->dev, "Context is NULL\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
> +	jpeg_src_buf =
> +		container_of(src_buf, struct mtk_jpeg_src_buf, b);
> +
> +	for (i = 0; i < dst_buf->vb2_buf.num_planes; i++)
> +		vb2_set_plane_payload(&dst_buf->vb2_buf, i,
> +				      jpeg_src_buf->dec_param.comp_size[i]);
> +
> +	buf_state = VB2_BUF_STATE_DONE;
> +
> +	v4l2_m2m_buf_done(src_buf, buf_state);
> +	v4l2_m2m_buf_done(dst_buf, buf_state);
> +	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +	pm_runtime_put(ctx->jpeg->dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_jpegdec_hw_init_irq(struct mtk_jpegdec_comp_dev *dev)
> +{
> +	struct platform_device *pdev = dev->plat_dev;
> +	int ret;
> +
> +	dev->jpegdec_irq = platform_get_irq(pdev, 0);
> +	if (dev->jpegdec_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq resource");
> +		return dev->jpegdec_irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev,
> +			       dev->jpegdec_irq,
> +			       mtk_jpegdec_hw_irq_handler,
> +			       0,
> +			       pdev->name, dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to devm_request_irq %d (%d)",
> +			dev->jpegdec_irq, ret);
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
> +{
> +	struct mtk_jpegdec_clk *jpegdec_clk;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegdec_comp_dev *dev;
> +	int ret;
> +
> +	struct device *decs = &pdev->dev;
> +
> +	if (!decs->parent)
> +		return -EPROBE_DEFER;
> +
> +	master_dev = dev_get_drvdata(decs->parent);
> +	if (!master_dev)
> +		return -EPROBE_DEFER;
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->plat_dev = pdev;
> +	dev->dev = &pdev->dev;
> +	jpegdec_clk = &dev->jdec_clk;
> +
> +	jpegdec_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
> +						     &jpegdec_clk->clks);
> +	if (jpegdec_clk->clk_num < 0)
> +		return dev_err_probe(&pdev->dev,
> +				      jpegdec_clk->clk_num,
> +				      "Failed to get jpegdec clock count.\n");
> +
> +	dev->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dev->reg_base))
> +		return PTR_ERR(dev->reg_base);
> +
> +	ret = mtk_jpegdec_hw_init_irq(dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				     ret,
> +				     "Failed to register JPEGDEC irq handler.\n");
> +
> +	of_property_read_u32(decs->of_node, "hw_id",
> +			     &dev->hw_id);

ret = of_property_read_u32( ..... )
if (ret)
	return ret;

P.S.: Is it really important to get the hw_id from devicetree?
is there any difference between HW0, HW1, HW2?

Can we start decoding the first frame on HW1 or on HW2 instead of HW0?
Does this hardware really need to work in HW0->1->2 specific sequence?

Regards,
Angelo
