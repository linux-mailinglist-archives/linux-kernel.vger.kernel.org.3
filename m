Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901354EA1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiC1Uru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345660AbiC1Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1776266AD2;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E3B614CA;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E69C341C6;
        Mon, 28 Mar 2022 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=2lLZy+8+HfLpQ9ZSrqPaFYZy8P0gQVUkzGts/rb6k78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XaU8cfgp2Dr2seVzNVGCrurhgSZaMGQajaHuwN+mQfYCZo9PS5959RuAnO62t4biR
         /oJxyYxQ9gfPk4tc+sp2zugG+tDdavM8yjE6p9vcj7Uj5kZnpGmKSZBu8TRxqx5boS
         xDpRfQ2/MIKw5r0ooYZQPLyXl53n4hKTi7Yn2K+FFfw5gcoDiNT4dHk3UP+aZ2B62k
         9fcTlU8xP/dkdA7nzuwlwYRnasHhgzuCU3I0av4VOgBOj6AQVrDDi2z1YJ+ovoPql1
         nugLFCP9gQnjAxKC/MhU4ZTSlKKOnGs5v05r+OQqRhFtJnTikhJxdqxrFWAUtGqJWs
         D8XZ0HMLPyVYA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lcu-NJ; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 17/26] media: dvb-usb: opera1: use an enum for the device number
Date:   Mon, 28 Mar 2022 22:41:29 +0200
Message-Id: <08861d80b6706ac1ed04a68959ebb78f27cb028d.1648499509.git.mchehab@kernel.org>
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

 drivers/media/usb/dvb-usb/opera1.c | 15 ++++++++++-----
 include/media/dvb-usb-ids.h        |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/opera1.c b/drivers/media/usb/dvb-usb/opera1.c
index e8d784b9d119..0da86f58aff6 100644
--- a/drivers/media/usb/dvb-usb/opera1.c
+++ b/drivers/media/usb/dvb-usb/opera1.c
@@ -425,10 +425,15 @@ static int opera1_rc_query(struct dvb_usb_device *dev, u32 * event, int *state)
 	return 0;
 }
 
+enum {
+	CYPRESS_OPERA1_COLD,
+	OPERA1_WARM,
+};
+
 static struct usb_device_id opera1_table[] = {
-	{USB_DEVICE(USB_VID_CYPRESS, USB_PID_OPERA1_COLD)},
-	{USB_DEVICE(USB_VID_OPERA1, USB_PID_OPERA1_WARM)},
-	{}
+	DVB_USB_DEV(CYPRESS, CYPRESS_OPERA1_COLD),
+	DVB_USB_DEV(OPERA1, OPERA1_WARM),
+	{ }
 };
 
 MODULE_DEVICE_TABLE(usb, opera1_table);
@@ -540,8 +545,8 @@ static struct dvb_usb_device_properties opera1_properties = {
 	.num_device_descs = 1,
 	.devices = {
 		{"Opera1 DVB-S USB2.0",
-			{&opera1_table[0], NULL},
-			{&opera1_table[1], NULL},
+			{&opera1_table[CYPRESS_OPERA1_COLD], NULL},
+			{&opera1_table[OPERA1_WARM], NULL},
 		},
 	}
 };
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index cc1df632d08b..6aa15988b577 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -168,6 +168,7 @@
 #define USB_PID_CYPRESS_DW2102				0x2102
 #define USB_PID_CYPRESS_DW2104				0x2104
 #define USB_PID_CYPRESS_DW3101				0x3101
+#define USB_PID_CYPRESS_OPERA1_COLD			0x2830
 #define USB_PID_DELOCK_USB2_DVBT			0xb803
 #define USB_PID_DIBCOM_ANCHOR_2135_COLD 		0x2131
 #define USB_PID_DIBCOM_HOOK_DEFAULT			0x0064
@@ -307,7 +308,6 @@
 #define USB_PID_NOXON_DAB_STICK 			0x00b3
 #define USB_PID_NOXON_DAB_STICK_REV2			0x00e0
 #define USB_PID_NOXON_DAB_STICK_REV3			0x00b4
-#define USB_PID_OPERA1_COLD				0x2830
 #define USB_PID_OPERA1_WARM				0x3829
 #define USB_PID_PCTV_2002E				0x025c
 #define USB_PID_PCTV_2002E_SE				0x025d
-- 
2.35.1

