Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D804D63E5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349731AbiCKOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349662AbiCKOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:38:16 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F51C9B54;
        Fri, 11 Mar 2022 06:36:59 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E1903240007;
        Fri, 11 Mar 2022 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDmhoLPQge3kG9Ojz9okiMcdcrF7ESNnFjv2vshc9E8=;
        b=CkMzxPXpS0SWFrfc4VdTua2320ouiDSqKn/9yyYp6rGxR7K0hB/pMeRX7rdXv1BAevuoos
        oWRRaT9ddbaafbH5auuO1jplMG+OmZBdVTkd82bR0hyM0+VbLJUKAxK8kOBuOfvseEmQOf
        W2LJwZ5Wchg2hId7VjvL2w1UQZYQ1n1H61ZAs3dsLLwio2GZWX6tk7grSc0vpptjUgR3LA
        21pW3BexthWMrW3JlgGSBfvhbdXzCU0k76JF07QJgnFpOADVmRfR2+rs1k+FvbwtPPVcSu
        kKfGt6upmoe/AIC4PQeLN6szH33+4MqVuTzUWtjvzB3IjwphJb3DOhr8J6LYNQ==
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
Subject: [PATCH v3 44/46] media: sun6i-csi: Detect the availability of the ISP
Date:   Fri, 11 Mar 2022 15:35:30 +0100
Message-Id: <20220311143532.265091-45-paul.kocialkowski@bootlin.com>
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

Add a helper to detect whether the ISP is available and connected
and store the indication in a driver-wide variable.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 794ac53dcd30..f17be8e091a9 100644
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
@@ -323,6 +352,10 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
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
index e3c1150d99f5..ee5b04f75311 100644
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
 
 struct sun6i_csi_variant {
-- 
2.35.1

