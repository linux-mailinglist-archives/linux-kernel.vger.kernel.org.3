Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0074451EECA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiEHQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiEHQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:06:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869DD11145;
        Sun,  8 May 2022 09:02:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so16356008wrh.11;
        Sun, 08 May 2022 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7s5fmBwP8rCs7pEtusXvi3U2iXj4JeLgqhsngdf67o=;
        b=Urc7uKiu9cfch99k9wn+hjQ7in3wJJOGDRJmr04x+bHSnlZyWnmkE5vkVlpFaJWXcQ
         inymFw9yJmhcjrmkufPl8xXhA9FntRt/mOZ1nBy5PD+/GQYtO4boolbdUSENjLWRG6Fo
         nqU4RLlNKQcQNYitlTJeENNAbtq0p8LWeoUOHQ7xu1lD6sCXvQxE/B2CdZ/aAUHT4Wf5
         +TckcAw8MXdAZCPTRxaN6eX7mEAM/CTQDsmw1qCPh5bj67utr0q12KKfSXeGRzBufB3Q
         Axc4xY6N+bTrgZPqnBodc1E0s/G/4QUtvDfwUGx9JoHUJkG/IGNamH5Esid/toT+CkT3
         HTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7s5fmBwP8rCs7pEtusXvi3U2iXj4JeLgqhsngdf67o=;
        b=5ltnVZFmOv/DELTIImRjryHAyPHetQLAmMVOpU4LkzWQw/wyhFnTmCxHwNViEgcRyG
         PR4d1riU9DpQOpYZg1zB3+8HhFJSNS5ETQ4QG8gJEjPHGidMwpRw+XYKhY8qj1uuD7pP
         fYTBoB5CGGbRTXLx0ed5zsqNiVNXbc0wKNysWWos5mbvB4o2/EG1ddLfFHzTHXNJEopL
         yCFKo4qeoOzEOX6mDVr7ufVNXH3Vnbs+2sGuVAGsi3GlcDXmaMOIh57iRWvZofBIkEOT
         3/cqmsdG6u9rvZiXDudwpj+UreU8YQ23oI187/RtA7c1+hRGDXSKtVw8tLikwM7n0oHv
         o+fQ==
X-Gm-Message-State: AOAM531jvaB565T7zPwz/6/m/Re7mBXj4OR5dlFMn5Rddje9nwEGUQBt
        Xm2uOxgA8eRfFaA0AcxWZTumCgDeL3E=
X-Google-Smtp-Source: ABdhPJyNPuBqz8hfGfn1xyhVG/SvN8DkWQqkVUrnsh7MNwLb3UFLzq/xaimEyZLsvdE2IlrjR1akHA==
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id n15-20020a5d598f000000b0020c83c9b05bmr10405766wri.343.1652025732899;
        Sun, 08 May 2022 09:02:12 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:02:12 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 3/7] HID: uclogic: Do not focus on touch ring only
Date:   Sun,  8 May 2022 18:01:42 +0200
Message-Id: <20220508160146.13004-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508160146.13004-1-jose.exposito89@gmail.com>
References: <20220508160146.13004-1-jose.exposito89@gmail.com>
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

Accommodate both touch ring and touch strip in naming throughout
hid-uclogic by talking about abstract "touch" instead of "touch ring",
wherever possible.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 20 +++++++++-----------
 drivers/hid/hid-uclogic-params.c | 20 ++++++++++----------
 drivers/hid/hid-uclogic-params.h | 27 ++++++++++++++-------------
 drivers/hid/hid-uclogic-rdesc.c  |  4 ++--
 drivers/hid/hid-uclogic-rdesc.h  |  8 ++++----
 5 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 8cac5944e63f..cc53625ed1f7 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -134,7 +134,7 @@ static int uclogic_input_configured(struct hid_device *hdev,
 			 * Disable EV_MSC reports for touch ring interfaces to
 			 * make the Wacom driver pickup touch ring extents
 			 */
-			if (frame->touch_ring_byte > 0)
+			if (frame->touch_byte > 0)
 				__clear_bit(EV_MSC, hi->input->evbit);
 		}
 	}
