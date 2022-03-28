Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936E74EA1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbiC1UqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345835AbiC1Un3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E07366AE0;
        Mon, 28 Mar 2022 13:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07240CE11B1;
        Mon, 28 Mar 2022 20:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0905EC3411C;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=07zwpGkJy2U+mIT/8Ok5lI+IC6/FPtTmt+ns/fNGoKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Viy7LRjzacq49TV5c6HHxhR3nVMSaTNFamwmeSGYXXCVzg1+BOISe1AEfRYiS9MPG
         F6KQ0pjk0Oa1TYzWcOatmYxcQz2uybTNGkpDkd/WyszbBITV0vlC2jyngb+q7fg/qc
         wIi6JRExFXKfV6xy6+jUlRu01ULjDwWz7HvIp4J5LNDl4NcaIhXrEhlVIBQY8h5sKL
         pi2gYN9xJtyVb5MvtPVEEzsZmK2Sj02LGsUsVf4Pcj3XEGUBhSmWMp/WzqPBXdLgNh
         Wxob+aX2YBy9DmhokVdt2G+DtQgwdOjuP0LQhRY6eirRJS0xnIxWHm8RG8BTLir5I4
         q2f18gqx36qug==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lce-Gz; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 13/26] media: dw2102: use the newer dvb-usb macros for USB device
