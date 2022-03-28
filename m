Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF44EA1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbiC1UsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345858AbiC1Un3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB40674C4;
        Mon, 28 Mar 2022 13:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50EF2CE1711;
        Mon, 28 Mar 2022 20:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8540FC341D2;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=uwmpfqv83q2eqh1S6tt2/ceI6eyicR5uJYET2zce/iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRKxiC7aMX6hhhGsN98h8nIV3qGz9ZETcaj2ogXjiPE2YjuHTKXUCigM1pORDVv2Y
         AyXOEFoVCSQcwnRzwsH0pQO25eQUdBewimINBhlf4rsw56gkI2bfzgye3k9ppl+d65
         kQur0Q7Of5Q+1CtYBaV0zNvyiAPkSLE7MLP6ubSGPFCO9MoVKxV43ydP9Mknw/YLgZ
         ZJt6Zdusnyk/F3wRQK/4BbPLNf9k2YzjfA5x9hE+WrIJB01FzSp+9ivQEm2C+ndb4C
         M+yUvRYhwEUqy5kL2s7NOL+vw4tYMW1u0O2LsXNkpGaCMaXKCYHtTYwkPZYlkWS6Nq
         ZYtvxQyvTKC8Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBJ-000ldQ-6u; Mon, 28 Mar 2022 22:41:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        =?UTF-8?q?Benjamin=20St=C3=BCrz?= <benni@stuerz.xyz>
Subject: [PATCH 25/26] media: dvb-usb: dibusb-mc: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:37 +0200
Message-Id: <f1d4fa4960b709152ae693800c830e19a4bc1f48.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/dibusb-mc.c | 88 ++++++++++++++++-----------
 include/media/dvb-usb-ids.h           | 16 ++---
 2 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dibusb-mc.c b/drivers/media/usb/dvb-usb/dibusb-mc.c
index e2689977c8c8..00cb016f6266 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mc.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mc.c
@@ -24,25 +24,45 @@ static int dibusb_mc_probe(struct usb_interface *intf,
 }
 
 /* do not change the order of the ID table */
-static struct usb_device_id dibusb_dib3000mc_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_COLD) },
-/* 01 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_WARM) },
-/* 02 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_COLD) },
-/* 03 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_WARM) }, // ( ? )
-/* 04 */	{ USB_DEVICE(USB_VID_LITEON,		USB_PID_LITEON_DVB_T_COLD) },
-/* 05 */	{ USB_DEVICE(USB_VID_LITEON,		USB_PID_LITEON_DVB_T_WARM) },
-/* 06 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_DIGIVOX_MINI_SL_COLD) },
-/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_DIGIVOX_MINI_SL_WARM) },
-/* 08 */	{ USB_DEVICE(USB_VID_GRANDTEC,          USB_PID_GRANDTEC_DVBT_USB2_COLD) },
-/* 09 */	{ USB_DEVICE(USB_VID_GRANDTEC,          USB_PID_GRANDTEC_DVBT_USB2_WARM) },
-/* 10 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ARTEC_T14_COLD) },
-/* 11 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ARTEC_T14_WARM) },
-/* 12 */	{ USB_DEVICE(USB_VID_LEADTEK,		USB_PID_WINFAST_DTV_DONGLE_COLD) },
-/* 13 */	{ USB_DEVICE(USB_VID_LEADTEK,		USB_PID_WINFAST_DTV_DONGLE_WARM) },
-/* 14 */	{ USB_DEVICE(USB_VID_HUMAX_COEX,	USB_PID_DVB_T_USB_STICK_HIGH_SPEED_COLD) },
-/* 15 */	{ USB_DEVICE(USB_VID_HUMAX_COEX,	USB_PID_DVB_T_USB_STICK_HIGH_SPEED_WARM) },
-			{ }		/* Terminating entry */
+enum {
+	DIBCOM_MOD3001_COLD,
+	DIBCOM_MOD3001_WARM,
+	ULTIMA_TVBOX_USB2_COLD,
+	ULTIMA_TVBOX_USB2_WARM,
+	LITEON_DVB_T_COLD,
+	LITEON_DVB_T_WARM,
+	EMPIA_DIGIVOX_MINI_SL_COLD,
+	EMPIA_DIGIVOX_MINI_SL_WARM,
+	GRANDTEC_DVBT_USB2_COLD,
+	GRANDTEC_DVBT_USB2_WARM,
+	ULTIMA_ARTEC_T14_COLD,
+	ULTIMA_ARTEC_T14_WARM,
+	LEADTEK_WINFAST_DTV_DONGLE_COLD,
+	LEADTEK_WINFAST_DTV_DONGLE_WARM,
+	HUMAX_DVB_T_STICK_HIGH_SPEED_COLD,
+	HUMAX_DVB_T_STICK_HIGH_SPEED_WARM,
 };
