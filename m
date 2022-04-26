Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7022F50FE09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbiDZNBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350244AbiDZNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D056417B983;
        Tue, 26 Apr 2022 05:58:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 861891F4398D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977888;
        bh=6spd5zDDXQhVBNuvmuT3DFsMJlwSvquZ1zvEha0LOEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqWzgHDY9Ak5+G5HgVpoyVMfBXHYr75AcBGNmAOztGJoSAIQxxLMMNBvAa0VdbZg7
         PwqrtSiuXgNOa0qKhke4XVyj0B+XN9fbeDhKoNd5+VuJj9dQTU3gl+YaP6iyUpszT6
         gb1Mx1iQmQV1aZ7jiv8kT3p0kLqwCcgB8TWzltYbHYUWHBFvOd8ey+ziDLB8B3JJpC
         Zv0r99IMt0ZZ60+ovHe9BkZHnrReClurTJg3EMiBwlukxp7U//ZJQ22UNEWA1AIRjd
         gbJ+i5e4jv0OKEmg5nnVZBv5iseBAwAUDGRB/IA0GDDrd/KuIUal1HIikQP48oBeFq
         vgbDSyV8+okqw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 05/24] media: h264: Use v4l2_h264_reference for reflist
Date:   Tue, 26 Apr 2022 08:57:31 -0400
Message-Id: <20220426125751.108293-6-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding field decoding support, convert the byte arrays
for reflist into array of struct v4l2_h264_reference. That struct will
allow us to mark which field of the reference picture is being referenced.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c   | 36 +++++--
 .../media/platform/nvidia/tegra-vde/h264.c    | 19 ++--
 drivers/media/v4l2-core/v4l2-h264.c           | 33 ++++---
 .../staging/media/hantro/hantro_g1_h264_dec.c | 38 +++----
 drivers/staging/media/hantro/hantro_hw.h      |  6 +-
 .../media/hantro/rockchip_vpu2_hw_h264_dec.c  | 98 +++++++++----------
 drivers/staging/media/rkvdec/rkvdec-h264.c    | 12 +--
 include/media/v4l2-h264.h                     | 19 ++--
 8 files changed, 143 insertions(+), 118 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index 43542de11e9c..8e59cf5c05a0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -439,11 +439,24 @@ static void update_dpb(const struct v4l2_ctrl_h264_decode_params *dec_param,
 	}
 }
 
-/*
- * The firmware expects unused reflist entries to have the value 0x20.
- */
-static void fixup_ref_list(u8 *ref_list, size_t num_valid)
+static void get_ref_list(u8 *ref_list,
+			 const struct v4l2_h264_reference *v4l2_ref_list,
+			 int num_valid)
 {
+	u32 i;
+
+	/*
+	 * TODO The firmware does not support field decoding. Future
+	 * implementation must use v4l2_ref_list[i].fields to obtain
+	 * the reference field parity.
+	 */
+
+	for (i = 0; i < num_valid; i++)
+		ref_list[i] = v4l2_ref_list[i].index;
+
+	/*
+	 * The firmware expects unused reflist entries to have the value 0x20.
+	 */
 	memset(&ref_list[num_valid], 0x20, 32 - num_valid);
 }
 
@@ -459,6 +472,9 @@ static void get_vdec_decode_parameters(struct vdec_h264_slice_inst *inst)
 		get_ctrl_ptr(inst->ctx, V4L2_CID_STATELESS_H264_SCALING_MATRIX);
 	struct mtk_h264_dec_slice_param *slice_param = &inst->h264_slice_param;
 	struct v4l2_h264_reflist_builder reflist_builder;
+	struct v4l2_h264_reference v4l2_p0_reflist[V4L2_H264_REF_LIST_LEN];
+	struct v4l2_h264_reference v4l2_b0_reflist[V4L2_H264_REF_LIST_LEN];
+	struct v4l2_h264_reference v4l2_b1_reflist[V4L2_H264_REF_LIST_LEN];
 	u8 *p0_reflist = slice_param->decode_params.ref_pic_list_p0;
 	u8 *b0_reflist = slice_param->decode_params.ref_pic_list_b0;
 	u8 *b1_reflist = slice_param->decode_params.ref_pic_list_b1;
