Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4654CAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355256AbiFOOAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355720AbiFOOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:00:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90B4A93A;
        Wed, 15 Jun 2022 07:00:08 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7964E6601703;
        Wed, 15 Jun 2022 15:00:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655301607;
        bh=mRN/ntKWHMjpEfhjxvDs4fKkWPwI+yLO+oKpeMdmPdc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hJa3B2crrHGbHe4/KG49V6CZRYeTlIJI/Bdn2NQCMMoB8bSG7rz1umrQDdfbSo/nb
         XO+OjvukU67BQadszRKVxWDjXBsCfh9GMAo4p5/nu0ssTBsDztGrJQlnxwEsGqw3bL
         NiezrfyR6pGbgAEL4uG6KqUWSL6oUE/VAod4BBiXOYxdteG8qnPteOQlDzG6hRLnSm
         C9kRCMt1fe/cYKBDcQ0DkLz+a6v02Dy+VsB7ztdLY7anEAoMnk64dOz3xurOFD/ZMj
         ePVcGXyIhIyDI37tMIqITrhO89eFdZuWQA5KjAf7WZ5yTLzdhn/bP3xDPRpGBhb+PB
         /Y2s2yIXpyFRA==
Message-ID: <57a6334374d19f80947906117785994b582e62ab.camel@collabora.com>
Subject: Re: [V9,3/7] mtk-jpegenc: manage jpegenc multi-hardware
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
Date:   Wed, 15 Jun 2022 09:59:56 -0400
In-Reply-To: <20220613032306.23237-4-irui.wang@mediatek.com>
References: <20220613032306.23237-1-irui.wang@mediatek.com>
         <20220613032306.23237-4-irui.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 juin 2022 =C3=A0 11:23 +0800, Irui Wang a =C3=A9crit=C2=A0:
