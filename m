Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193E04F522B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849407AbiDFCh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444129AbiDEWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:20:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4147939D;
        Tue,  5 Apr 2022 13:44:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 544301F4480B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191496;
        bh=CCCLzz5lUZJ9ab0CExOOh36ojMkZJq6/0fFDYiktq9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZo8vioRXq+507FDC7+qoDF69PTHFSESG1LRMByh7iTC0JZbFDrHzmifO6d0QZcvz
         twR7kRg0k+BppKEmOsfJlPsVpNCaayMsnosgrFzL3+52mdyJtSWQMKgf9cupl8L49g
         zS2dQ0e1fEJUle+3sje5Y4Cs4o8871jyzwiVoSIQnxhgpjcf19WBHEx3nexBofSAdn
         uQmSIgcFUbQ6fRgdqytJ7elIOW/WDRL+4Z8Zxxc53WHsf718mh7a+PNlMABQFXlm1b
         4XK99yE9XicRmcJLlJ/kxqWeLtxTtGEOwM/cpYIjE4JTEVNwIuhB+xxUmhC524npyY
         yjInyaei62pnA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 09/24] media: v4l2: Trace calculated p/b0/b1 initial reflist
Date:   Tue,  5 Apr 2022 16:44:10 -0400
Message-Id: <20220405204426.259074-10-nicolas.dufresne@collabora.com>
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

Add debug print statements to print the content of P & B reference
lists, to verify that the ordering of the generated reference lists is
correct. This is especially important for the field decoding mode,
where sorting is more complex.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/v4l2-core/v4l2-h264.c | 86 +++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 38d8dbda0045..bcf9b7774560 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -241,6 +241,87 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 	return poca < pocb ? -1 : 1;
 }
 
+static char ref_type_to_char (u8 ref_type)
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
+				     char *out_str, const int len)
+{
+	int n = 0, i;
+
+	n += snprintf(out_str + n, len - n, "|");
+
+	for (i = 0; i < builder->num_valid; i++) {
+		/* this is pic_num for frame and frame_num (wrapped) for field,
+		 * but for frame pic_num is equal to frame_num (wrapped).
+		 */
+		int frame_num = builder->refs[reflist[i].index].frame_num;
+		bool longterm = builder->refs[reflist[i].index].longterm;
+
+		n += scnprintf(out_str + n, len - n, "%i%c%c|",
+			       frame_num, longterm ? 'l' : 's',
+			       ref_type_to_char (reflist[i].fields));
+	}
+
+	return out_str;
+}
+
+static void print_ref_list_p(const struct v4l2_h264_reflist_builder *builder,
+			     struct v4l2_h264_reference *reflist)
+{
+	char buf[1024];
+
+	pr_debug("ref_pic_list_p (cur_poc %u%c) %s\n",
+		 builder->cur_pic_order_count,
+		 ref_type_to_char(builder->cur_pic_fields),
+		 format_ref_list_p(builder, reflist, buf, sizeof(buf)));
+}
+
+static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
+				     struct v4l2_h264_reference *reflist,
+				     char *out_str, const int len)
+{
+	int n = 0, i;
+
+	n += snprintf(out_str + n, len - n, "|");
+
+	for (i = 0; i < builder->num_valid; i++) {
+		int frame_num = builder->refs[reflist[i].index].frame_num;
+		u32 poc = v4l2_h264_get_poc(builder, reflist + i);
+		bool longterm = builder->refs[reflist[i].index].longterm;
+
+		n += scnprintf(out_str + n, len - n, "%i%c%c|",
+			       longterm ? frame_num : poc,
+			       longterm ? 'l' : 's',
+			       ref_type_to_char(reflist[i].fields));
+	}
+
+	return out_str;
+}
+
+static void print_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
+			     struct v4l2_h264_reference *reflist, u8 list_num)
+{
+	char buf[1024];
+
+	pr_debug("ref_pic_list_b%u (cur_poc %u%c) %s",
+		 list_num, builder->cur_pic_order_count,
+		 ref_type_to_char (builder->cur_pic_fields),
+		 format_ref_list_b(builder, reflist, buf, sizeof(buf)));
+}
+
 /**
  * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
@@ -261,6 +342,8 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
 	       sizeof(builder->unordered_reflist[0]) * builder->num_valid);
 	sort_r(reflist, builder->num_valid, sizeof(*reflist),
 	       v4l2_h264_p_ref_list_cmp, NULL, builder);
+
+	print_ref_list_p(builder, reflist);
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
 
@@ -296,6 +379,9 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
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

