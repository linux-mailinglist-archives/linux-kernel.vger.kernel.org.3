Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1A56C06E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbiGHQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiGHQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:10:17 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9204574368;
        Fri,  8 Jul 2022 09:10:15 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id AADA8C800AF;
        Fri,  8 Jul 2022 18:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1657296613; x=1659111014; bh=nv
        1yeQkccAF+ZdQu96d/KEVsM4YZKFWBOeyC2mkggzE=; b=VTE7fGn4HgNFcE8vW1
        H6ht6z0tK2ZIhRaVvy5H+twPziq8YRCS+oqCKG8G9juSuDql6NeVQAD1145GYThV
        DIqLAGpe54dSVCPjMdd+wIoEHXTvQBxE5x2eWzSs+vhCeK55JtkG58PcstNplzo3
        BrCCmYZcqzxFDTWM/f9Dxk4DM=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id jMK6RkaHBlY0; Fri,  8 Jul 2022 18:10:13 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 3231AC800AD;
        Fri,  8 Jul 2022 18:10:13 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, hdegoede@redhat.com, tiwai@suse.de,
        samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: i8042 - add additional TUXEDO devices to i8042 quirk tables
Date:   Fri,  8 Jul 2022 18:10:04 +0200
Message-Id: <20220708161005.1251929-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220708161005.1251929-1-wse@tuxedocomputers.com>
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of modern Clevo barebones have touchpad and/or keyboard issues after
suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
have an external PS/2 port so this can safely be set for all of them.

I'm not entirely sure if every device listed really needs all four quirks,
but after testing and production use. No negative effects could be
observed when setting all four.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 76 ++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 50b090e77fca..5204a7dd61d4 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -900,14 +900,6 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
-	{
-		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
 	{
 		/* OQO Model 01 */
 		.matches = {
@@ -1162,6 +1154,74 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65xH"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65_P67H"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RS"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P67xRP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
-- 
2.34.1

