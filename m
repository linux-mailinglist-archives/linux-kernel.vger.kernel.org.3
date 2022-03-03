Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0A4CB818
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiCCHsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiCCHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:48:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CD285BE9;
        Wed,  2 Mar 2022 23:47:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2680050wmb.3;
        Wed, 02 Mar 2022 23:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0NKVzasrTrGwBZq2ioODs/A3zUcClXcRrJ9wLnu5QE=;
        b=M0h1vDhzoitu2Gcu9k2BkLCbs915ZC+A6XQDsmne4dOMPr111GtDhUesUGw+Akift2
         7Mo19ZvCa5shn4gC8o8NsyoH1zG1YW5f+Cg8mgTZ4uWWRCe63mm86pvpMoY29/8NR3N+
         rv/5LJxrdMQPvvH+PU6jumfCflxco2PoGikMsLiutbevug2oE/HKrVxp036v73bBt76H
         wk95VZRNx5+XrmMK7xbK6BwBQVcCCQ0l3AOD85xTbKEbnPpN1cSz//4/iXDpSjCInj6O
         d4kIfV6k0E740ykuGicnWVyiGxX+aA7YResiaBUn6rW4nEqn76IbNed6awW4BKKZXID7
         4mUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0NKVzasrTrGwBZq2ioODs/A3zUcClXcRrJ9wLnu5QE=;
        b=f2eGGkaoTvxPnewTDT73KBl1VMcZZYD5/itjacN36bOoy+0ElNmP4r8sj+9XpgFPxS
         /CCQe8F+gm2gXd3I2PzaZOmfchq2gUE6nduQv+CpsgFez53l9s2rDX+E+hsGzBAHLOKg
         iDu0hEHNcZUhsHz+aV2nv8SYBL7lh6M5TUrY+BpkPdgrmmmw/J1fTJG83AS5uSoA+4WP
         2QwqGjv22uTEmIfdNlc2U7CK0tv+Bfbmq2Alwq4s3JI8EVoWx2ciVDwVaUKhf0OT2NDs
         AV7tA+Oz+5eEnosn+YmqrtpKPqJiij8uHEYV8j2o7k+kia2OlCDqVhxv84Z7qlmreSzq
         GdvQ==
X-Gm-Message-State: AOAM533Uq70uZwBOf1vPm++OOBj4gK9aSbf+juAat0gDVywnO0AkPoBV
        m+/OnkafDwv561Ushx7kGl4=
X-Google-Smtp-Source: ABdhPJx4gkOdLGlBHG92q1Jkpjo77fKPceNyhre3f51+8YnfT+fY4RJ58hoN7BidSoiKQIuMIADiZw==
X-Received: by 2002:a05:600c:3596:b0:381:751a:f0a6 with SMTP id p22-20020a05600c359600b00381751af0a6mr2723282wmq.168.1646293660874;
        Wed, 02 Mar 2022 23:47:40 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b003884e826642sm841169wmq.12.2022.03.02.23.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 23:47:40 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 2/4] HID: uclogic: Support custom device suffix for frames
Date:   Thu,  3 Mar 2022 08:47:32 +0100
Message-Id: <20220303074734.7235-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303074734.7235-1-jose.exposito89@gmail.com>
References: <20220303074734.7235-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Support assigning custom device name suffixes to frame input devices
instead of just "Pad". This allows distinguishing multiple frame input
devices, e.g. for Huion HS610.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 46 +++++++++++++++++---------------
 drivers/hid/hid-uclogic-params.h |  6 +++++
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b448616dacb9..96f3fb8c492c 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -110,6 +110,8 @@ static int uclogic_input_configured(struct hid_device *hdev,
 	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
 		frame = &params->frame_list[i];
 		if (hi->report->id == frame->id) {
+			/* Assign custom suffix, if any */
+			suffix = frame->suffix;
 			/*
 			 * Disable EV_MSC reports for touch ring interfaces to
 			 * make the Wacom driver pickup touch ring extents
@@ -119,27 +121,29 @@ static int uclogic_input_configured(struct hid_device *hdev,
 		}
 	}
 
-	field = hi->report->field[0];
-
-	switch (field->application) {
-	case HID_GD_KEYBOARD:
-		suffix = "Keyboard";
-		break;
-	case HID_GD_MOUSE:
-		suffix = "Mouse";
-		break;
-	case HID_GD_KEYPAD:
-		suffix = "Pad";
-		break;
-	case HID_DG_PEN:
-		suffix = "Pen";
-		break;
-	case HID_CP_CONSUMER_CONTROL:
-		suffix = "Consumer Control";
-		break;
-	case HID_GD_SYSTEM_CONTROL:
-		suffix = "System Control";
-		break;
+	if (!suffix) {
+		field = hi->report->field[0];
+
+		switch (field->application) {
+		case HID_GD_KEYBOARD:
+			suffix = "Keyboard";
+			break;
+		case HID_GD_MOUSE:
+			suffix = "Mouse";
+			break;
+		case HID_GD_KEYPAD:
+			suffix = "Pad";
+			break;
+		case HID_DG_PEN:
+			suffix = "Pen";
+			break;
+		case HID_CP_CONSUMER_CONTROL:
+			suffix = "Consumer Control";
+			break;
+		case HID_GD_SYSTEM_CONTROL:
+			suffix = "System Control";
+			break;
+		}
 	}
 
 	if (suffix) {
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index fe13bc36983b..8042820e78b1 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -114,6 +114,10 @@ struct uclogic_params_frame {
 	 * Report ID, if reports should be tweaked, zero if not.
 	 */
 	unsigned int id;
+	/*
+	 * The suffix to add to the input device name, if not NULL.
+	 */
+	const char *suffix;
 	/*
 	 * Number of the least-significant bit of the 2-bit state of a rotary
 	 * encoder, in the report. Cannot point to a 2-bit field crossing a
@@ -212,6 +216,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		".frame_list[0].desc_ptr = %p\n"                \
 		".frame_list[0].desc_size = %u\n"               \
 		".frame_list[0].id = %u\n"                      \
+		".frame_list[0].suffix = %s\n"                  \
 		".frame_list[0].re_lsb = %u\n"                  \
 		".frame_list[0].dev_id_byte = %u\n"             \
 		".frame_list[0].touch_ring_byte = %u\n"         \
@@ -234,6 +239,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->frame_list[0].desc_ptr,                          \
 		(_params)->frame_list[0].desc_size,                         \
 		(_params)->frame_list[0].id,                                \
+		(_params)->frame_list[0].suffix,                            \
 		(_params)->frame_list[0].re_lsb,                            \
 		(_params)->frame_list[0].dev_id_byte,                       \
 		(_params)->frame_list[0].touch_ring_byte,                   \
-- 
2.25.1

