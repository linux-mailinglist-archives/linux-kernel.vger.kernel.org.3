Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93264EA103
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbiC1UCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344131AbiC1UBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036D3A730;
        Mon, 28 Mar 2022 13:00:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 4EFD31F4386D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497600;
        bh=vByQV7rCpRfvNGtGYzI2vxESufjfaYFSOaqSafHc0Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AD3UX9iFdiyFU1ERpNORrTzFj7a34p+IuYkWRoz3FspWwoYs2DJFs5h8TYtLeCWrA
         156jZRkmHbeiPv4tTDwgOSlpaNM9OYSQnahvWiidfWyncGtPrapG/uBhO/lr6/JofG
         wp99iuELgfA+prTZQsQ5aJtzIe7MoMkC8XuUkc+ig0v+UY4YSp7H09ZRvA+DqdvHG4
         VuNJuLL25t2S2wSHYEmSazuRRyz0NYGS5T4fkm1V7Sz4S1jn23mSg9Yt7l/GEecuzL
         jN2yoKyFbE12FNITrbV5A9Zvl30RVGInPXI5ECGqG3EavwYtiYh2kHZua7lo8FCQTT
         Aw3UXC/4mhaOg==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/24] media: v4l2: Reorder field reflist
Date:   Mon, 28 Mar 2022 15:59:20 -0400
Message-Id: <20220328195936.82552-9-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
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

As per spec, the field refslist requires interleaving top and bottom
field in a specific way that does not fit inside the sort operation.
Reorder in-place the references so that their parity sart with the same
parity as the current picture and do that for both short and longterm
references separately.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 45 +++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index c3fad382882d..2f7ee8d5479f 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -243,6 +243,43 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 	return poca < pocb ? -1 : 1;
 }
 
+/*
+ * The references need to be reorder so that reference are alternating between
+ * top and bottom ref starting with the current picture parity. This have to be
+ * done for short term and long term references separately.
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
+					reflist[k] = tmplist[i];
+					k++;
+					i++;
+					break;
+				}
+			}
+
+			for (; j < b->num_valid && b->refs[tmplist[j].index].longterm == lt; j++) {
+				if (tmplist[j].fields != b->cur_pic_fields) {
+					reflist[k] = tmplist[j];
+					k++;
+					j++;
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
@@ -345,6 +382,9 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
 	sort_r(reflist, builder->num_valid, sizeof(*reflist),
 	       v4l2_h264_p_ref_list_cmp, NULL, builder);
 
+	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF)
+		reorder_field_reflist(builder, reflist);
+
 	print_ref_list_p(builder, reflist);
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
@@ -378,6 +418,11 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
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

