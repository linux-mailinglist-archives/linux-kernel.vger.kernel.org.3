Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4904483D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiADHi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiADHiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:38:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9CFC061761;
        Mon,  3 Jan 2022 23:38:53 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d353:5de8:6c9d:602a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DED4E1F416F9;
        Tue,  4 Jan 2022 07:38:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641281932;
        bh=27jKMgWeYwR8aVibrTCtYSknu0GLlBzN0y68vGHFqSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsP3azh0JXkSM/HxX5C3ttJybNb1GBA2feHuu406N/TCvNDi42/T05Xy9uRXjxtEp
         PAhTne11bugJB7AH5+gWwDDfoBVGSsoE0nK9P6GRR9ieqPOzL7+4izv46oGlflKtTv
         v95JS9IRMc7v3vogdFkccNjFZtZgoShxhThsUhlBKNP0F2xUcSC6sZTtSIrUJ+2HiG
         7zt/l4gcgergLpa5NAUVyvII13LEoKlV+m/ZnpeYckBC69px26lbgmTFTzoRtptlYX
         SQUqQ6GfAYccqn+8VnDJo8Ki9dgPexJpMA0V9vpx4w5fDOAQNpeJtX6EDHdNom4RKb
         U6bE5Qx2PrW+A==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, jernej.skrabec@gmail.com,
        nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 1/2] media: hevc: Remove RPS named flags
Date:   Tue,  4 Jan 2022 08:38:41 +0100
Message-Id: <20220104073842.1791639-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104073842.1791639-1-benjamin.gaignard@collabora.com>
References: <20220104073842.1791639-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marking a picture as long-term reference is valid for DPB but not for RPS.
Change flag name to match with it description in HEVC spec chapiter
"8.3.2 Decoding process for reference picture set".
Remove the other unused RPS flags.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 4:
- check flags with & and not ==

 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 8 +++-----
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c         | 2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
 include/media/hevc-ctrls.h                                | 6 ++----
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index e141f0e4eec9..38da33e61c3d 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -3166,11 +3166,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 	:c:func:`v4l2_timeval_to_ns()` function to convert the struct
 	:c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
     * - __u8
-      - ``rps``
-      - The reference set for the reference frame
-        (V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_BEFORE,
-        V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_AFTER or
-        V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR)
+      - ``flags``
+      - Long term flag for the reference frame
+        (V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE)
     * - __u8
       - ``field_pic``
       - Whether the reference is a field picture or a frame.
diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index 99d8ea7543da..14e0e6414100 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -433,7 +433,7 @@ static int set_ref(struct hantro_ctx *ctx)
 		chroma_addr = luma_addr + cr_offset;
 		mv_addr = luma_addr + mv_offset;
 
-		if (dpb[i].rps == V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR)
+		if (dpb[i].flags & V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE)
 			dpb_longterm_e |= BIT(V4L2_HEVC_DPB_ENTRIES_NUM_MAX - 1 - i);
 
 		hantro_write_addr(vpu, G2_REF_LUMA_ADDR(i), luma_addr);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 8829a7bab07e..8ab2d9c6f048 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -169,7 +169,7 @@ static void cedrus_h265_ref_pic_list_write(struct cedrus_dev *dev,
 		unsigned int index = list[i];
 		u8 value = list[i];
 
-		if (dpb[index].rps == V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR)
+		if (dpb[index].flags & V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE)
 			value |= VE_DEC_H265_SRAM_REF_PIC_LIST_LT_REF;
 
 		/* Each SRAM word gathers up to 4 references. */
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index ef63bc205756..01ccda48d8c5 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -127,15 +127,13 @@ struct v4l2_ctrl_hevc_pps {
 	__u64	flags;
 };
 
-#define V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_BEFORE	0x01
-#define V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_AFTER	0x02
-#define V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR		0x03
+#define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
 
 #define V4L2_HEVC_DPB_ENTRIES_NUM_MAX		16
 
 struct v4l2_hevc_dpb_entry {
 	__u64	timestamp;
-	__u8	rps;
+	__u8	flags;
 	__u8	field_pic;
 	__u16	pic_order_cnt[2];
 	__u8	padding[2];
-- 
2.30.2

