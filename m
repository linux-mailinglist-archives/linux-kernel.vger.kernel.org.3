Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE01249CF65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiAZQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242092AbiAZQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643213938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Csg0k3JN5nLMfOor1DtTmLyZk4+42tuFkOSOtb2Gq2o=;
        b=RP4so9JNxGK0YEuCGg0eTzuPIPOwxXd0Unch0r+3uGZ/bt+HKVbKEk+Z1Dd5WgHSt5tS61
        q+HvnG4wvSS3NnuxUqW5urQWnXsqPZwxEhVlflZr8BmAvgR/cbCWo14gjjWKtjcK4N3iWD
        FgKC8mQXzcNMKifYtsIZKJVtWUl337Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-8PBV9zodPbaCfc7vdOjUhQ-1; Wed, 26 Jan 2022 11:18:54 -0500
X-MC-Unique: 8PBV9zodPbaCfc7vdOjUhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E871783DD21;
        Wed, 26 Jan 2022 16:18:52 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 569D6798DD;
        Wed, 26 Jan 2022 16:18:50 +0000 (UTC)
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
Subject: [PATCH 03/12] HID: core: split data fetching from processing in hid_input_field()
Date:   Wed, 26 Jan 2022 17:18:23 +0100
Message-Id: <20220126161832.3193805-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory patch for being able to process the usages
out of order. We split the retrieval of the data in a separate function
and also split out the processing of the usages depending if the field
is an array or a variable.

No functional changes from this patch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 96 +++++++++++++++++++++++++++++++++---------
 include/linux/hid.h    |  3 +-
 2 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index fad4dbdf6391..34188d7ac0f7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1544,13 +1544,12 @@ static inline int hid_array_value_is_valid(struct hid_field *field,
 }
 
 /*
- * Analyse a received field, and fetch the data from it. The field
- * content is stored for next report processing (we do differential
- * reporting to the layer).
+ * Fetch the field from the data. The field content is stored for next
+ * report processing (we do differential reporting to the layer).
  */
-
-static void hid_input_field(struct hid_device *hid, struct hid_field *field,
-			    __u8 *data, int interrupt)
+static void hid_input_fetch_field(struct hid_device *hid,
+				  struct hid_field *field,
+				  __u8 *data)
 {
 	unsigned n;
 	unsigned count = field->report_count;
@@ -1561,6 +1560,7 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 
 	value = field->new_value;
 	memset(value, 0, count * sizeof(__s32));
+	field->ignored = false;
 
 	for (n = 0; n < count; n++) {
 
@@ -1572,21 +1572,56 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 		/* Ignore report if ErrorRollOver */
 		if (!(field->flags & HID_MAIN_ITEM_VARIABLE) &&
 		    hid_array_value_is_valid(field, value[n]) &&
-		    field->usage[value[n] - min].hid == HID_UP_KEYBOARD + 1)
+		    field->usage[value[n] - min].hid == HID_UP_KEYBOARD + 1) {
+			field->ignored = true;
 			return;
+		}
 	}
+}
 
-	for (n = 0; n < count; n++) {
+/*
+ * Process a received variable field.
+ */
 
-		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
-			hid_process_event(hid,
-					  field,
-					  &field->usage[n],
-					  value[n],
-					  interrupt);
-			continue;
-		}
+static void hid_input_var_field(struct hid_device *hid,
+				struct hid_field *field,
+				int interrupt)
+{
+	unsigned int count = field->report_count;
+	__s32 *value = field->new_value;
+	unsigned int n;
+
+	for (n = 0; n < count; n++)
+		hid_process_event(hid,
+				  field,
+				  &field->usage[n],
+				  value[n],
+				  interrupt);
+
+	memcpy(field->value, value, count * sizeof(__s32));
+}
 
+/*
+ * Process a received array field. The field content is stored for
+ * next report processing (we do differential reporting to the layer).
+ */
+
+static void hid_input_array_field(struct hid_device *hid,
+				  struct hid_field *field,
+				  int interrupt)
+{
+	unsigned int n;
+	unsigned int count = field->report_count;
+	__s32 min = field->logical_minimum;
+	__s32 *value;
+
+	value = field->new_value;
+
+	/* ErrorRollOver */
+	if (field->ignored)
+		return;
+
+	for (n = 0; n < count; n++) {
 		if (hid_array_value_is_valid(field, field->value[n]) &&
 		    search(value, field->value[n], count))
 			hid_process_event(hid,
@@ -1607,6 +1642,31 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 	memcpy(field->value, value, count * sizeof(__s32));
 }
 
+/*
+ * Analyse a received report, and fetch the data from it. The field
+ * content is stored for next report processing (we do differential
+ * reporting to the layer).
+ */
+static void hid_process_report(struct hid_device *hid,
+			       struct hid_report *report,
+			       __u8 *data,
+			       int interrupt)
+{
+	unsigned int a;
+	struct hid_field *field;
+
+	for (a = 0; a < report->maxfield; a++) {
+		field = report->field[a];
+
+		hid_input_fetch_field(hid, field, data);
+
+		if (field->flags & HID_MAIN_ITEM_VARIABLE)
+			hid_input_var_field(hid, field, interrupt);
+		else
+			hid_input_array_field(hid, field, interrupt);
+	}
+}
+
 /*
  * Output the field into the report.
  */
@@ -1768,7 +1828,6 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
 	struct hid_driver *hdrv;
-	unsigned int a;
 	u32 rsize, csize = size;
 	u8 *cdata = data;
 	int ret = 0;
@@ -1804,8 +1863,7 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 	}
 
 	if (hid->claimed != HID_CLAIMED_HIDRAW && report->maxfield) {
-		for (a = 0; a < report->maxfield; a++)
-			hid_input_field(hid, report->field[a], cdata, interrupt);
+		hid_process_report(hid, report, cdata, interrupt);
 		hdrv = hid->driver;
 		if (hdrv && hdrv->report)
 			hdrv->report(hid, report);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3fbfe0986659..cf79eb3da465 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -342,7 +342,7 @@ struct hid_item {
  * HID device quirks.
  */
 
-/* 
+/*
  * Increase this if you need to configure more HID quirks at module load time
  */
 #define MAX_USBHID_BOOT_QUIRKS 4
@@ -483,6 +483,7 @@ struct hid_field {
 	__s32     physical_maximum;
 	__s32     unit_exponent;
 	unsigned  unit;
+	bool      ignored;		/* this field is ignored in this event */
 	struct hid_report *report;	/* associated report */
 	unsigned index;			/* index into report->field[] */
 	/* hidinput data */
-- 
2.33.1