Date:   Mon, 28 Mar 2022 22:41:25 +0200
Message-Id: <828998ef3f0843bab4e84780e42f8f0802f57be7.1648499509.git.mchehab@kernel.org>
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
use the new macro, and rename some PIDs.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/dw2102.c | 84 ++++++++++++++----------------
 include/media/dvb-usb-ids.h        | 12 ++---
 2 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 33643fb88265..0ca764282c76 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -1771,10 +1771,10 @@ enum dw2102_table_entry {
 	PROF_7500,
 	GENIATECH_SU3000,
 	HAUPPAUGE_MAX_S2,
-	TERRATEC_CINERGY_S2,
+	TERRATEC_CINERGY_S2_R1,
 	TEVII_S480_1,
 	TEVII_S480_2,
-	X3M_SPC1400HD,
+	GENIATECH_X3M_SPC1400HD,
 	TEVII_S421,
 	TEVII_S632,
 	TERRATEC_CINERGY_S2_R2,
@@ -1784,7 +1784,7 @@ enum dw2102_table_entry {
 	TERRATEC_CINERGY_S2_2,
 	GOTVIEW_SAT_HD,
 	GENIATECH_T220,
-	TECHNOTREND_S2_4600,
+	TECHNOTREND_CONNECT_S2_4600,
 	TEVII_S482_1,
 	TEVII_S482_2,
 	TERRATEC_CINERGY_S2_BOX,
@@ -1792,42 +1792,36 @@ enum dw2102_table_entry {
 };
 
 static struct usb_device_id dw2102_table[] = {
-	[CYPRESS_DW2102] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW2102)},
-	[CYPRESS_DW2101] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW2101)},
-	[CYPRESS_DW2104] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW2104)},
-	[TEVII_S650] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S650)},
-	[TERRATEC_CINERGY_S] = {USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_S)},
-	[CYPRESS_DW3101] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW3101)},
-	[TEVII_S630] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S630)},
-	[PROF_1100] = {USB_DEVICE(USB_VID_PROF_1, USB_PID_PROF_1100)},
-	[TEVII_S660] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S660)},
-	[PROF_7500] = {USB_DEVICE(USB_VID_PROF_2, USB_PID_PROF_7500)},
-	[GENIATECH_SU3000] = {USB_DEVICE(USB_VID_GTEK, USB_PID_GENIATECH_SU3000)},
-	[HAUPPAUGE_MAX_S2] = {USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_MAX_S2)},
-	[TERRATEC_CINERGY_S2] = {USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_S2_R1)},
-	[TEVII_S480_1] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S480_1)},
-	[TEVII_S480_2] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S480_2)},
-	[X3M_SPC1400HD] = {USB_DEVICE(USB_VID_GTEK, USB_PID_GENIATECH_X3M_SPC1400HD)},
-	[TEVII_S421] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S421)},
-	[TEVII_S632] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S632)},
-	[TERRATEC_CINERGY_S2_R2] = {USB_DEVICE(USB_VID_TERRATEC,
-				    USB_PID_TERRATEC_CINERGY_S2_R2)},
-	[TERRATEC_CINERGY_S2_R3] = {USB_DEVICE(USB_VID_TERRATEC,
-				    USB_PID_TERRATEC_CINERGY_S2_R3)},
-	[TERRATEC_CINERGY_S2_R4] = {USB_DEVICE(USB_VID_TERRATEC,
-				    USB_PID_TERRATEC_CINERGY_S2_R4)},
-	[TERRATEC_CINERGY_S2_1] = {USB_DEVICE(USB_VID_TERRATEC_2,
-				   USB_PID_TERRATEC_CINERGY_S2_1)},
-	[TERRATEC_CINERGY_S2_2] = {USB_DEVICE(USB_VID_TERRATEC_2,
-				   USB_PID_TERRATEC_CINERGY_S2_2)},
-	[GOTVIEW_SAT_HD] = {USB_DEVICE(USB_VID_GOTVIEW, USB_PID_GOTVIEW_SAT_HD)},
-	[GENIATECH_T220] = {USB_DEVICE(USB_VID_GTEK, USB_PID_GENIATECH_T220)},
-	[TECHNOTREND_S2_4600] = {USB_DEVICE(USB_VID_TECHNOTREND,
-		USB_PID_TECHNOTREND_CONNECT_S2_4600)},
-	[TEVII_S482_1] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TTEVII_S482_1)},
-	[TEVII_S482_2] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TTEVII_S482_2)},
-	[TERRATEC_CINERGY_S2_BOX] = {USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_S2_BOX)},
-	[TEVII_S662] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S662)},
+	DVB_USB_DEV(CYPRESS, CYPRESS_DW2102),
+	DVB_USB_DEV(CYPRESS, CYPRESS_DW2101),
+	DVB_USB_DEV(CYPRESS, CYPRESS_DW2104),
+	DVB_USB_DEV(TEVII, TEVII_S650),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_S),
+	DVB_USB_DEV(CYPRESS, CYPRESS_DW3101),
+	DVB_USB_DEV(TEVII, TEVII_S630),
+	DVB_USB_DEV(PROF_1, PROF_1100),
+	DVB_USB_DEV(TEVII, TEVII_S660),
+	DVB_USB_DEV(PROF_2, PROF_7500),
+	DVB_USB_DEV(GTEK, GENIATECH_SU3000),
+	DVB_USB_DEV(HAUPPAUGE, HAUPPAUGE_MAX_S2),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_S2_R1),
+	DVB_USB_DEV(TEVII, TEVII_S480_1),
+	DVB_USB_DEV(TEVII, TEVII_S480_2),
+	DVB_USB_DEV(GTEK, GENIATECH_X3M_SPC1400HD),
+	DVB_USB_DEV(TEVII, TEVII_S421),
+	DVB_USB_DEV(TEVII, TEVII_S632),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_S2_R2),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_S2_R3),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_S2_R4),
+	DVB_USB_DEV(TERRATEC_2, TERRATEC_CINERGY_S2_1),
+	DVB_USB_DEV(TERRATEC_2, TERRATEC_CINERGY_S2_2),
+	DVB_USB_DEV(GOTVIEW, GOTVIEW_SAT_HD),
+	DVB_USB_DEV(GTEK, GENIATECH_T220),
+	DVB_USB_DEV(TECHNOTREND, TECHNOTREND_CONNECT_S2_4600),
+	DVB_USB_DEV(TEVII, TEVII_S482_1),
+	DVB_USB_DEV(TEVII, TEVII_S482_2),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_S2_BOX),
+	DVB_USB_DEV(TEVII, TEVII_S662),
 	{ }
 };
 
