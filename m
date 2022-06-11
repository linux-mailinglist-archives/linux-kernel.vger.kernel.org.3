Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207FF54744E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiFKLj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiFKLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:39:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE37DFF0;
        Sat, 11 Jun 2022 04:39:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u8so1568314wrm.13;
        Sat, 11 Jun 2022 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PjQuKMkTY1kyPsdXkRWcy11RqWiSJraBoDtsiZIFcs=;
        b=pMAV4YZDWCCWc6eMKct6qOVKz92iXyCAAj6bSWuv4NVXkN0+IWOEQR8ZeWUHIQmJHS
         mjZAKDrY44b8qeA0wJvGleRTdaUHPSx78Oeno5tSF6rVODsXtE30gfRE6HMPN9qMw5Oc
         cD1Z5XkYo8Ftc+6J/KafWm/L8U4chJ+2mwRFKwHhqhqDnzmYDtwiQ7s0gV+LT2rzC4TE
         7l4G5QQoZEgoA2RZjHUs605L9aYxlOMy3yUNX19cImlBP+BxIXeOieQt0/romLmim5Hm
         r4T5+CH30zPpwt8gIX7mCEeL0OoP22JlMIBLjhq895y57HOdz0U8tad4h03tUkb6Hiox
         rD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PjQuKMkTY1kyPsdXkRWcy11RqWiSJraBoDtsiZIFcs=;
        b=GfLdbh/Z+yyvRVyme8yHETiXvy+TpL32R3AAJcXoIwAK6Uw41Jj973QaUz0vqyN4gT
         6r49s7UpLALJzY1a27/lMEvAhYzFZfRblYf5UrHRHzDpfrQBYZtsAoTCcGB9xWiEXtE0
         BXI17bgzLUVBXnI2GATwQZRFlf8WeFj0EytzK8hBOJKAebo1w6IcrwRiJRe0qdZNMnuA
         +2NWiT64LPqp0X1TQKSAm2u/yJv/zbzhEFCjRrcTA4EqhRxZd5Pcmsl8Gbt89QtZpShV
         efSTmZAVXOJZNonBXExRJreDEsFJf3ooGZEsi4HRGRbQfP186RPMls9vn0dUFnQdlxlJ
         ytgA==
X-Gm-Message-State: AOAM530hB77Nhd4FTJumOnpe+MTYDqNKVt2vYQNbHj9Utmap8LdEBgcB
        3wlV0CzH4PhHSbzaLgu2UU27PAZrJw4=
X-Google-Smtp-Source: ABdhPJzc8Pvxr69wjXMxllNgQSpnO+W1ifZeTXJfLLTeqTD7bbuEmGlT069kZ9+kpx5w61LrtA1qgQ==
X-Received: by 2002:a5d:624e:0:b0:210:a42:f29d with SMTP id m14-20020a5d624e000000b002100a42f29dmr47648017wrv.615.1654947560749;
        Sat, 11 Jun 2022 04:39:20 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b0039c4945c753sm6574198wmq.39.2022.06.11.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 04:39:20 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 1/4] HID: uclogic: Make template placeholder IDs generic
Date:   Sat, 11 Jun 2022 13:39:11 +0200
Message-Id: <20220611113914.355577-2-jose.exposito89@gmail.com>
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

Up until now, the report descriptor template parameter IDs were only
used with pen report descriptors and they were named accordingly.

