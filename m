Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F44A863D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351209AbiBCOcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351195AbiBCOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nDKkpDSU0sxhq2xLBakc+ahxXjrPTKXfIyEVQpG6nk=;
        b=Mg8aystXKgsUCtsh+lV8whMHtPuwXsKmzfGMtIryhP9oMnppZnorU3JGp/KqzGw5crAbPk
        boCtdP7U+Qrs0vvrpCrHun0W5x739dB16eks4gTwFNkcmcvWMbz1RHCQFjcEkmAO/xHdBa
        fj7ynSO4KfI9wKfhTNfaAGjAp8Dbf9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-pR9MTwd3MCuGzqwKxzjVpg-1; Thu, 03 Feb 2022 09:32:43 -0500
X-MC-Unique: pR9MTwd3MCuGzqwKxzjVpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAEAD835B4C;
        Thu,  3 Feb 2022 14:32:41 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88E3A7D57D;
        Thu,  3 Feb 2022 14:32:39 +0000 (UTC)
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
Subject: [PATCH v2 01/12] HID: core: statically allocate read buffers
Date:   Thu,  3 Feb 2022 15:32:15 +0100
Message-Id: <20220203143226.4023622-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch for rethinking the generic processing
of HID reports.

We can actually pre-allocate all of our memory instead of dynamically
allocating/freeing it whenever we parse a report.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 12 +++++-------
 include/linux/hid.h    |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f1aed5bbd000..75e7b8447bf7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -101,7 +101,7 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 
 	field = kzalloc((sizeof(struct hid_field) +
 			 usages * sizeof(struct hid_usage) +
-			 usages * sizeof(unsigned)), GFP_KERNEL);
+			 2 * usages * sizeof(unsigned int)), GFP_KERNEL);
 	if (!field)
 		return NULL;
 
@@ -109,6 +109,7 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 	report->field[field->index] = field;
 	field->usage = (struct hid_usage *)(field + 1);
 	field->value = (s32 *)(field->usage + usages);
+	field->new_value = (s32 *)(field->value + usages);
 	field->report = report;
 
 	return field;
@@ -1541,9 +1542,8 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 	__s32 max = field->logical_maximum;
 	__s32 *value;
 
-	value = kmalloc_array(count, sizeof(__s32), GFP_ATOMIC);
-	if (!value)
-		return;
+	value = field->new_value;
+	memset(value, 0, count * sizeof(__s32));
 
 	for (n = 0; n < count; n++) {
 
@@ -1557,7 +1557,7 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 		    value[n] >= min && value[n] <= max &&
 		    value[n] - min < field->maxusage &&
 		    field->usage[value[n] - min].hid == HID_UP_KEYBOARD + 1)
-			goto exit;
+			return;
 	}
 
 	for (n = 0; n < count; n++) {
@@ -1581,8 +1581,6 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 	}
 
 	memcpy(field->value, value, count * sizeof(__s32));
-exit:
-	kfree(value);
 }
 
 /*
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 7487b0586fe6..3fbfe0986659 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -476,6 +476,7 @@ struct hid_field {
 	unsigned  report_count;		/* number of this field in the report */
 	unsigned  report_type;		/* (input,output,feature) */
 	__s32    *value;		/* last known value(s) */
+	__s32    *new_value;		/* newly read value(s) */
 	__s32     logical_minimum;
 	__s32     logical_maximum;
 	__s32     physical_minimum;
-- 
2.33.1

