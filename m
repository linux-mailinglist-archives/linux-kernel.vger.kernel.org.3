Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28C4EA1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346184AbiC1UsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiC1Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9166AE0;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD5D8614D3;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2BFC3411F;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=hTy+qzETzi69PC0L01ikNmjGWuzUbT7kNwTJl3UyFeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlZulTcIO7yvJWxGwnOCQgiRoCjvTwjGh932UNyzMtdvX3xhyKwSdQBrD87TMMS0r
         gOjAnpu+NdP9fhjM2duwn/Bkxo+qIxOpPn1Mv7rrLAZANY12fki7fWlBJjamyOkLGu
         9NIyFgfJkqZUqjiAm6q2mV/WfEMERgojG3rmJbuQSEsA1gDtvqz8eIBvOFDb/LLmHa
         ZzUVC1QUI/stIWyM6oOnegkzZ8Qq78pdTRCgXFQEeWLnLeTDOzvj6SEJgOjUzeONjI
         8B/r3I1i6cGqw3kYXBEmKCWCV44krKn109UjlBlskrI9JZ0IWfwSBoC+v5E6MXdVJ9
         4kbh/DZ5rYQpg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000ld2-Qu; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 19/26] media: technisat-usb2: use the newer dvb-usb macros for USB device
Date:   Mon, 28 Mar 2022 22:41:31 +0200
Message-Id: <c125c28aeb3d4344b632e1f99d81c433917f2a4c.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/technisat-usb2.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/technisat-usb2.c b/drivers/media/usb/dvb-usb/technisat-usb2.c
index a9ed26ce1be6..9c77911fcad4 100644
--- a/drivers/media/usb/dvb-usb/technisat-usb2.c
+++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
@@ -689,10 +689,15 @@ static int technisat_usb2_rc_query(struct dvb_usb_device *d)
 }
 
 /* DVB-USB and USB stuff follows */
+enum {
+	TECHNISAT_USB2_DVB_S2,
+};
+
 static struct usb_device_id technisat_usb2_id_table[] = {
-	{ USB_DEVICE(USB_VID_TECHNISAT, USB_PID_TECHNISAT_USB2_DVB_S2) },
-	{ 0 }		/* Terminating entry */
+	DVB_USB_DEV(TECHNISAT, TECHNISAT_USB2_DVB_S2),
+	{ }
 };
+
 MODULE_DEVICE_TABLE(usb, technisat_usb2_id_table);
 
 /* device description */
@@ -738,7 +743,7 @@ static struct dvb_usb_device_properties technisat_usb2_devices = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "Technisat SkyStar USB HD (DVB-S/S2)",
-			{ &technisat_usb2_id_table[0], NULL },
+			{ &technisat_usb2_id_table[TECHNISAT_USB2_DVB_S2], NULL },
 			{ NULL },
 		},
 	},
-- 
2.35.1

