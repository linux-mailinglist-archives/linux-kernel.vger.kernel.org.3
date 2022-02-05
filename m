Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74F4AABA8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381736AbiBES47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:56:59 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52993 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381385AbiBESzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:31 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4A28240007;
        Sat,  5 Feb 2022 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9Du3GfYn3UOCDAPoYJILY6rh/Nnu6H6h0CX6Ze373Y=;
        b=IURtoySrYYi5eK3hSwO5N8qOIcyNqY4Cy9o1fdR/WiyFPmgHCLyFq8wKoxTKhGL6xsANsx
        xm1cbTBTPPQ6TXxGGaNrisAfka3YZIWme38mrdOqEcHmORcvVR602flt13CeUP+E6ncOTU
        ji5B6sD87d7B0xCq6ZGXVmVfJatT1cbVioyO4T5H/cF8/m+xrQVnGzpl3uHd+uculImZ8c
        f8OMnokOVHCeWE9k3ivHHTO0Xy1Ga42ZNdj7XXSAt44wSnOWzVX7RJohKDRdvrgWtabjIU
        YyZSMIlFT/91uMfBZMUtDDCY2GvcrqwbnwEF8257hD+CgINU6+eVuGTw+SrHVQ==
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
Subject: [PATCH v2 27/66] media: sun6i-csi: Add media ops with link notify callback
Date:   Sat,  5 Feb 2022 19:53:50 +0100
Message-Id: <20220205185429.2278860-28-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep the power use count fields balanced when link changes
happen between v4l2_pipeline_pm_get/set calls (in open/close),
the link_notify media operation callback needs to be registered.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 6f04f86504bf..c8fe31cc38b5 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -23,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <media/v4l2-mc.h>
 
 #include "sun6i_csi.h"
 #include "sun6i_csi_reg.h"
@@ -574,6 +575,12 @@ void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
 			   CSI_CAP_CH0_VCAP_ON);
 }
 
+/* Media */
+
+static const struct media_device_ops sun6i_csi_media_ops = {
+	.link_notify = v4l2_pipeline_link_notify,
+};
+
 /* V4L2 */
 
 static int sun6i_csi_link_entity(struct sun6i_csi_device *csi_dev,
@@ -683,6 +690,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 	snprintf(media_dev->bus_info, sizeof(media_dev->bus_info),
 		 "platform:%s", dev_name(dev));
 	media_dev->hw_revision = 0;
+	media_dev->ops = &sun6i_csi_media_ops;
 	media_dev->dev = dev;
 
 	media_device_init(media_dev);
-- 
2.34.1