+
+static struct usb_device_id dibusb_dib3000mc_table[] = {
+	DVB_USB_DEV(DIBCOM, DIBCOM_MOD3001_COLD),
+	DVB_USB_DEV(DIBCOM, DIBCOM_MOD3001_WARM),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_USB2_COLD),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_TVBOX_USB2_WARM),
+	DVB_USB_DEV(LITEON, LITEON_DVB_T_COLD),
+	DVB_USB_DEV(LITEON, LITEON_DVB_T_WARM),
+	DVB_USB_DEV(EMPIA, EMPIA_DIGIVOX_MINI_SL_COLD),
+	DVB_USB_DEV(EMPIA, EMPIA_DIGIVOX_MINI_SL_WARM),
+	DVB_USB_DEV(GRANDTEC, GRANDTEC_DVBT_USB2_COLD),
+	DVB_USB_DEV(GRANDTEC, GRANDTEC_DVBT_USB2_WARM),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_ARTEC_T14_COLD),
+	DVB_USB_DEV(ULTIMA_ELECTRONIC, ULTIMA_ARTEC_T14_WARM),
+	DVB_USB_DEV(LEADTEK, LEADTEK_WINFAST_DTV_DONGLE_COLD),
+	DVB_USB_DEV(LEADTEK, LEADTEK_WINFAST_DTV_DONGLE_WARM),
+	DVB_USB_DEV(HUMAX_COEX, HUMAX_DVB_T_STICK_HIGH_SPEED_COLD),
+	DVB_USB_DEV(HUMAX_COEX, HUMAX_DVB_T_STICK_HIGH_SPEED_WARM),
+	{ }
+};
+
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mc_table);
 
 static struct dvb_usb_device_properties dibusb_mc_properties = {
@@ -95,37 +115,37 @@ static struct dvb_usb_device_properties dibusb_mc_properties = {
 	.num_device_descs = 8,
 	.devices = {
 		{   "DiBcom USB2.0 DVB-T reference design (MOD3000P)",
-			{ &dibusb_dib3000mc_table[0], NULL },
-			{ &dibusb_dib3000mc_table[1], NULL },
+			{ &dibusb_dib3000mc_table[DIBCOM_MOD3001_COLD], NULL },
+			{ &dibusb_dib3000mc_table[DIBCOM_MOD3001_WARM], NULL },
 		},
 		{   "Artec T1 USB2.0 TVBOX (please check the warm ID)",
-			{ &dibusb_dib3000mc_table[2], NULL },
-			{ &dibusb_dib3000mc_table[3], NULL },
+			{ &dibusb_dib3000mc_table[ULTIMA_TVBOX_USB2_COLD], NULL },
+			{ &dibusb_dib3000mc_table[ULTIMA_TVBOX_USB2_WARM], NULL },
 		},
 		{   "LITE-ON USB2.0 DVB-T Tuner",
 		    /* Also rebranded as Intuix S800, Toshiba */
-			{ &dibusb_dib3000mc_table[4], NULL },
-			{ &dibusb_dib3000mc_table[5], NULL },
+			{ &dibusb_dib3000mc_table[LITEON_DVB_T_COLD], NULL },
+			{ &dibusb_dib3000mc_table[LITEON_DVB_T_WARM], NULL },
 		},
 		{   "MSI Digivox Mini SL",
-			{ &dibusb_dib3000mc_table[6], NULL },
-			{ &dibusb_dib3000mc_table[7], NULL },
+			{ &dibusb_dib3000mc_table[EMPIA_DIGIVOX_MINI_SL_COLD], NULL },
+			{ &dibusb_dib3000mc_table[EMPIA_DIGIVOX_MINI_SL_WARM], NULL },
 		},
 		{   "GRAND - USB2.0 DVB-T adapter",
-			{ &dibusb_dib3000mc_table[8], NULL },
-			{ &dibusb_dib3000mc_table[9], NULL },
+			{ &dibusb_dib3000mc_table[GRANDTEC_DVBT_USB2_COLD], NULL },
+			{ &dibusb_dib3000mc_table[GRANDTEC_DVBT_USB2_WARM], NULL },
 		},
 		{   "Artec T14 - USB2.0 DVB-T",
-			{ &dibusb_dib3000mc_table[10], NULL },
-			{ &dibusb_dib3000mc_table[11], NULL },
+			{ &dibusb_dib3000mc_table[ULTIMA_ARTEC_T14_COLD], NULL },
+			{ &dibusb_dib3000mc_table[ULTIMA_ARTEC_T14_WARM], NULL },
 		},
 		{   "Leadtek - USB2.0 Winfast DTV dongle",
-			{ &dibusb_dib3000mc_table[12], NULL },
-			{ &dibusb_dib3000mc_table[13], NULL },
+			{ &dibusb_dib3000mc_table[LEADTEK_WINFAST_DTV_DONGLE_COLD], NULL },
+			{ &dibusb_dib3000mc_table[LEADTEK_WINFAST_DTV_DONGLE_WARM], NULL },
 		},
 		{   "Humax/Coex DVB-T USB Stick 2.0 High Speed",
-			{ &dibusb_dib3000mc_table[14], NULL },
-			{ &dibusb_dib3000mc_table[15], NULL },
+			{ &dibusb_dib3000mc_table[HUMAX_DVB_T_STICK_HIGH_SPEED_COLD], NULL },
+			{ &dibusb_dib3000mc_table[HUMAX_DVB_T_STICK_HIGH_SPEED_WARM], NULL },
 		},
 		{ NULL },
 	}
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index e4796464b0d7..4dba939760ed 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -111,8 +111,6 @@
 #define USB_PID_ANUBIS_MSI_DIGI_VOX_MINI_II		0x1513
 #define USB_PID_ANYSEE					0x861f
 #define USB_PID_ARTEC_T14BR				0x810f
-#define USB_PID_ARTEC_T14_COLD				0x810b
-#define USB_PID_ARTEC_T14_WARM				0x810c
 #define USB_PID_ASUS_U3000				0x171f
 #define USB_PID_ASUS_U3000H				0x1736
 #define USB_PID_ASUS_U3100				0x173f
@@ -195,12 +193,8 @@
 #define USB_PID_DIBCOM_TFE8096P 			0x1f9C
 #define USB_PID_DIGITALNOW_BLUEBIRD_DUAL_1_COLD 	0xdb54
 #define USB_PID_DIGITALNOW_BLUEBIRD_DUAL_1_WARM 	0xdb55
-#define USB_PID_DIGIVOX_MINI_SL_COLD			0xe360
-#define USB_PID_DIGIVOX_MINI_SL_WARM			0xe361
 #define USB_PID_DPOSH_M9206_COLD			0x9206
 #define USB_PID_DPOSH_M9206_WARM			0xa090
-#define USB_PID_DVB_T_USB_STICK_HIGH_SPEED_COLD 	0x5000
-#define USB_PID_DVB_T_USB_STICK_HIGH_SPEED_WARM 	0x5001
 #define USB_PID_DVICO_BLUEBIRD_DUAL_1_COLD		0xdb50
 #define USB_PID_DVICO_BLUEBIRD_DUAL_1_WARM		0xdb51
 #define USB_PID_DVICO_BLUEBIRD_DUAL_2_COLD		0xdb58
@@ -228,6 +222,8 @@
 #define USB_PID_ELGATO_EYETV_SAT			0x002a
 #define USB_PID_ELGATO_EYETV_SAT_V2			0x0025
 #define USB_PID_ELGATO_EYETV_SAT_V3			0x0036
+#define USB_PID_EMPIA_DIGIVOX_MINI_SL_COLD		0xe360
+#define USB_PID_EMPIA_DIGIVOX_MINI_SL_WARM		0xe361
 #define USB_PID_EMPIA_VSTREAM_COLD			0x17de
 #define USB_PID_EMPIA_VSTREAM_WARM			0x17df
 #define USB_PID_EVOLVEO_XTRATV_STICK			0xa115
@@ -270,6 +266,8 @@
 #define USB_PID_HAUPPAUGE_TIGER_ATSC_B210		0xb210
 #define USB_PID_HAUPPAUGE_WINTV_NOVA_T_USB2_COLD	0x9300
 #define USB_PID_HAUPPAUGE_WINTV_NOVA_T_USB2_WARM	0x9301
+#define USB_PID_HUMAX_DVB_T_STICK_HIGH_SPEED_COLD	0x5000
+#define USB_PID_HUMAX_DVB_T_STICK_HIGH_SPEED_WARM	0x5001
 #define USB_PID_INTEL_CE9500				0x9500
 #define USB_PID_ITETECH_IT9135				0x9135
 #define USB_PID_ITETECH_IT9135_9005			0x9005
@@ -289,6 +287,8 @@
 #define USB_PID_KWORLD_VSTREAM_COLD			0x17de
 #define USB_PID_KYE_DVB_T_COLD				0x701e
 #define USB_PID_KYE_DVB_T_WARM				0x701f
+#define USB_PID_LEADTEK_WINFAST_DTV_DONGLE_COLD 	0x6025
+#define USB_PID_LEADTEK_WINFAST_DTV_DONGLE_WARM 	0x6026
 #define USB_PID_LITEON_DVB_T_COLD			0xf000
 #define USB_PID_LITEON_DVB_T_WARM			0xf001
 #define USB_PID_MEDION_MD95700				0x0932
@@ -412,6 +412,8 @@
 #define USB_PID_TWINHAN_VP7021_WARM			0x3208
 #define USB_PID_TWINHAN_VP7041_COLD			0x3201
 #define USB_PID_TWINHAN_VP7041_WARM			0x3202
+#define USB_PID_ULTIMA_ARTEC_T14_COLD			0x810b
+#define USB_PID_ULTIMA_ARTEC_T14_WARM			0x810c
 #define USB_PID_ULTIMA_TVBOX_AN2235_COLD		0x8107
 #define USB_PID_ULTIMA_TVBOX_AN2235_WARM		0x8108
 #define USB_PID_ULTIMA_TVBOX_ANCHOR_COLD		0x2235
@@ -447,13 +449,11 @@
 #define USB_PID_WIDEVIEW_WT220U_ZL0353_WARM		0x022b
 #define USB_PID_WINFAST_DTV2000DS			0x6a04
 #define USB_PID_WINFAST_DTV2000DS_PLUS			0x6f12
-#define USB_PID_WINFAST_DTV_DONGLE_COLD 		0x6025
 #define USB_PID_WINFAST_DTV_DONGLE_GOLD 		0x6029
 #define USB_PID_WINFAST_DTV_DONGLE_H			0x60f6
 #define USB_PID_WINFAST_DTV_DONGLE_MINID		0x6f0f
 #define USB_PID_WINFAST_DTV_DONGLE_STK7700P		0x6f00
 #define USB_PID_WINFAST_DTV_DONGLE_STK7700P_2		0x6f01
-#define USB_PID_WINFAST_DTV_DONGLE_WARM 		0x6026
 #define USB_PID_WINTV_SOLOHD				0x0264
 #define USB_PID_WINTV_SOLOHD_2				0x8268
 #define USB_PID_XBOX_ONE_TUNER				0x02d5
-- 
2.35.1

