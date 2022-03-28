Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299B4EA1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbiC1UrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbiC1Un2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1530366AD3;
        Mon, 28 Mar 2022 13:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 546C3CE170E;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8A5C340F0;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500104;
        bh=rHTvx+MW5hQ4COwG9FoYC4tM2scdex5pWVuYj4T0umA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edV5R8xtzr8AbdMBczn7Waq6rG+c0iCvu+Pjqt6BagwMvC8m+F2n1wtRLmavjxJQb
         ba2PjOa9fzDmky3t6sdg0NebtHoTE8cdpatNNyJeDP014DTNzJJe4t8aejhMc8dxfZ
         KKXu3rWS+CxI3/7/ZMQ12KvCOCWBHegrvBiBxbQikVc1KEVcy2LvHIBQl9QjN2BRs0
         xx+0V7j6yRUJ1Iq9hzEBjtQuyuPEzTH+Sk2h2ilmlW5x9SjlXEap6ZN7j/1NB7mXfI
         3E0g5/wnqbUaYcWqVi4b1ksEYKGAE2KAo5BNWiIfpJzVW6FKmHnBoe0J4/F8kvUW2w
         YaN6UzTJKgvCA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBJ-000ldM-4a; Mon, 28 Mar 2022 22:41:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        =?UTF-8?q?Benjamin=20St=C3=BCrz?= <benni@stuerz.xyz>
Subject: [PATCH 24/26] media: dvb-usb: dibusb-mb: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:36 +0200
Message-Id: <a300c26ad4e9bb913e86eeaf0ec7d72b9e7d5d3e.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
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

Suggested-by: Benjamin Stürz <benni@stuerz.xyz>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/dibusb-mb.c | 165 +++++++++++++++-----------
 include/media/dvb-usb-ids.h           |  11 +-
 2 files changed, 101 insertions(+), 75 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dibusb-mb.c b/drivers/media/usb/dvb-usb/dibusb-mb.c
index e9dc27f73970..2cd88cab4c98 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mb.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mb.c
@@ -121,56 +121,77 @@ static int dibusb_probe(struct usb_interface *intf,
 }
 
 /* do not change the order of the ID table */
