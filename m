Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640174EA1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbiC1UsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345704AbiC1Un3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9644E66AD2;
        Mon, 28 Mar 2022 13:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DABFB8121B;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED94BC3411E;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=gaJVK9j4dgU7VRPy0o42lYJiLsQkio1yHZPgSpFfnQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IdKqAdDMeOXOpA7KnlrMUExtyq/yYs1qxXPd0UqRXFe8siG/CMeDqoeWQGtvBa3mE
         N4eWw1YE4pSKrw48mQkiLP86C2qiZ3vD7lWoNnRCbzNn9sdmXDRn9Npd3FvdqaNb2M
         TL3zkMytfldedhzuAH2aWLsyDasAWACcgF2hkk3fSoSssKxzNjb+8+XW0im5tdcGFq
         TA74tdL0I4uD+8zxKuPe08lSATZAI453dsaXK5V2vrnSRcF/eolzADB70X0jBrYLag
         yY0yLdvbLU3h562rbYqW9RmtaES6cMAX8Iafy3WtbEEwmzIk+/zERkdeqHXiNRp760
         cgJvezqSriiqg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lci-IJ; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 14/26] media: dvb-usb: gp8psk: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:26 +0200
Message-Id: <0d32148747df677f0c930605389c12b190c09bdf.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/gp8psk.c | 36 +++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/gp8psk.c b/drivers/media/usb/dvb-usb/gp8psk.c
index b4f661bb5648..b2b27a86dfe5 100644
--- a/drivers/media/usb/dvb-usb/gp8psk.c
+++ b/drivers/media/usb/dvb-usb/gp8psk.c
@@ -310,15 +310,25 @@ static int gp8psk_usb_probe(struct usb_interface *intf,
 	return ret;
 }
 
-static struct usb_device_id gp8psk_usb_table [] = {
-	    { USB_DEVICE(USB_VID_GENPIX, USB_PID_GENPIX_8PSK_REV_1_COLD) },
-	    { USB_DEVICE(USB_VID_GENPIX, USB_PID_GENPIX_8PSK_REV_1_WARM) },
-	    { USB_DEVICE(USB_VID_GENPIX, USB_PID_GENPIX_8PSK_REV_2) },
-	    { USB_DEVICE(USB_VID_GENPIX, USB_PID_GENPIX_SKYWALKER_1) },
-	    { USB_DEVICE(USB_VID_GENPIX, USB_PID_GENPIX_SKYWALKER_2) },
-/*	    { USB_DEVICE(USB_VID_GENPIX, USB_PID_GENPIX_SKYWALKER_CW3K) }, */
-	    { 0 },
+enum {
+	GENPIX_8PSK_REV_1_COLD,
+	GENPIX_8PSK_REV_1_WARM,
+	GENPIX_8PSK_REV_2,
+	GENPIX_SKYWALKER_1,
+	GENPIX_SKYWALKER_2,
+	GENPIX_SKYWALKER_CW3K,
 };
+
+static struct usb_device_id gp8psk_usb_table[] = {
+	DVB_USB_DEV(GENPIX, GENPIX_8PSK_REV_1_COLD),
+	DVB_USB_DEV(GENPIX, GENPIX_8PSK_REV_1_WARM),
+	DVB_USB_DEV(GENPIX, GENPIX_8PSK_REV_2),
+	DVB_USB_DEV(GENPIX, GENPIX_SKYWALKER_1),
+	DVB_USB_DEV(GENPIX, GENPIX_SKYWALKER_2),
+	DVB_USB_DEV(GENPIX, GENPIX_SKYWALKER_CW3K),
+	{ }
+};
+
 MODULE_DEVICE_TABLE(usb, gp8psk_usb_table);
 
 static struct dvb_usb_device_properties gp8psk_properties = {
@@ -355,20 +365,20 @@ static struct dvb_usb_device_properties gp8psk_properties = {
 	.num_device_descs = 4,
 	.devices = {
 		{ .name = "Genpix 8PSK-to-USB2 Rev.1 DVB-S receiver",
-		  .cold_ids = { &gp8psk_usb_table[0], NULL },
-		  .warm_ids = { &gp8psk_usb_table[1], NULL },
+		  .cold_ids = { &gp8psk_usb_table[GENPIX_8PSK_REV_1_COLD], NULL },
+		  .warm_ids = { &gp8psk_usb_table[GENPIX_8PSK_REV_1_WARM], NULL },
 		},
 		{ .name = "Genpix 8PSK-to-USB2 Rev.2 DVB-S receiver",
 		  .cold_ids = { NULL },
-		  .warm_ids = { &gp8psk_usb_table[2], NULL },
+		  .warm_ids = { &gp8psk_usb_table[GENPIX_8PSK_REV_2], NULL },
 		},
 		{ .name = "Genpix SkyWalker-1 DVB-S receiver",
 		  .cold_ids = { NULL },
-		  .warm_ids = { &gp8psk_usb_table[3], NULL },
+		  .warm_ids = { &gp8psk_usb_table[GENPIX_SKYWALKER_1], NULL },
 		},
 		{ .name = "Genpix SkyWalker-2 DVB-S receiver",
 		  .cold_ids = { NULL },
-		  .warm_ids = { &gp8psk_usb_table[4], NULL },
+		  .warm_ids = { &gp8psk_usb_table[GENPIX_SKYWALKER_2], NULL },
 		},
 		{ NULL },
 	}
-- 
2.35.1

