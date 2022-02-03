Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E04A86A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiBCOgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351367AbiBCOd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgR1T10PmKgYXr3n6p0CSnu6UNlPvhOSkcyMPTZFwsA=;
        b=FCpWuyz9QBlHoH1yXWrtXULrfJTsPpnMGI8ly9ihpS85i18zgWceHBFalvX2x0Wv5UPZNm
        FhGwejHRIM/lYGh+v5xxtxwGQbwLJBW39TDNcWgIsrgNkJoUtwGw5s+7LLcbT+8P1lrz+Z
        tTyEvLq1q8FTqEHbvPRxt3FnzF9xDYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-7vUL1IaQOVyofIhOq0N3fw-1; Thu, 03 Feb 2022 09:33:53 -0500
X-MC-Unique: 7vUL1IaQOVyofIhOq0N3fw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14336190A7A1;
        Thu,  3 Feb 2022 14:33:51 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 956E07D499;
        Thu,  3 Feb 2022 14:33:48 +0000 (UTC)
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
Subject: [PATCH v2 11/12] HID: input: accommodate priorities for slotted devices
Date:   Thu,  3 Feb 2022 15:32:25 +0100
Message-Id: <20220203143226.4023622-12-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multitouch devices in hybrid mode are reporting multiple times the
same collection. We should accommodate for this in our handling
of priorities by defining the slots they belong to.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 103 ++++++++++++++++++++++++++++++++++++----
 include/linux/hid.h     |   1 +
 2 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9f8853640648..56d4e91c4750 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -48,6 +48,16 @@ static const struct {
 	__s32 y;
 }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
+struct usage_priority {
+	__u32 usage;			/* the HID usage associated */
+	bool global;			/* we assume all usages to be slotted,
+					 * unless global
+					 */
+	unsigned int slot_overwrite;	/* for globals: allows to set the usage
+					 * before or after the slots
+					 */
+};
+
 /*
  * hid-input will convert this list into priorities:
  * the first element will have the highest priority
@@ -57,17 +67,30 @@ static const struct {
  * hid-input will then shift the priority by 8 bits to leave some space
  * in case drivers want to interleave other fields.
  *
+ * To accommodate slotted devices, the slot priority is
+ * defined in the next 8 bits (defined by 0xff - slot).
+ *
  * If drivers want to add fields before those, hid-input will
  * leave out the first 8 bits of the priority value.
  *
  * This still leaves us 65535 individual priority values.
  */
-static const __u32 hidinput_usages_priorities[] = {
-	HID_DG_ERASER,		/* Eraser (eraser touching) must always come before tipswitch */
-	HID_DG_INVERT,		/* Invert must always come before In Range */
-	HID_DG_TIPSWITCH,	/* Is the tip of the tool touching? */
-	HID_DG_TIPPRESSURE,	/* Tip Pressure might emulate tip switch */
-	HID_DG_INRANGE,		/* In Range needs to come after the other tool states */
+static const struct usage_priority hidinput_usages_priorities[] = {
+	{ /* Eraser (eraser touching) must always come before tipswitch */
+	  .usage = HID_DG_ERASER,
+	},
+	{ /* Invert must always come before In Range */
+	  .usage = HID_DG_INVERT,
+	},
+	{ /* Is the tip of the tool touching? */
+	  .usage = HID_DG_TIPSWITCH,
+	},
+	{ /* Tip Pressure might emulate tip switch */
+	  .usage = HID_DG_TIPPRESSURE,
+	},
+	{ /* In Range needs to come after the other tool states */
+	  .usage = HID_DG_INRANGE,
+	},
 };
 
 #define map_abs(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_ABS, (c))
@@ -612,6 +635,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 {
 	struct input_dev *input = hidinput->input;
 	struct hid_device *device = input_get_drvdata(input);
+	const struct usage_priority *usage_priority = NULL;
 	int max = 0, code;
 	unsigned int i = 0;
 	unsigned long *bit = NULL;
@@ -633,13 +657,26 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 	/* assign a priority based on the static list declared here */
 	for (i = 0; i < ARRAY_SIZE(hidinput_usages_priorities); i++) {
-		if (usage->hid == hidinput_usages_priorities[i]) {
+		if (usage->hid == hidinput_usages_priorities[i].usage) {
+			usage_priority = &hidinput_usages_priorities[i];
+
 			field->usages_priorities[usage_index] =
 				(ARRAY_SIZE(hidinput_usages_priorities) - i) << 8;
 			break;
 		}
 	}
 
+	/*
+	 * For slotted devices, we need to also add the slot index
+	 * in the priority.
+	 */
+	if (usage_priority && usage_priority->global)
+		field->usages_priorities[usage_index] |=
+			usage_priority->slot_overwrite;
+	else
+		field->usages_priorities[usage_index] |=
+			(0xff - field->slot_idx) << 16;
+
 	if (device->driver->input_mapping) {
 		int ret = device->driver->input_mapping(device, hidinput, field,
 				usage, &bit, &max);
@@ -2068,7 +2105,57 @@ static struct hid_input *hidinput_match_application(struct hid_report *report)
 static inline void hidinput_configure_usages(struct hid_input *hidinput,
 					     struct hid_report *report)
 {
-	int i, j;
+	int i, j, k;
+	int first_field_index = 0;
+	int slot_collection_index = -1;
+	int prev_collection_index = -1;
+	unsigned int slot_idx = 0;
+	struct hid_field *field;
+
+	/*
+	 * First tag all the fields that are part of a slot,
+	 * a slot needs to have one Contact ID in the collection
+	 */
+	for (i = 0; i < report->maxfield; i++) {
+		field = report->field[i];
+
+		/* ignore fields without usage */
+		if (field->maxusage < 1)
+			continue;
+
+		/*
+		 * janitoring when collection_index changes
+		 */
+		if (prev_collection_index != field->usage->collection_index) {
+			prev_collection_index = field->usage->collection_index;
+			first_field_index = i;
+		}
+
+		/*
+		 * if we already found a Contact ID in the collection,
+		 * tag and continue to the next.
+		 */
+		if (slot_collection_index == field->usage->collection_index) {
+			field->slot_idx = slot_idx;
+			continue;
+		}
+
+		/* check if the current field has Contact ID */
+		for (j = 0; j < field->maxusage; j++) {
+			if (field->usage[j].hid == HID_DG_CONTACTID) {
+				slot_collection_index = field->usage->collection_index;
+				slot_idx++;
+
+				/*
+				 * mark all previous fields and this one in the
+				 * current collection to be slotted.
+				 */
+				for (k = first_field_index; k <= i; k++)
+					report->field[k]->slot_idx = slot_idx;
+				break;
+			}
+		}
+	}
 
 	for (i = 0; i < report->maxfield; i++)
 		for (j = 0; j < report->field[i]->maxusage; j++)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index feb8df61168f..4363a63b9775 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -492,6 +492,7 @@ struct hid_field {
 	/* hidinput data */
 	struct hid_input *hidinput;	/* associated input structure */
 	__u16 dpad;			/* dpad input code */
+	unsigned int slot_idx;		/* slot index in a report */
 };
 
 #define HID_MAX_FIELDS 256
-- 
2.33.1

