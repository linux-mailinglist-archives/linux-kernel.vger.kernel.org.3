Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BCB4A9D68
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376769AbiBDRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiBDRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:07:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94487C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:07:49 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u24so14251754eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/+oTJIUco9iSDLcoK98xrLmbOde1duXTh41+KP2gLs=;
        b=AfKsYQsyJpMcrd1jqKkHQfjmdoeQafRrchHinCqr0c9erBvsf2GDYR1pr6cHx3Mqkz
         UWxL0AmYbdk7JFqLTXISWU9E9x7fd4tXv1eMj3ftrowCfuKTF2nlvDOaj0/3pskPkbj5
         0H740MDD8/NP0ahT4GIA5iRI1O33dlHbVfnrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/+oTJIUco9iSDLcoK98xrLmbOde1duXTh41+KP2gLs=;
        b=354x5NMI9nLaGKCmOPDIBqMhIhPooP5bie4jpG/gEkK/qSVJwXRSEyTdDukhhYdcba
         ykPnBoMcnVcNEPqGmvkVnHoaMpRWYPZPdM9r1hDLQ+SQYOaLl4MHoHWZjS2E9vEUsvK5
         eh0VY6Q37AljZGVe4nSt6tvB5N2TTOOXMhDwK/YudJWWGPFn9q8ivE32dRLsafulw+bM
         exlx8r5O3AnnPgcq3r1W5rKHHuTbSELCw72Stq+Lx0MX+Oe1ybCufqmbUhTI8OymoqGR
         qf+21o7ZwqQBO4/UT7VMWrZRZRQOcjQcLBzFW3MiATtHqYy88b5TpvqZoQZdLXJ1WM8b
         vNCg==
X-Gm-Message-State: AOAM533ClSPMH9ZiJgRByvakDwVIsuJ5GaQXgUN2LLEDcLeaaluXs+wQ
        bmEtCBjxi2iZu5zKkKbyDYBQhA==
X-Google-Smtp-Source: ABdhPJzwBr0blTu4ryIu1LuKzDcH0T/OUDJJV2uZRNwg0/JEQxxPTK344wpGd07o6Sy/UmoMUFGJ1g==
X-Received: by 2002:a50:9555:: with SMTP id v21mr72899eda.214.1643994468214;
        Fri, 04 Feb 2022 09:07:48 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id gv36sm840753ejc.94.2022.02.04.09.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:07:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 2/3] media: uvcvideo: Refactor streamon/streamoff
Date:   Fri,  4 Feb 2022 18:07:44 +0100
Message-Id: <20220204170745.1269482-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220204170745.1269482-1-ribalda@chromium.org>
References: <20220204170745.1269482-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variable to handle the streaming state and handle the
streamoff errors, that were not handled before.

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