Rename the enum and the total number of IDs to make them interface
agnostic.

Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c |  4 ++--
 drivers/hid/hid-uclogic-rdesc.c  | 14 +++++++-------
 drivers/hid/hid-uclogic-rdesc.h  | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index db838f16282d..b43142f98a8b 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -234,7 +234,7 @@ static int uclogic_params_pen_init_v1(struct uclogic_params_pen *pen,
 	const int len = 12;
 	s32 resolution;
 	/* Pen report descriptor template parameters */
-	s32 desc_params[UCLOGIC_RDESC_PEN_PH_ID_NUM];
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	__u8 *desc_ptr = NULL;
 
 	/* Check arguments */
@@ -379,7 +379,7 @@ static int uclogic_params_pen_init_v2(struct uclogic_params_pen *pen,
 	size_t i;
 	s32 resolution;
 	/* Pen report descriptor template parameters */
-	s32 desc_params[UCLOGIC_RDESC_PEN_PH_ID_NUM];
+	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	__u8 *desc_ptr = NULL;
 
 	/* Check arguments */
diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
index 13f9ce73f1b1..7126fba80968 100644
--- a/drivers/hid/hid-uclogic-rdesc.c
+++ b/drivers/hid/hid-uclogic-rdesc.c
@@ -979,7 +979,7 @@ const size_t uclogic_rdesc_xppen_deco01_frame_size =
  * uclogic_rdesc_template_apply() - apply report descriptor parameters to a
  * report descriptor template, creating a report descriptor. Copies the
  * template over to the new report descriptor and replaces every occurrence of
- * UCLOGIC_RDESC_PH_HEAD, followed by an index byte, with the value from the
+ * UCLOGIC_RDESC_PEN_PH_HEAD, followed by an index byte, with the value from the
  * parameter list at that index.
  *
  * @template_ptr:	Pointer to the template buffer.
@@ -996,7 +996,7 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 				   const s32 *param_list,
 				   size_t param_num)
 {
-	static const __u8 head[] = {UCLOGIC_RDESC_PH_HEAD};
+	static const __u8 pen_head[] = {UCLOGIC_RDESC_PEN_PH_HEAD};
 	__u8 *rdesc_ptr;
 	__u8 *p;
 	s32 v;
@@ -1005,12 +1005,12 @@ __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 	if (rdesc_ptr == NULL)
 		return NULL;
 
-	for (p = rdesc_ptr; p + sizeof(head) < rdesc_ptr + template_size;) {
-		if (memcmp(p, head, sizeof(head)) == 0 &&
-		    p[sizeof(head)] < param_num) {
-			v = param_list[p[sizeof(head)]];
+	for (p = rdesc_ptr; p + sizeof(pen_head) < rdesc_ptr + template_size;) {
+		if (memcmp(p, pen_head, sizeof(pen_head)) == 0 &&
+		    p[sizeof(pen_head)] < param_num) {
+			v = param_list[p[sizeof(pen_head)]];
 			put_unaligned(cpu_to_le32(v), (s32 *)p);
-			p += sizeof(head) + 1;
+			p += sizeof(pen_head) + 1;
 		} else {
 			p++;
 		}
diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
index 0c6e95e8bde7..9d37090c39d1 100644
--- a/drivers/hid/hid-uclogic-rdesc.h
+++ b/drivers/hid/hid-uclogic-rdesc.h
@@ -81,7 +81,7 @@ extern __u8 uclogic_rdesc_twha60_fixed1_arr[];
 extern const size_t uclogic_rdesc_twha60_fixed1_size;
 
 /* Report descriptor template placeholder head */
-#define UCLOGIC_RDESC_PH_HEAD	0xFE, 0xED, 0x1D
+#define UCLOGIC_RDESC_PEN_PH_HEAD	0xFE, 0xED, 0x1D
 
 /* Apply report descriptor parameters to a report descriptor template */
 extern __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
@@ -89,19 +89,19 @@ extern __u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
 					  const s32 *param_list,
 					  size_t param_num);
 
-/* Pen report descriptor template placeholder IDs */
-enum uclogic_rdesc_pen_ph_id {
+/* Report descriptor template placeholder IDs */
+enum uclogic_rdesc_ph_id {
 	UCLOGIC_RDESC_PEN_PH_ID_X_LM,
 	UCLOGIC_RDESC_PEN_PH_ID_X_PM,
 	UCLOGIC_RDESC_PEN_PH_ID_Y_LM,
 	UCLOGIC_RDESC_PEN_PH_ID_Y_PM,
 	UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM,
-	UCLOGIC_RDESC_PEN_PH_ID_NUM
+	UCLOGIC_RDESC_PH_ID_NUM
 };
 
 /* Report descriptor pen template placeholder */
 #define UCLOGIC_RDESC_PEN_PH(_ID) \
-	UCLOGIC_RDESC_PH_HEAD, UCLOGIC_RDESC_PEN_PH_ID_##_ID
+	UCLOGIC_RDESC_PEN_PH_HEAD, UCLOGIC_RDESC_PEN_PH_ID_##_ID
 
 /* Report ID for v1 pen reports */
 #define UCLOGIC_RDESC_V1_PEN_ID	0x07
-- 
2.25.1

