Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566274EA1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbiC1UsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbiC1Un3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B666AF7;
        Mon, 28 Mar 2022 13:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E3C0B8121D;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BF7C341C7;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=WFRIVoaSVGogfWxn6F5H5FzA85zVU7xFddFjRUvhWLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIlAMyM1Zp/U5kaXCpx3RdqljcXRWkCMztLvL3070xMq5VTZ9waWhLiESauRCLIxC
         xAOo10egzA/pnJ/2MyN/MUZH/ZBw7DppOJCIloX0/TSgaOlbjndjbucUuX34avl/xN
         0MEB012p4Un13TaV116xeX8ZVDwEro8XrjD96TJvcW5weDPmq1hqTcsl5h2MKe8yYm
         3TcTbXMUbhkDlyUlIp/xJHYSZd5BXz8l/KbeFM4NYlfLsypjZF0aknmkAgeKg2SEIr
         mr1yS12woguh09Dt+K8J4b+JRrR+ZBeUI/xY1owejbP5njI9nzkHRl81ZafW23Kz03
         GxCMnvxCNxd6Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcq-LC; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 16/26] media: dvb-usb: nova-t-usb2: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:28 +0200
Message-Id: <58f1a356b7b75bbefef3aa07cd99896c446df32f.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/nova-t-usb2.c | 18 ++++++++++++------
 include/media/dvb-usb-ids.h             |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/nova-t-usb2.c b/drivers/media/usb/dvb-usb/nova-t-usb2.c
index 9c0eb0d40822..4782d0780913 100644
--- a/drivers/media/usb/dvb-usb/nova-t-usb2.c
+++ b/drivers/media/usb/dvb-usb/nova-t-usb2.c
@@ -160,11 +160,17 @@ static int nova_t_probe(struct usb_interface *intf,
 }
 
 /* do not change the order of the ID table */
-static struct usb_device_id nova_t_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_HAUPPAUGE,     USB_PID_WINTV_NOVA_T_USB2_COLD) },
-/* 01 */	{ USB_DEVICE(USB_VID_HAUPPAUGE,     USB_PID_WINTV_NOVA_T_USB2_WARM) },
-			{ }		/* Terminating entry */
+enum {
+	HAUPPAUGE_WINTV_NOVA_T_USB2_COLD,
+	HAUPPAUGE_WINTV_NOVA_T_USB2_WARM,
 };
+
+static struct usb_device_id nova_t_table[] = {
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_WINTV_NOVA_T_USB2_COLD),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_WINTV_NOVA_T_USB2_WARM),
+	{ }
+};
+
 MODULE_DEVICE_TABLE(usb, nova_t_table);
 
 static struct dvb_usb_device_properties nova_t_properties = {
@@ -221,8 +227,8 @@ static struct dvb_usb_device_properties nova_t_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "Hauppauge WinTV-NOVA-T usb2",
-			{ &nova_t_table[0], NULL },
-			{ &nova_t_table[1], NULL },
+			{ &nova_t_table[HAUPPAUGE_WINTV_NOVA_T_USB2_COLD], NULL },
+			{ &nova_t_table[HAUPPAUGE_WINTV_NOVA_T_USB2_WARM], NULL },
 		},
 		{ NULL },
 	}
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 10d73c108149..cc1df632d08b 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -267,6 +267,8 @@
 #define USB_PID_HAUPPAUGE_NOVA_T_STICK_3		0x7070
 #define USB_PID_HAUPPAUGE_TIGER_ATSC			0xb200
 #define USB_PID_HAUPPAUGE_TIGER_ATSC_B210		0xb210
+#define USB_PID_HAUPPAUGE_WINTV_NOVA_T_USB2_COLD	0x9300
+#define USB_PID_HAUPPAUGE_WINTV_NOVA_T_USB2_WARM	0x9301
 #define USB_PID_INTEL_CE9500				0x9500
 #define USB_PID_ITETECH_IT9135				0x9135
 #define USB_PID_ITETECH_IT9135_9005			0x9005
@@ -447,8 +449,6 @@
 #define USB_PID_WINFAST_DTV_DONGLE_STK7700P		0x6f00
 #define USB_PID_WINFAST_DTV_DONGLE_STK7700P_2		0x6f01
 #define USB_PID_WINFAST_DTV_DONGLE_WARM 		0x6026
-#define USB_PID_WINTV_NOVA_T_USB2_COLD			0x9300
-#define USB_PID_WINTV_NOVA_T_USB2_WARM			0x9301
 #define USB_PID_WINTV_SOLOHD				0x0264
 #define USB_PID_WINTV_SOLOHD_2				0x8268
 #define USB_PID_XBOX_ONE_TUNER				0x02d5
-- 
2.35.1

