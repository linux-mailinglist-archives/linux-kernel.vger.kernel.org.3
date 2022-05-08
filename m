Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8482751EED0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiEHQGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiEHQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:06:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA7101DA;
        Sun,  8 May 2022 09:02:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x18so16396607wrc.0;
        Sun, 08 May 2022 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCAIUMXgOaQUy6jpGQ8Il3QqIm6Z+Gcea7ZCrGiHJkM=;
        b=lWiOfBzbnx08jhBiqDcYJyjOLsrMUrXL/rvkOrKqPsTq0TMXPqTl7q6lc9Qvl9Mcl2
         H4pAB+DhqHggJlfPfuigFajXLyayfA+Vfa0VIhZIC/q1/DpyOgbZIoMyaZ9C5NcHS5hg
         LdrUFN39fdYfMICzHetCz2yxcB5Pi+OfLzmB14i4/9MV/VG+/qljUP4vowca+lulHVNi
         bYlYle7hsA+CHdrlgTzpA2O9IdbRRAnasYUcAX92EyAUMnKn0ozkdV9ZgOb8MrAKGZuh
         mwLkUdEMcLuoVxp/rXuYWY88qAClQ5iXKzzbLa/ksnQrsKiXlNu7+LLSfKBvZnq020Sc
         p2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCAIUMXgOaQUy6jpGQ8Il3QqIm6Z+Gcea7ZCrGiHJkM=;
        b=h1H7zLWnmC/pmg869CLBlJbBXXrhGmGYiXTUu9tUZHzUyRt4EKfzQbhFDsl2m+B1G+
         LfL53RwfbRVYQj6jgp1wYdLHp1w8KQbEBM2Fn20RSG5bIOH89f7Bz4Rpz6yClc6kMeOn
         LH6g2aAsfI/efTLqPCK06EdhVVYAQ1G9vzQk4tAVKCd+S0vfGwk4E6goVLjkpxlPg4eR
         Xb4Qq7M4sCodI1XIZNOrFdxS28fWgho91ed913H60FwD1a6I6o8dEW1+g+3022McsrPH
         Lab6P8G0ewJDFIruKWoEijYdbgafE4fSi3IBU1ImI91niPJIbaTB4yvlwuQIHXpchEeq
         AI3g==
X-Gm-Message-State: AOAM531p3z9ZZBXQTYR3uNwJYGnr98Q53/1XI9ODtSLWCvNqgtuyDaLR
        ZIDGRmPWxF9ww+SujOLg8yh61RBV+IY=
X-Google-Smtp-Source: ABdhPJx32yXO38pW0xwFC677hk29JQs+e9DziGmFVecgcmPKXdIhPXuAYjQgdD+PD8s3RNwbQQGF/g==
X-Received: by 2002:a05:6000:1f03:b0:20c:4d9e:7400 with SMTP id bv3-20020a0560001f0300b0020c4d9e7400mr10532054wrb.257.1652025737915;
        Sun, 08 May 2022 09:02:17 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b003942a244ecfsm10101925wmj.20.2022.05.08.09.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 09:02:17 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, albertofanjul@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 5/7] HID: uclogic: Differentiate touch ring and touch strip
Date:   Sun,  8 May 2022 18:01:44 +0200
Message-Id: <20220508160146.13004-6-jose.exposito89@gmail.com>
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

Improve support for touch strips.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 84 +++++++++++++++++++++++---------
 drivers/hid/hid-uclogic-rdesc.c  | 48 ++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.h  |  4 ++
 3 files changed, 112 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 163efd026881..7db63bb77158 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -808,6 +808,14 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	static const char transition_ver[] = "HUION_T153_160607";
 	char *ver_ptr = NULL;
 	const size_t ver_len = sizeof(transition_ver) + 1;
+	__u8 *params_ptr = NULL;
+	size_t params_len = 0;
+	/* Parameters string descriptor of a model with touch ring (HS610) */
+	const __u8 touch_ring_model_params_buf[] = {
+		0x13, 0x03, 0x70, 0xC6, 0x00, 0x06, 0x7C, 0x00,
+		0xFF, 0x1F, 0xD8, 0x13, 0x03, 0x0D, 0x10, 0x01,
+		0x04, 0x3C, 0x3E
+	};
 
 	/* Check arguments */
 	if (params == NULL || hdev == NULL) {
@@ -852,7 +860,8 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	} else {
 		/* Try to probe v2 pen parameters */
 		rc = uclogic_params_pen_init_v2(&p.pen, &found,
-						NULL, NULL, hdev);
+						&params_ptr, &params_len,
+						hdev);
 		if (rc != 0) {
 			hid_err(hdev,
 				"failed probing pen v2 parameters: %d\n", rc);
@@ -872,24 +881,58 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				goto cleanup;
 			}
 
