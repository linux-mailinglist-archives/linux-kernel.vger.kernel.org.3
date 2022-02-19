Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DB84BC77F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbiBSKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:03:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiBSKCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:02:34 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42DA195;
        Sat, 19 Feb 2022 02:02:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m27so6681111wrb.4;
        Sat, 19 Feb 2022 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m07NzeDNgXIpmmakHBOfuEWrfbejOEgooxQTFQQRZTQ=;
        b=l+8HbbX6aO557qAofeqV6p33HmS49v1TQL8MKgnIP9geIC359EMQnC407Xioi0RieF
         ln0PO9kx7RJi8+bRyvLqFQ//vTTa6q3oIdjaFSjql/JkGKaV+sIe+9TRBVAAIBpyulsD
         PJflX2uVIP57KGGVR6xT5a4+cgApuwzM14XdGkBfHY36qvZ3uv6/vb9Q+ucfKc+LL7qe
         tSxWs0kGmpm6S7cTtZWMK8hhWGYP/dEb0ySPH34PZtvNqUcIbua/nPN4M04WpsZZP1YV
         paMSiTmZ3rkhdB+xxADqcD5W2dpzuBHHfIpIhpjQcNYJX++54FYqpHYVmINRsA+xe8i/
         xoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m07NzeDNgXIpmmakHBOfuEWrfbejOEgooxQTFQQRZTQ=;
        b=izBXh03LEaoYIgt/DuvH4KvEEEvQD49YqNxJjJ8glU2Ir+vGnluHJRpK1sbpEe4Zrq
         CHu6tqOdULI4tHxe6uY8hJgFKlwD0oxWVf9J6UE8GyJvIWr0pas5VIRAKPBwuKWB6wvF
         lK1ik9RKf+56wH8lm1lF3KAjkHSNWjvneIEcu0LKs5/+qxAyBry5c/NfatBa8r+SGClY
         tZnrlvZ5IKUqXZJiNersufxlBrYviNoG83chuwsZI1Tr1QPynGaAj+H7ai9BjcVRiMYI
         88YxaxGZ8KL3u8YQIsXoAJC8cjd2WrQc2Ag828NkudBT1KcvH79yyia4KkiLoJOuYWsr
         Jxsg==
X-Gm-Message-State: AOAM533bl8LySDbehiCJ1lWIjQ6wFLKSWomWQVgIhmJHPjFNepA7H4Uf
        IJXQDFAr/y++JuPT/uz5WvI=
X-Google-Smtp-Source: ABdhPJxW3KRQYeN0N509XlLSenXfkWvsxLyjoZegXSx+UFYWl+W/CMd9Hzd/UyrrFiPZxY2KcW5CuA==
X-Received: by 2002:adf:fe02:0:b0:1e3:266:d1c with SMTP id n2-20020adffe02000000b001e302660d1cmr8761544wrr.582.1645264934427;
        Sat, 19 Feb 2022 02:02:14 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id az13sm24417244wrb.39.2022.02.19.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 02:02:14 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 6/9] HID: uclogic: Use "frame" instead of "buttonpad"
Date:   Sat, 19 Feb 2022 11:01:54 +0100
Message-Id: <20220219100157.41920-7-jose.exposito89@gmail.com>
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

Use the term "frame" instead of "buttonpad" for consistency, in UC-Logic
driver.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 46 +++++++++++++++-----------------
 drivers/hid/hid-uclogic-rdesc.c  | 32 +++++++++++-----------
 drivers/hid/hid-uclogic-rdesc.h  | 26 +++++++++---------
 3 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index a4a53ab1e72c..168749d9a112 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -431,8 +431,8 @@ static int uclogic_params_frame_init_with_desc(
 }
 
 /**
- * uclogic_params_frame_init_v1_buttonpad() - initialize abstract buttonpad
- * on a v1 tablet interface.
+ * uclogic_params_frame_init_v1() - initialize v1 tablet interface frame
+ * controls.
  *
  * @frame:	Pointer to the frame parameters to initialize (to be cleaned
  *		up with uclogic_params_frame_cleanup()). Not modified in case
@@ -446,8 +446,7 @@ static int uclogic_params_frame_init_with_desc(
  * Returns:
  *	Zero, if successful. A negative errno code on error.
  */