@@ -475,12 +491,14 @@ static void get_vdec_decode_parameters(struct vdec_h264_slice_inst *inst)
 	/* Build the reference lists */
 	v4l2_h264_init_reflist_builder(&reflist_builder, dec_params, sps,
 				       inst->dpb);
-	v4l2_h264_build_p_ref_list(&reflist_builder, p0_reflist);
-	v4l2_h264_build_b_ref_lists(&reflist_builder, b0_reflist, b1_reflist);
+	v4l2_h264_build_p_ref_list(&reflist_builder, v4l2_p0_reflist);
+	v4l2_h264_build_b_ref_lists(&reflist_builder, v4l2_b0_reflist,
+				    v4l2_b1_reflist);
+
 	/* Adapt the built lists to the firmware's expectations */
-	fixup_ref_list(p0_reflist, reflist_builder.num_valid);
-	fixup_ref_list(b0_reflist, reflist_builder.num_valid);
-	fixup_ref_list(b1_reflist, reflist_builder.num_valid);
+	get_ref_list(p0_reflist, v4l2_p0_reflist, reflist_builder.num_valid);
+	get_ref_list(b0_reflist, v4l2_b0_reflist, reflist_builder.num_valid);
+	get_ref_list(b1_reflist, v4l2_b1_reflist, reflist_builder.num_valid);
 
 	memcpy(&inst->vsi_ctx.h264_slice_params, slice_param,
 	       sizeof(inst->vsi_ctx.h264_slice_params));
diff --git a/drivers/media/platform/nvidia/tegra-vde/h264.c b/drivers/media/platform/nvidia/tegra-vde/h264.c
index d8e5534e80c8..acc1b97f06ad 100644
--- a/drivers/media/platform/nvidia/tegra-vde/h264.c
+++ b/drivers/media/platform/nvidia/tegra-vde/h264.c
@@ -45,9 +45,9 @@ struct tegra_vde_h264_decoder_ctx {
 };
 
 struct h264_reflists {
-	u8 p[V4L2_H264_NUM_DPB_ENTRIES];
-	u8 b0[V4L2_H264_NUM_DPB_ENTRIES];
-	u8 b1[V4L2_H264_NUM_DPB_ENTRIES];
+	struct v4l2_h264_reference p[V4L2_H264_NUM_DPB_ENTRIES];
+	struct v4l2_h264_reference b0[V4L2_H264_NUM_DPB_ENTRIES];
+	struct v4l2_h264_reference b1[V4L2_H264_NUM_DPB_ENTRIES];
 };
 
 static int tegra_vde_wait_mbe(struct tegra_vde *vde)
