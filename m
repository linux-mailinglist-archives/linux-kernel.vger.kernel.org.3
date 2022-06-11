Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6994254744F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiFKLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiFKLj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:39:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DFDFF0;
        Sat, 11 Jun 2022 04:39:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x17so1601740wrg.6;
        Sat, 11 Jun 2022 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAr8shjvKRcCfv7HNBBK8SL5xstDJCBPnCo1qU9xjjY=;
        b=bfZz8x2DPAMl5wzFr0eqjMOR3rp/PnF/1kHrJ1GV5cQID+wrB4zo5q9Az4FxfOvfCT
         rXXyaKW0rAHNd0NtShSX5djrqAv4cqNVWF/QomLV2iqqEyRj2tlZEWFF9xJNVH4OGOnZ
         bCqRm3gNGTRdaVwjv0WSTGTGH1NUub6SDOW1udifGJ36jAQA/kUMGLINw8dU4hT7V7BF
         C+mfIoJ8x2JKnCt7joXwPbuk7Zct82o5m0CQ/cDzoLpWHpW2FWRHTOkwl6FzuxzZEYv3
         wD7OMHWRAPf8NP1Il0uG3ZA4YHRc2TIxKHD3vDTuvE/i2ia37ykymX+r7AM16sOcqcbh
         ot4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAr8shjvKRcCfv7HNBBK8SL5xstDJCBPnCo1qU9xjjY=;
        b=FzV1emoXOdXZ2S3HidSumvcU1UloLB1M+ITePNxa9TY8gIJpFk6axjrn0q0vUg+euO
         SeiLb7n4n7AIhorlENdeQxNsk3NPjDYxl7kERGWk8d+a3XVQoR1AdwDTr/E08flHW6+U
         V1DZUwc19huENq0z0pIiWjkeqoZn+vXxSjL/3gbEkPy0x9eMKTZHiS+Et3KwbAb5UcPg
         llQOZRURT2pty4/jWbOhwhqjIapu5Q4oxLzmfYz5HbrQR8hfj397sJNoQJXLKQLBu1jk
         uy4lift3yPfoAUxN2CZBRdhWQebGF+ldgCbzMqKlB16H4vo4vywF04AYzBFvfYVroJNz
         2REg==
X-Gm-Message-State: AOAM531HhrsZ5yqWSItgH8tXQZRbN3WlCurxM6GPGWGiKj6I+L74Ury1
        V2UC7NeqzNxXgzpZzMSOtQ4=
X-Google-Smtp-Source: ABdhPJypA8sSHoULmOCCwUD3OHbt1Ul5hiuRGxqEGYho/G+7U8bzYaHrQ+DCAWnWEGVQSCiZbClf1w==
X-Received: by 2002:adf:d1e7:0:b0:215:2126:dede with SMTP id g7-20020adfd1e7000000b002152126dedemr41966585wrd.297.1654947563600;
        Sat, 11 Jun 2022 04:39:23 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b0039c4945c753sm6574198wmq.39.2022.06.11.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 04:39:23 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 3/4] HID: uclogic: Allow to generate frame templates
Date:   Sat, 11 Jun 2022 13:39:13 +0200
Message-Id: <20220611113914.355577-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611113914.355577-1-jose.exposito89@gmail.com>
References: <20220611113914.355577-1-jose.exposito89@gmail.com>
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

Add a new template placeholder to allow configuring the number of
buttons in the drawing tablet frame and update the KUnit tests to
cover the new case.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc-test.c | 36 ++++++++++++++++++++++++++++
 drivers/hid/hid-uclogic-rdesc.c      | 14 ++++++++---
 drivers/hid/hid-uclogic-rdesc.h      |  6 +++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
