Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E05A2EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiHZSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344205AbiHZSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:36 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A09E3C03;
        Fri, 26 Aug 2022 11:33:23 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 36BD0FF809;
        Fri, 26 Aug 2022 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OgLbVt95IswN57OD3YbDIdTcpan29K7wlu0knN7p7nY=;
        b=LRlT4AXWb0ovaSKo4ELb2Pfw8HkFLh8sjBPS1gwwZyhXoSptFrJ/Nx92YmBHyVJSAUN/8b
        lnHlZ9jP70rblinW37OSYOJDNKcuXShGcvbc/P54gx1zWKm4KMEdDH6ZVOHvG3Bis0+py0
        OgHHA2Nf5H4RluGw5gW5OrURfNLlUWAK83HgxIv/JLQjzWWZ7ynzHNcTmORAIbMpsDhGvx
        woOtqk5V837OzB+iCdDkqugiQRLbGzfQmlP2kPXX+GVAFQlnguod2gkkwjWDgVkULACxsd
        OY6y/tlM/5SyFizzw1yQn106Lk7p4QuaAQWxjXap9LM8O67FEk7o0W8l1A2WEg==
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
Subject: [PATCH v6 13/43] media: sun6i-csi: Add media ops with link notify callback
Date:   Fri, 26 Aug 2022 20:32:10 +0200
Message-Id: <20220826183240.604834-14-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep the power use count fields balanced when link changes
happen between v4l2_pipeline_pm_get/set calls (in open/close),
the link_notify media operation callback needs to be registered.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index d74eaa3132d6..8b99c17e8403 100644
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
@@ -681,6 +688,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 	strscpy(media_dev->model, SUN6I_CSI_DESCRIPTION,
 		sizeof(media_dev->model));
 	media_dev->hw_revision = 0;
+	media_dev->ops = &sun6i_csi_media_ops;
 	media_dev->dev = dev;
 
 	media_device_init(media_dev);
-- 
2.37.1

