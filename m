Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D8512054
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiD0Pxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbiD0Pxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:53:35 -0400
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 08:50:20 PDT
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5B255B8;
        Wed, 27 Apr 2022 08:50:19 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id DC539C8009E;
        Wed, 27 Apr 2022 17:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1651074056; x=1652888457; bh=ui/bYejcnY9R7gBn0GwVOE0a
        OmURfjgUyCjFPF6MREo=; b=n8XCr1STHK241socn1WHSfKD21WWP2LAGi7MTPGU
        j/Uq1oAycVmT5ZSnrm/4BzD2zdqa8OtmRrhdBlAS4lW2sQWvjFdBe2lCogdTtCmp
        hu57SHi1r8B6u6ADkGGtvT/nxPlnXdvSj+SPfrfSLxBiDDZvNUMv89PmRDOR40Pi
        lwY=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Y-ujsk8TkqNA; Wed, 27 Apr 2022 17:40:56 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 7B75DC8006F;
        Wed, 27 Apr 2022 17:40:56 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/battery: Make "not-charging" the default on no charging or full info
Date:   Wed, 27 Apr 2022 17:40:53 +0200
Message-Id: <20220427154053.499203-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the battery is neither charging or discharging and is not full,
"not-charging" is a useful status description for the case in general.
Currently this state is set as "unknown" by default, expect when this is
explicitly replaced with "not-charging" on a per device or per vendor
basis.

A lot of devices have this state without a BIOS specification available
explicitly describing it. e.g. some current Clevo barebones have a BIOS
setting to stop charging at a user defined battery level.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/acpi/battery.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index dc208f5f5a1f..306513fec1e1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -52,7 +52,6 @@ static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
 static int battery_ac_is_broken;
-static int battery_quirk_notcharging;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
@@ -216,10 +215,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (acpi_battery_is_charged(battery))
 			val->intval = POWER_SUPPLY_STATUS_FULL;
-		else if (battery_quirk_notcharging)
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
-			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = acpi_battery_present(battery);
@@ -1105,12 +1102,6 @@ battery_ac_is_broken_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
-static int __init battery_quirk_not_charging(const struct dmi_system_id *d)
-{
-	battery_quirk_notcharging = 1;
-	return 0;
-}
-
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		/* NEC LZ750/LS */
@@ -1139,19 +1130,6 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_DATE, "08/22/2014"),
 		},
 	},
-	{
-		/*
-		 * On Lenovo ThinkPads the BIOS specification defines
-		 * a state when the bits for charging and discharging
-		 * are both set to 0. That state is "Not Charging".
-		 */
-		.callback = battery_quirk_not_charging,
-		.ident = "Lenovo ThinkPad",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
-		},
-	},
 	{
 		/* Microsoft Surface Go 3 */
 		.callback = battery_notification_delay_quirk,
-- 
2.25.1

