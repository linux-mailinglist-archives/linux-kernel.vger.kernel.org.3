Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EDC528011
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbiEPItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiEPItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:49:32 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7811C27;
        Mon, 16 May 2022 01:49:27 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1652690964;
        bh=uG+x6icNh1O/0EWgQVvx6OLvnHRYs+n2gGyVuVqjvb0=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=c3U8uydi633Lr2omnk1ltnkT19QHEqsyzOuQJyYuT8FwAG40/SlxPN/fyaNDa2mvl
         RYpYtSDsw1TGAw0P7lXm7jyqFL8/XutSQstNluxsLWJZB0A1g7LFdM5RlTpwUaXxnD
         weQQtqIYnElgK/mAD0eKXaam1wO58Wdos8rjP1EleKSnJU4fX6I3G6bAU9l7jgLr8J
         eU8lZK9P1MLbJ5hg3PW9tL6aGQj04OxjiDFg8aIiDPC+SIKQ1i9dcR8tHbJcIJWNHb
         coODbeO0CZ3X1m1QMwxQRc8RVFGgX7/2DAz9hGLHuZ8vNeNhZK3sR+8zktijrX/p8X
         VFOFiUc5Bh8Dg==
To:     linux-usb@vger.kernel.org, oliver@neukum.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net: usb: cdc_ether: Add Fibocom MA510 modem
Date:   Mon, 16 May 2022 10:48:47 +0200
Message-Id: <20220516084847.77586-2-sven@svenschwermer.de>
In-Reply-To: <20220516084847.77586-1-sven@svenschwermer.de>
References: <20220516084847.77586-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

Since this is a modem device enumerating as an Ethernet adapter, we need
to whitelist it as a WWAN device which tells userspace that this device
requires setup (via AT commands) before it can be used.

The MA510 modem has 3 USB configurations that are configurable via the AT
command AT+GTUSBMODE={30,31,32} which make the modem enumerate with the
following interfaces, respectively:

30: Diag + QDSS + Modem + RMNET
31: Diag + Modem + AT + ECM
32: Modem + AT + ECM

Detailed descriptions of the ECM-mode USB configurations follow:

+GTUSBMODE: 31
--------------
T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#= 99 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2cb7 ProdID=0106 Rev= 0.00
S:  Manufacturer=Fibocom MA510 Modem
S:  Product=Fibocom MA510 Modem
S:  SerialNumber=55e2695b
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 3 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=86(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
I:  If#= 4 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 4 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

+GTUSBMODE: 32
--------------
T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#=100 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2cb7 ProdID=010a Rev= 0.00
S:  Manufacturer=Fibocom MA510 Modem
S:  Product=Fibocom MA510 Modem
S:  SerialNumber=55e2695b
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 2 IfCount= 2 Cls=02(comm.) Sub=00 Prot=00
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=fe Prot=ff Driver=option
E:  Ad=83(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=2ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---

Notes:
    Changes:
    V1->V2: Add additional comments

 drivers/net/usb/cdc_ether.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 3a9c4935c180..2b839fd62528 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -1005,6 +1005,18 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET,
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
+}, {
+	/* Fibocom MA510 (ECM mode; +GTUSBMODE=31) */
+	USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0106, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
+}, {
+	/* Fibocom MA510 (ECM mode; +GTUSBMODE=32) */
+	USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010a, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
 }, {
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),
-- 
2.36.1

