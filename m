Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CAA4D63DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiCKOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349494AbiCKOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:24 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC551C8DB4;
        Fri, 11 Mar 2022 06:36:11 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7743224000C;
        Fri, 11 Mar 2022 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wd011+7n71DXlKsfbB1z3rKK7bmQJEGrr2p6llB6W8k=;
        b=DAjYoDALjWGJL7QzA0cMmjki6qsp7FM6jxM8xOoLJoGgKPEIYzbxqwBuiskn/Nsg/ZBJnz
        bj4yBH8jknjzA8NChH29aTfiL3tWvwsNne+UWgGpv6VTK1XH5QjR23eXojCqqCEpIqjdCs
        esHih6Vv4IBrvyHnvj3uCiPZpW3+nKJRJRalryy/MF4mDTnEtnZ3mucaAa8fKhYkgaRfxy
        tH6ip+oQeVDkmA7fNgbgpeaObPuvR8RsWaaARS/mgdXA2Kdsma2f67brqaDkzOP9WvdgkC
        wmcIBnBjuZKWCw2J8Wdov9DESiOaT8zNnEArvyzmtqKUqJvcdtj+IVIsX/uuhQ==
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
Subject: [PATCH v3 13/46] media: sun6i-csi: Add media ops with link notify callback
Date:   Fri, 11 Mar 2022 15:34:59 +0100
Message-Id: <20220311143532.265091-14-paul.kocialkowski@bootlin.com>
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

In order to keep the power use count fields balanced when link changes
happen between v4l2_pipeline_pm_get/set calls (in open/close),
the link_notify media operation callback needs to be registered.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 38e41e0c8a3c..c340dc5507f6 100644
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
2.35.1

