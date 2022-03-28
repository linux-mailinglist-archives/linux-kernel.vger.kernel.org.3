Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE14EA1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbiC1Up4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345680AbiC1Un1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E76C67D3C;
        Mon, 28 Mar 2022 13:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DE0F614E2;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2B5C341D8;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=Mq/3q2HPn+lLhZOCSw6V5fK6FkDgJ6aTbZK5JZLvons=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlkVJ9TTb7ibxxkWfR5u0Bk1y3V8E1KXwHnFn+OyB4DHxn7J12kUwAMaLTFyBwsUM
         evLjrFaet6OSW4fq1wtwdALOTeYhN9rhzagGar/6SRCNxNNew0AIzdmB0pj1+2XWDR
         ZeYGmZHpeUSQDB+0Pf4FQHUbGgJqkIw3OrAn1Ez/6mfA8dL/w7x1e5KdHXPQwSeb9u
         AhYrRljb6nP04TJsP0/UsHPC2qSfJDXf+D9TVzFESVaFYk/WAl1hiyq3Jerzq8kWmG
         415fp4kFBceJVi+lyFvvoQnbrJ61X6ITnwzMeC5KW9IAb+ljqkxYacegpfg44M7z2G
         GAcp4ednTd4EA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lc8-37; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 05/26] media: dvb-usb: a800: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:17 +0200
Message-Id: <dc8f9ec6cc8f2e16967a61752a292c46622c01dc.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/a800.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/a800.c b/drivers/media/usb/dvb-usb/a800.c
index 36b5b6227412..5f294784923c 100644
--- a/drivers/media/usb/dvb-usb/a800.c
+++ b/drivers/media/usb/dvb-usb/a800.c
@@ -72,11 +72,17 @@ static int a800_probe(struct usb_interface *intf,
 }
 
 /* do not change the order of the ID table */
-static struct usb_device_id a800_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_AVERMEDIA,     USB_PID_AVERMEDIA_DVBT_USB2_COLD) },
-/* 01 */	{ USB_DEVICE(USB_VID_AVERMEDIA,     USB_PID_AVERMEDIA_DVBT_USB2_WARM) },
-			{ }		/* Terminating entry */
+enum {
+	AVERMEDIA_DVBT_USB2_COLD,
+	AVERMEDIA_DVBT_USB2_WARM,
 };
+
+static struct usb_device_id a800_table[] = {
+	DVB_USB_DEV(AVERMEDIA, AVERMEDIA_DVBT_USB2_COLD),
+	DVB_USB_DEV(AVERMEDIA, AVERMEDIA_DVBT_USB2_WARM),
+	{ }
+};
+
 MODULE_DEVICE_TABLE (usb, a800_table);
 
 static struct dvb_usb_device_properties a800_properties = {
@@ -132,8 +138,8 @@ static struct dvb_usb_device_properties a800_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{   "AVerMedia AverTV DVB-T USB 2.0 (A800)",
-			{ &a800_table[0], NULL },
-			{ &a800_table[1], NULL },
+			{ &a800_table[AVERMEDIA_DVBT_USB2_COLD], NULL },
+			{ &a800_table[AVERMEDIA_DVBT_USB2_WARM], NULL },
 		},
 	}
 };
-- 
2.35.1

