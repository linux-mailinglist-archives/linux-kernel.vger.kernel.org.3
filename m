Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9244E4EA1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbiC1UsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbiC1Un3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6D674C6;
        Mon, 28 Mar 2022 13:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1748FB81229;
        Mon, 28 Mar 2022 20:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE19C341DB;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500104;
        bh=OZbAm1ebGLpYNVtKje0n/Ne1+7kOD/b8OLKk94dRokY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkw9zIuDEc58wrTEtbwhs4hUl1Nol2jRQm8N4Nila6+M4F8iTBOrNLgVJo/tkZ/RN
         GMhPaGwUmUAO636B8s9gxthX1qI5mEjy0VNBDBkQXJnJLX2OZBkWsSsasg/68qaDaP
         b/BWmymLsILs9iNVNLy2B3d3Btcy26SBErJDcmhA8rxZA4Lc6qU1O8AwqosFpfooHa
         wvKSKzwJJ6WJZIjxIUDHv88t+Ga6c3v/5LBmq3Ztce/ibxae516wEekZjxBJ9TSux9
         clfafJ0TH6FQTbXSDxR41rcydwOzEGhL+EpgIKiG/7IJiVSWf4dp8fvfH4Gg4z0AC3
         4AXn+b8au1gyw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000ld6-Sn; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 20/26] media: dvb-usb: ttusb2: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:32 +0200
Message-Id: <b447d9fd3832da5eff6267e8fe742c431f1133f2.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device number is currently a value that needs to be the same
on two separate tables, but the code doesn't actually enforce it,
leading to errors as boards get added or removed.

Fix it by using an enum.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/ttusb2.c | 36 +++++++++++++++++-------------
 include/media/dvb-usb-ids.h        |  4 ++--
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/ttusb2.c b/drivers/media/usb/dvb-usb/ttusb2.c
index 294274fd8f55..373ffa7f641e 100644
--- a/drivers/media/usb/dvb-usb/ttusb2.c
+++ b/drivers/media/usb/dvb-usb/ttusb2.c
@@ -630,17 +630,23 @@ static int ttusb2_probe(struct usb_interface *intf,
 	return -ENODEV;
 }
 
-static struct usb_device_id ttusb2_table [] = {
-	{ USB_DEVICE(USB_VID_PINNACLE, USB_PID_PCTV_400E) },
-	{ USB_DEVICE(USB_VID_PINNACLE, USB_PID_PCTV_450E) },
-	{ USB_DEVICE(USB_VID_TECHNOTREND,
-		USB_PID_TECHNOTREND_CONNECT_S2400) },
-	{ USB_DEVICE(USB_VID_TECHNOTREND,
-		USB_PID_TECHNOTREND_CONNECT_CT3650) },
-	{ USB_DEVICE(USB_VID_TECHNOTREND,
-		USB_PID_TECHNOTREND_CONNECT_S2400_8KEEPROM) },
-	{}		/* Terminating entry */
+enum {
+	PINNACLE_PCTV_400E,
+	PINNACLE_PCTV_450E,
+	TECHNOTREND_CONNECT_S2400,
+	TECHNOTREND_CONNECT_CT3650,
+	TECHNOTREND_CONNECT_S2400_8KEEPROM,
 };
+
+static struct usb_device_id ttusb2_table[] = {
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV_400E),
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV_450E),
+	DVB_USB_DEV(TECHNOTREND, TECHNOTREND_CONNECT_S2400),
+	DVB_USB_DEV(TECHNOTREND, TECHNOTREND_CONNECT_CT3650),
+	DVB_USB_DEV(TECHNOTREND, TECHNOTREND_CONNECT_S2400_8KEEPROM),
+	{ }
+};
+
 MODULE_DEVICE_TABLE (usb, ttusb2_table);
 
 static struct dvb_usb_device_properties ttusb2_properties = {
@@ -688,11 +694,11 @@ static struct dvb_usb_device_properties ttusb2_properties = {
 	.num_device_descs = 2,
 	.devices = {
 		{   "Pinnacle 400e DVB-S USB2.0",
-			{ &ttusb2_table[0], NULL },
+			{ &ttusb2_table[PINNACLE_PCTV_400E], NULL },
 			{ NULL },
 		},
 		{   "Pinnacle 450e DVB-S USB2.0",
-			{ &ttusb2_table[1], NULL },
+			{ &ttusb2_table[PINNACLE_PCTV_450E], NULL },
 			{ NULL },
 		},
 	}
@@ -743,11 +749,11 @@ static struct dvb_usb_device_properties ttusb2_properties_s2400 = {
 	.num_device_descs = 2,
 	.devices = {
 		{   "Technotrend TT-connect S-2400",
-			{ &ttusb2_table[2], NULL },
+			{ &ttusb2_table[TECHNOTREND_CONNECT_S2400], NULL },
 			{ NULL },
 		},
 		{   "Technotrend TT-connect S-2400 (8kB EEPROM)",
-			{ &ttusb2_table[4], NULL },
+			{ &ttusb2_table[TECHNOTREND_CONNECT_S2400_8KEEPROM], NULL },
 			{ NULL },
 		},
 	}
@@ -823,7 +829,7 @@ static struct dvb_usb_device_properties ttusb2_properties_ct3650 = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "Technotrend TT-connect CT-3650",
-			.warm_ids = { &ttusb2_table[3], NULL },
+			.warm_ids = { &ttusb2_table[TECHNOTREND_CONNECT_CT3650], NULL },
 		},
 	}
 };
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index ed6e37f23cbc..0fad68bfe6f9 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -312,8 +312,6 @@
 #define USB_PID_PCTV_2002E				0x025c
 #define USB_PID_PCTV_2002E_SE				0x025d
 #define USB_PID_PCTV_200E				0x020e
-#define USB_PID_PCTV_400E				0x020f
-#define USB_PID_PCTV_450E				0x0222
 #define USB_PID_PCTV_78E				0x025a
 #define USB_PID_PCTV_79E				0x0262
 #define USB_PID_PINNACLE_EXPRESSCARD_320CX		0x022e
@@ -329,6 +327,8 @@
 #define USB_PID_PINNACLE_PCTV74E			0x0246
 #define USB_PID_PINNACLE_PCTV801E			0x023a
 #define USB_PID_PINNACLE_PCTV801E_SE			0x023b
+#define USB_PID_PINNACLE_PCTV_400E			0x020f
+#define USB_PID_PINNACLE_PCTV_450E			0x0222
 #define USB_PID_PINNACLE_PCTV_452E			0x021f
 #define USB_PID_PINNACLE_PCTV_DUAL_DIVERSITY_DVB_T	0x0229
 #define USB_PID_PINNACLE_PCTV_DVB_T_FLASH		0x0228
-- 
2.35.1

