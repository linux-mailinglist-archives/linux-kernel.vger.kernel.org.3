Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A48A54F71F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382280AbiFQL6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382177AbiFQL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:58:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478652B251;
        Fri, 17 Jun 2022 04:58:16 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 958D3660183F;
        Fri, 17 Jun 2022 12:58:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655467095;
        bh=Bi9ZgazJJwK+UkLeBW4Jrqy71/5gwlYkkwpr++kSPkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6NLed4jxlXHDJPD/q4xzy1Fl7/Bqux8fDkPtfQqt3OTbEmyg4aKG3s2xWyB6cRLY
         QlZW2trGVdOF/x2dTMvEYIMCKKcVT/TX2AzPUr6p7neNVfqOdSLZ3EdVon9Yw7ivwe
         y+xAHhMRyMxupaPm6VyvGapLJ9PNDuMNlp3DFvvNoBz8gLx2gVCdoqdvCDWSc7OD/r
         NCesnf18jXkKzrQ09TVqWylBbdEXFZzoakQUodTkexabf+na8RuWQaTQKJV5BUNOFM
         Jh8ra96L+qdOPpSNLfENziK7H/aCewUCmlP6sbRroEzGiv41iGe3+WE1+2gxvzOFPZ
         MkcefIlVFHb+Q==
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
Subject: [PATCH 6/7] media: hantro: imx8m: Enable 10bit decoding
Date:   Fri, 17 Jun 2022 13:58:01 +0200
Message-Id: <20220617115802.396442-7-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
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

Expose 10bit pixel formats to enable 10bit decoding in IMX8M SoCs.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/hantro/imx8m_vpu_hw.c | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
index 77f574fdfa77..b390228fd3b4 100644
--- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
+++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
@@ -162,12 +162,39 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
 			.step_height = MB_DIM,
 		},
 	},
+	{
+		.fourcc = V4L2_PIX_FMT_P010,
+		.codec_mode = HANTRO_MODE_NONE,
+		.postprocessed = true,
+		.frmsize = {
+			.min_width = FMT_MIN_WIDTH,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = FMT_MIN_HEIGHT,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
 };
 
 static const struct hantro_fmt imx8m_vpu_g2_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12_4L4,
 		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
+		.frmsize = {
+			.min_width = FMT_MIN_WIDTH,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = TILE_MB_DIM,
+			.min_height = FMT_MIN_HEIGHT,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = TILE_MB_DIM,
+		},
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_P010_4L4,
+		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
 		.frmsize = {
 			.min_width = FMT_MIN_WIDTH,
 			.max_width = FMT_UHD_WIDTH,
-- 
2.32.0

