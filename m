Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B34EA1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbiC1UqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345855AbiC1Un3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1DF66ADB;
        Mon, 28 Mar 2022 13:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E56E4B81223;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BD5C34112;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=igf1YSCCBjkuVabykAkqPLeWrSFcFzZevr9yX0NS45c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lk01mu3g9AAyWFT1QH3Bwy9bYT9/mLtTIeYWEflJc8FMdys2FP8ipBHBT6avsSvW9
         0Cl0LDOWmJ3xfOQpvAKjTX1WxkVN+2iaYi6sDZopawJmq9k1fYThVHVbLDzAaeM9UG
         Uded8KMrWKUoNKR4fyQ22q2Q6b70uURXNU5vIoBOzlrzkGINaVwbAuboxEJyQkMytZ
         EKZ4J9bMUQKfmb2bccnmyM5MNw9yrU9O1GcaPZOFGEjTWnw8Vtw5+kEE8SH4XO7TUy
         1WOGuHTDf0UEBOHN2h3swOE4BRFiWT2P2r7pssHHi6axkAIF45kGKLz9fS9s7wDuJm
         HcR+1NndqF6TQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBJ-000ldI-32; Mon, 28 Mar 2022 22:41:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 23/26] media: dvb-usb: vp7045: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:35 +0200
Message-Id: <0241bf842bf592dfa01b0ef4916afda396194f98.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/vp7045.c | 28 ++++++++++++++++++----------
 include/media/dvb-usb-ids.h        |  8 ++++----
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/vp7045.c b/drivers/media/usb/dvb-usb/vp7045.c
index 23e3a90af1f4..1dc2b18d44d8 100644
--- a/drivers/media/usb/dvb-usb/vp7045.c
+++ b/drivers/media/usb/dvb-usb/vp7045.c
@@ -172,13 +172,21 @@ static int vp7045_usb_probe(struct usb_interface *intf,
 				   THIS_MODULE, NULL, adapter_nr);
 }
 
-static struct usb_device_id vp7045_usb_table [] = {
-	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7045_COLD) },
-	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7045_WARM) },
-	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_DNTV_TINYUSB2_COLD) },
-	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_DNTV_TINYUSB2_WARM) },
-	    { 0 },
+enum {
+	VISIONPLUS_VP7045_COLD,
+	VISIONPLUS_VP7045_WARM,
+	VISIONPLUS_TINYUSB2_COLD,
+	VISIONPLUS_TINYUSB2_WARM,
 };
+
+static struct usb_device_id vp7045_usb_table[] = {
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_VP7045_COLD),
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_VP7045_WARM),
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_TINYUSB2_COLD),
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_TINYUSB2_WARM),
+	{ }
+};
+
 MODULE_DEVICE_TABLE(usb, vp7045_usb_table);
 
 static struct dvb_usb_device_properties vp7045_properties = {
@@ -221,12 +229,12 @@ static struct dvb_usb_device_properties vp7045_properties = {
 	.num_device_descs = 2,
 	.devices = {
 		{ .name = "Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II)",
-		  .cold_ids = { &vp7045_usb_table[0], NULL },
-		  .warm_ids = { &vp7045_usb_table[1], NULL },
+		  .cold_ids = { &vp7045_usb_table[VISIONPLUS_VP7045_COLD], NULL },
+		  .warm_ids = { &vp7045_usb_table[VISIONPLUS_VP7045_WARM], NULL },
 		},
 		{ .name = "DigitalNow TinyUSB 2 DVB-t Receiver",
-		  .cold_ids = { &vp7045_usb_table[2], NULL },
-		  .warm_ids = { &vp7045_usb_table[3], NULL },
+		  .cold_ids = { &vp7045_usb_table[VISIONPLUS_TINYUSB2_COLD], NULL },
+		  .warm_ids = { &vp7045_usb_table[VISIONPLUS_TINYUSB2_WARM], NULL },
 		},
 		{ NULL },
 	}
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index e022e38b6f95..9f53b3ce3e58 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -199,8 +199,6 @@
 #define USB_PID_DIGITALNOW_BLUEBIRD_DUAL_1_WARM 	0xdb55
 #define USB_PID_DIGIVOX_MINI_SL_COLD			0xe360
 #define USB_PID_DIGIVOX_MINI_SL_WARM			0xe361
-#define USB_PID_DNTV_TINYUSB2_COLD			0x3223
-#define USB_PID_DNTV_TINYUSB2_WARM			0x3224
 #define USB_PID_DPOSH_M9206_COLD			0x9206
 #define USB_PID_DPOSH_M9206_WARM			0xa090
 #define USB_PID_DVB_T_USB_STICK_HIGH_SPEED_COLD 	0x5000
@@ -413,8 +411,6 @@
 #define USB_PID_TWINHAN_VP7021_WARM			0x3208
 #define USB_PID_TWINHAN_VP7041_COLD			0x3201
 #define USB_PID_TWINHAN_VP7041_WARM			0x3202
-#define USB_PID_TWINHAN_VP7045_COLD			0x3205
-#define USB_PID_TWINHAN_VP7045_WARM			0x3206
 #define USB_PID_ULTIMA_TVBOX_AN2235_COLD		0x8107
 #define USB_PID_ULTIMA_TVBOX_AN2235_WARM		0x8108
 #define USB_PID_ULTIMA_TVBOX_ANCHOR_COLD		0x2235
@@ -428,9 +424,13 @@
 #define USB_PID_UNK_HYPER_PALTEK_COLD			0x005e
 #define USB_PID_UNK_HYPER_PALTEK_WARM			0x005f
 #define USB_PID_VISIONPLUS_PINNACLE_PCTV310E		0x3211
+#define USB_PID_VISIONPLUS_TINYUSB2_COLD		0x3223
+#define USB_PID_VISIONPLUS_TINYUSB2_WARM		0x3224
 #define USB_PID_VISIONPLUS_VP7020_COLD			0x3203
 #define USB_PID_VISIONPLUS_VP7020_WARM			0x3204
 #define USB_PID_VISIONPLUS_VP7021_COLD			0x3207
+#define USB_PID_VISIONPLUS_VP7045_COLD			0x3205
+#define USB_PID_VISIONPLUS_VP7045_WARM			0x3206
 #define USB_PID_WIDEVIEW_DTT200U_COLD			0x0201
 #define USB_PID_WIDEVIEW_DTT200U_WARM			0x0301
 #define USB_PID_WIDEVIEW_WT220U_COLD			0x0222
-- 
2.35.1

