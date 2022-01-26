Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF4C49CF71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbiAZQTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243097AbiAZQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643213950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5j0N0MXhPzEQU00nTmU5V9bnIUoEjM+0zli124kmSk=;
        b=Nv+TLIQrzA/U8K6kJX5OPf+eQpPCche0maEQQSRkEj2KFaXnBORnVvkfmuw8Bd5RUoI7n1
        24LJvx3/Yi9OboCqYxS6Dqoqv/Jp8po2DUiKE6/5n233H5O/b0Dhc3T/AOW3FEWnvlaEan
        pqRP+2xvHoG1taLcdOgqiraDlC8r1Zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-NkqBYRftOqemm91jboaE1g-1; Wed, 26 Jan 2022 11:19:06 -0500
X-MC-Unique: NkqBYRftOqemm91jboaE1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF34B1923E20;
        Wed, 26 Jan 2022 16:19:04 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3904F79A1F;
        Wed, 26 Jan 2022 16:19:02 +0000 (UTC)
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
Subject: [PATCH 07/12] HID: compute an ordered list of input fields to process
Date:   Wed, 26 Jan 2022 17:18:27 +0100
Message-Id: <20220126161832.3193805-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used in a later commit:
we build a list of input fields (and usage_index) that is ordered based
on a usage priority.

Changing the usage priority allows to re-order the processed list, meaning
that we can enforce some usages to be process before others.

For instance, before processing InRange in the HID tablets, we need to
know if we are using the eraser (side or button). Enforcing a higher
(lower number) priority for Invert allows to force the input stack to
process that field before.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 105 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/hid.h    |  10 ++++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 34188d7ac0f7..b38528118642 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -81,6 +81,7 @@ struct hid_report *hid_register_report(struct hid_device *device,
 	report_enum->report_id_hash[id] = report;
 
 	list_add_tail(&report->list, &report_enum->report_list);
+	INIT_LIST_HEAD(&report->field_entry_list);
 
 	return report;
 }
@@ -101,7 +102,7 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 
 	field = kzalloc((sizeof(struct hid_field) +
 			 usages * sizeof(struct hid_usage) +
-			 2 * usages * sizeof(unsigned int)), GFP_KERNEL);
+			 3 * usages * sizeof(unsigned int)), GFP_KERNEL);
 	if (!field)
 		return NULL;
 
@@ -110,6 +111,7 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 	field->usage = (struct hid_usage *)(field + 1);
 	field->value = (s32 *)(field->usage + usages);
 	field->new_value = (s32 *)(field->value + usages);
+	field->usages_priorities = (s32 *)(field->new_value + usages);
 	field->report = report;
 
 	return field;
@@ -657,6 +659,8 @@ static void hid_free_report(struct hid_report *report)
 {
 	unsigned n;
 
+	kfree(report->field_entries);
+
 	for (n = 0; n < report->maxfield; n++)
 		kfree(report->field[n]);
 	kfree(report);
@@ -1667,6 +1671,103 @@ static void hid_process_report(struct hid_device *hid,
 	}
 }
 
+/*
+ * Insert a given usage_index in a field in the list
+ * of processed usages in the report.
+ *
+ * The elements of lower priority score are processed
+ * first.
+ */
+static void __hid_insert_field_entry(struct hid_device *hid,
+				     struct hid_report *report,
+				     struct hid_field_entry *entry,
+				     struct hid_field *field,
+				     unsigned int usage_index)
+{
+	struct hid_field_entry *next;
+
+	entry->field = field;
+	entry->index = usage_index;
+	entry->priority = field->usages_priorities[usage_index];
+
+	/* insert the element at the correct position */
+	list_for_each_entry(next,
+			    &report->field_entry_list,
+			    list) {
+		/*
+		 * the priority of our element is strictly higher
+		 * than the next one, insert it before
+		 */
+		if (entry->priority > next->priority) {
+			list_add_tail(&entry->list, &next->list);
+			return;
+		}
+	}
+
+	/* lowest priority score: insert at the end */
+	list_add_tail(&entry->list, &report->field_entry_list);
+}
+
+static void hid_report_process_ordering(struct hid_device *hid,
+					struct hid_report *report)
+{
+	struct hid_field *field;
+	struct hid_field_entry *entries;
+	unsigned int a, u, usages;
+	unsigned int count = 0;
+
+	/* count the number of individual fields in the report */
+	for (a = 0; a < report->maxfield; a++) {
+		field = report->field[a];
+
+		if (field->flags & HID_MAIN_ITEM_VARIABLE)
+			count += field->report_count;
+		else
+			count++;
+	}
+
+	/* allocate the memory to process the fields */
+	entries = kcalloc(count, sizeof(*entries), GFP_KERNEL);
+	if (!entries)
+		return;
+
+	report->field_entries = entries;
+
+	/*
+	 * walk through all fields in the report and
+	 * store them by priority order in report->field_entry_list
+	 *
+	 * - Var elements are individualized (field + usage_index)
+	 * - Arrays are taken as one, we can not chose an order for them
+	 */
+	usages = 0;
+	for (a = 0; a < report->maxfield; a++) {
+		field = report->field[a];
+
+		if (field->flags & HID_MAIN_ITEM_VARIABLE) {
+			for (u = 0; u < field->report_count; u++) {
+				__hid_insert_field_entry(hid, report,
+							 &entries[usages],
+							 field, u);
+				usages++;
+			}
+		} else {
+			__hid_insert_field_entry(hid, report, &entries[usages],
+						 field, 0);
+			usages++;
+		}
+	}
+}
+
+static void hid_process_ordering(struct hid_device *hid)
+{
+	struct hid_report *report;
+	struct hid_report_enum *report_enum = &hid->report_enum[HID_INPUT_REPORT];
+
+	list_for_each_entry(report, &report_enum->report_list, list)
+		hid_report_process_ordering(hid, report);
+}
+
 /*
  * Output the field into the report.
  */
@@ -2050,6 +2151,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		return -ENODEV;
 	}
 
+	hid_process_ordering(hdev);
+
 	if ((hdev->claimed & HID_CLAIMED_INPUT) &&
 			(connect_mask & HID_CONNECT_FF) && hdev->ff_init)
 		hdev->ff_init(hdev);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index cf79eb3da465..f25020c0d6b8 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -477,6 +477,7 @@ struct hid_field {
 	unsigned  report_type;		/* (input,output,feature) */
 	__s32    *value;		/* last known value(s) */
 	__s32    *new_value;		/* newly read value(s) */
+	__s32    *usages_priorities;	/* priority of each usage when reading the report */
 	__s32     logical_minimum;
 	__s32     logical_maximum;
 	__s32     physical_minimum;
@@ -493,13 +494,22 @@ struct hid_field {
 
 #define HID_MAX_FIELDS 256
 
+struct hid_field_entry {
+	struct list_head list;
+	struct hid_field *field;
+	unsigned int index;
+	__s32 priority;
+};
+
 struct hid_report {
 	struct list_head list;
 	struct list_head hidinput_list;
+	struct list_head field_entry_list;		/* ordered list of input fields */
 	unsigned int id;				/* id of this report */
 	unsigned int type;				/* report type */
 	unsigned int application;			/* application usage for this report */
 	struct hid_field *field[HID_MAX_FIELDS];	/* fields of the report */
+	struct hid_field_entry *field_entries;		/* allocated memory of input field_entry */
 	unsigned maxfield;				/* maximum valid field index */
 	unsigned size;					/* size of the report (bits) */
 	struct hid_device *device;			/* associated device */
-- 
2.33.1

