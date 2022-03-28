Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85804EA1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbiC1UrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbiC1Un1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF92674F2;
        Mon, 28 Mar 2022 13:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06B20614E3;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C83C341D7;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=h89cfelz2LoOVPJ++EYo2rokl1PZCZwdioQY5oDs0jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mncQNsopHGARXBmEbvScuQOrOUaPSXxgZkTC1o5UPQrkLHVkFzLRZ28EdfXB2iMrw
         L+HIdqR8y7mvdBQP/V3cIlc1frCGKHvie8LvHUchW7sflgyGAbR3+/XqOAfUHNaIHJ
         uHMAXmGrNFV78RBpRNjTddFUkSFKjoZfakvNuHn8XYekvCgSmu8itNAGpccXVrYd9M
         F/tRbx08WrqX7ZEaebJh83qB2DSWbI3qbH/+CoRjEZza0AD6d8BU3LjZLpTyVv0sc2
         WAkL9J3EmCTw1k73N7vtZ6c1Wn5mh36Z5muhW2rWIm8/zvR1yehYItevMIw3zJCU06
         3sm8kpXUnavTg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcS-Bv; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 10/26] media: digitv: use the newer dvb-usb macros for USB device
Date:   Mon, 28 Mar 2022 22:41:22 +0200
Message-Id: <68de8820a361e61c25bf7402acac71b3770ff906.1648499509.git.mchehab@kernel.org>
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

In order to make the drivers under dvb-usb more homogeneous,
use the new macro.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/digitv.c | 13 +++++++++----
 include/media/dvb-usb-ids.h        |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/digitv.c b/drivers/media/usb/dvb-usb/digitv.c
index 4e3b3c064bcf..2756815a780b 100644
--- a/drivers/media/usb/dvb-usb/digitv.c
+++ b/drivers/media/usb/dvb-usb/digitv.c
@@ -291,10 +291,15 @@ static int digitv_probe(struct usb_interface *intf,
 	return ret;
 }
 
-static struct usb_device_id digitv_table [] = {
-		{ USB_DEVICE(USB_VID_ANCHOR, USB_PID_NEBULA_DIGITV) },
-		{ }		/* Terminating entry */
+enum {
+	ANCHOR_NEBULA_DIGITV,
 };
+
+static struct usb_device_id digitv_table[] = {
+	DVB_USB_DEV(ANCHOR, ANCHOR_NEBULA_DIGITV),
+	{ }
+};
+
 MODULE_DEVICE_TABLE (usb, digitv_table);
 
 static struct dvb_usb_device_properties digitv_properties = {
@@ -343,7 +348,7 @@ static struct dvb_usb_device_properties digitv_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "Nebula Electronics uDigiTV DVB-T USB2.0)",
-			{ &digitv_table[0], NULL },
+			{ &digitv_table[ANCHOR_NEBULA_DIGITV], NULL },
 			{ NULL },
 		},
 		{ NULL },
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index 5ae55c20912e..c3bea2bf9dda 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -104,6 +104,7 @@
 #define USB_PID_AFATECH_AF9035_9035			0x9035
 #define USB_PID_ALINK_DTU				0xf170
 #define USB_PID_AME_DTV5100				0xa232
+#define USB_PID_ANCHOR_NEBULA_DIGITV			0x0201
 #define USB_PID_ANSONIC_DVBT_USB			0x6000
 #define USB_PID_ANYSEE					0x861f
 #define USB_PID_ARTEC_T14BR				0x810f
@@ -301,7 +302,6 @@
 #define USB_PID_MYGICA_T230C2				0xc68a
 #define USB_PID_MYGICA_T230C2_LITE			0xc69a
 #define USB_PID_MYGICA_T230C_LITE			0xc699
-#define USB_PID_NEBULA_DIGITV				0x0201
 #define USB_PID_NOXON_DAB_STICK 			0x00b3
 #define USB_PID_NOXON_DAB_STICK_REV2			0x00e0
 #define USB_PID_NOXON_DAB_STICK_REV3			0x00b4
-- 
2.35.1

