Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBCA550104
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382512AbiFQX44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381373AbiFQX4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:56:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9265415
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n10so11368350ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=scX391f5blpJybIeBstalb8q/E+bG9Wz4cWkWDEOBNM=;
        b=WZ25gGhFa6piGaIAblr/7+DjWPKrFrCiYrhva2rjbsBCWQkVv8JG0shVuTPmm4a78Y
         5oUqPdiKh8Iopv/haFtV9Fvxg20fPQHUVTN4P5TRhETIt+HM1tyVhbOBj+9kSl9MsSIW
         Fr0D36hT+p/cFaQkJgwyAKlW8wuNzg/LuTeQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=scX391f5blpJybIeBstalb8q/E+bG9Wz4cWkWDEOBNM=;
        b=Tg/ZMoRvk1hBHKIIKq/82K20bSb9zbMSUPww7PC6zD7+9YWJQR3mT/IryXGvhgtxCX
         BGOKFEsjy+jIcWblRaIWdWzLwKvEyn2hiwTYnP2fOsK2HdPqSpWVi9/C6b9mQOI77X1P
         U7/Lh4RhZ8e8rNNi/Txn4nXXFSP79snJjYRFdfdbVqv1zRslXFSYaWJaKg5uNpyFeAQX
         lrBl40PcxyG39TDqm+FEOH5IRuMi1T9J7MbRDn+0IgqwS4f5OmeBKlBpNbaTjq9OSNbg
         1rrKIcuKgItGNTBU/fc1DqEMx7+HoLc4Lj5jAkFuRaKxRER5Yp7iC5pEG5Y6epaxJQIj
         t2tQ==
X-Gm-Message-State: AJIora/hDXQR5nSIv7BHYs8RIF45IrOYldWumujxXd6cjKu6fkFYXFWm
        KGG+hjsKZUKICggsTBDni9Rtrg==
X-Google-Smtp-Source: AGRyM1vxunrryRLKRZB0tZ5E/wpySmxklz+mBU9GpldYHFwnCyJousJygAXN+QATaDteTf4N0dO/gg==
X-Received: by 2002:a17:907:7da5:b0:711:c9cd:61e0 with SMTP id oz37-20020a1709077da500b00711c9cd61e0mr11257153ejc.443.1655510177994;
        Fri, 17 Jun 2022 16:56:17 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm1452538edq.63.2022.06.17.16.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:56:17 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 7/9] media: uvcvideo: Limit power line control for Chicony Easycamera
Date:   Sat, 18 Jun 2022 01:56:08 +0200
Message-Id: <20220617235610.321917-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220617235610.321917-1-ribalda@chromium.org>
References: <20220617235610.321917-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another Chicony camera device does not implement the power line control
correctly. Add a corresponding control mapping override.

Bus 001 Device 003: ID 04f2:b5eb Chicony Electronics Co., Ltd EasyCamera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x04f2 Chicony Electronics Co., Ltd
  idProduct          0xb5eb
  bcdDevice           90.45
  iManufacturer           3 Chicony Electronics Co.,Ltd.
  iProduct                1 EasyCamera
  iSerial                 2 0001
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index b22d083833ee..425520f06ce4 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2812,6 +2812,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTRICT_FRAME_RATE) },
 	/* Chicony EasyCamera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x04f2,
+	  .idProduct		= 0xb5eb,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Chicony EasyCamera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
 	  .idVendor		= 0x04f2,
-- 
2.37.0.rc0.104.g0611611a94-goog

