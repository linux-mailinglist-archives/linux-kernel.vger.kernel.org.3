Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9A4AC291
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443201AbiBGPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442451AbiBGOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:50:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44AC0401C2;
        Mon,  7 Feb 2022 06:50:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 89AB31F444AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644245435;
        bh=mITQyN74T8TrzhhNjUVWhdqcFowm7op0GVEcLUl0r3k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jscu1N6GY8MVTJJI2CzFQZ6jf4L7fmsfwr667QFfHNFSiTAD+RzEF7yTwlpPYY+3t
         A+rcbtV1RPtkgqOKVm/jiteSszWCmJa2jiZ553iEAKkwDioX4tzpOZasgUOvH6aTlK
         g858F61ZO4FxTqAhJK5IEjJEztTCohI0WJ5DMNXkd+xxTmRySp+38J1m7YOg+kgQMa
         YlytzZhi55wIsLw6MVIqwiHQQauf+/nRPUiTY2TEfUe4oNW4i/pfDSEuSRIlj+xnsa
         PNtXsenh4KMr3ZTqpAVCpi3Bqrdds3M/OrpKuiyRjdaKZbTL00xkPm0QqggoLy0LRv
         bc9VNH4XcwA6g==
Message-ID: <4e1b549b-748e-94f3-befb-59ceab950297@collabora.com>
Date:   Mon, 7 Feb 2022 15:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V6, 2/5] media: mtk-jpegenc: manage jpegenc multi-hardware
Content-Language: en-US
To:     "kyrie.wu" <kyrie.wu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com,
        irui.wang@mediatek.com
References: <1638501230-13417-1-git-send-email-kyrie.wu@mediatek.com>
 <1638501230-13417-3-git-send-email-kyrie.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1638501230-13417-3-git-send-email-kyrie.wu@mediatek.com>
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

Il 03/12/21 04:13, kyrie.wu ha scritto:
> manage each hardware information, including irq/clk/power.
> the hardware includes HW0 and HW1.
> 
> Signed-off-by: kyrie.wu <kyrie.wu@mediatek.com>

Hello Kyrie,
thanks for the patch!

However, there are a few things to improve...

> ---
> V6: use of_platform_populate to replace component framework
> to manage multi-hardware
> ---
>   drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c   | 103 +++++++---
>   drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h   |  55 +++++
>   drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c | 232 +++++++++++++++++++++-
>   3 files changed, 362 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index a89c7b2..da7eb84 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -1353,33 +1353,40 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
>   	spin_lock_init(&jpeg->hw_lock);
>   	jpeg->dev = &pdev->dev;
>   	jpeg->variant = of_device_get_match_data(jpeg->dev);
> -	INIT_DELAYED_WORK(&jpeg->job_timeout_work, mtk_jpeg_job_timeout_work);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	jpeg->reg_base = devm_ioremap_resource(&pdev->dev, res);

This has to be rebased... new versions are using devm_platform_ioremap_resource(),
which is shorter and cleaner...

