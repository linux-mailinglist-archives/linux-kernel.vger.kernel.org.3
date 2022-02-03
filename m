Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3BC4A864C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351200AbiBCOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351255AbiBCOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tuAKfawLm+JaDbn81DenL5Yg02akDAVQDmdL6NAxhv0=;
        b=dH0pgGkyQDHlDGxKSoKtQ2ItF8BRel3riKI2EqFJsiuDZvEikg3A5JRGoHoE1R2wYk5OvC
        CvLa9ywVTXOEJ/ncjpLD8VY1NICI34TER0mm1NC4iBtewynjSTkNoAq7Z8kXUEYGc1cET+
        6XAk+vG+XqaF3SVM0pNPWQVAVhknMCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-pcu_eJfJO1qd2g253Fw5Fg-1; Thu, 03 Feb 2022 09:33:14 -0500
X-MC-Unique: pcu_eJfJO1qd2g253Fw5Fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2301091DA1;
        Thu,  3 Feb 2022 14:33:08 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 553CE7D4D0;
        Thu,  3 Feb 2022 14:33:06 +0000 (UTC)
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
Subject: [PATCH v2 06/12] HID: input: move up out-of-range processing of input values
Date:   Thu,  3 Feb 2022 15:32:20 +0100
Message-Id: <20220203143226.4023622-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It actually makes sense to clamp the value to its boundaries before
doing further processing.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 54b3e9c5ccc4..8770d9a2b2af 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1364,6 +1364,30 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 	}
 
+	/*
+	 * Ignore out-of-range values as per HID specification,
+	 * section 5.10 and 6.2.25, when NULL state bit is present.
+	 * When it's not, clamp the value to match Microsoft's input
+	 * driver as mentioned in "Required HID usages for digitizers":
+	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
+	 *
+	 * The logical_minimum < logical_maximum check is done so that we
+	 * don't unintentionally discard values sent by devices which
+	 * don't specify logical min and max.
+	 */
+	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+	    field->logical_minimum < field->logical_maximum) {
+		if (field->flags & HID_MAIN_ITEM_NULL_STATE &&
+		    (value < field->logical_minimum ||
+		     value > field->logical_maximum)) {
+			dbg_hid("Ignoring out-of-range value %x\n", value);
+			return;
+		}
+		value = clamp(value,
+			      field->logical_minimum,
+			      field->logical_maximum);
+	}
+
 	switch (usage->hid) {
 	case HID_DG_INVERT:
 		*quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
@@ -1431,30 +1455,6 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		break;
 	}
 
-	/*
-	 * Ignore out-of-range values as per HID specification,
-	 * section 5.10 and 6.2.25, when NULL state bit is present.
-	 * When it's not, clamp the value to match Microsoft's input
-	 * driver as mentioned in "Required HID usages for digitizers":
-	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
-	 *
-	 * The logical_minimum < logical_maximum check is done so that we
-	 * don't unintentionally discard values sent by devices which
-	 * don't specify logical min and max.
-	 */
-	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
-	    (field->logical_minimum < field->logical_maximum)) {
-		if (field->flags & HID_MAIN_ITEM_NULL_STATE &&
-		    (value < field->logical_minimum ||
-		     value > field->logical_maximum)) {
-			dbg_hid("Ignoring out-of-range value %x\n", value);
-			return;
-		}
-		value = clamp(value,
-			      field->logical_minimum,
-			      field->logical_maximum);
-	}
-
 	/*
 	 * Ignore reports for absolute data if the data didn't change. This is
 	 * not only an optimization but also fixes 'dead' key reports. Some
-- 
2.33.1

