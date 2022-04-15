Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6613A502D07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355303AbiDOPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355562AbiDOPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:33:48 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B3D5E8C;
        Fri, 15 Apr 2022 08:29:11 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1C01BE0009;
        Fri, 15 Apr 2022 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJhdnVljXNxVEUMy4in6EAVIykPxuz30jn1QuT2PjaY=;
        b=Zk7yFys2c2BJ9az9iLbgPiy+++XOJFjJ9avanOahl/MwOs13EJRsry5ULsFMWtj0sFPkG3
        +X9FEp5q09ETZvrFJaR9tm7kh+Y1fkNjfdkfnvTKYVhhiiCCf3crFCA4lKRbkm6AgjWLJJ
        zNhciEKHvb1qr1qr74A1QNf97sTEHc39Q9XglU1hC1MSyCLlxod8WbOEfC/trL/AcFIKBy
        ptrTgc9JWO+r8m3gkqwrpyHx7oAfaSmxcnPi3lsGi5Uxxbe73vy3Y/9aohqC9QsYgl8MFj
        bPE7bE3/gTQx/Z2QXDRgkCRFbkSl+Cwmvc4edQmgBg5wUzKvV6hcA4BPdjnSOQ==
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
Subject: [PATCH v4 43/45] media: sun6i-csi: Detect the availability of the ISP
Date:   Fri, 15 Apr 2022 17:28:09 +0200
Message-Id: <20220415152811.636419-44-paul.kocialkowski@bootlin.com>
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

Add a helper to detect whether the ISP is available and connected
and store the indication in a driver-wide variable.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index a88deb8ba1e7..f185cbd113c7 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -25,6 +25,35 @@
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
@@ -306,6 +335,10 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
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
index 6aa83dd11684..9b105c341047 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -22,6 +22,7 @@
 enum sun6i_csi_port {
 	SUN6I_CSI_PORT_PARALLEL		= 0,
 	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
+	SUN6I_CSI_PORT_ISP		= 2,
 };
 
 struct sun6i_csi_buffer {
@@ -46,6 +47,8 @@ struct sun6i_csi_device {
 	struct clk			*clock_mod;
 	struct clk			*clock_ram;
 	struct reset_control		*reset;
+
+	bool				isp_available;
 };
 
 struct sun6i_csi_variant {
-- 
2.35.2

