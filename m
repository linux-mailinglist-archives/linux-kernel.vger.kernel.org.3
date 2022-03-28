Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1A4EA101
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbiC1UDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344340AbiC1UCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:02:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFF75D1AC;
        Mon, 28 Mar 2022 13:00:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 173C11F438BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497627;
        bh=5bMWt8FIlhATFg8dWZpSwD375jbwZ9dZXKe/ctzMbWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HgE8I+mDkxkQ2X9yVMvzFDQ4jmEqoeYUkBg3IBrZElVU6jyB8GKIFEdYDfaA5E7Nt
         VsYfXmZ7jIXrWHsBn57QQHjFOKAl1GAF5icpLR08XgBFPqgxXS9XG7uySm7sNh7bcK
         d3/7xeYZ3V/t6VinCbny8rAAZYBZ9TTaMEYUW1E+KTFs0+cQKnaPCTHEGvD3G40bBk
         gTiAW3vZmHVzewLprpcQJTIwAXwFY+kphUECS2Ci6zv+k0HIzAHe2YAxl/LnRClop9
         PEIrQU7bIWEKMK3Cq2pri/rmqXODlitsSCd2gAiS3y54w45iHyx+n+ae/sLMeutUl5
         BYlnDrYQVnITw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, Alex Bee <knaerzche@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1 24/24] media: rkvdec-h264: Don't hardcode SPS/PPS parameters
Date:   Mon, 28 Mar 2022 15:59:36 -0400
Message-Id: <20220328195936.82552-25-nicolas.dufresne@collabora.com>
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

From: Alex Bee <knaerzche@gmail.com>

Some SPS/PPS parameters are currently hardcoded in the driver
even though so do exist in the uapi which is stable by now.

Use them instead of hardcoding them.

Conformance tests have shown there is no difference, but it might
increase decoder performance.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 891c48bf6a51..91f65d78e453 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -655,13 +655,14 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 
 #define WRITE_PPS(value, field) set_ps_field(hw_ps->info, field, value)
 	/* write sps */
-	WRITE_PPS(0xf, SEQ_PARAMETER_SET_ID);
-	WRITE_PPS(0xff, PROFILE_IDC);
-	WRITE_PPS(1, CONSTRAINT_SET3_FLAG);
+	WRITE_PPS(sps->seq_parameter_set_id, SEQ_PARAMETER_SET_ID);
+	WRITE_PPS(sps->profile_idc, PROFILE_IDC);
+	WRITE_PPS((sps->constraint_set_flags & 1 << 3) ? 1 : 0, CONSTRAINT_SET3_FLAG);
 	WRITE_PPS(sps->chroma_format_idc, CHROMA_FORMAT_IDC);
 	WRITE_PPS(sps->bit_depth_luma_minus8, BIT_DEPTH_LUMA);
 	WRITE_PPS(sps->bit_depth_chroma_minus8, BIT_DEPTH_CHROMA);
-	WRITE_PPS(0, QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
+	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_QPPRIME_Y_ZERO_TRANSFORM_BYPASS),
+		  QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
 	WRITE_PPS(sps->log2_max_frame_num_minus4, LOG2_MAX_FRAME_NUM_MINUS4);
 	WRITE_PPS(sps->max_num_ref_frames, MAX_NUM_REF_FRAMES);
 	WRITE_PPS(sps->pic_order_cnt_type, PIC_ORDER_CNT_TYPE);
@@ -679,8 +680,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 		  DIRECT_8X8_INFERENCE_FLAG);
 
 	/* write pps */
-	WRITE_PPS(0xff, PIC_PARAMETER_SET_ID);
-	WRITE_PPS(0x1f, PPS_SEQ_PARAMETER_SET_ID);
+	WRITE_PPS(pps->pic_parameter_set_id, PIC_PARAMETER_SET_ID);
+	WRITE_PPS(pps->seq_parameter_set_id, PPS_SEQ_PARAMETER_SET_ID);
 	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE),
 		  ENTROPY_CODING_MODE_FLAG);
 	WRITE_PPS(!!(pps->flags & V4L2_H264_PPS_FLAG_BOTTOM_FIELD_PIC_ORDER_IN_FRAME_PRESENT),
-- 
2.34.1

