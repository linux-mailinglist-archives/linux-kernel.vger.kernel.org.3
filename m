Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D084D47A87A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhLTLTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhLTLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A7C061574;
        Mon, 20 Dec 2021 03:19:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EAAE60FDA;
        Mon, 20 Dec 2021 11:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD279C36AE7;
        Mon, 20 Dec 2021 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639999161;
        bh=rFjfI7Vn7vJeC1yK+hK/Qc1NMRxCct+H3Q4AMWxJdCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rj8tO1uyWdpRHPQ0//QKOsbjqWHCdzwqjq0dKNReb3imsliuoirUMTlvJ95e//VyR
         iUIJZFeR9gbgqMNmYVa5Zk6dddqcjblgUHzENetfC1734x4QqUv8LVWLKnTf7Anndx
         LV12a3OOUQZDqH7ihUzQ/gYZwgWac6I4o/yzYvwnS7djqUMlSp7EuE+N4H9oHCxLqG
         nD4vg9X96gNZ2fBjFNoZKyocf59+6B7l5UCyeddSlBuGXe2RehYb0sytYJPjJLyiew
         qnT037uIxpYzzOh6TZcZSUyQbEkuu2WEaWtieynoOJvRCTqKVntGoCjY9J+Enc2jBD
         fFXfAUtbdYzvA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzGhH-00063C-2s; Mon, 20 Dec 2021 12:19:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marc Ferland <ferlandm@amotus.ca>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gnss: usb: add support for Sierra Wireless XM1210
Date:   Mon, 20 Dec 2021 12:19:01 +0100
Message-Id: <20211220111901.23206-3-johan@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211220111901.23206-1-johan@kernel.org>
References: <20211220111901.23206-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the USB interface of the Sierra Wireless XM1210
receiver.

Note that the device only supports NMEA.

Bus 002 Device 003: ID 1199:b000 Sierra Wireless, Inc. Sierra Wireless_GNSS
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1199 Sierra Wireless, Inc.
  idProduct          0xb000
  bcdDevice            0.01
  iManufacturer           1 Sierra-wireless
  iProduct                2 Sierra Wireless_GNSS
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0020
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               50mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         0
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval             255
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval             255
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0001
  Self Powered

Reported-by: Marc Ferland <ferlandm@amotus.ca>
Link: https://lore.kernel.org/r/20211027200223.72701-1-ferlandm@amotus.ca
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gnss/usb.c b/drivers/gnss/usb.c
index 5c0251034def..792235a688ea 100644
--- a/drivers/gnss/usb.c
+++ b/drivers/gnss/usb.c
@@ -17,6 +17,7 @@
 #define GNSS_USB_WRITE_TIMEOUT	1000
 
 static const struct usb_device_id gnss_usb_id_table[] = {
+	{ USB_DEVICE(0x1199, 0xb000) },		/* Sierra Wireless XM1210 */
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, gnss_usb_id_table);
-- 
2.32.0

