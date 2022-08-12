Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238DE591099
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiHLMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbiHLMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:12:18 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C862CE1E;
        Fri, 12 Aug 2022 05:12:13 -0700 (PDT)
X-UUID: 85f2f4f3783f44cdbc51399c0128896a-20220812
X-CPASD-INFO: 588139735cd7453caf1f82e1554a33df@fohyUWBrZWNhg6aDg3h-nYGXYZZoXoW
        Ad29UkWFjkIaVgnxsTV5qXFWCgGpQYWNdYlV3fGtQYmBgZFB5i4Jyj1RgXmCCVHSTgHdyWGFhaQ==
X-CLOUD-ID: 588139735cd7453caf1f82e1554a33df
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:184.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:157.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:0,DUF:2250,ACD:47,DCD:47,SL:0,EISP:0,AG:0,CFC:0.364,CFSR:0.072,UAT:0,RA
        F:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,E
        AF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 85f2f4f3783f44cdbc51399c0128896a-20220812
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 85f2f4f3783f44cdbc51399c0128896a-20220812
X-User: huanglei@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <huanglei@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1122621435; Fri, 12 Aug 2022 20:12:09 +0800
From:   huanglei <huanglei@kylinos.cn>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: [PATCH] media: uvcvideo: limit power line control for Sonix Technology
Date:   Fri, 12 Aug 2022 20:12:02 +0800
Message-Id: <20220812121202.1971-1-huanglei@kylinos.cn>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not implement the power line control correctly. Add a
corresponding control mapping override.

Bus 003 Device 003: ID 3277:0072 Sonix Technology Co., Ltd. USB 2.0 Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x3277
  idProduct          0x0072
  bcdDevice            1.00
  iManufacturer           2 Sonix Technology Co., Ltd.
  iProduct                1 USB 2.0 Camera
  iSerial                 3 REV0001
  bNumConfigurations      1

Signed-off-by: huanglei <huanglei@kylinos.cn>
---
 drivers/media/usb/uvc/uvc_driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..48f4d755a584 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -3282,6 +3282,14 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
+	/* Sonix Technology USB 2.0 Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x3277,
+	  .idProduct		= 0x0072,
+	  .bInterfaceClass	= USB_CLASS_VENDOR_SPEC,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0 },
 	/* Generic USB Video Class */
 	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
 	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },
-- 
2.17.1


No virus found
		Checked by Hillstone Network AntiVirus
