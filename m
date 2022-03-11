Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327624D63D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349825AbiCKOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349555AbiCKOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:38:08 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E631C9463;
        Fri, 11 Mar 2022 06:36:47 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F3FA924000B;
        Fri, 11 Mar 2022 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bMGZvUt/JePqe8VlEu0KjPrl5T3acogQy4sy4Jv7Pk=;
        b=S0RcmxYe36RaOp5pAeZIyeJ3EZAlPXqkVDFQbUGzY4a8rIoxXPY94bIRXmuv8xnpMnW92F
        3FsbsA7wX4kTa0nEFPHMGUepGGKCRoZZVgElMQlvCsymFPjZkPx/ABe/qJqMCQC1jH9IFY
        sAwaVpFbg/CFDZmAJLrNqw75Bixp6a93mPJa6aMKDjzLBXMz8IgLBqq+ryOEBXtXr0Fh06
        kN8fVB6Z5OqCiDRLUoAwB7+Bvdk3HzuXmMggjLtG3TD395aWqJaCtaAsFwuNbxW3x/jM/j
        ELRhE3wiVLfN2r5qBxzXZLXC32CpIluz1r7o6z28QFF886d0wOjd5zIyWVIviw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 38/46] media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
Date:   Fri, 11 Mar 2022 15:35:24 +0100
Message-Id: <20220311143532.265091-39-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
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

Now that the driver is properly split between bridge and capture,
rename the video device to highlight its role and be in line with
the bridge entity naming.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 3 ++-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 6033acaa9564..85ea7812e991 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1020,7 +1020,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 
 	/* Video Device */
 
-	strscpy(video_dev->name, SUN6I_CSI_NAME, sizeof(video_dev->name));
+	strscpy(video_dev->name, SUN6I_CSI_CAPTURE_NAME,
+		sizeof(video_dev->name));
 	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
 	video_dev->vfl_dir = VFL_DIR_RX;
 	video_dev->release = video_device_release_empty;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index a61db3bc72e5..59c57bcefeec 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -11,6 +11,8 @@
 #include <media/v4l2-dev.h>
 #include <media/videobuf2-core.h>
 
+#define SUN6I_CSI_CAPTURE_NAME	"sun6i-csi-capture"
+
 #define SUN6I_CSI_CAPTURE_WIDTH_MIN	32
 #define SUN6I_CSI_CAPTURE_WIDTH_MAX	4800
 #define SUN6I_CSI_CAPTURE_HEIGHT_MIN	32
-- 
2.35.1

