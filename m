Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C54CB815
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiCCHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiCCHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:48:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5938BD3;
        Wed,  2 Mar 2022 23:47:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so3428484wmj.1;
        Wed, 02 Mar 2022 23:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AATWb0QJcK0U+z3f0zjpgkV38rUnep/CDv97l/dLl40=;
        b=lYCu/SblUcjMJSBeWLAkwX3BFoxG28Hb9STScFacGXpx7j4zqRGZxHIIPHHN/AAZ7c
         iH8qvePTl1qIcZ9p4UXrE57bXw/kNMwSRBSTZJEzIRDySP0HuMIciPDGqxpaTwyiV24B
         n1L2W5WV90freGAspr699xnfK281iOy6umAl7m6qZu3JHt5KzlizM0ZyXFwA10ctHKdj
         mlYl3AD+Ky6/kPr65z0tbTcmjl9sYENh3+ta+b1SYKlPjU+mDi2Bffv7H8kqrgQqkwJT
         6+YrhnDCF0VPb90L1UkkDwct0J5YOjaD1ethOCOV2KIrliCUGRcrkeWxVPYjlAdOHFeW
         RIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AATWb0QJcK0U+z3f0zjpgkV38rUnep/CDv97l/dLl40=;
        b=LNTsw9M2h6K/B6lwOKIfWnerKRzHZB9p/jIHX44NV6onq/mmynkV+oToUCKAGJVtVl
         5t/Mv9bCK8RI6bfFlBdQ6rBBpr2zvsI33HSnYyx+0qELYe2L42uMp7HN+ez9bq4cy4uC
         POSFYNxfccvFV3sCkstoGQ0oG2SPyWngclqKA31zGQ5V6s1t767HeODsvd5xmTCo9b8L
         SwLXgIVDRGgUs9t30BROfhD6iUraxCmlr+glU864Ze3pP/YN+i0PxdWStQ4PD0eNGzc3
         LvVrb3d15w1wYhC28Nagoj8hQwSoTT1ksYVVA4uPLdbNQOvRzfAANBhLRgxfcTbbPspA
         otpw==
X-Gm-Message-State: AOAM533YZ4I0fUiijeRkUzPPDyISt/AkJolRDxj9lEGMItYx0Qx1XXOZ
        7h2GOhe/+KgIsXN/hrvMG1E=
X-Google-Smtp-Source: ABdhPJzPT5VhNjWM1XSE6JjuRPxqclxdxX85OzY1akbC6yYk87iVnl2f7HGNayM4eHCWdziKWA3h5g==
X-Received: by 2002:a05:600c:4e08:b0:381:9094:6b3c with SMTP id b8-20020a05600c4e0800b0038190946b3cmr2699028wmq.103.1646293659970;
        Wed, 02 Mar 2022 23:47:39 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b003884e826642sm841169wmq.12.2022.03.02.23.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 23:47:39 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 1/4] HID: uclogic: Add support for touch ring reports
Date:   Thu,  3 Mar 2022 08:47:31 +0100
Message-Id: <20220303074734.7235-2-jose.exposito89@gmail.com>
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

