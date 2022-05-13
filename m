Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD80526B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384444AbiEMUaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384387AbiEMUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE437A445;
        Fri, 13 May 2022 13:29:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 5903B1F46486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473781;
        bh=KVLMxgMMO7m0lqkG6bPooOf8zeVz8lXbczHMDvPoftQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGvPOI3YVHDsb77BjdZ/SPjXymc3YG7ybPvU3YIljIeKpD9Uqo8oy6b49BNHvIiPL
         hkXhyE2iDrrbznyvMd5JRgOf6A+R0sNLJM+KYeyb1ISR51VrvBaje0Uram2HZ6p40W
         m4pNAB8Lj136BO4M4/L+m3mTN6DwZlpeCZcjv/ud1KKJllnMCA0QOmn57ZO9utnzJK
         pv4Si9izQkUPLJ1Oud2yUpJHYJO00Ntj3XMS5Sr483Oc30Rhqv4wELFTQIKIRTrEzr
         Lodryn29by7Zig4DCUkBQKarSjRXlsC+hFJ5yaeOgneQO2bbYpwsdw+xPl5wHFXfN4
         hmWcPIjwUrGFQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/20] media: v4l2: Trace calculated p/b0/b1 initial reflist
Date:   Fri, 13 May 2022 16:29:07 -0400
Message-Id: <20220513202922.13846-6-nicolas.dufresne@collabora.com>
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

Add debug print statements to print the content of P & B reference
lists, to verify that the ordering of the generated reference lists is
correct. This is especially important for the field decoding mode,
where sorting is more complex.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
2.34.3

