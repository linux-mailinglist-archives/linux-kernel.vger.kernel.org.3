Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5BD4B434D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbiBNIJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:09:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbiBNIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:09:49 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3C95F8E6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:09:41 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 21E81BqX064667;
        Mon, 14 Feb 2022 16:01:11 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 16:09:38 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] media: aspeed: Use of_device_get_match_data() helper
Date:   Mon, 14 Feb 2022 16:09:09 +0800
Message-ID: <20220214080909.2792-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 21E81BqX064667
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2:
  - Add a check for null pointer for of_device_get_match_data
---
 drivers/media/platform/aspeed-video.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 3904ded2052a..91ec7eec1e6e 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
@@ -2451,7 +2452,6 @@ MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
 static int aspeed_video_probe(struct platform_device *pdev)
 {
 	const struct aspeed_video_config *config;
-	const struct of_device_id *match;
 	struct aspeed_video *video;
 	int rc;
 
@@ -2463,11 +2463,10 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	if (IS_ERR(video->base))
 		return PTR_ERR(video->base);
 
-	match = of_match_node(aspeed_video_of_match, pdev->dev.of_node);
-	if (!match)
-		return -EINVAL;
+	config = of_device_get_match_data(&pdev->dev);
+	if (!config)
+		return -ENODEV;
 
-	config = match->data;
 	video->version = config->version;
 	video->jpeg_mode = config->jpeg_mode;
 	video->comp_size_read = config->comp_size_read;
-- 
2.25.1

