Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA72A4EA1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346283AbiC1Us1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbiC1Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BD366AF7;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7567B81213;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75ECC34111;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=dxOGR/DJv+ktdWiQTmecLhQ3kvCEs9EGdMO3bsnvbVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxOsfq8tLsZgSJdcdcJDaI2CWxZJfsbXyhcTcnA9xnFmu+itMojkbLSY+87cXcW8C
         zjpz+5c8+EnUUjkc2l8N9n+kPtClIyIXxrMfEbbNw6Pn4mMd5jUUOyZaK/aZxgjLRj
         so+xo4CaSkYhKqTzNGhmPMQy1/NJtepu5F09WDXqTt2e2clQ6Sfp3cKuIEVGg1OZwr
         1XFmHVia56atGJH3Gk04RP87Xua/5CrwVcj/P0LxgBQt7hpxG4MY5cl0gRbh9R3m9d
         lwFJCSP7iQBuPoI91lgwG4nSQq/PdCp25pOI3j40B+uFPg1UOmGxRoo1YoUAC7cImG
         QtRCNa087ibeA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcK-91; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 08/26] media: cinergyT2-core: use the newer dvb-usb macros for USB device
Date:   Mon, 28 Mar 2022 22:41:20 +0200
Message-Id: <4b8212adab277a2bf84ab04480eb6fd37edda74f.1648499509.git.mchehab@kernel.org>
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
use the new macro and an enum with the USB model supported by
this driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/cinergyT2-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/cinergyT2-core.c b/drivers/media/usb/dvb-usb/cinergyT2-core.c
index 405b0c9a792c..4926c954e29a 100644
--- a/drivers/media/usb/dvb-usb/cinergyT2-core.c
+++ b/drivers/media/usb/dvb-usb/cinergyT2-core.c
@@ -193,9 +193,13 @@ static int cinergyt2_usb_probe(struct usb_interface *intf,
 				   THIS_MODULE, NULL, adapter_nr);
 }
 
+enum {
+	TERRATEC_CINERGY_T2,
+};
+
 static struct usb_device_id cinergyt2_usb_table[] = {
-	{ USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_T2) },
-	{ 0 }
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_T2),
+	{ }
 };
 
 MODULE_DEVICE_TABLE(usb, cinergyt2_usb_table);
@@ -240,7 +244,7 @@ static const struct dvb_usb_device_properties cinergyt2_properties = {
 	.devices = {
 		{ .name = "TerraTec/qanu USB2.0 Highspeed DVB-T Receiver",
 		  .cold_ids = {NULL},
-		  .warm_ids = { &cinergyt2_usb_table[0], NULL },
+		  .warm_ids = { &cinergyt2_usb_table[TERRATEC_CINERGY_T2], NULL },
 		},
 		{ NULL },
 	}
-- 
2.35.1

