Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3084AC29F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442793AbiBGPJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442452AbiBGOuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:50:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B361C0401C2;
        Mon,  7 Feb 2022 06:50:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 398861F444B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644245439;
        bh=Ju2Q5YwjY/LdNga4EoB41t6xw3DyFhmTZT8pPKyD1xI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oaFTUYvRYY60eNHWhaNtRSsVies+YMnhzdtJ+Bbe5HKv/sU+giIdxU7YGk5i6vX9C
         JFxLcTAtzSPpheVOyDCYr6OoyKAqDEq9EFgOyvsbd20C0LtSwrBFT6fzFKlEJtbmk0
         0CsH33VM8IVpNuNcLk+hDjxj/o47W0VGlYzyThdkzJsjHiCJLj16R43gfo1luP1rW4
         Am8CvuA2Yp3Bh0MgOqxTJc9OOgXzgtZyNLZETmTq1ZfOhP2r3saOYg6yhIAmtfFmTy
         v1thQMWM5I2nSfeq0YyPlz0m0Dhd0jFizEWGwe/iMLrxc4/tH1dh35MguKPph+JVOp
         Kx+ZQl1rF+4RQ==
Message-ID: <d91f056c-227f-7a01-9e9c-9b4d53ec04f4@collabora.com>
Date:   Mon, 7 Feb 2022 15:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V6, 3/5] media: mtk-jpegenc: add jpegenc timeout func
 interface
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
 <1638501230-13417-4-git-send-email-kyrie.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1638501230-13417-4-git-send-email-kyrie.wu@mediatek.com>
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
> Generalizes jpegenc timeout func interfaces to handle HW timeout.
> 
> Signed-off-by: kyrie.wu <kyrie.wu@mediatek.com>
> ---
> V6: no change
> ---
>   drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h   |  8 ++++++++
>   drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c | 23 +++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> index 7d013de..baab305 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> @@ -75,6 +75,12 @@ struct mtk_jpeg_variant {
>   	u32 cap_q_default_fourcc;
>   };
>   
> +struct mtk_jpeg_hw_param {
> +	struct vb2_v4l2_buffer *src_buffer;
> +	struct vb2_v4l2_buffer *dst_buffer;
> +	struct mtk_jpeg_ctx *curr_ctx;
> +};
> +
>   enum mtk_jpegenc_hw_id {
>   	MTK_JPEGENC_HW0,
>   	MTK_JPEGENC_HW1,
> @@ -122,6 +128,8 @@ struct mtk_jpegenc_comp_dev {
>   	struct mtk_jpeg_dev *master_dev;
>   	struct mtk_jpegenc_pm pm;
>   	int jpegenc_irq;
> +	struct delayed_work job_timeout_work;
> +	struct mtk_jpeg_hw_param hw_param;
>   };
>   
>   /**
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> index 4ccda1d..e62b875 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
> @@ -183,6 +183,24 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
>   	writel(ctx->restart_interval, base + JPEG_ENC_RST_MCU_NUM);
>   }
>   
> +static void mtk_jpegenc_timeout_work(struct work_struct *work)
> +{
> +	struct delayed_work *Pwork =
> +		container_of(work, struct delayed_work, work);
> +	struct mtk_jpegenc_comp_dev *cjpeg =
> +		container_of(Pwork, struct mtk_jpegenc_comp_dev,
> +		job_timeout_work);
> +	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
> +	struct vb2_v4l2_buffer *src_buf;
> +
> +	src_buf = cjpeg->hw_param.src_buffer;
> +
> +	mtk_jpeg_enc_reset(cjpeg->reg_base);
> +	clk_disable_unprepare(cjpeg->pm.venc_clk.clk_info->jpegenc_clk);

You disable and unprepare the clock, but you never turn it back on?

This will lead to unbalanced disable on module removal but, more importantly,
will lead to unclocked access after a timeout, for which the platform may or
may not crash, but the jpgenc hardware will be unrecoverable until performing
a full system reboot.

Please fix this.

> +	pm_runtime_put(cjpeg->pm.dev);
> +	v4l2_m2m_buf_done(src_buf, buf_state);
> +}
> +
>   static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
>   {
>   	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> @@ -194,6 +212,8 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
>   	struct mtk_jpegenc_comp_dev *jpeg = priv;
>   	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
>   
> +	cancel_delayed_work(&jpeg->job_timeout_work);
> +
>   	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
>   		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
>   	if (irq_status)
> @@ -322,6 +342,9 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
>   
>   	dev->plat_dev = pdev;
>   
> +	INIT_DELAYED_WORK(&dev->job_timeout_work,
> +		mtk_jpegenc_timeout_work);
> +
>   	ret = mtk_jpegenc_init_pm(dev);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to get jpeg enc clock source");


