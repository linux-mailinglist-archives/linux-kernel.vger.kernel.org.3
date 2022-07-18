Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C497577FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiGRKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiGRKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:40:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805F1EC68;
        Mon, 18 Jul 2022 03:40:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04F2B6601A05;
        Mon, 18 Jul 2022 11:40:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658140824;
        bh=yNapTY+IvffaTEBI0X0/kdVvwYn1/gbJNowfTGMSXNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P3/OcjQmqoB7/8Udziy16ptBdaRSZGwqC1/9u9iV81kc/CEfjdb4P3q37+93nkk40
         VAS6HqybxkEA6xt/AXEZqtS/MOKPwr7kXRK90kpfZSkor6QlWyRtbMdFJISFT1b+lR
         63JXc8xvhZ1vz/ScnipFicFwgFu6hAnXCXywkhvbwUYPr+FSi67CQc3JYXp5BcpvaY
         noH2JcuXi53v2hlmf9vHu7JEU29M6Evphoae9gCc23oKPj1yB362X7ZdprHCzg9/fA
         IgN4LxJhRBf8rIzmMcG4u3GffxzfwEgYlKkM0fYoslVFEWx/kKywhUY4Uq9OcWXpSS
         Tx8BwA3W+BiKQ==
Message-ID: <f8618c29-167b-a627-e4b1-d117ec860b7e@collabora.com>
Date:   Mon, 18 Jul 2022 12:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V11,3/7] mtk-jpegenc: manage jpegenc multi-hardware
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
References: <20220716093435.29796-1-irui.wang@mediatek.com>
 <20220716093435.29796-4-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220716093435.29796-4-irui.wang@mediatek.com>
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
> the hardware includes HW0 and HW1.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> 
> ---
>   drivers/media/platform/mediatek/jpeg/Makefile |  11 +-
>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |  94 ++++++----
>   .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  37 ++++
>   .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 163 ++++++++++++++++++
>   4 files changed, 272 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/Makefile b/drivers/media/platform/mediatek/jpeg/Makefile
> index 76c33aad0f3f..69703db4b0a5 100644
> --- a/drivers/media/platform/mediatek/jpeg/Makefile
> +++ b/drivers/media/platform/mediatek/jpeg/Makefile
> @@ -1,6 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -mtk_jpeg-objs := mtk_jpeg_core.o \
> +obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) += mtk_jpeg.o \
> +	mtk-jpeg-enc-hw.o
> +
> +mtk_jpeg-y := mtk_jpeg_core.o \
>   		 mtk_jpeg_dec_hw.o \
> -		 mtk_jpeg_dec_parse.o \
> -		 mtk_jpeg_enc_hw.o
> -obj-$(CONFIG_VIDEO_MEDIATEK_JPEG) += mtk_jpeg.o
> +		 mtk_jpeg_dec_parse.o
> +
> +mtk-jpeg-enc-hw-y := mtk_jpeg_enc_hw.o
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 724fb7aeb0ee..3286e9606505 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c

..snip..

> @@ -1497,6 +1516,18 @@ static const struct mtk_jpeg_variant mtk_jpeg_drvdata = {
>   	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
>   };
>   
> +static struct mtk_jpeg_variant mtk8195_jpegenc_drvdata = {

mt8195_jpegenc_drvdata, or mtk_jpegenc_multicore_drvdata

(same applies for jpegdec)

> +	.formats = mtk_jpeg_enc_formats,
> +	.num_formats = MTK_JPEG_ENC_NUM_FORMATS,
> +	.qops = &mtk_jpeg_enc_qops,
> +	.m2m_ops = &mtk_jpeg_multicore_enc_m2m_ops,

Same comment for jpgenc as well: add support for this device after adding support
for multicore encoder.

> +	.dev_name = "mtk-jpeg-enc",
> +	.ioctl_ops = &mtk_jpeg_enc_ioctl_ops,
> +	.out_q_default_fourcc = V4L2_PIX_FMT_YUYV,
> +	.cap_q_default_fourcc = V4L2_PIX_FMT_JPEG,
> +};
> +
> +#if defined(CONFIG_OF)
>   static const struct of_device_id mtk_jpeg_match[] = {
>   	{
>   		.compatible = "mediatek,mt8173-jpgdec",
> @@ -1510,10 +1541,15 @@ static const struct of_device_id mtk_jpeg_match[] = {
>   		.compatible = "mediatek,mtk-jpgenc",
>   		.data = &mtk_jpeg_drvdata,
>   	},
> +	{
> +		.compatible = "mediatek,mt8195-jpgenc",
> +		.data = &mtk8195_jpegenc_drvdata,
> +	},
>   	{},
>   };
>   
>   MODULE_DEVICE_TABLE(of, mtk_jpeg_match);
> +#endif
>   
>   static struct platform_driver mtk_jpeg_driver = {
>   	.probe = mtk_jpeg_probe,




