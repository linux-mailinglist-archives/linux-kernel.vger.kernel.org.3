Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B494EA1D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345643AbiC1Uq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbiC1Un1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C067D09;
        Mon, 28 Mar 2022 13:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19CBCB81217;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC28AC341D5;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=Hi9bdGTrkLqzCP9PA6HQj7j6ahQbZYu8OOriI1R776k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFFSMQQJP4k20mAYa8Cj2ojkSgwlEJi6anqJu7nmUbkgxCi6wDJkxXG9EYkhdgCE6
         RM4mAMB+BZqXCSypbYmCpfXvXvS1jFWSRsPXW5U/3SDXmVizKV8O9O6Xyk459KO2wi
         OGRjLqN8/omJZ4q94/zfqgkBS56ImcTRlXORl7xmykx4IjNAyprVAMK5q4ITlXH136
         0HukNFqJ6mhMsj2FgAoEpgxxCbUOiaq5ceqWP5dkLFkfxw3eciimWsFtLLikd+QAlJ
         1HsvCuWRvGwfCbmvfzevy9ZmarMvWfSNy7aX7aOiztHWnsF0vMa2/qlac7bwNVWGTc
         A64h/GdlMA8/g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcm-Jd; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 15/26] media: dvb-usb: m920x: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:27 +0200
Message-Id: <c6f6bab97c39561add54f69a75980f4d453f7c17.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/m920x.c | 51 ++++++++++++++++++-------------
 include/media/dvb-usb-ids.h       | 10 +++---
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/m920x.c
index 691e05833db1..548199cd86f6 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -897,20 +897,29 @@ static int m920x_probe(struct usb_interface *intf,
 	return ret;
 }
 
-static struct usb_device_id m920x_table [] = {
-		{ USB_DEVICE(USB_VID_MSI, USB_PID_MSI_MEGASKY580) },
-		{ USB_DEVICE(USB_VID_ANUBIS_ELECTRONIC,
-			     USB_PID_MSI_DIGI_VOX_MINI_II) },
-		{ USB_DEVICE(USB_VID_ANUBIS_ELECTRONIC,
-			     USB_PID_LIFEVIEW_TV_WALKER_TWIN_COLD) },
-		{ USB_DEVICE(USB_VID_ANUBIS_ELECTRONIC,
-			     USB_PID_LIFEVIEW_TV_WALKER_TWIN_WARM) },
-		{ USB_DEVICE(USB_VID_DPOSH, USB_PID_DPOSH_M9206_COLD) },
-		{ USB_DEVICE(USB_VID_DPOSH, USB_PID_DPOSH_M9206_WARM) },
-		{ USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_PINNACLE_PCTV310E) },
-		{ USB_DEVICE(USB_VID_AZUREWAVE, USB_PID_TWINHAN_VP7049) },
-		{ }		/* Terminating entry */
+enum {
+	MSI_MEGASKY580,
+	ANUBIS_MSI_DIGI_VOX_MINI_II,
+	ANUBIS_LIFEVIEW_TV_WALKER_TWIN_COLD,
+	ANUBIS_LIFEVIEW_TV_WALKER_TWIN_WARM,
+	DPOSH_M9206_COLD,
+	DPOSH_M9206_WARM,
+	VISIONPLUS_PINNACLE_PCTV310E,
+	AZUREWAVE_TWINHAN_VP7049,
 };
+
+static struct usb_device_id m920x_table[] = {
+	DVB_USB_DEV(MSI, MSI_MEGASKY580),
+	DVB_USB_DEV(ANUBIS_ELECTRONIC, ANUBIS_MSI_DIGI_VOX_MINI_II),
+	DVB_USB_DEV(ANUBIS_ELECTRONIC, ANUBIS_LIFEVIEW_TV_WALKER_TWIN_COLD),
+	DVB_USB_DEV(ANUBIS_ELECTRONIC, ANUBIS_LIFEVIEW_TV_WALKER_TWIN_WARM),
+	DVB_USB_DEV(DPOSH, DPOSH_M9206_COLD),
+	DVB_USB_DEV(DPOSH, DPOSH_M9206_WARM),
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_PINNACLE_PCTV310E),
+	DVB_USB_DEV(AZUREWAVE, AZUREWAVE_TWINHAN_VP7049),
+	{ }
+};
+
 MODULE_DEVICE_TABLE (usb, m920x_table);
 
 static struct dvb_usb_device_properties megasky_properties = {
@@ -962,7 +971,7 @@ static struct dvb_usb_device_properties megasky_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "MSI Mega Sky 580 DVB-T USB2.0",
-			{ &m920x_table[0], NULL },
+			{ &m920x_table[MSI_MEGASKY580], NULL },
 			{ NULL },
 		}
 	}
@@ -1010,7 +1019,7 @@ static struct dvb_usb_device_properties digivox_mini_ii_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "MSI DIGI VOX mini II DVB-T USB2.0",
-			{ &m920x_table[1], NULL },
+			{ &m920x_table[ANUBIS_MSI_DIGI_VOX_MINI_II], NULL },
 			{ NULL },
 		},
 	}
@@ -1097,8 +1106,8 @@ static struct dvb_usb_device_properties tvwalkertwin_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   .name = "LifeView TV Walker Twin DVB-T USB2.0",
-		    .cold_ids = { &m920x_table[2], NULL },
-		    .warm_ids = { &m920x_table[3], NULL },
+		    .cold_ids = { &m920x_table[ANUBIS_LIFEVIEW_TV_WALKER_TWIN_COLD], NULL },
+		    .warm_ids = { &m920x_table[ANUBIS_LIFEVIEW_TV_WALKER_TWIN_WARM], NULL },
 		},
 	}
 };
