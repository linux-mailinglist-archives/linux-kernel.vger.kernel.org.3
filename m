Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593CE5595EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiFXJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:01:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BA3D495;
        Fri, 24 Jun 2022 02:01:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DB0166017FB;
        Fri, 24 Jun 2022 10:01:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656061261;
        bh=ZQ8X5D1IcOUGbtwDqXDogzKGk9JzEqKZzM5dl1w1QGw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hlqWMd06ztelWQMlQv5HAJ3DKxwH7xmC+2xGhyp9EHOJzyqeT34ilM0tTCj59KY0x
         +It4PtJ1zVe53sEJ/uIu3WEweJDLWK2vQbmJTq/SD3MFMez0kkxWru9abEVi98QMuR
         mNrC0rYCewSGOYwZkPJBDgYfymUsVDdIsGZW1uusnhGmRnMZb5WnT70zojzmjoIWWs
         AP0HXg6IeBcSFa3xE357H5233ygcrZsc3dlhBes0g8goeavRcLqtDUDZeU3ZBi58Zo
         BePDUAalCzHTVEXHs3VrL9WOgTrWbh4aUjtdl0KUU4pq7MymIXw3fRmzfRKsP2+pQl
         zf1r3Zi7RTTRA==
Message-ID: <33f5dfdf-ca4b-15f5-ff75-cc27800bbea0@collabora.com>
Date:   Fri, 24 Jun 2022 11:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4, 2/8] media: mediatek: vcodec: Enable venc dual core
 usage
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        nicolas.dufresne@collabora.com
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220624082335.10165-1-irui.wang@mediatek.com>
 <20220624082335.10165-3-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220624082335.10165-3-irui.wang@mediatek.com>
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

Il 24/06/22 10:23, Irui Wang ha scritto:
> Adds new property to indicate whether the encoder has multiple cores.
> Use of_platform_populate to probe each venc cores, the core device can
> use the init_clk/request_irq helper to initialize their own power/clk/irq.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>   .../media/platform/mediatek/vcodec/Makefile   |   4 +-
>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  12 ++
>   .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  10 ++
>   .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 139 ++++++++++++++++++
>   .../mediatek/vcodec/mtk_vcodec_enc_hw.h       |  36 +++++
>   5 files changed, 200 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
>   create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/Makefile b/drivers/media/platform/mediatek/vcodec/Makefile
> index 93e7a343b5b0..ac068d88af29 100644
> --- a/drivers/media/platform/mediatek/vcodec/Makefile
> +++ b/drivers/media/platform/mediatek/vcodec/Makefile
> @@ -3,7 +3,8 @@
>   obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
>   				       mtk-vcodec-enc.o \
>   				       mtk-vcodec-common.o \
> -				       mtk-vcodec-dec-hw.o
> +				       mtk-vcodec-dec-hw.o \
> +				       mtk_vcodec_enc_hw.o
>   
>   mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
>   		vdec/vdec_vp8_if.o \
> @@ -32,6 +33,7 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
>   		venc_drv_if.o \
>   		venc_vpu_if.o \
>   
> +mtk-vcodec-enc-hw-y := mtk_vcodec_enc_hw.o
>   
>   mtk-vcodec-common-y := mtk_vcodec_intr.o \
>   		mtk_vcodec_util.o \
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index dc6aada882d9..8919bdf2eef5 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -97,6 +97,15 @@ enum mtk_fmt_type {
>   	MTK_FMT_FRAME = 2,
>   };
>   
> +/*
> + * enum mtk_venc_hw_id -- encoder hardware id
> + */
> +enum mtk_venc_hw_id {
> +	MTK_VENC_CORE_0 = 0,
> +	MTK_VENC_CORE_1,
> +	MTK_VENC_HW_MAX,
> +};
> +
>   /*
>    * enum mtk_vdec_hw_id - Hardware index used to separate
>    *                         different hardware
> @@ -484,6 +493,7 @@ struct mtk_vcodec_enc_pdata {
>    * @dec_active_cnt: used to mark whether need to record register value
>    * @vdec_racing_info: record register value
>    * @dec_racing_info_mutex: mutex lock used for inner racing mode
> + * @enc_hw_dev: used to store venc core device
>    */
>   struct mtk_vcodec_dev {
>   	struct v4l2_device v4l2_dev;
> @@ -534,6 +544,8 @@ struct mtk_vcodec_dev {
>   	u32 vdec_racing_info[132];
>   	/* Protects access to vdec_racing_info data */
>   	struct mutex dec_racing_info_mutex;
> +
> +	void *enc_hw_dev[MTK_VENC_HW_MAX];
>   };
>   
>   static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> index 95e8c29ccc65..65a8251a5a68 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> @@ -263,6 +263,16 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>   		goto err_enc_pm;
>   	}
>   
> +	if (of_property_read_bool(pdev->dev.of_node,
> +				  "mediatek,venc-multi-core")) {

You don't need this property here: just call of_platform_populate()
unconditionally. If there's no child node, this function will do nothing
so this conditional is useless and can be avoided.

> +		ret = of_platform_populate(pdev->dev.of_node,
> +					   NULL, NULL, &pdev->dev);
> +		if (ret) {
> +			mtk_v4l2_err("Venc core device populate failed");

What about "Failed to populate children devices" ?

> +			goto err_enc_pm;
> +		}
> +	}
> +
>   	pm_runtime_enable(&pdev->dev);
>   
>   	dev->reg_base[dev->venc_pdata->core_id] =
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
> new file mode 100644
> index 000000000000..02582cce4863
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include "mtk_vcodec_drv.h"
> +#include "mtk_vcodec_enc.h"
> +#include "mtk_vcodec_enc_hw.h"
> +#include "mtk_vcodec_intr.h"
> +
> +static const struct of_device_id mtk_venc_hw_ids[] = {
> +	{
> +		.compatible = "mediatek,mtk-venc-hw",
> +	},

Please compress this in one line.

> +	{},

Usually, we say that this is a sentinel.

	{ .compatible = "mediatek,mtk-venc-hw" },
	{ /* sentinel */ },

> +};
> +MODULE_DEVICE_TABLE(of, mtk_venc_hw_ids);
> +

