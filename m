Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612404A8648
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351240AbiBCOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351200AbiBCOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scDj/oJvhoJAgdPIlS5IhQpZrZh8PkiSfRjw1220pU4=;
        b=JjUPvkDqGe0uHI3vrxUbQ9CcHruddfP+H51F+nGG+kRgGwYsiLfJmj/Or/UX7iotqsUNDd
        tAZ9GYKvdbwl3StheEDwy+ApSx5wvG/qOPF2qVH27eRCMxI/8Auu4Hnb5WybsDSorD+Ctv
        1irasEobnZoOFanIxYLe4tGp3GtNdMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-u1EhqJpxPUueTUC7IY4Siw-1; Thu, 03 Feb 2022 09:33:05 -0500
X-MC-Unique: u1EhqJpxPUueTUC7IY4Siw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 360261091DA6;
        Thu,  3 Feb 2022 14:33:03 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4E437D4D0;
        Thu,  3 Feb 2022 14:33:00 +0000 (UTC)
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
Subject: [PATCH v2 04/12] HID: input: tag touchscreens as such if the physical is not there
Date:   Thu,  3 Feb 2022 15:32:18 +0100
Message-Id: <20220203143226.4023622-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices (Elan, Synaptics...) are sometimes not setting a physical
in their finger collections. hid-input will consider them to be pen
devices, leading to some wrong behavior in user space.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 112901d2d8d2..d2562497a726 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -828,10 +828,31 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 
 		case 0x32: /* InRange */
-			switch (field->physical & 0xff) {
-			case 0x21: map_key(BTN_TOOL_MOUSE); break;
-			case 0x22: map_key(BTN_TOOL_FINGER); break;
-			default: map_key(BTN_TOOL_PEN); break;
+			switch (field->physical) {
+			case HID_DG_PUCK:
+				map_key(BTN_TOOL_MOUSE);
+				break;
+			case HID_DG_FINGER:
+				map_key(BTN_TOOL_FINGER);
+				break;
+			default:
+				/*
+				 * If the physical is not given,
+				 * rely on the application.
+				 */
+				if (!field->physical) {
+					switch (field->application) {
+					case HID_DG_TOUCHSCREEN:
+					case HID_DG_TOUCHPAD:
+						map_key_clear(BTN_TOOL_FINGER);
+						break;
+					default:
+						map_key_clear(BTN_TOOL_PEN);
+					}
+				} else {
+					map_key(BTN_TOOL_PEN);
+				}
+				break;
 			}
 			break;
 
-- 
2.33.1

