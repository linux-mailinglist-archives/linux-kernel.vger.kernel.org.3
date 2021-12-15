Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55C4759D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbhLONmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:42:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:34641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242923AbhLONmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:42:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226509020"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226509020"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:42:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="518774312"
Received: from cdobraun-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.251.212.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:42:35 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, tero.kristo@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        peter.hutterer@who-t.net
Subject: [RFCv5 1/2] HID: core: Add support for USI style events
Date:   Wed, 15 Dec 2021 15:42:19 +0200
Message-Id: <20211215134220.1735144-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
References: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Universal Stylus Interface (USI) style events to the HID
core and input layers.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/hid-debug.c                |  9 +++++-
 drivers/hid/hid-input.c                | 40 ++++++++++++++++++++++++++
 include/linux/mod_devicetable.h        |  2 +-
 include/uapi/linux/input-event-codes.h | 26 +++++++++++------
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 26c31d759914..18035c63c358 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1025,7 +1025,14 @@ static const char *absolutes[ABS_CNT] = {
 
 static const char *misc[MSC_MAX + 1] = {
 	[MSC_SERIAL] = "Serial",	[MSC_PULSELED] = "Pulseled",
-	[MSC_GESTURE] = "Gesture",	[MSC_RAW] = "RawData"
+	[MSC_GESTURE] = "Gesture",	[MSC_RAW] = "RawData",
+	[MSC_PEN_ID] = "PenID",		[MSC_PEN_COLOR] "PenColor",
+	[MSC_PEN_LINE_STYLE_INK] = "PenLineStyleInk",
+	[MSC_PEN_LINE_STYLE_PENCIL] = "PenLineStylePencil",
+	[MSC_PEN_LINE_STYLE_HIGHLIGHTER] = "PenLineStyleHighlighter",
+	[MSC_PEN_LINE_STYLE_CHISEL_MARKER] = "PenLineStyleChiselMarker",
+	[MSC_PEN_LINE_STYLE_BRUSH] = "PenLineStyleBrush",
+	[MSC_PEN_LINE_STYLE_NO_PREFERENCE] = "PenLineStyleNoPreference",
 };
 
 static const char *leds[LED_MAX + 1] = {
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 1ce75e8b49d5..52c581324491 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -833,6 +833,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			}
 			break;
 
+		case 0x38: /* Transducer Index */
+			map_msc(MSC_PEN_ID);
+			goto ignore;
+
 		case 0x3b: /* Battery Strength */
 			hidinput_setup_battery(device, HID_INPUT_REPORT, field, false);
 			usage->type = EV_PWR;
@@ -880,6 +884,42 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			map_msc(MSC_SERIAL);
 			break;
 
+		case 0x5c: /* Digitizer Preferred Color */
+			map_msc(MSC_PEN_COLOR);
+			break;
+
+		case 0x5e: /* Digitizer Preferred Line Width */
+			map_abs_clear(ABS_TOOL_WIDTH);
+			break;
+
+		case 0x70: /* Preferred Line Style -> not an input usage */
+		case 0x71: /* Preferred Line Style is Locked */
+			goto ignore;
+
+		case 0x72: /* Ink */
+			map_msc(MSC_PEN_LINE_STYLE_INK);
+			break;
+
+		case 0x73: /* Pencil */
+			map_msc(MSC_PEN_LINE_STYLE_PENCIL);
+			break;
+
+		case 0x74: /* Highlighter */
+			map_msc(MSC_PEN_LINE_STYLE_HIGHLIGHTER);
+			break;
+
+		case 0x75: /* Chisel Marker */
+			map_msc(MSC_PEN_LINE_STYLE_CHISEL_MARKER);
+			break;
+
+		case 0x76: /* Brush */
+			map_msc(MSC_PEN_LINE_STYLE_BRUSH);
+			break;
+
+		case 0x77: /* No Preference */
+			map_msc(MSC_PEN_LINE_STYLE_NO_PREFERENCE);
+			break;
+
 		default:  goto unknown;
 		}
 		break;
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 4bb71979a8fd..bf2b76a6e7e8 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -322,7 +322,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_KEY_MAX		0x2ff
 #define INPUT_DEVICE_ID_REL_MAX		0x0f
 #define INPUT_DEVICE_ID_ABS_MAX		0x3f
-#define INPUT_DEVICE_ID_MSC_MAX		0x07
+#define INPUT_DEVICE_ID_MSC_MAX		0x0d
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
 #define INPUT_DEVICE_ID_FF_MAX		0x7f
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 225ec87d4f22..0ebfc92dacf5 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -901,14 +901,24 @@
  * Misc events
  */
 
-#define MSC_SERIAL		0x00
-#define MSC_PULSELED		0x01
-#define MSC_GESTURE		0x02
-#define MSC_RAW			0x03
-#define MSC_SCAN		0x04
-#define MSC_TIMESTAMP		0x05
-#define MSC_MAX			0x07
-#define MSC_CNT			(MSC_MAX+1)
+#define MSC_SERIAL			0x00
+#define MSC_PULSELED			0x01
+#define MSC_GESTURE			0x02
+#define MSC_RAW				0x03
+#define MSC_SCAN			0x04
+#define MSC_TIMESTAMP			0x05
+/* USI Pen events */
+#define MSC_PEN_ID			0x06
+#define MSC_PEN_COLOR			0x07
+#define MSC_PEN_LINE_STYLE_INK			0x08
+#define MSC_PEN_LINE_STYLE_PENCIL		0x09
+#define MSC_PEN_LINE_STYLE_HIGHLIGHTER		0x0a
+#define MSC_PEN_LINE_STYLE_CHISEL_MARKER	0x0b
+#define MSC_PEN_LINE_STYLE_BRUSH		0x0c
+#define MSC_PEN_LINE_STYLE_NO_PREFERENCE	0x0d
+/* TODO: Add USI diagnostic & battery events too */
+#define MSC_MAX				0x0d
+#define MSC_CNT				(MSC_MAX + 1)
 
 /*
  * LEDs
-- 
2.25.1