..snip..

> +
> +static int mtk_venc_hw_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_venc_hw_dev *sub_core;
> +	struct mtk_vcodec_dev *main_dev;
> +	int ret;
> +
> +	if (!dev->parent)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "No parent for venc core device\n");
> +
> +	main_dev = dev_get_drvdata(dev->parent);
> +	if (!main_dev)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Failed to get parent driver data\n");
> +
> +	sub_core = devm_kzalloc(&pdev->dev, sizeof(*sub_core), GFP_KERNEL);
> +	if (!sub_core)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to get alloc core data\n");
> +
> +	sub_core->plat_dev = pdev;
> +
> +	platform_set_drvdata(pdev, sub_core);
> +
> +	sub_core->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sub_core->reg_base))
> +		return dev_err_probe(dev, PTR_ERR(sub_core->reg_base),
> +				     "Failed to get reg base\n");
> +
> +	sub_core->enc_irq = platform_get_irq(pdev, 0);
> +	if (sub_core->enc_irq < 0)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Failed to get irq resource\n");
> +
> +	ret = devm_request_irq(dev, sub_core->enc_irq,
> +			       mtk_enc_hw_irq_handler, 0,
> +			       pdev->name, sub_core);
> +	if (ret)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Failed to install sub_core->enc_irq %d\n",
> +				     sub_core->enc_irq);
> +
> +	of_property_read_u32(dev->of_node, "mediatek,hw-id",
> +			     &sub_core->hw_id);
> +

I'd do it like this, instead:

     ret = of_property_read_u32(dev->of_node, "mediatek,hw-id", &sub_core->hw_id);
     if (ret || sub_core->hw_id >= MTK_VENC_HW_MAX)
         return dev_err_probe(dev, (ret ? ret : -EINVAL),
                              "Cannot parse hardware id");

P.S.: you're reading an unsigned value from devicetree, this cannot ever be less
       than zero!

> +	if (sub_core->hw_id < 0 || sub_core->hw_id >= MTK_VENC_HW_MAX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid hardware id %d\n",
> +				     sub_core->hw_id);
> +
> +	main_dev->enc_hw_dev[sub_core->hw_id] = sub_core;
> +	sub_core->main_dev = main_dev;
> +
> +	dev_dbg(dev, "Venc core :%d probe done\n", sub_core->hw_id);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mtk_venc_core_driver = {
> +	.probe  = mtk_venc_hw_probe,
> +	.driver = {
> +		.name	 = "mtk-venc-core",
> +		.of_match_table = mtk_venc_hw_ids,
> +	},
> +};
> +module_platform_driver(mtk_venc_core_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("MediaTek video encoder core driver");
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> new file mode 100644
> index 000000000000..0ff544c20eb9
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#ifndef _MTK_VCODEC_ENC_HW_H_
> +#define _MTK_VCODEC_ENC_HW_H_
> +
> +#include <linux/platform_device.h>
> +#include "mtk_vcodec_drv.h"
> +
> +/**
> + * struct mtk_venc_hw_dev - driver data
> + * @plat_dev: platform_device
> + * @main_dev: main device
> + * @pm: power management data
> + * @curr_ctx: the context that is waiting for venc hardware
> + * @reg_base: mapped address of venc registers
> + * @irq_status: venc hardware irq status
> + * @enc_irq: venc device irq
> + * @hw_id: for venc hardware id: core#0, core#1...
> + */
> +struct mtk_venc_hw_dev {
> +	struct platform_device *plat_dev;
> +	struct mtk_vcodec_dev *main_dev;
> +
> +	struct mtk_vcodec_pm pm;
> +	struct mtk_vcodec_ctx *curr_ctx;
> +
> +	void __iomem *reg_base;
> +	unsigned int irq_status;
> +	int enc_irq;
> +	int hw_id;

For consistency, this should be `enum mtk_venc_hw_id hw_id;`

> +};
> +
> +#endif /* _MTK_VCODEC_ENC_HW_H_ */

Cheers,
Angelo
