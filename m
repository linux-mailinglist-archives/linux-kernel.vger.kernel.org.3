Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E252DC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbiESSCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243513AbiESSB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:01:59 -0400
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599685BE45;
        Thu, 19 May 2022 11:01:56 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id E7EE63C00BA;
        Thu, 19 May 2022 20:01:54 +0200 (CEST)
Received: from vmlxhi-121.localdomain (10.72.92.132) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 19 May
 2022 20:01:54 +0200
From:   Michael Rodin <mrodin@de.adit-jv.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
CC:     Michael Rodin <mrodin@de.adit-jv.com>, <michael@rodin.online>,
        <erosca@de.adit-jv.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/3] media: videobuf2: Add a transfer error event
Date:   Thu, 19 May 2022 20:00:07 +0200
Message-ID: <1652983210-1194-2-git-send-email-mrodin@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652983210-1194-1-git-send-email-mrodin@de.adit-jv.com>
References: <1652983210-1194-1-git-send-email-mrodin@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.72.92.132]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Add a new V4L2_EVENT_XFER_ERROR event to signal if a unrecoverable error
happens during video transfer.

The use-case that sparked this new event is to signal to the video
device driver that an error has happen on the CSI-2 bus from the CSI-2
receiver subdevice.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[mrodin@de.adit-jv.com: added information what to do if this new event is received]
Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
---
 Documentation/userspace-api/media/v4l/vidioc-dqevent.rst     | 9 +++++++++
 Documentation/userspace-api/media/videodev2.h.rst.exceptions | 1 +
 include/uapi/linux/videodev2.h                               | 1 +
 3 files changed, 11 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
index 6eb4007..ed0a5ff 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
@@ -182,6 +182,15 @@ call.
 	the regions changes. This event has a struct
 	:c:type:`v4l2_event_motion_det`
 	associated with it.
+    * - ``V4L2_EVENT_XFER_ERROR``
+      - 7
+      - This event is triggered when an transfer error is detected while
+	streaming. For example if a unrecoverable error is detected on a video
+	bus in the pipeline. If a driver receives this event from an upstream
+	subdevice, it has to check if it is affected by this error and then try
+	to recover from this error. If an internal recovery is not possible,
+	then it can forward the event to userspace so the streaming application
+	has to restart streaming if it wants to continue.
     * - ``V4L2_EVENT_PRIVATE_START``
       - 0x08000000
       - Base event number for driver-private events.
diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
index 9cbb7a0..25bde61 100644
--- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
+++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
@@ -500,6 +500,7 @@ replace define V4L2_EVENT_CTRL event-type
 replace define V4L2_EVENT_FRAME_SYNC event-type
 replace define V4L2_EVENT_SOURCE_CHANGE event-type
 replace define V4L2_EVENT_MOTION_DET event-type
+replace define V4L2_EVENT_XFER_ERROR event-type
 replace define V4L2_EVENT_PRIVATE_START event-type
 
 replace define V4L2_EVENT_CTRL_CH_VALUE ctrl-changes-flags
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 6d465dc..8c75bd8 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2383,6 +2383,7 @@ struct v4l2_streamparm {
 #define V4L2_EVENT_FRAME_SYNC			4
 #define V4L2_EVENT_SOURCE_CHANGE		5
 #define V4L2_EVENT_MOTION_DET			6
+#define V4L2_EVENT_XFER_ERROR			7
 #define V4L2_EVENT_PRIVATE_START		0x08000000
 
 /* Payload for V4L2_EVENT_VSYNC */
-- 
2.7.4