-static int uclogic_params_frame_init_v1_buttonpad(
-					struct uclogic_params_frame *frame,
+static int uclogic_params_frame_init_v1(struct uclogic_params_frame *frame,
 					bool *pfound,
 					struct hid_device *hdev)
 {
@@ -488,9 +487,9 @@ static int uclogic_params_frame_init_v1_buttonpad(
 		hid_dbg(hdev, "generic buttons enabled\n");
 		rc = uclogic_params_frame_init_with_desc(
 				frame,
-				uclogic_rdesc_buttonpad_v1_arr,
-				uclogic_rdesc_buttonpad_v1_size,
-				UCLOGIC_RDESC_BUTTONPAD_V1_ID);
+				uclogic_rdesc_frame_v1_arr,
+				uclogic_rdesc_frame_v1_size,
+				UCLOGIC_RDESC_FRAME_V1_ID);
 		if (rc != 0)
 			goto cleanup;
 		found = true;
@@ -750,22 +749,22 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 			goto cleanup;
 		} else if (found) {
 			hid_dbg(hdev, "pen v2 parameters found\n");
-			/* Create v2 buttonpad parameters */
+			/* Create v2 frame parameters */
 			rc = uclogic_params_frame_init_with_desc(
 					&p.frame,
-					uclogic_rdesc_buttonpad_v2_arr,
-					uclogic_rdesc_buttonpad_v2_size,
-					UCLOGIC_RDESC_BUTTONPAD_V2_ID);
+					uclogic_rdesc_frame_v2_arr,
+					uclogic_rdesc_frame_v2_size,
+					UCLOGIC_RDESC_FRAME_V2_ID);
 			if (rc != 0) {
 				hid_err(hdev,
-					"failed creating v2 buttonpad parameters: %d\n",
+					"failed creating v2 frame parameters: %d\n",
 					rc);
 				goto cleanup;
 			}
 			/* Link frame button subreports from pen reports */
 			p.pen.subreport_list[0].value = 0xe0;
 			p.pen.subreport_list[0].id =
-				UCLOGIC_RDESC_BUTTONPAD_V2_ID;
+				UCLOGIC_RDESC_FRAME_V2_ID;
 			goto output;
 		}
 		hid_dbg(hdev, "pen v2 parameters not found\n");
