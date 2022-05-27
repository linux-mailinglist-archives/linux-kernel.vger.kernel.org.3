Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31C0536434
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353428AbiE0OdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353340AbiE0OcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:32:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A403701A;
        Fri, 27 May 2022 07:32:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id D52961F462DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653661921;
        bh=PmxaFIrP9yyw28hXRNq0XOgbJF4mq11NMqZdSpjXgwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asKbBrzlf7DFPxa4MqNWJfgtG5QFqOwDsacOM6zbP/v+6ysoxWEYF8466DGfoFvvD
         f+mfE2uU4vPzGCmEo5KJOSq9VvMmSEa35ghdJ46CNjj6stz4EboDZfUQn5NOOFsoOR
         H/JnGN6NqqfKLKv4fjJ90gbaubTiRxBkYlu9DVceEnFVudJ/eICj0eUnk7fhJRdhks
         Bkp3Y7XcR0vez0HaFxvcOQu0ngL1O23EhKPWrnYOxG9vfHhiVt/CacQ+5OLZvB7QqA
         i8AGp3PVpwtrJjybyGsvoReBvHpCjV/quzEr6bXLQT410ssWjM2qcDWxo4UZPPFuPg
         87cTuwuy4txbQ==
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
Subject: [PATCH v6 16/17] media: uapi: Change data_bit_offset definition
Date:   Fri, 27 May 2022 16:31:33 +0200
Message-Id: <20220527143134.3360174-17-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
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

'F.7.3.6.1 General slice segment header syntax' section of HEVC
specification describes that a slice header always end aligned on
byte boundary, therefore we only need to provide the data offset in bytes.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++--
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
 include/media/hevc-ctrls.h                                | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 48a8825a001b..37079581c661 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -3008,8 +3008,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
       - ``bit_size``
       - Size (in bits) of the current slice data.
     * - __u32
-      - ``data_bit_offset``
-      - Offset (in bits) to the video data in the current slice data.
+      - ``data_byte_offset``
+      - Offset (in bytes) to the video data in the current slice data.
     * - __u32
       - ``num_entry_point_offsets``
       - Specifies the number of entry point offset syntax elements in the slice header.
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 411601975124..835454239f73 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -405,7 +405,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 	/* Initialize bitstream access. */
 	cedrus_write(dev, VE_DEC_H265_TRIGGER, VE_DEC_H265_TRIGGER_INIT_SWDEC);
 
-	cedrus_h265_skip_bits(dev, slice_params->data_bit_offset);
+	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8);
 
 	/* Bitstream parameters. */
 
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 9abca1a75bd4..936ff693967b 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -312,7 +312,7 @@ struct v4l2_hevc_pred_weight_table {
  * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
  *
  * @bit_size: size (in bits) of the current slice data
- * @data_bit_offset: offset (in bits) to the video data in the current slice data
+ * @data_byte_offset: offset (in bytes) to the video data in the current slice data
  * @num_entry_point_offsets: specifies the number of entry point offset syntax
  *			     elements in the slice header.
  * @nal_unit_type: specifies the coding type of the slice (B, P or I)
@@ -356,7 +356,7 @@ struct v4l2_hevc_pred_weight_table {
  */
 struct v4l2_ctrl_hevc_slice_params {
 	__u32	bit_size;
-	__u32	data_bit_offset;
+	__u32	data_byte_offset;
 	__u32	num_entry_point_offsets;
 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
 	__u8	nal_unit_type;
-- 
2.32.0

