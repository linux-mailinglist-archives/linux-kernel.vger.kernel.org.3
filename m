Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAB49CF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbiAZQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:19:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242939AbiAZQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643213946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTEskCYipmEYa3P9pdqv0PwdXf6r+e7EEf/JZcOom+Y=;
        b=DMTUfgnD6JiYr94qMR5TST1revcudV0XsiR0lh8F2nttkDx57rVg8ukfPIZKApaPAGwzhU
        s2ZTPZnN+RIzp+h3zoT7RioCtt9190I6O0n6fRO8MqO0lupNAJisrFpfqqpLhnVWEg5hmj
        AWUPzad/oO3SJx03YfP1LZDXSJp3SYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-zQ91oVP8OcmwEdQlzWXtDQ-1; Wed, 26 Jan 2022 11:19:00 -0500
X-MC-Unique: zQ91oVP8OcmwEdQlzWXtDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E30FD10247A8;
        Wed, 26 Jan 2022 16:18:58 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A76E798DD;
        Wed, 26 Jan 2022 16:18:56 +0000 (UTC)
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
Subject: [PATCH 05/12] HID: input: rework spaghetti code with switch statements
Date:   Wed, 26 Jan 2022 17:18:25 +0100
Message-Id: <20220126161832.3193805-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using multiple `if (a == b)`, use the switch statement
which has been done exactly for that.

There should be no functional change (I don't expect moving down
HID_QUIRK_{X|Y}_INVERT having any impact.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 80 ++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d2562497a726..54b3e9c5ccc4 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1354,12 +1354,6 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	input = field->hidinput->input;
 
-	if (usage->type == EV_ABS &&
-	    (((*quirks & HID_QUIRK_X_INVERT) && usage->code == ABS_X) ||
-	     ((*quirks & HID_QUIRK_Y_INVERT) && usage->code == ABS_Y))) {
-		value = field->logical_maximum - value;
-	}
-
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
@@ -1370,12 +1364,12 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 	}
 
-	if (usage->hid == HID_DG_INVERT) {
+	switch (usage->hid) {
+	case HID_DG_INVERT:
 		*quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
 		return;
-	}
 
-	if (usage->hid == HID_DG_INRANGE) {
+	case HID_DG_INRANGE:
 		if (value) {
 			input_event(input, usage->type, (*quirks & HID_QUIRK_INVERT) ? BTN_TOOL_RUBBER : usage->code, 1);
 			return;
@@ -1383,46 +1377,58 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		input_event(input, usage->type, usage->code, 0);
 		input_event(input, usage->type, BTN_TOOL_RUBBER, 0);
 		return;
-	}
 
-	if (usage->hid == HID_DG_TIPPRESSURE && (*quirks & HID_QUIRK_NOTOUCH)) {
-		int a = field->logical_minimum;
-		int b = field->logical_maximum;
-		input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
-	}
+	case HID_DG_TIPPRESSURE:
+		if (*quirks & HID_QUIRK_NOTOUCH) {
+			int a = field->logical_minimum;
+			int b = field->logical_maximum;
+
+			input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
+		}
+		break;
 
-	if (usage->hid == (HID_UP_PID | 0x83UL)) { /* Simultaneous Effects Max */
+	case HID_UP_PID | 0x83UL: /* Simultaneous Effects Max */
 		dbg_hid("Maximum Effects - %d\n",value);
 		return;
-	}
 
-	if (usage->hid == (HID_UP_PID | 0x7fUL)) {
+	case HID_UP_PID | 0x7fUL:
 		dbg_hid("PID Pool Report\n");
 		return;
 	}
 
-	if ((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
-		return;
+	switch (usage->type) {
+	case EV_KEY:
+		if (usage->code == 0) /* Key 0 is "unassigned", not KEY_UNKNOWN */
+			return;
+		break;
 
-	if ((usage->type == EV_REL) && (usage->code == REL_WHEEL_HI_RES ||
-					usage->code == REL_HWHEEL_HI_RES)) {
-		hidinput_handle_scroll(usage, input, value);
-		return;
-	}
+	case EV_REL:
+		if (usage->code == REL_WHEEL_HI_RES ||
+		    usage->code == REL_HWHEEL_HI_RES) {
+			hidinput_handle_scroll(usage, input, value);
+			return;
+		}
+		break;
 
-	if ((usage->type == EV_ABS) && (field->flags & HID_MAIN_ITEM_RELATIVE) &&
-			(usage->code == ABS_VOLUME)) {
-		int count = abs(value);
-		int direction = value > 0 ? KEY_VOLUMEUP : KEY_VOLUMEDOWN;
-		int i;
+	case EV_ABS:
+		if ((field->flags & HID_MAIN_ITEM_RELATIVE) &&
+		    usage->code == ABS_VOLUME) {
+			int count = abs(value);
+			int direction = value > 0 ? KEY_VOLUMEUP : KEY_VOLUMEDOWN;
+			int i;
+
+			for (i = 0; i < count; i++) {
+				input_event(input, EV_KEY, direction, 1);
+				input_sync(input);
+				input_event(input, EV_KEY, direction, 0);
+				input_sync(input);
+			}
+			return;
 
-		for (i = 0; i < count; i++) {
-			input_event(input, EV_KEY, direction, 1);
-			input_sync(input);
-			input_event(input, EV_KEY, direction, 0);
-			input_sync(input);
-		}
-		return;
+		} else if (((*quirks & HID_QUIRK_X_INVERT) && usage->code == ABS_X) ||
+			   ((*quirks & HID_QUIRK_Y_INVERT) && usage->code == ABS_Y))
+			value = field->logical_maximum - value;
+		break;
 	}
 
 	/*
-- 
2.33.1

