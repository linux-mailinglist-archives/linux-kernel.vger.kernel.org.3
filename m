Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B05A2EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbiHZSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbiHZSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:36 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EFDE58A1;
        Fri, 26 Aug 2022 11:33:25 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3CBFBFF808;
        Fri, 26 Aug 2022 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYTuQV1Xs4yw7WQUODfE04pJZGBT+lD8NI+hbXDGsg0=;
        b=WYKWUz/tI/JZi7LsD/IDPO7wgmwanoY8T+d5FcYNf9OPzDrGNMEuulSkilqJ30hgRZxPg/
        vOb7Sq2vMaMIfk1gKF4/QxDvlc5v3FraEpC3kEhaFjv5B2mldvq6hSHVhu+liLm+D8+iQF
        qfEkJaG9Ou84C51iamN/aPtnadSH/pVMiG1l/f2jk6CjnvqPfOmhVmDcdnX1x/ZcQB68RA
        EUD4pktLfxE64n1lvPRzCYfqKyZNoFIbfoXUgC6HsASH7L95J6+RLWOs7ZTX13zjXtIuJJ
        y5GO6kZz+tqHphXQEapfXGwJpv8Knef9UP18VZ3XQAmUAn7f9iTK/BBE4UtmLg==
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
Subject: [PATCH v6 15/43] media: sun6i-csi: Move csi buffer definition to main header file
Date:   Fri, 26 Aug 2022 20:32:12 +0200
Message-Id: <20220826183240.604834-16-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 1edc3e91ba6f..3c72d865a01a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -10,12 +10,21 @@
 
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
index a40927899828..42b10c61b60d 100644
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
2.37.1

