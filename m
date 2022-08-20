Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8972759AA54
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244844AbiHTA5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiHTA5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:57:15 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E6BE107D8A;
        Fri, 19 Aug 2022 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4ginwr7HYN3S4UBiB6
        IChkqn6tiWIxhJ8/YP+ouQkxc=; b=BcKdSvrNOpSP6XBx4Kq7gg2FpMRIxCSOy9
        XrbeUrauyJkAWw3ITUybp1GZszFPQPpnRoIS23jOuhl+pJFa+yHUx63f41h++tVP
        YngnYcRH9D/aLsTmITWZy/C+7u3JmmmuGf6swBZmAgtUQaPmCPiBU2NsEcWygF/H
        hvD3ZWw2Y=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp1 (Coremail) with SMTP id GdxpCgCnxtZcMQBjTCv_Vw--.51024S2;
        Sat, 20 Aug 2022 08:57:00 +0800 (CST)
From:   huanglei <huanglei814@163.com>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: [PATCH v3] media: uvcvideo: limit power line control for Sonix Technology
Date:   Sat, 20 Aug 2022 08:56:58 +0800
Message-Id: <20220820005658.21456-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgCnxtZcMQBjTCv_Vw--.51024S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1fJFW8XF1UZr45JF4fZrb_yoW8WFWUpr
        4kGayFyrW8GrWfuw17X3yDuFy5u3Z3GaySkF43Gws09F93Cr97WF9FyFyqkay2yF1IyF12
        qr1kt39Ig3W5Kr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNNV9UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbisB1j9lUMUKv3XgAAsz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huanglei <huanglei@kylinos.cn>

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
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..e8f823685139 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -3264,6 +3264,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
+	/* Sonix Technology USB 2.0 Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x3277,
+	  .idProduct		= 0x0072,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* Acer EasyCamera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.17.1


No virus found
		Checked by Hillstone Network AntiVirus

