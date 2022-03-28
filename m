Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFD4EA1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbiC1Url (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbiC1Un1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC297674D9;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 938C7B81216;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA30C34119;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=te/M1UTj81BvKZCC2zuYT5VpjeocWG1s6x8tx6Kb9iM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nePC87bXf2SP1a6xaFbDsN5Erad8LqABDr4yKplf0wVnVu5bAqj42iB0s0PAG9/3q
         zh2ZpdpKjJtqEPshj3G6qLKADySSCaWvgTzTqebD5dHj54e9xn6lZwl9JXO16ilY/0
         MpVTGvzvewMO8PIIN0B7tDRNxGC2Xg20vS1eOT+G3FTro8+6ukwvatQyD6eyl9ntoW
         OfIUNx0NVrkE9hbfh694WgnuDDx2e/uQXRRqvGKpNKUxYlctQ+MdicO+qigQf9mzxE
         p5m1W/ruD+p6hfFa+m3mjacffUxGOMepQP0TpcTBYttBHuzWuHMlHr61w0OKwuUHV3
         KmFQifC6ZmOVg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcO-AV; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 09/26] media: cxusb: use the newer dvb-usb macros for USB device
Date:   Mon, 28 Mar 2022 22:41:21 +0200
Message-Id: <bd1e61664e234252de3dfac16aab8bfc35b7bcd7.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
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

In order to make the drivers under dvb-usb more homogeneous,
use the new macro.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/cxusb.c | 88 ++++++++-----------------------
 1 file changed, 23 insertions(+), 65 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/cxusb.c b/drivers/media/usb/dvb-usb/cxusb.c
index 265b960db499..1d98d3465e28 100644
--- a/drivers/media/usb/dvb-usb/cxusb.c
+++ b/drivers/media/usb/dvb-usb/cxusb.c
@@ -1692,72 +1692,30 @@ static void cxusb_disconnect(struct usb_interface *intf)
 	dvb_usb_device_exit(intf);
 }
 
-static struct usb_device_id cxusb_table[NR__cxusb_table_index + 1] = {
-	[MEDION_MD95700] = {
-		USB_DEVICE(USB_VID_MEDION, USB_PID_MEDION_MD95700)
-	},
-	[DVICO_BLUEBIRD_LG064F_COLD] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_LG064F_COLD)
-	},
-	[DVICO_BLUEBIRD_LG064F_WARM] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_LG064F_WARM)
-	},
-	[DVICO_BLUEBIRD_DUAL_1_COLD] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_DUAL_1_COLD)
-	},
-	[DVICO_BLUEBIRD_DUAL_1_WARM] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_DUAL_1_WARM)
-	},
-	[DVICO_BLUEBIRD_LGZ201_COLD] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_LGZ201_COLD)
-	},
-	[DVICO_BLUEBIRD_LGZ201_WARM] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_LGZ201_WARM)
-	},
-	[DVICO_BLUEBIRD_TH7579_COLD] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_TH7579_COLD)
-	},
-	[DVICO_BLUEBIRD_TH7579_WARM] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_TH7579_WARM)
-	},
-	[DIGITALNOW_BLUEBIRD_DUAL_1_COLD] = {
-		USB_DEVICE(USB_VID_DVICO,
-			   USB_PID_DIGITALNOW_BLUEBIRD_DUAL_1_COLD)
-	},
-	[DIGITALNOW_BLUEBIRD_DUAL_1_WARM] = {
-		USB_DEVICE(USB_VID_DVICO,
-			   USB_PID_DIGITALNOW_BLUEBIRD_DUAL_1_WARM)
-	},
-	[DVICO_BLUEBIRD_DUAL_2_COLD] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_DUAL_2_COLD)
-	},
-	[DVICO_BLUEBIRD_DUAL_2_WARM] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_DUAL_2_WARM)
-	},
-	[DVICO_BLUEBIRD_DUAL_4] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_DUAL_4)
-	},
-	[DVICO_BLUEBIRD_DVB_T_NANO_2] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_DVB_T_NANO_2)
-	},
-	[DVICO_BLUEBIRD_DVB_T_NANO_2_NFW_WARM] = {
-		USB_DEVICE(USB_VID_DVICO,
-			   USB_PID_DVICO_BLUEBIRD_DVB_T_NANO_2_NFW_WARM)
-	},
-	[AVERMEDIA_VOLAR_A868R] = {
-		USB_DEVICE(USB_VID_AVERMEDIA, USB_PID_AVERMEDIA_VOLAR_A868R)
-	},
-	[DVICO_BLUEBIRD_DUAL_4_REV_2] = {
-		USB_DEVICE(USB_VID_DVICO, USB_PID_DVICO_BLUEBIRD_DUAL_4_REV_2)
-	},
-	[CONEXANT_D680_DMB] = {
-		USB_DEVICE(USB_VID_CONEXANT, USB_PID_CONEXANT_D680_DMB)
-	},
-	[MYGICA_D689] = {
-		USB_DEVICE(USB_VID_CONEXANT, USB_PID_MYGICA_D689)
-	},
-	{}		/* Terminating entry */
+static struct usb_device_id cxusb_table[] = {
+	DVB_USB_DEV(MEDION, MEDION_MD95700),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_LG064F_COLD),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_LG064F_WARM),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DUAL_1_COLD),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DUAL_1_WARM),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_LGZ201_COLD),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_LGZ201_WARM),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_TH7579_COLD),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_TH7579_WARM),
+	DVB_USB_DEV(DVICO, DIGITALNOW_BLUEBIRD_DUAL_1_COLD),
+	DVB_USB_DEV(DVICO, DIGITALNOW_BLUEBIRD_DUAL_1_WARM),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DUAL_2_COLD),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DUAL_2_WARM),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DUAL_4),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DVB_T_NANO_2),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DVB_T_NANO_2_NFW_WARM),
+	DVB_USB_DEV(AVERMEDIA, AVERMEDIA_VOLAR_A868R),
+	DVB_USB_DEV(DVICO, DVICO_BLUEBIRD_DUAL_4_REV_2),
+	DVB_USB_DEV(CONEXANT, CONEXANT_D680_DMB),
+	DVB_USB_DEV(CONEXANT, MYGICA_D689),
+	{ }
 };
+
 MODULE_DEVICE_TABLE(usb, cxusb_table);
 
 static struct dvb_usb_device_properties cxusb_medion_properties = {
-- 
2.35.1

