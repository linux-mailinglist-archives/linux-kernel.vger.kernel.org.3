Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E6526B72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384343AbiEMUaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384348AbiEMU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:29:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE9677F2A;
        Fri, 13 May 2022 13:29:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id E2CB61F46482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473776;
        bh=molSu9Ndn1sYFzHom/iyL7R+4m1ZjEvEB6PLGf0nq+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOdq8tM1BWHoSrbopxlJpYNQJLRnrt9+F1t6Ue7JNDdbHugNTNnnmt8UvKOoidhLg
         9LyA6wsJIDxPd2WS2eMJyL+GCF4cS8ZXMdR2SD8notkAZAFeqnMqung4764rPIqENN
         bL1xKHErTi3FVJFbyqMfMTje5xGo1kX7bGljs0hlxnXyv2PPw/zqqO6nFqcU4R+OYL
         Mkxax0HOK0L9Irt/+y1NzuIOQqC+jJEARQnkW03ixcnvPcdS79MqRS8X2GGtnFdFr/
         iBWSUAH+3MRtfe2z1kgCvuqkBqka0aS7N9ekeAEjFRAAbriHenaTEAkOtpqlQQLTR1
         ghjrHw9+dN7sA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v5 02/20] media: h264: Increase reference lists size to 32
Date:   Fri, 13 May 2022 16:29:04 -0400
Message-Id: <20220513202922.13846-3-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
References: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
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

This is to accommodate support for field decoding, which splits the top
and the bottom references into the reference list.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/v4l2-core/v4l2-h264.c        | 6 +++---
 drivers/staging/media/hantro/hantro_hw.h   | 6 +++---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 6 +++---
 include/media/v4l2-h264.h                  | 8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index afbfcf78efe4..4b46b36526c0 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -212,7 +212,7 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
  * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
  * @builder: reference list builder context
- * @reflist: 16 sized array used to store the P reference list. Each entry
+ * @reflist: 32 sized array used to store the P reference list. Each entry
  *	     is a v4l2_h264_reference structure
  *
  * This functions builds the P reference lists. This procedure is describe in
@@ -235,9 +235,9 @@ EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
  * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
  *
  * @builder: reference list builder context
- * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
+ * @b0_reflist: 32 sized array used to store the B0 reference list. Each entry
  *		is a v4l2_h264_reference structure
- * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
+ * @b1_reflist: 32 sized array used to store the B1 reference list. Each entry
  *		is a v4l2_h264_reference structure
  *
  * This functions builds the B0/B1 reference lists. This procedure is described
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index 3608e463290e..0b5b9da86c43 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -69,9 +69,9 @@ struct hantro_h264_dec_ctrls {
  * @b1:		B1 reflist
  */
 struct hantro_h264_dec_reflists {
-	struct v4l2_h264_reference p[HANTRO_H264_DPB_SIZE];
-	struct v4l2_h264_reference b0[HANTRO_H264_DPB_SIZE];
-	struct v4l2_h264_reference b1[HANTRO_H264_DPB_SIZE];
+	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
+	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
+	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
 };
 
 /**
diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 3c7f3d87fab4..dff89732ddd0 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -100,9 +100,9 @@ struct rkvdec_h264_priv_tbl {
 #define RKVDEC_H264_DPB_SIZE 16
 
 struct rkvdec_h264_reflists {
-	struct v4l2_h264_reference p[RKVDEC_H264_DPB_SIZE];
-	struct v4l2_h264_reference b0[RKVDEC_H264_DPB_SIZE];
-	struct v4l2_h264_reference b1[RKVDEC_H264_DPB_SIZE];
+	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
+	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
+	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
 	u8 num_valid;
 };
 
diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
index ef9a894e3c32..e282fb16ac58 100644
--- a/include/media/v4l2-h264.h
+++ b/include/media/v4l2-h264.h
@@ -37,7 +37,7 @@ struct v4l2_h264_reflist_builder {
 		u16 longterm : 1;
 	} refs[V4L2_H264_NUM_DPB_ENTRIES];
 	s32 cur_pic_order_count;
-	struct v4l2_h264_reference unordered_reflist[V4L2_H264_NUM_DPB_ENTRIES];
+	struct v4l2_h264_reference unordered_reflist[V4L2_H264_REF_LIST_LEN];
 	u8 num_valid;
 };
 
@@ -51,9 +51,9 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
  * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
  *
  * @builder: reference list builder context
- * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
+ * @b0_reflist: 32 sized array used to store the B0 reference list. Each entry
  *		is a v4l2_h264_reference structure
- * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
+ * @b1_reflist: 32 sized array used to store the B1 reference list. Each entry
  *		is a v4l2_h264_reference structure
  *
  * This functions builds the B0/B1 reference lists. This procedure is described
@@ -70,7 +70,7 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
  * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
  * @builder: reference list builder context
- * @reflist: 16 sized array used to store the P reference list. Each entry
+ * @reflist: 32 sized array used to store the P reference list. Each entry
  *	     is a v4l2_h264_reference structure
  *
  * This functions builds the P reference lists. This procedure is describe in
-- 
2.34.3

