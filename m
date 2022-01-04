Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70979483BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiADGWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiADGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:22:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B65C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 22:22:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so2117192pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 22:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YL2eZRWZPza3fG+cUhkNkFtKht4RCVGdGOYrobm8hvc=;
        b=bXAReRekp3Ch5av9UEJjYPsdngGJOCahZMQGNdCz3lTvobQA6mT8UOkf1LNLLs+Bdm
         FDlbw9X2318kQNdNB3JuK/xotBqNVZ1ka0dWRbXyeitE+LEhmwRAMtRXZkRGuAgexhPx
         qlu7/5ER7MxAIc69mCi7lwwbDMhzOD+lGG0HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YL2eZRWZPza3fG+cUhkNkFtKht4RCVGdGOYrobm8hvc=;
        b=EcrVqQjeBUBEx1UkQicygAVM/bsTSo6DEqxisyt1dX1oNJ8h5zVqd/4SmYl4Y/YjN2
         v/PVaW4ZzA3Sanzd8TL62zrQfZrvi5uJp0z0v9udsaRfbskNDdUjElaPgoKbSqVsKo71
         SuJuKzx6RtUfwCwL8NYwtxxsuzHFoa/V0UEKWOHcdRLj1A6kkRGSrUri+I2kL06U/wLV
         54K8SaJ2tS7qf8CVWmdUmeeIWGRmhN+7pzOYGvBppMqBR8q4qH6iN7FIoKWyVFado4Mm
         D43jvH5p7heVd9iCDkzeBAWG/sTkJ8mOrNfA0GE7+kxVudS8zDv9zHyD/tlWiWwY8UBN
         v6kA==
X-Gm-Message-State: AOAM532rpU+BeWYibVNvu7GNdcBGu/ex2SgyeKQqQYE5OP8D9+ViVUnD
        zRs9DdkmImNoH7yM9icngTt1Iw==
X-Google-Smtp-Source: ABdhPJyhbJiYDRgkeBOzGSDYl/Q4bW899WPbKkwOc5+O52YxDr+Jldi+D/l6eTKH3U562P3eoWFc0Q==
X-Received: by 2002:a17:902:d101:b0:149:9004:4e7b with SMTP id w1-20020a170902d10100b0014990044e7bmr29405858plw.142.1641277341242;
        Mon, 03 Jan 2022 22:22:21 -0800 (PST)
Received: from localhost ([2620:15c:202:201:6f47:183c:871a:2a1a])
        by smtp.gmail.com with UTF8SMTPSA id d13sm35075562pfl.18.2022.01.03.22.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 22:22:21 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/3] plaform/chrome: Remove SET_LATE_SYSTEM_SLEEP_PM_OPS
Date:   Mon,  3 Jan 2022 22:22:13 -0800
Message-Id: <20220104062213.2365356-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104062213.2365356-1-gwendal@chromium.org>
References: <20220104062213.2365356-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 296282fca791 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
introduces LATE_SYSTEM_SLEEP_PM_OPS, so we can remove the #ifdef around
suspend/resume functions.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_i2c.c | 6 ++----
 drivers/platform/chrome/cros_ec_lpc.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 30c8938c27d54e..b27c15f6774cc9 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -316,7 +316,6 @@ static int cros_ec_i2c_remove(struct i2c_client *client)
 	return cros_ec_unregister(ec_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int cros_ec_i2c_suspend(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = to_ec_dev(dev);
@@ -330,10 +329,9 @@ static int cros_ec_i2c_resume(struct device *dev)
 
 	return cros_ec_resume(ec_dev);
 }
-#endif
 
 static const struct dev_pm_ops cros_ec_i2c_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_i2c_suspend, cros_ec_i2c_resume)
+	LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_i2c_suspend, cros_ec_i2c_resume)
 };
 
 #ifdef CONFIG_OF
@@ -363,7 +361,7 @@ static struct i2c_driver cros_ec_driver = {
 		.name	= "cros-ec-i2c",
 		.acpi_match_table = ACPI_PTR(cros_ec_i2c_acpi_id),
 		.of_match_table = of_match_ptr(cros_ec_i2c_of_match),
-		.pm	= &cros_ec_i2c_pm_ops,
+		.pm	= pm_sleep_ptr(&cros_ec_i2c_pm_ops),
 	},
 	.probe		= cros_ec_i2c_probe,
 	.remove		= cros_ec_i2c_remove,
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index d6306d2a096f13..91b4f9dad069b1 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -504,7 +504,6 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 };
 MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
 
-#ifdef CONFIG_PM_SLEEP
 static int cros_ec_lpc_suspend(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
@@ -518,17 +517,16 @@ static int cros_ec_lpc_resume(struct device *dev)
 
 	return cros_ec_resume(ec_dev);
 }
-#endif
 
 static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
+	LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
 };
 
 static struct platform_driver cros_ec_lpc_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = cros_ec_lpc_acpi_device_ids,
-		.pm = &cros_ec_lpc_pm_ops,
+		.pm = pm_sleep_ptr(&cros_ec_lpc_pm_ops),
 	},
 	.probe = cros_ec_lpc_probe,
 	.remove = cros_ec_lpc_remove,
-- 
2.34.1.448.ga2b2bfdf31-goog

