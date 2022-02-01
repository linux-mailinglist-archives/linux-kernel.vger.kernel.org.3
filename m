Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D154A5C92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238202AbiBAMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:48:33 -0500
Received: from maury.uberspace.de ([185.26.156.175]:60888 "EHLO
        maury.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiBAMsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:48:32 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2022 07:48:31 EST
Received: (qmail 12855 invoked by uid 990); 1 Feb 2022 12:41:50 -0000
Authentication-Results: maury.uberspace.de;
        auth=pass (plain)
From:   Joern Koerner <joern.koerner@ijwo.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Joern Koerner <joern.koerner@ijwo.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add support for Edup BT5.1 Class1 Adapter (RTL8761B)
Date:   Tue,  1 Feb 2022 13:41:34 +0100
Message-Id: <20220201124134.806135-1-joern.koerner@ijwo.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ++
X-Rspamd-Report: R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: 2.9
Received: from unknown (HELO unkown) (::1)
        by maury.uberspace.de (Haraka/2.8.28) with ESMTPSA; Tue, 01 Feb 2022 13:41:50 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ cat /sys/kernel/debug/usb/devices. T:  Bus=02 Lev=02
 Prnt=02 Port=00 Cnt=01 Dev#=  7 Spd=12   MxCh= 0 D:  Ver= 1.10 Cls=e0(wlcon)
 Sub=01 Prot=01 MxPS=64 #Cfgs=  1 P:  Vendor=2550 ProdID=8761 Rev= 2.00 S: 
 Manufacturer=Realtek S:  Product=Bluetooth Radio S: 
 SerialNumber=00E04C239987 C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA I:* If#= 0
 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=81(I)
 Atr=03(Int.) MxPS=  16 Ivl=1ms E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms E:
  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms I:* If#= 1 Alt= 0 #EPs= 2
 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=   0
 Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms I:  If#= 1 Alt= 1 #EPs= 2
 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=   9
 Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms I:  If#= 1 Alt= 2 #EPs= 2
 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  17
 Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms I:  If#= 1 Alt= 3 #EPs= 2
 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  25
 Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms I:  If#= 1 Alt= 4 #EPs= 2
 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  33
 Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms I:  If#= 1 Alt= 5 #EPs= 2
 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb E:  Ad=03(O) Atr=01(Isoc) MxPS=  49
 Ivl=1ms E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Joern Koerner <joern.koerner@ijwo.de>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ea72afb7abea..ba467663b79a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -477,6 +477,8 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Additional Realtek 8761B Bluetooth devices */
 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8761BU Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
-- 
2.35.1