> From: kyrie wu <kyrie.wu@mediatek.com>
>=20
> manage each hardware information, including irq/clk/power.
> the hardware includes HW0 and HW1.
>=20
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  drivers/media/platform/mediatek/jpeg/Makefile |  11 +-
>  .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  78 ++++++---
>  .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  38 +++++
>  .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 160 ++++++++++++++++++
>  4 files changed, 261 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/jpeg/Makefile b/drivers/medi=
a/platform/mediatek/jpeg/Makefile
> index 76c33aad0f3f..69703db4b0a5 100644
> --- a/drivers/media/platform/mediatek/jpeg/Makefile
> +++ b/drivers/media/platform/mediatek/jpeg/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -mtk_jpeg-objs :=3D mtk_jpeg_core.o \
> +obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) +=3D mtk_jpeg.o \
> +	mtk-jpeg-enc-hw.o
> +
> +mtk_jpeg-y :=3D mtk_jpeg_core.o \
>  		 mtk_jpeg_dec_hw.o \
> -		 mtk_jpeg_dec_parse.o \
> -		 mtk_jpeg_enc_hw.o
> -obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) +=3D mtk_jpeg.o
> +		 mtk_jpeg_dec_parse.o
> +
> +mtk-jpeg-enc-hw-y :=3D mtk_jpeg_enc_hw.o
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 724fb7aeb0ee..f7a5b971e628 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -680,7 +680,7 @@ static int mtk_jpeg_buf_prepare(struct vb2_buffer *vb=
)
>  {
>  	struct mtk_jpeg_ctx *ctx =3D vb2_get_drv_priv(vb->vb2_queue);
>  	struct mtk_jpeg_q_data *q_data =3D NULL;
> -	struct v4l2_plane_pix_format plane_fmt;
> +	struct v4l2_plane_pix_format plane_fmt =3D {};
>  	int i;
> =20
>  	q_data =3D mtk_jpeg_get_q_data(ctx, vb->vb2_queue->type);
> @@ -1312,31 +1312,39 @@ static int mtk_jpeg_probe(struct platform_device =
*pdev)
>  	spin_lock_init(&jpeg->hw_lock);
>  	jpeg->dev =3D &pdev->dev;
>  	jpeg->variant =3D of_device_get_match_data(jpeg->dev);
> -	INIT_DELAYED_WORK(&jpeg->job_timeout_work, mtk_jpeg_job_timeout_work);
> =20
> -	jpeg->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(jpeg->reg_base)) {
> -		ret =3D PTR_ERR(jpeg->reg_base);
> -		return ret;
> -	}
> +	if (!jpeg->variant->is_multihw) {
> +		INIT_DELAYED_WORK(&jpeg->job_timeout_work,
> +				  mtk_jpeg_job_timeout_work);
> =20
> -	jpeg_irq =3D platform_get_irq(pdev, 0);
> -	if (jpeg_irq < 0)
> -		return jpeg_irq;
> +		jpeg->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(jpeg->reg_base)) {
> +			ret =3D PTR_ERR(jpeg->reg_base);
> +			return ret;
> +		}
> =20
> -	ret =3D devm_request_irq(&pdev->dev, jpeg_irq,
> -			       jpeg->variant->irq_handler, 0, pdev->name, jpeg);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
> -			jpeg_irq, ret);
> -		goto err_req_irq;
> -	}
> +		jpeg_irq =3D platform_get_irq(pdev, 0);
> +		if (jpeg_irq < 0)
> +			return jpeg_irq;
> =20
> -	ret =3D devm_clk_bulk_get(jpeg->dev, jpeg->variant->num_clks,
> -				jpeg->variant->clks);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to init clk, err %d\n", ret);
> -		goto err_clk_init;
> +		ret =3D devm_request_irq(&pdev->dev,
> +				       jpeg_irq,
> +				       jpeg->variant->irq_handler,
> +				       0,
> +				       pdev->name, jpeg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
> +				jpeg_irq, ret);
> +			goto err_req_irq;
> +		}
> +
> +		ret =3D devm_clk_bulk_get(jpeg->dev,
> +					jpeg->variant->num_clks,
> +					jpeg->variant->clks);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to init clk\n");
> +			goto err_clk_init;
> +		}
>  	}
> =20
>  	ret =3D v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
> @@ -1388,6 +1396,14 @@ static int mtk_jpeg_probe(struct platform_device *=
pdev)
> =20
>  	platform_set_drvdata(pdev, jpeg);
> =20
> +	if (jpeg->variant->is_multihw) {
> +		ret =3D devm_of_platform_populate(&pdev->dev);
> +		if (ret) {
> +			v4l2_err(&jpeg->v4l2_dev, "Master of platform populate failed.");
> +			goto err_vfd_jpeg_register;
> +		}
> +	}
> +
>  	pm_runtime_enable(&pdev->dev);
> =20
>  	return 0;
> @@ -1497,6 +1513,19 @@ static const struct mtk_jpeg_variant mtk_jpeg_drvd=
ata =3D {
>  	.cap_q_default_fourcc =3D V4L2_PIX_FMT_JPEG,
>  };
> =20
> +static const struct mtk_jpeg_variant mtk8195_jpegenc_drvdata =3D {
> +	.is_multihw =3D true,

For my undersatanding, is there a link between is_multihw here and
mediatek,jpegenc-multi-core property ? If not, then ignore my comment, othe=
rwise
this would seem redundant, and I would drop the property.

> +	.formats =3D mtk_jpeg_enc_formats,
> +	.num_formats =3D MTK_JPEG_ENC_NUM_FORMATS,
> +	.qops =3D &mtk_jpeg_enc_qops,
> +	.m2m_ops =3D &mtk_jpeg_enc_m2m_ops,
> +	.dev_name =3D "mtk-jpeg-enc",
> +	.ioctl_ops =3D &mtk_jpeg_enc_ioctl_ops,
> +	.out_q_default_fourcc =3D V4L2_PIX_FMT_YUYV,
> +	.cap_q_default_fourcc =3D V4L2_PIX_FMT_JPEG,
> +};
> +
> +#if defined(CONFIG_OF)
>  static const struct of_device_id mtk_jpeg_match[] =3D {
>  	{
>  		.compatible =3D "mediatek,mt8173-jpgdec",
> @@ -1510,10 +1539,15 @@ static const struct of_device_id mtk_jpeg_match[]=
 =3D {
>  		.compatible =3D "mediatek,mtk-jpgenc",
>  		.data =3D &mtk_jpeg_drvdata,
>  	},
> +	{
> +		.compatible =3D "mediatek,mt8195-jpgenc",
> +		.data =3D &mtk8195_jpegenc_drvdata,
> +	},
>  	{},
>  };
> =20
>  MODULE_DEVICE_TABLE(of, mtk_jpeg_match);
> +#endif
> =20
>  static struct platform_driver mtk_jpeg_driver =3D {
>  	.probe =3D mtk_jpeg_probe,
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> index 3e4811a41ba2..f6e980fde4ef 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> @@ -9,6 +9,7 @@
>  #ifndef _MTK_JPEG_CORE_H
>  #define _MTK_JPEG_CORE_H
> =20
> +#include <linux/clk.h>
>  #include <linux/interrupt.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> @@ -60,6 +61,7 @@ enum mtk_jpeg_ctx_state {
>   * @cap_q_default_fourcc:	capture queue default fourcc
>   */
>  struct mtk_jpeg_variant {
> +	bool is_multihw;
>  	struct clk_bulk_data *clks;
>  	int num_clks;
>  	struct mtk_jpeg_fmt *formats;
> @@ -74,6 +76,39 @@ struct mtk_jpeg_variant {
>  	u32 cap_q_default_fourcc;
>  };
> =20
> +enum mtk_jpegenc_hw_id {
> +	MTK_JPEGENC_HW0,
> +	MTK_JPEGENC_HW1,
> +	MTK_JPEGENC_HW_MAX,
> +};
> +
> +/**
> + * struct mtk_vcodec_clk - Structure used to store vcodec clock informat=
ion
> + */
> +struct mtk_jpegenc_clk {
> +	struct clk_bulk_data *clks;
> +	int clk_num;
> +};
> +
> +/**
> + * struct mtk_jpegenc_comp_dev - JPEG COREX abstraction
> + * @dev:		        JPEG device
> + * @plat_dev:		    platform device data
> + * @reg_base:		    JPEG registers mapping
> + * @master_dev:		    mtk_jpeg_dev device
> + * @pm:	                mtk_jpegenc_pm
> + * @jpegenc_irq:	    jpeg encode irq num
> + */
> +struct mtk_jpegenc_comp_dev {
> +	struct device *dev;
> +	struct platform_device *plat_dev;
> +	void __iomem *reg_base;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegenc_clk venc_clk;
> +	int jpegenc_irq;
> +	int hw_id;
> +};
> +
>  /**
>   * struct mtk_jpeg_dev - JPEG IP abstraction
>   * @lock:		the mutex protecting this structure
> @@ -100,6 +135,9 @@ struct mtk_jpeg_dev {
>  	void __iomem		*reg_base;
>  	struct delayed_work job_timeout_work;
>  	const struct mtk_jpeg_variant *variant;
> +
> +	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
> +	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
>  };
> =20
>  /**
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> index a2b6e1f85c2d..8ac6b031dcd4 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> @@ -5,11 +5,27 @@
>   *
>   */
> =20
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <media/media-device.h>
>  #include <media/videobuf2-core.h>
>  #include <media/videobuf2-dma-contig.h>
> +#include <media/videobuf2-v4l2.h>
> +#include <media/v4l2-mem2mem.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-event.h>
> =20
> +#include "mtk_jpeg_core.h"
>  #include "mtk_jpeg_enc_hw.h"
> =20
>  static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_quality[] =3D {
> @@ -30,6 +46,16 @@ static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_qual=
ity[] =3D {
>  	{.quality_param =3D 97, .hardware_value =3D JPEG_ENC_QUALITY_Q97},
>  };
> =20
> +#if defined(CONFIG_OF)
> +static const struct of_device_id mtk_jpegenc_drv_ids[] =3D {
> +	{
> +		.compatible =3D "mediatek,mt8195-jpgenc-hw",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_jpegenc_drv_ids);
> +#endif
> +
>  void mtk_jpeg_enc_reset(void __iomem *base)
>  {
>  	writel(0, base + JPEG_ENC_RSTB);
> @@ -159,3 +185,137 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *c=
tx,  void __iomem *base)
>  }
>  EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_params);
> =20
> +static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
> +{
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	enum vb2_buffer_state buf_state;
> +	struct mtk_jpeg_ctx *ctx;
> +	u32 result_size;
> +	u32 irq_status;
> +
> +	struct mtk_jpegenc_comp_dev *jpeg =3D priv;
> +	struct mtk_jpeg_dev *master_jpeg =3D jpeg->master_dev;
> +
> +	irq_status =3D readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
> +		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
> +	if (irq_status)
> +		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
> +	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
> +		return IRQ_NONE;
> +
> +	ctx =3D v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
> +	if (!ctx) {
> +		v4l2_err(&master_jpeg->v4l2_dev, "Context is NULL\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	src_buf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +	dst_buf =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +	dst_buf->vb2_buf.timestamp =3D src_buf->vb2_buf.timestamp;

I would suggest using v4l2_m2m_buf_copy_metadata().

> +
> +	result_size =3D mtk_jpeg_enc_get_file_size(jpeg->reg_base);
> +	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
> +	buf_state =3D VB2_BUF_STATE_DONE;
> +	v4l2_m2m_buf_done(src_buf, buf_state);
> +	v4l2_m2m_buf_done(dst_buf, buf_state);
> +	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +	pm_runtime_put(ctx->jpeg->dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_jpegenc_hw_init_irq(struct mtk_jpegenc_comp_dev *dev)
> +{
> +	struct platform_device *pdev =3D dev->plat_dev;
> +	int ret;
> +
> +	dev->jpegenc_irq =3D platform_get_irq(pdev, 0);
> +	if (dev->jpegenc_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq resource");
> +		return dev->jpegenc_irq;
> +	}
> +
> +	ret =3D devm_request_irq(&pdev->dev,
> +			       dev->jpegenc_irq,
> +			       mtk_jpegenc_hw_irq_handler,
> +			       0,
> +			       pdev->name, dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to devm_request_irq %d (%d)",
> +			dev->jpegenc_irq, ret);
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
> +{
> +	struct mtk_jpegenc_clk *jpegenc_clk;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegenc_comp_dev *dev;
> +	int ret;
> +
> +	struct device *decs =3D &pdev->dev;
> +
> +	if (!decs->parent)
> +		return -EPROBE_DEFER;
> +
> +	master_dev =3D dev_get_drvdata(decs->parent);
> +	if (!master_dev)
> +		return -EPROBE_DEFER;
> +
> +	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->plat_dev =3D pdev;
> +	dev->dev =3D &pdev->dev;
> +
> +	jpegenc_clk =3D &dev->venc_clk;
> +
> +	jpegenc_clk->clk_num =3D devm_clk_bulk_get_all(&pdev->dev,
> +						     &jpegenc_clk->clks);
> +	if (jpegenc_clk->clk_num < 0)
> +		return dev_err_probe(&pdev->dev, jpegenc_clk->clk_num,
> +				     "Failed to get jpegenc clock count\n");
> +
> +	dev->reg_base =3D
> +		devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dev->reg_base))
> +		return PTR_ERR(dev->reg_base);
> +
> +	ret =3D mtk_jpegenc_hw_init_irq(dev);
> +	if (ret)
> +		return ret;
> +
> +	of_property_read_u32(decs->of_node, "mediatek,hw-id",
> +			     &dev->hw_id);
> +
> +	if (dev->hw_id >=3D 0 || dev->hw_id < MTK_JPEGENC_HW_MAX) {
> +		master_dev->enc_hw_dev[dev->hw_id] =3D dev;
> +		master_dev->reg_encbase[dev->hw_id] =3D dev->reg_base;
> +		dev->master_dev =3D master_dev;
> +	} else {
> +		return dev_err_probe(&pdev->dev, dev->hw_id,
> +				     "Invalid hw id\n");
> +	}
> +
> +	platform_set_drvdata(pdev, dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +struct platform_driver mtk_jpegenc_hw_driver =3D {
> +	.probe =3D mtk_jpegenc_hw_probe,
> +	.driver =3D {
> +		.name =3D "mtk-jpegenc-hw",
> +		.of_match_table =3D of_match_ptr(mtk_jpegenc_drv_ids),
> +	},
> +};
> +
> +module_platform_driver(mtk_jpegenc_hw_driver);
> +
> +MODULE_DESCRIPTION("MediaTek JPEG encode HW driver");
> +MODULE_LICENSE("GPL");

