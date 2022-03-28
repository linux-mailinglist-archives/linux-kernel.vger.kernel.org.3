Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786CE4EA1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiC1Urc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbiC1Un3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D66674D9;
        Mon, 28 Mar 2022 13:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A190CE1712;
        Mon, 28 Mar 2022 20:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076B6C34118;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500104;
        bh=S1SK8BZ46qBTNL/ci9YPc28ZZP7dV+0Sm7N2ksJlf/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cny2gelXnMnPio6p1LZHMJV5fvD0wParQg1ghBzlBiJ3kHj8ZqbweKW2LiiBu4bus
         jL1KdKLE1ixY6B6w7h/vCU74WaKzJC/sO7Wljm0CZNstpR2rgVbk4TpOpg+DY76afm
         AC+z69NOX+KZedGyjvqdDc+0VNkooPucRR04IJnAY4ESJHycyVzC8YL8d5maZLxHuK
         6BvLbMhwbScYkMwPwUCR3MOSisDyK+U5PTHQKwuoTAzNzMu0cu6Z7CPV03A8wxlb+G
         arpl8ik8Ui7ObBEAlq9AhYcUDXzuJRfyEUOv/rUxcMH+v+gY+N390P2mcmiLnf07kO
         k2IF7ITiGV2QA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcW-Dn; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 11/26] media: dvb-usb: dtt200u: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:23 +0200
Message-Id: <9fa3d1add4c58e1320dcc18578fda2d0106becda.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/dtt200u.c | 56 ++++++++++++++++++-----------
 include/media/dvb-usb-ids.h         | 19 +++++-----
 2 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dtt200u.c b/drivers/media/usb/dvb-usb/dtt200u.c
index 24efa023d827..e6ee56b3a9dd 100644
--- a/drivers/media/usb/dvb-usb/dtt200u.c
+++ b/drivers/media/usb/dvb-usb/dtt200u.c
@@ -158,19 +158,33 @@ static int dtt200u_usb_probe(struct usb_interface *intf,
 	return -ENODEV;
 }
 
-static struct usb_device_id dtt200u_usb_table [] = {
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_COLD) },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_DTT200U_WARM) },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_COLD)  },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_WARM)  },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_ZL0353_COLD)  },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_ZL0353_WARM)  },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_FC_COLD)  },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_FC_WARM)  },
-	{ USB_DEVICE(USB_VID_WIDEVIEW, USB_PID_WT220U_ZAP250_COLD)  },
-	{ USB_DEVICE(USB_VID_MIGLIA, USB_PID_WT220U_ZAP250_COLD)  },
-	{ 0 },
+enum {
+	WIDEVIEW_DTT200U_COLD,
+	WIDEVIEW_DTT200U_WARM,
+	WIDEVIEW_WT220U_COLD,
+	WIDEVIEW_WT220U_WARM,
+	WIDEVIEW_WT220U_ZL0353_COLD,
+	WIDEVIEW_WT220U_ZL0353_WARM,
+	WIDEVIEW_WT220U_FC_COLD,
+	WIDEVIEW_WT220U_FC_WARM,
+	WIDEVIEW_WT220U_ZAP250_COLD,
+	MIGLIA_WT220U_ZAP250_COLD,
 };
+
+static struct usb_device_id dtt200u_usb_table[] = {
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_DTT200U_COLD),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_DTT200U_WARM),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_WT220U_COLD),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_WT220U_WARM),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_WT220U_ZL0353_COLD),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_WT220U_ZL0353_WARM),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_WT220U_FC_COLD),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_WT220U_FC_WARM),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_WT220U_ZAP250_COLD),
+	DVB_USB_DEV(MIGLIA, MIGLIA_WT220U_ZAP250_COLD),
+	{ }
+};
+
 MODULE_DEVICE_TABLE(usb, dtt200u_usb_table);
 
 static struct dvb_usb_device_properties dtt200u_properties = {
@@ -218,8 +232,8 @@ static struct dvb_usb_device_properties dtt200u_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{ .name = "WideView/Yuan/Yakumo/Hama/Typhoon DVB-T USB2.0 (WT-200U)",
-		  .cold_ids = { &dtt200u_usb_table[0], NULL },
-		  .warm_ids = { &dtt200u_usb_table[1], NULL },
+		  .cold_ids = { &dtt200u_usb_table[WIDEVIEW_DTT200U_COLD], NULL },
+		  .warm_ids = { &dtt200u_usb_table[WIDEVIEW_DTT200U_WARM], NULL },
 		},
 		{ NULL },
 	}
@@ -270,8 +284,8 @@ static struct dvb_usb_device_properties wt220u_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{ .name = "WideView WT-220U PenType Receiver (Typhoon/Freecom)",
-		  .cold_ids = { &dtt200u_usb_table[2], &dtt200u_usb_table[8], NULL },
-		  .warm_ids = { &dtt200u_usb_table[3], NULL },
+		  .cold_ids = { &dtt200u_usb_table[WIDEVIEW_WT220U_COLD], &dtt200u_usb_table[WIDEVIEW_WT220U_ZAP250_COLD], NULL },
+		  .warm_ids = { &dtt200u_usb_table[WIDEVIEW_WT220U_WARM], NULL },
 		},
 		{ NULL },
 	}
