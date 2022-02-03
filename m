Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF84A86A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348195AbiBCOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351388AbiBCOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wA0dI14eSZx5t7rwKADFrF7BN7CoS/Nrs6Pdks+yZFw=;
        b=A3hw5DEKyH80dCFxFNgiCP7KdTX6VFFG+f2oOjsA2liSMi+VLeC8rUqBhw5vlT+PKiS/A0
        UD0Ztsz0XMNdd4sbdvL/55YU1xIp3vZslBcYwe3AoeopzpUNCXWrRHxfOxeyPfiXs2e6lz
        9Qv2FNieiI3jY7x/CR1rrj5iRHABciE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-nG3ulzyBNvGamYiqbziOfQ-1; Thu, 03 Feb 2022 09:33:50 -0500
X-MC-Unique: nG3ulzyBNvGamYiqbziOfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E358145E0;
        Thu,  3 Feb 2022 14:33:48 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F8D97D499;
        Thu,  3 Feb 2022 14:33:42 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 10/12] HID: input: remove the need for HID_QUIRK_INVERT
Date:   Thu,  3 Feb 2022 15:32:24 +0100
Message-Id: <20220203143226.4023622-11-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HID_QUIRK_INVERT is kind of complex to deal with and was bogus.

Furthermore, it didn't make sense to use a global per struct hid_device
quirk for something dynamic as the current state.

Store the current tool information in the report itself, and re-order
the processing of the fields to enforce having all the tablet "state"
fields before getting to In Range and other input fields.

This way, we now have all the information whether a tool is present
or not while processing In Range.

This new behavior enforces that only one tool gets forwarded to userspace
at the same time, and that if either eraser or invert is set, we enforce
BTN_TOOL_RUBBER.

Note that the release of the previous tool now happens in its own EV_SYN
report so userspace doesn't get confused by having 2 tools.

These changes are tested in the following hid-tools regression tests:
https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

Changes in v2:
- rework the entire tool switching, this makes the processing
  slightly more complex but is better for existing userspace.
---
 drivers/hid/hid-input.c | 98 +++++++++++++++++++++++++++++++++++++----
 include/linux/hid.h     |  6 ++-
 2 files changed, 95 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 61d91117f4ae..9f8853640648 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -63,8 +63,11 @@ static const struct {
  * This still leaves us 65535 individual priority values.
  */
 static const __u32 hidinput_usages_priorities[] = {
+	HID_DG_ERASER,		/* Eraser (eraser touching) must always come before tipswitch */
 	HID_DG_INVERT,		/* Invert must always come before In Range */
-	HID_DG_INRANGE,
+	HID_DG_TIPSWITCH,	/* Is the tip of the tool touching? */
+	HID_DG_TIPPRESSURE,	/* Tip Pressure might emulate tip switch */
+	HID_DG_INRANGE,		/* In Range needs to come after the other tool states */
 };
 
 #define map_abs(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_ABS, (c))
@@ -1365,9 +1368,38 @@ static void hidinput_handle_scroll(struct hid_usage *usage,
 	input_event(input, EV_REL, usage->code, hi_res);
 }
 
+static void hid_report_release_tool(struct hid_report *report, struct input_dev *input,
+				    unsigned int tool)
+{
+	/* if the given tool is not currently reported, ignore */
+	if (!test_bit(tool, input->key))
+		return;
+
+	/*
+	 * if the given tool was previously set, release it,
+	 * release any TOUCH and send an EV_SYN
+	 */
+	input_event(input, EV_KEY, BTN_TOUCH, 0);
+	input_event(input, EV_KEY, tool, 0);
+	input_event(input, EV_SYN, SYN_REPORT, 0);
+
+	report->tool = 0;
+}
+
+static void hid_report_set_tool(struct hid_report *report, struct input_dev *input,
+				unsigned int new_tool)
+{
+	if (report->tool != new_tool)
+		hid_report_release_tool(report, input, report->tool);
+
+	input_event(input, EV_KEY, new_tool, 1);
+	report->tool = new_tool;
+}
+
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
 {
 	struct input_dev *input;
+	struct hid_report *report = field->report;
 	unsigned *quirks = &hid->quirks;
 
 	if (!usage->type)
@@ -1418,25 +1450,75 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	}
 
 	switch (usage->hid) {
+	case HID_DG_ERASER:
+		report->tool_active |= !!value;
+
+		/*
+		 * if eraser is set, we must enforce BTN_TOOL_RUBBER
+		 * to accommodate for devices not following the spec.
+		 */
+		if (value)
+			hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
+		else if (report->tool != BTN_TOOL_RUBBER)
+			/* value is off, tool is not rubber, ignore */
+			return;
+
+		/* let hid-input set BTN_TOUCH */
+		break;
+
 	case HID_DG_INVERT:
-		*quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
+		report->tool_active |= !!value;
+
+		/*
+		 * If invert is set, we store BTN_TOOL_RUBBER.
+		 */
+		if (value)
+			hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
+		else if (!report->tool_active)
+			/* tool_active not set means Invert and Eraser are not set */
+			hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
+
+		/* no further processing */
 		return;
 
 	case HID_DG_INRANGE:
-		if (value) {
-			input_event(input, usage->type, (*quirks & HID_QUIRK_INVERT) ? BTN_TOOL_RUBBER : usage->code, 1);
-			return;
+		report->tool_active |= !!value;
+
+		if (report->tool_active) {
+			/*
+			 * if tool is not set but is marked as active,
+			 * assume ours
+			 */
+			if (!report->tool)
+				hid_report_set_tool(report, input, usage->code);
+		} else {
+			hid_report_release_tool(report, input, usage->code);
 		}
-		input_event(input, usage->type, usage->code, 0);
-		input_event(input, usage->type, BTN_TOOL_RUBBER, 0);
+
+		/* reset tool_active for the next event */
+		report->tool_active = false;
+
+		/* no further processing */
 		return;
 
+	case HID_DG_TIPSWITCH:
+		report->tool_active |= !!value;
+
+		/* if tool is set to RUBBER we should ignore the current value */
+		if (report->tool == BTN_TOOL_RUBBER)
+			return;
+
+		break;
+
 	case HID_DG_TIPPRESSURE:
 		if (*quirks & HID_QUIRK_NOTOUCH) {
 			int a = field->logical_minimum;
 			int b = field->logical_maximum;
 
-			input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
+			if (value > a + ((b - a) >> 3)) {
+				input_event(input, EV_KEY, BTN_TOUCH, 1);
+				report->tool_active = true;
+			}
 		}
 		break;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index eaad0655b05c..feb8df61168f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -347,7 +347,7 @@ struct hid_item {
  */
 #define MAX_USBHID_BOOT_QUIRKS 4
 
-#define HID_QUIRK_INVERT			BIT(0)
+/* BIT(0) reserved for backward compatibility, was HID_QUIRK_INVERT */
 #define HID_QUIRK_NOTOUCH			BIT(1)
 #define HID_QUIRK_IGNORE			BIT(2)
 #define HID_QUIRK_NOGET				BIT(3)
@@ -515,6 +515,10 @@ struct hid_report {
 	unsigned maxfield;				/* maximum valid field index */
 	unsigned size;					/* size of the report (bits) */
 	struct hid_device *device;			/* associated device */
+
+	/* tool related state */
+	bool tool_active;				/* whether the current tool is active */
+	unsigned int tool;				/* BTN_TOOL_* */
 };
 
 #define HID_MAX_IDS 256
-- 
2.33.1

