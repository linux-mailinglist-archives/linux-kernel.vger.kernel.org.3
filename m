Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507624AAC0C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381153AbiBES7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243650AbiBES47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:59 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E22C043181;
        Sat,  5 Feb 2022 10:56:19 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0175A240002;
        Sat,  5 Feb 2022 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=majeYqv001Hk/JLaXWth7OAGgt7K7pFuA9tBX2AQZdA=;
        b=abPysJQbp5jULxHX49048PYYBx4305nxRe5w5u+VzfslzR2LiQA83/qY67Eq4h8C67wpwA
        uxTAjeZvzPPuZvb7U/q0QmONjb5Mw2Ry2xiyGOlABIKzeN1DdSUHlYTA+TKHbmfvsAmnUB
        QMVIj8AMCDX+VcXHM2LRzwW+mZMzi6DE6EbEUmjbHL2kR0UNV0YKNZLF7k0bAQzR5LRTnn
        JM62yWhFlqv9uNgnImYII7167XJiepzIzHPXq8vTzPyIyKur6SjJQ0No8vpKjFd4RiGm0u
        laqRZILqkcha5m7G2Y3QcQTJZWtUyQOWrvw3VoKJ1jMN7GaG/mKjDYPwTWbmDw==
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
Subject: [PATCH v2 58/66] media: sun6i-csi: Detect the availability of the ISP
Date:   Sat,  5 Feb 2022 19:54:21 +0100
Message-Id: <20220205185429.2278860-59-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to detect whether the ISP is available and connected
and store the indication in a driver-wide variable.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index b8e925f6bc09..70b2a8b95b40 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -24,6 +24,35 @@
 #include "sun6i_csi_capture.h"
 #include "sun6i_csi_reg.h"
 
+/* ISP */
+
+static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
+{
+	struct device *dev = csi_dev->dev;
+	struct fwnode_handle *handle = NULL;
+
+	/* ISP is not available if disabled in kernel config. */
+	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
+		return 0;
+
+	/*
+	 * ISP is not available if not connected via fwnode graph.
+	 * This weill also check that the remote parent node is available.
+	 */
+	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
+						 SUN6I_CSI_PORT_ISP, 0,
+						 FWNODE_GRAPH_ENDPOINT_NEXT);
+	if (!handle)
+		return 0;
+
+	fwnode_handle_put(handle);
+
+	dev_info(dev, "ISP link is available\n");
+	csi_dev->isp_available = true;
+
+	return 0;
+}
+
 /* Media */
 
 static const struct media_device_ops sun6i_csi_media_ops = {
@@ -328,6 +357,10 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
 	if (ret)
 		return ret;
 
+	ret = sun6i_csi_isp_detect(csi_dev);
+	if (ret)
+		goto error_resources;
+
 	ret = sun6i_csi_v4l2_setup(csi_dev);
 	if (ret)
 		goto error_resources;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 3c08b2712215..6cdaf98dc295 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -22,6 +22,7 @@
 enum sun6i_csi_port {
 	SUN6I_CSI_PORT_PARALLEL		= 0,
 	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
+	SUN6I_CSI_PORT_ISP		= 2,
 };
 
 struct sun6i_csi_buffer {
@@ -47,6 +48,8 @@ struct sun6i_csi_device {
 	struct clk			*clk_mod;
 	struct clk			*clk_ram;
 	struct reset_control		*reset;
+
+	bool				isp_available;
 };
 
 /* V4L2 */
-- 
2.34.1

