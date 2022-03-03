Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08774CB819
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiCCHsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiCCHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:48:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B26DD94B;
        Wed,  2 Mar 2022 23:47:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ay10so6399199wrb.6;
        Wed, 02 Mar 2022 23:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiVepjW1JG6/Q6RmFnrhcxgSObNvC7PpGqjXdCAH81c=;
        b=UDrnu6G5FwpQdLlep9WTdwHnGvM1DdpGeNR30Bk5ZxXyT6UbnLnYKz5aRprnq+LKRk
         17xpuSL1UDGm7QQryMdJt8NPcvNvH78esl7A8BG5AltilRBmKPWNg/6yepJYy5i6EhD8
         Q2w3BCDRNMsI8w2/XA9+QFWv3JuTuFkWiL7V5W+jphBJpB0hTShqvR/gdKdrN05LYsry
         kpSqX+jDrr9Cm3vXSava8P88qh8S90J09kul9yvvnjzSMaRIdGL2BECYsaaq1syjLgr0
         5du/QRvecPvR//hs2TWH4NA6fcs+i+mKxYtvy7c8pdDahX/b4NvOtNdvpMtgls+JzFoQ
         FPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiVepjW1JG6/Q6RmFnrhcxgSObNvC7PpGqjXdCAH81c=;
        b=h8nMysbOOPnlVcn7NmA0+pHv+qtT7plLl+01uqsqAVpq5s+uyxrB8j2cbo9OxOREjQ
         ml61w1Sz92BMz7hyJOZ/iiA+AoFbZbiY7nXyARVEvaIUAAH60scSZclil6U9SHiTCuVW
         GKFeRPWZ1SP4bH40oiNC7uKjV1gDBMRyCIMncYcfiZWoHjR07KO0H1nZvB00fb8m36LZ
         sACMc6+PC21Y2kWpE7ekYPKvSWlkcff/TMS76fEgcZzMvwLhFWuvG74ri1H+MgnLJuCZ
         hYmh4kBOX7cKEKH6ASfvGAOGs2V+mpb5xw6YD+coaLCjr40TyqwVabUAu6cQ75hZ/97J
         snjg==
X-Gm-Message-State: AOAM533lbxqZlZoCYNZwNEGhgM6LUOSX1SGYb3sYdnMSVD5TVAwRXYOf
        OYt/3yBeRUJ3eYz7PTreZNg=
X-Google-Smtp-Source: ABdhPJxIF8HJj5xNTIrqyqRyCjVyNySLh8FRUyaczlx5bkoabT4yzfQNSttEjAswey3etsTgQet/hQ==
X-Received: by 2002:a5d:64a8:0:b0:1f0:5556:6d3a with SMTP id m8-20020a5d64a8000000b001f055566d3amr1206137wrp.72.1646293662705;
        Wed, 02 Mar 2022 23:47:42 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b003884e826642sm841169wmq.12.2022.03.02.23.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 23:47:42 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 4/4] HID: uclogic: Add support for Huion touch ring reports
Date:   Thu,  3 Mar 2022 08:47:34 +0100
Message-Id: <20220303074734.7235-5-jose.exposito89@gmail.com>
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

Support touch ring reports found in Huion HS610 to the UC-Logic driver.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 40 ++++++++++++++++----
 drivers/hid/hid-uclogic-rdesc.c  | 65 ++++++++++++++++++++++++++++----
 drivers/hid/hid-uclogic-rdesc.h  | 20 +++++++---
 3 files changed, 105 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 5f50ceb875d6..3ac45e7572a0 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -745,22 +745,48 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			goto cleanup;
 		} else if (found) {
 			hid_dbg(hdev, "pen v2 parameters found\n");
-			/* Create v2 frame parameters */
+			/* Create v2 frame button parameters */
 			rc = uclogic_params_frame_init_with_desc(
 					&p.frame_list[0],
-					uclogic_rdesc_v2_frame_arr,
-					uclogic_rdesc_v2_frame_size,
-					UCLOGIC_RDESC_V2_FRAME_ID);
+					uclogic_rdesc_v2_frame_buttons_arr,
+					uclogic_rdesc_v2_frame_buttons_size,
+					UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID);
 			if (rc != 0) {
 				hid_err(hdev,
-					"failed creating v2 frame parameters: %d\n",
+					"failed creating v2 frame button parameters: %d\n",
 					rc);
 				goto cleanup;
 			}
-			/* Link frame button subreports from pen reports */
+
+			/* Create v2 frame touch ring parameters */
+			rc = uclogic_params_frame_init_with_desc(
+					&p.frame_list[1],
+					uclogic_rdesc_v2_frame_touch_ring_arr,
+					uclogic_rdesc_v2_frame_touch_ring_size,
+					UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID);
+			if (rc != 0) {
+				hid_err(hdev,
+					"failed creating v2 frame touch ring parameters: %d\n",
+					rc);
+				goto cleanup;
+			}
+			p.frame_list[1].suffix = "Touch Ring";
+			p.frame_list[1].dev_id_byte =
+				UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_DEV_ID_BYTE;
+			p.frame_list[1].touch_ring_byte = 5;
+			p.frame_list[1].touch_ring_max = 12;
+			p.frame_list[1].touch_ring_flip_at = 6;
+
+			/*
+			 * Link button and touch ring subreports from pen
+			 * reports
+			 */
 			p.pen.subreport_list[0].value = 0xe0;
 			p.pen.subreport_list[0].id =
