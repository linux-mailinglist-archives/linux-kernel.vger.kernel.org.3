Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39234EA1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346410AbiC1Usi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345669AbiC1Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F766AF9;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67A7614D5;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B88BC34114;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=3tg7B9x/wxtfuW/7G4mrwEGudjd4r9ULAoYGJZgmVMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5itQDMP8KUCEpRvGltYDEUHRzcp4QZw7KJXOa50fwIqUR/YyoC/rZBWM7LT+qe8u
         t8y5pjV2P0bhGb27z54KdIJqLMOD+jDK8HTKGAm/MvvjYzmQgL21pq/LC/iEr9Q6gI
         +AffmyG9jPGrvZIju4s7cM8ztfOOKjabKFOP+387tcDwlOwer+kLlaXJUnkFChcJab
         O0y2E/t4mSqJt7KtCvSxN6gmxOD2t382AYh6GiChk4HYxyypiZW/KwSesPWs9LwyXC
         svZ4uVbMZBHrJnrFSHGamtCa+YP64mUM/U/qPsdSFfneTuGpmN4Y5Y9QIJlPE6ma6w
         bdKWLQPBtpxVQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBJ-000ldE-0k; Mon, 28 Mar 2022 22:41:41 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 22/26] media: dvb-usb: vp702x: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:34 +0200
Message-Id: <13bf6aab3909fae5da4c9a24c114b15e76abd146.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/vp702x.c | 23 +++++++++++++++--------
 include/media/dvb-usb-ids.h        |  6 +++---
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/vp702x.c b/drivers/media/usb/dvb-usb/vp702x.c
index 8e9e3b494367..5b6740cbd1d1 100644
--- a/drivers/media/usb/dvb-usb/vp702x.c
+++ b/drivers/media/usb/dvb-usb/vp702x.c
@@ -369,12 +369,19 @@ static void vp702x_usb_disconnect(struct usb_interface *intf)
 	dvb_usb_device_exit(intf);
 }
 
-static struct usb_device_id vp702x_usb_table [] = {
-	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7021_COLD) },
-//	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7020_COLD) },
-//	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7020_WARM) },
-	    { 0 },
+enum {
+	VISIONPLUS_VP7021_COLD,
+	VISIONPLUS_VP7020_COLD,
+	VISIONPLUS_VP7020_WARM,
 };
+
+static struct usb_device_id vp702x_usb_table[] = {
+	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_VP7021_COLD),
+//	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_VP7020_COLD),
+//	DVB_USB_DEV(VISIONPLUS, VISIONPLUS_VP7020_WARM),
+	{ }
+};
+
 MODULE_DEVICE_TABLE(usb, vp702x_usb_table);
 
 static struct dvb_usb_device_properties vp702x_properties = {
@@ -421,12 +428,12 @@ static struct dvb_usb_device_properties vp702x_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{ .name = "TwinhanDTV StarBox DVB-S USB2.0 (VP7021)",
-		  .cold_ids = { &vp702x_usb_table[0], NULL },
+		  .cold_ids = { &vp702x_usb_table[VISIONPLUS_VP7021_COLD], NULL },
 		  .warm_ids = { NULL },
 		},
 /*		{ .name = "TwinhanDTV StarBox DVB-S USB2.0 (VP7020)",
-		  .cold_ids = { &vp702x_usb_table[1], NULL },
-		  .warm_ids = { &vp702x_usb_table[2], NULL },
+		  .cold_ids = { &vp702x_usb_table[VISIONPLUS_VP7020_COLD], NULL },
+		  .warm_ids = { &vp702x_usb_table[VISIONPLUS_VP7020_WARM], NULL },
 		},
 */		{ NULL },
 	}
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 0fad68bfe6f9..e022e38b6f95 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -410,9 +410,6 @@
 #define USB_PID_TREKSTOR_TERRES_2_0			0xC803
 #define USB_PID_TURBOX_DTT_2000 			0xd3a4
 #define USB_PID_TVWAY_PLUS				0x0002
-#define USB_PID_TWINHAN_VP7020_COLD			0x3203
-#define USB_PID_TWINHAN_VP7020_WARM			0x3204
-#define USB_PID_TWINHAN_VP7021_COLD			0x3207
 #define USB_PID_TWINHAN_VP7021_WARM			0x3208
 #define USB_PID_TWINHAN_VP7041_COLD			0x3201
 #define USB_PID_TWINHAN_VP7041_WARM			0x3202
@@ -431,6 +428,9 @@
 #define USB_PID_UNK_HYPER_PALTEK_COLD			0x005e
 #define USB_PID_UNK_HYPER_PALTEK_WARM			0x005f
 #define USB_PID_VISIONPLUS_PINNACLE_PCTV310E		0x3211
+#define USB_PID_VISIONPLUS_VP7020_COLD			0x3203
+#define USB_PID_VISIONPLUS_VP7020_WARM			0x3204
+#define USB_PID_VISIONPLUS_VP7021_COLD			0x3207
 #define USB_PID_WIDEVIEW_DTT200U_COLD			0x0201
 #define USB_PID_WIDEVIEW_DTT200U_WARM			0x0301
 #define USB_PID_WIDEVIEW_WT220U_COLD			0x0222
-- 
2.35.1

