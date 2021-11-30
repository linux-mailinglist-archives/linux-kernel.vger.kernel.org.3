Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB6446354D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhK3NYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:24:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53546 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbhK3NYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:24:12 -0500
Received: from [IPv6:2a01:e0a:120:3210:b422:9841:4afb:11b5] (unknown [IPv6:2a01:e0a:120:3210:b422:9841:4afb:11b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8F1921F44745;
        Tue, 30 Nov 2021 13:20:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638278452; bh=ONtyTVbL9fzmae3u6JbAr4lLFBVbozE7teHyM5lzILY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kl0ov2l5bz3CJRqCATSlOhgO7ZxikuoVtLKnBnQu8qEHSb3uuJzN5FNyTa0qdKW4V
         AcMIndG08QboHmeExDe9NApyEdmBMc5ltEAK3FA7YB2+kE32yHbk6VQdJPwN1w7xW1
         CCYEN/NvxOoiAQK3Lh9GX03SIFhhFc/8lG7fmS8q/QZPQrEo+bCFvFJyUIGWYymQ3k
         Lopycg7AwhdQCAw41zCUbZZHOPM4hi+xShh/zBHNmw/iKbBVT9ONjgnBO9KwvR/I4Q
         y/2w4scJXFxL3cTWd7465ewsyfGyCnamKFXvDvteyr+uFNnbZfxQFWFIQMMk6JEXwR
         0zV1hVgqIiByQ==
Subject: Re: [PATCH v11, 01/19] media: mtk-vcodec: Get numbers of register
 bases from DT
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211129034201.5767-1-yunfei.dong@mediatek.com>
 <20211129034201.5767-2-yunfei.dong@mediatek.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <5e350a02-eb4b-5080-8d13-fe01ccf5dd70@collabora.com>
Date:   Tue, 30 Nov 2021 14:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 29/11/2021 à 04:41, Yunfei Dong a écrit :
> Different platform may has different numbers of register bases. Gets the
> numbers of register bases from DT (sizeof(u32) * 4 bytes for each).
>
> Reviewed-by: Tzung-Bi Shih<tzungbi@google.com>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 37 ++++++++++++++-----
>   1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> index e6e6a8203eeb..59caf2163349 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> @@ -78,6 +78,30 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
>   	return IRQ_HANDLED;
>   }
>   
> +static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
> +{
> +	struct platform_device *pdev = dev->plat_dev;
> +	int reg_num, i;
> +
> +	/* Sizeof(u32) * 4 bytes for each register base. */
> +	reg_num = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
> +		sizeof(u32) * 4);

It looks strange for me to have a "reg" size equal to sizeof(u32) * 4. Usually
we more see reg size = sizeof(u32).

> +	if (reg_num <= 0 || reg_num > NUM_MAX_VDEC_REG_BASE) {

If reg_num = NUM_MAX_VDEC_REG_BASE you will iterate out of bounds of dev->reg_base array.
That never happens because dev->reg_base size equal NUM_MAX_VCODEC_REG_BASE.
The question is what is the real needed size for dev->reg_base array ? NUM_MAX_VDEC_REG_BASE or
NUM_MAX_VCODEC_REG_BASE ?

Regards,
Benjamin

> +		dev_err(&pdev->dev, "Invalid register property size: %d\n", reg_num);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < reg_num; i++) {
> +		dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
> +		if (IS_ERR(dev->reg_base[i]))
> +			return PTR_ERR(dev->reg_base[i]);
> +
> +		mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
> +	}
> +
> +	return 0;
> +}
> +
>   static int fops_vcodec_open(struct file *file)
>   {
>   	struct mtk_vcodec_dev *dev = video_drvdata(file);
> @@ -206,7 +230,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>   	struct resource *res;
>   	phandle rproc_phandle;
>   	enum mtk_vcodec_fw_type fw_type;
> -	int i, ret;
> +	int ret;
>   
>   	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>   	if (!dev)
> @@ -238,14 +262,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>   		goto err_dec_pm;
>   	}
>   
> -	for (i = 0; i < NUM_MAX_VDEC_REG_BASE; i++) {
> -		dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
> -		if (IS_ERR((__force void *)dev->reg_base[i])) {
> -			ret = PTR_ERR((__force void *)dev->reg_base[i]);
> -			goto err_res;
> -		}
> -		mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
> -	}
> +	ret = mtk_vcodec_get_reg_bases(dev);
> +	if (ret)
> +		goto err_res;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>   	if (res == NULL) {
