Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8493453641A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbiE0OcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344291AbiE0Obx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:31:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C8F3701C;
        Fri, 27 May 2022 07:31:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 027051F462A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653661910;
        bh=v/Qj9dkCpC1sNaB07KNbLhoqv0M/1payaJLdzsZJWFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSpzQTUD7GbDWhQ6P3w12aJJD7KjeJqgWVor4wHAMScUfmdnxTJZRp7EJnM2qo1nF
         wblXUcXOst5PNXkDovVWjntaxNFS22DhHU1G0BTGqnz/uWJ6hN5VhUCT7nEGaKkaTi
         X4SxlIW+LCyiDbpzdDQITZmMDTpk5makhhCfTv0Z9D4ZNdYy1eaiV1N/ilsyrI99LU
         1ify4NevfXs571caels53uzg/tcd1oQe81kgXY9QjwSnQrjk72S00q6qsQDzjyRof2
         +7Gs88cAukuBuCw1r2n4CY6pOBx3Jzyim03l+50KIZygOSMESZjzZxQlX2dlfdAOSm
         IY1tM2llGsvRA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v6 01/17] videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
Date:   Fri, 27 May 2022 16:31:18 +0200
Message-Id: <20220527143134.3360174-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Add a new flag that indicates that this control is a dynamically sized
array. Also document this flag.

Currently dynamically sized arrays are limited to one dimensional arrays,
but that might change in the future if there is a need for it.

The initial use-case of dynamic arrays are stateless codecs. A frame
can be divided in many slices, so you want to provide an array containing
slice information for each slice. Typically the number of slices is small,
but the standard allow for hundreds or thousands of slices. Dynamic arrays
are a good solution since sizing the array for the worst case would waste
substantial amounts of memory.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../userspace-api/media/v4l/vidioc-queryctrl.rst          | 8 ++++++++
 include/uapi/linux/videodev2.h                            | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
index 88f630252d98..a20dfa2a933b 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
@@ -625,6 +625,14 @@ See also the examples in :ref:`control`.
 	``V4L2_CTRL_FLAG_GRABBED`` flag when buffers are allocated or
 	streaming is in progress since most drivers do not support changing
 	the format in that case.
+    * - ``V4L2_CTRL_FLAG_DYNAMIC_ARRAY``
+      - 0x0800
+      - This control is a dynamically sized 1-dimensional array. It
+        behaves the same as a regular array, except that the number
+	of elements as reported by the ``elems`` field is between 1 and
+	``dims[0]``. So setting the control with a differently sized
+	array will change the ``elems`` field when the control is
+	queried afterwards.
 
 Return Value
 ============
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5311ac4fde35..9018aa984db3 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1890,6 +1890,7 @@ struct v4l2_querymenu {
 #define V4L2_CTRL_FLAG_HAS_PAYLOAD	0x0100
 #define V4L2_CTRL_FLAG_EXECUTE_ON_WRITE	0x0200
 #define V4L2_CTRL_FLAG_MODIFY_LAYOUT	0x0400
+#define V4L2_CTRL_FLAG_DYNAMIC_ARRAY	0x0800
 
 /*  Query flags, to be ORed with the control ID */
 #define V4L2_CTRL_FLAG_NEXT_CTRL	0x80000000
-- 
2.32.0

