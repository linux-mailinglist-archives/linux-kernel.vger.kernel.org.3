Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80E550108
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiFQX4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383023AbiFQX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD3462CE6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id es26so6348599edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jnwN8/6Kw9QXkQJc/fBYupKgOyKif9IBYZXUyF1l04=;
        b=LaHFGJ+vmI7vv9p7PqJtdxNqnbBKiL9mPRLDO8EhOI0iQb4IxPUSAwaflGgrMLqZuB
         4zxG26tGBO/+MCqzmKBkXVqDw5lmgsRbF2KQbmmSOmCpSMT/2Lliq3MwwUlNE6OoGO9A
         ov/dWDMTltr38aasOErN1b1gGrvXNhm93rDLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jnwN8/6Kw9QXkQJc/fBYupKgOyKif9IBYZXUyF1l04=;
        b=j3lXGEVKdc/TF/8+12NLvmxyLGk4B7XB9mPDc/L7U+Nu1/b+FHqkX3+7MylOOkM5Mu
         HY9nXjia+wrTbx8pMe6mT6oUdoU5EbmNJVyxL6/Q6TPkD3xVGbFuvJ7wJRmZ4wJdnkus
         aIWI+/hrMsgM+CDdPqh/Po6FqvJbsNJd+ZqPVoxdhslYDdbLfXyFstWcYVO2+9utAgc3
         iBk1h9t679bg8ilb4ZpIJj4YQ4nWATyD+MsxsTNJjqyo0f5k7rXnFF2UJE8D9Na5o/kZ
         wKAvlfyNBvqfC06pajZEhTIKF//fn947zfmvfyRsDIED9SZHJfLBd/M6OeU9o5Pw8ns3
         7pxw==
X-Gm-Message-State: AJIora+i2OYUvSoz1iKhaw6TYYzLPiIv6OfCv7Wlc6sN/WE+iruhFuT9
        E3M81dGBe0DFOpC1VLE7jmSUwecLOX4wdmNK
X-Google-Smtp-Source: AGRyM1t/2FyFec2b3mG0O30RSB+BxB3GsPTeg3wEUIRsx8xxj7AhhzUhk7WcsvxUSz4DDhdSSDnThA==
X-Received: by 2002:a05:6402:b8c:b0:435:6d4b:37e4 with SMTP id cf12-20020a0564020b8c00b004356d4b37e4mr1124518edb.109.1655510177029;
        Fri, 17 Jun 2022 16:56:17 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:16 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 6/9] media: uvcvideo: Limit power line control for Chicony Easycamera
Date:   Sat, 18 Jun 2022 01:56:07 +0200
Message-Id: <20220617235610.321917-7-ribalda@chromium.org>
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

Two different Easycamera devices do not implement the power line control
correctly. Add a corresponding control mapping override.

Bus 001 Device 003: ID 04f2:b6ba Chicony Electronics Co., Ltd EasyCamera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x04f2 Chicony Electronics Co., Ltd
  idProduct          0xb6ba
  bcdDevice           10.70
  iManufacturer           3 Chicony Electronics Co.,Ltd.
  iProduct                1 EasyCamera
  iSerial                 2 0001
  bNumConfigurations      1

Bus 001 Device 003: ID 04f2:b746 Chicony Electronics Co., Ltd EasyCamera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x04f2 Chicony Electronics Co., Ltd
  idProduct          0xb746
  bcdDevice           97.57
  iManufacturer           3 Chicony Electronics Co.,Ltd.
  iProduct                1 EasyCamera
  iSerial                 2 0001
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index ea8f0bb7a20c..b22d083833ee 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2811,6 +2811,24 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRAME_RATE) },
+	/* Chicony EasyCamera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x04f2,
+	  .idProduct		= 0xb6ba,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Chicony EasyCamera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x04f2,
+	  .idProduct		= 0xb746,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* Alcor Micro AU3820 (Future Boy PC USB Webcam) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.37.0.rc0.104.g0611611a94-goog

