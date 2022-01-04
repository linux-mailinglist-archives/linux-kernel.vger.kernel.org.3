Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF3484638
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiADQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiADQun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:50:43 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ACEC061761;
        Tue,  4 Jan 2022 08:50:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o3so19202271wrh.10;
        Tue, 04 Jan 2022 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w77GvWlSgMascBH89NQnwzeoXq/tPaE14mbfz3NGY9g=;
        b=QGEbwJ+uXb88Rww2LqpLua4OMQCiFMB2So68nV1LjVzvwL2fAv6euwjOgYFcOpYD3X
         HIhii2iLPpMQkMlDvA8MP9BWpVr+NzCn3qvAsmh6MWzpfRY8+l2Yv8yLTsetbM4WKRtG
         b6Upgy5k1ce8ou5S/AN/dTY+IUKW/tJ9fmpiJXQNusIvga5uRGHj3/V8aQ7NhxZ85QJi
         z1pwb9eVkE/R1/HJl2iAMyVNYGpXEbFGb9qD3mXl/DxoXuXtKuSXBbHVWv3Q5+xEddiK
         gG86sBedG7vmXH8vAlY8ZXH18y0G0SBeYlff/WdDygiebl8M0xQXoWYdJ2rriFIkuXD7
         T/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w77GvWlSgMascBH89NQnwzeoXq/tPaE14mbfz3NGY9g=;
        b=OPbNKa7AVr0gf127+oi1ZdIaMcX8er1S97wcmOapwd1riyg811P+Q5lAmRyI0H/2uC
         42MEtlTp2yLR1DL7E/6+79DlyV9wXCh3Z4aWt9WyhAiEb1P8QxkatDwSDydtUhLy7Yi7
         rLjTHImuog6TmP6j7DYAF+LwkjEyevSX1qxxmfeo/sHlvBlh7cgjTuLPqhQ5CdltbGhA
         FCZ1pB68q2XIQKTHcJEb21AIpFikwThVJ9/9hVJEVfSYCP+B73Ras3YnWszBI5PNwLC9
         G8n+WVP+hgbSOMQ1oYrrLPwrlVYdktNAgd8QBVxV1WgueWwgZiaUFpG54zZUdtxmxqVk
         xEeQ==
X-Gm-Message-State: AOAM530woPmnXfYbbH6gIk9ew/+aI6Q4psw5VW4YVDq6QOLhDaTM0O0R
        CZGRLuuCIhg8IxwaKvrlLTDclAidmIXqUw==
X-Google-Smtp-Source: ABdhPJxGHnWqBULMR3by+lYFpYK/RnUpFZGM2j9IkBYwVUEmwCSWQ2jnfD1Q5iwEfXIv2R3CNjNM1w==
X-Received: by 2002:adf:c391:: with SMTP id p17mr20520736wrf.257.1641315041362;
        Tue, 04 Jan 2022 08:50:41 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id j85sm417696wmj.3.2022.01.04.08.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:50:41 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexhenrie24@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/3] HID: apple: Refactor key translation setup
Date:   Tue,  4 Jan 2022 17:50:31 +0100
Message-Id: <20220104165033.29421-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104165033.29421-1-jose.exposito89@gmail.com>
References: <20220104165033.29421-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code used to map the apple_key_translation structs is duplicated.
Extract it to a common function.

Refactor, no functional changes.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-apple.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 2c9c5faa74a9..aa3d643e3615 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -174,6 +174,15 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
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
@@ -359,27 +368,16 @@ static __u8 *apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
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
+	apple_setup_key_translation(input, apple_fn_keys);
+	apple_setup_key_translation(input, powerbook_fn_keys);
+	apple_setup_key_translation(input, powerbook_numlock_keys);
+	apple_setup_key_translation(input, apple_iso_keyboard);
 
-	for (trans = apple_iso_keyboard; trans->from; trans++)
-		set_bit(trans->to, input->keybit);
-
-	if (swap_fn_leftctrl) {
-		for (trans = swapped_fn_leftctrl_keys; trans->from; trans++)
-			set_bit(trans->to, input->keybit);
-	}
+	if (swap_fn_leftctrl)
+		apple_setup_key_translation(input, swapped_fn_leftctrl_keys);
 }
 
 static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
-- 
2.25.1

