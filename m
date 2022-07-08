Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4900056C070
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiGHQWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbiGHQWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:22:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2C45045;
        Fri,  8 Jul 2022 09:22:19 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3cab:61a1:2b1f:896b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 414D36601A08;
        Fri,  8 Jul 2022 17:22:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657297337;
        bh=PVStR3ApcqPTtqGenIYO4/72sXWBsjSuFtk9oWFtb7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAKuWVT8NtwQS6/0WKJTUvoWH0ScKFCPXqUt5nMgFkH8Xzx7Z22kfWio/Y4wtD9pe
         J8KpBMOsEsr8yz5CLbXFlk4f8NTcgh2YEz2fxnG4PSeiSdUJM3EvW+a+8sLC2gjIjn
         UXgEZpz48xVwmJdccAck2Q4SwbmX+Um/tU07mEVNaMKRiMvSu4MxJuMy1Gspntrc3v
         MxIgk8oCzdVK93TZXWPW2xlruKn26Hoi9uFwp8SENWtRpzmrXonZKS7vNBHGBMHknl
         nN3hiT4UhkxvsBMgdOAFrMNwYWgqY/KQhFg895zVLCg9+FeHaoilxIfKxcVDnOTcce
         FKDGr79DK3vcw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v13 07/17] media: uapi: HEVC: Add SEI pic struct flags
Date:   Fri,  8 Jul 2022 18:21:46 +0200
Message-Id: <20220708162156.815772-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708162156.815772-1-benjamin.gaignard@collabora.com>
References: <20220708162156.815772-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The possible values for the field_pic field in the v4l2_hevc_dpb_entry
structure are defined in the table D.2 in HEVC specification section D.3.3.
Add flags and documentation for each of them.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/v4l/ext-ctrls-codec.rst             | 54 +++++++++++++++++++
 include/media/hevc-ctrls.h                    | 14 +++++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 3dfb81a93935..8ba16e8742f3 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -3218,6 +3218,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     * - __u8
       - ``field_pic``
       - Whether the reference is a field picture or a frame.
+        See :ref:`HEVC dpb field pic Flags <hevc_dpb_field_pic_flags>`
     * - __u16
       - ``pic_order_cnt[2]``
       - The picture order count of the reference. Only the first element of the
@@ -3231,6 +3232,59 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 
     \normalsize
 
+.. _hevc_dpb_field_pic_flags:
+
+``HEVC dpb field pic Flags``
+
+.. raw:: latex
+
+    \scriptsize
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+    :widths:       1 1 2
+
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME``
+      - 0
+      - (progressive) Frame
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD``
+      - 1
+      - Top field
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD``
+      - 2
+      - Bottom field
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM``
+      - 3
+      - Top field, bottom field, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP``
+      - 4
+      - Bottom field, top field, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP``
+      - 5
+      - Top field, bottom field, top field repeated, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM``
+      - 6
+      - Bottom field, top field, bottom field repeated, in that order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING``
+      - 7
+      - Frame doubling
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING``
+      - 8
+      - Frame tripling
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM``
+      - 9
+      - Top field paired with previous bottom field in output order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP``
+      - 10
+      - Bottom field paired with previous top field in output order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM``
+      - 11
+      - Top field paired with next bottom field in output order
+    * - ``V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP``
+      - 12
+      - Bottom field paired with next top field in output order
+
 .. c:type:: v4l2_hevc_pred_weight_table
 
 .. raw:: latex
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 01c1795c57a9..f3695ab44389 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -132,6 +132,20 @@ struct v4l2_ctrl_hevc_pps {
 
 #define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
 
+#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME				0
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_FIELD			1
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_FIELD			2
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM			3
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP			4
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_BOTTOM_TOP			5
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_TOP_BOTTOM		6
+#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_DOUBLING			7
+#define V4L2_HEVC_SEI_PIC_STRUCT_FRAME_TRIPLING			8
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_PREVIOUS_BOTTOM	9
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_PREVIOUS_TOP	10
+#define V4L2_HEVC_SEI_PIC_STRUCT_TOP_PAIRED_NEXT_BOTTOM		11
+#define V4L2_HEVC_SEI_PIC_STRUCT_BOTTOM_PAIRED_NEXT_TOP		12
+
 #define V4L2_HEVC_DPB_ENTRIES_NUM_MAX		16
 
 struct v4l2_hevc_dpb_entry {
-- 
2.32.0

