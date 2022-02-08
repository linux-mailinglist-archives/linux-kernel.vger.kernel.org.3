Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6E4AE0F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385014AbiBHShR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiBHShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:37:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A58DC061579;
        Tue,  8 Feb 2022 10:37:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so1842061wml.0;
        Tue, 08 Feb 2022 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6agt1vf+amWniZh1gXtipOgD6wm2asGKzDyPpayMiA=;
        b=NBylJD5zJum1mLlZYAzx6SJmi4SSpVGKCqjwxTAFk7WDeDCBcL1Hgx64HM1ZOML97/
         RKc3SzD4PeY+ECJio5x8kBm2Wc8q8OD1IWZJpf6BtQ+LUhTMWwQZ09BTQ7fvlqMIlO6I
         uAa6hlJZs0U97IsK3qS1Ij8oHl/GVeR3GaDHmaJ/1BHucBXRSNDuUdPjnrtWOap/lLze
         7hxdVUg6+tciWvce/qRAGDFlD9Vfc4V3Ii3tM0lBQieHeKsFHSTQxa1igurvr6JVq/pQ
         ikecBzORPLtdHMzOs8gITy7RGrevY1iAXVPvuFWsOByvjgK5h5Dcy6Vr3lzsmw5S+msO
         VZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6agt1vf+amWniZh1gXtipOgD6wm2asGKzDyPpayMiA=;
        b=gei1CEthWMXipQyX4sRHe2hkUfGGLfEjFvhiKrRAhKiNosH+muWeac+uc55lTNiU3j
         fRE56HbQgdkJZf6vJZXvQa2+Z0R2SOyWfr7BeHYpJOaYcyFxbzhLVr3BFunLZ1/kVrH0
         jLQdsAmnypW41Lb9mxDOtvNwlJd1VknS98MQsExZAXlNExCJ+SZoYpDFc9Ul3gb3e0Uu
         Bkj+C3Khc/H7UdKIaR5bJFi0HOeXLrm4bfeKKG3YNbwAhG0nWwcWTL3sGi3uZcx5QfWk
         yMdh6cE0pHNyH/3ABYg0SiG3Y/X6WK+EVxyaKaSB1Z6eBf30uGymfAsNEjfvNcTqLfGT
         534Q==
X-Gm-Message-State: AOAM530pmxvbhsAOQoilXLzFSnihawYr6K40vTV3ILk+zKwqr651trCk
        w6N9ma0CR/R/hMetJkAUzpQ=
X-Google-Smtp-Source: ABdhPJybn0/Ym2G1A7pSnJMFr8KahuGFhK4pAGF44v8GL+B14EQGR3OiaFKZ7JtAcfu7de0QobdrAg==
X-Received: by 2002:a05:600c:1f0a:: with SMTP id bd10mr2135080wmb.6.1644345431854;
        Tue, 08 Feb 2022 10:37:11 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id l20sm2945308wmq.22.2022.02.08.10.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:37:11 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/3] HID: apple: Refactor key translation setup
Date:   Tue,  8 Feb 2022 19:37:02 +0100
Message-Id: <20220208183704.40101-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208183704.40101-1-jose.exposito89@gmail.com>
References: <20220208183704.40101-1-jose.exposito89@gmail.com>
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

The code used to map the apple_key_translation structs is duplicated.
Extract it to a common function.

Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-apple.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 24802a4a636e..6ca393c0a390 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -202,6 +202,15 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 	{ }
 };
 
+static inline void apple_setup_key_translation(struct input_dev *input,
+		const struct apple_key_translation *table)
+{
+	const struct apple_key_translation *trans;
+
+	for (trans = table; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+}
+
 static const struct apple_key_translation *apple_find_translation(
 		const struct apple_key_translation *table, u16 from)
 {
@@ -452,30 +461,17 @@ static __u8 *apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 static void apple_setup_input(struct input_dev *input)
 {
-	const struct apple_key_translation *trans;
-
 	set_bit(KEY_NUMLOCK, input->keybit);
 
 	/* Enable all needed keys */
-	for (trans = apple_fn_keys; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	for (trans = powerbook_fn_keys; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	for (trans = powerbook_numlock_keys; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	for (trans = apple_iso_keyboard; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	for (trans = apple2021_fn_keys; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	if (swap_fn_leftctrl) {
-		for (trans = swapped_fn_leftctrl_keys; trans->from; trans++)
-			set_bit(trans->to, input->keybit);
-	}
+	apple_setup_key_translation(input, apple_fn_keys);
+	apple_setup_key_translation(input, powerbook_fn_keys);
+	apple_setup_key_translation(input, powerbook_numlock_keys);
+	apple_setup_key_translation(input, apple_iso_keyboard);
+	apple_setup_key_translation(input, apple2021_fn_keys);
+
+	if (swap_fn_leftctrl)
+		apple_setup_key_translation(input, swapped_fn_leftctrl_keys);
 }
 
 static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-- 
2.25.1

