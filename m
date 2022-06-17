Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B654F596
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381913AbiFQKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381839AbiFQKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:36:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581116AA7B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:36:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c13so1160574eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxHwUwUuK5U+dFx9/GDrIMCnRWc/PWyIrdKraztqqMs=;
        b=bKrBV0/MEMx50ydlkzLOhOZunA8jo2paFP4Qv58Yu6d+6ueqXJfA68/niCBEVCCGrd
         IdSiLARFSCEAevzaqhFBFtNGAOT/OLIkt89wIT8yVvb19YiVkCDkPz+KgdY/pBCQMspz
         uXE+mrhhkpz9kLTAqfmYVZ/c7UUyl2jzqRWF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxHwUwUuK5U+dFx9/GDrIMCnRWc/PWyIrdKraztqqMs=;
        b=GWJNpnqUAefhPSRqSr1/lA7mkFoNMMtHd/Z6U844wpq25/nh2+EIZqyQTnRhrMiUOH
         +X/Oms8NlQPP2ZXYNnekxy9SUlAdJ7r5v4hEfD/j0yPq9jrUohC1xqJ4MKSjNR2WaaYv
         c83kfaCwgbv6SJtDkqUZJ2M/CLk2s8XD+b2vykuzqfh7lIAePd7AU/EA+48qEr5pMyDD
         C2GNeCQmCIbGb8mX6UZfpdgN/mYYZAaIAFLWsVKPcfDeZY1i2vQQ9qKpC4b2z1tFZmYo
         5c2WfcybwPbtgclzsgTvzqzNEdH4J7/+aJ1z1yj4yLdiEGIzirSeLUuSJ6/TnvVrjOIj
         YNwQ==
X-Gm-Message-State: AJIora/LC2aS0eQQb+u3Bo66BJwkXMT5UVfDkqCZQCfRiu+hi25qlQFY
        9W2wo26PXnjwYUn+i7efZEqCbQ==
X-Google-Smtp-Source: AGRyM1vbuV+JVTS15R79q5HUioNrVZfLZIK8XcOZSNVC+11xTLsFFl6xjlAn2w3q/w9ptbvbeKrUTg==
X-Received: by 2002:a05:6402:4490:b0:435:640c:2abb with SMTP id er16-20020a056402449000b00435640c2abbmr1985034edb.301.1655462214730;
        Fri, 17 Jun 2022 03:36:54 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:a86e:90:fb4:466e])
        by smtp.gmail.com with ESMTPSA id z19-20020a056402275300b004319b12371asm3704340edd.47.2022.06.17.03.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:36:54 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 4/8] media: uvcvideo: Limit power line control for Quanta UVC Webcam
Date:   Fri, 17 Jun 2022 12:36:41 +0200
Message-Id: <20220617103645.71560-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220617103645.71560-1-ribalda@chromium.org>
References: <20220617103645.71560-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not implement the power line control correctly. Add a
corresponding control mapping override.

Bus 001 Device 003: ID 0408:3090 Quanta Computer, Inc. USB2.0 HD UVC WebCam
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x0408 Quanta Computer, Inc.
  idProduct          0x3090
  bcdDevice            0.04
  iManufacturer           3 Quanta
  iProduct                1 USB2.0 HD UVC WebCam
  iSerial                 2 0x0001
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 6c86faecbea2..4fb07084f1c0 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2643,6 +2643,32 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
+static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
+	{ 0, "Invalid" },
+	{ 1, "50 Hz" },
+	{ 2, "60 Hz" },
+};
+
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls_limited,
+	.menu_min	= 1,
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
+};
+
+static const struct uvc_device_info uvc_ctrl_power_line_limited = {
+	.mappings = (const struct uvc_control_mapping *[]) {
+		&uvc_ctrl_power_line_mapping_limited,
+		NULL, /* Sentinel */
+	},
+};
+
 static const struct uvc_device_info uvc_quirk_probe_minmax = {
 	.quirks = UVC_QUIRK_PROBE_MINMAX,
 };
@@ -2673,6 +2699,15 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
  * though they are compliant.
  */
 static const struct usb_device_id uvc_ids[] = {
+	/* Quanta USB2.0 HD UVC Webcam */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x0408,
+	  .idProduct		= 0x3090,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* LogiLink Wireless Webcam */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.36.1.476.g0c4daa206d-goog