-static struct usb_device_id dibusb_dib3000mb_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_COLD) },
-/* 01 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_WARM) },
-/* 02 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
-/* 03 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_WARM) },
-/* 04 */	{ USB_DEVICE(USB_VID_COMPRO_UNK,	USB_PID_COMPRO_DVBU2000_UNK_COLD) },
-/* 05 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_COLD) },
-/* 06 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_WARM) },
-/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_COLD) },
-/* 08 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_WARM) },
-/* 09 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_COLD) },
-/* 10 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_WARM) },
-/* 11 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_COLD) },
-/* 12 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_WARM) },
-/* 13 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_COLD) },
-/* 14 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_WARM) },
-/* 15 */	{ USB_DEVICE(USB_VID_VISIONPLUS,	USB_PID_TWINHAN_VP7041_COLD) },
-/* 16 */	{ USB_DEVICE(USB_VID_VISIONPLUS,	USB_PID_TWINHAN_VP7041_WARM) },
-/* 17 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_COLD) },
-/* 18 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_WARM) },
-/* 19 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_COLD) },
-/* 20 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_WARM) },
-/* 21 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
-/* 22 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
-/* 23 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_COLD) },
-
-/* device ID with default DIBUSB2_0-firmware and with the hacked firmware */
-/* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
-/* 25 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_COLD) },
-/* 26 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_WARM) },
-
-/* 27 */	{ USB_DEVICE(USB_VID_KWORLD,		USB_PID_KWORLD_VSTREAM_COLD) },
-
-/* 28 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_COLD) },
-/* 29 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_WARM) },
-
-/*
- * XXX: As Artec just 'forgot' to program the EEPROM on some Artec T1 devices
- *      we don't catch these faulty IDs (namely 'Cypress FX1 USB controller') that
- *      have been left on the device. If you don't have such a device but an Artec
- *      device that's supposed to work with this driver but is not detected by it,
- *      free to enable CONFIG_DVB_USB_DIBUSB_MB_FAULTY via your kernel config.
- */
+enum {
+	WIDEVIEW_DVBT_USB_COLD,
+	WIDEVIEW_DVBT_USB_WARM,
+	COMPRO_DVBU2000_COLD,
+	COMPRO_DVBU2000_WARM,
+	COMPRO_DVBU2000_UNK_COLD,
+	DIBCOM_MOD3000_COLD,
+	DIBCOM_MOD3000_WARM,
+	EMPIA_VSTREAM_COLD,
+	EMPIA_VSTREAM_WARM,
+	GRANDTEC_DVBT_USB_COLD,
+	GRANDTEC_DVBT_USB_WARM,
+	GRANDTEC_MOD3000_COLD,
+	GRANDTEC_MOD3000_WARM,
+	UNK_HYPER_PALTEK_COLD,
+	UNK_HYPER_PALTEK_WARM,
+	VISIONPLUS_VP7041_COLD,
+	VISIONPLUS_VP7041_WARM,
+	TWINHAN_VP7041_COLD,
+	TWINHAN_VP7041_WARM,
+	ULTIMA_TVBOX_COLD,
+	ULTIMA_TVBOX_WARM,
+	ULTIMA_TVBOX_AN2235_COLD,
+	ULTIMA_TVBOX_AN2235_WARM,
+	ADSTECH_USB2_COLD,
+	ADSTECH_USB2_WARM,
+	KYE_DVB_T_COLD,
+	KYE_DVB_T_WARM,
+	KWORLD_VSTREAM_COLD,
+	ULTIMA_TVBOX_USB2_COLD,
+	ULTIMA_TVBOX_USB2_WARM,
+	ULTIMA_TVBOX_ANCHOR_COLD,
+};
 
+static struct usb_device_id dibusb_dib3000mb_table[] = {
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_DVBT_USB_COLD),
+	DVB_USB_DEV(WIDEVIEW, WIDEVIEW_DVBT_USB_WARM),
+	DVB_USB_DEV(COMPRO, COMPRO_DVBU2000_COLD),
+	DVB_USB_DEV(COMPRO, COMPRO_DVBU2000_WARM),
+	DVB_USB_DEV(COMPRO_UNK, COMPRO_DVBU2000_UNK_COLD),
+	DVB_USB_DEV(DIBCOM, DIBCOM_MOD3000_COLD),
+	DVB_USB_DEV(DIBCOM, DIBCOM_MOD3000_WARM),
+	DVB_USB_DEV(EMPIA, EMPIA_VSTREAM_COLD),
+	DVB_USB_DEV(EMPIA, EMPIA_VSTREAM_WARM),
+	DVB_USB_DEV(GRANDTEC, GRANDTEC_DVBT_USB_COLD),
+	DVB_USB_DEV(GRANDTEC, GRANDTEC_DVBT_USB_WARM),
+	DVB_USB_DEV(GRANDTEC, GRANDTEC_MOD3000_COLD),
+	DVB_USB_DEV(GRANDTEC, GRANDTEC_MOD3000_WARM),
+	DVB_USB_DEV(HYPER_PALTEK, UNK_HYPER_PALTEK_COLD),
+	DVB_USB_DEV(HYPER_PALTEK, UNK_HYPER_PALTEK_WARM),
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_VP7041_COLD),
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_VP7041_WARM),
+	DVB_USB_DEV(TWINHAN, TWINHAN_VP7041_COLD),
+	DVB_USB_DEV(TWINHAN, TWINHAN_VP7041_WARM),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_COLD),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_WARM),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_AN2235_COLD),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_AN2235_WARM),
+	DVB_USB_DEV(ADSTECH, ADSTECH_USB2_COLD),
+	DVB_USB_DEV(ADSTECH, ADSTECH_USB2_WARM),
+	DVB_USB_DEV(KYE, KYE_DVB_T_COLD),
+	DVB_USB_DEV(KYE, KYE_DVB_T_WARM),
+	DVB_USB_DEV(KWORLD, KWORLD_VSTREAM_COLD),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_USB2_COLD),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_USB2_WARM),
 #ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