@@ -322,8 +336,8 @@ static struct dvb_usb_device_properties wt220u_fc_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{ .name = "WideView WT-220U PenType Receiver (Typhoon/Freecom)",
-		  .cold_ids = { &dtt200u_usb_table[6], NULL },
-		  .warm_ids = { &dtt200u_usb_table[7], NULL },
+		  .cold_ids = { &dtt200u_usb_table[WIDEVIEW_WT220U_FC_COLD], NULL },
+		  .warm_ids = { &dtt200u_usb_table[WIDEVIEW_WT220U_FC_WARM], NULL },
 		},
 		{ NULL },
 	}
@@ -374,8 +388,8 @@ static struct dvb_usb_device_properties wt220u_zl0353_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{ .name = "WideView WT-220U PenType Receiver (based on ZL353)",
-		  .cold_ids = { &dtt200u_usb_table[4], NULL },
-		  .warm_ids = { &dtt200u_usb_table[5], NULL },
+		  .cold_ids = { &dtt200u_usb_table[WIDEVIEW_WT220U_ZL0353_COLD], NULL },
+		  .warm_ids = { &dtt200u_usb_table[WIDEVIEW_WT220U_ZL0353_WARM], NULL },
 		},
 		{ NULL },
 	}
@@ -393,7 +407,7 @@ static struct dvb_usb_device_properties wt220u_miglia_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{ .name = "WideView WT-220U PenType Receiver (Miglia)",
-		  .cold_ids = { &dtt200u_usb_table[9], NULL },
+		  .cold_ids = { &dtt200u_usb_table[MIGLIA_WT220U_ZAP250_COLD], NULL },
 		  /* This device turns into WT220U_ZL0353_WARM when fw
 		     has been uploaded */
 		  .warm_ids = { NULL },
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index c3bea2bf9dda..66a5b2045552 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -194,8 +194,6 @@
 #define USB_PID_DNTV_TINYUSB2_WARM			0x3224
 #define USB_PID_DPOSH_M9206_COLD			0x9206
 #define USB_PID_DPOSH_M9206_WARM			0xa090
-#define USB_PID_DTT200U_COLD				0x0201
-#define USB_PID_DTT200U_WARM				0x0301
 #define USB_PID_DVB_T_USB_STICK_HIGH_SPEED_COLD 	0x5000
 #define USB_PID_DVB_T_USB_STICK_HIGH_SPEED_WARM 	0x5001
 #define USB_PID_DVICO_BLUEBIRD_DUAL_1_COLD		0xdb50
@@ -290,6 +288,7 @@
 #define USB_PID_LITEON_DVB_T_COLD			0xf000
 #define USB_PID_LITEON_DVB_T_WARM			0xf001
 #define USB_PID_MEDION_MD95700				0x0932
+#define USB_PID_MIGLIA_WT220U_ZAP250_COLD		0x0220
 #define USB_PID_MSI_DIGIVOX_DUO 			0x8801
 #define USB_PID_MSI_DIGI_VOX_MINI_II			0x1513
 #define USB_PID_MSI_DIGI_VOX_MINI_III			0x8807
@@ -430,6 +429,15 @@
 #define USB_PID_UNIWILL_STK7700P			0x6003
 #define USB_PID_UNK_HYPER_PALTEK_COLD			0x005e
 #define USB_PID_UNK_HYPER_PALTEK_WARM			0x005f
+#define USB_PID_WIDEVIEW_DTT200U_COLD			0x0201
+#define USB_PID_WIDEVIEW_DTT200U_WARM			0x0301
+#define USB_PID_WIDEVIEW_WT220U_COLD			0x0222
+#define USB_PID_WIDEVIEW_WT220U_FC_COLD 		0x0225
+#define USB_PID_WIDEVIEW_WT220U_FC_WARM 		0x0226
+#define USB_PID_WIDEVIEW_WT220U_WARM			0x0221
+#define USB_PID_WIDEVIEW_WT220U_ZAP250_COLD		0x0220
+#define USB_PID_WIDEVIEW_WT220U_ZL0353_COLD		0x022a
+#define USB_PID_WIDEVIEW_WT220U_ZL0353_WARM		0x022b
 #define USB_PID_WINFAST_DTV2000DS			0x6a04
 #define USB_PID_WINFAST_DTV2000DS_PLUS			0x6f12
 #define USB_PID_WINFAST_DTV_DONGLE_COLD 		0x6025
@@ -443,13 +451,6 @@
 #define USB_PID_WINTV_NOVA_T_USB2_WARM			0x9301
 #define USB_PID_WINTV_SOLOHD				0x0264
 #define USB_PID_WINTV_SOLOHD_2				0x8268
-#define USB_PID_WT220U_COLD				0x0222
-#define USB_PID_WT220U_FC_COLD				0x0225
-#define USB_PID_WT220U_FC_WARM				0x0226
-#define USB_PID_WT220U_WARM				0x0221
-#define USB_PID_WT220U_ZAP250_COLD			0x0220
-#define USB_PID_WT220U_ZL0353_COLD			0x022a
-#define USB_PID_WT220U_ZL0353_WARM			0x022b
 #define USB_PID_XBOX_ONE_TUNER				0x02d5
 #define USB_PID_XTENSIONS_XD_380			0x0381
 #define USB_PID_YUAN_EC372S				0x1edc
-- 
2.35.1