Add support for touch ring to UC-Logic driver. The touch ring reports
can be flipped around a specific point to match the orientation and
direction reported by the Wacom drivers. The proximity will also be
reported similar to the Wacom drivers.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 39 +++++++++++++++++++++++++++++++-
 drivers/hid/hid-uclogic-params.h | 36 +++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 05147f2d7564..b448616dacb9 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -90,6 +90,8 @@ static int uclogic_input_configured(struct hid_device *hdev,
 	const char *suffix = NULL;
 	struct hid_field *field;
 	size_t len;
+	size_t i;
+	const struct uclogic_params_frame *frame;
 
 	/* no report associated (HID_QUIRK_MULTI_INPUT not set) */
 	if (!hi->report)
@@ -104,6 +106,19 @@ static int uclogic_input_configured(struct hid_device *hdev,
 		drvdata->pen_input = hi->input;
 	}
 
+	/* If it's one of the frame devices */
+	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
+		frame = &params->frame_list[i];
+		if (hi->report->id == frame->id) {
+			/*
+			 * Disable EV_MSC reports for touch ring interfaces to
+			 * make the Wacom driver pickup touch ring extents
+			 */
+			if (frame->touch_ring_byte > 0)
+				__clear_bit(EV_MSC, hi->input->evbit);
+		}
+	}
+
 	field = hi->report->field[0];
 
 	switch (field->application) {
@@ -313,8 +328,16 @@ static int uclogic_raw_event_frame(
 
 	/* If need to, and can, set pad device ID for Wacom drivers */
 	if (frame->dev_id_byte > 0 && frame->dev_id_byte < size) {
-		data[frame->dev_id_byte] = 0xf;
+		/* If we also have a touch ring and the finger left it */
+		if (frame->touch_ring_byte > 0 &&
+		    frame->touch_ring_byte < size &&
+		    data[frame->touch_ring_byte] == 0) {
+			data[frame->dev_id_byte] = 0;
+		} else {
+			data[frame->dev_id_byte] = 0xf;
+		}
 	}
+
 	/* If need to, and can, read rotary encoder state change */
 	if (frame->re_lsb > 0 && frame->re_lsb / 8 < size) {
 		unsigned int byte = frame->re_lsb / 8;
@@ -341,6 +364,20 @@ static int uclogic_raw_event_frame(
 		drvdata->re_state = state;
 	}
 
+	/* If need to, and can, transform the touch ring reports */
+	if (frame->touch_ring_byte > 0 && frame->touch_ring_byte < size &&
+	    frame->touch_ring_flip_at != 0) {
+		__s8 value = data[frame->touch_ring_byte];
+
+		if (value != 0) {
+			value = frame->touch_ring_flip_at - value;
+			if (value < 0)
+				value = frame->touch_ring_max + value;
+
+			data[frame->touch_ring_byte] = value;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index 86f616dfbb53..fe13bc36983b 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -123,10 +123,32 @@ struct uclogic_params_frame {
 	/*
 	 * Offset of the Wacom-style device ID byte in the report, to be set
 	 * to pad device ID (0xf), for compatibility with Wacom drivers. Zero
-	 * if no changes to the report should be made. Only valid if "id" is
-	 * not zero.
+	 * if no changes to the report should be made. The ID byte will be set
+	 * to zero whenever the byte pointed by "touch_ring_byte" is zero, if
+	 * the latter is valid. Only valid if "id" is not zero.
 	 */
 	unsigned int dev_id_byte;
+	/*
+	 * Offset of the touch ring state byte, in the report.
+	 * Zero if not present. If dev_id_byte is also valid and non-zero,
+	 * then the device ID byte will be cleared when the byte pointed to by
+	 * this offset is zero. Only valid if "id" is not zero.
+	 */
+	unsigned int touch_ring_byte;
+
+	/*
+	 * Maximum value of the touch ring report.
+	 * The minimum valid value is considered to be one,
+	 * with zero being out-of-proximity (finger lift) value.
+	 */
+	__s8 touch_ring_max;
+
+	/*
+	 * The value to anchor the reversed reports at.
+	 * I.e. one, if the reports should be flipped without offset.
+	 * Zero if no reversal should be done.
+	 */
+	__s8 touch_ring_flip_at;
 };
 
 /*
@@ -191,7 +213,10 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		".frame_list[0].desc_size = %u\n"               \
 		".frame_list[0].id = %u\n"                      \
 		".frame_list[0].re_lsb = %u\n"                  \
-		".frame_list[0].dev_id_byte = %u\n"
+		".frame_list[0].dev_id_byte = %u\n"             \
+		".frame_list[0].touch_ring_byte = %u\n"         \
+		".frame_list[0].touch_ring_max = %hhd\n"        \
+		".frame_list[0].touch_ring_flip_at = %hhd\n"
 
 /* Tablet interface parameters *printf format arguments */
 #define UCLOGIC_PARAMS_FMT_ARGS(_params) \
@@ -210,7 +235,10 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->frame_list[0].desc_size,                         \
 		(_params)->frame_list[0].id,                                \
 		(_params)->frame_list[0].re_lsb,                            \
-		(_params)->frame_list[0].dev_id_byte
+		(_params)->frame_list[0].dev_id_byte,                       \
+		(_params)->frame_list[0].touch_ring_byte,                   \
+		(_params)->frame_list[0].touch_ring_max,                    \
+		(_params)->frame_list[0].touch_ring_flip_at
 
 /* Get a replacement report descriptor for a tablet's interface. */
 extern int uclogic_params_get_desc(const struct uclogic_params *params,
-- 
2.25.1

