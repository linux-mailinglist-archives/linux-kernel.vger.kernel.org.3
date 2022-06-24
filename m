Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567C9559709
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiFXJxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXJxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:53:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE64A1B6;
        Fri, 24 Jun 2022 02:53:00 -0700 (PDT)
X-UUID: 4617cd32f7bf4f07b461570ee591b394-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:457a7942-da37-4817-b28d-c7630fa6b9a0,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:16e5f42d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4617cd32f7bf4f07b461570ee591b394-20220624
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 295354194; Fri, 24 Jun 2022 17:52:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 17:52:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 24 Jun 2022 17:52:49 +0800
Message-ID: <323a0e5e52d25704aaa8eac9b1a14c47a1d4d8bb.camel@mediatek.com>
Subject: Re: [PATCH v4, 2/8] media: mediatek: vcodec: Enable venc dual core
 usage
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        <nicolas.dufresne@collabora.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 24 Jun 2022 17:52:49 +0800
In-Reply-To: <33f5dfdf-ca4b-15f5-ff75-cc27800bbea0@collabora.com>
References: <20220624082335.10165-1-irui.wang@mediatek.com>
         <20220624082335.10165-3-irui.wang@mediatek.com>
         <33f5dfdf-ca4b-15f5-ff75-cc27800bbea0@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Angelo,

