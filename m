Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D281577F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiGRKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiGRKWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:22:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2841CFD5;
        Mon, 18 Jul 2022 03:22:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 973C66601A05;
        Mon, 18 Jul 2022 11:22:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658139741;
        bh=MBfaA4l7s9JZSP3+F+mJre4x0mO0iWTWc7gCQfQH6R4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bgKQqeZ3BSO/JrSFq+us7gOSiaS9QQL/nZTgdDc4xU8jGJ0dJmRNikSXK4TmbX+Uz
         TnfbQetMKhMfBw1xftjD7PcseM2CVl3zSs4wLmJW62qtZEvQtjckQ6NEZFyad5ch20
         /QPjynMzbLT7nIgxIzsSPkJXUL5wr2uxjEu+poJFShYOVXeHKhUyslIBQW1stXP9Vq
         SGorPakSM4X2nlNM6/DUUwpm/DaZoWoIxxqUa7ftVkHhhPpsumAfMMaSd9nP3j3vw/
         8LJVKVM0VhX12KGP5DLBiBsHPHei28IUtxug2Dawy+KjCpS1Kzy2lBClQdNFR8I/ea
         lepl1nve+GCiA==
Message-ID: <00dc6bff-d87a-0d80-fe20-ae70e5ad0c4f@collabora.com>
Date:   Mon, 18 Jul 2022 12:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V5,3/8] media: mtk-jpegdec: manage jpegdec multi-hardware
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
References: <20220716093408.29734-1-irui.wang@mediatek.com>
 <20220716093408.29734-4-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220716093408.29734-4-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/07/22 11:34, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> manage each hardware information, including irq/clk/power.
> the hardware includes HW0/HW1/HW2.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> 
> ---
>   drivers/media/platform/mediatek/jpeg/Makefile |   5 +-
>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  23 +++
>   .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  37 ++++
>   .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 172 ++++++++++++++++++
>   4 files changed, 235 insertions(+), 2 deletions(-)
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
> index 386d48cc4f59..a9e8be976bb0 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1100,6 +1100,10 @@ static void mtk_jpeg_multicore_enc_device_run(void *priv)
>   	queue_work(jpeg->workqueue, &ctx->jpeg_work);
>   }
>   
> +static void mtk_jpeg_multicore_dec_device_run(void *priv)
> +{

.... why is this function empty?!

> +}
> +
>   static void mtk_jpeg_dec_device_run(void *priv)
>   {
>   	struct mtk_jpeg_ctx *ctx = priv;
> @@ -1166,6 +1170,10 @@ static const struct v4l2_m2m_ops mtk_jpeg_multicore_enc_m2m_ops = {
>   	.device_run = mtk_jpeg_multicore_enc_device_run,
>   };
>   
> +static const struct v4l2_m2m_ops mtk_jpeg_multicore_dec_m2m_ops = {
> +	.device_run = mtk_jpeg_multicore_dec_device_run,
> +};
> +
>   static const struct v4l2_m2m_ops mtk_jpeg_dec_m2m_ops = {
>   	.device_run = mtk_jpeg_dec_device_run,
>   	.job_ready  = mtk_jpeg_dec_job_ready,
> @@ -1680,6 +1688,17 @@ static struct mtk_jpeg_variant mtk8195_jpegenc_drvdata = {
>   	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
>   };
>   
> +static const struct mtk_jpeg_variant mtk8195_jpegdec_drvdata = {
> +	.formats = mtk_jpeg_dec_formats,
> +	.num_formats = MTK_JPEG_DEC_NUM_FORMATS,
> +	.qops = &mtk_jpeg_dec_qops,
> +	.m2m_ops = &mtk_jpeg_multicore_dec_m2m_ops,
> +	.dev_name = "mtk-jpeg-dec",
> +	.ioctl_ops = &mtk_jpeg_dec_ioctl_ops,
> +	.out_q_default_fourcc = V4L2_PIX_FMT_JPEG,
> +	.cap_q_default_fourcc = V4L2_PIX_FMT_YUV420M,
> +};
> +
>   #if defined(CONFIG_OF)
>   static const struct of_device_id mtk_jpeg_match[] = {
>   	{
> @@ -1698,6 +1717,10 @@ static const struct of_device_id mtk_jpeg_match[] = {
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

..snip..

> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> index d2f25f43e852..232e81165dd3 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c

..snip..

> +
> +static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
> +{
> +	struct mtk_jpegdec_clk *jpegdec_clk;
> +	struct mtk_jpeg_dev *master_dev;
> +	struct mtk_jpegdec_comp_dev *dev;
> +	int ret, i;
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
> +
> +	if (!master_dev->is_jpgdec_multihw) {
> +		master_dev->is_jpgdec_multihw = true;
> +		for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
> +			master_dev->dec_hw_dev[i] = NULL;
> +	}
> +
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

Fix:
		return dev_err_probe(&pdev->dev, ret,

				     "Failed to register JPEGDEC irq handler.\n");


Regards,
Angelo
