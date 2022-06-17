Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7007C55010B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiFQX4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382748AbiFQX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDFA61627
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gl15so11362274ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5NDpsm7942F8ZAmDt1/U3OvWgy4XsdEFDVSVEbFO9s=;
        b=nVc1TlGRzm+6zidFMBS9tzR7dsyWC9GpBonuqwNbiK1F8F0kYLpp++P6ranijiHZl6
         z812PWhsI0Wgc3cdj7Ye2gLpye5PLOEQWMOWkNvpwc72n/wflQVNpgFJhswrm7QL/wc5
         +56RwvzIfBf2LUgOv8PqSdkytqoJQXHO7yo5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5NDpsm7942F8ZAmDt1/U3OvWgy4XsdEFDVSVEbFO9s=;
        b=nBmxbyOunNga1S98NBaIFMABdFPL8DxINV0/QxUHqN3e4VWnibjYDcUAE62e4jh5Vh
         1apQEaMSQp+k7R45Zi7r+dzBTKboBhHfzWDhyAKar3l9wHflmGjhq/+j29M+7WCw9FS1
         Rlmd+smC64HShsNWgRBN+tqiyJXbjoPsoNTmRtO784bKtX5WkEQxbOmXhVVJshuOOYGV
         Pa/XAkgHLqO3b7+o4SYrFhTPxZL6l/YB7CniXCiTggJEIF/W0OruJ4Zjhi3bXE5zBYOD
         622XcAKw/E9PsSD2HUshdHR5w5Jn0WVFW+CtrsjeKSAMTcZTgnoDWaJFAQan0IfD3QPl
         S8rg==
X-Gm-Message-State: AJIora8pwPOPRYzUVWDnhSG1pANyWjfzynPkt9dhSL3RpBy4ukhDyxwb
        a7Nc9jz92/Ln8IfbxlILPoS6NA==
X-Google-Smtp-Source: AGRyM1sjg2BOhrpcR/L31d1agtFPImts7SKC/0t9bER+Rl1EmJAIC4owlQjbMXcYeutidfMIL+I7vA==
X-Received: by 2002:a17:906:c041:b0:718:c984:d9ee with SMTP id bm1-20020a170906c04100b00718c984d9eemr12078098ejb.722.1655510176399;
        Fri, 17 Jun 2022 16:56:16 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:16 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 5/9] media: uvcvideo: Limit power line control for Quanta UVC Webcam
Date:   Sat, 18 Jun 2022 01:56:06 +0200
Message-Id: <20220617235610.321917-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220617235610.321917-1-ribalda@chromium.org>
References: <20220617235610.321917-1-ribalda@chromium.org>
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
 drivers/media/usb/uvc/uvc_driver.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 6c86faecbea2..ea8f0bb7a20c 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2643,6 +2643,24 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_mask	= 0x6,
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
@@ -2673,6 +2691,15 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
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
2.37.0.rc0.104.g0611611a94-goog