@@ -768,7 +768,7 @@ static int tegra_vde_h264_setup_frames(struct tegra_ctx *ctx,
 	struct h264_reflists reflists;
 	struct vb2_buffer *ref;
 	unsigned int i;
-	u8 *dpb_id;
+	struct v4l2_h264_reference *dpb_id;
 	int err;
 
 	/*
@@ -811,14 +811,16 @@ static int tegra_vde_h264_setup_frames(struct tegra_ctx *ctx,
 	}
 
 	for (i = 0; i < b.num_valid; i++) {
-		ref = get_ref_buf(ctx, dst, dpb_id[i]);
+		int dpb_idx = dpb_id[i].index;
 
-		err = tegra_vde_h264_setup_frame(ctx, h264, &b, ref, dpb_id[i],
+		ref = get_ref_buf(ctx, dst, dpb_idx);
+
+		err = tegra_vde_h264_setup_frame(ctx, h264, &b, ref, dpb_idx,
 						 h264->dpb_frames_nb++);
 		if (err)
 			return err;
 
-		if (b.refs[dpb_id[i]].pic_order_count < b.cur_pic_order_count)
+		if (b.refs[dpb_idx].top_field_order_cnt < b.cur_pic_order_count)
 			h264->dpb_ref_frames_with_earlier_poc_nb++;
 	}
 
@@ -880,6 +882,9 @@ static int tegra_vde_h264_setup_context(struct tegra_ctx *ctx,
 	if (h->pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE)
 		return -EOPNOTSUPP;
 
+	if (h->decode_params->flags & V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC)
+		return -EOPNOTSUPP;
+
 	if (h->sps->profile_idc == 66)
 		h264->baseline_profile = 1;
 
diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index ac47519a9fbe..afbfcf78efe4 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -75,12 +75,12 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
 			pic_order_count = dpb[i].top_field_order_cnt;
 
 		b->refs[i].pic_order_count = pic_order_count;
-		b->unordered_reflist[b->num_valid] = i;
+		b->unordered_reflist[b->num_valid].index = i;
 		b->num_valid++;
 	}
 
 	for (i = b->num_valid; i < ARRAY_SIZE(b->unordered_reflist); i++)
-		b->unordered_reflist[i] = i;
+		b->unordered_reflist[i].index = i;
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_init_reflist_builder);
 
@@ -90,8 +90,8 @@ static int v4l2_h264_p_ref_list_cmp(const void *ptra, const void *ptrb,
 	const struct v4l2_h264_reflist_builder *builder = data;
 	u8 idxa, idxb;
 
-	idxa = *((u8 *)ptra);
-	idxb = *((u8 *)ptrb);
+	idxa = ((struct v4l2_h264_reference *)ptra)->index;
+	idxb = ((struct v4l2_h264_reference *)ptrb)->index;
 
 	if (WARN_ON(idxa >= V4L2_H264_NUM_DPB_ENTRIES ||
 		    idxb >= V4L2_H264_NUM_DPB_ENTRIES))
@@ -125,8 +125,8 @@ static int v4l2_h264_b0_ref_list_cmp(const void *ptra, const void *ptrb,
 	s32 poca, pocb;
 	u8 idxa, idxb;
 
-	idxa = *((u8 *)ptra);
-	idxb = *((u8 *)ptrb);
+	idxa = ((struct v4l2_h264_reference *)ptra)->index;
+	idxb = ((struct v4l2_h264_reference *)ptrb)->index;
 
 	if (WARN_ON(idxa >= V4L2_H264_NUM_DPB_ENTRIES ||
 		    idxb >= V4L2_H264_NUM_DPB_ENTRIES))
@@ -170,8 +170,8 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 	s32 poca, pocb;
 	u8 idxa, idxb;
 
-	idxa = *((u8 *)ptra);
-	idxb = *((u8 *)ptrb);
+	idxa = ((struct v4l2_h264_reference *)ptra)->index;
+	idxb = ((struct v4l2_h264_reference *)ptrb)->index;
 
 	if (WARN_ON(idxa >= V4L2_H264_NUM_DPB_ENTRIES ||
 		    idxb >= V4L2_H264_NUM_DPB_ENTRIES))
@@ -212,8 +212,8 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
  * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
  * @builder: reference list builder context
- * @reflist: 16-bytes array used to store the P reference list. Each entry
- *	     is an index in the DPB
+ * @reflist: 16 sized array used to store the P reference list. Each entry
+ *	     is a v4l2_h264_reference structure
  *
  * This functions builds the P reference lists. This procedure is describe in
  * section '8.2.4 Decoding process for reference picture lists construction'
@@ -222,7 +222,7 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
  */
 void
 v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
-			   u8 *reflist)
+			   struct v4l2_h264_reference *reflist)
 {
 	memcpy(reflist, builder->unordered_reflist,
 	       sizeof(builder->unordered_reflist[0]) * builder->num_valid);
@@ -235,10 +235,10 @@ EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
  * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
  *
  * @builder: reference list builder context
- * @b0_reflist: 16-bytes array used to store the B0 reference list. Each entry
- *		is an index in the DPB
- * @b1_reflist: 16-bytes array used to store the B1 reference list. Each entry
- *		is an index in the DPB
+ * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
+ *		is a v4l2_h264_reference structure
+ * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
+ *		is a v4l2_h264_reference structure
  *
  * This functions builds the B0/B1 reference lists. This procedure is described
  * in section '8.2.4 Decoding process for reference picture lists construction'
@@ -247,7 +247,8 @@ EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
  */
 void
 v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
-			    u8 *b0_reflist, u8 *b1_reflist)
+			    struct v4l2_h264_reference *b0_reflist,
+			    struct v4l2_h264_reference *b1_reflist)
 {
 	memcpy(b0_reflist, builder->unordered_reflist,
 	       sizeof(builder->unordered_reflist[0]) * builder->num_valid);
diff --git a/drivers/staging/media/hantro/hantro_g1_h264_dec.c b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
index f49dbfb8a843..9de7f05eff2a 100644
--- a/drivers/staging/media/hantro/hantro_g1_h264_dec.c
+++ b/drivers/staging/media/hantro/hantro_g1_h264_dec.c
@@ -126,7 +126,7 @@ static void set_params(struct hantro_ctx *ctx, struct vb2_v4l2_buffer *src_buf)
 
 static void set_ref(struct hantro_ctx *ctx)
 {
-	const u8 *b0_reflist, *b1_reflist, *p_reflist;
+	const struct v4l2_h264_reference *b0_reflist, *b1_reflist, *p_reflist;
 	struct hantro_dev *vpu = ctx->dev;
 	int reg_num;
 	u32 reg;
@@ -157,12 +157,12 @@ static void set_ref(struct hantro_ctx *ctx)
 	 */
 	reg_num = 0;
 	for (i = 0; i < 15; i += 3) {
-		reg = G1_REG_BD_REF_PIC_BINIT_RLIST_F0(b0_reflist[i]) |
-		      G1_REG_BD_REF_PIC_BINIT_RLIST_F1(b0_reflist[i + 1]) |
-		      G1_REG_BD_REF_PIC_BINIT_RLIST_F2(b0_reflist[i + 2]) |
-		      G1_REG_BD_REF_PIC_BINIT_RLIST_B0(b1_reflist[i]) |
-		      G1_REG_BD_REF_PIC_BINIT_RLIST_B1(b1_reflist[i + 1]) |
-		      G1_REG_BD_REF_PIC_BINIT_RLIST_B2(b1_reflist[i + 2]);
+		reg = G1_REG_BD_REF_PIC_BINIT_RLIST_F0(b0_reflist[i].index) |
+		      G1_REG_BD_REF_PIC_BINIT_RLIST_F1(b0_reflist[i + 1].index) |
+		      G1_REG_BD_REF_PIC_BINIT_RLIST_F2(b0_reflist[i + 2].index) |
+		      G1_REG_BD_REF_PIC_BINIT_RLIST_B0(b1_reflist[i].index) |
+		      G1_REG_BD_REF_PIC_BINIT_RLIST_B1(b1_reflist[i + 1].index) |
+		      G1_REG_BD_REF_PIC_BINIT_RLIST_B2(b1_reflist[i + 2].index);
 		vdpu_write_relaxed(vpu, reg, G1_REG_BD_REF_PIC(reg_num++));
 	}
 
@@ -171,12 +171,12 @@ static void set_ref(struct hantro_ctx *ctx)
 	 * of forward and backward reference picture lists and first 4 entries
 	 * of P forward picture list.
 	 */
-	reg = G1_REG_BD_P_REF_PIC_BINIT_RLIST_F15(b0_reflist[15]) |
-	      G1_REG_BD_P_REF_PIC_BINIT_RLIST_B15(b1_reflist[15]) |
-	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F0(p_reflist[0]) |
-	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F1(p_reflist[1]) |
-	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F2(p_reflist[2]) |
-	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F3(p_reflist[3]);
+	reg = G1_REG_BD_P_REF_PIC_BINIT_RLIST_F15(b0_reflist[15].index) |
+	      G1_REG_BD_P_REF_PIC_BINIT_RLIST_B15(b1_reflist[15].index) |
+	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F0(p_reflist[0].index) |
+	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F1(p_reflist[1].index) |
+	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F2(p_reflist[2].index) |
+	      G1_REG_BD_P_REF_PIC_PINIT_RLIST_F3(p_reflist[3].index);
 	vdpu_write_relaxed(vpu, reg, G1_REG_BD_P_REF_PIC);
 
 	/*
@@ -185,12 +185,12 @@ static void set_ref(struct hantro_ctx *ctx)
 	 */
 	reg_num = 0;
 	for (i = 4; i < HANTRO_H264_DPB_SIZE; i += 6) {
-		reg = G1_REG_FWD_PIC_PINIT_RLIST_F0(p_reflist[i]) |
-		      G1_REG_FWD_PIC_PINIT_RLIST_F1(p_reflist[i + 1]) |
-		      G1_REG_FWD_PIC_PINIT_RLIST_F2(p_reflist[i + 2]) |
-		      G1_REG_FWD_PIC_PINIT_RLIST_F3(p_reflist[i + 3]) |
-		      G1_REG_FWD_PIC_PINIT_RLIST_F4(p_reflist[i + 4]) |
-		      G1_REG_FWD_PIC_PINIT_RLIST_F5(p_reflist[i + 5]);
+		reg = G1_REG_FWD_PIC_PINIT_RLIST_F0(p_reflist[i].index) |
+		      G1_REG_FWD_PIC_PINIT_RLIST_F1(p_reflist[i + 1].index) |
+		      G1_REG_FWD_PIC_PINIT_RLIST_F2(p_reflist[i + 2].index) |
+		      G1_REG_FWD_PIC_PINIT_RLIST_F3(p_reflist[i + 3].index) |
+		      G1_REG_FWD_PIC_PINIT_RLIST_F4(p_reflist[i + 4].index) |
+		      G1_REG_FWD_PIC_PINIT_RLIST_F5(p_reflist[i + 5].index);
 		vdpu_write_relaxed(vpu, reg, G1_REG_FWD_PIC(reg_num++));
 	}
 
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index ed018e293ba0..2bc6b8f088f5 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -69,9 +69,9 @@ struct hantro_h264_dec_ctrls {
  * @b1:		B1 reflist
  */
 struct hantro_h264_dec_reflists {
-	u8 p[HANTRO_H264_DPB_SIZE];
-	u8 b0[HANTRO_H264_DPB_SIZE];
-	u8 b1[HANTRO_H264_DPB_SIZE];
+	struct v4l2_h264_reference p[HANTRO_H264_DPB_SIZE];
+	struct v4l2_h264_reference b0[HANTRO_H264_DPB_SIZE];
+	struct v4l2_h264_reference b1[HANTRO_H264_DPB_SIZE];
 };
 
 /**
diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_h264_dec.c b/drivers/staging/media/hantro/rockchip_vpu2_hw_h264_dec.c
index 64a6330475eb..46c1a83bcc4e 100644
--- a/drivers/staging/media/hantro/rockchip_vpu2_hw_h264_dec.c
+++ b/drivers/staging/media/hantro/rockchip_vpu2_hw_h264_dec.c
@@ -298,7 +298,7 @@ static void set_params(struct hantro_ctx *ctx, struct vb2_v4l2_buffer *src_buf)
 
 static void set_ref(struct hantro_ctx *ctx)
 {
-	const u8 *b0_reflist, *b1_reflist, *p_reflist;
+	const struct v4l2_h264_reference *b0_reflist, *b1_reflist, *p_reflist;
 	struct hantro_dev *vpu = ctx->dev;
 	u32 reg;
 	int i;
@@ -307,20 +307,20 @@ static void set_ref(struct hantro_ctx *ctx)
 	b1_reflist = ctx->h264_dec.reflists.b1;
 	p_reflist = ctx->h264_dec.reflists.p;
 
-	reg = VDPU_REG_PINIT_RLIST_F9(p_reflist[9]) |
-	      VDPU_REG_PINIT_RLIST_F8(p_reflist[8]) |
-	      VDPU_REG_PINIT_RLIST_F7(p_reflist[7]) |
-	      VDPU_REG_PINIT_RLIST_F6(p_reflist[6]) |
-	      VDPU_REG_PINIT_RLIST_F5(p_reflist[5]) |
-	      VDPU_REG_PINIT_RLIST_F4(p_reflist[4]);
+	reg = VDPU_REG_PINIT_RLIST_F9(p_reflist[9].index) |
+	      VDPU_REG_PINIT_RLIST_F8(p_reflist[8].index) |
+	      VDPU_REG_PINIT_RLIST_F7(p_reflist[7].index) |
+	      VDPU_REG_PINIT_RLIST_F6(p_reflist[6].index) |
+	      VDPU_REG_PINIT_RLIST_F5(p_reflist[5].index) |
+	      VDPU_REG_PINIT_RLIST_F4(p_reflist[4].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(74));
 
-	reg = VDPU_REG_PINIT_RLIST_F15(p_reflist[15]) |
-	      VDPU_REG_PINIT_RLIST_F14(p_reflist[14]) |
-	      VDPU_REG_PINIT_RLIST_F13(p_reflist[13]) |
-	      VDPU_REG_PINIT_RLIST_F12(p_reflist[12]) |
-	      VDPU_REG_PINIT_RLIST_F11(p_reflist[11]) |
-	      VDPU_REG_PINIT_RLIST_F10(p_reflist[10]);
+	reg = VDPU_REG_PINIT_RLIST_F15(p_reflist[15].index) |
+	      VDPU_REG_PINIT_RLIST_F14(p_reflist[14].index) |
+	      VDPU_REG_PINIT_RLIST_F13(p_reflist[13].index) |
+	      VDPU_REG_PINIT_RLIST_F12(p_reflist[12].index) |
+	      VDPU_REG_PINIT_RLIST_F11(p_reflist[11].index) |
+	      VDPU_REG_PINIT_RLIST_F10(p_reflist[10].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(75));
 
 	reg = VDPU_REG_REFER1_NBR(hantro_h264_get_ref_nbr(ctx, 1)) |
@@ -355,54 +355,54 @@ static void set_ref(struct hantro_ctx *ctx)
 	      VDPU_REG_REFER14_NBR(hantro_h264_get_ref_nbr(ctx, 14));
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(83));
 
-	reg = VDPU_REG_BINIT_RLIST_F5(b0_reflist[5]) |
-	      VDPU_REG_BINIT_RLIST_F4(b0_reflist[4]) |
-	      VDPU_REG_BINIT_RLIST_F3(b0_reflist[3]) |
-	      VDPU_REG_BINIT_RLIST_F2(b0_reflist[2]) |
-	      VDPU_REG_BINIT_RLIST_F1(b0_reflist[1]) |
-	      VDPU_REG_BINIT_RLIST_F0(b0_reflist[0]);
+	reg = VDPU_REG_BINIT_RLIST_F5(b0_reflist[5].index) |
+	      VDPU_REG_BINIT_RLIST_F4(b0_reflist[4].index) |
+	      VDPU_REG_BINIT_RLIST_F3(b0_reflist[3].index) |
+	      VDPU_REG_BINIT_RLIST_F2(b0_reflist[2].index) |
+	      VDPU_REG_BINIT_RLIST_F1(b0_reflist[1].index) |
+	      VDPU_REG_BINIT_RLIST_F0(b0_reflist[0].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(100));
 
-	reg = VDPU_REG_BINIT_RLIST_F11(b0_reflist[11]) |
-	      VDPU_REG_BINIT_RLIST_F10(b0_reflist[10]) |
-	      VDPU_REG_BINIT_RLIST_F9(b0_reflist[9]) |
-	      VDPU_REG_BINIT_RLIST_F8(b0_reflist[8]) |
-	      VDPU_REG_BINIT_RLIST_F7(b0_reflist[7]) |
-	      VDPU_REG_BINIT_RLIST_F6(b0_reflist[6]);
+	reg = VDPU_REG_BINIT_RLIST_F11(b0_reflist[11].index) |
+	      VDPU_REG_BINIT_RLIST_F10(b0_reflist[10].index) |
+	      VDPU_REG_BINIT_RLIST_F9(b0_reflist[9].index) |
+	      VDPU_REG_BINIT_RLIST_F8(b0_reflist[8].index) |
+	      VDPU_REG_BINIT_RLIST_F7(b0_reflist[7].index) |
+	      VDPU_REG_BINIT_RLIST_F6(b0_reflist[6].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(101));
 
-	reg = VDPU_REG_BINIT_RLIST_F15(b0_reflist[15]) |
-	      VDPU_REG_BINIT_RLIST_F14(b0_reflist[14]) |
-	      VDPU_REG_BINIT_RLIST_F13(b0_reflist[13]) |
-	      VDPU_REG_BINIT_RLIST_F12(b0_reflist[12]);
+	reg = VDPU_REG_BINIT_RLIST_F15(b0_reflist[15].index) |
+	      VDPU_REG_BINIT_RLIST_F14(b0_reflist[14].index) |
+	      VDPU_REG_BINIT_RLIST_F13(b0_reflist[13].index) |
+	      VDPU_REG_BINIT_RLIST_F12(b0_reflist[12].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(102));
 
-	reg = VDPU_REG_BINIT_RLIST_B5(b1_reflist[5]) |
-	      VDPU_REG_BINIT_RLIST_B4(b1_reflist[4]) |
-	      VDPU_REG_BINIT_RLIST_B3(b1_reflist[3]) |
-	      VDPU_REG_BINIT_RLIST_B2(b1_reflist[2]) |
-	      VDPU_REG_BINIT_RLIST_B1(b1_reflist[1]) |
-	      VDPU_REG_BINIT_RLIST_B0(b1_reflist[0]);
+	reg = VDPU_REG_BINIT_RLIST_B5(b1_reflist[5].index) |
+	      VDPU_REG_BINIT_RLIST_B4(b1_reflist[4].index) |
+	      VDPU_REG_BINIT_RLIST_B3(b1_reflist[3].index) |
+	      VDPU_REG_BINIT_RLIST_B2(b1_reflist[2].index) |
+	      VDPU_REG_BINIT_RLIST_B1(b1_reflist[1].index) |
+	      VDPU_REG_BINIT_RLIST_B0(b1_reflist[0].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(103));
 
-	reg = VDPU_REG_BINIT_RLIST_B11(b1_reflist[11]) |
-	      VDPU_REG_BINIT_RLIST_B10(b1_reflist[10]) |
-	      VDPU_REG_BINIT_RLIST_B9(b1_reflist[9]) |
-	      VDPU_REG_BINIT_RLIST_B8(b1_reflist[8]) |
-	      VDPU_REG_BINIT_RLIST_B7(b1_reflist[7]) |
-	      VDPU_REG_BINIT_RLIST_B6(b1_reflist[6]);
+	reg = VDPU_REG_BINIT_RLIST_B11(b1_reflist[11].index) |
+	      VDPU_REG_BINIT_RLIST_B10(b1_reflist[10].index) |
+	      VDPU_REG_BINIT_RLIST_B9(b1_reflist[9].index) |
+	      VDPU_REG_BINIT_RLIST_B8(b1_reflist[8].index) |
+	      VDPU_REG_BINIT_RLIST_B7(b1_reflist[7].index) |
+	      VDPU_REG_BINIT_RLIST_B6(b1_reflist[6].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(104));
 
-	reg = VDPU_REG_BINIT_RLIST_B15(b1_reflist[15]) |
-	      VDPU_REG_BINIT_RLIST_B14(b1_reflist[14]) |
-	      VDPU_REG_BINIT_RLIST_B13(b1_reflist[13]) |
-	      VDPU_REG_BINIT_RLIST_B12(b1_reflist[12]);
+	reg = VDPU_REG_BINIT_RLIST_B15(b1_reflist[15].index) |
+	      VDPU_REG_BINIT_RLIST_B14(b1_reflist[14].index) |
+	      VDPU_REG_BINIT_RLIST_B13(b1_reflist[13].index) |
+	      VDPU_REG_BINIT_RLIST_B12(b1_reflist[12].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(105));
 
-	reg = VDPU_REG_PINIT_RLIST_F3(p_reflist[3]) |
-	      VDPU_REG_PINIT_RLIST_F2(p_reflist[2]) |
-	      VDPU_REG_PINIT_RLIST_F1(p_reflist[1]) |
-	      VDPU_REG_PINIT_RLIST_F0(p_reflist[0]);
+	reg = VDPU_REG_PINIT_RLIST_F3(p_reflist[3].index) |
+	      VDPU_REG_PINIT_RLIST_F2(p_reflist[2].index) |
+	      VDPU_REG_PINIT_RLIST_F1(p_reflist[1].index) |
+	      VDPU_REG_PINIT_RLIST_F0(p_reflist[0].index);
 	vdpu_write_relaxed(vpu, reg, VDPU_SWREG(106));
 
 	reg = VDPU_REG_REFER_LTERM_E(ctx->h264_dec.dpb_longterm);
diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 951e19231da2..3c7f3d87fab4 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -100,9 +100,9 @@ struct rkvdec_h264_priv_tbl {
 #define RKVDEC_H264_DPB_SIZE 16
 
 struct rkvdec_h264_reflists {
-	u8 p[RKVDEC_H264_DPB_SIZE];
-	u8 b0[RKVDEC_H264_DPB_SIZE];
-	u8 b1[RKVDEC_H264_DPB_SIZE];
+	struct v4l2_h264_reference p[RKVDEC_H264_DPB_SIZE];
+	struct v4l2_h264_reference b0[RKVDEC_H264_DPB_SIZE];
+	struct v4l2_h264_reference b1[RKVDEC_H264_DPB_SIZE];
 	u8 num_valid;
 };
 
@@ -767,13 +767,13 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 
 			switch (j) {
 			case 0:
-				idx = h264_ctx->reflists.p[i];
+				idx = h264_ctx->reflists.p[i].index;
 				break;
 			case 1:
-				idx = h264_ctx->reflists.b0[i];
+				idx = h264_ctx->reflists.b0[i].index;
 				break;
 			case 2:
-				idx = h264_ctx->reflists.b1[i];
+				idx = h264_ctx->reflists.b1[i].index;
 				break;
 			}
 
diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
index 4b1c71c935e0..ef9a894e3c32 100644
--- a/include/media/v4l2-h264.h
+++ b/include/media/v4l2-h264.h
@@ -37,7 +37,7 @@ struct v4l2_h264_reflist_builder {
 		u16 longterm : 1;
 	} refs[V4L2_H264_NUM_DPB_ENTRIES];
 	s32 cur_pic_order_count;
-	u8 unordered_reflist[V4L2_H264_NUM_DPB_ENTRIES];
+	struct v4l2_h264_reference unordered_reflist[V4L2_H264_NUM_DPB_ENTRIES];
 	u8 num_valid;
 };
 
@@ -51,10 +51,10 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
  * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
  *
  * @builder: reference list builder context
- * @b0_reflist: 16-bytes array used to store the B0 reference list. Each entry
- *		is an index in the DPB
- * @b1_reflist: 16-bytes array used to store the B1 reference list. Each entry
- *		is an index in the DPB
+ * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
+ *		is a v4l2_h264_reference structure
+ * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
+ *		is a v4l2_h264_reference structure
  *
  * This functions builds the B0/B1 reference lists. This procedure is described
  * in section '8.2.4 Decoding process for reference picture lists construction'
@@ -63,14 +63,15 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
  */
 void
 v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
-			    u8 *b0_reflist, u8 *b1_reflist);
+			    struct v4l2_h264_reference *b0_reflist,
+			    struct v4l2_h264_reference *b1_reflist);
 
 /**
  * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
  * @builder: reference list builder context
- * @reflist: 16-bytes array used to store the P reference list. Each entry
- *	     is an index in the DPB
+ * @reflist: 16 sized array used to store the P reference list. Each entry
+ *	     is a v4l2_h264_reference structure
  *
  * This functions builds the P reference lists. This procedure is describe in
  * section '8.2.4 Decoding process for reference picture lists construction'
@@ -79,6 +80,6 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
  */
 void
 v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
-			   u8 *reflist);
+			   struct v4l2_h264_reference *reflist);
 
 #endif /* _MEDIA_V4L2_H264_H */
-- 
2.34.1

