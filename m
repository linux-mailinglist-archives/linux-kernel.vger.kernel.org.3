Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C654EA1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbiC1Ur0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345678AbiC1Un1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629F66AD2;
        Mon, 28 Mar 2022 13:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD2D1CE170B;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9B4C34117;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=9HZjksUabmOm37G5sc/HJE9SBSEyfBlYvIZOWWpC4hE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABswXVV5gQuCk9AD/wtL8bO+BypW0m8y+ANAQ5rnByh5DMEvWtpqrsgbAg0JsEJ9c
         VT9ZhC4q8iRP+vYd/N/27I+V+4EniwELQuULlz4lgsnjuy5r171ufFlmoYBAXqFM/E
         jGX9CNMzMX2t5ZaN4NWUJpLoSSP8V+i8PHqAY/8M2WfwjP5OQAKe6SZl5vXqK83/CJ
         WjJSYbnnBNWrf9t2Fj0Xe4IgSrFQVuC/POsAdh3Ck3bQAk6NcGLdfkeeEGbONH+u3p
         75S6fEbN/Cf+qBa4eGs7S32hQ8tLXoiL6fjlsG+ZeuucRpLhQZrDx0wQiW25CvdXAl
         XOcDh/+HdwqSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcC-55; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 06/26] media: af9005: use the newer dvb-usb macros for USB device
Date:   Mon, 28 Mar 2022 22:41:18 +0200
Message-Id: <9b1749763465815af92f0a4d8f210fe170c549d5.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/af9005.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
index b6a2436d16e9..0827bf3d4e8c 100644
--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -994,19 +994,16 @@ static int af9005_usb_probe(struct usb_interface *intf,
 				  THIS_MODULE, NULL, adapter_nr);
 }
 
-enum af9005_usb_table_entry {
+enum {
 	AFATECH_AF9005,
-	TERRATEC_AF9005,
-	ANSONIC_AF9005,
+	TERRATEC_CINERGY_T_USB_XE,
+	ANSONIC_DVBT_USB,
 };
 
 static struct usb_device_id af9005_usb_table[] = {
-	[AFATECH_AF9005] = {USB_DEVICE(USB_VID_AFATECH,
-				USB_PID_AFATECH_AF9005)},
-	[TERRATEC_AF9005] = {USB_DEVICE(USB_VID_TERRATEC,
-				USB_PID_TERRATEC_CINERGY_T_USB_XE)},
-	[ANSONIC_AF9005] = {USB_DEVICE(USB_VID_ANSONIC,
-				USB_PID_ANSONIC_DVBT_USB)},
+	DVB_USB_DEV(AFATECH, AFATECH_AF9005),
+	DVB_USB_DEV(TERRATEC, TERRATEC_CINERGY_T_USB_XE),
+	DVB_USB_DEV(ANSONIC, ANSONIC_DVBT_USB),
 	{ }
 };
 
@@ -1071,11 +1068,11 @@ static struct dvb_usb_device_properties af9005_properties = {
 		     .warm_ids = {NULL},
 		     },
 		    {.name = "TerraTec Cinergy T USB XE",
-		     .cold_ids = {&af9005_usb_table[TERRATEC_AF9005], NULL},
+		     .cold_ids = {&af9005_usb_table[TERRATEC_CINERGY_T_USB_XE], NULL},
 		     .warm_ids = {NULL},
 		     },
 		    {.name = "Ansonic DVB-T USB1.1 stick",
-		     .cold_ids = {&af9005_usb_table[ANSONIC_AF9005], NULL},
+		     .cold_ids = {&af9005_usb_table[ANSONIC_DVBT_USB], NULL},
 		     .warm_ids = {NULL},
 		     },
 		    {NULL},
-- 
2.35.1

