Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920B3528D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbiEPSfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiEPSe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:34:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D542532EFB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:34:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ev18so4630163pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+y3ghcGTNoWHMuz4m4RXJ7SgZxKsd4M4FdcYQjzA2w=;
        b=cxqvyxqR0vj/bC96KVA7ctZ0rsu4BnDz2HIF7A+msr0g3QETbAY8RBEt6+NmkbvCLy
         I3EdnrcacKqv1OChq/MXrd5hWhvvjQCvo8XPjWe6ssVQ6QA4elagVf9pTiAxQxHG7dUD
         8nZgN9OGTySge3vXLW2ce4lQQWGTL54dsFoz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+y3ghcGTNoWHMuz4m4RXJ7SgZxKsd4M4FdcYQjzA2w=;
        b=uqKuSu2aAMgDwLm8OksHeTOJSrcpAr3D8mpkkg9fdK7unA7UVfrLrHrC8L4d7HVjXL
         /tFjSmZXNGqx3Bf1t4cfuqDMsY9pfGYSM/i0H6cR/gK0bJLq3EmaCoAoRV9gpTZ33xdu
         y7kReIit/V1yG8Iklqx/JxuN4Ae7Gys9jbgeSuuocLsGvponnXmyJo9Bmaasktc3Mg5q
         iOLC1knPhGD8Ey1f5jnLC/HjyvISNyjiNbp+iz3K6TFH7fNK7jJiQOBHk5eKdMvOVvVP
         KREjS7KED1dJiUT3qfBwueraJWY/hXSE4Vhq0OXl6gph09igMa45GQHSa/UKrXXxsLx5
         8Yig==
X-Gm-Message-State: AOAM5320a9ju6Bhc2WlW2oW/6wVki5Zt/FPCUplTnxULdw4C6YdAQhoR
        PTUcHkuUqj8DGsk+QSLSsCIsfg==
X-Google-Smtp-Source: ABdhPJx0C4tIVn/hfIjxZ5wNuIjfUUrnAcrjq0nD/REk4Z4lhVGVQF0SHx8yweOLPBONMShvr56Kig==
X-Received: by 2002:a17:90b:4f41:b0:1de:bd14:7721 with SMTP id pj1-20020a17090b4f4100b001debd147721mr21000140pjb.9.1652726096358;
        Mon, 16 May 2022 11:34:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7d0d:b8ac:a3e3:757a])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709026f1000b0015e8d4eb24fsm7331090plk.153.2022.05.16.11.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:34:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH v5 2/2] Input: cros-ec-keyb - skip keyboard registration w/o cros-ec-keyb compatible
Date:   Mon, 16 May 2022 11:34:52 -0700
Message-Id: <20220516183452.942008-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220516183452.942008-1-swboyd@chromium.org>
References: <20220516183452.942008-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if
rows/columns exist") we skipped registration of the keyboard if the
row/columns property didn't exist, but that has a slight problem for
existing DTBs. The DTBs have the rows/columns properties, so removing
the properties to indicate only switches exist makes this keyboard
driver fail to probe, resulting in broken power and volume buttons. Ease
the migration of existing DTBs by skipping keyboard registration if the
google,cros-ec-keyb-switches compatible exists.

The end result is that new DTBs can either choose to remove the matrix
keymap properties or leave them in place and add this new compatible
indicating the matrix keyboard properties should be ignored. Existing
DTBs will continue to work, but they will keep registering the keyboard
that does nothing. To fix that problem we can add this extra compatible
to existing devicetrees and the keyboard will stop being registered.
Finally, if google,cros-ec-keyb is missing then this driver won't even
attempt to register the matrix keyboard. Of course, this driver won't
probe until this patch is applied in that scenario, but that's OK. This
last case is likely only going to be used by new devicetrees created
after this commit.

Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Fixes: 4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if rows/columns exist")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index eef909e52e23..bdbb263e8586 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -464,8 +464,13 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
 		return ret;
 	switches = get_unaligned_le32(&event_data.switches);
 
-	if (!buttons && !switches)
+	if (!buttons && !switches) {
+		/* Fail probe if we expected buttons/switches */
+		if (of_device_is_compatible(dev->of_node, "google,cros-ec-keyb-switches"))
+			return -ENODEV;
+
 		return 0;
+	}
 
 	/*
 	 * We call the non-matrix buttons/switches 'input1', if present.
@@ -536,14 +541,10 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	u32 *physmap;
 	u32 key_pos;
 	unsigned int row, col, scancode, n_physmap;
+	bool has_keyboard;
 
-	/*
-	 * No rows and columns? There isn't a matrix but maybe there are
-	 * switches to register in cros_ec_keyb_register_bs() because
-	 * this is a detachable device.
-	 */
-	if (!device_property_present(dev, "keypad,num-rows") &&
-	    !device_property_present(dev, "keypad,num-cols"))
+	has_keyboard = device_get_match_data(dev);
+	if (!has_keyboard)
 		return 0;
 
 	err = matrix_keypad_parse_properties(dev, &ckdev->rows, &ckdev->cols);
@@ -718,8 +719,13 @@ static int cros_ec_keyb_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id cros_ec_keyb_of_match[] = {
-	{ .compatible = "google,cros-ec-keyb" },
-	{},
+	{
+		/* Must be first */
+		.compatible = "google,cros-ec-keyb",
+		.data = (void *)true
+	},
+	{ .compatible = "google,cros-ec-keyb-switches" },
+	{}
 };
 MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
 #endif
-- 
https://chromeos.dev

