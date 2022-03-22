Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F204E441F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbiCVQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiCVQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:23:03 -0400
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F721E23;
        Tue, 22 Mar 2022 09:21:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 35E96C8009B;
        Tue, 22 Mar 2022 17:21:31 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1647966090; x=1649780491; bh=8a
        Uyrssi2CpLUROB1u6KAOHSFCKEjbxvGeWwSdvf/Nw=; b=bDhVTK+QfffrIQYuoD
        Q5rn1veSRSBKVPpFoSWBOv3TFJ1dPnleNNDgPbr/GG75kRQiEN5qk1fEErBSzAnV
        do4cldeQltg3iw+2kC2v7gM3RT7hHS8Cakq10sdYH98gTtr6eccjycnP5JzDvro8
        5xoK/mkYBo4ZQywW/WQv9pJo8=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id tGIct-VHPwaq; Tue, 22 Mar 2022 17:21:30 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (unknown [IPv6:2001:a61:6168:d301:4be4:641d:6061:c5dc])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id BCEDFC800A7;
        Tue, 22 Mar 2022 17:21:30 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, hdegoede@redhat.com, samuel@cavoj.net,
        wse@tuxedocomputers.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] input/i8042: Add TUXEDO devices to i8042 quirk tables
Date:   Tue, 22 Mar 2022 17:21:25 +0100
Message-Id: <20220322162125.59838-5-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322162125.59838-1-wse@tuxedocomputers.com>
References: <20220322162125.59838-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

In this 4th revision the list is reduced by only identifying the devices by
board_name. This avoids a lot of duplication because of inconsistent and/or
reseller specific values of board_vendor and/or system_vendor. This change
is based on Dmitry Torokhovs mention that Clevos default "Notebook" string
doesn't add much uniqueness anyhow.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 125 ++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 229d4936910f..f79b5eea1295 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1095,6 +1095,25 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	/*
+	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
+	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
+	 * none of them have an external PS/2 port so this can savely be set for
+	 * all of them. These two are based on a Clevo design, but have the
+	 * board_name changed.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
+		},
+	},
 	{
 		/* Mivvy M310 */
 		.matches = {
@@ -1124,6 +1143,112 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
+	/*
+	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
+	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
+	 * none of them have an external PS/2 port so this can savely be set for
+	 * all of them.
+	 * Clevo barebones come with board_vendor and/or system_vendor set to
+	 * either the very generic string "Notebook" and/or a different value
+	 * for each individual reseller. The only somewhat universal way to
+	 * identify them is by board_name.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	/*
+	 * At least one modern Clevo barebone has the touchpad connected both
+	 * via PS/2 and i2c interface. This causes a race condition between the
+	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
+	 * is available via the i2c interface and the device has no external
+	 * PS/2 port, it is save to just ignore all ps2 mouses here to avoid
+	 * this issue. The know affected device is the
+	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
+	 * the two different dmi strings below. NS50MU is not a typo!
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
+					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
+					SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
+					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
+					SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	{ }
 };
 
-- 
2.25.1