@@ -351,9 +351,8 @@ static int uclogic_raw_event_frame(
 	/* If need to, and can, set pad device ID for Wacom drivers */
 	if (frame->dev_id_byte > 0 && frame->dev_id_byte < size) {
 		/* If we also have a touch ring and the finger left it */
-		if (frame->touch_ring_byte > 0 &&
-		    frame->touch_ring_byte < size &&
-		    data[frame->touch_ring_byte] == 0) {
+		if (frame->touch_byte > 0 && frame->touch_byte < size &&
+		    data[frame->touch_byte] == 0) {
 			data[frame->dev_id_byte] = 0;
 		} else {
 			data[frame->dev_id_byte] = 0xf;
@@ -387,16 +386,15 @@ static int uclogic_raw_event_frame(
 	}
 
 	/* If need to, and can, transform the touch ring reports */
-	if (frame->touch_ring_byte > 0 && frame->touch_ring_byte < size &&
-	    frame->touch_ring_flip_at != 0) {
-		__s8 value = data[frame->touch_ring_byte];
-
+	if (frame->touch_byte > 0 && frame->touch_byte < size &&
+	    frame->touch_flip_at != 0) {
+		__s8 value = data[frame->touch_byte];
 		if (value != 0) {
-			value = frame->touch_ring_flip_at - value;
+			value = frame->touch_flip_at - value;
 			if (value < 0)
-				value = frame->touch_ring_max + value;
+				value = frame->touch_max + value;
 
-			data[frame->touch_ring_byte] = value;
+			data[frame->touch_byte] = value;
 		}
 	}
 
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 91379d7cd33e..459f15288ccc 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -93,10 +93,10 @@ static void uclogic_params_frame_hid_dbg(
 	hid_dbg(hdev, "\t\t.suffix = %s\n", frame->suffix);
 	hid_dbg(hdev, "\t\t.re_lsb = %u\n", frame->re_lsb);
 	hid_dbg(hdev, "\t\t.dev_id_byte = %u\n", frame->dev_id_byte);
-	hid_dbg(hdev, "\t\t.touch_ring_byte = %u\n", frame->touch_ring_byte);
-	hid_dbg(hdev, "\t\t.touch_ring_max = %hhd\n", frame->touch_ring_max);
-	hid_dbg(hdev, "\t\t.touch_ring_flip_at = %hhd\n",
-		frame->touch_ring_flip_at);
+	hid_dbg(hdev, "\t\t.touch_byte = %u\n", frame->touch_byte);
+	hid_dbg(hdev, "\t\t.touch_max = %hhd\n", frame->touch_max);
+	hid_dbg(hdev, "\t\t.touch_flip_at = %hhd\n",
+		frame->touch_flip_at);
 	hid_dbg(hdev, "\t\t.bitmap_dial_byte = %u\n",
 		frame->bitmap_dial_byte);
 }
@@ -877,7 +877,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 					&p.frame_list[1],
 					uclogic_rdesc_v2_frame_touch_ring_arr,
 					uclogic_rdesc_v2_frame_touch_ring_size,
-					UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID);
+					UCLOGIC_RDESC_V2_FRAME_TOUCH_ID);
 			if (rc != 0) {
 				hid_err(hdev,
 					"failed creating v2 frame touch ring parameters: %d\n",
@@ -886,10 +886,10 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			}
 			p.frame_list[1].suffix = "Touch Ring";
 			p.frame_list[1].dev_id_byte =
-				UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_DEV_ID_BYTE;
-			p.frame_list[1].touch_ring_byte = 5;
-			p.frame_list[1].touch_ring_max = 12;
-			p.frame_list[1].touch_ring_flip_at = 6;
+				UCLOGIC_RDESC_V2_FRAME_TOUCH_DEV_ID_BYTE;
+			p.frame_list[1].touch_byte = 5;
+			p.frame_list[1].touch_max = 12;
+			p.frame_list[1].touch_flip_at = 6;
 
 			/* Create v2 frame dial parameters */
 			rc = uclogic_params_frame_init_with_desc(
@@ -917,7 +917,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID;
 			p.pen.subreport_list[1].value = 0xf0;
 			p.pen.subreport_list[1].id =
-				UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID;
+				UCLOGIC_RDESC_V2_FRAME_TOUCH_ID;
 			p.pen.subreport_list[2].value = 0xf1;
 			p.pen.subreport_list[2].id =
 				UCLOGIC_RDESC_V2_FRAME_DIAL_ID;
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index c7573f70d35c..5bef8daaa607 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -128,31 +128,32 @@ struct uclogic_params_frame {
 	 * Offset of the Wacom-style device ID byte in the report, to be set
 	 * to pad device ID (0xf), for compatibility with Wacom drivers. Zero
 	 * if no changes to the report should be made. The ID byte will be set
-	 * to zero whenever the byte pointed by "touch_ring_byte" is zero, if
+	 * to zero whenever the byte pointed by "touch_byte" is zero, if
 	 * the latter is valid. Only valid if "id" is not zero.
 	 */
 	unsigned int dev_id_byte;
 	/*
-	 * Offset of the touch ring state byte, in the report.
+	 * Offset of the touch ring/strip state byte, in the report.
 	 * Zero if not present. If dev_id_byte is also valid and non-zero,
 	 * then the device ID byte will be cleared when the byte pointed to by
 	 * this offset is zero. Only valid if "id" is not zero.
 	 */
-	unsigned int touch_ring_byte;
-
-	/*
-	 * Maximum value of the touch ring report.
-	 * The minimum valid value is considered to be one,
-	 * with zero being out-of-proximity (finger lift) value.
-	 */
-	__s8 touch_ring_max;
-
+	unsigned int touch_byte;
 	/*
-	 * The value to anchor the reversed reports at.
+	 * The value to anchor the reversed touch ring/strip reports at.
 	 * I.e. one, if the reports should be flipped without offset.
 	 * Zero if no reversal should be done.
+	 * Only valid if "touch_byte" is valid and not zero.
+	 */
+	__s8 touch_flip_at;
+	/*
+	 * Maximum value of the touch ring/strip report around which the value
+	 * should be wrapped when flipping according to "touch_flip_at".
+	 * The minimum valid value is considered to be one, with zero being
+	 * out-of-proximity (finger lift) value.
+	 * Only valid if "touch_flip_at" is valid and not zero.
 	 */
-	__s8 touch_ring_flip_at;
+	__s8 touch_max;
 	/*
 	 * Offset of the bitmap dial byte, in the report. Zero if not present.
 	 * Only valid if "id" is not zero. A bitmap dial sends reports with a
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index dd792160fe7e..e2bd3a91e6fd 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -718,8 +718,8 @@ const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
 	0x09, 0x07,         /*  Usage (Keypad),                     */
 	0xA1, 0x01,         /*  Collection (Application),           */
-	0x85, UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID,
-			    /*      Report ID (DIAL_ID),            */
+	0x85, UCLOGIC_RDESC_V2_FRAME_TOUCH_ID,
+			    /*      Report ID (TOUCH_ID),           */
 	0x14,               /*      Logical Minimum (0),            */
 	0x05, 0x0D,         /*      Usage Page (Digitizer),         */
 	0x09, 0x39,         /*      Usage (Tablet Function Keys),   */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 2ab6b7d5f5af..b7bbaa70261e 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -131,15 +131,15 @@ extern const size_t uclogic_rdesc_v1_frame_size;
 extern const __u8 uclogic_rdesc_v2_frame_buttons_arr[];
 extern const size_t uclogic_rdesc_v2_frame_buttons_size;
 
-/* Report ID for tweaked v2 frame touch ring reports */
-#define UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID 0xf8
+/* Report ID for tweaked v2 frame touch ring/strip reports */
+#define UCLOGIC_RDESC_V2_FRAME_TOUCH_ID 0xf8
 
 /* Fixed report descriptor for (tweaked) v2 frame touch ring reports */
 extern const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[];
 extern const size_t uclogic_rdesc_v2_frame_touch_ring_size;
 
-/* Device ID byte offset in v2 frame touch ring reports */
-#define UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_DEV_ID_BYTE	0x4
+/* Device ID byte offset in v2 frame touch ring/strip reports */
+#define UCLOGIC_RDESC_V2_FRAME_TOUCH_DEV_ID_BYTE	0x4
 
 /* Report ID for tweaked v2 frame dial reports */
 #define UCLOGIC_RDESC_V2_FRAME_DIAL_ID 0xf9
-- 
2.25.1

