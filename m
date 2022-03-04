Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73A04CCB97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiCDCNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiCDCNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:13:41 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9923B29C;
        Thu,  3 Mar 2022 18:12:49 -0800 (PST)
X-UUID: e0c03160bea041e195d468a27de430d4-20220304
X-UUID: e0c03160bea041e195d468a27de430d4-20220304
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1783489580; Fri, 04 Mar 2022 10:12:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 4 Mar 2022 10:12:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Mar 2022 10:12:41 +0800
Message-ID: <0b7f30b6eabb54fa894dcffea5827023ffdd58ee.camel@mediatek.com>
Subject: Re: [PATCH v2, 04/10] media: mtk-vcodec: Enable venc dual core usage
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 4 Mar 2022 10:12:41 +0800
In-Reply-To: <3eaa4c05-f8f2-9e18-e6d9-a627fe5e1e40@collabora.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
         <20220117120615.21687-5-irui.wang@mediatek.com>
         <3eaa4c05-f8f2-9e18-e6d9-a627fe5e1e40@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Angelo,

Many thanks for your review.

On Thu, 2022-03-03 at 15:27 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/01/22 13:06, Irui Wang ha scritto:
> > Adds new venc core mode to indicate different venc hardware mode:
> > VENC_SINGLE_CORE_MODE means only one core, the device has its own
> > power/clk/irq, init_clk/request_irq helper can be used.
> > 
> > VENC_DUAL_CORE_MODE means more than one core inside, the core
> > device
> > can use the init_clk/request_irq helper to initialize their own
> > power/clk/irq. And the main device doesn't need use these helper
> > anymore.
> > 
> > MT8195 has two H264 venc cores, enable dual_core_mode for it.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >   drivers/media/platform/mtk-vcodec/Makefile    |   4 +-
> >   .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  22 +++
> >   .../platform/mtk-vcodec/mtk_vcodec_enc_core.c | 153
> > ++++++++++++++++++
> >   .../platform/mtk-vcodec/mtk_vcodec_enc_core.h |  36 +++++
> >   .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  88 +++++-----
> >   5 files changed, 266 insertions(+), 37 deletions(-)
> >   create mode 100644 drivers/media/platform/mtk-
> > vcodec/mtk_vcodec_enc_core.c
> >   create mode 100644 drivers/media/platform/mtk-
> > vcodec/mtk_vcodec_enc_core.h
> > 
> > diff --git a/drivers/media/platform/mtk-vcodec/Makefile
> > b/drivers/media/platform/mtk-vcodec/Makefile
> > index 93e7a343b5b0..c472b221bd6b 100644
> > --- a/drivers/media/platform/mtk-vcodec/Makefile
> > +++ b/drivers/media/platform/mtk-vcodec/Makefile
> > @@ -3,7 +3,8 @@
> >   obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
> >   				       mtk-vcodec-enc.o \
> >   				       mtk-vcodec-common.o \
> > -				       mtk-vcodec-dec-hw.o
> > +				       mtk-vcodec-dec-hw.o \
> > +				       mtk-vcodec-enc-core.o
> >   
> >   mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
> >   		vdec/vdec_vp8_if.o \
> > @@ -32,6 +33,7 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
> >   		venc_drv_if.o \
> >   		venc_vpu_if.o \
> >   
> > +mtk-vcodec-enc-core-y := mtk_vcodec_enc_core.o
> >   
> >   mtk-vcodec-common-y := mtk_vcodec_intr.o \
> >   		mtk_vcodec_util.o \
> > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > index f78463ff4551..9e4e4290a69a 100644
> > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > @@ -117,6 +117,23 @@ enum mtk_vdec_hw_count {
> >   	MTK_VDEC_MAX_HW_COUNT,
> >   };
> >   
> > +/*
> > + * enum mtk_venc_core_id -- encoder core id
> > + */
> > +enum mtk_venc_core_id {
> > +	MTK_VENC_CORE0 = 0,
> > +	MTK_VENC_CORE1 = 1,
> 
> You don't have to say "= 1" for core1, just...
> 
> 	MTK_VENC_CORE0 = 0,
> 	MTK_VENC_CORE1,
> 
> ...is fine, and better.

I will fix it.

> 
> > +	MTK_VENC_CORE_MAX,
> > +};
> > +
> > +/**
> > + * enmu mtk_venc_core_mode - Used to indicate different encode
> > mode
> > + */
> > +enum mtk_venc_core_mode {
> > +	VENC_SINGLE_CORE_MODE = 0,
> > +	VENC_DUAL_CORE_MODE = 1,
> > +};
> > +
> >   /*
> >    * struct mtk_video_fmt - Structure used to store information
> > about pixelformats
> >    */
> > @@ -420,6 +437,7 @@ struct mtk_vcodec_dec_pdata {
> >    * @output_formats: array of supported output formats
> >    * @num_output_formats: number of entries in output_formats
> >    * @core_type: stand for h264 or vp8 encode
> > + * @core_mode: indicate encode core mode
> >    */
> >   struct mtk_vcodec_enc_pdata {
> >   	bool uses_ext;
> > @@ -430,6 +448,7 @@ struct mtk_vcodec_enc_pdata {
> >   	const struct mtk_video_fmt *output_formats;
> >   	size_t num_output_formats;
> >   	int core_type;
> > +	enum mtk_venc_core_mode core_mode;
> >   };
> >   
> >   #define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata-
> > >uses_ext)
> > @@ -479,6 +498,7 @@ struct mtk_vcodec_enc_pdata {
> >    * @subdev_dev: subdev hardware device
> >    * @subdev_prob_done: check whether all used hw device is prob
> > done
> >    * @subdev_bitmap: used to record hardware is ready or not
> > + * @enc_core_dev: used to store venc core device
> >    */
> >   struct mtk_vcodec_dev {
> >   	struct v4l2_device v4l2_dev;
> > @@ -524,6 +544,8 @@ struct mtk_vcodec_dev {
> >   	void *subdev_dev[MTK_VDEC_HW_MAX];
> >   	int (*subdev_prob_done)(struct mtk_vcodec_dev *vdec_dev);
> >   	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
> > +
> > +	void *enc_core_dev[MTK_VENC_CORE_MAX];
> >   };
> >   
> >   static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh
> > *fh)
> > diff --git a/drivers/media/platform/mtk-
> > vcodec/mtk_vcodec_enc_core.c b/drivers/media/platform/mtk-
> > vcodec/mtk_vcodec_enc_core.c
> > new file mode 100644
> > index 000000000000..d84914f615a5
> > --- /dev/null
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
> > @@ -0,0 +1,153 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2021 MediaTek Inc.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +
> > +#include "mtk_vcodec_drv.h"
> > +#include "mtk_vcodec_enc.h"
> > +#include "mtk_vcodec_enc_core.h"
> > +
> > +static const struct of_device_id mtk_venc_core_ids[] = {
> > +	{
> > +		.compatible = "mediatek,mtk-venc-core0",
> > +		.data = (void *)MTK_VENC_CORE0,
> > +	},
> > +	{
> > +		.compatible = "mediatek,mtk-venc-core1",
> > +		.data = (void *)MTK_VENC_CORE1,
> > +	},
> > +	{},
> > +};
> 
> Hello Irui,
> 
> You don't need a different compatible for the different cores, as in
> the
> declaration, there's nothing special that differentiates them that
> much.
> 
> I understand that there may be a need to differentiate the core
> number, as
> in, CORE0 always has to be the leader, while CORE1 would be the
> follower,
> but this is not a good reason to give them a different compatible
> string.
> 
> I want to make you aware that Kyrie Wu did the same thing as you did
> here
> and in my review on his patch I was able to give an extensive example
> of
> how this should look; the exactly same logic would apply to this
> patch.
> 
> Please have a look here: 
> https://patchwork.kernel.org/comment/24726607/
> 
> P.S.: In short, you should have only one "mediatek,mtk-venc-hw"
> compatible
>        used for probing both cores.

thanks for your suggestions, with your example, venc can be rewritten
like this:
venc {
    compatible = "mediatek,mt8195-vcodec-enc";
    ..... other properties .....

    venc_core0 {
        compatible = "mediatek,mtk-venc-hw";
        mediatek,hw-leader;//mediatek,venc-core0;
        ..... other properties .....
    };

    venc_core1 {
        compatible = "mediatek,mtk-venc-hw";
        //mediatek,venc-core1;
        ..... other properties .....
    };
};
I will rewrite this code if it matches your suggestions.
> 
> > +MODULE_DEVICE_TABLE(of, mtk_venc_core_ids);
> > +
> > +static void clean_irq_status(unsigned int irq_status, void __iomem
> > *addr)
> > +{
> > +	if (irq_status & MTK_VENC_IRQ_STATUS_PAUSE)
> > +		writel(MTK_VENC_IRQ_STATUS_PAUSE, addr);
> > +
> > +	if (irq_status & MTK_VENC_IRQ_STATUS_SWITCH)
> > +		writel(MTK_VENC_IRQ_STATUS_SWITCH, addr);
> > +
> > +	if (irq_status & MTK_VENC_IRQ_STATUS_DRAM)
> > +		writel(MTK_VENC_IRQ_STATUS_DRAM, addr);
> > +
> > +	if (irq_status & MTK_VENC_IRQ_STATUS_SPS)
> > +		writel(MTK_VENC_IRQ_STATUS_SPS, addr);
> > +
> > +	if (irq_status & MTK_VENC_IRQ_STATUS_PPS)
> > +		writel(MTK_VENC_IRQ_STATUS_PPS, addr);
> > +
> > +	if (irq_status & MTK_VENC_IRQ_STATUS_FRM)
> > +		writel(MTK_VENC_IRQ_STATUS_FRM, addr);
> > +}
> > +
> > +static irqreturn_t mtk_enc_core_irq_handler(int irq, void *priv)
> > +{
> > +	struct mtk_venc_core_dev *core = priv;
> > +	struct mtk_vcodec_ctx *ctx;
> > +	unsigned long flags;
> > +	void __iomem *addr;
> > +
> > +	spin_lock_irqsave(&core->main_dev->irqlock, flags);
> > +	ctx = core->curr_ctx;
> > +	spin_unlock_irqrestore(&core->main_dev->irqlock, flags);
> > +	if (!ctx)
> > +		return IRQ_HANDLED;
> > +
> > +	mtk_v4l2_debug(1, "id=%d core :%d", ctx->id, core->core_id);
> > +
> > +	addr = core->reg_base + MTK_VENC_IRQ_ACK_OFFSET;
> > +	ctx->irq_status = readl(core->reg_base +
> > MTK_VENC_IRQ_STATUS_OFFSET);
> > +	clean_irq_status(ctx->irq_status, addr);
> > +
> > +	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mtk_venc_core_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mtk_venc_core_dev *core;
> > +	struct mtk_vcodec_dev *main_dev;
> > +	int ret;
> > +
> > +	if (!dev->parent) {
> > +		dev_err(dev, "No parent for venc core device\n");
> > +		return -ENODEV;
> > +	}
> 
> Please, use dev_err_probe(), here and everywhere else.

I will fix it
> 
> > +
> > +	main_dev = dev_get_drvdata(dev->parent);
> > +	if (!main_dev) {
> > +		dev_err(dev, "Failed to get parent driver data");
> > +		return -EINVAL;
> > +	}
> > +
> > +	core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
> > +	if (!core)
> > +		return -ENOMEM;
> > +
> > +	core->plat_dev = pdev;
> > +
> > +	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(core->reg_base)) {
> > +		dev_err(&pdev->dev, "Failed to get reg base");
> > +		ret = PTR_ERR(core->reg_base);
> > +		goto err;
> 
> You don't need the "err" label. Also, you can return dev_err_probe
> here too.
> Example:
> 
> 		return dev_err_probe(&pdev->dev, PTR_ERR(core-
> >reg_base),
> 				     "Failed to get reg base\n");

I will fix it
> 
> > +	}
> > +
> > +	core->enc_irq = platform_get_irq(pdev, 0);
> > +	if (core->enc_irq < 0) {
> > +		dev_err(&pdev->dev, "Failed to get irq resource");
> > +		ret = core->enc_irq;
> > +		goto err;
> > +	}
> > +
> > +	ret = devm_request_irq(&pdev->dev, core->enc_irq,
> > +			       mtk_enc_core_irq_handler, 0,
> > +			       pdev->name, core);
> > +	if (ret) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to install core->enc_irq %d (%d)",
> > +			core->enc_irq, ret);
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> > +
> > +	core->core_id =
> 
> core_id would be 0 if "mediatek,hw-leader", N if it's not a
> mediatek,hw-leader.
> 
> > +		(enum mtk_venc_core_id)of_device_get_match_data(&pdev-
> > >dev);
> > +	if (core->core_id < 0 || core->core_id >= MTK_VENC_CORE_MAX) {
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> > +
> > +	main_dev->enc_core_dev[core->core_id] = core;
> > +	core->main_dev = main_dev;
> > +
> > +	platform_set_drvdata(pdev, core);
> > +
> > +	dev_info(dev, "Venc core :%d probe done\n", core->core_id);
> 
> Please change this to dev_dbg().

I will fix it
> 
> > +
> > +	return 0;
> > +
> > +err:
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver mtk_venc_core_driver = {
> > +	.probe  = mtk_venc_core_probe,
> > +	.driver = {
> > +		.name	 = "mtk-venc-core",
> > +		.of_match_table = mtk_venc_core_ids,
> > +	},
> > +};
> > +module_platform_driver(mtk_venc_core_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Mediatek video encoder core driver");
> > diff --git a/drivers/media/platform/mtk-
> > vcodec/mtk_vcodec_enc_core.h b/drivers/media/platform/mtk-
> > vcodec/mtk_vcodec_enc_core.h
> > new file mode 100644
> > index 000000000000..856681989869
> > --- /dev/null
> > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2021 MediaTek Inc.
> > + */
> > +
> > +#ifndef _MTK_VCODEC_ENC_CORE_H_
> > +#define _MTK_VCODEC_ENC_CORE_H_
> > +
> > +#include <linux/platform_device.h>
> > +#include "mtk_vcodec_drv.h"
> > +
> > +/*
> 
> I love when developers try to write kerneldoc, this is something that
> should really be done *always*, so thank you for this!!!!
> 
> ....but you missed something here: for this to be parsed by
> kerneldoc,
> you need to do:
> 
> /**
> ^^^ this one :))
> 
>   * struct mtk_venc_core_dev - driver data
> 
> P.S.: https://docs.kernel.org/doc-guide/kernel-doc.html

I will fix it
> 
> > + * struct mtk_venc_core_dev - driver data
> > + * @plat_dev: platform_device
> > + * @main_dev: main device
> > + * @pm: power management data
> > + * @curr_ctx: the context that is waiting for venc hardware
> > + * @reg_base: mapped address of venc registers
> > + * @irq_status: venc core irq status
> > + * @enc_irq: venc device irq
> > + * @core id: for venc core id: core#0, core#1...
> > + */
> > +struct mtk_venc_core_dev {
> > +	struct platform_device *plat_dev;
> > +	struct mtk_vcodec_dev *main_dev;
> > +
> > +	struct mtk_vcodec_pm pm;
> > +	struct mtk_vcodec_ctx *curr_ctx;
> > +
> > +	void __iomem *reg_base;
> > +	unsigned int irq_status;
> > +	int enc_irq;
> > +	int core_id;
> > +};
> > +
> > +#endif /* _MTK_VCODEC_ENC_CORE_H_ */
> 
> 
> Thanks,
> Angelo

Thanks
Best Regards

