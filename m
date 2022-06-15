Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7F54CC56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbiFOPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbiFOPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:13:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189313E07
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:13:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x5so16658052edi.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhLoBlqgRdL7zGQaDBkJEiUo6xrYYgqrgV6p3n7v4gE=;
        b=VHsDUL+8G+l9h6VR2ECsRIAsjXxhP+/yUMKyjhDtQk2Sw/qGLfN25P6aJQeB3Ta3wS
         aRWHnuUAgcO/xYMaasg7Q4M+AM7P8JSwx2bqTHCXwWxzNbTqa3dNBqSx91gvtJcAIrIi
         WMUbhHBliDvh0SgLIjCbSwgbaPPrXTrMi48aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhLoBlqgRdL7zGQaDBkJEiUo6xrYYgqrgV6p3n7v4gE=;
        b=dR8AwA8MHIxNQ13hvdp7e84T9RBOpNF+/+mZT2To//vobdY4pKXdW5H50CwriE2MaV
         K9dm4ogzQH9nBWY0YzKngVBRUKMmm0m4XQge+YNlpH8QAK2ZKxPfaSZAnPTj3rTkWaMu
         8xLqBzuE3GPqreCwZ9KFzfngZkgHfCjApYQTd5R5YZTSU+OH9q2+Awy7UxtfqWWpHPRx
         /yK0skDu93wiMkZwOsY4vyGxsYb+HaSlOuZo4tlBtRR6yLiClgU54qD6JQ5f+4K6FYbw
         7iKP4qJbusFEQGmanJI9eGpkP/4ngxbITONvNzQe7TzOfr4muHu+U7dN7ycYi9Ki7EMv
         GVXw==
X-Gm-Message-State: AJIora/wvLQDS+5p5LtoM5lOhJ7wnJ4WAbPnTgl5VwQOgLD+1fxrkyl+
        2JTAVl9etJYkuQbg2kBpm0GHDw==
X-Google-Smtp-Source: AGRyM1tRkSTTg+6N8fUozmyqvF4O5etX5jvtgyGmyHMsEPxaOr3JOmT6UfDylpDQJq4g1QOkj9TUpw==
X-Received: by 2002:a50:ec12:0:b0:42d:cbcf:a629 with SMTP id g18-20020a50ec12000000b0042dcbcfa629mr275214edr.224.1655305987113;
        Wed, 15 Jun 2022 08:13:07 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b25-20020aa7cd19000000b0042bd2012196sm9610264edw.85.2022.06.15.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:13:06 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 7/8] media: uvcvideo: Limit power line control for Quanta cameras
Date:   Wed, 15 Jun 2022 17:12:58 +0200
Message-Id: <20220615151259.77825-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615151259.77825-1-ribalda@chromium.org>
References: <20220615151259.77825-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two more cameras do not implement the power line control correctly. Add
a corresponding control mapping override.

Bus 001 Device 003: ID 0408:4034 Quanta Computer, Inc. ACER HD User Facing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x0408 Quanta Computer, Inc.
  idProduct          0x4034
  bcdDevice            0.01
  iManufacturer           1 Quanta
  iProduct                2 ACER HD User Facing
  iSerial                 3 01.00.00
  bNumConfigurations      1

Bus 001 Device 003: ID 0408:4030 Quanta Computer, Inc. HD User Facing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x0408 Quanta Computer, Inc.
  idProduct          0x4030
  bcdDevice            0.02
  iManufacturer           1 Quanta
  iProduct                2 HD User Facing
  iSerial                 3 01.00.00
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index d21de83021f5..a862a9d6a2fd 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2708,6 +2708,24 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Quanta USB2.0 HD UVC Webcam */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x0408,
+	  .idProduct		= 0x4030,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 1,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Quanta USB2.0 HD UVC Webcam */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x0408,
+	  .idProduct		= 0x4034,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* LogiLink Wireless Webcam */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.36.1.476.g0c4daa206d-goog

