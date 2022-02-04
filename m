Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330D34A9D71
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376794AbiBDRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbiBDRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:10:48 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7972C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:10:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id s13so21373435ejy.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70aba+gXbkqdI4Od7Xpu39VsQQbTbunqa4tpFaQFQGU=;
        b=drCQJCor2IUi+p1j6BTCiIEjEdXQKPi8mTKHS63CswoGKeJlxFwpB91jTLQec3uko7
         dd2BDHhgL5kqAo8DpcznfxAMnhWdxzMiHx5UTcVdDVoBhln4spp3Zc+5BaGDuwzYpS3U
         Ik16OgwOTIz6rcFEZ9xi03L52JAZZoZ/YYHEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70aba+gXbkqdI4Od7Xpu39VsQQbTbunqa4tpFaQFQGU=;
        b=8FetZ3N4duH+xlIklTigGZChj3RvzSZ3/k0DwUp8yP2RfrDwMBln0WwI1gQODtSgVO
         c208XqswDLjvgenkIpYChOOlgSICw99uLVqO6BAnTrdI1H5oxS9Yno20CMdKkBAm185R
         lsezShQ9oqz/ufm9nBzoLG/ap7t7nTgsGwtFAe86feYIWEIDc+/UG6qqiI+atCByaxVF
         qQanXPtHRiqeU/mjQYdYjSvr/pc3nMqm2Tqg+goAcjWSGZbzDxT2semNha9P/F2siLui
         vGVeXdFbNOxnRvybBBcQS6XKusxYj59wGitz2wZ+jKxCCGyYvPSt9is7U0dk3ab+x6IU
         49FQ==
X-Gm-Message-State: AOAM533BcUsIxtKClWAgEtVKBruftqlugcWFOQijQ1cNPOxdOeKb77bC
        zAhC89Ir9RxH9ZL6s7IjfOh7Eg==
X-Google-Smtp-Source: ABdhPJz8vb1BGRteKCtBbiia2AnaM/q1FpGdGeRO3fYSwScIKqy76kw10sdZeeQ8mG5Yu8a+v4hUrQ==
X-Received: by 2002:a17:907:2d1e:: with SMTP id gs30mr3329232ejc.14.1643994647207;
        Fri, 04 Feb 2022 09:10:47 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id bf21sm1103800edb.2.2022.02.04.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:10:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 2/3] media: uvcvideo: Refactor streamon/streamoff
Date:   Fri,  4 Feb 2022 18:10:42 +0100
Message-Id: <20220204171043.1271215-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220204171043.1271215-1-ribalda@chromium.org>
References: <20220204171043.1271215-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variable to handle the streaming state and handle the
streamoff errors, that were not handled before.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 19 ++++++++++++++++---
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 711556d13d03..ae1f221b2a5d 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -836,13 +836,19 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_streaming *stream = handle->stream;
-	int ret;
+	int ret = -EBUSY;
 
 	if (!uvc_has_privileges(handle))
 		return -EBUSY;
 
 	mutex_lock(&stream->mutex);
+
+	if (handle->is_streaming)
+		goto unlock;
 	ret = uvc_queue_streamon(&stream->queue, type);
+	handle->is_streaming = !ret;
+
+unlock:
 	mutex_unlock(&stream->mutex);
 
 	return ret;
@@ -853,15 +859,22 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_streaming *stream = handle->stream;
+	int ret = 0;
 
 	if (!uvc_has_privileges(handle))
 		return -EBUSY;
 
 	mutex_lock(&stream->mutex);
-	uvc_queue_streamoff(&stream->queue, type);
+
+	if (!handle->is_streaming)
+		goto unlock;
+	ret = uvc_queue_streamoff(&stream->queue, type);
+	handle->is_streaming = !!ret;
+
+unlock:
 	mutex_unlock(&stream->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int uvc_ioctl_enum_input(struct file *file, void *fh,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 143230b3275b..5958b2a54dab 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -720,6 +720,7 @@ enum uvc_handle_state {
 
 struct uvc_fh {
 	struct v4l2_fh vfh;
+	bool is_streaming;
 	struct uvc_video_chain *chain;
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
-- 
2.35.0.263.gb82422642f-goog

