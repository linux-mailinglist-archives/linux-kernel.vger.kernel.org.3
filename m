Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A976452B426
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiERH7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiERH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:59:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625571207E6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:59:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h5so325382wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dds68n4eVAqNb9Nh1GkmgUmrWiZNicCAFfz37bcPi/E=;
        b=q0S94H1GhZQls0QplGXXaQ20xyUhPJfSw9jx5Z1yMH4JNQDn2qssApG6YIhSC1Ahcl
         H//p6eK6yYHKF1mQCiWr5xMditxAExDaHTPHhjYdKpAP6mj+fBp5/4sczfa2Cw9/A5Se
         O3z+eoS/q5Y1ymj92c+ivFjdF4mUYtghiB3iVIGWIAV/Mlw7DCc6JVlJek/HwFN+fvMk
         8owS92GwrYaNr+e/mJFp+fywqy2sZDTd6P66ONYa5JRYMkgRk0shA6mWCBnD+//UnpIx
         P5I2FZkLKWZdCnkzEedKx1IqaiO9os3cDWOE1+7Hxq0n/LFz4ogFuZNx5v0Oj4UJVD0J
         1LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dds68n4eVAqNb9Nh1GkmgUmrWiZNicCAFfz37bcPi/E=;
        b=tVS460cpgR62HrJp5S6XuweFjPHPB9qwO5WzU55sXepsgXYm+QhzSrl1SpjA2kXUWO
         i5u0qNX4ccSPdKQsqkhjAoSbH7AVg6FJw9kiLRjxVgvu0MV5Yz7l6Lr0PrdLx4eh2v6N
         GvnJnZUfTCJcv/eymJiNfWmoWWvtW/CBSJtVgJDD92ErFA5BUTVM/z+n+rmR98yBJwQg
         fx1zWy4jvFk4M6ixRtIMoGsmdedrZCmSS8WRe1jCUj/NCuHJv5owW6+Yh5IUpPSd/jqM
         +FcKHPzLT0Rqwvq7sQP8mLRe1QNyg5MiiIqqlEnfasSSejsUxXQCGa3HyXujIU2nVrk7
         LLdQ==
X-Gm-Message-State: AOAM531F0kVagxAHvlQ5nCauFo16IpUagdwhOMY2GZ2SbNE5rfv7Avr5
        KCKAVr1RARv9S42TMTOFytj/EQ==
X-Google-Smtp-Source: ABdhPJwXGZwgKt2xBN/YHUpTFYOWitejVIgIv8v5y8RaS6IUg2o89e7OYU3thoshzpsYoCAbw7r/OQ==
X-Received: by 2002:a05:6000:15c1:b0:20c:5825:f043 with SMTP id y1-20020a05600015c100b0020c5825f043mr21710401wry.261.1652860753963;
        Wed, 18 May 2022 00:59:13 -0700 (PDT)
Received: from groot.home ([2a01:cb19:85e6:1900:bda6:8356:4db1:4539])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b0039706782e06sm1041300wmb.33.2022.05.18.00.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 00:59:13 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 1/2] Input: mt6779-keypad - fix hardware code mapping
Date:   Wed, 18 May 2022 09:59:08 +0200
Message-Id: <20220518075909.180629-2-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518075909.180629-1-mkorpershoek@baylibre.com>
References: <20220518075909.180629-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mt6779_keypad_irq_handler(), we
1. Read a hardware code from KPD_MEM1 -> KPD_MEM5
2. Use that hardware code to compute columns/rows for the standard
   keyboard matrix.

According to the (non-public) datasheet, the
map between the hardware code and the cols/rows is:

        |(0)  |(1)  |(2)
    ----*-----*-----*-----
        |     |     |
        |(9)  |(10) |(11)
    ----*-----*-----*-----
        |     |     |
        |(18) |(19) |(20)
    ----*-----*-----*-----
        |     |     |

This brings us to another formula:
-> row = code / 9;
-> col = code % 3;

Implement this mapping in bitnr_to_col_row() to fetch the
correct input event from keypad->input_dev->keycode and report that
back to userspace.

Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
Co-developed-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mt6779-keypad.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index 2e7c9187c10f..23360de20da5 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -36,6 +36,19 @@ static const struct regmap_config mt6779_keypad_regmap_cfg = {
 	.max_register = 36,
 };
 
+/*
+ * | hardware key code | col0 | col1 | col2|
+ * | ----------------- | -----| ---- | --- |
+ * | row0              | 0    | 1    | 2   |
+ * | row1              | 9    | 10   | 11  |
+ * | row2              | 18   | 19   | 20  |
+ */
+static void bitnr_to_col_row(int bit_nr, int *col, int *row)
+{
+	*row = bit_nr / 9;
+	*col = bit_nr % 3;
+}
+
 static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct mt6779_keypad *keypad = dev_id;
@@ -61,8 +74,7 @@ static irqreturn_t mt6779_keypad_irq_handler(int irq, void *dev_id)
 		if (bit_nr % 32 >= 16)
 			continue;
 
-		row = bit_nr / 32;
-		col = bit_nr % 32;
+		bitnr_to_col_row(bit_nr, &col, &row);
 		scancode = MATRIX_SCAN_CODE(row, col, row_shift);
 		/* 1: not pressed, 0: pressed */
 		pressed = !test_bit(bit_nr, new_state);
-- 
2.34.1

