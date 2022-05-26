Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6333B535654
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbiEZXMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiEZXMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:12:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A00E5292;
        Thu, 26 May 2022 16:12:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y189so2901872pfy.10;
        Thu, 26 May 2022 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NutntfjOLhm5vnkAI6J63aqPd+5lyjNYED2lB5Nzypc=;
        b=f9IpqER2Xa1o1NkAvhApl7mtUQdmcGuXMsiRmnB3lgDD79qA+7YHne14gqqXEQXZ/I
         y87scVcuqxVTTrdHaaBMwzKqKvRmsfN0Wag78E6gMOdpVU8TGDrtk0Iw+6YQes3zj8BF
         7jW5wOk6oevitELnTQrTfLKxniws8dOaYzy7h8w+fqpSGZ84sPNC1X/IEHs3QofMz8v8
         X33xA/SzSAKfeNvszIh1trFo3ILs0oXv7jWJv2PItAH/dxtxQ/Ze//ACjjjR6iXcPWU2
         rB1e7FfvBRkIjm2mNmNCaW4W9LVA5J9RHt64zUD3k9lk+RlvxIP4rTMUA+DhGSSL4ojv
         GVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NutntfjOLhm5vnkAI6J63aqPd+5lyjNYED2lB5Nzypc=;
        b=Mya6Wn87TnM8h7FMf8NldhevryyimHSOgW6ePiU0EGVkdVJ3sUpdzGlgt0ZqItPyUH
         fxTGmK3XfSsiA7nVhfUyLLmiHW8hDLYYjy3LL6Ck3xaSaSCaTwtVHn0Q2+hht/z0pzfy
         avZm/VYBE7w35dFkJj0+9ybWiTfC7dFv83A0nWNBrH2lCjYmhS7n9Aya14/Yj/GjWVeu
         wDUOmf7bIiw4nRw4nT3jQLXUYTZPysvifSe3gtPR8wzBxNCHRHBqhOjtjJMkbdhHte7P
         4BNp/1TTP81oXOgLPt2nkxogYtURra77hU+0VFs+UMA25ZPAWVvL5g1tYvoJO1Xx/244
         b6lA==
X-Gm-Message-State: AOAM530oNTj8TxXhT2FER9kgAQNqqlC7Z2otPWz6moNhI51tthYEJkMU
        DT1tbFxJZ92n3B9OKNMyynNqIPc0DqY=
X-Google-Smtp-Source: ABdhPJxkJjdZDo2Z6T+lu370swWNjkIxOT6aw9y8cApR96rtR1FFNioZcM/cwJuHaMwEcBA1iTNK8w==
X-Received: by 2002:a62:1c50:0:b0:518:89bf:8b41 with SMTP id c77-20020a621c50000000b0051889bf8b41mr27372849pfc.60.1653606753742;
        Thu, 26 May 2022 16:12:33 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3206:ea0b:ce53:ea86])
        by smtp.gmail.com with ESMTPSA id y129-20020a626487000000b0050dc76281b5sm2068978pfb.143.2022.05.26.16.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 16:12:32 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: cros_ec_keyb - switch to using generic device properties
Date:   Thu, 26 May 2022 16:12:29 -0700
Message-Id: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling this driver on x86 devices let's switch
from OF-specific property API to the generic one.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 68 ++++++++++++++++++---------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index cc73a149da28..e8338b1c5776 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -518,6 +518,50 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev,
 	return 0;
 }
 
+static void cros_ec_keyb_parse_vivaldi_physmap(struct cros_ec_keyb *ckdev)
+{
+	u32 *physmap = ckdev->vdata.function_row_physmap;
+	unsigned int row, col, scancode;
+	int n_physmap;
+	int error;
+	int i;
+
+	n_physmap = device_property_count_u32(ckdev->dev,
+					      "function-row-physmap");
+	if (n_physmap <= 0)
+		return;
+
+	if (n_physmap >= VIVALDI_MAX_FUNCTION_ROW_KEYS) {
+		dev_warn(ckdev->dev,
+			 "only up to %d top row keys is supported (%d specified)\n",
+			 VIVALDI_MAX_FUNCTION_ROW_KEYS, n_physmap);
+		n_physmap = VIVALDI_MAX_FUNCTION_ROW_KEYS;
+	}
+
+	error = device_property_read_u32_array(ckdev->dev,
+					       "function-row-physmap",
+					       physmap, n_physmap);
+	if (error) {
+		dev_warn(ckdev->dev,
+			 "failed to parse function-row-physmap property: %d\n",
+			 error);
+		return;
+	}
+
+	/*
+	 * Convert (in place) from row/column encoding to matrix "scancode"
+	 * used by the driver.
+	 */
+	for (i = 0; i < n_physmap; i++) {
+		row = KEY_ROW(physmap[i]);
+		col = KEY_COL(physmap[i]);
+		scancode = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
+		physmap[i] = scancode;
+	}
+
+	ckdev->vdata.num_function_row_keys = n_physmap;
+}
+
 /**
  * cros_ec_keyb_register_matrix - Register matrix keys
  *
@@ -534,11 +578,6 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	struct input_dev *idev;
 	const char *phys;
 	int err;
-	struct property *prop;
-	const __be32 *p;
-	u32 *physmap;
-	u32 key_pos;
-	unsigned int row, col, scancode, n_physmap;
 
 	err = matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev->cols);
 	if (err)
@@ -573,7 +612,7 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	idev->id.product = 0;
 	idev->dev.parent = dev;
 
-	ckdev->ghost_filter = of_property_read_bool(dev->of_node,
+	ckdev->ghost_filter = device_property_read_bool(dev,
 					"google,needs-ghost-filter");
 
 	err = matrix_keypad_build_keymap(NULL, NULL, ckdev->rows, ckdev->cols,
@@ -589,22 +628,7 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	input_set_drvdata(idev, ckdev);
 	ckdev->idev = idev;
 	cros_ec_keyb_compute_valid_keys(ckdev);
-
-	physmap = ckdev->vdata.function_row_physmap;
-	n_physmap = 0;
-	of_property_for_each_u32(dev->of_node, "function-row-physmap",
-				 prop, p, key_pos) {
-		if (n_physmap == VIVALDI_MAX_FUNCTION_ROW_KEYS) {
-			dev_warn(dev, "Only support up to %d top row keys\n",
-				 VIVALDI_MAX_FUNCTION_ROW_KEYS);
-			break;
-		}
-		row = KEY_ROW(key_pos);
-		col = KEY_COL(key_pos);
-		scancode = MATRIX_SCAN_CODE(row, col, ckdev->row_shift);
-		physmap[n_physmap++] = scancode;
-	}
-	ckdev->vdata.num_function_row_keys = n_physmap;
+	cros_ec_keyb_parse_vivaldi_physmap(ckdev);
 
 	err = input_register_device(ckdev->idev);
 	if (err) {
-- 
2.36.1.124.g0e6072fb45-goog

