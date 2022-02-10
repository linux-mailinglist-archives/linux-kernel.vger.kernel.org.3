Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8764B15C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbiBJTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:04:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbiBJTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665B2188;
        Thu, 10 Feb 2022 11:04:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v12so11342856wrv.2;
        Thu, 10 Feb 2022 11:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpmRjI0D+EUjYe3MeaVVjfaIantYzT3rLaYTj18YtDY=;
        b=KK8VxxYFNzGY9uQk3j+LgYTG0MruHQh7kSQKDUrSXVX5ahF1ACDOjDpuGj2e6fWuCf
         Ayl4KYwww5Jhex1PeSTHDpx5yP7yZ4MgFCTsCln0mov0JAsTxMmopyma6UF81/j3SLzX
         ACnYdFH41nCKYvdZBHVUymd5z7ZQavR+ZrBGW0SyRytPJV+PpBMdY+uw56TBUQpLBYLY
         e5zVROEzuAtNxaujQPeBf8JCROsVLymQz8c3L8OnLMFI6XIrAQ7vj7QnJuwG5mpUdvqr
         n9TncL/uQnQIVgRxnysSEnQxHjxuiPYMjijNy+TnRjDCsG2yLuU9dZXNYggkIwbS0Cwf
         EoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpmRjI0D+EUjYe3MeaVVjfaIantYzT3rLaYTj18YtDY=;
        b=7wWyOMMdKLeDR9lO1XBHwpst/QClieQe4Vqf48nvLE/uhC0bMOs+COfBPfQjxY7Ha8
         GSjnDnOcwie5r+MAowZ3eZytmRqRzCo4U2RsTVePpmansSRth40zlZLpBlsiNU0rEhDb
         ipS+hiRoBOv37qjeVrEIQ0TP0wGyF1cMKNOa7f2XNVBzBh+3YwnP1XwLwitz8YXCm5J5
         zJ8IzTb2Owb6KbAqaQ+oVtFU/8tiLeDC1fX3gT+/PmRRU7LMqy7zMjsxEb9gDGTAC5aK
         Bsvwl4IcOWOj1rjY0uDrZdTGJPDIVujB39Ef84i27TcfOgeo7+gTqYs7kf2hwoHNeNbk
         RPkw==
X-Gm-Message-State: AOAM532RTK4JuJSoD+dBQ8vvEUaHU30R0lDFNh/1VjABU/sj+F20coYd
        O1DuZF0scm2PPFx5XVfAcD+oElROx/THCw==
X-Google-Smtp-Source: ABdhPJx4yTAHUWHtzEXcqnx00gEFZFjP7TG1bALA0XmwAKM9UVXczPvofWdN38j83/8PdoxCGhuDGg==
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr7296289wrx.84.1644519891164;
        Thu, 10 Feb 2022 11:04:51 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:50 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/7] HID: uclogic: Support Huion tilt reporting
Date:   Thu, 10 Feb 2022 20:04:31 +0100
Message-Id: <20220210190437.50152-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210190437.50152-1-jose.exposito89@gmail.com>
References: <20220210190437.50152-1-jose.exposito89@gmail.com>
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

Add support for Huion v2 protocol tilt reporting. Describe reports as
angles in degrees, which is not exactly true, but there doesn't seem to
be a straightforward, consistent conversion possible, and what's
reported would have to be enough.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   |  3 +++
 drivers/hid/hid-uclogic-params.c |  1 +
 drivers/hid/hid-uclogic-params.h |  8 ++++++++
 drivers/hid/hid-uclogic-rdesc.c  | 12 +++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index d8ab0139e5cd..823704bc02ef 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -304,6 +304,9 @@ static int uclogic_raw_event(struct hid_device *hdev,
 			mod_timer(&drvdata->inrange_timer,
 					jiffies + msecs_to_jiffies(100));
 		}
+		/* If we report tilt and Y direction is flipped */
+		if (size >= 12 && params->pen.tilt_y_flipped)
+			data[11] = -data[11];
 	}
 
 	/* Tweak frame control reports, if necessary */
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 3e70f969fb84..30e0f69ed5af 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -369,6 +369,7 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	pen->id = UCLOGIC_RDESC_PEN_V2_ID;
 	pen->inrange = UCLOGIC_PARAMS_PEN_INRANGE_NONE;
 	pen->fragmented_hires = true;
+	pen->tilt_y_flipped = true;
 	found = true;
 finish:
 	*pfound = found;
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index ba48b1c7a0e5..e8381bb77bd0 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -62,6 +62,12 @@ struct uclogic_params_pen {
 	 * Only valid if "id" is not zero.
 	 */
 	bool fragmented_hires;
+	/*
+	 * True if the pen reports tilt in bytes at offset 10 (X) and 11 (Y),
+	 * and the Y tilt direction is flipped.
+	 * Only valid if "id" is not zero.
+	 */
+	bool tilt_y_flipped;
 };
 
 /*
@@ -171,6 +177,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		".pen.id = %u\n"                    \
 		".pen.inrange = %s\n"               \
 		".pen.fragmented_hires = %s\n"      \
+		".pen.tilt_y_flipped = %s\n"        \
 		".frame.desc_ptr = %p\n"            \
 		".frame.desc_size = %u\n"           \
 		".frame.id = %u\n"                  \
@@ -189,6 +196,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->pen.id,                                          \
 		uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
 		((_params)->pen.fragmented_hires ? "true" : "false"),       \
+		((_params)->pen.tilt_y_flipped ? "true" : "false"),         \
 		(_params)->frame.desc_ptr,                                  \
 		(_params)->frame.desc_size,                                 \
 		(_params)->frame.id,                                        \
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 6dd6dcd09c8b..2607cbdf8ff2 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -633,7 +633,17 @@ const __u8 uclogic_rdesc_pen_v2_template_arr[] = {
 	0x27, UCLOGIC_RDESC_PEN_PH(PRESSURE_LM),
 				/*          Logical Maximum (PLACEHOLDER),  */
 	0x81, 0x02,             /*          Input (Variable),               */
-	0x81, 0x03,             /*          Input (Constant, Variable),     */
+	0x54,                   /*          Unit Exponent (0),              */
+	0x65, 0x14,             /*          Unit (Degrees),                 */
+	0x35, 0xC4,             /*          Physical Minimum (-60),         */
+	0x45, 0x3C,             /*          Physical Maximum (60),          */
+	0x15, 0xC4,             /*          Logical Minimum (-60),          */
+	0x25, 0x3C,             /*          Logical Maximum (60),           */
+	0x75, 0x08,             /*          Report Size (8),                */
+	0x95, 0x02,             /*          Report Count (2),               */
+	0x09, 0x3D,             /*          Usage (X Tilt),                 */
+	0x09, 0x3E,             /*          Usage (Y Tilt),                 */
+	0x81, 0x02,             /*          Input (Variable),               */
 	0xC0,                   /*      End Collection,                     */
 	0xC0                    /*  End Collection                          */
 };
-- 
2.25.1

