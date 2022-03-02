Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5B4CA113
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbiCBJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiCBJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:45:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DD7EDA3;
        Wed,  2 Mar 2022 01:45:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 411D01F410A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646214309;
        bh=zrznIpBFL8LiCItblwyMn7DORd4urUBkf/OPWsULH8s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RWxbwhcNszQIibXpghBJ1fzAbnZAgqcSmSelbPLSfSIwt7OXxk9yODmdAFrjXk2KL
         kS1JCVexs9zuid8LlT1s/WEbQcTI8mnKEsoV0VAqrDiSLn3eAIh6uNOzAw51UFJ1W1
         TNf/vIHnU7s9cp/BH6wBhd9F9nqApEE/EQc52d7svGIN5kOl8O8rRlPQkvMVfjFeLt
         tm8OM2E/F6H1/RGQUAGju+kIir9elWnhAmwVtAoIE84KAuGtvigKg1u6G2ihFZFbFy
         Jei4dABf+536KNiQ8ugLQs9gJcKZNUBnT39S9Kpr5LQwhIQA+u8C/GAgv38dmrO25S
         7Bk2fbYCNuMiw==
Message-ID: <dee15f20-0f7d-58c6-728b-3e14f84f0833@collabora.com>
Date:   Wed, 2 Mar 2022 10:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RESEND,V7,3/6] media: mtk-jpegenc: manage jpegenc multi-hardware
Content-Language: en-US
To:     "kyrie.wu" <kyrie.wu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
References: <1645693637-627-1-git-send-email-kyrie.wu@mediatek.com>
 <1645693637-627-4-git-send-email-kyrie.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1645693637-627-4-git-send-email-kyrie.wu@mediatek.com>
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

Il 24/02/22 10:07, kyrie.wu ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> manage each hardware information, including irq/clk/power.
> the hardware includes HW0 and HW1.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>   drivers/media/platform/mtk-jpeg/Makefile      |  11 +-
>   .../media/platform/mtk-jpeg/mtk_jpeg_core.c   |  76 +++++---
>   .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  37 ++++
>   .../media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c | 168 ++++++++++++++++++
>   4 files changed, 267 insertions(+), 25 deletions(-)
> 

Hello Kyrie,

despite my v6 review, where I also gave you solutions for an issue with
more than one example, this v7 still didn't get one out of the many
requested fixes.

I'm sure that this was not intentional, so it's not a problem...

In any case, this gave me the opportunity to see some more issues inside
of this patch: let's get it perfect!


...snip...

> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> index 3e4811a41ba2..31e941ef84bd 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> @@ -9,6 +9,7 @@
>   #ifndef _MTK_JPEG_CORE_H
>   #define _MTK_JPEG_CORE_H
>   
> +#include <linux/clk.h>
>   #include <linux/interrupt.h>
>   #include <media/v4l2-ctrls.h>
>   #include <media/v4l2-device.h>
> @@ -60,6 +61,7 @@ enum mtk_jpeg_ctx_state {
>    * @cap_q_default_fourcc:	capture queue default fourcc
>    */
>   struct mtk_jpeg_variant {
> +	bool is_multihw;

Thanks for this fix, this name makes it way clearer!

>   	struct clk_bulk_data *clks;
>   	int num_clks;
>   	struct mtk_jpeg_fmt *formats;
> @@ -74,6 +76,38 @@ struct mtk_jpeg_variant {
>   	u32 cap_q_default_fourcc;
>   };
>   
> +enum mtk_jpegenc_hw_id {
> +	MTK_JPEGENC_HW0,
> +	MTK_JPEGENC_HW1,
> +	MTK_JPEGENC_HW_MAX,
> +};
> +
> +/**
> + * struct mtk_vcodec_clk - Structure used to store vcodec clock information
> + */
> +struct mtk_jpegenc_clk {
> +	struct clk_bulk_data *clks;
> +	int	clk_num;

Why is clk_num tabbed?

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

You're using tabulations *and* spaces.... please use either, not both, as it's
not necessary. Besides, this is also producing bad indentation.

> + */
> +struct mtk_jpegenc_comp_dev {
> +	struct device		*dev;
> +	struct platform_device *plat_dev;
> +	void __iomem		*reg_base;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegenc_clk	venc_clk;
> +	int jpegenc_irq;
> +};
> +
>   /**
>    * struct mtk_jpeg_dev - JPEG IP abstraction
>    * @lock:		the mutex protecting this structure
> @@ -100,6 +134,9 @@ struct mtk_jpeg_dev {
>   	void __iomem		*reg_base;
>   	struct delayed_work job_timeout_work;
>   	const struct mtk_jpeg_variant *variant;
> +
> +	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
> +	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
>   };
>   
>   /**
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> index a2b6e1f85c2d..3d967bff1352 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> @@ -5,11 +5,27 @@
>    *
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
>   #include <media/videobuf2-dma-contig.h>
> +#include <media/videobuf2-v4l2.h>
> +#include <media/v4l2-mem2mem.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-event.h>
>   
> +#include "mtk_jpeg_core.h"
>   #include "mtk_jpeg_enc_hw.h"
>   
>   static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_quality[] = {
> @@ -30,6 +46,21 @@ static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_quality[] = {
>   	{.quality_param = 97, .hardware_value = JPEG_ENC_QUALITY_Q97},
>   };
>   
> +#if defined(CONFIG_OF)
> +static const struct of_device_id mtk_jpegenc_drv_ids[] = {
> +	{
> +		.compatible = "mediatek,mt8195-jpgenc0",
> +		.data = (void *)MTK_JPEGENC_HW0,
> +	},
> +	{
> +		.compatible = "mediatek,mt8195-jpgenc1",
> +		.data = (void *)MTK_JPEGENC_HW1,
> +	},

I've already pointed out an issue with this in your v6 series:

https://patchwork.kernel.org/comment/24726607/

Besides, I want to add up that the SoC distinction is already done in the
parent node which, in MT8195's case, is named "mediatek,mt8195-jpgenc", so
you really don't have to redo this distinction "from scratch" here in the
sub-driver, as you can just get your information from the parent device/node.

So, just "mediatek,jpgenc-hw" should be totally enough here.

Please fix this for v8.


> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_jpegenc_drv_ids);
> +#endif
> +
>   void mtk_jpeg_enc_reset(void __iomem *base)
>   {
>   	writel(0, base + JPEG_ENC_RSTB);

...snip...

> +
> +static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
> +{
> +	struct mtk_jpegenc_clk *jpegenc_clk;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegenc_comp_dev *dev;
> +	int ret, comp_idx;
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
> +
> +	jpegenc_clk = &dev->venc_clk;
> +
> +	jpegenc_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
> +						     &jpegenc_clk->clks);

Using dev_err_probe() looks more appropriate here:

	if (jpegenc_clk->clk_num < 0)
		return dev_err_probe(&pdev->dev, jpegenc_clk->clk_num,
				     "Failed to get jpegenc clocks\n");


> +	if (jpegenc_clk->clk_num < 0) {
> +		dev_err(&pdev->dev, "Failed to get jpegenc clock count\n");
> +		return jpegenc_clk->clk_num;
> +	}
> +
> +	dev->reg_base =
> +		devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dev->reg_base)) {
> +		ret = PTR_ERR(dev->reg_base);
> +		goto err;

There's no need for any goto here, as you're not reverting any operation.

Hence, you can just:

	if (IS_ERR(dev->reg_base))
		return PTR_ERR(dev->reg_base);

> +	}
> +
> +	ret = mtk_jpegenc_hw_init_irq(dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register JPEGENC irq handler.\n");

You are already printing an error inside of mtk_jpegenc_hw_init_irq(), so printing
another one here is redundant.
Either remove the prints in the function or, more appropriately, remove this print.

Also, same "goto" comment applies here, you can simply return ret.

> +		goto err;
> +	}
> +
> +	comp_idx = (enum mtk_jpegenc_hw_id)of_device_get_match_data(decs);
> +	if (comp_idx < MTK_JPEGENC_HW_MAX) {

`comp_idx` is a bit misleading, this is not using the component framework.

....but this will probably be refactored after following the suggestion that
I gave you in v6 and again now.

> +		master_dev->enc_hw_dev[comp_idx] = dev;
> +		master_dev->reg_encbase[comp_idx] = dev->reg_base;
> +		dev->master_dev = master_dev;
> +	} else {
> +		dev_err(&pdev->dev, "Failed to get_match_data.\n");
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +err:

This label serves no real purpose: please remove.

> +	return ret;
> +}
> +



Regards,
Angelo
