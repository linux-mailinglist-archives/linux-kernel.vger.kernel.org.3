Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97646AF45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378506AbhLGAmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378515AbhLGAmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:42:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98671C061A83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:38:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so49860897edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+GbyHSIhzCM5dXMMI+btg2trszjytK9bBAgvB5NDbo=;
        b=G8y8ID3GInMgoefRzbFPEIV4DJyqhuZT6eqVKtEucJQSUl3UI9x1qf9WchG76iMvQl
         bwIlO7CoPTIirxYCkeMLfaEN7sDC8xVkhtk3YzldUUUiBaxX/KR8pbUA05XORFuhtK0C
         47exNw4jGi91VX2B9bkMU41qWfaMHDFzeYVzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+GbyHSIhzCM5dXMMI+btg2trszjytK9bBAgvB5NDbo=;
        b=kqyYfhRsKZI9hgelfl6BYMDKHoNYUiyOrH121nyFEzhTmHx4DX6lNVFo9PmLdKxUlv
         KCpi+Zm/wXV//fjcWFTJ2/8WHaZZwGqzjSq1/dB0ub0UStIPm0GxpzfAPDXY149h/GNc
         RDGhS7JKG4DzctIQFFYcmEG1vDFLe0WV1/RsQ2MnM/3AlBpkxYKUfCV2nMzc2A59UXUf
         8nKx8Yyf7bOvL1tf1PooLR7t+lhDJ8jWky/s2qJHzhhSkrzPJz5QtVwbI0P0rYiY6pz+
         jmCQzIL8xKTgQor8rsy4fPxOB6ICyDiDXDN1F3XoLRBKBrueBx4oOy38O1FL3fTXptt6
         HcmQ==
X-Gm-Message-State: AOAM531qgmeJjSZZvOengaxDZE14SwwBJeLRmk1oqViv1Inatx3mxSi4
        3E5ridGO4KUFYH8FrIL/h3mtMw==
X-Google-Smtp-Source: ABdhPJxGI6WlldB0T0QMAva0rdGCbbvhtXidl4JEEDpue9hG48h2JzB2JyNWoqJq9UZ+Gqrd64y5NQ==
X-Received: by 2002:a17:907:6e8e:: with SMTP id sh14mr48470300ejc.536.1638837524183;
        Mon, 06 Dec 2021 16:38:44 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hg19sm7422531ejc.1.2021.12.06.16.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:38:43 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 4/4] media: uvcvideo: Set unique entity name based in type
Date:   Tue,  7 Dec 2021 01:38:40 +0100
Message-Id: <20211207003840.1212374-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211207003840.1212374-1-ribalda@chromium.org>
References: <20211207003840.1212374-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the entities must have a unique name. We can have a descriptive and
unique name by appending the function to their terminal link.

This is even resilient to multi chain devices.

Fixes v4l2-compliance:
Media Controller ioctls:
     fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
   test MEDIA_IOC_G_TOPOLOGY: FAIL
     fail: v4l2-test-media.cpp(394): num_data_links != num_links
   test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 058d28a0344b..8efbde981480 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2193,6 +2193,7 @@ int uvc_register_video_device(struct uvc_device *dev,
 			      const struct v4l2_file_operations *fops,
 			      const struct v4l2_ioctl_ops *ioctl_ops)
 {
+	const char __maybe_unused *name;
 	int ret;
 
 	/* Initialize the video buffers queue. */
@@ -2221,17 +2222,29 @@ int uvc_register_video_device(struct uvc_device *dev,
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	default:
 		vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+		name = "Video Capture";
 		break;
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
 		vdev->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
+		name = "Video Output";
 		break;
 	case V4L2_BUF_TYPE_META_CAPTURE:
 		vdev->device_caps = V4L2_CAP_META_CAPTURE | V4L2_CAP_STREAMING;
+		name = "Metadata";
 		break;
 	}
 
+	/*
+	 * Many userspace applications identify the device with vdev->name, so
+	 * we cannot change its name for its function.
+	 */
 	strscpy(vdev->name, dev->name, sizeof(vdev->name));
 
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	vdev->entity.name = devm_kasprintf(&stream->intf->dev, GFP_KERNEL,
+				"%s %u", name, stream->header.bTerminalLink);
+#endif
+
 	/*
 	 * Set the driver data before calling video_register_device, otherwise
 	 * the file open() handler might race us.
-- 
2.34.1.400.ga245620fadb-goog