Thanks for the comments.
On Fri, 2022-06-24 at 11:00 +0200, AngeloGioacchino Del Regno wrote:
> Il 24/06/22 10:23, Irui Wang ha scritto:
> > Adds new property to indicate whether the encoder has multiple
> > cores.
> > Use of_platform_populate to probe each venc cores, the core device
> > can
> > use the init_clk/request_irq helper to initialize their own
> > power/clk/irq.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >   .../media/platform/mediatek/vcodec/Makefile   |   4 +-
> >   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  12 ++
> >   .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  10 ++
> >   .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 139
> > ++++++++++++++++++
> >   .../mediatek/vcodec/mtk_vcodec_enc_hw.h       |  36 +++++
> >   5 files changed, 200 insertions(+), 1 deletion(-)
> >   create mode 100644
> > drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
> >   create mode 100644
> > drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> > 
> > diff --git a/drivers/media/platform/mediatek/vcodec/Makefile
> > b/drivers/media/platform/mediatek/vcodec/Makefile
> > index 93e7a343b5b0..ac068d88af29 100644
> > --- a/drivers/media/platform/mediatek/vcodec/Makefile
> > +++ b/drivers/media/platform/mediatek/vcodec/Makefile
> > @@ -3,7 +3,8 @@
> >   obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
> >   				       mtk-vcodec-enc.o \
> >   				       mtk-vcodec-common.o \
> > -				       mtk-vcodec-dec-hw.o
> > +				       mtk-vcodec-dec-hw.o \
> > +				       mtk_vcodec_enc_hw.o
> >   
> >   mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
> >   		vdec/vdec_vp8_if.o \
> > @@ -32,6 +33,7 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
> >   		venc_drv_if.o \
> >   		venc_vpu_if.o \
> >   
> > +mtk-vcodec-enc-hw-y := mtk_vcodec_enc_hw.o
> >   
> >   mtk-vcodec-common-y := mtk_vcodec_intr.o \
> >   		mtk_vcodec_util.o \
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > index dc6aada882d9..8919bdf2eef5 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > @@ -97,6 +97,15 @@ enum mtk_fmt_type {
> >   	MTK_FMT_FRAME = 2,
> >   };
> >   
> > +/*
> > + * enum mtk_venc_hw_id -- encoder hardware id
> > + */
> > +enum mtk_venc_hw_id {
> > +	MTK_VENC_CORE_0 = 0,
> > +	MTK_VENC_CORE_1,
> > +	MTK_VENC_HW_MAX,
> > +};
> > +
> >   /*
> >    * enum mtk_vdec_hw_id - Hardware index used to separate
> >    *                         different hardware
> > @@ -484,6 +493,7 @@ struct mtk_vcodec_enc_pdata {
> >    * @dec_active_cnt: used to mark whether need to record register
> > value
> >    * @vdec_racing_info: record register value
> >    * @dec_racing_info_mutex: mutex lock used for inner racing mode
> > + * @enc_hw_dev: used to store venc core device
> >    */
> >   struct mtk_vcodec_dev {
> >   	struct v4l2_device v4l2_dev;
> > @@ -534,6 +544,8 @@ struct mtk_vcodec_dev {
> >   	u32 vdec_racing_info[132];
> >   	/* Protects access to vdec_racing_info data */
> >   	struct mutex dec_racing_info_mutex;
> > +
> > +	void *enc_hw_dev[MTK_VENC_HW_MAX];
> >   };
> >   
> >   static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh
> > *fh)
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > index 95e8c29ccc65..65a8251a5a68 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> > @@ -263,6 +263,16 @@ static int mtk_vcodec_probe(struct
> > platform_device *pdev)
> >   		goto err_enc_pm;
> >   	}
> >   
> > +	if (of_property_read_bool(pdev->dev.of_node,
> > +				  "mediatek,venc-multi-core")) {
> 
> You don't need this property here: just call of_platform_populate()
> unconditionally. If there's no child node, this function will do
> nothing
> so this conditional is useless and can be avoided.

I will update YAML and fix it in next version.
> 
> > +		ret = of_platform_populate(pdev->dev.of_node,
> > +					   NULL, NULL, &pdev->dev);
> > +		if (ret) {
> > +			mtk_v4l2_err("Venc core device populate
> > failed");
> 
> What about "Failed to populate children devices" ?
fix it in next version.
> 
> > +			goto err_enc_pm;
> > +		}
> > +	}
> > +
> >   	pm_runtime_enable(&pdev->dev);
> >   
> >   	dev->reg_base[dev->venc_pdata->core_id] =
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
> > new file mode 100644
> > index 000000000000..02582cce4863
> > --- /dev/null
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
> > @@ -0,0 +1,139 @@
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
> > +#include "mtk_vcodec_enc_hw.h"
> > +#include "mtk_vcodec_intr.h"
> > +
> > +static const struct of_device_id mtk_venc_hw_ids[] = {
> > +	{
> > +		.compatible = "mediatek,mtk-venc-hw",
> > +	},
> 
> Please compress this in one line.
> 
> > +	{},
> 
> Usually, we say that this is a sentinel.
> 
> 	{ .compatible = "mediatek,mtk-venc-hw" },
> 	{ /* sentinel */ },

fix it in next version.
> 
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_venc_hw_ids);
> > +
> 
> ..snip..
> 
> > +
> > +static int mtk_venc_hw_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mtk_venc_hw_dev *sub_core;
> > +	struct mtk_vcodec_dev *main_dev;
> > +	int ret;
> > +
> > +	if (!dev->parent)
> > +		return dev_err_probe(dev, -ENODEV,
> > +				     "No parent for venc core
> > device\n");
> > +
> > +	main_dev = dev_get_drvdata(dev->parent);
> > +	if (!main_dev)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Failed to get parent driver
> > data\n");
> > +
> > +	sub_core = devm_kzalloc(&pdev->dev, sizeof(*sub_core),
> > GFP_KERNEL);
> > +	if (!sub_core)
> > +		return dev_err_probe(dev, -ENOMEM,
> > +				     "Failed to get alloc core
> > data\n");
> > +
> > +	sub_core->plat_dev = pdev;
> > +
> > +	platform_set_drvdata(pdev, sub_core);
> > +
> > +	sub_core->reg_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(sub_core->reg_base))
> > +		return dev_err_probe(dev, PTR_ERR(sub_core->reg_base),
> > +				     "Failed to get reg base\n");
> > +
> > +	sub_core->enc_irq = platform_get_irq(pdev, 0);
> > +	if (sub_core->enc_irq < 0)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Failed to get irq resource\n");
> > +
> > +	ret = devm_request_irq(dev, sub_core->enc_irq,
> > +			       mtk_enc_hw_irq_handler, 0,
> > +			       pdev->name, sub_core);
> > +	if (ret)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Failed to install sub_core-
> > >enc_irq %d\n",
> > +				     sub_core->enc_irq);
> > +
> > +	of_property_read_u32(dev->of_node, "mediatek,hw-id",
> > +			     &sub_core->hw_id);
> > +
> 
> I'd do it like this, instead:
> 
>      ret = of_property_read_u32(dev->of_node, "mediatek,hw-id",
> &sub_core->hw_id);
>      if (ret || sub_core->hw_id >= MTK_VENC_HW_MAX)
>          return dev_err_probe(dev, (ret ? ret : -EINVAL),
>                               "Cannot parse hardware id");
> 
> P.S.: you're reading an unsigned value from devicetree, this cannot
> ever be less
>        than zero!

fix it in next version.
> 
> > +	if (sub_core->hw_id < 0 || sub_core->hw_id >= MTK_VENC_HW_MAX)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Invalid hardware id %d\n",
> > +				     sub_core->hw_id);
> > +
> > +	main_dev->enc_hw_dev[sub_core->hw_id] = sub_core;
> > +	sub_core->main_dev = main_dev;
> > +
> > +	dev_dbg(dev, "Venc core :%d probe done\n", sub_core->hw_id);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver mtk_venc_core_driver = {
> > +	.probe  = mtk_venc_hw_probe,
> > +	.driver = {
> > +		.name	 = "mtk-venc-core",
> > +		.of_match_table = mtk_venc_hw_ids,
> > +	},
> > +};
> > +module_platform_driver(mtk_venc_core_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("MediaTek video encoder core driver");
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> > new file mode 100644
> > index 000000000000..0ff544c20eb9
> > --- /dev/null
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2021 MediaTek Inc.
> > + */
> > +
> > +#ifndef _MTK_VCODEC_ENC_HW_H_
> > +#define _MTK_VCODEC_ENC_HW_H_
> > +
> > +#include <linux/platform_device.h>
> > +#include "mtk_vcodec_drv.h"
> > +
> > +/**
> > + * struct mtk_venc_hw_dev - driver data
> > + * @plat_dev: platform_device
> > + * @main_dev: main device
> > + * @pm: power management data
> > + * @curr_ctx: the context that is waiting for venc hardware
> > + * @reg_base: mapped address of venc registers
> > + * @irq_status: venc hardware irq status
> > + * @enc_irq: venc device irq
> > + * @hw_id: for venc hardware id: core#0, core#1...
> > + */
> > +struct mtk_venc_hw_dev {
> > +	struct platform_device *plat_dev;
> > +	struct mtk_vcodec_dev *main_dev;
> > +
> > +	struct mtk_vcodec_pm pm;
> > +	struct mtk_vcodec_ctx *curr_ctx;
> > +
> > +	void __iomem *reg_base;
> > +	unsigned int irq_status;
> > +	int enc_irq;
> > +	int hw_id;
> 
> For consistency, this should be `enum mtk_venc_hw_id hw_id;`

fix it in next version.
> 
> > +};
> > +
> > +#endif /* _MTK_VCODEC_ENC_HW_H_ */
> 
> Cheers,
> Angelo

Thanks
Best Regards