> -	if (IS_ERR(jpeg->reg_base)) {
> -		ret = PTR_ERR(jpeg->reg_base);
> -		return ret;
> -	}
> +	if (!jpeg->variant->is_encoder) {

What about mediatek,mtk-jpgenc? That's also an encoder... this "is_encoder"
variable is a bit confusing... Is that a newer version of the IP?
Please, let's find a better name for this variable to avoid confusion.


> +		INIT_DELAYED_WORK(&jpeg->job_timeout_work,
> +				mtk_jpeg_job_timeout_work);
>   
> -	jpeg_irq = platform_get_irq(pdev, 0);
> -	if (jpeg_irq < 0) {
> -		dev_err(&pdev->dev, "Failed to get jpeg_irq %d.\n", jpeg_irq);
> -		return jpeg_irq;
> -	}
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		jpeg->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(jpeg->reg_base)) {
> +			ret = PTR_ERR(jpeg->reg_base);
> +			return ret;
> +		}
>   
> -	ret = devm_request_irq(&pdev->dev, jpeg_irq,
> -			       jpeg->variant->irq_handler, 0, pdev->name, jpeg);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
> -			jpeg_irq, ret);
> -		goto err_req_irq;
> -	}
> +		jpeg_irq = platform_get_irq(pdev, 0);
> +		if (jpeg_irq < 0) {
> +			dev_err(&pdev->dev, "Failed to get jpeg_irq.\n");
> +			return jpeg_irq;
> +		}
>   
> -	ret = mtk_jpeg_clk_init(jpeg);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to init clk, err %d\n", ret);
> -		goto err_clk_init;
> +		ret = devm_request_irq(&pdev->dev, jpeg_irq,
> +				       jpeg->variant->irq_handler,
> +					   0, pdev->name, jpeg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to request jpeg_irq %d (%d)\n",
> +				jpeg_irq, ret);
> +			goto err_req_irq;
> +		}
> +
> +		ret = mtk_jpeg_clk_init(jpeg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to init clk(%d)\n", ret);
> +			goto err_clk_init;
> +		}
> +
> +		pm_runtime_enable(&pdev->dev);
>   	}
>   
>   	ret = v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);

...snip...

/
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> index 1cf037b..4ccda1d 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> @@ -4,12 +4,27 @@
>    * Author: Xia Jiang <xia.jiang@mediatek.com>
>    *
>    */
> -
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
> @@ -30,6 +45,21 @@ static const struct mtk_jpeg_enc_qlt mtk_jpeg_enc_quality[] = {
>   	{.quality_param = 97, .hardware_value = JPEG_ENC_QUALITY_Q97},
>   };
>   
> +#if defined(CONFIG_OF)
> +static const struct of_device_id mtk_jpegenc_drv_ids[] = {

There's nothing special in jpgenc1 or, at least, nothing that really needs
us to differentiate between jpgenc0 and jpgenc1, apart knowing which core is
the "main" one, hence, you don't need a special compatible string for each core.

Here's my proposal:
- Use one compatible "mediatek,mt8195-jpgenc-hw"
- Add either of:
   - A bool "mediatek,hw-leader" on core 0; or
   - A u8 "mediatek,instance" (0, 1, 2 ... for core number)

A comment is required on "mediatek,instance" though... this way should only be
chosen if it is expected, in the future, to have the following situation on
newer SoCs:
- More than two cores, and
- non-interchangeable cores (meaning that, for example, frame 1 *shall* go to
   core 1, frame 2 shall go to core 2, frame 3 to core 3, BUT core 2/3 are not
   interchangeable, as in there are reasons to never process frame 2 on core 3),
   so this means that it's not important if Linux labels core 3 as core 2.

Otherwise, if it's not expected to have non-interchangeable "hw-follower" cores,
or if more than two cores are not ever expected, "mediatek,hw-leader" is the best
choice for this.

Example:

jpegenc@address {
	compatible = "mediatek,mt8195-jpgenc";
	reg = < .... >;
	ranges = < ....... >;
	.... other properties here ....

	jpegenc-hw0@relative-address {
		compatible = "mediatek,mt8195-jpgenc-hw", "mediatek,jpgenc-hw";
		iommus, interrupts, other properties here ...
		mediatek,hw-leader;
	};

	jpegenc-hw1@relative-address {
		compatible = "mediatek,mt8195-jpgenc-hw", "mediatek,jpgenc-hw";
		iommus, interrupts, etc.....
	};
};

> +	{
> +		.compatible = "mediatek,mt8195-jpgenc0",
> +		.data = (void *)MTK_JPEGENC_HW0,
> +	},
> +	{
> +		.compatible = "mediatek,mt8195-jpgenc1",
> +		.data = (void *)MTK_JPEGENC_HW1,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_jpegenc_drv_ids);
> +#endif
> +
>   void mtk_jpeg_enc_reset(void __iomem *base)
>   {
>   	writel(0, base + JPEG_ENC_RSTB);

Thanks,
Angelo

