Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D852254F59B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381946AbiFQKh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381763AbiFQKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:37:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DBE6AA7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:36:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o7so7991157eja.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhLoBlqgRdL7zGQaDBkJEiUo6xrYYgqrgV6p3n7v4gE=;
        b=Wwk7RLofEB+IbmYSe2FmMqkR5iRZKO1Oh+HCKuEp/FIYSTFYKycnJdq/iYv5WDw79Q
         dOCmjt/GDxI5WU3cVlVb3xZ2zvIAfDOX/MI/VNNL1P+6Xlw0PoMr0mC8unwkip1c4grT
         KQQyL2tnyQg+IAK0xlNXpYVUIUSja8u09c6hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhLoBlqgRdL7zGQaDBkJEiUo6xrYYgqrgV6p3n7v4gE=;
        b=x3ZAUurCm5mloiP51A31niUwdjxi4qhYJC+JcNO/NwRNMTXtXSyGIGDHnuCpEsoAad
         0yQGr13AXLN+L2VPhiNKktYHmxpruBFyp8XaMGcgYSyxivXKX2jPMR+DrOoh1G7y41rs
         /AKlME0MsYmgqegIoICQStrAACCULfvTwxIBuG7VRoiuIr7P8H2WQyhYW19GCpnd7Jje
         pTT6ssUPQoej7xSEDAcbRn+aGAo4Wi4SKRISKRTC6MejgVqs7re19hbA2tlNMtzXlThl
         4DqsbhNIM7CV247JEfufdKU++SdRMc/+lLlOdYsi86kHKMm4+u2VRRzpRlmAV0oj8Nva
         L1pQ==
X-Gm-Message-State: AJIora9G+XyPR25U/6IBxng4BmTaUPZH+kSC7jlQuXQBgFlibZ6Sxw0l
        NcQWLmQL64rFUHTc71Oo26LjDQ==
X-Google-Smtp-Source: AGRyM1s8HwNU0Z7zculSCmSGdnF7htKjf3r7eeUdFUUmjP7/4WdkESSeJkd6mQq3hUxLna+JTh5y8Q==
X-Received: by 2002:a17:907:7f06:b0:6fe:b81f:f885 with SMTP id qf6-20020a1709077f0600b006feb81ff885mr8695519ejc.621.1655462217885;
        Fri, 17 Jun 2022 03:36:57 -0700 (PDT)
Received: from alco.corp.google.com ([2620:0:1059:10:a86e:90:fb4:466e])
        by smtp.gmail.com with ESMTPSA id z19-20020a056402275300b004319b12371asm3704340edd.47.2022.06.17.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:36:57 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 7/8] media: uvcvideo: Limit power line control for Quanta cameras
Date:   Fri, 17 Jun 2022 12:36:44 +0200
Message-Id: <20220617103645.71560-8-ribalda@chromium.org>
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

