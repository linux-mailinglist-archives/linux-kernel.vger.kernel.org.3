Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA74F5227
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450847AbiDFCgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444148AbiDEWVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:21:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13AA75215;
        Tue,  5 Apr 2022 13:44:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 19F1B1F44826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191498;
        bh=SqPD7oTR+3FuYunP0khMcdvMcGz4bOvgAm9j9vzmvSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e98qXzKjRZFuL/1d64MdD/TSfoAuS+Rtbo1M33dWwT8qxn1uhQ7PvPAwsAZrsYtnV
         QQhRUOSl1PTbGUwxM+dGBF6iVLVERKpfP4wx66wBrzf1aS39TbPzHtztbeY6k7mMUu
         Az2rMIaHgmJuhS4AxGnabihK857+cIB8+6yErqIxbyd8syfyFWTTezxqEwEzvtwxGy
         zuO//SrfBlNw8DW8ttI7xS+A7TWnzY3Sww+oqSSYBDUopTOFivBwlIkseGHK0nvlTf
         n6M5KFFBALD5wfkLqqlr5HL9+ta52NxEfdqRfSuJnku56+nW3l4YXiSiYGW9Xozl2o
         BufRJcuQ0V0dA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 11/24] media: v4l2: Reorder field reflist
Date:   Tue,  5 Apr 2022 16:44:12 -0400
Message-Id: <20220405204426.259074-12-nicolas.dufresne@collabora.com>
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

As per spec, the field reflist requires interleaving top and bottom
field in a specific way that does not fit inside the sort operation.
The process consist of alternating references parity, starting with
a reference of the same parity as the current picture. This
processs is done twice, once for short term references and a second
time for the long term references.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 7e1eba03099a..d2d1f3bed7e8 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -244,6 +244,40 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 	return poca < pocb ? -1 : 1;
 }
 
+/*
+ * The references need to be reordered so that references are alternating
+ * between top and bottom field references starting with the current picture
+ * parity. This has to be * done for short term and long term references
+ * separately.
+ */
+static void reorder_field_reflist(const struct v4l2_h264_reflist_builder *b,
+				  struct v4l2_h264_reference *reflist)
+{
+	struct v4l2_h264_reference tmplist[V4L2_H264_REF_LIST_LEN];
+	u8 lt, i = 0, j = 0, k = 0;
+
+	memcpy(tmplist, reflist, sizeof(tmplist[0]) * b->num_valid);
+
+	for (lt = 0; lt <= 1; lt++) {
+		do {
+			for (; i < b->num_valid && b->refs[tmplist[i].index].longterm == lt; i++) {
+				if (tmplist[i].fields == b->cur_pic_fields) {
+					reflist[k++] = tmplist[i++];
+					break;
+				}
+			}
+
+			for (; j < b->num_valid && b->refs[tmplist[j].index].longterm == lt; j++) {
+				if (tmplist[j].fields != b->cur_pic_fields) {
+					reflist[k++] = tmplist[j++];
+					break;
+				}
+			}
+		} while ((i < b->num_valid && b->refs[tmplist[i].index].longterm == lt) ||
+			 (j < b->num_valid && b->refs[tmplist[j].index].longterm == lt));
+	}
+}
+
 static char ref_type_to_char (u8 ref_type)
 {
 	switch (ref_type) {
@@ -346,6 +380,9 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
 	sort_r(reflist, builder->num_valid, sizeof(*reflist),
 	       v4l2_h264_p_ref_list_cmp, NULL, builder);
 
+	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF)
+		reorder_field_reflist(builder, reflist);
+
 	print_ref_list_p(builder, reflist);
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
@@ -379,6 +416,11 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
 	sort_r(b1_reflist, builder->num_valid, sizeof(*b1_reflist),
 	       v4l2_h264_b1_ref_list_cmp, NULL, builder);
 
+	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF) {
+		reorder_field_reflist(builder, b0_reflist);
+		reorder_field_reflist(builder, b1_reflist);
+	}
+
 	if (builder->num_valid > 1 &&
 	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
 		swap(b1_reflist[0], b1_reflist[1]);
-- 
2.34.1

