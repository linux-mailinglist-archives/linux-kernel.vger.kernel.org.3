Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3752C4B15C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbiBJTFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:05:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbiBJTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFDF10BA;
        Thu, 10 Feb 2022 11:04:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso1581736wmj.2;
        Thu, 10 Feb 2022 11:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ldkbEk4Ot0+c2jkb2wLX+CD6aUDq3RF/PTF3GMpQmA=;
        b=ZsTazNhRiUDa2uCyCVxXhCKANmWAfIIWrKzWI9hrKiiYeCk5vIOgUzxNZI50mDZ00X
         JPMm8qEtmrXY/9eA8nuQJ/dhqjANGfYiggqQlM5/XIf+/aVd7+yzs4Ivaceep5U3pAkp
         7oJsCKqvnTywszFINkJsbEa1wPHMjTI8pdipvjJRsBIpFxMtFy8LtxgZfLS34i3hMzeF
         5ViM0pvLRZ7oJEDrsJgROegP+MMb6Qt/ZLNGUMhERzUK6N3LzDzdqgxTScHaYLqfWTtu
         lZlusHcXqy5JDQV4HAiCzv2g5Tovw+Ya2s6GK7bWE+gBnUpln1PxlnlJvBUQo67kyntH
         2x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ldkbEk4Ot0+c2jkb2wLX+CD6aUDq3RF/PTF3GMpQmA=;
        b=zIDrsskgpc7pJcIRlOBqe5hntP406FS/Yzyq976EGr0xGHZpIdCx2CxXyg+8hCmFmP
         xa2tG0NcVrdOkVNWkHb/O9Tw1MyO7rsrK1pTitGq4g6NHUZccDI3I5D0T0wslq0fzz+a
         RMroHS95E+HUZ+UwHtbnlY2K+/QWbwfHdZ7NVSGf8S47zCL8nqHsKLB/dbFPtdwfcSFf
         XEPmAVxQla+14iXQpVwXfaUDxQZ4qNMIw1iZymq3oDbFJcemdHf1buPR23WIIWfwdnlc
         H+LSphTzZKbha3/XxMkUu7VP0J7ExY4JTQBILXdLk7Kjmg4+dV+68A55Wdk+YbVthGfj
         K2sw==
X-Gm-Message-State: AOAM532oX+LOKoCy0PL20XQD7ZvxEmvfkNg5q/ilo10BlYZwwCTrQ9DR
        UehSB1rRUZwWTf1ggaPLRTiIM7d4e5sYKA==
X-Google-Smtp-Source: ABdhPJxvcmFn3FCRhMI/RD4mHKKCrWK2L157C6o6psrEVZ95zkuyHEWR8A25hwlCMllL271+Sxfriw==
X-Received: by 2002:a05:600c:4ca1:: with SMTP id g33mr3391418wmp.108.1644519893640;
        Thu, 10 Feb 2022 11:04:53 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:53 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 4/7] HID: uclogic: Split pen and frame raw event handling
Date:   Thu, 10 Feb 2022 20:04:34 +0100
Message-Id: <20220210190437.50152-5-jose.exposito89@gmail.com>
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

In order to avoid ending up with  a big uclogic_raw_event function,
split it in two smaller functions: uclogic_raw_event_pen for the pen
events and uclogic_raw_event_frame for the pad events.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 195 ++++++++++++++++++++-------------
 1 file changed, 120 insertions(+), 75 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 850c660ec2ab..9187fd835a46 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -246,6 +246,123 @@ static int uclogic_resume(struct hid_device *hdev)
 }
 #endif
 
