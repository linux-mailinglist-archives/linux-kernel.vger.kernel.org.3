Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD204EA0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbiC1UCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbiC1UCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:02:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24259A77;
        Mon, 28 Mar 2022 13:00:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 394D21F438A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497616;
        bh=PqdQnTESUHQAXRfjK8M+MyHsl8WocJ3A7cMRoX/7vwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFTmVD0qqy2AA0++iIq5Y4/vmDXOq4qBb9aPdbD0Rv36lYHxr+O/H+EN9aTHBQk66
         EOhqW1TUr8j+S5Meu+XfMG6ROIgibKAf/fxXGzfbYIDutmlnlBwHclIR0e9vt+7J7c
         H8cjgxv1muMhwijlvLK+/Rtl+Rx3yRJrlzu4Ej6ySdXodtRoJleMzt3sSt1KsfZybn
         rm1/2BJmizUymlb3kbaQLIgcD90zpqGjnl6wgO2LQlZF05kbUqdPoDslAgNkcBvLTc
         SvFAo7+mmkTjWHRTFSKh3xqzokOJ1KH0qoBEo53dd8M8n/o0w25MlVU43rrRL+74Ug
         FjPikprYubBQw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v1 18/24] media: rkvdec: h264: Fix bit depth wrap in pps packet
Date:   Mon, 28 Mar 2022 15:59:30 -0400
Message-Id: <20220328195936.82552-19-nicolas.dufresne@collabora.com>
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

From: Jonas Karlman <jonas@kwiboo.se>

The luma and chroma bit depth fields in the pps packet is 3 bits wide.
8 is wrongly added to the bit depth value written to these 3-bit fields.
Because only the 3 LSB is written the hardware is configured correctly.

Correct this by not adding 8 to the luma and chroma bit depth value.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 847b8957dad3..ec52b195bbd7 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -662,8 +662,8 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 	WRITE_PPS(0xff, PROFILE_IDC);
 	WRITE_PPS(1, CONSTRAINT_SET3_FLAG);
 	WRITE_PPS(sps->chroma_format_idc, CHROMA_FORMAT_IDC);
-	WRITE_PPS(sps->bit_depth_luma_minus8 + 8, BIT_DEPTH_LUMA);
-	WRITE_PPS(sps->bit_depth_chroma_minus8 + 8, BIT_DEPTH_CHROMA);
+	WRITE_PPS(sps->bit_depth_luma_minus8, BIT_DEPTH_LUMA);
+	WRITE_PPS(sps->bit_depth_chroma_minus8, BIT_DEPTH_CHROMA);
 	WRITE_PPS(0, QPPRIME_Y_ZERO_TRANSFORM_BYPASS_FLAG);
 	WRITE_PPS(sps->log2_max_frame_num_minus4, LOG2_MAX_FRAME_NUM_MINUS4);
 	WRITE_PPS(sps->max_num_ref_frames, MAX_NUM_REF_FRAMES);
-- 
2.34.1

