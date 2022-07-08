Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6629256C0B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiGHQW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbiGHQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:22:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F817478E;
        Fri,  8 Jul 2022 09:22:23 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3cab:61a1:2b1f:896b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 488C96601A2A;
        Fri,  8 Jul 2022 17:22:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657297341;
        bh=EWl41oPEID6zpGjxRHLVKEpy84BwJAMd1eH0xDCJYjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfQwJtT2o4aVYVVRfgfShVKc0OclMyXblCyQV0QBLGLj7w4Y6G41Og0s84hnQB4Ei
         8xaG6wkIgmLyvVk7Ij4lIF9Zu3nBWg6lTUm+sqr6DWBj3LbR+pYL1RgvjVqDaiNBFa
         j3By34MQnSskhUEDw6d2xhLGViOnU6R40j7wheG8Xe4OmRxJ4Y1pbD2vzE8/Q8etYF
         gnOAzCUqhT+n6NOLvK/an0tJkiIhSW8/ZdwdQGE4I6JyedXvR39ZWgUfOPb1Xs0koC
         Wg+glS6Q/TLjdz8bja37uaVGa1P6sle7nJD8X5kr8/3Gw9W0JIZIGI55YK7qTMPIXq
         NiaBhxypKLk4A==
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
Subject: [PATCH v13 13/17] media: controls: Log HEVC stateless control in .std_log
Date:   Fri,  8 Jul 2022 18:21:52 +0200
Message-Id: <20220708162156.815772-14-benjamin.gaignard@collabora.com>
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

Simply print the type of the control.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index ff8a61f24d0a..c5c5407584ff 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -307,6 +307,21 @@ static void std_log(const struct v4l2_ctrl *ctrl)
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

