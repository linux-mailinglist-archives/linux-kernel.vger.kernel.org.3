Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D554ED9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379175AbiFPWt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378512AbiFPWtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:49:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC462216;
        Thu, 16 Jun 2022 15:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655419790; x=1686955790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6/VwsxPg/x4V5W8fgtZTd11tOBaTZVyMQ4yK6BNrFI=;
  b=d+Exf1GyOaz8fu1fzToMfMkA+hm55/BDQvhKb+ZyM+au6xTskkGg7P+x
   PzziOZ27lcUAFCFQ0ttPIUyQBxxih/k3d4tXcoZMgHslkvna3Jotozhu9
   nbDme5g2js7SI1zyVUSAiuKPkWHx3wpAPgYa9Jasp1i9ATQHZlzYF3fyL
   iA0fj1EFruUI2OKhdKO70mEJII3dQgS5QbD75IwakuRI125bXkd5WyGiI
   7PZGs63fIHu5zGGBbljiiY0x+OysfbsYnA57dxd1WMQrT2oj6AoJw4m0I
   LFlmOz6bX8gZ4etab3UbJg8JJ/2OFdp72IKJX7VVdv1aSX8wvO7oAoy+v
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280402501"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280402501"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="763032835"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2022 15:49:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4659067; Fri, 17 Jun 2022 01:49:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] platform/x86: thinkpad_acpi: Replace custom str_on_off() etc
Date:   Fri, 17 Jun 2022 01:49:51 +0300
Message-Id: <20220616224951.66660-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616224951.66660-1-andriy.shevchenko@linux.intel.com>
References: <20220616224951.66660-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace enabled(), onoff() and other similar places by str_*() helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 55 +++++++++++-----------------
 1 file changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index eab50d47f567..5950c69edf8b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -64,6 +64,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -261,8 +262,6 @@ enum tpacpi_hkey_event_t {
 #define TPACPI_DBG_BRGHT	0x0020
 #define TPACPI_DBG_MIXER	0x0040
 
-#define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
-#define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
 #define strlencmp(a, b) (strncmp((a), (b), strlen(b)))
 
 
@@ -1316,9 +1315,7 @@ static int tpacpi_rfk_procfs_read(const enum tpacpi_rfk_id id, struct seq_file *
 				return status;
 		}
 
-		seq_printf(m, "status:\t\t%s\n",
-				(status == TPACPI_RFK_RADIO_ON) ?
-					"enabled" : "disabled");
+		seq_printf(m, "status:\t\t%s\n", str_enabled_disabled(status == TPACPI_RFK_RADIO_ON));
 		seq_printf(m, "commands:\tenable, disable\n");
 	}
 
