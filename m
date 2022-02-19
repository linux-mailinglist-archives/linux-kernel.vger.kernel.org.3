Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD3D4BC793
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbiBSKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:02:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbiBSKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C04E4C;
        Sat, 19 Feb 2022 02:02:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o24so18500077wro.3;
        Sat, 19 Feb 2022 02:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xP5uwtUef3r0nEvw6n8H3ODuHfFiZTeoAS2iiXRb5ak=;
        b=GcDVsN9kZNYJfKJ5gZPUU3DoKw3zHL2kbbr9P7tg2cTnZMFhDrMhKBxlQ4MuUASC76
         nwe0ly7atN3aE3N6HysSEB2D/2Z3QLGJwo1pR+UOX84NI30Bl5Wuv3ZPG569Vp9SyWKW
         oM4MjTO82Cs2xiIjkRLKkq/oCKGFIK9U0o9seIQcukTONLkmFNRseE3py3QYUpTydg28
         oGzyw8CO6pCzV6KJmc4jla7YH987I1NJ5RZcLUhhNqmtjac6C1qDftAMctlYeH2eh28p
         oK+uavz/zgrEhpHNvqOofFYBmKK/cvK/1nHqWvIHl95gUrJeYWAjKhqQY3PNHq/b+o7O
         CMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xP5uwtUef3r0nEvw6n8H3ODuHfFiZTeoAS2iiXRb5ak=;
        b=O3h2T1BaJEknfJNcW3Fnh3MpLQ+w6G20jq6gtFEO7ycTDgk0sQqPLd1k2hrCRK+8sz
         h7Gkzb4tqi6LEyC2C3B9D7JGD3VPadh7x9K9S+waJziSFftgRIHy+ycuPgMLU7V2mUIP
         AfLmMYoES/VQv0Wm8oCUC/Rz7cr4B7h6Zp/WPSXLZl7OhnDd9h9IHTReoZavcrxOfCt/
         Xabc+HUS72xUuf/rT3VCFro3FzDjfPGkMfjACFilgiPZhzwoEDoqkOdK7f29TKuOwMnw
         ZEeJmq/edyB+qtMHbzbo0XkXEm9Wz6YxyRxtRtKm+MX9dtmBTcVjCWMG1Av4RE+LTyyD
         1T0w==
X-Gm-Message-State: AOAM5309yTZfHKC2O40yFyPGd06kzeGJt/ziqnrbNgw/ybb6Mw/tYgaq
        D+/0E83Yn7t+Vg4PWYs13Yg=
X-Google-Smtp-Source: ABdhPJzVnLOg3dZASbtZkO2mFU0jG97f4txcOtAQJa7996v0jetJQK1IPpDdGfnMQV+1bCgxHDKV0A==
X-Received: by 2002:a5d:584d:0:b0:1e4:a62d:ad45 with SMTP id i13-20020a5d584d000000b001e4a62dad45mr8738618wrf.571.1645264931942;
        Sat, 19 Feb 2022 02:02:11 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:11 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 3/9] HID: uclogic: Switch to matching subreport bytes
Date:   Sat, 19 Feb 2022 11:01:51 +0100
Message-Id: <20220219100157.41920-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219100157.41920-1-jose.exposito89@gmail.com>
References: <20220219100157.41920-1-jose.exposito89@gmail.com>
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

Switch from matching UC-Logic subreport with a mask to a full value to
support detecting Huion HS610 touch dial reports. Those would match the
button mask otherwise.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   |  9 ++++++---
 drivers/hid/hid-uclogic-params.c |  4 ++--
 drivers/hid/hid-uclogic-params.h | 13 +++++++------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 7092f86517a5..a02edeb30a35 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -365,9 +365,12 @@ static int uclogic_raw_event(struct hid_device *hdev,
 				ARRAY_SIZE(params->pen.subreport_list);
 			/* Try to match a subreport */
 			for (subreport = params->pen.subreport_list;
-			     subreport < subreport_list_end &&
-				(data[1] & subreport->mask) != subreport->mask;
-			     subreport++);
+			     subreport < subreport_list_end; subreport++) {
+				if (subreport->value != 0 &&
+				    subreport->value == data[1]) {
+					break;
+				}
+			}
 			/* If a subreport matched */
 			if (subreport < subreport_list_end) {
 				/* Change to subreport ID, and restart */
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 138dd8b0a360..a4a53ab1e72c 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -763,7 +763,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				goto cleanup;
 			}
 			/* Link frame button subreports from pen reports */
-			p.pen.subreport_list[0].mask = 0x20;
+			p.pen.subreport_list[0].value = 0xe0;
 			p.pen.subreport_list[0].id =
 				UCLOGIC_RDESC_BUTTONPAD_V2_ID;
 			goto output;
@@ -791,7 +791,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			(found ? "" : " not"));
 		if (found) {
 			/* Link frame button subreports from pen reports */
-			p.pen.subreport_list[0].mask = 0x20;
+			p.pen.subreport_list[0].value = 0xe0;
 			p.pen.subreport_list[0].id =
 				UCLOGIC_RDESC_BUTTONPAD_V1_ID;
 		}
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index 82db8ab36fec..c18569591b75 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -39,14 +39,15 @@ extern const char *uclogic_params_pen_inrange_to_str(
  */
 struct uclogic_params_pen_subreport {
 	/*
-	 * The subreport's bitmask matching the second byte of the pen report.
-	 * If zero, the subreport is considered invalid, and won't match.
+	 * The value of the second byte of the pen report indicating this
+	 * subreport. If zero, the subreport should be considered invalid and
+	 * not matched.
 	 */
-	__u8 mask;
+	__u8 value;
 
 	/*
-	 * The ID to be assigned to the report, if the "mask" matches.
-	 * Only valid if "mask" is not zero.
+	 * The ID to be assigned to the report, if the second byte of the pen
+	 * report is equal to "value". Only valid if "value" is not zero.
 	 */
 	__u8 id;
 };
@@ -200,7 +201,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->pen.desc_ptr,                                    \
 		(_params)->pen.desc_size,                                   \
 		(_params)->pen.id,                                          \
-		(_params)->pen.subreport_list[0].mask,                      \
+		(_params)->pen.subreport_list[0].value,                     \
 		(_params)->pen.subreport_list[0].id,                        \
 		uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
 		((_params)->pen.fragmented_hires ? "true" : "false"),       \
-- 
2.25.1