-/* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+	DVB_USB_DEV(ANCHOR, ULTIMA_TVBOX_ANCHOR_COLD),
 #endif
-
-			{ }		/* Terminating entry */
+	{ }
 };
+
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mb_table);
 
 static struct dvb_usb_device_properties dibusb1_1_properties = {
@@ -226,40 +247,40 @@ static struct dvb_usb_device_properties dibusb1_1_properties = {
 	.num_device_descs = 9,
 	.devices = {
 		{	"AVerMedia AverTV DVBT USB1.1",
-			{ &dibusb_dib3000mb_table[0],  NULL },
-			{ &dibusb_dib3000mb_table[1],  NULL },
+			{ &dibusb_dib3000mb_table[WIDEVIEW_DVBT_USB_COLD],  NULL },
+			{ &dibusb_dib3000mb_table[WIDEVIEW_DVBT_USB_WARM],  NULL },
 		},
 		{	"Compro Videomate DVB-U2000 - DVB-T USB1.1 (please confirm to linux-dvb)",
-			{ &dibusb_dib3000mb_table[2], &dibusb_dib3000mb_table[4], NULL},
-			{ &dibusb_dib3000mb_table[3], NULL },
+			{ &dibusb_dib3000mb_table[COMPRO_DVBU2000_COLD], &dibusb_dib3000mb_table[COMPRO_DVBU2000_UNK_COLD], NULL},
+			{ &dibusb_dib3000mb_table[COMPRO_DVBU2000_WARM], NULL },
 		},
 		{	"DiBcom USB1.1 DVB-T reference design (MOD3000)",
-			{ &dibusb_dib3000mb_table[5],  NULL },
-			{ &dibusb_dib3000mb_table[6],  NULL },
+			{ &dibusb_dib3000mb_table[DIBCOM_MOD3000_COLD],  NULL },
+			{ &dibusb_dib3000mb_table[DIBCOM_MOD3000_WARM],  NULL },
 		},
 		{	"KWorld V-Stream XPERT DTV - DVB-T USB1.1",
-			{ &dibusb_dib3000mb_table[7], NULL },
-			{ &dibusb_dib3000mb_table[8], NULL },
+			{ &dibusb_dib3000mb_table[EMPIA_VSTREAM_COLD], NULL },
+			{ &dibusb_dib3000mb_table[EMPIA_VSTREAM_WARM], NULL },
 		},
 		{	"Grandtec USB1.1 DVB-T",
-			{ &dibusb_dib3000mb_table[9],  &dibusb_dib3000mb_table[11], NULL },
-			{ &dibusb_dib3000mb_table[10], &dibusb_dib3000mb_table[12], NULL },
+			{ &dibusb_dib3000mb_table[GRANDTEC_DVBT_USB_COLD],  &dibusb_dib3000mb_table[GRANDTEC_MOD3000_COLD], NULL },
+			{ &dibusb_dib3000mb_table[GRANDTEC_DVBT_USB_WARM], &dibusb_dib3000mb_table[GRANDTEC_MOD3000_WARM], NULL },
 		},
 		{	"Unknown USB1.1 DVB-T device ???? please report the name to the author",
-			{ &dibusb_dib3000mb_table[13], NULL },
-			{ &dibusb_dib3000mb_table[14], NULL },
+			{ &dibusb_dib3000mb_table[UNK_HYPER_PALTEK_COLD], NULL },
+			{ &dibusb_dib3000mb_table[UNK_HYPER_PALTEK_WARM], NULL },
 		},
 		{	"TwinhanDTV USB-Ter USB1.1 / Magic Box I / HAMA USB1.1 DVB-T device",
-			{ &dibusb_dib3000mb_table[15], &dibusb_dib3000mb_table[17], NULL},
-			{ &dibusb_dib3000mb_table[16], &dibusb_dib3000mb_table[18], NULL},
+			{ &dibusb_dib3000mb_table[VISIONPLUS_VP7041_COLD], &dibusb_dib3000mb_table[TWINHAN_VP7041_COLD], NULL},
+			{ &dibusb_dib3000mb_table[VISIONPLUS_VP7041_WARM], &dibusb_dib3000mb_table[TWINHAN_VP7041_WARM], NULL},
 		},
 		{	"Artec T1 USB1.1 TVBOX with AN2135",
-			{ &dibusb_dib3000mb_table[19], NULL },
-			{ &dibusb_dib3000mb_table[20], NULL },
+			{ &dibusb_dib3000mb_table[ULTIMA_TVBOX_COLD], NULL },
+			{ &dibusb_dib3000mb_table[ULTIMA_TVBOX_WARM], NULL },
 		},
 		{	"VideoWalker DVB-T USB",
-			{ &dibusb_dib3000mb_table[25], NULL },
-			{ &dibusb_dib3000mb_table[26], NULL },
+			{ &dibusb_dib3000mb_table[KYE_DVB_T_COLD], NULL },
+			{ &dibusb_dib3000mb_table[KYE_DVB_T_WARM], NULL },
 		},
 	}
 };
@@ -319,12 +340,12 @@ static struct dvb_usb_device_properties dibusb1_1_an2235_properties = {
 #endif
 	.devices = {
 		{	"Artec T1 USB1.1 TVBOX with AN2235",
-			{ &dibusb_dib3000mb_table[21], NULL },
-			{ &dibusb_dib3000mb_table[22], NULL },
+			{ &dibusb_dib3000mb_table[ULTIMA_TVBOX_AN2235_COLD], NULL },
+			{ &dibusb_dib3000mb_table[ULTIMA_TVBOX_AN2235_WARM], NULL },
 		},
 #ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
 		{	"Artec T1 USB1.1 TVBOX with AN2235 (faulty USB IDs)",
-			{ &dibusb_dib3000mb_table[30], NULL },
+			{ &dibusb_dib3000mb_table[ULTIMA_TVBOX_ANCHOR_COLD], NULL },
 			{ NULL },
 		},
 		{ NULL },
@@ -384,11 +405,11 @@ static struct dvb_usb_device_properties dibusb2_0b_properties = {
 	.num_device_descs = 2,
 	.devices = {
 		{	"KWorld/ADSTech Instant DVB-T USB2.0",
-			{ &dibusb_dib3000mb_table[23], NULL },
-			{ &dibusb_dib3000mb_table[24], NULL },
+			{ &dibusb_dib3000mb_table[ADSTECH_USB2_COLD], NULL },
+			{ &dibusb_dib3000mb_table[ADSTECH_USB2_WARM], NULL },
 		},
 		{	"KWorld Xpert DVB-T USB2.0",
-			{ &dibusb_dib3000mb_table[27], NULL },
+			{ &dibusb_dib3000mb_table[KWORLD_VSTREAM_COLD], NULL },
 			{ NULL }
 		},
 		{ NULL },
@@ -446,8 +467,8 @@ static struct dvb_usb_device_properties artec_t1_usb2_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{	"Artec T1 USB2.0",
-			{ &dibusb_dib3000mb_table[28], NULL },
-			{ &dibusb_dib3000mb_table[29], NULL },
+			{ &dibusb_dib3000mb_table[ULTIMA_TVBOX_USB2_COLD], NULL },
+			{ &dibusb_dib3000mb_table[ULTIMA_TVBOX_USB2_WARM], NULL },
 		},
 		{ NULL },
 	}
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 9f53b3ce3e58..e4796464b0d7 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -133,8 +133,6 @@
 #define USB_PID_AVERMEDIA_B835				0xb835
 #define USB_PID_AVERMEDIA_DVBT_USB2_COLD		0xa800
 #define USB_PID_AVERMEDIA_DVBT_USB2_WARM		0xa801
-#define USB_PID_AVERMEDIA_DVBT_USB_COLD 		0x0001
-#define USB_PID_AVERMEDIA_DVBT_USB_WARM 		0x0002
 #define USB_PID_AVERMEDIA_EXPRESS			0xb568
 #define USB_PID_AVERMEDIA_H335				0x0335
 #define USB_PID_AVERMEDIA_HYBRID_ULTRA_USB_M039R	0x0039
@@ -230,6 +228,8 @@
 #define USB_PID_ELGATO_EYETV_SAT			0x002a
 #define USB_PID_ELGATO_EYETV_SAT_V2			0x0025
 #define USB_PID_ELGATO_EYETV_SAT_V3			0x0036
+#define USB_PID_EMPIA_VSTREAM_COLD			0x17de
+#define USB_PID_EMPIA_VSTREAM_WARM			0x17df
 #define USB_PID_EVOLVEO_XTRATV_STICK			0xa115
 #define USB_PID_FREECOM_DVBT				0x0160
 #define USB_PID_FREECOM_DVBT_2				0x0161
@@ -251,6 +251,8 @@
 #define USB_PID_GRANDTEC_DVBT_USB2_WARM 		0x0bc7
 #define USB_PID_GRANDTEC_DVBT_USB_COLD			0x0fa0
 #define USB_PID_GRANDTEC_DVBT_USB_WARM			0x0fa1
+#define USB_PID_GRANDTEC_MOD3000_COLD			0x0bb8
+#define USB_PID_GRANDTEC_MOD3000_WARM			0x0bb9
 #define USB_PID_HAMA_DVBT_HYBRID			0x2758
 #define USB_PID_HANFTEK_UMT_010_COLD			0x0001
 #define USB_PID_HANFTEK_UMT_010_WARM			0x0015
@@ -285,7 +287,6 @@
 #define USB_PID_KWORLD_UB383_T				0xe383
 #define USB_PID_KWORLD_UB499_2T_T09			0xe409
 #define USB_PID_KWORLD_VSTREAM_COLD			0x17de
-#define USB_PID_KWORLD_VSTREAM_WARM			0x17df
 #define USB_PID_KYE_DVB_T_COLD				0x701e
 #define USB_PID_KYE_DVB_T_WARM				0x701f
 #define USB_PID_LITEON_DVB_T_COLD			0xf000
@@ -429,10 +430,14 @@
 #define USB_PID_VISIONPLUS_VP7020_COLD			0x3203
 #define USB_PID_VISIONPLUS_VP7020_WARM			0x3204
 #define USB_PID_VISIONPLUS_VP7021_COLD			0x3207
+#define USB_PID_VISIONPLUS_VP7041_COLD			0x3201
+#define USB_PID_VISIONPLUS_VP7041_WARM			0x3202
 #define USB_PID_VISIONPLUS_VP7045_COLD			0x3205
 #define USB_PID_VISIONPLUS_VP7045_WARM			0x3206
 #define USB_PID_WIDEVIEW_DTT200U_COLD			0x0201
 #define USB_PID_WIDEVIEW_DTT200U_WARM			0x0301
+#define USB_PID_WIDEVIEW_DVBT_USB_COLD			0x0001
+#define USB_PID_WIDEVIEW_DVBT_USB_WARM			0x0002
 #define USB_PID_WIDEVIEW_WT220U_COLD			0x0222
 #define USB_PID_WIDEVIEW_WT220U_FC_COLD 		0x0225
 #define USB_PID_WIDEVIEW_WT220U_FC_WARM 		0x0226
-- 
2.35.1

