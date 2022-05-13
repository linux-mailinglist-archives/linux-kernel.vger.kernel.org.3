Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5E526B86
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384188AbiEMUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384378AbiEMUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED777F2A;
        Fri, 13 May 2022 13:29:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 3BABA1F46487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473784;
        bh=Vra7LsHrOdEcIBqrM9/POp0obwO6NMVDgAU9FK3KQ+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmo23fQjBPdo8JI2PkxYjwweogzgLdG9a6DK5ZGB7V0mALSFfrt6uM7yGvSvWQN+Q
         wKLB4aEsWy8x+sa0pHUzht0n0LKknstj8zHIpLKVjQ+4RUwm7PYUUHrLLSBxIUa/Ej
         1Osb0d5oxmLWR+FNXMuK620GHgPilmibWDp1bBOPZKU2JYYDMXK+VGl5J/3GBXgokd
         CbT49FvIEIIvU6D1rUquPOfLAXPBremmRGaIBDF9V8mo5H1/XBYoxcPZIYdqbeIp61
         eaMNmj3+eMp+NHCRLdF9PUIBgbAkukPwo3WYXTZfVBbYlKKqlTlDPSm5kYK0mKqG+T
         yBnN7/oW1yq2Q==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/20] media: v4l2: Reorder field reflist
Date:   Fri, 13 May 2022 16:29:09 -0400
Message-Id: <20220513202922.13846-8-nicolas.dufresne@collabora.com>
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

As per spec, the field reflist requires interleaving top and bottom
field in a specific way that does not fit inside the sort operation.
The process consist of alternating references parity, starting with
a reference of the same parity as the current picture. This
processs is done twice, once for short term references and a second
time for the long term references.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/v4l2-core/v4l2-h264.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index fe215035d9e8..72bd64f65198 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -250,6 +250,40 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
 	return poca < pocb ? -1 : 1;
 }
 
+/*
+ * The references need to be reordered so that references are alternating
+ * between top and bottom field references starting with the current picture
+ * parity. This has to be done for short term and long term references
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
 static char ref_type_to_char(u8 ref_type)
 {
 	switch (ref_type) {
@@ -360,6 +394,9 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
 	sort_r(reflist, builder->num_valid, sizeof(*reflist),
 	       v4l2_h264_p_ref_list_cmp, NULL, builder);
 
+	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF)
+		reorder_field_reflist(builder, reflist);
+
 	print_ref_list_p(builder, reflist);
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
@@ -393,6 +430,11 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
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
2.34.3

