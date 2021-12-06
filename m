Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08412468E47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbhLFA07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:26:59 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:33005 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLFA07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:26:59 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1B5NvL4l019924;
        Mon, 6 Dec 2021 07:57:21 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Dec
 2021 08:22:11 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <hverkuil-cisco@xs4all.nl>, <sakari.ailus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <laurent.pinchart@ideasonboard.com>,
        <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: aspeed: move err-handling together to the bottom
Date:   Mon, 6 Dec 2021 08:22:09 +0800
Message-ID: <20211206002209.412-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1B5NvL4l019924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refine aspeed_video_setup_video() flow.

Change-Id: Icc7bcec800d5a9d478ead1b283fdb3aa15a86b80
Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index fea5e4d0927e..f5c40d6b4ece 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1641,11 +1641,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
 
 	rc = video->ctrl_handler.error;
 	if (rc) {
-		v4l2_ctrl_handler_free(&video->ctrl_handler);
-		v4l2_device_unregister(v4l2_dev);
-
 		dev_err(video->dev, "Failed to init controls: %d\n", rc);
-		return rc;
+		goto err_ctrl_init;
 	}
 
 	v4l2_dev->ctrl_handler = &video->ctrl_handler;
@@ -1663,11 +1660,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
 
 	rc = vb2_queue_init(vbq);
 	if (rc) {
-		v4l2_ctrl_handler_free(&video->ctrl_handler);
-		v4l2_device_unregister(v4l2_dev);
-
 		dev_err(video->dev, "Failed to init vb2 queue\n");
-		return rc;
+		goto err_vb2_init;
 	}
 
 	vdev->queue = vbq;
@@ -1685,15 +1679,19 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
 	video_set_drvdata(vdev, video);
 	rc = video_register_device(vdev, VFL_TYPE_GRABBER, 0);
 	if (rc) {
-		vb2_queue_release(vbq);
-		v4l2_ctrl_handler_free(&video->ctrl_handler);
-		v4l2_device_unregister(v4l2_dev);
-
 		dev_err(video->dev, "Failed to register video device\n");
-		return rc;
+		goto err_video_reg;
 	}
 
 	return 0;
+
+err_video_reg:
+	vb2_queue_release(vbq);
+err_vb2_init:
+err_ctrl_init:
+	v4l2_ctrl_handler_free(&video->ctrl_handler);
+	v4l2_device_unregister(v4l2_dev);
+	return rc;
 }
 
 static int aspeed_video_init(struct aspeed_video *video)
-- 
2.25.1