index ded59e226230..ebebffef5f8a 100644
--- a/drivers/hid/hid-uclogic-rdesc-test.c
+++ b/drivers/hid/hid-uclogic-rdesc-test.c
@@ -31,6 +31,10 @@ static const s32 params_pen_some[] = {
 	[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0xBB,
 };
 
+static const s32 params_frame_all[UCLOGIC_RDESC_PH_ID_NUM] = {
+	[UCLOGIC_RDESC_FRAME_PH_ID_UM] = 0xFF,
+};
+
 static const __u8 template_empty[] = { };
 static const __u8 template_small[] = { 0x00 };
 static const __u8 template_no_ph[] = { 0xAA, 0xFE, 0xAA, 0xED, 0x1D };
@@ -39,6 +43,10 @@ static const __u8 template_pen_ph_end[] = {
 	0xAA, 0xBB, UCLOGIC_RDESC_PEN_PH_HEAD
 };
 
+static const __u8 template_btn_ph_end[] = {
+	0xAA, 0xBB, UCLOGIC_RDESC_FRAME_PH_BTN_HEAD
+};
+
 static const __u8 template_pen_all_params[] = {
 	UCLOGIC_RDESC_PEN_PH(X_LM),
 	0x47, UCLOGIC_RDESC_PEN_PH(X_PM),
@@ -55,6 +63,18 @@ static const __u8 expected_pen_all_params[] = {
 	0x00, 0xEE, 0x00, 0x00, 0x00,
 };
 
+static const __u8 template_frame_all_params[] = {
+	0x01, 0x02,
+	UCLOGIC_RDESC_FRAME_PH_BTN,
+	0x99,
+};
+
+static const __u8 expected_frame_all_params[] = {
+	0x01, 0x02,
+	0x2A, 0xFF, 0x00,
+	0x99,
+};
+
 static const __u8 template_pen_some_params[] = {
 	0x01, 0x02,
 	UCLOGIC_RDESC_PEN_PH(X_LM),
@@ -108,6 +128,14 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.param_num = ARRAY_SIZE(params_pen_all),
 		.expected = template_pen_ph_end,
 	},
+	{
+		.name = "Frame button placeholder at the end, without ID",
+		.template = template_btn_ph_end,
+		.template_size = sizeof(template_btn_ph_end),
+		.param_list = params_frame_all,
+		.param_num = ARRAY_SIZE(params_frame_all),
+		.expected = template_btn_ph_end,
+	},
 	{
 		.name = "All params present in the pen template",
 		.template = template_pen_all_params,
@@ -116,6 +144,14 @@ static struct uclogic_template_case uclogic_template_cases[] = {
 		.param_num = ARRAY_SIZE(params_pen_all),
 		.expected = expected_pen_all_params,
 	},
+	{
+		.name = "All params present in the frame template",
+		.template = template_frame_all_params,
+		.template_size = sizeof(template_frame_all_params),
+		.param_list = params_frame_all,
+		.param_num = ARRAY_SIZE(params_frame_all),
+		.expected = expected_frame_all_params,
+	},
 	{
 		.name = "Some params present in the pen template (complete param list)",
 		.template = template_pen_some_params,
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 7126fba80968..3fb84ac492b4 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -979,7 +979,7 @@ const size_t uclogic_rdesc_xppen_deco01_frame_size =
  * uclogic_rdesc_template_apply() - apply report descriptor parameters to a
  * report descriptor template, creating a report descriptor. Copies the
  * template over to the new report descriptor and replaces every occurrence of
- * UCLOGIC_RDESC_PEN_PH_HEAD, followed by an index byte, with the value from the
+ * the template placeholders, followed by an index byte, with the value from the
  * parameter list at that index.
  *
  * @template_ptr:	Pointer to the template buffer.
@@ -996,6 +996,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 				   const s32 *param_list,
 				   size_t param_num)
 {
+	static const __u8 btn_head[] = {UCLOGIC_RDESC_FRAME_PH_BTN_HEAD};
 	static const __u8 pen_head[] = {UCLOGIC_RDESC_PEN_PH_HEAD};
 	__u8 *rdesc_ptr;
 	__u8 *p;
@@ -1005,12 +1006,19 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 	if (rdesc_ptr == NULL)
 		return NULL;
 
-	for (p = rdesc_ptr; p + sizeof(pen_head) < rdesc_ptr + template_size;) {
-		if (memcmp(p, pen_head, sizeof(pen_head)) == 0 &&
+	for (p = rdesc_ptr; p + sizeof(btn_head) < rdesc_ptr + template_size;) {
+		if (p + sizeof(pen_head) < rdesc_ptr + template_size &&
+		    memcmp(p, pen_head, sizeof(pen_head)) == 0 &&
 		    p[sizeof(pen_head)] < param_num) {
 			v = param_list[p[sizeof(pen_head)]];
 			put_unaligned(cpu_to_le32(v), (s32 *)p);
 			p += sizeof(pen_head) + 1;
+		} else if (memcmp(p, btn_head, sizeof(btn_head)) == 0 &&
+			   p[sizeof(btn_head)] < param_num) {
+			v = param_list[p[sizeof(btn_head)]];
+			put_unaligned((__u8)0x2A, p); /* Usage Maximum */
+			put_unaligned_le16((__force u16)cpu_to_le16(v), p + 1);
+			p += sizeof(btn_head) + 1;
 		} else {
 			p++;
 		}
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 9d37090c39d1..3d78299f082d 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -82,6 +82,7 @@ extern const size_t uclogic_rdesc_twha60_fixed1_size;
 
 /* Report descriptor template placeholder head */
 #define UCLOGIC_RDESC_PEN_PH_HEAD	0xFE, 0xED, 0x1D
+#define UCLOGIC_RDESC_FRAME_PH_BTN_HEAD	0xFE, 0xED
 
 /* Apply report descriptor parameters to a report descriptor template */
 extern __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
@@ -96,6 +97,7 @@ enum uclogic_rdesc_ph_id {
 	UCLOGIC_RDESC_PEN_PH_ID_Y_LM,
 	UCLOGIC_RDESC_PEN_PH_ID_Y_PM,
 	UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM,
+	UCLOGIC_RDESC_FRAME_PH_ID_UM,
 	UCLOGIC_RDESC_PH_ID_NUM
 };
 
@@ -103,6 +105,10 @@ enum uclogic_rdesc_ph_id {
 #define UCLOGIC_RDESC_PEN_PH(_ID) \
 	UCLOGIC_RDESC_PEN_PH_HEAD, UCLOGIC_RDESC_PEN_PH_ID_##_ID
 
+/* Report descriptor frame buttons template placeholder */
+#define UCLOGIC_RDESC_FRAME_PH_BTN \
+	UCLOGIC_RDESC_FRAME_PH_BTN_HEAD, UCLOGIC_RDESC_FRAME_PH_ID_UM
+
 /* Report ID for v1 pen reports */
 #define UCLOGIC_RDESC_V1_PEN_ID	0x07
 
-- 
2.25.1

