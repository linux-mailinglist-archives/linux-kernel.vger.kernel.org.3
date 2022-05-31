Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4A5395F8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346900AbiEaSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbiEaSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:13:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B147E1F7;
        Tue, 31 May 2022 11:13:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso1647903wmn.4;
        Tue, 31 May 2022 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAr8shjvKRcCfv7HNBBK8SL5xstDJCBPnCo1qU9xjjY=;
        b=CD3nqGmpYhCWGbRlxJKXtwhrevKBn43+OH2gSK/HC2Dma2Mm818kiFBwgrkFKFDnJu
         K8KsA36cFbAmwQFHLPrhmnX0NGBMvxKHQSITHNQ2jp0GcDfOg1cwhbnu3ots4Cu4C9Vm
         2Hdjfhxh4IOFqt90CaJ5o+LN/XMNDlOXHkj3iCDP24zWMNX2qfynocBKj0gC2wq+w0Mg
         sHu/Xsn1Uq8iVQB54lD4l0eMhPtQwZM+0SyqIIxe4uqF9Moc1OWN2VyWE9ThlNGAYZTE
         oWKlwfH/7kHXe1pesmYrPsqBdn7VhS4naZ/MyEqPgjxsGr1R/SzqMHG6CtIPbTTwYFkW
         tr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAr8shjvKRcCfv7HNBBK8SL5xstDJCBPnCo1qU9xjjY=;
        b=l18RcnxuPBnGxDKfsEoJ46+ILlUdf3UAWqE1492lE+H1zV9XbJCdUlJoorlUlbWFCd
         +Jw5fT9Y7hEBdtP9R9yJ4RyxhRnpgOteIBDOIsw9u8mBtO/6+J2izrr+wLSodjU+ocqE
         fpBa8Slds0b72E1lnGKstTkqbG1o5qFDp6UpoRoKzo78RqN6t7mm9yYjw+9Ppy1ugJzo
         h6MBp8i1z4qRmS1J8zxOB4Rssf4L5nRqZjJnY5h9DK9KIypdtM9gOABF29ygtzpoLlEI
         YLHLsZiS8Owr9fRrFFj7j/p1oBgaIPuPMV8W/Cy838O70cFhouXpLrQPU4K2eCA5uCuL
         v54Q==
X-Gm-Message-State: AOAM530eXB88V2JVeROFq9XHsLIUeYfNUe1QtF5YWUeLJHLGVKhnstHT
        HbGARC7lNiR9GdFUZXIjxQY=
X-Google-Smtp-Source: ABdhPJyg+lvntDq9wQYXblT8ZildvAM3vqQDVl8yG4X25FykKXXjJyuMY1t1UHi4kc52GDF3LEELbQ==
X-Received: by 2002:a05:600c:4618:b0:397:84aa:5585 with SMTP id m24-20020a05600c461800b0039784aa5585mr22708298wmo.21.1654020797746;
        Tue, 31 May 2022 11:13:17 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b0039765a7add4sm3099597wmq.29.2022.05.31.11.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:13:17 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 3/4] HID: uclogic: Allow to generate frame templates
Date:   Tue, 31 May 2022 20:12:45 +0200
Message-Id: <20220531181246.190729-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531181246.190729-1-jose.exposito89@gmail.com>
References: <20220531181246.190729-1-jose.exposito89@gmail.com>
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

