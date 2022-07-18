Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76CC577FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiGRKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiGRKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:36:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A21F584;
        Mon, 18 Jul 2022 03:36:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20EB56601A05;
        Mon, 18 Jul 2022 11:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658140580;
        bh=iSwuLXDnaixNeYtjbh3kKjug8iTFfg+DwQcZxPKFB4U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W1rjXS+gHE1mn0A3nprW3zGjnLEJFTNW8RkL/QBefy02jWToxeWyghWXKuh7bMzqm
         ZZ5MTe1MVRmXZzi1Nxdz4Cz6jKW90snYGwfbLUFtm2LkEnRpb8wGkvhUEZXtX7B/Jx
         wSA3CKctUbzeFwE+1hYq7iONHK/R6gc30wvcoqfgETrj5duKABz/OfKYcPXE1ryOU9
         B7fWdtmouNzSgQwVtoHxaotTv7SgPEu+FGQdSjPS60v0yMOJmUfN4tNPPVK0ymEUpb
         g18ElU+S0sJykgWZraSv4vVTWwCqP02Thqo49IbDHL7Ub/PaKppfiTgi0l5pPqrEQi
         xHIaIvV3M1gQw==
Message-ID: <737fbc8c-8890-c4e0-c7f6-e2c4c1cb9725@collabora.com>
Date:   Mon, 18 Jul 2022 12:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V5,6/8] media: mtk-jpegdec: add output pic reorder interface
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
 <20220716093408.29734-7-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220716093408.29734-7-irui.wang@mediatek.com>
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
> add output reorder func to reorder the output images
> to ensure the output pic is consistent with the input images.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> 
> ---
>   .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 49 ++++++++++++++++++-
>   1 file changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> index 590300108bff..c0468cf96d74 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
> @@ -440,6 +440,51 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
>   }
>   EXPORT_SYMBOL_GPL(mtk_jpeg_dec_set_config);
>   
> +static void mtk_jpegdec_put_buf(struct mtk_jpegdec_comp_dev *jpeg)
> +{
> +	struct mtk_jpeg_src_buf *dst_done_buf, *tmp_dst_done_buf;
> +	struct vb2_v4l2_buffer *dst_buffer;
> +	struct list_head *temp_entry;
> +	struct list_head *pos = NULL;
> +	struct mtk_jpeg_ctx *ctx;
> +	unsigned long flags;
> +
> +	ctx = jpeg->hw_param.curr_ctx;
> +	if (unlikely(!ctx)) {
> +		dev_err(jpeg->dev, "comp_jpeg ctx fail !!!\n");
> +		return;
> +	}
> +
> +	dst_buffer = jpeg->hw_param.dst_buffer;
> +	if (!dst_buffer) {
> +		dev_err(jpeg->dev, "comp_jpeg dst_buffer fail !!!\n");
> +		return;
> +	}
> +
> +	dst_done_buf = container_of(dst_buffer, struct mtk_jpeg_src_buf, b);
> +
> +	spin_lock_irqsave(&ctx->done_queue_lock, flags);
> +	list_add_tail(&dst_done_buf->list, &ctx->dst_done_queue);
> +	while (!list_empty(&ctx->dst_done_queue) &&
> +	       (pos != &ctx->dst_done_queue)) {
> +		list_for_each_prev_safe(pos,
> +					temp_entry,
> +					(&ctx->dst_done_queue)) {

This fits in one line, as it results in being 81 columns long, and parenthesis
are redundant for dst_done_queue.

Everything else looks ok to me.

Regards,
Angelo
