Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6DE4C6EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiB1OKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiB1OJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:09:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75252E19;
        Mon, 28 Feb 2022 06:08:54 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:82d4:230a:70ff:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 03F4C1F43AB8;
        Mon, 28 Feb 2022 14:08:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646057333;
        bh=rs9RdUWG4TxsqIsVBwg0rye1IPGpH5Z/mSNfvCbkwaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+KyTCr/hdPD2O7WrDNV7RPxaSbBcgZ1OA/r0huCCeRC2/0VMpS8Qkic1/0wP9wyf
         /d0fVKZ10/Y/OEu9jyCsx3kt80kA2LQtNvuKQRmdBxIawtLvjAHGN5SxjZzNAuDrSI
         ZX1/94Db8rD4fD+U3XNm0++mXcjd60NzJShbWcurvmDRwwXwawsuUFjLUyctSen0Yg
         Zmyym5whJM/hrJxPtLXYJtdzb2/gMb4ZDZb/4PYJ0NDQYgJ8/+PfkRW0qr/zdlJ/8F
         dxB5Etvm10mFIvFZAgRt6AwcCPP96B/dzMAZ6xiy+ITbM6ErlgYdPW9OASSDBjoYLw
         xxJrUW36SycUA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 11/15] media: controls: Log HEVC stateless control in .std_log
Date:   Mon, 28 Feb 2022 15:08:34 +0100
Message-Id: <20220228140838.622021-12-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply print the type of the control.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 2d24cb8d3926..694de414f545 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -289,6 +289,21 @@ static void std_log(const struct v4l2_ctrl *ctrl)
 	case V4L2_CTRL_TYPE_VP9_FRAME:
 		pr_cont("VP9_FRAME");
 		break;
+	case V4L2_CTRL_TYPE_HEVC_SPS:
+		pr_cont("HEVC_SPS");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_PPS:
+		pr_cont("HEVC_PPS");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
+		pr_cont("HEVC_SLICE_PARAMS");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX:
+		pr_cont("HEVC_SCALING_MATRIX");
+		break;
+	case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
+		pr_cont("HEVC_DECODE_PARAMS");
+		break;
 	default:
 		pr_cont("unknown type %d", ctrl->type);
 		break;
-- 
2.32.0

