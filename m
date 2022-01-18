Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F094C49253F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbiARLzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:55:38 -0500
Received: from srv6.fidu.org ([159.69.62.71]:42526 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237808AbiARLzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:55:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id DBA76C80073;
        Tue, 18 Jan 2022 12:55:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id aeAXiSTbaRAH; Tue, 18 Jan 2022 12:55:32 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 649D5C8006F;
        Tue, 18 Jan 2022 12:55:32 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, tiwai@suse.com, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] input/i8042: Add quirk table to disable aux port on Clevo NS70MU
Date:   Tue, 18 Jan 2022 12:55:32 +0100
Message-Id: <20220118115532.33011-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least one modern Clevo barebone has the touchpad connected both via PS/2
and i2c interface. This causes a race condition between the psmouse and
i2c-hid driver. Since the full capability if the touchpad is available via
the i2c interface and the device has no external PS/2 port, it is save to
just ignore all ps2 mouses here to avoid this issue.

The know affected device is the Clevo NS70MU.

This patch adds a new i8042_dmi_noaux_table with the dmi strings of the
affected device of different revisions. The table is then evaluated like
the other quirk tables in the i8042 driver.

This is revision 2 as I got aware that there are yet another 2 dmi string
combinations identifying the same device.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 148a7c5fd0e2..e39d3d840a31 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1013,6 +1013,57 @@ static const struct dmi_system_id i8042_dmi_probe_defer_table[] __initconst = {
 	{ }
 };
 
+static const struct dmi_system_id i8042_dmi_noaux_table[] __initconst = {
+	/*
+	 * At least one modern Clevo barebone has the touchpad connected
+	 * both via PS/2 and i2c interface. This causes a race condition
+	 * between the psmouse and i2c-hid driver. Since the full
+	 * capability if the touchpad is available via the i2c interface
+	 * and the device has no external PS/2 port, it is save to just
+	 * ignore all ps2 mouses here to avoid this issue.
+	 * The know affected device is the
+	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with
+	 * one of the 6 different dmi string combinations below.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
+		},
+	},
+	{ }
+};
+
 #endif /* CONFIG_X86 */
 
 #ifdef CONFIG_PNP
@@ -1336,6 +1387,9 @@ static int __init i8042_platform_init(void)
 	if (dmi_check_system(i8042_dmi_probe_defer_table))
 		i8042_probe_defer = true;
 
+	if (dmi_check_system(i8042_dmi_noaux_table))
+		i8042_noaux = true;
+
 	/*
 	 * A20 was already enabled during early kernel init. But some buggy
 	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
-- 
2.25.1

