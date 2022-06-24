Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFCD5595F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiFXJBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiFXJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:01:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079753BFBB;
        Fri, 24 Jun 2022 02:01:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA1B866017FA;
        Fri, 24 Jun 2022 10:00:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656061261;
        bh=0a4LN2Xv/2R17lSduW2ToqfNrWrNFnf/+npA9hiKOsU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lsBRTjbNyPOW9/ad+sWs/fw3bnIKqKwnDOIInfLBnXAffGknXZPX3g4fCEk2rbThv
         DWJEsXAiybhVuJWmyI3PZgO1Z3JJpo0s+Q2jO9xsJJC+x3O4Hi/hHaDC6lNS35nzs1
         OJH3CzJ4+q2De1wXMzgW7LAA7dj0GBjRMGYNCpFdNZ+z8uc1he95WEpLfATiUXuJUn
         wmBZldtJeBKEo6UnuunB3OcV9z1SM3SzipujhRHxxLUqNTFgF0vMOiAZX6mucXwqfm
         lcS9/MeKctwN5j1q889mlZV7wPTgzedRUGftRDUTk5gjeM+1RzRPO+uD/XZ4jwexHU
         lQ4w0AxvWcrNA==
Message-ID: <a8c3e22c-8f22-2fb9-ff23-f394c5c34366@collabora.com>
Date:   Fri, 24 Jun 2022 11:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4, 4/8] media: mediatek: vcodec: Add more extra
 processing for multi-core encoding
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
 <20220624082335.10165-5-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220624082335.10165-5-irui.wang@mediatek.com>
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
> Add a bit for indicating support multi-core encoding, because multi-core
> encoding need more working buffers for encoder hardware. The working
> buffers are allocated from kernel side then pass to scp firmware side
> through shared memory, the struct definition must be kept align between
> kernel and scp firmware side. New another shared memory struct for
> multi-core encoding.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   2 +
>   .../mediatek/vcodec/mtk_vcodec_util.c         |  19 ++
>   .../mediatek/vcodec/mtk_vcodec_util.h         |   2 +
>   .../mediatek/vcodec/venc/venc_h264_if.c       | 171 +++++++++++++++---
>   4 files changed, 170 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index 8919bdf2eef5..3a291cac6b5e 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -29,6 +29,8 @@
>   #define WAIT_INTR_TIMEOUT_MS	1000
>   #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
>   #define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
> +#define MTK_VENC_MULTICORE_ENABLE BIT(1)
> +#define IS_VENC_MULTICORE(capability) ((capability) & MTK_VENC_MULTICORE_ENABLE)
>   
>   /*
>    * enum mtk_hw_reg_idx - MTK hw register base index
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> index ace78c4b5b9e..a723243626c0 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> @@ -11,6 +11,7 @@
>   
>   #include "mtk_vcodec_dec_hw.h"
>   #include "mtk_vcodec_drv.h"
> +#include "mtk_vcodec_enc_hw.h"
>   #include "mtk_vcodec_util.h"
>   
>   void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
> @@ -26,6 +27,24 @@ void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
>   }
>   EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
>   
> +void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *ctx,
> +					 unsigned int hw_id)

This is enum mtk_venc_hw_id.....

> +{
> +	struct mtk_venc_hw_dev *sub_core;
> +
> +	if (hw_id >= MTK_VENC_HW_MAX) {
> +		mtk_v4l2_err("Invalid hw_id = %d", hw_id);
> +		return NULL;
> +	}
> +
> +	sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[hw_id];
> +	if (!sub_core)
> +		return NULL;
> +
> +	return sub_core->reg_base;
> +}
> +EXPORT_SYMBOL(mtk_venc_get_core_reg_addr);
> +
>   int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
>   			struct mtk_vcodec_mem *mem)
>   {
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index 71956627a0e2..a74c98aa355b 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -50,6 +50,8 @@ struct mtk_vcodec_dev;
>   
>   void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
>   				unsigned int reg_idx);
> +void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *data,
> +					 unsigned int hw_id);
>   int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
>   				struct mtk_vcodec_mem *mem);
>   void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> index 4d9b8798dffe..888cee39d324 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c

..snip..

> @@ -143,8 +184,8 @@ struct venc_h264_vsi {
>    * @ctx: context for v4l2 layer integration
>    */
>   struct venc_h264_inst {
> -	void __iomem *hw_base;
> -	struct mtk_vcodec_mem work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
> +	void __iomem *hw_base[MTK_VENC_HW_MAX];
> +	struct mtk_vcodec_mem work_bufs[VENC_MULTI_CORE_WORK_BUF_MAX];
>   	struct mtk_vcodec_mem pps_buf;
>   	bool work_buf_allocated;
>   	unsigned int frm_cnt;
> @@ -152,12 +193,13 @@ struct venc_h264_inst {
>   	unsigned int prepend_hdr;
>   	struct venc_vpu_inst vpu_inst;
>   	struct venc_h264_vsi *vsi;
> +	struct venc_multi_core_vsi *core_vsi;

You're adding a new struct member without adding it to the documentation,
please add it there too.

>   	struct mtk_vcodec_ctx *ctx;
>   };
>   
>   static inline u32 h264_read_reg(struct venc_h264_inst *inst, u32 addr)
>   {
> -	return readl(inst->hw_base + addr);
> +	return readl(inst->hw_base[MTK_VENC_CORE_0] + addr);
>   }
>   
>   static unsigned int h264_get_profile(struct venc_h264_inst *inst,
> @@ -228,13 +270,20 @@ static unsigned int h264_get_level(struct venc_h264_inst *inst,
>   static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
>   {
>   	int i;
> +	struct mtk_vcodec_ctx *ctx = inst->ctx;
> +	int max_work_buf;

int i, max_work_buf;

>   
>   	mtk_vcodec_debug_enter(inst);
>   
> +	if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
> +		max_work_buf = VENC_MULTI_CORE_WORK_BUF_MAX;
> +	else
> +		max_work_buf = VENC_H264_VPU_WORK_BUF_MAX;
> +
>   	/* Except the SKIP_FRAME buffers,
>   	 * other buffers need to be freed by AP.
>   	 */
> -	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
> +	for (i = 0; i < max_work_buf; i++) {
>   		if (i != VENC_H264_VPU_WORK_BUF_SKIP_FRAME)
>   			mtk_vcodec_mem_free(inst->ctx, &inst->work_bufs[i]);
>   	}
> @@ -248,11 +297,21 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst)
>   {
>   	int i;
>   	int ret = 0;
> -	struct venc_h264_vpu_buf *wb = inst->vsi->work_bufs;
> +	struct mtk_vcodec_ctx *ctx = inst->ctx;
> +	struct venc_h264_vpu_buf *wb;
> +	int max_work_buf;

While at it, can you please fix the order of these declarations?

	struct mtk_vcodec_ctx *ctx = inst->ctx;
	struct venc_h264_vpu_buf *wb;
	int i, max_work_buf;
	int ret = 0;

>   
>   	mtk_vcodec_debug_enter(inst);
>   
> -	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
> +	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
> +		wb = inst->core_vsi->work_bufs;
> +		max_work_buf = VENC_MULTI_CORE_WORK_BUF_MAX;
> +	} else {
> +		wb = inst->vsi->work_bufs;
> +		max_work_buf = VENC_H264_VPU_WORK_BUF_MAX;
> +	}
> +
> +	for (i = 0; i < max_work_buf; i++) {
>   		/*
>   		 * This 'wb' structure is set by VPU side and shared to AP for
>   		 * buffer allocation and IO virtual addr mapping. For most of
> @@ -358,6 +417,26 @@ static int h264_frame_type(struct venc_h264_inst *inst)
>   		return VENC_H264_P_FRM;  /* Note: B frames are not supported */
>   	}
>   }
> +
> +static int h264_core_frame_type(struct venc_h264_inst *inst)
> +{
> +	struct venc_multi_core_vsi *vsi = inst->core_vsi;
> +
> +	if ((vsi->config.gop_size != 0 &&
> +	     (inst->frm_cnt % vsi->config.gop_size) == 0) ||
> +	    (inst->frm_cnt == 0 && vsi->config.gop_size == 0)) {
> +		/* IDR frame */
> +		return VENC_H264_IDR_FRM;

You can get to a maximum of 100 columns and, thinking about readability...:

if ((vsi->config.gop_size != 0 && (inst->frm_cnt % vsi->config.gop_size) == 0) ||
     (inst->frm_cnt == 0 && vsi->config.gop_size == 0)) {

this gets to 90 columns, so it's acceptable (and more readable).


> +	} else if ((vsi->config.intra_period != 0 &&
> +		    (inst->frm_cnt % vsi->config.intra_period) == 0) ||
> +		   (inst->frm_cnt == 0 && vsi->config.intra_period == 0)) {

..but, unfortunately, this doesn't, so we have to live with it.

> +		/* I frame */
> +		return VENC_H264_I_FRM;
> +	} else {
> +		return VENC_H264_P_FRM;  /* Note: B frames are not supported */
> +	}
> +}
> +
>   static int h264_encode_sps(struct venc_h264_inst *inst,
>   			   struct mtk_vcodec_mem *bs_buf,
>   			   unsigned int *bs_size)
> @@ -440,12 +519,16 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
>   	int ret = 0;
>   	unsigned int irq_status;
>   	struct venc_frame_info frame_info;
> +	struct mtk_vcodec_ctx *ctx = inst->ctx;
>   
>   	mtk_vcodec_debug_enter(inst);
>   	mtk_vcodec_debug(inst, "frm_cnt = %d\n ", inst->frm_cnt);
>   	frame_info.frm_count = inst->frm_cnt;
>   	frame_info.skip_frm_count = inst->skip_frm_cnt;
> -	frame_info.frm_type = h264_frame_type(inst);
> +	if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
> +		frame_info.frm_type = h264_core_frame_type(inst);
> +	else
> +		frame_info.frm_type = h264_frame_type(inst);
>   	mtk_vcodec_debug(inst, "frm_count = %d,skip_frm_count =%d,frm_type=%d.\n",
>   			 frame_info.frm_count, frame_info.skip_frm_count,
>   			 frame_info.frm_type);
> @@ -501,7 +584,7 @@ static void h264_encode_filler(struct venc_h264_inst *inst, void *buf,
>   static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
>   {
>   	const bool is_ext = MTK_ENC_CTX_IS_EXT(ctx);
> -	int ret = 0;
> +	int ret, i;

Can you also move this after `inst` please?

>   	struct venc_h264_inst *inst;
>   

Cheers,
Angelo
