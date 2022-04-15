Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F7502D20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355216AbiDOPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355513AbiDOPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:32:49 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5CD5546;
        Fri, 15 Apr 2022 08:29:04 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B7516E0013;
        Fri, 15 Apr 2022 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGj0QnH8QxZA9mRlqEQryshwhN+v1j41f5zJdRdM9m4=;
        b=GknlYP5+vG8cneVCfJ35894QrnXKkvkSEa00P2ZF9hmjJYA0oYV04WTLcdVoBDWqTWl6sn
        6oFGWB3nPxClOOSnFuj2ptQvZ52BS+mp2nBwukWelOtiYvAC+syTTOic+96ALSoKjB2alJ
        ClPsJMCgPubTPWaJ4XRZqqJtbJoJKwK7Rd1dlFdcm6Hx2tvnKvhhMtiyAvP9C8Ntbdq+KI
        7bHYb8vSZsLXpM4Dl5fYLoLnHlta0/3EDd4zjOVANIVIeiku/zYJMbSo26Jvc+0R6bwslg
        5ObhOWS97I+DEVKkFDGR3Nn+5CL6L+mZVYW08RSsDScRUNzzF6DgeNYNTIqK9Q==
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
Subject: [PATCH v4 37/45] media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
Date:   Fri, 15 Apr 2022 17:28:03 +0200
Message-Id: <20220415152811.636419-38-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
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
index a6619d083308..c3b1e1411da4 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1027,7 +1027,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 
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
2.35.2

