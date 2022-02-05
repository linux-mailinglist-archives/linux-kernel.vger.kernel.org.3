Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DA4AAB84
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiBES44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:56:56 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:44739 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357192AbiBESzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:31 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3CE6E240004;
        Sat,  5 Feb 2022 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aoT5FIIERp7lgQaWfQERGBqlEF8kPpVGe2H5GlAjDAU=;
        b=MbZlqpo+b00Hh2nbKGCBM48X6DDgk5MJERBY7APh+BptuWLVJi517xPlSh84ex+VPGwM0w
        tHsquib6dgR0hZ+MYjwXhnw6o+Fgls6v58oY03jOZNNPiyBKPqPMclbXah7kztSt50Xc7C
        4F2sZagSjTgrcm/Rv9jJ3bAB6zP2xOWvOxMqIgnG7UTfdGHrLKSVkPbLxKDAQx8P66IYVc
        EJJvE8YTWMtUBSdswLBJcIdpiXZ/H4rVjKma+sFXxPYs3QwaN+fuytbmTwEjjnPxj587Ay
        fiNWHCPEbXu9ng4HX0ww+rX7CnXeOPPLt68RXSJaCcNreWQjGYL/WmNjeIpgtA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 29/66] media: sun6i-csi: Move csi buffer definition to main header file
Date:   Sat,  5 Feb 2022 19:53:52 +0100
Message-Id: <20220205185429.2278860-30-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer structure is a top-level definition, put it in the main header
to keep things tidy. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h   | 9 +++++++++
 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 356661b413f8..4dd83e57bafa 100644
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
2.34.1

