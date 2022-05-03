Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306C518F3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiECUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbiECUpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:45:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DA2B19C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:42:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so3339894pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWTG6qR6PAsl5ztcLukE6FJQRLR4F9ygwETJyaOlpe4=;
        b=Xkyhnyn2iM1JvpehHToV52oJSUr9tjvV7dxzdT878Wp72btp/tN7Yra4Gg50LjAY11
         9/HCmMeyESxUqEsoWar713A+KF+AqbEoZksU5yRmzjhfiKeZHP9F7qFYRzBxBGObK9i1
         MnE4y/EVQa+HvqVQqvBIdLsbnyeQ5HXD1g8Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWTG6qR6PAsl5ztcLukE6FJQRLR4F9ygwETJyaOlpe4=;
        b=q67mpffMT/BZWMe7iJu9dDuutEHyD2kCN589WNyDFnvLKJ5oZfO8Uh3plNi8AUxHZh
         Huu5W5j+tOCkTZznJv0hwpMaOc5rBLrLRw6lsrSAi0/Of5mV+h4hCwYw3wDU6C75GhGQ
         oIkvjrL/xR5M0a6tqFW7LulAmaN8FDpAzXkqUIXtQ4b3EcMBLL3gaNutIasNxQeyH+/Y
         YZ/yBD9yHLdkm2sJEvZF261cIVvYt9oCi7Tf4jUM3K1odSy3DM+f0tOxhpZ7Btc2INqy
         fb0/0qVkIUsQ9e6woAm56983W3Ev2r5YC+YnRi0l7mT9lndrchy0d6arpWsgW2CvbkZE
         Dgxg==
X-Gm-Message-State: AOAM531RksDT3R7TEudW6ILbeMt8JVWnadJaxcQaFTw2+H9lkLepd7fV
        Rd2qfepMnkvxM7VwypUmYIe2vg==
X-Google-Smtp-Source: ABdhPJzYYojbmtuI9J7qVitArEwpEuYIjEFGujZTHvq7ZDXGmDZ1G9wykRXBgwgk4zGtkUrd9tZjvA==
X-Received: by 2002:a17:902:bb90:b0:156:2c05:b34f with SMTP id m16-20020a170902bb9000b001562c05b34fmr18881814pls.53.1651610538012;
        Tue, 03 May 2022 13:42:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:15e:c760:9a04:7fbe])
        by smtp.gmail.com with ESMTPSA id x18-20020aa79192000000b0050dc76281e4sm6702081pfa.190.2022.05.03.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:42:17 -0700 (PDT)
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
Subject: [PATCH v4 2/2] Input: cros-ec-keyb - skip keyboard registration w/o cros-ec-keyb compatible
Date:   Tue,  3 May 2022 13:42:12 -0700
Message-Id: <20220503204212.3907925-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220503204212.3907925-1-swboyd@chromium.org>
References: <20220503204212.3907925-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/input/keyboard/cros_ec_keyb.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index eef909e52e23..7684caf9b209 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -536,14 +536,10 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
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
@@ -718,8 +714,13 @@ static int cros_ec_keyb_remove(struct platform_device *pdev)
 
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

