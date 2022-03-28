Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA34EA1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbiC1UqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbiC1UnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130366ACC;
        Mon, 28 Mar 2022 13:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3303F614B3;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9306BC340ED;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=kWgGrhwx6DwAxyD1VMwH9Xw1QxCd/o7nc+h7FA2drrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9h30IAyzmOvqaQe+Wt6s4dtwgekH/Z/c8JIhXUPSJ+SDYT5HEDEQOs1cC55zlbse
         SVH/qG8fVXne/OiVu6hhugpx5C6OztIPtbZ6GRcUITejO7CzojGeMriZ8SNbtmXlLm
         8NQLnrVcDOArEm5eCET0pFrHKEcOgsJIehkEK7LqTLY9IowqM5Qv8+N5rr9ZWSexni
         fsqxtUA943a9Ftd9HQhyFLuEJEbGXf0vTV0iK4Gy5KpcyCDh54ofvWYonZ3rEFo4eC
         e1sPH3ssgrxR7vHinS33phJrmmT0EJxzshcGeXvQ11yNb+tEEFhUEN9nhp+TZBc2m0
         w7VcDuEi6OhBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcG-6t; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 07/26] media: dvb-usb: az6027: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:19 +0200
Message-Id: <65b9775c39dcd21e5cb75a86e1e7b99b7d6eefcd.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/az6027.c | 45 +++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index 86788771175b..cf15988dfb51 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -1080,16 +1080,27 @@ static int az6027_identify_state(struct usb_device *udev,
 }
 
 
+enum {
+	AZUREWAVE_AZ6027,
+	TERRATEC_DVBS2CI_V1,
+	TERRATEC_DVBS2CI_V2,
+	TECHNISAT_USB2_HDCI_V1,
+	TECHNISAT_USB2_HDCI_V2,
+	ELGATO_EYETV_SAT,
+	ELGATO_EYETV_SAT_V2,
+	ELGATO_EYETV_SAT_V3,
+};
+
 static struct usb_device_id az6027_usb_table[] = {
-	{ USB_DEVICE(USB_VID_AZUREWAVE, USB_PID_AZUREWAVE_AZ6027) },
-	{ USB_DEVICE(USB_VID_TERRATEC,  USB_PID_TERRATEC_DVBS2CI_V1) },
-	{ USB_DEVICE(USB_VID_TERRATEC,  USB_PID_TERRATEC_DVBS2CI_V2) },
-	{ USB_DEVICE(USB_VID_TECHNISAT, USB_PID_TECHNISAT_USB2_HDCI_V1) },
-	{ USB_DEVICE(USB_VID_TECHNISAT, USB_PID_TECHNISAT_USB2_HDCI_V2) },
-	{ USB_DEVICE(USB_VID_ELGATO, USB_PID_ELGATO_EYETV_SAT) },
-	{ USB_DEVICE(USB_VID_ELGATO, USB_PID_ELGATO_EYETV_SAT_V2) },
-	{ USB_DEVICE(USB_VID_ELGATO, USB_PID_ELGATO_EYETV_SAT_V3) },
-	{ },
+	DVB_USB_DEV(AZUREWAVE, AZUREWAVE_AZ6027),
+	DVB_USB_DEV(TERRATEC, TERRATEC_DVBS2CI_V1),
+	DVB_USB_DEV(TERRATEC, TERRATEC_DVBS2CI_V2),
+	DVB_USB_DEV(TECHNISAT, TECHNISAT_USB2_HDCI_V1),
+	DVB_USB_DEV(TECHNISAT, TECHNISAT_USB2_HDCI_V2),
+	DVB_USB_DEV(ELGATO, ELGATO_EYETV_SAT),
+	DVB_USB_DEV(ELGATO, ELGATO_EYETV_SAT_V2),
+	DVB_USB_DEV(ELGATO, ELGATO_EYETV_SAT_V3),
+	{ }
 };
 
 MODULE_DEVICE_TABLE(usb, az6027_usb_table);
@@ -1141,35 +1152,35 @@ static struct dvb_usb_device_properties az6027_properties = {
 	.devices = {
 		{
 			.name = "AZUREWAVE DVB-S/S2 USB2.0 (AZ6027)",
-			.cold_ids = { &az6027_usb_table[0], NULL },
+			.cold_ids = { &az6027_usb_table[AZUREWAVE_AZ6027], NULL },
 			.warm_ids = { NULL },
 		}, {
 			.name = "TERRATEC S7",
-			.cold_ids = { &az6027_usb_table[1], NULL },
+			.cold_ids = { &az6027_usb_table[TERRATEC_DVBS2CI_V1], NULL },
 			.warm_ids = { NULL },
 		}, {
 			.name = "TERRATEC S7 MKII",
-			.cold_ids = { &az6027_usb_table[2], NULL },
+			.cold_ids = { &az6027_usb_table[TERRATEC_DVBS2CI_V2], NULL },
 			.warm_ids = { NULL },
 		}, {
 			.name = "Technisat SkyStar USB 2 HD CI",
-			.cold_ids = { &az6027_usb_table[3], NULL },
+			.cold_ids = { &az6027_usb_table[TECHNISAT_USB2_HDCI_V1], NULL },
 			.warm_ids = { NULL },
 		}, {
 			.name = "Technisat SkyStar USB 2 HD CI",
-			.cold_ids = { &az6027_usb_table[4], NULL },
+			.cold_ids = { &az6027_usb_table[TECHNISAT_USB2_HDCI_V2], NULL },
 			.warm_ids = { NULL },
 		}, {
 			.name = "Elgato EyeTV Sat",
-			.cold_ids = { &az6027_usb_table[5], NULL },
+			.cold_ids = { &az6027_usb_table[ELGATO_EYETV_SAT], NULL },
 			.warm_ids = { NULL },
 		}, {
 			.name = "Elgato EyeTV Sat",
-			.cold_ids = { &az6027_usb_table[6], NULL },
+			.cold_ids = { &az6027_usb_table[ELGATO_EYETV_SAT_V2], NULL },
 			.warm_ids = { NULL },
 		}, {
 			.name = "Elgato EyeTV Sat",
-			.cold_ids = { &az6027_usb_table[7], NULL },
+			.cold_ids = { &az6027_usb_table[ELGATO_EYETV_SAT_V3], NULL },
 			.warm_ids = { NULL },
 		},
 		{ NULL },
-- 
2.35.1

