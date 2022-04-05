Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BBE4F51FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849069AbiDFCdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444112AbiDEWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:20:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F178374843;
        Tue,  5 Apr 2022 13:44:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 0C8071F4480B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191489;
        bh=/4x2dOVmlW5X3SMWtdjUn/oKHye1Q/xNZ6Y9N4e0NSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xmm0t+cgocv3IS/j0VcDnBLz+QifOxbtn4lixay51yEGNHxYIfdj3MKHye/T4jYBX
         UD1ogaW4x/oD5yU7KN6ABNUO7ZCPTYYuLGWxpB7SI9+42PqqbQ+uYiT9Yq09sURyh+
         OglDRu+3MbToFilinIBoKNyJdN01qi0CZB11xyz12mOGXq7C9+Xce/lCPErvSP8eOD
         8ltLV0b6ARXus8vGhk0ZTMSrAQsfSamyei1rKoZTI8LP96tPnsz8Ez9OU7bFlesNH7
         EILkJdHMNHJsYNik1kaNFohvu2xAg8ukkDMd5vE4IWIaHjljm+XHmGLX/VfKEP/TaG
         0cDlqQmf+diXQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 05/24] media: h264: Use v4l2_h264_reference for reflist
Date:   Tue,  5 Apr 2022 16:44:06 -0400
Message-Id: <20220405204426.259074-6-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c   | 17 +++-
 drivers/media/v4l2-core/v4l2-h264.c           | 33 ++++---
 .../staging/media/hantro/hantro_g1_h264_dec.c | 38 +++----
 drivers/staging/media/hantro/hantro_hw.h      |  6 +-
 .../media/hantro/rockchip_vpu2_hw_h264_dec.c  | 98 +++++++++----------
 drivers/staging/media/rkvdec/rkvdec-h264.c    | 12 +--
 include/media/v4l2-h264.h                     | 19 ++--
 7 files changed, 116 insertions(+), 107 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
index 43542de11e9c..72c599e05a47 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
@@ -442,9 +442,16 @@ static void update_dpb(const struct v4l2_ctrl_h264_decode_params *dec_param,
 /*
  * The firmware expects unused reflist entries to have the value 0x20.
  */
-static void fixup_ref_list(u8 *ref_list, size_t num_valid)
+static void get_ref_list(u8 *ref_list, struct v4l2_h264_reflist_builder *b)
 {
-	memset(&ref_list[num_valid], 0x20, 32 - num_valid);
+	u32 i;
+
+	/* FIXME mark the reference parity */
+	for (i = 0; i < b->num_valid; i++)
+		ref_list[i] = b->index;
+
+	for (; i < 32; i++)
+		ref_list[i] = 0x20;
 }
 
 static void get_vdec_decode_parameters(struct vdec_h264_slice_inst *inst)
@@ -478,9 +485,9 @@ static void get_vdec_decode_parameters(struct vdec_h264_slice_inst *inst)
 	v4l2_h264_build_p_ref_list(&reflist_builder, p0_reflist);
 	v4l2_h264_build_b_ref_lists(&reflist_builder, b0_reflist, b1_reflist);
 	/* Adapt the built lists to the firmware's expectations */
-	fixup_ref_list(p0_reflist, reflist_builder.num_valid);
-	fixup_ref_list(b0_reflist, reflist_builder.num_valid);
-	fixup_ref_list(b1_reflist, reflist_builder.num_valid);
+	get_ref_list(p0_reflist, reflist_builder);
+	get_ref_list(b0_reflist, reflist_builder);
+	get_ref_list(b1_reflist, reflist_builder);
 
 	memcpy(&inst->vsi_ctx.h264_slice_params, slice_param,
 	       sizeof(inst->vsi_ctx.h264_slice_params));
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

