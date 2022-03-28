Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E183E4EA1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346316AbiC1Usc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbiC1Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956C66ADF;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D37D8614D7;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466F0C341CD;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=ZMqRsVWH7Xix4Ul67rXjIZoC7fsabNACSNqXpoa4wzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtGzrvJs1iMpmwB+D4nDRkpYksccEbAcQtw7mnEZFASfZQl5TkYtS98q9TqdXvKMP
         54R408zJoCQ9qg/WguoUbTa82GGIRLJb7YFVUe+faI+62qNH1y1UaGCg1eusDeaggF
         L9i7SvK9QtxjuQn/jv7RHLY95v6G+3NJkPDycADPTZWwq9/hfoMP2jo+jjPARaT2NM
         nRZ9z1gppNwAIrGr0IjfZoi4W5TxF4ckwQLYoE8ow6WT0ZDkzgvisD7w/XdvorZ9qR
         OApcb7uaDI4BpTLE4KUnpLYPzrHRlei6VvHq4FisH40qfr2mtkIhrxHArwwCjvMz3Q
         D6eWw7kIoC/KQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000ldA-V1; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 21/26] media: dvb-usb: umt-010: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:33 +0200
Message-Id: <5fd3c469faa115856f48037019e607edcb41d458.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/umt-010.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/umt-010.c b/drivers/media/usb/dvb-usb/umt-010.c
index 2181993771ae..464699b0b75b 100644
--- a/drivers/media/usb/dvb-usb/umt-010.c
+++ b/drivers/media/usb/dvb-usb/umt-010.c
@@ -81,11 +81,17 @@ static int umt_probe(struct usb_interface *intf,
 }
 
 /* do not change the order of the ID table */
-static struct usb_device_id umt_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_HANFTEK, USB_PID_HANFTEK_UMT_010_COLD) },
-/* 01 */	{ USB_DEVICE(USB_VID_HANFTEK, USB_PID_HANFTEK_UMT_010_WARM) },
-			{ }		/* Terminating entry */
+enum {
+	HANFTEK_UMT_010_COLD,
+	HANFTEK_UMT_010_WARM,
 };
+
+static struct usb_device_id umt_table[] = {
+	DVB_USB_DEV(HANFTEK, HANFTEK_UMT_010_COLD),
+	DVB_USB_DEV(HANFTEK, HANFTEK_UMT_010_WARM),
+	{ }
+};
+
 MODULE_DEVICE_TABLE (usb, umt_table);
 
 static struct dvb_usb_device_properties umt_properties = {
@@ -127,8 +133,8 @@ static struct dvb_usb_device_properties umt_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{	"Hanftek UMT-010 DVB-T USB2.0",
-			{ &umt_table[0], NULL },
-			{ &umt_table[1], NULL },
+			{ &umt_table[HANFTEK_UMT_010_COLD], NULL },
+			{ &umt_table[HANFTEK_UMT_010_WARM], NULL },
 		},
 	}
 };
-- 
2.35.1

