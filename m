Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F317590F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiHLKf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiHLKfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:35:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E85FAFD;
        Fri, 12 Aug 2022 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660300524; x=1691836524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hu3sHXqmoBStOS/bTZR9jSIQNiGB7/ztc9oxGV+FzE8=;
  b=cZF/aDaJENg98hzZzsgd4fIDdy1wVdCgb646p/X2T/yJ9Fx+QQ5ebwJ8
   x5v2evZWNoocS8LI1PcVGhiLNOP99UZklKUZiluazug2qOZ6lTJOc2he3
   /+0PVxt/zjs2Qv8vRLMHBLmS3ch49LHZftY5S4OCT5uzdlCUKn8PM5GmV
   kLGCqJ2F5Bw1eecWOn43or6s+xoYRmZCbBsITP1khMrRg8cIMRe3HodST
   3dWVSdH/RQBgKtCJwz20awJkVY8eEExhRPe0pjpP6Fd/4TKxjmHI80aiw
   4cMUXJWIcD5Z0W1P+I+ep8IstS0GViSYC6sDLP7ItF9ucZqkVLRXk8BL5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="274625857"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="274625857"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 03:35:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="582043047"
Received: from ekuprjan-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.35.164])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 03:35:22 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: [PATCH] HID: input: Add support for USI style events
Date:   Fri, 12 Aug 2022 13:35:19 +0300
Message-Id: <20220812103519.2142290-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Universal Stylus Interface (USI) style events to the HID
input layers. The events are mapped as follows:

type	id	event
----	--	-----
MSC(4)	6	Pen ID
MSC(4)	7	Pen Color
MSC(4)	8	Pen Line Style Ink
MSC(4)	9	Pen Line Style Pencil
MSC(4)	0xa	Pen Line Style Highlighter
MSC(4)	0xb	Pen Line Style Chisel Marker
MSC(4)	0xc	Pen Line Style Brush
MSC(4)	0xd	Pen No Preferred Line Style
ABS(3)	0x1c	Pen Line Width

All the listed MSC events are new, the ABS one is mapped to an existing
event.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/hid/hid-debug.c                |  9 ++++++-
 drivers/hid/hid-input.c                | 36 ++++++++++++++++++++++++++
 include/linux/mod_devicetable.h        |  2 +-
 include/uapi/linux/input-event-codes.h | 10 ++++++-
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 81e7e404a5fc..1394370ec6d5 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1028,7 +1028,14 @@ static const char *absolutes[ABS_CNT] = {
 
 static const char *misc[MSC_MAX + 1] = {
 	[MSC_SERIAL] = "Serial",	[MSC_PULSELED] = "Pulseled",
-	[MSC_GESTURE] = "Gesture",	[MSC_RAW] = "RawData"
+	[MSC_GESTURE] = "Gesture",	[MSC_RAW] = "RawData",
+	[MSC_PEN_ID] = "PenID",		[MSC_PEN_COLOR] = "PenColor",
+	[MSC_PEN_LINE_STYLE_INK] = "PenLineStyleInk",
+	[MSC_PEN_LINE_STYLE_PENCIL] = "PenLineStylePencil",
+	[MSC_PEN_LINE_STYLE_HIGHLIGHTER] = "PenLineStyleHighLighter",
+	[MSC_PEN_LINE_STYLE_CHISEL_MARKER] = "PenLineStyleChiselMarker",
+	[MSC_PEN_LINE_STYLE_BRUSH] = "PenLineStyleBrush",
+	[MSC_PEN_LINE_STYLE_NO_PREFERENCE] = "PenLineStyleNoPreference",
 };
 
 static const char *leds[LED_MAX + 1] = {
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c6b27aab9041..54ff99453a44 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -925,6 +925,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			}
 			break;
 
+		case 0x38: /* Transducer Index */
+			map_msc(MSC_PEN_ID);
+			break;
+
 		case 0x3b: /* Battery Strength */
 			hidinput_setup_battery(device, HID_INPUT_REPORT, field, false);
 			usage->type = EV_PWR;
@@ -972,6 +976,38 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			map_msc(MSC_SERIAL);
 			break;
 
+		case 0x5c: /* USI Pen Color */
+			map_msc(MSC_PEN_COLOR);
+			break;
+
+		case 0x5e: /* USI Pen Line Width */
+			map_abs(ABS_TOOL_WIDTH);
+			break;
+
+		case 0x72: /* USI Pen preferred line style: Ink */
+			map_msc(MSC_PEN_LINE_STYLE_INK);
+			break;
+
+		case 0x73: /* USI Pen preferred line style: Pencil */
+			map_msc(MSC_PEN_LINE_STYLE_PENCIL);
+			break;
+
+		case 0x74: /* USI Pen preferred line style: Highlighter */
+			map_msc(MSC_PEN_LINE_STYLE_HIGHLIGHTER);
+			break;
+
+		case 0x75: /* USI Pen preferred line style: Chisel Marker */
+			map_msc(MSC_PEN_LINE_STYLE_CHISEL_MARKER);
+			break;
+
+		case 0x76: /* USI Pen preferred line style: Brush */
+			map_msc(MSC_PEN_LINE_STYLE_BRUSH);
+			break;
+
+		case 0x77: /* USI Pen no preferred line style */
+			map_msc(MSC_PEN_LINE_STYLE_NO_PREFERENCE);
+			break;
+
 		default:  goto unknown;
 		}
 		break;
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 549590e9c644..db0d0ae27161 100644
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
index dff8e7f17074..486a1d6c9db1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -930,7 +930,15 @@
 #define MSC_RAW			0x03
 #define MSC_SCAN		0x04
 #define MSC_TIMESTAMP		0x05
-#define MSC_MAX			0x07
+#define MSC_PEN_ID		0x06
+#define MSC_PEN_COLOR		0x07
+#define MSC_PEN_LINE_STYLE_INK			0x08
+#define MSC_PEN_LINE_STYLE_PENCIL		0x09
+#define MSC_PEN_LINE_STYLE_HIGHLIGHTER		0x0a
+#define MSC_PEN_LINE_STYLE_CHISEL_MARKER	0x0b
+#define MSC_PEN_LINE_STYLE_BRUSH		0x0c
+#define MSC_PEN_LINE_STYLE_NO_PREFERENCE	0x0d
+#define MSC_MAX			0x0d
 #define MSC_CNT			(MSC_MAX+1)
 
 /*
-- 
2.25.1

