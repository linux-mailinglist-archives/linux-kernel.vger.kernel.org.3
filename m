Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C284850FE20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350424AbiDZNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350352AbiDZNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC317F12E;
        Tue, 26 Apr 2022 05:58:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 4B5B21F43992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977895;
        bh=dscra9aQy+OFrcD4i/Eei0e+7LpQWDlVC/URKqG2tgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8KPWohhHtPMfo5ZDHvEBRpE5RfRlbI8ZEfc8l5GyboDgpVkJIaiqDaqpSrmndrn+
         EVE6Ha4ffWfANezr5G6auwR0yo0W3yl+9dICKCSkpkao0PLtDxd4KmJXLKN8pFZ4zy
         RzWRLVH0QiHXtJdUYuXDVvOc6Gg/vpNzKtMf3YYvz/tlZFpPg/CJ1TnQtgJ1xC5gv+
         1lGRvTN1P77AbyxqNyBY6phqMApzfSbB7YOCMk+sRCenCi0q6r+7KHRtWtpl+t0CuF
         7N/Zc7ac1pze0BaS7FcWyGlvHxiH1WOp2FcZi14C4CxeFeYTi43RNVrTghsOlKOPml
         P6ZwQpWaQWPiw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/24] media: v4l2: Trace calculated p/b0/b1 initial reflist
Date:   Tue, 26 Apr 2022 08:57:35 -0400
Message-Id: <20220426125751.108293-10-nicolas.dufresne@collabora.com>
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

Add debug print statements to print the content of P & B reference
lists, to verify that the ordering of the generated reference lists is
correct. This is especially important for the field decoding mode,
where sorting is more complex.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 100 ++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 38d8dbda0045..853f54e0fe67 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -12,6 +12,12 @@
 
 #include <media/v4l2-h264.h>
 
+/*
+ * Size of the tempory buffer allocated when printing reference lists. The
+ * output will be truncated if the size is too small.
+ */
+static const int tmp_str_size = 1024;
+
 /**
  * v4l2_h264_init_reflist_builder() - Initialize a P/B0/B1 reference list
  *				      builder
@@ -241,6 +247,95 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 	return poca < pocb ? -1 : 1;
 }
 
+static char ref_type_to_char(u8 ref_type)
+{
+	switch (ref_type) {
+	case V4L2_H264_FRAME_REF:
+		return 'f';
+	case V4L2_H264_TOP_FIELD_REF:
+		return 't';
+	case V4L2_H264_BOTTOM_FIELD_REF:
+		return 'b';
+	}
+
+	return '?';
+}
+
+static const char *format_ref_list_p(const struct v4l2_h264_reflist_builder *builder,
+				     struct v4l2_h264_reference *reflist,
+				     char **out_str)
+{
+	int n = 0, i;
+
+	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
+
+	n += snprintf(*out_str + n, tmp_str_size - n, "|");
+
+	for (i = 0; i < builder->num_valid; i++) {
+		/* this is pic_num for frame and frame_num (wrapped) for field,
+		 * but for frame pic_num is equal to frame_num (wrapped).
+		 */
+		int frame_num = builder->refs[reflist[i].index].frame_num;
+		bool longterm = builder->refs[reflist[i].index].longterm;
+
+		n += scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
+			       frame_num, longterm ? 'l' : 's',
+			       ref_type_to_char(reflist[i].fields));
+	}
+
+	return *out_str;
+}
+
+static void print_ref_list_p(const struct v4l2_h264_reflist_builder *builder,
+			     struct v4l2_h264_reference *reflist)
+{
+	char *buf = NULL;
+
+	pr_debug("ref_pic_list_p (cur_poc %u%c) %s\n",
+		 builder->cur_pic_order_count,
+		 ref_type_to_char(builder->cur_pic_fields),
+		 format_ref_list_p(builder, reflist, &buf));
+
+	kfree(buf);
+}
+
+static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
+				     struct v4l2_h264_reference *reflist,
+				     char **out_str)
+{
+	int n = 0, i;
+
+	*out_str = kmalloc(tmp_str_size, GFP_KERNEL);
+
+	n += snprintf(*out_str + n, tmp_str_size - n, "|");
+
+	for (i = 0; i < builder->num_valid; i++) {
+		int frame_num = builder->refs[reflist[i].index].frame_num;
+		u32 poc = v4l2_h264_get_poc(builder, reflist + i);
+		bool longterm = builder->refs[reflist[i].index].longterm;
+
+		n += scnprintf(*out_str + n, tmp_str_size - n, "%i%c%c|",
+			       longterm ? frame_num : poc,
+			       longterm ? 'l' : 's',
+			       ref_type_to_char(reflist[i].fields));
+	}
+
+	return *out_str;
+}
+
+static void print_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
+			     struct v4l2_h264_reference *reflist, u8 list_num)
+{
+	char *buf = NULL;
+
+	pr_debug("ref_pic_list_b%u (cur_poc %u%c) %s",
+		 list_num, builder->cur_pic_order_count,
+		 ref_type_to_char(builder->cur_pic_fields),
+		 format_ref_list_b(builder, reflist, &buf));
+
+	kfree(buf);
+}
+
 /**
  * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
@@ -261,6 +356,8 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
 	       sizeof(builder->unordered_reflist[0]) * builder->num_valid);
 	sort_r(reflist, builder->num_valid, sizeof(*reflist),
 	       v4l2_h264_p_ref_list_cmp, NULL, builder);
+
+	print_ref_list_p(builder, reflist);
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
 
@@ -296,6 +393,9 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
 	if (builder->num_valid > 1 &&
 	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
 		swap(b1_reflist[0], b1_reflist[1]);
+
+	print_ref_list_b(builder, b0_reflist, 0);
+	print_ref_list_b(builder, b1_reflist, 1);
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_build_b_ref_lists);
 
-- 
2.34.1