-			/* Create v2 frame touch ring parameters */
-			rc = uclogic_params_frame_init_with_desc(
+			/* Link from pen sub-report */
+			p.pen.subreport_list[0].value = 0xe0;
+			p.pen.subreport_list[0].id =
+				UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID;
+
+			/* If this is the model with touch ring */
+			if (params_ptr != NULL &&
+			    params_len == sizeof(touch_ring_model_params_buf) &&
+			    memcmp(params_ptr, touch_ring_model_params_buf,
+				   params_len) == 0) {
+				/* Create touch ring parameters */
+				rc = uclogic_params_frame_init_with_desc(
 					&p.frame_list[1],
 					uclogic_rdesc_v2_frame_touch_ring_arr,
 					uclogic_rdesc_v2_frame_touch_ring_size,
 					UCLOGIC_RDESC_V2_FRAME_TOUCH_ID);
-			if (rc != 0) {
-				hid_err(hdev,
-					"failed creating v2 frame touch ring parameters: %d\n",
-					rc);
-				goto cleanup;
+				if (rc != 0) {
+					hid_err(hdev,
+						"failed creating v2 frame touch ring parameters: %d\n",
+						rc);
+					goto cleanup;
+				}
+				p.frame_list[1].suffix = "Touch Ring";
+				p.frame_list[1].dev_id_byte =
+					UCLOGIC_RDESC_V2_FRAME_TOUCH_DEV_ID_BYTE;
+				p.frame_list[1].touch_byte = 5;
+				p.frame_list[1].touch_max = 12;
+				p.frame_list[1].touch_flip_at = 7;
+			} else {
+				/* Create touch strip parameters */
+				rc = uclogic_params_frame_init_with_desc(
+					&p.frame_list[1],
+					uclogic_rdesc_v2_frame_touch_strip_arr,
+					uclogic_rdesc_v2_frame_touch_strip_size,
+					UCLOGIC_RDESC_V2_FRAME_TOUCH_ID);
+				if (rc != 0) {
+					hid_err(hdev,
+						"failed creating v2 frame touch strip parameters: %d\n",
+						rc);
+					goto cleanup;
+				}
+				p.frame_list[1].suffix = "Touch Strip";
+				p.frame_list[1].dev_id_byte =
+					UCLOGIC_RDESC_V2_FRAME_TOUCH_DEV_ID_BYTE;
+				p.frame_list[1].touch_byte = 5;
+				p.frame_list[1].touch_max = 8;
 			}
-			p.frame_list[1].suffix = "Touch Ring";
-			p.frame_list[1].dev_id_byte =
-				UCLOGIC_RDESC_V2_FRAME_TOUCH_DEV_ID_BYTE;
-			p.frame_list[1].touch_byte = 5;
-			p.frame_list[1].touch_max = 12;
-			p.frame_list[1].touch_flip_at = 7;
+
+			/* Link from pen sub-report */
+			p.pen.subreport_list[1].value = 0xf0;
+			p.pen.subreport_list[1].id =
+				UCLOGIC_RDESC_V2_FRAME_TOUCH_ID;
 
 			/* Create v2 frame dial parameters */
 			rc = uclogic_params_frame_init_with_desc(
@@ -908,19 +951,11 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				UCLOGIC_RDESC_V2_FRAME_DIAL_DEV_ID_BYTE;
 			p.frame_list[2].bitmap_dial_byte = 5;
 
-			/*
-			 * Link button and touch ring subreports from pen
-			 * reports
-			 */
-			p.pen.subreport_list[0].value = 0xe0;
-			p.pen.subreport_list[0].id =
-				UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID;
-			p.pen.subreport_list[1].value = 0xf0;
-			p.pen.subreport_list[1].id =
-				UCLOGIC_RDESC_V2_FRAME_TOUCH_ID;
+			/* Link from pen sub-report */
 			p.pen.subreport_list[2].value = 0xf1;
 			p.pen.subreport_list[2].id =
 				UCLOGIC_RDESC_V2_FRAME_DIAL_ID;
+
 			goto output;
 		}
 		hid_dbg(hdev, "pen v2 parameters not found\n");
@@ -961,6 +996,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	memset(&p, 0, sizeof(p));
 	rc = 0;
 cleanup:
+	kfree(params_ptr);
 	kfree(ver_ptr);
 	uclogic_params_cleanup(&p);
 	return rc;
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index e2bd3a91e6fd..3c3d4e8780dc 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -761,6 +761,54 @@ const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[] = {
 const size_t uclogic_rdesc_v2_frame_touch_ring_size =
 			sizeof(uclogic_rdesc_v2_frame_touch_ring_arr);
 
+/* Fixed report descriptor for (tweaked) v2 frame touch strip reports */
+const __u8 uclogic_rdesc_v2_frame_touch_strip_arr[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x07,         /*  Usage (Keypad),                     */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, UCLOGIC_RDESC_V2_FRAME_TOUCH_ID,
+			    /*      Report ID (TOUCH_ID),           */
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
+	0x25, 0x07,         /*          Logical Maximum (7),        */
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
+const size_t uclogic_rdesc_v2_frame_touch_strip_size =
+			sizeof(uclogic_rdesc_v2_frame_touch_strip_arr);
+
 /* Fixed report descriptor for (tweaked) v2 frame dial reports */
 const __u8 uclogic_rdesc_v2_frame_dial_arr[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index b7bbaa70261e..0c6e95e8bde7 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -138,6 +138,10 @@ extern const size_t uclogic_rdesc_v2_frame_buttons_size;
 extern const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[];
 extern const size_t uclogic_rdesc_v2_frame_touch_ring_size;
 
+/* Fixed report descriptor for (tweaked) v2 frame touch strip reports */
+extern const __u8 uclogic_rdesc_v2_frame_touch_strip_arr[];
+extern const size_t uclogic_rdesc_v2_frame_touch_strip_size;
+
 /* Device ID byte offset in v2 frame touch ring/strip reports */
 #define UCLOGIC_RDESC_V2_FRAME_TOUCH_DEV_ID_BYTE	0x4
 
-- 
2.25.1