+/**
+ * uclogic_raw_event_pen - handle raw pen events (pen HID reports).
+ *
+ * @drvdata:	Driver data.
+ * @data:	Report data buffer, can be modified.
+ * @size:	Report data size, bytes.
+ *
+ * Returns:
+ *	Negative value on error (stops event delivery), zero for success.
+ */
+static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
+					u8 *data, int size)
+{
+	struct uclogic_params *params = &drvdata->params;
+
+	WARN_ON(drvdata == NULL);
+	WARN_ON(data == NULL && size != 0);
+
+	/* If in-range reports are inverted */
+	if (params->pen.inrange ==
+		UCLOGIC_PARAMS_PEN_INRANGE_INVERTED) {
+		/* Invert the in-range bit */
+		data[1] ^= 0x40;
+	}
+	/*
+	 * If report contains fragmented high-resolution pen
+	 * coordinates
+	 */
+	if (size >= 10 && params->pen.fragmented_hires) {
+		u8 pressure_low_byte;
+		u8 pressure_high_byte;
+
+		/* Lift pressure bytes */
+		pressure_low_byte = data[6];
+		pressure_high_byte = data[7];
+		/*
+		 * Move Y coord to make space for high-order X
+		 * coord byte
+		 */
+		data[6] = data[5];
+		data[5] = data[4];
+		/* Move high-order X coord byte */
+		data[4] = data[8];
+		/* Move high-order Y coord byte */
+		data[7] = data[9];
+		/* Place pressure bytes */
+		data[8] = pressure_low_byte;
+		data[9] = pressure_high_byte;
+	}
+	/* If we need to emulate in-range detection */
+	if (params->pen.inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE) {
+		/* Set in-range bit */
+		data[1] |= 0x40;
+		/* (Re-)start in-range timeout */
+		mod_timer(&drvdata->inrange_timer,
+				jiffies + msecs_to_jiffies(100));
+	}
+	/* If we report tilt and Y direction is flipped */
+	if (size >= 12 && params->pen.tilt_y_flipped)
+		data[11] = -data[11];
+
+	return 0;
+}
+
+/**
+ * uclogic_raw_event_frame - handle raw frame events (frame HID reports).
+ *
+ * @drvdata:	Driver data.
+ * @data:	Report data buffer, can be modified.
+ * @size:	Report data size, bytes.
+ *
+ * Returns:
+ *	Negative value on error (stops event delivery), zero for success.
+ */
+static int uclogic_raw_event_frame(struct uclogic_drvdata *drvdata,
+					u8 *data, int size)
+{
+	struct uclogic_params *params = &drvdata->params;
+
+	WARN_ON(drvdata == NULL);
+	WARN_ON(data == NULL && size != 0);
+
+	/* If need to, and can, set pad device ID for Wacom drivers */
+	if (params->frame.dev_id_byte > 0 &&
+	    params->frame.dev_id_byte < size) {
+		data[params->frame.dev_id_byte] = 0xf;
+	}
+	/* If need to, and can, read rotary encoder state change */
+	if (params->frame.re_lsb > 0 &&
+	    params->frame.re_lsb / 8 < size) {
+		unsigned int byte = params->frame.re_lsb / 8;
+		unsigned int bit = params->frame.re_lsb % 8;
+
+		u8 change;
+		u8 prev_state = drvdata->re_state;
+		/* Read Gray-coded state */
+		u8 state = (data[byte] >> bit) & 0x3;
+		/* Encode state change into 2-bit signed integer */
+		if ((prev_state == 1 && state == 0) ||
+		    (prev_state == 2 && state == 3)) {
+			change = 1;
+		} else if ((prev_state == 2 && state == 0) ||
+			   (prev_state == 1 && state == 3)) {
+			change = 3;
+		} else {
+			change = 0;
+		}
+		/* Write change */
+		data[byte] = (data[byte] & ~((u8)3 << bit)) |
+				(change << bit);
+		/* Remember state */
+		drvdata->re_state = state;
+	}
+
+	return 0;
+}
+
 static int uclogic_raw_event(struct hid_device *hdev,
 				struct hid_report *report,
 				u8 *data, int size)
@@ -265,85 +382,13 @@ static int uclogic_raw_event(struct hid_device *hdev,
 			data[0] = params->frame.id;
 			return 0;
 		}
-		/* If in-range reports are inverted */
-		if (params->pen.inrange ==
-			UCLOGIC_PARAMS_PEN_INRANGE_INVERTED) {
-			/* Invert the in-range bit */
-			data[1] ^= 0x40;
-		}
-		/*
-		 * If report contains fragmented high-resolution pen
-		 * coordinates
-		 */
-		if (size >= 10 && params->pen.fragmented_hires) {
-			u8 pressure_low_byte;
-			u8 pressure_high_byte;
-
-			/* Lift pressure bytes */
-			pressure_low_byte = data[6];
-			pressure_high_byte = data[7];
-			/*
-			 * Move Y coord to make space for high-order X
-			 * coord byte
-			 */
-			data[6] = data[5];
-			data[5] = data[4];
-			/* Move high-order X coord byte */
-			data[4] = data[8];
-			/* Move high-order Y coord byte */
-			data[7] = data[9];
-			/* Place pressure bytes */
-			data[8] = pressure_low_byte;
-			data[9] = pressure_high_byte;
-		}
-		/* If we need to emulate in-range detection */
-		if (params->pen.inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE) {
-			/* Set in-range bit */
-			data[1] |= 0x40;
-			/* (Re-)start in-range timeout */
-			mod_timer(&drvdata->inrange_timer,
-					jiffies + msecs_to_jiffies(100));
-		}
-		/* If we report tilt and Y direction is flipped */
-		if (size >= 12 && params->pen.tilt_y_flipped)
-			data[11] = -data[11];
+		return uclogic_raw_event_pen(drvdata, data, size);
 	}
 
 	/* Tweak frame control reports, if necessary */
 	if ((report->type == HID_INPUT_REPORT) &&
-	    (report->id == params->frame.id)) {
-		/* If need to, and can, set pad device ID for Wacom drivers */
-		if (params->frame.dev_id_byte > 0 &&
-		    params->frame.dev_id_byte < size) {
-			data[params->frame.dev_id_byte] = 0xf;
-		}
-		/* If need to, and can, read rotary encoder state change */
-		if (params->frame.re_lsb > 0 &&
-		    params->frame.re_lsb / 8 < size) {
-			unsigned int byte = params->frame.re_lsb / 8;
-			unsigned int bit = params->frame.re_lsb % 8;
-
-			u8 change;
-			u8 prev_state = drvdata->re_state;
-			/* Read Gray-coded state */
-			u8 state = (data[byte] >> bit) & 0x3;
-			/* Encode state change into 2-bit signed integer */
-			if ((prev_state == 1 && state == 0) ||
-			    (prev_state == 2 && state == 3)) {
-				change = 1;
-			} else if ((prev_state == 2 && state == 0) ||
-				   (prev_state == 1 && state == 3)) {
-				change = 3;
-			} else {
-				change = 0;
-			}
-			/* Write change */
-			data[byte] = (data[byte] & ~((u8)3 << bit)) |
-					(change << bit);
-			/* Remember state */
-			drvdata->re_state = state;
-		}
-	}
+	    (report->id == params->frame.id))
+		return uclogic_raw_event_frame(drvdata, data, size);
 
 	return 0;
 }
-- 
2.25.1