@@ -1889,18 +1883,18 @@ static int dw2102_load_firmware(struct usb_device *dev,
 		case USB_PID_TEVII_S650:
 			dw2104_properties.rc.core.rc_codes = RC_MAP_TEVII_NEC;
 			fallthrough;
-		case USB_PID_DW2104:
+		case USB_PID_CYPRESS_DW2104:
 			reset = 1;
 			dw210x_op_rw(dev, 0xc4, 0x0000, 0, &reset, 1,
 					DW210X_WRITE_MSG);
 			fallthrough;
-		case USB_PID_DW3101:
+		case USB_PID_CYPRESS_DW3101:
 			reset = 0;
 			dw210x_op_rw(dev, 0xbf, 0x0040, 0, &reset, 0,
 					DW210X_WRITE_MSG);
 			break;
 		case USB_PID_TERRATEC_CINERGY_S:
-		case USB_PID_DW2102:
+		case USB_PID_CYPRESS_DW2102:
 			dw210x_op_rw(dev, 0xbf, 0x0040, 0, &reset, 0,
 					DW210X_WRITE_MSG);
 			dw210x_op_rw(dev, 0xb9, 0x0000, 0, &reset16[0], 2,
@@ -2350,11 +2344,11 @@ static struct dvb_usb_device_properties su3000_properties = {
 			{ NULL },
 		},
 		{ "Terratec Cinergy S2 USB HD",
-			{ &dw2102_table[TERRATEC_CINERGY_S2], NULL },
+			{ &dw2102_table[TERRATEC_CINERGY_S2_R1], NULL },
 			{ NULL },
 		},
 		{ "X3M TV SPC1400HD PCI",
-			{ &dw2102_table[X3M_SPC1400HD], NULL },
+			{ &dw2102_table[GENIATECH_X3M_SPC1400HD], NULL },
 			{ NULL },
 		},
 		{ "Terratec Cinergy S2 USB HD Rev.2",
@@ -2525,7 +2519,7 @@ static struct dvb_usb_device_properties tt_s2_4600_properties = {
 	.num_device_descs = 5,
 	.devices = {
 		{ "TechnoTrend TT-connect S2-4600",
-			{ &dw2102_table[TECHNOTREND_S2_4600], NULL },
+			{ &dw2102_table[TECHNOTREND_CONNECT_S2_4600], NULL },
 			{ NULL },
 		},
 		{ "TeVii S482 (tuner 1)",
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 66a5b2045552..e41902d06ccc 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -160,6 +160,10 @@
 #define USB_PID_CPYTO_REDI_PC50A			0xa803
 #define USB_PID_CREATIX_CTX1921 			0x1921
 #define USB_PID_CTVDIGDUAL_V2				0xe410
+#define USB_PID_CYPRESS_DW2101				0x2101
+#define USB_PID_CYPRESS_DW2102				0x2102
+#define USB_PID_CYPRESS_DW2104				0x2104
+#define USB_PID_CYPRESS_DW3101				0x3101
 #define USB_PID_DELOCK_USB2_DVBT			0xb803
 #define USB_PID_DIBCOM_ANCHOR_2135_COLD 		0x2131
 #define USB_PID_DIBCOM_HOOK_DEFAULT			0x0064
@@ -211,10 +215,6 @@
 #define USB_PID_DVICO_BLUEBIRD_LGZ201_WARM		0xdb01
 #define USB_PID_DVICO_BLUEBIRD_TH7579_COLD		0xdb10
 #define USB_PID_DVICO_BLUEBIRD_TH7579_WARM		0xdb11
-#define USB_PID_DW2101					0x2101
-#define USB_PID_DW2102					0x2102
-#define USB_PID_DW2104					0x2104
-#define USB_PID_DW3101					0x3101
 #define USB_PID_E3C_EC168				0x1689
 #define USB_PID_E3C_EC168_2				0xfffa
 #define USB_PID_E3C_EC168_3				0xfffb
@@ -394,6 +394,8 @@
 #define USB_PID_TEVII_S421				0xd421
 #define USB_PID_TEVII_S480_1				0xd481
 #define USB_PID_TEVII_S480_2				0xd482
+#define USB_PID_TEVII_S482_1				0xd483
+#define USB_PID_TEVII_S482_2				0xd484
 #define USB_PID_TEVII_S630				0xd630
 #define USB_PID_TEVII_S632				0xd632
 #define USB_PID_TEVII_S650				0xd650
@@ -404,8 +406,6 @@
 #define USB_PID_TINYTWIN_3				0x9016
 #define USB_PID_TREKSTOR_DVBT				0x901b
 #define USB_PID_TREKSTOR_TERRES_2_0			0xC803
-#define USB_PID_TTEVII_S482_1				0xd483
-#define USB_PID_TTEVII_S482_2				0xd484
 #define USB_PID_TURBOX_DTT_2000 			0xd3a4
 #define USB_PID_TVWAY_PLUS				0x0002
 #define USB_PID_TWINHAN_VP7020_COLD			0x3203
-- 
2.35.1

