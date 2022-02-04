Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF44A9D6E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376774AbiBDRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiBDRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:10:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BCBC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:10:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ka4so21238253ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfG7+eN0faSdt04jThM25jndsLCbneWwcnw4yLBWIqQ=;
        b=lvlF4tompMjGDck07Ya1IW8CblQ6XLlwXGuG1zjJNgB3sGDUMxrTF6Oo7qv5flpZYI
         WuMZGdoa6H6xpDrFDdlL6Rl+CBNE1FgrujNNGuSIDMIr5jddsf2jQdv1e2RqW0D7r5lk
         vlxib7CAHllmdJofWMo+mBj+MbbZN8Y32lQtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfG7+eN0faSdt04jThM25jndsLCbneWwcnw4yLBWIqQ=;
        b=evBloQNK6EoIcFIEuN/PLNaoOx32H8/O5QRkiyKdUqR40SMKBEkz1Uy2moXBxDc/YW
         WeUU+11vE7QvmPUuIDMUzYoYAN6IW53pczAojgwJut26NwsDq/BuceiMv0+798zFeYkI
         VtFWmtcY5HdPcart6/5p3tmki0DcIb1QDNP8ciTSmyeEfDYWZ1azxKrlckC7cIx/aCa1
         ZxwvXozR2Q4tY7lK6sZiBSzKMZfxFz6C93k3WuMB3EJb2O9wLNbwAU52Ft4ZJ7JIL4Sh
         8MFfCr0FCmccLOKwAuwSTQo0p5INI3/Dydfw8N4KpUaSqoSxgN/nzgN8WBn35pYtc0TL
         wyOw==
X-Gm-Message-State: AOAM533ezOq57b5l8SudsktSCCBxDh+YLY93n1k2YVwPmOttXQWLiyN3
        jMK5C3dFUOd/ziYlaZItHoEHXA==
X-Google-Smtp-Source: ABdhPJzA0w6RBfgDcLTUJ8fdt3wN0XtIOlUmzxaZ8b/P8uwqCjsetYjZc4w7r67y6M5R2ZHzNXV/PA==
X-Received: by 2002:a17:907:16a3:: with SMTP id hc35mr3550585ejc.299.1643994646560;
        Fri, 04 Feb 2022 09:10:46 -0800 (PST)
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
Subject: [PATCH v5 1/3] media: uvcvideo: Only create input devs if hw supports it
Date:   Fri,  4 Feb 2022 18:10:41 +0100
Message-Id: <20220204171043.1271215-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Examine the stream headers to figure out if the device has a button and
can be used as an input.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 753c8226db70..6149bfafd1cc 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -18,11 +18,34 @@
  * Input device
  */
 #ifdef CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV
+
+static bool uvc_input_has_button(struct uvc_device *dev)
+{
+	struct uvc_streaming *stream;
+
+	/*
+	 * The device has button events if both bTriggerSupport and
+	 * bTriggerUsage are one. Otherwise the camera button does not
+	 * exist or is handled automatically by the camera without host
+	 * driver or client application intervention.
+	 */
+	list_for_each_entry(stream, &dev->streams, list) {
+		if (stream->header.bTriggerSupport == 1 &&
+		    stream->header.bTriggerUsage == 1)
+			return true;
+	}
+
+	return false;
+}
+
 static int uvc_input_init(struct uvc_device *dev)
 {
 	struct input_dev *input;
 	int ret;
 
+	if (!uvc_input_has_button(dev))
+		return 0;
+
 	input = input_allocate_device();
 	if (input == NULL)
 		return -ENOMEM;
-- 
2.35.0.263.gb82422642f-goog

