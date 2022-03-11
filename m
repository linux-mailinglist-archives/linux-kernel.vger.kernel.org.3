Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7B4D63D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349831AbiCKOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbiCKOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:29 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736A11C9467;
        Fri, 11 Mar 2022 06:36:14 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A547F240013;
        Fri, 11 Mar 2022 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s18NrUi/W9m7iDrtX6X6WlrK2Xvr6urYYt5kdcn3Hqo=;
        b=OLk6XG83H2m8vI7vSd8KrNtGYiUPX7ENKPqxyjx1Vg7dLaIB5rEIWsNCyFjYg0mHL7QNMd
        aiKO17rSblGaiUCHwBOKRbX7gc/fSGZ2GAzn3G8SyKCJJcxYvp+2K7jXSMoK1lbOEHRsBy
        u30F6gRusptsrxyxGrbdUhN7pfb3NGcVG677G5S3H8mUFC1vBZjMgijXLAIdP2bLn6OWUs
        usdJK7NWCJyMGHr20TNofD7TAaEreXu5NwN5XfugGuYim72eqx1ryCUC/c/1ErLqbsWfW/
        GvKRnhM9voYErqM5ml3dxePwyzYtmAW1wPhvML5O99Zhb9xO9PLxxiX7/UCuzQ==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 15/46] media: sun6i-csi: Move csi buffer definition to main header file
Date:   Fri, 11 Mar 2022 15:35:01 +0100
Message-Id: <20220311143532.265091-16-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer structure is a top-level definition, put it in the main header
to keep things tidy. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h   | 9 +++++++++
 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 3c4a3af6b897..404e304e4ff6 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -11,12 +11,21 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
+#include <media/videobuf2-v4l2.h>
 
 #include "sun6i_video.h"
 
 #define SUN6I_CSI_NAME		"sun6i-csi"
 #define SUN6I_CSI_DESCRIPTION	"Allwinner A31 CSI Device"
 
+struct sun6i_csi_buffer {
+	struct vb2_v4l2_buffer		v4l2_buffer;
+	struct list_head		list;
+
+	dma_addr_t			dma_addr;
+	bool				queued_to_csi;
+};
+
 /**
  * struct sun6i_csi_config - configs for sun6i csi
  * @pixelformat: v4l2 pixel format (V4L2_PIX_FMT_*)
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 6f5470a6859d..d32ff6b81f8a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -23,14 +23,6 @@
 #define MAX_WIDTH	(4800)
 #define MAX_HEIGHT	(4800)
 
-struct sun6i_csi_buffer {
-	struct vb2_v4l2_buffer		v4l2_buffer;
-	struct list_head		list;
-
-	dma_addr_t			dma_addr;
-	bool				queued_to_csi;
-};
-
 /* Helpers */
 
 static struct v4l2_subdev *
-- 
2.35.1

