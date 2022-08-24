Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10659FACB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiHXNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiHXNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237697D55;
        Wed, 24 Aug 2022 06:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E1361629;
        Wed, 24 Aug 2022 13:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564E2C43470;
        Wed, 24 Aug 2022 13:02:34 +0000 (UTC)
Message-ID: <27263bbf-10d0-174d-38b4-5d6b0a6bc9bd@xs4all.nl>
Date:   Wed, 24 Aug 2022 15:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH, v2] media: mediatek: vcodec: Add to support VP9 inner
 racing mode
Content-Language: en-US
To:     Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Irui Wang <irui.wang@mediatek.com>,
        George Sun <george.sun@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20220727061310.2307-1-mingjia.zhang@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220727061310.2307-1-mingjia.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingjia,

On 27/07/2022 08:13, Mingjia Zhang wrote:
> In order to reduce decoder latency, enable VP9 inner racing mode.
> Send lat trans buffer information to core when trigger lat to work,
> need not to wait until lat decode done.
> 
> Signed-off-by: mingjia zhang <mingjia.zhang@mediatek.com>

I'm getting this compile warning:

drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c: In function 'vdec_vp9_slice_core_decode':
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:2218:50: warning: 'instance' may be used uninitialized in this function [-Wmaybe-uninitialized]
 2218 |                 if (IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
      |                                                  ^~

I think you need to take a close look at the error handling in vdec_vp9_slice_core_decode().

After each error there is a 'goto err;' and that will run the new code, and that doesn't
feel right.

Regards,

	Hans

> ---
> 1. CTS/GTS test pass
> 2. Fluster result: Ran 240/303 tests successfully
> ---
>  .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 64 ++++++++++++-------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index fb1c36a3592d..92b47f0fdf40 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -436,6 +436,7 @@ struct vdec_vp9_slice_ref {
>   * @frame_ctx:		4 frame context according to VP9 Spec
>   * @frame_ctx_helper:	4 frame context according to newest kernel spec
>   * @dirty:		state of each frame context
> + * @local_vsi:		local instance vsi information
>   * @init_vsi:		vsi used for initialized VP9 instance
>   * @vsi:		vsi used for decoding/flush ...
>   * @core_vsi:		vsi used for Core stage
> @@ -482,6 +483,8 @@ struct vdec_vp9_slice_instance {
>  	struct v4l2_vp9_frame_context frame_ctx_helper;
>  	unsigned char dirty[4];
>  
> +	struct vdec_vp9_slice_vsi local_vsi;
> +
>  	/* MicroP vsi */
>  	union {
>  		struct vdec_vp9_slice_init_vsi *init_vsi;
> @@ -1616,16 +1619,10 @@ static int vdec_vp9_slice_update_single(struct vdec_vp9_slice_instance *instance
>  }
>  
>  static int vdec_vp9_slice_update_lat(struct vdec_vp9_slice_instance *instance,
> -				     struct vdec_lat_buf *lat_buf,
> -				     struct vdec_vp9_slice_pfc *pfc)
> +				     struct vdec_vp9_slice_vsi *vsi)
>  {
> -	struct vdec_vp9_slice_vsi *vsi;
> -
> -	vsi = &pfc->vsi;
> -	memcpy(&pfc->state[0], &vsi->state, sizeof(vsi->state));
> -
>  	mtk_vcodec_debug(instance, "Frame %u LAT CRC 0x%08x %lx %lx\n",
> -			 pfc->seq, vsi->state.crc[0],
> +			 (instance->seq - 1), vsi->state.crc[0],
>  			 (unsigned long)vsi->trans.dma_addr,
>  			 (unsigned long)vsi->trans.dma_addr_end);
>  
> @@ -2090,6 +2087,13 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  		return ret;
>  	}
>  
> +	if (IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability)) {
> +		vdec_vp9_slice_vsi_from_remote(vsi, instance->vsi, 0);
> +		memcpy(&instance->local_vsi, vsi, sizeof(*vsi));
> +		vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
> +		vsi = &instance->local_vsi;
> +	}
> +
>  	if (instance->irq) {
>  		ret = mtk_vcodec_wait_for_done_ctx(ctx,	MTK_INST_IRQ_RECEIVED,
>  						   WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
> @@ -2102,22 +2106,25 @@ static int vdec_vp9_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
>  	}
>  
>  	vdec_vp9_slice_vsi_from_remote(vsi, instance->vsi, 0);
> -	ret = vdec_vp9_slice_update_lat(instance, lat_buf, pfc);
> +	ret = vdec_vp9_slice_update_lat(instance, vsi);
>  
> -	/* LAT trans full, no more UBE or decode timeout */
> -	if (ret) {
> -		mtk_vcodec_err(instance, "VP9 decode error: %d\n", ret);
> -		return ret;
> -	}
> +	if (!IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
> +		/* LAT trans full, no more UBE or decode timeout */
> +		if (ret) {
> +			mtk_vcodec_err(instance, "frame[%d] decode error: %d\n",
> +				       ret, (instance->seq - 1));
> +			return ret;
> +		}
>  
> -	mtk_vcodec_debug(instance, "lat dma addr: 0x%lx 0x%lx\n",
> -			 (unsigned long)pfc->vsi.trans.dma_addr,
> -			 (unsigned long)pfc->vsi.trans.dma_addr_end);
>  
> -	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue,
> -				       vsi->trans.dma_addr_end +
> -				       ctx->msg_queue.wdma_addr.dma_addr);
> -	vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
> +	vsi->trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
> +	vdec_msg_queue_update_ube_wptr(&ctx->msg_queue, vsi->trans.dma_addr_end);
> +	if (!IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
> +		vdec_msg_queue_qbuf(&ctx->dev->msg_queue_core_ctx, lat_buf);
> +
> +	mtk_vcodec_debug(instance, "lat trans end addr(0x%lx), ube start addr(0x%lx)\n",
> +			 (unsigned long)vsi->trans.dma_addr_end,
> +			 (unsigned long)ctx->msg_queue.wdma_addr.dma_addr);
>  
>  	return 0;
>  }
> @@ -2193,10 +2200,14 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
>  		goto err;
>  	}
>  
> -	pfc->vsi.trans.dma_addr_end += ctx->msg_queue.wdma_addr.dma_addr;
>  	mtk_vcodec_debug(instance, "core dma_addr_end 0x%lx\n",
>  			 (unsigned long)pfc->vsi.trans.dma_addr_end);
> -	vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
> +
> +	if (IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
> +		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr);
> +	else
> +		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
> +
>  	ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req);
>  
>  	return 0;
> @@ -2204,7 +2215,12 @@ static int vdec_vp9_slice_core_decode(struct vdec_lat_buf *lat_buf)
>  err:
>  	if (ctx && pfc) {
>  		/* always update read pointer */
> -		vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dma_addr_end);
> +		if (IS_VDEC_INNER_RACING(instance->ctx->dev->dec_capability))
> +			vdec_msg_queue_update_ube_rptr(&ctx->msg_queue,
> +						       pfc->vsi.trans.dma_addr);
> +		else
> +			vdec_msg_queue_update_ube_rptr(&ctx->msg_queue,
> +						       pfc->vsi.trans.dma_addr_end);
>  
>  		if (fb)
>  			ctx->dev->vdec_pdata->cap_to_disp(ctx, 1, lat_buf->src_buf_req);