-				UCLOGIC_RDESC_V2_FRAME_ID;
+				UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID;
+			p.pen.subreport_list[1].value = 0xf0;
+			p.pen.subreport_list[1].id =
+				UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID;
 			goto output;
 		}
 		hid_dbg(hdev, "pen v2 parameters not found\n");
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 04644d93bd11..d64b607dce5d 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -652,12 +652,12 @@ const size_t uclogic_rdesc_v2_pen_template_size =
 			sizeof(uclogic_rdesc_v2_pen_template_arr);
 
 /*
- * Expand to the contents of a generic frame report descriptor.
+ * Expand to the contents of a generic frame buttons report descriptor.
  *
  * @_id:	The report ID to use.
  * @_size:	Size of the report to pad to, including report ID, bytes.
  */
-#define UCLOGIC_RDESC_FRAME_BYTES(_id, _size) \
+#define UCLOGIC_RDESC_FRAME_BUTTONS_BYTES(_id, _size) \
 	0x05, 0x01,     /*  Usage Page (Desktop),               */ \
 	0x09, 0x07,     /*  Usage (Keypad),                     */ \
 	0xA1, 0x01,     /*  Collection (Application),           */ \
@@ -700,17 +700,66 @@ const size_t uclogic_rdesc_v2_pen_template_size =
 
 /* Fixed report descriptor for (tweaked) v1 frame reports */
 const __u8 uclogic_rdesc_v1_frame_arr[] = {
-	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_V1_FRAME_ID, 8)
+	UCLOGIC_RDESC_FRAME_BUTTONS_BYTES(UCLOGIC_RDESC_V1_FRAME_ID, 8)
 };
 const size_t uclogic_rdesc_v1_frame_size =
 			sizeof(uclogic_rdesc_v1_frame_arr);
 
-/* Fixed report descriptor for (tweaked) v2 frame reports */
-const __u8 uclogic_rdesc_v2_frame_arr[] = {
-	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_V2_FRAME_ID, 12)
+/* Fixed report descriptor for (tweaked) v2 frame button reports */
+const __u8 uclogic_rdesc_v2_frame_buttons_arr[] = {
+	UCLOGIC_RDESC_FRAME_BUTTONS_BYTES(UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID,
+					  12)
 };
-const size_t uclogic_rdesc_v2_frame_size =
-			sizeof(uclogic_rdesc_v2_frame_arr);
+const size_t uclogic_rdesc_v2_frame_buttons_size =
+			sizeof(uclogic_rdesc_v2_frame_buttons_arr);
+
+/* Fixed report descriptor for (tweaked) v2 frame touch ring reports */
+const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x07,         /*  Usage (Keypad),                     */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID,
+			    /*      Report ID (DIAL_ID),            */
+	0x14,               /*      Logical Minimum (0),            */
+	0x05, 0x0D,         /*      Usage Page (Digitizer),         */
+	0x09, 0x39,         /*      Usage (Tablet Function Keys),   */
+	0xA0,               /*      Collection (Physical),          */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x05, 0x09,         /*          Usage Page (Button),        */
+	0x09, 0x01,         /*          Usage (01h),                */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x07,         /*          Report Count (7),           */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x02,         /*          Report Count (2),           */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x05, 0x0D,         /*          Usage Page (Digitizer),     */
+	0x0A, 0xFF, 0xFF,   /*          Usage (FFFFh),              */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x09, 0x38,         /*          Usage (Wheel),              */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x15, 0x00,         /*          Logical Minimum (0),        */
+	0x25, 0x0B,         /*          Logical Maximum (11),       */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x09, 0x30,         /*          Usage (X),                  */
+	0x09, 0x31,         /*          Usage (Y),                  */
+	0x14,               /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x02,         /*          Report Count (2),           */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x2E,         /*          Report Count (46),          */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
+};
+const size_t uclogic_rdesc_v2_frame_touch_ring_size =
+			sizeof(uclogic_rdesc_v2_frame_touch_ring_arr);
 
 /* Fixed report descriptor for Ugee EX07 frame */
 const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 3d904c27b86a..f15a9d8a946b 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -124,12 +124,22 @@ extern const size_t uclogic_rdesc_v2_pen_template_size;
 extern const __u8 uclogic_rdesc_v1_frame_arr[];
 extern const size_t uclogic_rdesc_v1_frame_size;
 
-/* Report ID for tweaked v2 frame reports */
-#define UCLOGIC_RDESC_V2_FRAME_ID 0xf7
+/* Report ID for tweaked v2 frame button reports */
+#define UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID 0xf7
 
-/* Fixed report descriptor for (tweaked) v2 frame reports */
-extern const __u8 uclogic_rdesc_v2_frame_arr[];
-extern const size_t uclogic_rdesc_v2_frame_size;
+/* Fixed report descriptor for (tweaked) v2 frame button reports */
+extern const __u8 uclogic_rdesc_v2_frame_buttons_arr[];
+extern const size_t uclogic_rdesc_v2_frame_buttons_size;
+
+/* Report ID for tweaked v2 frame touch ring reports */
+#define UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_ID 0xf8
+
+/* Fixed report descriptor for (tweaked) v2 frame touch ring reports */
+extern const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[];
+extern const size_t uclogic_rdesc_v2_frame_touch_ring_size;
+
+/* Device ID byte offset in v2 frame touch ring reports */
+#define UCLOGIC_RDESC_V2_FRAME_TOUCH_RING_DEV_ID_BYTE	0x4
 
 /* Fixed report descriptor for Ugee EX07 frame */
 extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
-- 
2.25.1

