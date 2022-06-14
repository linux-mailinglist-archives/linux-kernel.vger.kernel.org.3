Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247A654ABF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352876AbiFNIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353277AbiFNIgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:36:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4942480;
        Tue, 14 Jun 2022 01:36:38 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4a7b:8d3a:acaa:ec46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC92C66016B2;
        Tue, 14 Jun 2022 09:36:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655195797;
        bh=x0nxGwrt50+4LgCDX6/bdpXdRkeiHuZS/A3/2NyD25E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlaolstlS0hY3UERM6ovgpSjPlb6iGnL2gFs59ZrXwUqXvmm3K8xW3cXeNR/YL0cq
         MTah8bjxVDhPk9fTwx0P8NbxAE0RicWOWRpsPQfDVRxBCdm8Nedtews8EpwUu5Z7VW
         3/LkzdMEA3VmmSTO5MlZqTapwcXKRLNaEnobphmNQSC32vMK0RIBRVCWnLt08q1ug5
         WN7MYqZuYbGr+GxGV5o1xcRzASQ9IGN7z3+y3da8xDGokMJCYHfbV7lG9LgqIOn+du
         QM1MCywowVNrAQgVsVF7LivBetWnns7Ftdy9ZkY3YiFvK3xDEHmfAW6pPHg7Lux4JN
         ZSHtFDk/cmvBw==
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
Subject: [PATCH v8 09/17] media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Date:   Tue, 14 Jun 2022 10:36:06 +0200
Message-Id: <20220614083614.240641-10-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614083614.240641-1-benjamin.gaignard@collabora.com>
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com>
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

Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
a dynamic array control type.
Some drivers may be able to receive multiple slices in one control
to improve decoding performance.

Define the max size of the dynamic that can driver can set in .dims = {}.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 7:
- Add Jernej patch to set array dims for Cedrus

version 6:
- Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
  V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
- Add a define for max slices count

 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
 drivers/staging/media/sunxi/cedrus/cedrus.c               | 1 +
 include/media/hevc-ctrls.h                                | 5 +++++
 4 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 06b967de140c..0796b1563daa 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2986,6 +2986,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     These bitstream parameters are defined according to :ref:`hevc`.
     They are described in section 7.4.7 "General slice segment header
     semantics" of the specification.
+    This control is a dynamically sized 1-dimensional array,
+    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
 
 .. c:type:: v4l2_ctrl_hevc_slice_params
 
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 9f55503cd3d6..d594efbcbb93 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1510,6 +1510,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		break;
 	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
 		*type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
+		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
 		break;
 	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
 		*type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 87be975a72b6..f3391c7c811c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -178,6 +178,7 @@ static const struct cedrus_control cedrus_controls[] = {
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
+			.dims   = { 1 },
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 0dbd5d681c28..140151609c96 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -311,9 +311,14 @@ struct v4l2_hevc_pred_weight_table {
 #define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 8)
 #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
 
+#define V4L2_HEVC_SLICE_MAX_COUNT	600
+
 /**
  * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
  *
+ * This control is a dynamically sized 1-dimensional array,
+ * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
+ *
  * @bit_size: size (in bits) of the current slice data
  * @data_bit_offset: offset (in bits) to the video data in the current slice data
  * @nal_unit_type: specifies the coding type of the slice (B, P or I)
-- 
2.32.0

