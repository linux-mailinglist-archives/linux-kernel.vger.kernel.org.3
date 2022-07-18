Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B35780C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiGRLcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiGRLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:32:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C51F623;
        Mon, 18 Jul 2022 04:31:58 -0700 (PDT)
X-UUID: 01ff983e96244e6f9108450886d66057-20220718
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:65230eb4-3ba3-4a49-9e51-2c67be9766d9,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:b2539864-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 01ff983e96244e6f9108450886d66057-20220718
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1194593640; Mon, 18 Jul 2022 19:31:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 18 Jul 2022 19:31:51 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 18 Jul 2022 19:31:50 +0800
Message-ID: <3f01cd582049611894f62ea3c27024687df96005.camel@mediatek.com>
Subject: Re: [PATCH 1/5] media: mediatek: vcodec: Add encoder driver support
 for 34-bit iova
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 18 Jul 2022 19:31:50 +0800
In-Reply-To: <7967c1df-ec41-e5ee-021d-d671021bc779@collabora.com>
References: <20220716093808.29894-1-irui.wang@mediatek.com>
         <20220716093808.29894-2-irui.wang@mediatek.com>
         <7967c1df-ec41-e5ee-021d-d671021bc779@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Angelo,

Thanks for your reviewing.

On Mon, 2022-07-18 at 11:51 +0200, AngeloGioacchino Del Regno wrote:
> Il 16/07/22 11:38, Irui Wang ha scritto:
> > Encoder driver got iova from IOMMU is 34-bit, for example:
> > 
> > Here is the sample code:
> > encoder input frame buffer dma address is:
> > frm_buf =
> >      vb2_dma_contig_plane_dma_addr(&vb2_v4l2_buffer->vb2_buf, 0);
> > the value of frm_buf is 0x1_ff30_0000.
> > 
> > encoder driver got the frm_buf and send the iova to SCP firmware
> > through SCP IPI message, then write to encoder hardware in SCP.
> > The iova is stored in IPI message as uint32_t data type, so the
> > value will be truncated from *0x1_ff30_0000* to *0xff30_0000*,
> > and then *0xff30_0000* will be written to encoder hardware, but
> > IOMMU will help to add the high *0x1_* bit back, so IOMMU can
> > translate the iova to PA correctly, encoder hardware can access
> > the correct memory for encoding.
> > Another reason to do this is the encoder hardware can't access
> > the 34-bit iova, IOMMU will help to add the remaining high bits
> > of iova. But for mt8188, encoder hardware can access 34-bit iova
> > directly, and encoder driver need write all 34-bit iova because
> > IOMMU can't help driver do this if the hardware support access
> > 34-bit iova.
> > For the reasons above, this patch is added to support transfer
> > 34-bit iova between kernel and SCP encoder driver. Use uint64_t
> > data type to store the iova, for compatibility with old chipsets,
> > add some new struct definitions for 34-bit.
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   3 +
> >   .../mediatek/vcodec/venc/venc_h264_if.c       | 200
> > +++++++++++++++---
> >   .../platform/mediatek/vcodec/venc_ipi_msg.h   |  24 +++
> >   .../platform/mediatek/vcodec/venc_vpu_if.c    |  34 ++-
> >   4 files changed, 227 insertions(+), 34 deletions(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > index ef4584a46417..ab80e1b1979e 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> > @@ -401,6 +401,7 @@ struct mtk_vcodec_dec_pdata {
> >    * @output_formats: array of supported output formats
> >    * @num_output_formats: number of entries in output_formats
> >    * @core_id: stand for h264 or vp8 encode index
> > + * @is_34bit: whether the encoder uses 34bit iova
> >    */
> >   struct mtk_vcodec_enc_pdata {
> >   	bool uses_ext;
> > @@ -411,9 +412,11 @@ struct mtk_vcodec_enc_pdata {
> >   	const struct mtk_video_fmt *output_formats;
> >   	size_t num_output_formats;
> >   	int core_id;
> > +	bool is_34bit;
> >   };
> >   
> >   #define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata-
> > >uses_ext)
> > +#define MTK_ENC_IOVA_IS_34BIT(ctx) ((ctx)->dev->venc_pdata-
> > >is_34bit)
> >   
> >   /**
> >    * struct mtk_vcodec_dev - driver data
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> > b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> > index 4d9b8798dffe..3a5af6cca040 100644
> > --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> > @@ -127,6 +127,72 @@ struct venc_h264_vsi {
> >   	struct venc_h264_vpu_buf work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
> >   };
> >   
> > +/**
> > + * struct venc_h264_vpu_config_ext - Structure for h264 encoder
> > configuration
> > + *                                   AP-W/R : AP is writer/reader
> > on this item
> > + *                                   VPU-W/R: VPU is write/reader
> > on this item
> > + * @input_fourcc: input fourcc
> > + * @bitrate: target bitrate (in bps)
> > + * @pic_w: picture width. Picture size is visible stream
> > resolution, in pixels,
> > + *         to be used for display purposes; must be smaller or
> > equal to buffer
> > + *         size.
> > + * @pic_h: picture height
> > + * @buf_w: buffer width. Buffer size is stream resolution in
> > pixels aligned to
> > + *         hardware requirements.
> > + * @buf_h: buffer height
> > + * @gop_size: group of picture size (idr frame)
> > + * @intra_period: intra frame period
> > + * @framerate: frame rate in fps
> > + * @profile: as specified in standard
> > + * @level: as specified in standard
> > + * @wfd: WFD mode 1:on, 0:off
> > + * @max_qp: max quant parameter
> > + * @min_qp: min quant parameter
> > + * @reserved: reserved configs
> > + */
> > +struct venc_h264_vpu_config_ext {
> > +	u32 input_fourcc;
> > +	u32 bitrate;
> > +	u32 pic_w;
> > +	u32 pic_h;
> > +	u32 buf_w;
> > +	u32 buf_h;
> > +	u32 gop_size;
> > +	u32 intra_period;
> > +	u32 framerate;
> > +	u32 profile;
> > +	u32 level;
> > +	u32 wfd;
> > +	u32 max_qp;
> > +	u32 min_qp;
> > +	u32 reserved[8];
> > +};
> > +
> > +/**
> > + * struct venc_h264_vpu_buf_34 - Structure for 34 bit buffer
> > information
> > + *                               AP-W/R : AP is writer/reader on
> > this item
> > + *                               VPU-W/R: VPU is write/reader on
> > this item
> > + * @iova: 34 bit IO virtual address
> > + * @vpua: VPU side memory addr which is used by RC_CODE
> > + * @size: buffer size (in bytes)
> > + */
> > +struct venc_h264_vpu_buf_34 {
> > +	u64 iova;
> > +	u32 vpua;
> > +	u32 size;
> > +};
> > +
> > +/**
> > + * struct venc_h264_vsi_64 - Structure for VPU driver control and
> > info share
> 
> Typo here --------------  ^^^^
Fix it in next version.
> 
> > + *                           Used for 64 bit iova sharing
> > + * @config: h264 encoder configuration
> > + * @work_bufs: working buffer information in VPU side
> > + */
> > +struct venc_h264_vsi_34 {
> > +	struct venc_h264_vpu_config_ext config;
> > +	struct venc_h264_vpu_buf_34
> > work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
> > +};
> > +
> >   /*
> >    * struct venc_h264_inst - h264 encoder AP driver instance
> >    * @hw_base: h264 encoder hardware register base
> > @@ -140,6 +206,8 @@ struct venc_h264_vsi {
> 
> ..snip..
> 
> > diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> > b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> > index d3570c4c177d..25c1b13559c9 100644
> > --- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
> > @@ -228,17 +228,28 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu,
> > unsigned int bs_mode,
> >   		   struct venc_frame_info *frame_info)
> >   {
> 
> That's practically 75% flow differences (or more, actually)... and
> there's going
> to always be a useless memzero, because a platform will always use
> either 34, or 32
> bits code.
> 
> At this point I think that for both performance and readability
> purposes, you
> should simply create another function.
> 
> Perhaps something like
> 
> static int vpu_enc_encode_32bits(struct venc_vpu_inst *vpu, unsigned
> int bs_mode,
> 				 struct venc_frm_buf *frm_buf,
> 				 struct mtk_vcodec_mem *bs_buf,
> 				 struct venc_frame_info *frame_info)
> {
> 	..... function .....
> }
> 
> static int vpu_enc_encode_34bits(struct venc_vpu_inst *vpu, unsigned
> int bs_mode,
> 
> 				 struct venc_frm_buf *frm_buf,
> 
> 				 struct mtk_vcodec_mem *bs_buf,
> 
> 				 struct venc_frame_info *frame_info)
> 
> {
> 	...... function ......
> }
Will add such function in next version, thank you.

Thanks
Best Regards
> 
> int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
> 
> 		   struct venc_frm_buf *frm_buf,
> 
> 		   struct mtk_vcodec_mem *bs_buf,
> 
> 		   struct venc_frame_info *frame_info)
> 
> {
> 	int ret;
> 
> 	if (MTK_ENC_IOVA_IS_34BIT(vpu->ctx))
> 		ret = vpu_enc_encode_34bits(......);
> 	else
> 		ret = vpu_enc_encode_32bits(....);
> 
> 	if (ret)
> 		return ret;
> 
> 	mtk_vcodec_debug(vpu, "bs_mode %d state %d size %d key_frm %d
> <-",
> 
> 			 bs_mode, vpu->state, vpu->bs_size, vpu-
> >is_key_frm);
> 
> 	return 0;
> }
> 
> 
> >   	const bool is_ext = MTK_ENC_CTX_IS_EXT(vpu->ctx);
> > +	const bool is_34bit = MTK_ENC_IOVA_IS_34BIT(vpu->ctx);
> > +
> >   	size_t msg_size = is_ext ?
> >   		sizeof(struct venc_ap_ipi_msg_enc_ext) :
> >   		sizeof(struct venc_ap_ipi_msg_enc);
> > +	int status;
> >   	struct venc_ap_ipi_msg_enc_ext out;
> > +	struct venc_ap_ipi_msg_enc_ext_34 out_34;
> >   
> >   	mtk_vcodec_debug(vpu, "bs_mode %d ->", bs_mode);
> >   
> >   	memset(&out, 0, sizeof(out));
> > +	memset(&out_34, 0, sizeof(out_34));
> > +
> >   	out.base.msg_id = AP_IPIMSG_ENC_ENCODE;
> >   	out.base.vpu_inst_addr = vpu->inst_addr;
> >   	out.base.bs_mode = bs_mode;
> > +
> > +	out_34.msg_id = AP_IPIMSG_ENC_ENCODE;
> > +	out_34.vpu_inst_addr = vpu->inst_addr;
> > +	out_34.bs_mode = bs_mode;
> > +
> >   	if (frm_buf) {
> >   		if ((frm_buf->fb_addr[0].dma_addr % 16 == 0) &&
> >   		    (frm_buf->fb_addr[1].dma_addr % 16 == 0) &&
> > @@ -246,6 +257,10 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu,
> > unsigned int bs_mode,
> >   			out.base.input_addr[0] = frm_buf-
> > >fb_addr[0].dma_addr;
> >   			out.base.input_addr[1] = frm_buf-
> > >fb_addr[1].dma_addr;
> >   			out.base.input_addr[2] = frm_buf-
> > >fb_addr[2].dma_addr;
> > +
> > +			out_34.input_addr[0] = frm_buf-
> > >fb_addr[0].dma_addr;
> > +			out_34.input_addr[1] = frm_buf-
> > >fb_addr[1].dma_addr;
> > +			out_34.input_addr[2] = frm_buf-
> > >fb_addr[2].dma_addr;
> >   		} else {
> >   			mtk_vcodec_err(vpu, "dma_addr not align to
> > 16");
> >   			return -EINVAL;
> > @@ -254,14 +269,31 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu,
> > unsigned int bs_mode,
> >   	if (bs_buf) {
> >   		out.base.bs_addr = bs_buf->dma_addr;
> >   		out.base.bs_size = bs_buf->size;
> > +
> > +		out_34.bs_addr = bs_buf->dma_addr;
> > +		out_34.bs_size = bs_buf->size;
> >   	}
> > +
> >   	if (is_ext && frame_info) {
> >   		out.data_item = 3;
> >   		out.data[0] = frame_info->frm_count;
> >   		out.data[1] = frame_info->skip_frm_count;
> >   		out.data[2] = frame_info->frm_type;
> > +
> > +		out_34.data_item = 3;
> > +		out_34.data[0] = frame_info->frm_count;
> > +		out_34.data[1] = frame_info->skip_frm_count;
> > +		out_34.data[2] = frame_info->frm_type;
> >   	}
> > -	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
> > +
> > +	if (is_34bit) {
> > +		msg_size = sizeof(struct venc_ap_ipi_msg_enc_ext_34);
> > +		status = vpu_enc_send_msg(vpu, &out_34, msg_size);
> > +	} else {
> > +		status = vpu_enc_send_msg(vpu, &out, msg_size);
> > +	}
> > +
> > +	if (status) {
> >   		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_ENCODE %d fail",
> >   			       bs_mode);
> >   		return -EINVAL;
> 
> 

