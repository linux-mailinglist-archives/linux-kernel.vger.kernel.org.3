Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0925449CF68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiAZQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242784AbiAZQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643213941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scDj/oJvhoJAgdPIlS5IhQpZrZh8PkiSfRjw1220pU4=;
        b=hiyWQZnahSxSSKOFlXhtRS6ouw6dvokIZTPgR4COVr5RzvwWDDnkuUm+RtfjJXV1hWkGpd
        FODaOc7z9qJL69JtSIEBh5sHMsZ6c8hI5f2ZqQFQjaURgleYOypcUrXqZS0IfZ2lxIa9Ma
        sHtIRA2UesKtrwMHVYr2GsOT1WRIJp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-G6Q_rPNBPie54mvAH4vL8Q-1; Wed, 26 Jan 2022 11:18:57 -0500
X-MC-Unique: G6Q_rPNBPie54mvAH4vL8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D90D11923E28;
        Wed, 26 Jan 2022 16:18:55 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 496B3798DD;
        Wed, 26 Jan 2022 16:18:53 +0000 (UTC)
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
Subject: [PATCH 04/12] HID: input: tag touchscreens as such if the physical is not there
Date:   Wed, 26 Jan 2022 17:18:24 +0100
Message-Id: <20220126161832.3193805-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

