Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5F515911
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381892AbiD2XfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381857AbiD2Xew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:34:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE96DB498
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:31:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a11so8117053pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWF9sCGDLZUK2sgoEIyeIZNot5TI6mJu4iu2/5YFEbs=;
        b=I4ZrQ02qj5Y2kq+RsM7F/x4rltUPs85PI2jsCeDO07YWMOe6ICw4kN17iLW+muuqND
         2bWJtIApxcoKrH7Rg0IB1waVaa3UXApFafxIED0m+uPDHTF/qJAhg5tYHoAsW/JXVomS
         IxQh1fKEWGgxxaxu1B9nw7vg8ahhN4fv107mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWF9sCGDLZUK2sgoEIyeIZNot5TI6mJu4iu2/5YFEbs=;
        b=U03E6CTIDk5R02hOR+rlXLaAW3jPgVcqBZ7mSrsPcDIkfb5F9AgHT1xU9NhjVQGiFP
         hmi8SnBOabnVBiBlokBpXM8Zf6u81BCwhrElttF3zoOkhNW+wfOnwzESb0U7lBWEJ7t7
         OHVfkvHAmAos3n4GvmArATpfq3f3S7o0enH7wLyk2sykhsChr3nBha51N35uc3MphMs4
         AJFk+WDer4cnlW+9SSOjrzH2NmzH6i9PZYaib1qwKGSmJFoIxNGzSe6AxWrJdPygmzdU
         p1EPfwDSw4cQLKSrTM4x2Ypf85RxR1Aw03dfFaBiTnUDtB/4lpzzOL4TyJ77k3Y6pjsZ
         9uUw==
X-Gm-Message-State: AOAM532q3RjHhU38mCf3PlfbmWC1hGeQ2qB1CbKV6GeZk/0X7amNct9E
        GQlVH94MZqWBFrjNZ6TC+Vlb0g==
X-Google-Smtp-Source: ABdhPJxVK4eELgvKjci8XyIkVF5wrZqTYg/voZE1BMP5wikFWF4v/Rp0TQ1AOSdMffDPdkjReT+NiA==
X-Received: by 2002:a05:6a00:24ce:b0:50d:c14b:b655 with SMTP id d14-20020a056a0024ce00b0050dc14bb655mr1240258pfv.57.1651275076720;
        Fri, 29 Apr 2022 16:31:16 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5172:14b3:3687:1fb0])
        by smtp.gmail.com with ESMTPSA id i24-20020aa78b58000000b0050dc762818esm223037pfd.104.2022.04.29.16.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 16:31:16 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH v2 2/2] Input: cros-ec-keyb - skip keyboard registration for switches compatible
Date:   Fri, 29 Apr 2022 16:31:12 -0700
Message-Id: <20220429233112.2851665-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220429233112.2851665-1-swboyd@chromium.org>
References: <20220429233112.2851665-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
to existing DTBs and the keyboard will stop being registered. Finally,
if google,cros-ec-keyb is missing then this driver won't even attempt to
register the matrix keyboard.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Fixes: 4352e23a7ff2 ("Input: cros-ec-keyb - only register keyboard if rows/columns exist")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index eef909e52e23..1bbe2987bf52 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -536,6 +536,12 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 	u32 *physmap;
 	u32 key_pos;
 	unsigned int row, col, scancode, n_physmap;
+	bool register_keyboard;
+
+	/* Skip matrix registration if no keyboard */
+	register_keyboard = device_get_match_data(dev);
+	if (!register_keyboard)
+		return 0;
 
 	/*
 	 * No rows and columns? There isn't a matrix but maybe there are
@@ -718,8 +724,13 @@ static int cros_ec_keyb_remove(struct platform_device *pdev)
 
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