@@ -779,21 +778,20 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 		goto cleanup;
 	} else if (found) {
 		hid_dbg(hdev, "pen v1 parameters found\n");
-		/* Try to probe v1 buttonpad */
-		rc = uclogic_params_frame_init_v1_buttonpad(
-						&p.frame,
-						&found, hdev);
+		/* Try to probe v1 frame */
+		rc = uclogic_params_frame_init_v1(&p.frame,
+						  &found, hdev);
 		if (rc != 0) {
-			hid_err(hdev, "v1 buttonpad probing failed: %d\n", rc);
+			hid_err(hdev, "v1 frame probing failed: %d\n", rc);
 			goto cleanup;
 		}
-		hid_dbg(hdev, "buttonpad v1 parameters%s found\n",
+		hid_dbg(hdev, "frame v1 parameters%s found\n",
 			(found ? "" : " not"));
 		if (found) {
 			/* Link frame button subreports from pen reports */
 			p.pen.subreport_list[0].value = 0xe0;
 			p.pen.subreport_list[0].id =
-				UCLOGIC_RDESC_BUTTONPAD_V1_ID;
+				UCLOGIC_RDESC_FRAME_V1_ID;
 		}
 		goto output;
 	}
@@ -1067,7 +1065,7 @@ int uclogic_params_init(struct uclogic_params *params,
 				UCLOGIC_RDESC_UGEE_G5_FRAME_ID);
 			if (rc != 0) {
 				hid_err(hdev,
-					"failed creating buttonpad parameters: %d\n",
+					"failed creating frame parameters: %d\n",
 					rc);
 				goto cleanup;
 			}
@@ -1096,12 +1094,12 @@ int uclogic_params_init(struct uclogic_params *params,
 		} else if (found) {
 			rc = uclogic_params_frame_init_with_desc(
 				&p.frame,
-				uclogic_rdesc_ugee_ex07_buttonpad_arr,
-				uclogic_rdesc_ugee_ex07_buttonpad_size,
+				uclogic_rdesc_ugee_ex07_frame_arr,
+				uclogic_rdesc_ugee_ex07_frame_size,
 				0);
 			if (rc != 0) {
 				hid_err(hdev,
-					"failed creating buttonpad parameters: %d\n",
+					"failed creating frame parameters: %d\n",
 					rc);
 				goto cleanup;
 			}
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 66aa83f67ccc..e8dedede3395 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -652,12 +652,12 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 			sizeof(uclogic_rdesc_pen_v2_template_arr);
 
 /*
- * Expand to the contents of a generic buttonpad report descriptor.
+ * Expand to the contents of a generic frame report descriptor.
  *
  * @_id:	The report ID to use.
  * @_size:	Size of the report to pad to, including report ID, bytes.
  */
-#define UCLOGIC_RDESC_BUTTONPAD_BYTES(_id, _size) \
+#define UCLOGIC_RDESC_FRAME_BYTES(_id, _size) \
 	0x05, 0x01,     /*  Usage Page (Desktop),               */ \
 	0x09, 0x07,     /*  Usage (Keypad),                     */ \
 	0xA1, 0x01,     /*  Collection (Application),           */ \
@@ -698,22 +698,22 @@ const size_t uclogic_rdesc_pen_v2_template_size =
 	0xC0,           /*      End Collection,                 */ \
 	0xC0            /*  End Collection                      */
 
-/* Fixed report descriptor for (tweaked) v1 buttonpad reports */
-const __u8 uclogic_rdesc_buttonpad_v1_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(UCLOGIC_RDESC_BUTTONPAD_V1_ID, 8)
+/* Fixed report descriptor for (tweaked) v1 frame reports */
+const __u8 uclogic_rdesc_frame_v1_arr[] = {
+	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_FRAME_V1_ID, 8)
 };
-const size_t uclogic_rdesc_buttonpad_v1_size =
-			sizeof(uclogic_rdesc_buttonpad_v1_arr);
+const size_t uclogic_rdesc_frame_v1_size =
+			sizeof(uclogic_rdesc_frame_v1_arr);
 
-/* Fixed report descriptor for (tweaked) v2 buttonpad reports */
-const __u8 uclogic_rdesc_buttonpad_v2_arr[] = {
-	UCLOGIC_RDESC_BUTTONPAD_BYTES(UCLOGIC_RDESC_BUTTONPAD_V2_ID, 12)
+/* Fixed report descriptor for (tweaked) v2 frame reports */
+const __u8 uclogic_rdesc_frame_v2_arr[] = {
+	UCLOGIC_RDESC_FRAME_BYTES(UCLOGIC_RDESC_FRAME_V2_ID, 12)
 };
-const size_t uclogic_rdesc_buttonpad_v2_size =
-			sizeof(uclogic_rdesc_buttonpad_v2_arr);
+const size_t uclogic_rdesc_frame_v2_size =
+			sizeof(uclogic_rdesc_frame_v2_arr);
 
-/* Fixed report descriptor for Ugee EX07 buttonpad */
-const __u8 uclogic_rdesc_ugee_ex07_buttonpad_arr[] = {
+/* Fixed report descriptor for Ugee EX07 frame */
+const __u8 uclogic_rdesc_ugee_ex07_frame_arr[] = {
 	0x05, 0x01,             /*  Usage Page (Desktop),                   */
 	0x09, 0x07,             /*  Usage (Keypad),                         */
 	0xA1, 0x01,             /*  Collection (Application),               */
@@ -736,8 +736,8 @@ const __u8 uclogic_rdesc_ugee_ex07_buttonpad_arr[] = {
 	0xC0,                   /*      End Collection,                     */
 	0xC0                    /*  End Collection                          */
 };
-const size_t uclogic_rdesc_ugee_ex07_buttonpad_size =
-			sizeof(uclogic_rdesc_ugee_ex07_buttonpad_arr);
+const size_t uclogic_rdesc_ugee_ex07_frame_size =
+			sizeof(uclogic_rdesc_ugee_ex07_frame_arr);
 
 /* Fixed report descriptor for Ugee G5 frame controls */
 const __u8 uclogic_rdesc_ugee_g5_frame_arr[] = {
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index c5da51055af3..40c6f02c6bab 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -117,23 +117,23 @@ extern const size_t uclogic_rdesc_pen_v1_template_size;
 extern const __u8 uclogic_rdesc_pen_v2_template_arr[];
 extern const size_t uclogic_rdesc_pen_v2_template_size;
 
-/* Fixed report descriptor for (tweaked) v1 buttonpad reports */
-extern const __u8 uclogic_rdesc_buttonpad_v1_arr[];
-extern const size_t uclogic_rdesc_buttonpad_v1_size;
+/* Fixed report descriptor for (tweaked) v1 frame reports */
+extern const __u8 uclogic_rdesc_frame_v1_arr[];
+extern const size_t uclogic_rdesc_frame_v1_size;
 
-/* Report ID for tweaked v1 buttonpad reports */
-#define UCLOGIC_RDESC_BUTTONPAD_V1_ID 0xf7
+/* Report ID for tweaked v1 frame reports */
+#define UCLOGIC_RDESC_FRAME_V1_ID 0xf7
 
-/* Fixed report descriptor for (tweaked) v2 buttonpad reports */
-extern const __u8 uclogic_rdesc_buttonpad_v2_arr[];
-extern const size_t uclogic_rdesc_buttonpad_v2_size;
+/* Fixed report descriptor for (tweaked) v2 frame reports */
+extern const __u8 uclogic_rdesc_frame_v2_arr[];
+extern const size_t uclogic_rdesc_frame_v2_size;
 
-/* Report ID for tweaked v2 buttonpad reports */
-#define UCLOGIC_RDESC_BUTTONPAD_V2_ID 0xf7
+/* Report ID for tweaked v2 frame reports */
+#define UCLOGIC_RDESC_FRAME_V2_ID 0xf7
 
-/* Fixed report descriptor for Ugee EX07 buttonpad */
-extern const __u8 uclogic_rdesc_ugee_ex07_buttonpad_arr[];
-extern const size_t uclogic_rdesc_ugee_ex07_buttonpad_size;
+/* Fixed report descriptor for Ugee EX07 frame */
+extern const __u8 uclogic_rdesc_ugee_ex07_frame_arr[];
+extern const size_t uclogic_rdesc_ugee_ex07_frame_size;
 
 /* Fixed report descriptor for XP-Pen Deco 01 frame controls */
 extern const __u8 uclogic_rdesc_xppen_deco01_frame_arr[];
-- 
2.25.1

