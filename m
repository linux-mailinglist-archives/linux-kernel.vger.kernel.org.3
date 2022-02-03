Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C34A8695
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351474AbiBCOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351313AbiBCOds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2G3/sS/C1EPSPkBFd3nsE75tTouY/LNBfeLI0lhMMcQ=;
        b=gQslpc8l+nspgJCgk/EOrir7Ek2z7KQ/wXOIwYL1YV2StQ+PT4M4W98lAZh/SC9X1Ys16+
        lkJRpKfuqGeTXbbwKg3ywsPtWSDZF9UAMBqMLIJS5Cv2ncFaAWHsfGCyrx8bPPrgOj0OwV
        yzVw/Hal/UPWrVa2QTQBEIXtBadKFPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-bW39gFqeM-i7cBZ6HGeAtA-1; Thu, 03 Feb 2022 09:33:42 -0500
X-MC-Unique: bW39gFqeM-i7cBZ6HGeAtA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EDA78145E4;
        Thu,  3 Feb 2022 14:33:39 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 085347D4AF;
        Thu,  3 Feb 2022 14:33:11 +0000 (UTC)
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
Subject: [PATCH v2 08/12] HID: core: for input reports, process the usages by priority list
Date:   Thu,  3 Feb 2022 15:32:22 +0100
Message-Id: <20220203143226.4023622-9-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a list of fields/usages by priority order,
walk through that list to process the inputs instead of using the
order provided by the manufacturer.

Note that this changes the way we update the values in the struct
hid_field:
Previously, once a field was processed, we updated the new values.
Now we need to wait for the entire report to be processed to update
the values.

I don't think it will be an issue: because we were relying on the device
ordering, there were no guarantees to have a field stored before an other.
Which is why we introduced .report() in drivers to have those values
updated.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 45 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b38528118642..db925794fbe6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1657,17 +1657,48 @@ static void hid_process_report(struct hid_device *hid,
 			       int interrupt)
 {
 	unsigned int a;
+	struct hid_field_entry *entry;
 	struct hid_field *field;
 
-	for (a = 0; a < report->maxfield; a++) {
-		field = report->field[a];
+	/* first retrieve all incoming values in data */
+	for (a = 0; a < report->maxfield; a++)
+		hid_input_fetch_field(hid, field = report->field[a], data);
+
+	if (!list_empty(&report->field_entry_list)) {
+		/* INPUT_REPORT, we have a priority list of fields */
+		list_for_each_entry(entry,
+				    &report->field_entry_list,
+				    list) {
+			field = entry->field;
+
+			if (field->flags & HID_MAIN_ITEM_VARIABLE)
+				hid_process_event(hid,
+						  field,
+						  &field->usage[entry->index],
+						  field->new_value[entry->index],
+						  interrupt);
+			else
+				hid_input_array_field(hid, field, interrupt);
+		}
 
-		hid_input_fetch_field(hid, field, data);
+		/* we need to do the memcpy at the end for var items */
+		for (a = 0; a < report->maxfield; a++) {
+			field = report->field[a];
 
-		if (field->flags & HID_MAIN_ITEM_VARIABLE)
-			hid_input_var_field(hid, field, interrupt);
-		else
-			hid_input_array_field(hid, field, interrupt);
+			if (field->flags & HID_MAIN_ITEM_VARIABLE)
+				memcpy(field->value, field->new_value,
+				       field->report_count * sizeof(__s32));
+		}
+	} else {
+		/* FEATURE_REPORT, regular processing */
+		for (a = 0; a < report->maxfield; a++) {
+			field = report->field[a];
+
+			if (field->flags & HID_MAIN_ITEM_VARIABLE)
+				hid_input_var_field(hid, field, interrupt);
+			else
+				hid_input_array_field(hid, field, interrupt);
+		}
 	}
 }
 
-- 
2.33.1

