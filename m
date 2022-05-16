Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96E1528015
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiEPItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiEPItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:49:32 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0011C16;
        Mon, 16 May 2022 01:49:27 -0700 (PDT)
X-Virus-Scanned: Yes
From:   Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1652690964;
        bh=6JI6nRxa4dp4XI16xrBF0shYaH4B8lhSnubceBvtvF8=;
        h=From:To:Cc:Subject;
        b=evzb4NjNJESXsEnNA97YibTqraCjzUGQMSUX6cR/hBFKeAYGto26ptyMspUL8hLAv
         uDb0nd1L3R4GJ0jSgix+gOJaqjoBuYwKRAvEPETL1aTQI3G2BrsY7pKgLf6mkBcYBy
         S1qPeRnwbgjFrYDcLqfiIIuZe+H99kthFup4tptOZqLVYyyMUxhCfgBkJDSE8/+QEN
         LPIkoTpFfzsCUevM3HI+XxCnIwhOmcu3WUQueWvUSek2/MMvHyyikcjvvpRI9VIDbV
         lyfkjCERP5drxkoIpf7OJlK2C/HV/k2RAwDiZRJW9hf64VWnK/OL1ny+pDaZL+V7Ev
         1nI3HIj/nS3zA==
To:     linux-usb@vger.kernel.org, oliver@neukum.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] net: usb: cdc_ether: Add Fibocom L610 modem
Date:   Mon, 16 May 2022 10:48:46 +0200
Message-Id: <20220516084847.77586-1-sven@svenschwermer.de>
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

The L610 modem has 3 USB configurations that are configurable via the AT
command AT+GTUSBMODE={31,32,33} which make the modem enumerate with the
following interfaces, respectively:

31: Modem + NV + MOS + Diag + LOG + AT + AT
32: ECM + Modem + NV + MOS + Diag + LOG + AT + AT
33: RNDIS + Modem + NV + MOS + Diag + LOG + AT + AT

A detailed description of the USB configuration for the ECM mode
(+GTUSBMODE=32) follows:

T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#=122 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1782 ProdID=4d11 Rev= 0.00
S:  Manufacturer=FIBOCOM
S:  Product=L610
C:* #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=400mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---

Notes:
    Changes:
    V1->V2: Add additional comments

 drivers/net/usb/cdc_ether.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 9b4dfa3001d6..3a9c4935c180 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -999,6 +999,12 @@ static const struct usb_device_id	products[] = {
 				      USB_CDC_SUBCLASS_ETHERNET,
 				      USB_CDC_PROTO_NONE),
 	.driver_info = (unsigned long)&wwan_info,
+}, {
+	/* Fibocom L610 (ECM mode) */
+	USB_DEVICE_AND_INTERFACE_INFO(0x1782, 0x4d11, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = (unsigned long)&wwan_info,
 }, {
 	USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ETHERNET,
 			USB_CDC_PROTO_NONE),

base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
2.36.1

