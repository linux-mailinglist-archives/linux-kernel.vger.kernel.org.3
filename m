Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0554A9D67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376764AbiBDRHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBDRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:07:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B8C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:07:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m4so21333499ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSQO/B2pXj/5Se04MXFeD+50vb9mnHw6bljwLcxZ4y0=;
        b=mL7qqRokkKO2UqVoOFAn4R3/KpvyVLNXqVNxNtzD5FavNZpaxr4aZekK3NIJkrwAYJ
         G4clsh0IPACaf4HA3DiVUnfeD7yg1G13FrlONnfPX5pHMpFnEUtWmrZLlB+IZIb+LNIH
         Ewkzadrza5bwAqwP5IumX2G0j87aSw6YcyQpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSQO/B2pXj/5Se04MXFeD+50vb9mnHw6bljwLcxZ4y0=;
        b=fRPrEGGBcD/WbdxQe9i2zLh0hCLM3oF13WJllJM0y8Y4hpEIN3k+dgbc1lvB1V8ZBM
         lE7sb9kJD6/jwBwS7aHfTSYhx51AgNFGSza4jUGxJWirxYy2lWIGn2L+xEzmGB1url6W
         kmzq9SBbdxp5RxEDE5MekI24G6iAEs7lCyTUlBXtFQIs8QOv1lbKIOXcD2RJW+bn0Ixr
         QxvxkGw2/bLMKwSAzXzx6YRTyaJqCQsNubebznloJ8nT+1pEL4kwtXDZLQKlLhsrt/bp
         Z0ts0JbdYOJUiG7QOgihNBP0oyLbjhMSq1Qlnrat7jAc7f8LJO5y3DNL/pnArstTMcT4
         ZMCg==
X-Gm-Message-State: AOAM5316qQCiSOAG5aqQcQR8m0YtHNZvxgRghQTpLgkME+4IQG3nW5p2
        ui69OhE1uMK7V3ESN3ei4fQRyQ==
X-Google-Smtp-Source: ABdhPJx1oepq/dn2zEkY1XQ96XNmLR9bQMAUh5i2QBt0soxm9hrLmpsHQ6txZIKaHylBQQsFZWCGhg==
X-Received: by 2002:a17:907:1c8a:: with SMTP id nb10mr3369595ejc.273.1643994467545;
        Fri, 04 Feb 2022 09:07:47 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id gv36sm840753ejc.94.2022.02.04.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:07:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 1/3] media: uvcvideo: Only create input devs if hw supports it
Date:   Fri,  4 Feb 2022 18:07:43 +0100
Message-Id: <20220204170745.1269482-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Examine the stream headers to figure out if the device has a button and
can be used as an input.

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

