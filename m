Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D2554CC61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347628AbiFOPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiFOPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:13:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BD13F5A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:13:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c2so16643338edf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eknO20DpjREAR8olUhraC51K66eHn6x17UHnd3DEaa8=;
        b=AmMAjCkL1NHC4Kgh2d7Ej68VIr0rqKewUVWM1k4pz9MCWHVvzDnSfmCWRw4HPaZ0sB
         WGK8K7ozPSLZP2MWzS2qcGJQDo9MpwwY41nsO5SI0wxJQ+IFLbApNy2V+dhqtCou//Vc
         xnZaSg8coYHOjt2eRuRO26FMmUADPmWwxhivA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eknO20DpjREAR8olUhraC51K66eHn6x17UHnd3DEaa8=;
        b=aHwhfUCHqKrgT9AsCOdq6K4PVfjMsn6skXbL22vB7Yu5+YRH/pZ1iqzJrw/dU965wS
         Z0Tap7D+Yi+NxDsSa1YgzJLJXBGWhf6PmkqsYJ8qUA4o5ye2J/tVVuL9hGfn5c/+adZe
         BU4BwYj2P8917T0S3YkPmpCi5bValxEVTGjiFrPp/C8SQLueAplIuNbmSFygXdHWLKfG
         nQVJEIB8K9CMxfyPOcjNltBDHvCA5gwsn4hRR/A3prEg1bi5H8uPoc3WLOwmSHIJSRii
         URckIGgS/dRRkIo2UK0eCtD/GOaL4UEnqzVmeKG9wWbzm7AzRHZnyAKytDJKhTeWFtp7
         A01w==
X-Gm-Message-State: AJIora8j7hpPtDFcs1yZOibidfCjC59tg27ZmEbOzxh/BIIswBPb9qhn
        78F/pMJog2ip7vTZYsCYxWliVg==
X-Google-Smtp-Source: AGRyM1sCvqatdCAaqkPCaRz7lvvlNc/f7+EpXvbuKThokACKe8fUo2IjbEVrnuuB0mlVFrX+98cmQQ==
X-Received: by 2002:a05:6402:e81:b0:432:7f12:1878 with SMTP id h1-20020a0564020e8100b004327f121878mr219454eda.179.1655305986455;
        Wed, 15 Jun 2022 08:13:06 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b25-20020aa7cd19000000b0042bd2012196sm9610264edw.85.2022.06.15.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:13:06 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 6/8] media: uvcvideo: Limit power line control for Chicony Easycamera
Date:   Wed, 15 Jun 2022 17:12:57 +0200
Message-Id: <20220615151259.77825-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615151259.77825-1-ribalda@chromium.org>
References: <20220615151259.77825-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 5b8a71a9edfb..d21de83021f5 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2820,6 +2820,15 @@ static const struct usb_device_id uvc_ids[] = {
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
2.36.1.476.g0c4daa206d-goog