@@ -1139,8 +1148,8 @@ static struct dvb_usb_device_properties dposh_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		 {   .name = "Dposh DVB-T USB2.0",
-		     .cold_ids = { &m920x_table[4], NULL },
-		     .warm_ids = { &m920x_table[5], NULL },
+		     .cold_ids = { &m920x_table[DPOSH_M9206_COLD], NULL },
+		     .warm_ids = { &m920x_table[DPOSH_M9206_WARM], NULL },
 		 },
 	 }
 };
@@ -1195,7 +1204,7 @@ static struct dvb_usb_device_properties pinnacle_pctv310e_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "Pinnacle PCTV 310e",
-			{ &m920x_table[6], NULL },
+			{ &m920x_table[VISIONPLUS_PINNACLE_PCTV310E], NULL },
 			{ NULL },
 		}
 	}
@@ -1250,7 +1259,7 @@ static struct dvb_usb_device_properties vp7049_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "DTV-DVB UDTT7049",
-			{ &m920x_table[7], NULL },
+			{ &m920x_table[AZUREWAVE_TWINHAN_VP7049], NULL },
 			{ NULL },
 		}
 	 }
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index e41902d06ccc..10d73c108149 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -106,6 +106,9 @@
 #define USB_PID_AME_DTV5100				0xa232
 #define USB_PID_ANCHOR_NEBULA_DIGITV			0x0201
 #define USB_PID_ANSONIC_DVBT_USB			0x6000
+#define USB_PID_ANUBIS_LIFEVIEW_TV_WALKER_TWIN_COLD	0x0514
+#define USB_PID_ANUBIS_LIFEVIEW_TV_WALKER_TWIN_WARM	0x0513
+#define USB_PID_ANUBIS_MSI_DIGI_VOX_MINI_II		0x1513
 #define USB_PID_ANYSEE					0x861f
 #define USB_PID_ARTEC_T14BR				0x810f
 #define USB_PID_ARTEC_T14_COLD				0x810b
@@ -149,6 +152,7 @@
 #define USB_PID_AZUREWAVE_6007				0x0ccd
 #define USB_PID_AZUREWAVE_AD_TU700			0x3237
 #define USB_PID_AZUREWAVE_AZ6027			0x3275
+#define USB_PID_AZUREWAVE_TWINHAN_VP7049		0x3219
 #define USB_PID_COMPRO_DVBU2000_COLD			0xd000
 #define USB_PID_COMPRO_DVBU2000_UNK_COLD		0x010c
 #define USB_PID_COMPRO_DVBU2000_UNK_WARM		0x010d
@@ -283,14 +287,11 @@
 #define USB_PID_KWORLD_VSTREAM_WARM			0x17df
 #define USB_PID_KYE_DVB_T_COLD				0x701e
 #define USB_PID_KYE_DVB_T_WARM				0x701f
-#define USB_PID_LIFEVIEW_TV_WALKER_TWIN_COLD		0x0514
-#define USB_PID_LIFEVIEW_TV_WALKER_TWIN_WARM		0x0513
 #define USB_PID_LITEON_DVB_T_COLD			0xf000
 #define USB_PID_LITEON_DVB_T_WARM			0xf001
 #define USB_PID_MEDION_MD95700				0x0932
 #define USB_PID_MIGLIA_WT220U_ZAP250_COLD		0x0220
 #define USB_PID_MSI_DIGIVOX_DUO 			0x8801
-#define USB_PID_MSI_DIGI_VOX_MINI_II			0x1513
 #define USB_PID_MSI_DIGI_VOX_MINI_III			0x8807
 #define USB_PID_MSI_MEGASKY580				0x5580
 #define USB_PID_MSI_MEGASKY580_55801			0x5581
@@ -317,7 +318,6 @@
 #define USB_PID_PINNACLE_EXPRESSCARD_320CX		0x022e
 #define USB_PID_PINNACLE_PCTV2000E			0x022c
 #define USB_PID_PINNACLE_PCTV282E			0x0248
-#define USB_PID_PINNACLE_PCTV310E			0x3211
 #define USB_PID_PINNACLE_PCTV340E			0x023d
 #define USB_PID_PINNACLE_PCTV340E_SE			0x023e
 #define USB_PID_PINNACLE_PCTV71E			0x022b
@@ -416,7 +416,6 @@
 #define USB_PID_TWINHAN_VP7041_WARM			0x3202
 #define USB_PID_TWINHAN_VP7045_COLD			0x3205
 #define USB_PID_TWINHAN_VP7045_WARM			0x3206
-#define USB_PID_TWINHAN_VP7049				0x3219
 #define USB_PID_ULTIMA_TVBOX_AN2235_COLD		0x8107
 #define USB_PID_ULTIMA_TVBOX_AN2235_WARM		0x8108
 #define USB_PID_ULTIMA_TVBOX_ANCHOR_COLD		0x2235
@@ -429,6 +428,7 @@
 #define USB_PID_UNIWILL_STK7700P			0x6003
 #define USB_PID_UNK_HYPER_PALTEK_COLD			0x005e
 #define USB_PID_UNK_HYPER_PALTEK_WARM			0x005f
+#define USB_PID_VISIONPLUS_PINNACLE_PCTV310E		0x3211
 #define USB_PID_WIDEVIEW_DTT200U_COLD			0x0201
 #define USB_PID_WIDEVIEW_DTT200U_WARM			0x0301
 #define USB_PID_WIDEVIEW_WT220U_COLD			0x0222
-- 
2.35.1

