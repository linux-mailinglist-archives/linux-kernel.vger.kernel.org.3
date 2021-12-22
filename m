Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A287847D8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhLVVUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:20:30 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:50571 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhLVVU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:20:28 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1640208026;
        bh=aGCj4aiE4nMhMPOvZxmPkbOeYECl8rQcbNMEcl0EXbc=;
        h=From:To:Cc:Subject:Date:From;
        b=RnBBWeyrJ/gnUz0yHX9jlR0geQv63Kx0+04Y7c+L0Xx6RJqDMVg3rWI/83H5HUlLD
         alZG1UojE7+4TR7NwKfduFEw+5e54+7Mm1+0L3fOsp5Y4YH62M5N+ZAQxFWzJzYGS/
         3vQ02nk84ZoOwF6RkvN/mTkzdf0LXRWcDhZqT6gg=
To:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, markpearson@lenovo.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ognjen Galic <smclt30p@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        David Zeuthen <davidz@redhat.com>,
        Richard Hughes <richard@hughsie.com>
Subject: [PATCH] ACPI: battery: Add the ThinkPad "Not Charging" quirk
Date:   Wed, 22 Dec 2021 22:20:14 +0100
Message-Id: <20211222212014.66971-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1640208009; l=3639; s=20211113; h=from:subject; bh=aGCj4aiE4nMhMPOvZxmPkbOeYECl8rQcbNMEcl0EXbc=; b=V4ltAs5HbLZJuv0HJiA8DNFuaS6cA+TfkoXpftD66G0oI3+a1Lfi7nnTjpqoEuQAaZBuCi4Th6V0 4oQ4R+6YA0Sfey7NObJdrg37MQq3l5anJc0hWKgNIkOC4nW4d9GP
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC/ACPI firmware on Lenovo ThinkPads used to report a status
of "Unknown" when the battery is between the charge start and
charge stop thresholds. On Windows, it reports "Not Charging"
so the quirk has been added to also report correctly.

Now the "status" attribute returns "Not Charging" when the
battery on ThinkPads is not physicaly charging.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---

This is the same as: https://patchwork.kernel.org/patch/10205359/

Previously this patch has been applied[0] but then reverted from -next
because it caused a regression in UPower.
This regression however has been fixed in UPower in late 2018[1],
with the fixed version 0.99.10 released in early 2019 [2].
So maybe it is now time to reintroduce this change.

Ognen:

As the patch was originally developed by you, could send a
Signed-off-by-tag, so I can attribute you as co-developer?

Or maybe the original patch could just be re-applied?

The original patch had the following tags, which I'm not sure to handle
for this case:

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Also Cc-ing the UPower maintainers for their opinion:

Cc: Bastien Nocera <hadess@hadess.net>
Cc: David Zeuthen <davidz@redhat.com>
Cc: Richard Hughes <richard@hughsie.com>

[0] Applied as 91eea70e5e5ce12eb1c7cd922e561fab43e201bd
[1] https://gitlab.freedesktop.org/upower/upower/-/merge_requests/19/commits
[2] https://gitlab.freedesktop.org/upower/upower/-/commit/215049e7b80c5f24cb35cd229a445c6cf19bd381
---
 drivers/acpi/battery.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8afa85d6eb6a..ead0114f27c9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -53,6 +53,7 @@ static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static int battery_ac_is_broken;
 static int battery_check_pmic = 1;
+static int battery_quirk_notcharging;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -217,6 +218,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (acpi_battery_is_charged(battery))
 			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (battery_quirk_notcharging)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
@@ -1111,6 +1114,12 @@ battery_do_not_check_pmic_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init battery_quirk_not_charging(const struct dmi_system_id *d)
+{
+	battery_quirk_notcharging = 1;
+	return 0;
+}
+
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		/* NEC LZ750/LS */
@@ -1155,6 +1164,19 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
 		},
 	},
+	{
+		/*
+		 * On Lenovo ThinkPads the BIOS specification defines
+		 * a state when the bits for charging and discharging
+		 * are both set to 0. That state is "Not Charging".
+		 */
+		.callback = battery_quirk_not_charging,
+		.ident = "Lenovo ThinkPad",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
+		},
+	},
 	{},
 };
 

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.34.1

