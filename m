Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3749E483BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiADGWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiADGWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:22:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E844C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 22:22:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v13so31344312pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 22:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5skJ1adnSEqbAhZu27y857FPm6OsY3ZtDrlCEr6GDE=;
        b=ftwK8EdoU9ZeKpKmJ11tgcPKaqUNqAIy2Ec+KkJ5pZ3Cewhxpcxz0AbnOl7KDH7ZbC
         /aHV4XqXShxDL2q4YOuwkdT2GVGu1ojl11sBm7m7Z4qpM/fPzPhEWAb3U4mW8DMCscjR
         YkN1RCBDG7k7ckc0eT1zh2qTmI9afzPU3CA/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5skJ1adnSEqbAhZu27y857FPm6OsY3ZtDrlCEr6GDE=;
        b=CrDgi68X3P6VM/IiberQQJEyGnPNhJDtz/+NMZr0k+tXgqgv0ZF3QM4IbDpZYRwdyq
         sfnWhrTEID2VzTlG3xmurqi7hS8+i/6fqO7pPgF3YiS9c8XQS4MxCCPZnsaOEVnxmC2A
         J3JivAraBrk2GyBsqHI/ejVgtDc+D3hTiFK9nuNk8McDunbH9slkrSRzxus3ll0wVAkU
         qXIU3M60KQDVRc63KzoMY0TO1AJwvFwlaUBRbsNiheZZp4ZZtXmsj+68c9hZUMZ0OE1b
         9q0KWKbDkgOf0aVwZEaBnAL1dbZM5eXrBcNQFw4b6hQtNfwT8/eF2UYrC1+Z3tniEEO6
         F0XA==
X-Gm-Message-State: AOAM531OQ3Vb7nE+GImqckej1UwOs7IXY0ACwWgrOTgiwLYD/NuXbZ+H
        qSvT1GVaAdHnEGkJrUZPgNNkkQ==
X-Google-Smtp-Source: ABdhPJxoRU7e2ecABqN4Y0dXUonGnCMKa9/ahrm1WNKt6rnixKdBv4hekN2AXZ8kbvsYRd+jDP6m4Q==
X-Received: by 2002:a05:6a00:168b:b0:4a8:d88:9cd with SMTP id k11-20020a056a00168b00b004a80d8809cdmr49113394pfc.11.1641277338656;
        Mon, 03 Jan 2022 22:22:18 -0800 (PST)
Received: from localhost ([2620:15c:202:201:6f47:183c:871a:2a1a])
        by smtp.gmail.com with UTF8SMTPSA id r13sm35029641pga.29.2022.01.03.22.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 22:22:18 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/3] plaform/chrome: remove SET_SYSTEM_SLEEP_PM_OPS
Date:   Mon,  3 Jan 2022 22:22:11 -0800
Message-Id: <20220104062213.2365356-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220104062213.2365356-1-gwendal@chromium.org>
References: <20220104062213.2365356-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 296282fca791 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
replaces SET_SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS.

Use sed and a cocci script to replace the macro and remove
__maybe_unused:
@Replacement@
identifier operation;
identifier suspend, resume;
@@
- static const struct dev_pm_ops operation = { SET_SYSTEM_SLEEP_PM_OPS(suspend, resume) };
+ gg_fc operation = gg_arg(suspend, resume);

@@
identifier Replacement.suspend;
identifier dev;
@@

- __maybe_unused
suspend(struct device* dev ) { ... }
@@
identifier Replacement.resume;
identifier dev;
@@

- __maybe_unused
resume(struct device* dev ) { ... }

@@
identifier Replacement.operation;
@@

- &operation
+ pm_sleep_ptr(&operation)

spatch -sp_file no_SET_SYSTEM_SLEEP_PM_OPS.cocci -dir drivers/platform/chrome |
patch -p 1 -d drivers/platform/chrome
sed -i 's/gg_fc \(.*\) = gg_arg(/DEFINE_SIMPLE_DEV_PM_OPS(\1, /' $(git
diff --name-only)

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5de0bfb0bc4d99..c3d449f9e38bc6 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1129,7 +1129,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __maybe_unused cros_typec_suspend(struct device *dev)
+static int cros_typec_suspend(struct device *dev)
 {
 	struct cros_typec_data *typec = dev_get_drvdata(dev);
 
@@ -1138,7 +1138,7 @@ static int __maybe_unused cros_typec_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cros_typec_resume(struct device *dev)
+static int cros_typec_resume(struct device *dev)
 {
 	struct cros_typec_data *typec = dev_get_drvdata(dev);
 
@@ -1148,16 +1148,14 @@ static int __maybe_unused cros_typec_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops cros_typec_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
-};
+DEFINE_SIMPLE_DEV_PM_OPS(cros_typec_pm_ops, cros_typec_suspend, cros_typec_resume);
 
 static struct platform_driver cros_typec_driver = {
 	.driver	= {
 		.name = DRV_NAME,
 		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
 		.of_match_table = of_match_ptr(cros_typec_of_match),
-		.pm = &cros_typec_pm_ops,
+		.pm = pm_sleep_ptr(&cros_typec_pm_ops),
 	},
 	.probe = cros_typec_probe,
 };
-- 
2.34.1.448.ga2b2bfdf31-goog

