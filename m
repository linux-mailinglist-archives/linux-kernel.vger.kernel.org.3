Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244AF49CF77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbiAZQTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243109AbiAZQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643213956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HY6dBUSJ0foycx8WGBmzVTABhlhALHZsF0lp5qfhzAI=;
        b=YNx0MVGeuOsVhrz4YqYgrx/80o1H6p7i89FfNFHKwN1C6lNzdPwQEffxyzvpkLucX9oLNA
        B+49cMk19g2h+UamNIOhot5nQFoWodsAp9DbW8pwVMTrKQB0P17aFFyqcNCVcDH2aw1k8C
        JFLL5++lVdgSGzbblu9eQgpSJYm4rWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19--zGUTFHdO5CmXdgE-_oT3w-1; Wed, 26 Jan 2022 11:19:12 -0500
X-MC-Unique: -zGUTFHdO5CmXdgE-_oT3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8B10874980;
        Wed, 26 Jan 2022 16:19:10 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F872798DD;
        Wed, 26 Jan 2022 16:19:08 +0000 (UTC)
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
Subject: [PATCH 09/12] HID: input: enforce Invert usage to be processed before InRange
Date:   Wed, 26 Jan 2022 17:18:29 +0100
Message-Id: <20220126161832.3193805-10-benjamin.tissoires@redhat.com>
In-Reply-To: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device exposes both Invert and InRange, Invert must be processed
before InRange. If we keep the order of the device and we process them
out of order, InRange will first set BTN_TOOL_PEN, and then Invert will
set BTN_TOOL_RUBBER. Userspace knows how to deal with that situation,
but fixing it in the kernel is now easier.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 34 ++++++++++++++++++++++++++++++++--
 include/linux/hid.h     |  4 +++-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 8770d9a2b2af..61d91117f4ae 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -48,6 +48,25 @@ static const struct {
 	__s32 y;
 }  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
 
+/*
+ * hid-input will convert this list into priorities:
+ * the first element will have the highest priority
+ * (the length of the following array) and the last
+ * element the lowest (1).
+ *
+ * hid-input will then shift the priority by 8 bits to leave some space
+ * in case drivers want to interleave other fields.
+ *
+ * If drivers want to add fields before those, hid-input will
+ * leave out the first 8 bits of the priority value.
+ *
+ * This still leaves us 65535 individual priority values.
+ */
+static const __u32 hidinput_usages_priorities[] = {
+	HID_DG_INVERT,		/* Invert must always come before In Range */
+	HID_DG_INRANGE,
+};
+
 #define map_abs(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_ABS, (c))
 #define map_rel(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_REL, (c))
 #define map_key(c)	hid_map_usage(hidinput, usage, &bit, &max, EV_KEY, (c))
@@ -586,11 +605,12 @@ static bool hidinput_field_in_collection(struct hid_device *device, struct hid_f
 }
 
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
-				     struct hid_usage *usage)
+				     struct hid_usage *usage, unsigned int usage_index)
 {
 	struct input_dev *input = hidinput->input;
 	struct hid_device *device = input_get_drvdata(input);
 	int max = 0, code;
+	unsigned int i = 0;
 	unsigned long *bit = NULL;
 
 	field->hidinput = hidinput;
@@ -608,6 +628,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		goto ignore;
 	}
 
+	/* assign a priority based on the static list declared here */
+	for (i = 0; i < ARRAY_SIZE(hidinput_usages_priorities); i++) {
+		if (usage->hid == hidinput_usages_priorities[i]) {
+			field->usages_priorities[usage_index] =
+				(ARRAY_SIZE(hidinput_usages_priorities) - i) << 8;
+			break;
+		}
+	}
+
 	if (device->driver->input_mapping) {
 		int ret = device->driver->input_mapping(device, hidinput, field,
 				usage, &bit, &max);
@@ -1962,7 +1991,8 @@ static inline void hidinput_configure_usages(struct hid_input *hidinput,
 	for (i = 0; i < report->maxfield; i++)
 		for (j = 0; j < report->field[i]->maxusage; j++)
 			hidinput_configure_usage(hidinput, report->field[i],
-						 report->field[i]->usage + j);
+						 report->field[i]->usage + j,
+						 j);
 }
 
 /*
diff --git a/include/linux/hid.h b/include/linux/hid.h
index f25020c0d6b8..eaad0655b05c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -477,7 +477,9 @@ struct hid_field {
 	unsigned  report_type;		/* (input,output,feature) */
 	__s32    *value;		/* last known value(s) */
 	__s32    *new_value;		/* newly read value(s) */
-	__s32    *usages_priorities;	/* priority of each usage when reading the report */
+	__s32    *usages_priorities;	/* priority of each usage when reading the report
+					 * bits 8-16 are reserved for hid-input usage
+					 */
 	__s32     logical_minimum;
 	__s32     logical_maximum;
 	__s32     physical_minimum;
-- 
2.33.1

