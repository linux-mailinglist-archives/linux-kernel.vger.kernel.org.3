Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BE0502CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355310AbiDOPbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355180AbiDOPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:31:19 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E03D4474;
        Fri, 15 Apr 2022 08:28:34 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 66497E000D;
        Fri, 15 Apr 2022 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7KuNEhxQ7zZ4XXrUpnB6gfWTPypBR8BHM6o/MGYzXM=;
        b=O30wxWs6YWbhqcc8noqeF5nhE6DP0dvJeopLFeOuyB8r36l+jOrUkEVy2uXlhhggIlqTWR
        EvTr6nLTNBYEaZMToSQGctR1sC/JKRYSCGBpVgbniTu1bBtD009SepHboQyiGHX2gpsq63
        TFf9AvGPQs9oN7FX5g2s6/CqszVx7BOkqUxSP2w0dvwyFvEXr9rQcUtZVnXBsRQpdpza4K
        a5mkl6oYklchj1tAwe1Dt6Sl54A9VLSasYDzNzzXOcO1G3IZqfEkBZ+AkyIfbwsBZa0pp9
        vlK7CupaSHIKAo8uuDwlBQ3u3kTbEhXqphgES1kvPfvOitIgHnVcK3m0jz62yg==
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
Subject: [PATCH v4 12/45] media: sun6i-csi: Add media ops with link notify callback
Date:   Fri, 15 Apr 2022 17:27:38 +0200
Message-Id: <20220415152811.636419-13-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
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

In order to keep the power use count fields balanced when link changes
happen between v4l2_pipeline_pm_get/set calls (in open/close),
the link_notify media operation callback needs to be registered.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index e59ee3e3f372..578714606c2f 100644
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
2.35.2

