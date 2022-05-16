Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4BE528CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiEPSOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiEPSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:13:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7283D4B2;
        Mon, 16 May 2022 11:13:51 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so6363359wrb.1;
        Mon, 16 May 2022 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACyQSwhwLJAQYdvhCmWlZhJ2luYcAzPfMPYG/ALzDjA=;
        b=Agb3BdhC//toEmbJ8FSE0/btu1yFUYKLFvZBB//WtfpdyFYDD28lFVSQZ89LieJk72
         70QXovYl24ajjGtb1omjMwFXZDUItcAcXw0xDx4p/oI/qClwwRvr5h9KkvoO9wMzEV8i
         a47OXrEuVa14ptFaiA1yW2TRrZ7xcKx/WjxNiuzqUg1+eZXZmkGrzaa9mMRieZvDXHxe
         /R+VM3nfpPq8iuK7Ev4JPuf8I+FQ9QuEG2K+DMh5bcwamppJUW5fhzM/GfmbluJrZhbM
         elOrkMrIdPmwF84Zq3r2DqstxQmVpw2HYc/RwQjM6vRvpxYZ3vKhXG7O8h37ReSg7FTp
         YEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACyQSwhwLJAQYdvhCmWlZhJ2luYcAzPfMPYG/ALzDjA=;
        b=EOvp3iYRcEF1h3anlQPZ7oh/aPhpYWOcsxPnp01DI46jlkqWJ4ELFGHPkfCKC6MO4r
         hczMimerm6hbptmskduV8usSBsof4LelcZOKDGyv7uRLZS4gdTsW05T2vZN1e1qjWTan
         jJkgkb1U0AzIeXqHgUDBeTxgK9d/r3yS9uow7KCOfVMcQPYlRWRGULuzDndXj0Wu/Au1
         gjR13L80kgdXTnFv8ZMxa8fcXhMvz5FZjW6XfSZf3HV3gU+2IWB3zojIu/vgsWrDF59J
         P3Ikkoz96iiAB14Sc5kIvA+9pGBXEhiQbEawA51i4hr+uBPGFoWdSPN3U5RdWfgdNWgy
         o80g==
X-Gm-Message-State: AOAM533BkxXA1PgFoxgw6LCPiBoQDxr11PvpWwfQjs4Ka6zYlZb84I4I
        EKs6iXronPiz2fcPLy1PnS97JWt00poxmg==
X-Google-Smtp-Source: ABdhPJwQ7PfdaugZtV5BfyvqV9FI3pJdH5RoDnl14wHMZxk6yxn/c5oX7z7Z+3eB+UOGPl7l99cpNQ==
X-Received: by 2002:a5d:460a:0:b0:20d:1029:5cff with SMTP id t10-20020a5d460a000000b0020d10295cffmr2567194wrq.335.1652724830128;
        Mon, 16 May 2022 11:13:50 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600002cf00b0020d0c9c95d3sm3276382wry.77.2022.05.16.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:13:49 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 3/4] HID: uclogic: Allow to generate frame templates
Date:   Mon, 16 May 2022 20:13:22 +0200
Message-Id: <20220516181323.59554-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516181323.59554-1-jose.exposito89@gmail.com>
References: <20220516181323.59554-1-jose.exposito89@gmail.com>
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
index 71917de02b03..1e22d1c86616 100644
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
index 7126fba80968..cf04e71b7bb5 100644
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
+			put_unaligned_le16(cpu_to_le16(v), p + 1);
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

