Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1876535655
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349479AbiEZXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349391AbiEZXMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:12:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8491FE529A;
        Thu, 26 May 2022 16:12:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c22so2560173pgu.2;
        Thu, 26 May 2022 16:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hESI7H4x1E9GmthOOatZOfLK2selcIJejOGX79+sAw=;
        b=V7bT9FFa1/aoyVCvlDzCiTnIi+qNUf55IayAHztYaU3eb2zh0NSSpLE6Hkciz9+y6D
         sZObhYAQoaqawPk/7SGRRbWB2eEaoMk+AsJJW0HDZmBV+eWRCW+vLIiWWwAHUDRaORZv
         n2R1WqfYc6Vw/5eZjztNHOE68ySbeqNugdqdQkoFmLo8i2sylgPvQiV/V+99TTZmiPqq
         P9zUnmcHzJNByYNjONJ/mGO9JxfzJsRFvbhTmylkzSgDSVqOyfrwb+Ww5p2V9teKWjsi
         +fOsE3ezY23PqqytAqKe2jW/YilNzfcYhHBV0Ap1JffV2p9rDg/YJwBg/+M7wmyEFem5
         Imiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hESI7H4x1E9GmthOOatZOfLK2selcIJejOGX79+sAw=;
        b=j3e0a+IqvDUA4DmzFeQKVgx0T192m7E3wtcjYD4JUdlrdclqhihTA0Lt0n2sHIC9bB
         d+2z/HQCKjeTr3yE2jzL27453WQY9kjoRQtuU8kCyU4WFQuz5H3xxsouWV+zddWVWJlD
         OTlajKg2a0ojmOR53rB57Ai47v9jSyq5oTFY1PK+iXwQ66yT0baQURdUtfhvkXPcgO06
         yjTjumBoBetlAlqBjVsADH7mE2DUe0H7P4SHJVbke38vVJaC/N1un0TzV4JQwjzlY2Vg
         pxYnTosQiSXhiDdZHzLjcklrxxzX6Gbxdpba+fzntPvE//xNvwy5bIJFigKgvHO4qkXp
         7RWQ==
X-Gm-Message-State: AOAM5326Zxg6izjwdeVbbmGLKv0RZD7FIw+2OGNfHqcCgFdqSFNECrWt
        bmGty0SiwevVzCJa2DJiPxvSIfFVYTQ=
X-Google-Smtp-Source: ABdhPJyWjmMeUGVUJKyEZ5wOno6L8FQOb0Yw1LrsplM3tTdY8EF9UGMOMM4IWVFT2zlBVBVfg5mCKg==
X-Received: by 2002:a65:5c48:0:b0:382:2c7:28e9 with SMTP id v8-20020a655c48000000b0038202c728e9mr35433146pgr.472.1653606755402;
        Thu, 26 May 2022 16:12:35 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3206:ea0b:ce53:ea86])
        by smtp.gmail.com with ESMTPSA id y129-20020a626487000000b0050dc76281b5sm2068978pfb.143.2022.05.26.16.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 16:12:34 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Furquan Shaikh <furquan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: cros_ec_keyb - handle x86 detachable/convertible Chromebooks
Date:   Thu, 26 May 2022 16:12:30 -0700
Message-Id: <20220526231230.2805147-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
References: <20220526231230.2805147-1-dmitry.torokhov@gmail.com>
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

From: Furquan Shaikh <furquan@chromium.org>

Some detachable/convertible x86 Chromebooks use EC buttons/switches
interface to signal volume up/down and other buttons. This configuration is
signalled via presence of GOOG0007 ACPI device. The main keyboard on such
Chromebooks is still using the standard 8042/atkbd combo.

Signed-off-by: Furquan Shaikh <furquan@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index e8338b1c5776..c14136b733a9 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -12,6 +12,7 @@
 // expensive.
 
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
@@ -677,14 +678,19 @@ static const struct attribute_group cros_ec_keyb_attr_group = {
 
 static int cros_ec_keyb_probe(struct platform_device *pdev)
 {
-	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct cros_ec_device *ec;
 	struct device *dev = &pdev->dev;
 	struct cros_ec_keyb *ckdev;
 	bool buttons_switches_only = device_get_match_data(dev);
 	int err;
 
-	if (!dev->of_node)
-		return -ENODEV;
+	/*
+	 * If the parent ec device has not been probed yet, defer the probe of
+	 * this keyboard/button driver until later.
+	 */
+	ec = dev_get_drvdata(pdev->dev.parent);
+	if (!ec)
+		return -EPROBE_DEFER;
 
 	ckdev = devm_kzalloc(dev, sizeof(*ckdev), GFP_KERNEL);
 	if (!ckdev)
@@ -737,6 +743,14 @@ static int cros_ec_keyb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cros_ec_keyb_acpi_match[] = {
+	{ "GOOG0007", true },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_keyb_acpi_match);
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id cros_ec_keyb_of_match[] = {
 	{ .compatible = "google,cros-ec-keyb" },
@@ -754,6 +768,7 @@ static struct platform_driver cros_ec_keyb_driver = {
 	.driver = {
 		.name = "cros-ec-keyb",
 		.of_match_table = of_match_ptr(cros_ec_keyb_of_match),
+		.acpi_match_table = ACPI_PTR(cros_ec_keyb_acpi_match),
 		.pm = &cros_ec_keyb_pm_ops,
 	},
 };
-- 
2.36.1.124.g0e6072fb45-goog

