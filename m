Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CA456C0EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiGHQKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiGHQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:10:17 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0574371;
        Fri,  8 Jul 2022 09:10:15 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 242E0C800AD;
        Fri,  8 Jul 2022 18:10:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1657296613; x=1659111014; bh=9K
        AXvRDlHHjdnW1XQZ8Nn+6WBTtHcJlv6v3Wld1jtgo=; b=fqVQWbtTWYK61/FcND
        do2lEIHdgg3TRNzSlSnGHc+5yzq2pPi3EcfEPMZxWa/+zogIno6Dwa84wc33NqAk
        mQxYysXjyGS/LVjeZc3Bdut9W8v8vRbad5dpFsjRHd+2WFM0gzO45G6LaoXZi28l
        aCw8/x7yZYmoLUQUoy1a9+1O0=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id XIGw24GGsAA5; Fri,  8 Jul 2022 18:10:13 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 77E76C800AC;
        Fri,  8 Jul 2022 18:10:13 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, hdegoede@redhat.com, tiwai@suse.de,
        samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: i8042 - add TUXEDO devices to i8042 quirk tables for partial fix
Date:   Fri,  8 Jul 2022 18:10:05 +0200
Message-Id: <20220708161005.1251929-3-wse@tuxedocomputers.com>
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

Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
boot and sometimes also after resume. However both are required for the
keyboard to not fail completely sometimes after boot or resume.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 5204a7dd61d4..9dc0266e5168 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1107,6 +1107,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		/*
+		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
+		 * the keyboard very laggy for ~5 seconds after boot and
+		 * sometimes also after resume.
+		 * However both are required for the keyboard to not fail
+		 * completely sometimes after boot or resume.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N150CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
@@ -1114,6 +1128,20 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		/*
+		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
+		 * the keyboard very laggy for ~5 seconds after boot and
+		 * sometimes also after resume.
+		 * However both are required for the keyboard to not fail
+		 * completely sometimes after boot or resume.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NHxxRZQ"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
-- 
2.34.1