@@ -1345,8 +1342,7 @@ static int tpacpi_rfk_procfs_write(const enum tpacpi_rfk_id id, char *buf)
 
 	if (status != -1) {
 		tpacpi_disclose_usertask("procfs", "attempt to %s %s\n",
-				(status == TPACPI_RFK_RADIO_ON) ?
-						"enable" : "disable",
+				str_enable_disable(status == TPACPI_RFK_RADIO_ON),
 				tpacpi_rfkill_names[id]);
 		res = (tpacpi_rfkill_switches[id]->ops->set_status)(status);
 		tpacpi_rfk_update_swstate(tpacpi_rfkill_switches[id]);
@@ -3503,8 +3499,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	if (acpi_evalf(hkey_handle, &status, "WLSW", "qd")) {
 		tp_features.hotkey_wlsw = 1;
 		radiosw_state = !!status;
-		pr_info("radio switch found; radios are %s\n",
-			enabled(status, 0));
+		pr_info("radio switch found; radios are %s\n", str_enabled_disabled(status & BIT(0)));
 	}
 
 	tabletsw_state = hotkey_init_tablet_mode();
@@ -4163,7 +4158,7 @@ static int hotkey_read(struct seq_file *m)
 	if (res)
 		return res;
 
-	seq_printf(m, "status:\t\t%s\n", enabled(status, 0));
+	seq_printf(m, "status:\t\t%s\n", str_enabled_disabled(status & BIT(0)));
 	if (hotkey_all_mask) {
 		seq_printf(m, "mask:\t\t0x%08x\n", hotkey_user_mask);
 		seq_printf(m, "commands:\tenable, disable, reset, <mask>\n");
@@ -4296,9 +4291,8 @@ static int bluetooth_set_status(enum tpacpi_rfkill_state state)
 {
 	int status;
 
-	vdbg_printk(TPACPI_DBG_RFKILL,
-		"will attempt to %s bluetooth\n",
-		(state == TPACPI_RFK_RADIO_ON) ? "enable" : "disable");
+	vdbg_printk(TPACPI_DBG_RFKILL, "will attempt to %s bluetooth\n",
+		    str_enable_disable(state == TPACPI_RFK_RADIO_ON));
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_bluetoothemul) {
@@ -4662,9 +4656,8 @@ static int wan_set_status(enum tpacpi_rfkill_state state)
 {
 	int status;
 
-	vdbg_printk(TPACPI_DBG_RFKILL,
-		"will attempt to %s wwan\n",
-		(state == TPACPI_RFK_RADIO_ON) ? "enable" : "disable");
+	vdbg_printk(TPACPI_DBG_RFKILL, "will attempt to %s wwan\n",
+		    str_enable_disable(state == TPACPI_RFK_RADIO_ON));
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_wwanemul) {
@@ -4840,9 +4833,8 @@ static int uwb_set_status(enum tpacpi_rfkill_state state)
 {
 	int status;
 
-	vdbg_printk(TPACPI_DBG_RFKILL,
-		"will attempt to %s UWB\n",
-		(state == TPACPI_RFK_RADIO_ON) ? "enable" : "disable");
+	vdbg_printk(TPACPI_DBG_RFKILL, "will attempt to %s UWB\n",
+		    str_enable_disable(state == TPACPI_RFK_RADIO_ON));
 
 #ifdef CONFIG_THINKPAD_ACPI_DEBUGFACILITIES
 	if (dbg_uwbemul) {
@@ -5196,11 +5188,11 @@ static int video_read(struct seq_file *m)
 		return autosw;
 
 	seq_printf(m, "status:\t\tsupported\n");
-	seq_printf(m, "lcd:\t\t%s\n", enabled(status, 0));
-	seq_printf(m, "crt:\t\t%s\n", enabled(status, 1));
+	seq_printf(m, "lcd:\t\t%s\n", str_enabled_disabled(status & BIT(0)));
+	seq_printf(m, "crt:\t\t%s\n", str_enabled_disabled(status & BIT(1)));
 	if (video_supported == TPACPI_VIDEO_NEW)
-		seq_printf(m, "dvi:\t\t%s\n", enabled(status, 3));
-	seq_printf(m, "auto:\t\t%s\n", enabled(autosw, 0));
+		seq_printf(m, "dvi:\t\t%s\n", str_enabled_disabled(status & BIT(3)));
+	seq_printf(m, "auto:\t\t%s\n", str_enabled_disabled(autosw & BIT(0)));
 	seq_printf(m, "commands:\tlcd_enable, lcd_disable\n");
 	seq_printf(m, "commands:\tcrt_enable, crt_disable\n");
 	if (video_supported == TPACPI_VIDEO_NEW)
@@ -5631,7 +5623,7 @@ static int light_read(struct seq_file *m)
 		status = light_get_status();
 		if (status < 0)
 			return status;
-		seq_printf(m, "status:\t\t%s\n", onoff(status, 0));
+		seq_printf(m, "status:\t\t%s\n", str_on_off(status & BIT(0)));
 		seq_printf(m, "commands:\ton, off\n");
 	}
 
@@ -6087,9 +6079,7 @@ static int __init led_init(struct ibm_init_struct *iibm)
 	return 0;
 }
 
-#define str_led_status(s) \
-	((s) == TPACPI_LED_OFF ? "off" : \
-		((s) == TPACPI_LED_ON ? "on" : "blinking"))
+#define str_led_status(s)	((s) >= TPACPI_LED_BLINK ? "blinking" : str_on_off(s))
 
 static int led_read(struct seq_file *m)
 {
@@ -6106,8 +6096,7 @@ static int led_read(struct seq_file *m)
 			status = led_get_status(i);
 			if (status < 0)
 				return -EIO;
-			seq_printf(m, "%d:\t\t%s\n",
-				       i, str_led_status(status));
+			seq_printf(m, "%d:\t\t%s\n", i, str_led_status(status));
 		}
 	}
 
@@ -7832,8 +7821,7 @@ static int volume_read(struct seq_file *m)
 			seq_printf(m, "level:\t\t%d\n",
 					status & TP_EC_AUDIO_LVL_MSK);
 
-		seq_printf(m, "mute:\t\t%s\n",
-				onoff(status, TP_EC_AUDIO_MUTESW));
+		seq_printf(m, "mute:\t\t%s\n", str_on_off(status & BIT(TP_EC_AUDIO_MUTESW)));
 
 		if (volume_control_allowed) {
 			seq_printf(m, "commands:\tunmute, mute\n");
@@ -9062,7 +9050,7 @@ static int fan_read(struct seq_file *m)
 
 		seq_printf(m, "status:\t\t%s\n"
 			       "level:\t\t%d\n",
-			       (status != 0) ? "enabled" : "disabled", status);
+			       str_enabled_disabled(status), status);
 		break;
 
 	case TPACPI_FAN_RD_TPEC:
@@ -9071,8 +9059,7 @@ static int fan_read(struct seq_file *m)
 		if (rc)
 			return rc;
 
-		seq_printf(m, "status:\t\t%s\n",
-			       (status != 0) ? "enabled" : "disabled");
+		seq_printf(m, "status:\t\t%s\n", str_enabled_disabled(status));
 
 		rc = fan_get_speed(&speed);
 		if (rc < 0)
-- 
2.35.1

