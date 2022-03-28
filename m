Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C44EA1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbiC1Uqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbiC1Un2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D24566ADF;
        Mon, 28 Mar 2022 13:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D845DB81227;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB5AC341C5;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=QiSpOx/mpTl3wUFgHzQUrea+xGFIrXTGCEAo0MWpF4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kNkL3JFe4zb55JL91uziKYv6uLQnt0CAC90hNvzRsN4kxl02M2PbdfdEWgNmGL7X+
         dB7KqMIRYs+eTf4+hc4Z6MmxyVLd++GV3YkThzBe49a0cG+7r860fdKEHu1YopLUgF
         Ip5qvi+dC7N/5j34Se9qtHEksd6ZcWU+tfNYcgXGBkPpxZgbvOsNqWeSdPElJRuKQG
         2eZKStiqXpMIMKNZU876NPsTet/52DkAyMWykPXeV7vuJ5LTuiFXPNlkxKM+9Iu9uX
         nRYlHgeqcOY19JR35iSjq9laNYrb6gJYeoimXoyjslplPYDvTVa9icpmJuaAxp5Q5K
         a3NjW1dpBSIJg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcy-PN; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 18/26] media: dvb-usb: pctv452e: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:30 +0200
Message-Id: <283a8c6bdf9778f832b4f6acc104c06688281668.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/pctv452e.c | 22 ++++++++++++++--------
 include/media/dvb-usb-ids.h          |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/pctv452e.c b/drivers/media/usb/dvb-usb/pctv452e.c
index 9b78b40abc6d..f0794c68c622 100644
--- a/drivers/media/usb/dvb-usb/pctv452e.c
+++ b/drivers/media/usb/dvb-usb/pctv452e.c
@@ -951,13 +951,19 @@ static int pctv452e_tuner_attach(struct dvb_usb_adapter *a)
 	return 0;
 }
 
+enum {
+	PINNACLE_PCTV_452E,
+	TECHNOTREND_CONNECT_S2_3600,
+	TECHNOTREND_CONNECT_S2_3650_CI,
+};
+
 static struct usb_device_id pctv452e_usb_table[] = {
-	{USB_DEVICE(USB_VID_PINNACLE, USB_PID_PCTV_452E)},
-	{USB_DEVICE(USB_VID_TECHNOTREND, USB_PID_TECHNOTREND_CONNECT_S2_3600)},
-	{USB_DEVICE(USB_VID_TECHNOTREND,
-				USB_PID_TECHNOTREND_CONNECT_S2_3650_CI)},
-	{}
+	DVB_USB_DEV(PINNACLE, PINNACLE_PCTV_452E),
+	DVB_USB_DEV(TECHNOTREND, TECHNOTREND_CONNECT_S2_3600),
+	DVB_USB_DEV(TECHNOTREND, TECHNOTREND_CONNECT_S2_3650_CI),
+	{ }
 };
+
 MODULE_DEVICE_TABLE(usb, pctv452e_usb_table);
 
 static struct dvb_usb_device_properties pctv452e_properties = {
@@ -1006,7 +1012,7 @@ static struct dvb_usb_device_properties pctv452e_properties = {
 	.devices = {
 		{ .name = "PCTV HDTV USB",
 		  .cold_ids = { NULL, NULL }, /* this is a warm only device */
-		  .warm_ids = { &pctv452e_usb_table[0], NULL }
+		  .warm_ids = { &pctv452e_usb_table[PINNACLE_PCTV_452E], NULL }
 		},
 		{ NULL },
 	}
@@ -1060,11 +1066,11 @@ static struct dvb_usb_device_properties tt_connect_s2_3600_properties = {
 	.devices = {
 		{ .name = "Technotrend TT Connect S2-3600",
 		  .cold_ids = { NULL, NULL }, /* this is a warm only device */
-		  .warm_ids = { &pctv452e_usb_table[1], NULL }
+		  .warm_ids = { &pctv452e_usb_table[TECHNOTREND_CONNECT_S2_3600], NULL }
 		},
 		{ .name = "Technotrend TT Connect S2-3650-CI",
 		  .cold_ids = { NULL, NULL },
-		  .warm_ids = { &pctv452e_usb_table[2], NULL }
+		  .warm_ids = { &pctv452e_usb_table[TECHNOTREND_CONNECT_S2_3650_CI], NULL }
 		},
 		{ NULL },
 	}
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 6aa15988b577..ed6e37f23cbc 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -314,7 +314,6 @@
 #define USB_PID_PCTV_200E				0x020e
 #define USB_PID_PCTV_400E				0x020f
 #define USB_PID_PCTV_450E				0x0222
-#define USB_PID_PCTV_452E				0x021f
 #define USB_PID_PCTV_78E				0x025a
 #define USB_PID_PCTV_79E				0x0262
 #define USB_PID_PINNACLE_EXPRESSCARD_320CX		0x022e
@@ -330,6 +329,7 @@
 #define USB_PID_PINNACLE_PCTV74E			0x0246
 #define USB_PID_PINNACLE_PCTV801E			0x023a
 #define USB_PID_PINNACLE_PCTV801E_SE			0x023b
+#define USB_PID_PINNACLE_PCTV_452E			0x021f
 #define USB_PID_PINNACLE_PCTV_DUAL_DIVERSITY_DVB_T	0x0229
 #define USB_PID_PINNACLE_PCTV_DVB_T_FLASH		0x0228
 #define USB_PID_PIXELVIEW_SBTVD 			0x5010
-- 
2.35.1

