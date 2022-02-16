Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB54B827B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiBPIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:03:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiBPIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:03:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B4213F1F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 2-20020a251302000000b006118f867dadso2695505ybt.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QwbIJmiyLmPJsz2898M/cKW1wrJYaBVyOrGjlzPUzPM=;
        b=QKqEMCGcSx2J3hQkVkRuvqwH+mW4FQKm+Y0JL6wkgcPIwTDVabKlRaTr/qFFPbehup
         Ca3LeujYdXNC2VCz41ANfKgS6oBnpOEROXSNTqS3bVDU1QaF348xv3+8kkZJJotyd2V8
         E3kIVWLjfK2kD8yg8EqixIMvSLRUg43RPHZX30hlfDiBKbzj3gsFQT9ZBZp3ZxjTqwQm
         CUyctzVDYKtaqZBbn4xM8Pa2U1hRSYnv6YWzffTI233Go/qCJNk8FgvJz1inn3Dp7YNC
         V/9snbueLCPDnKiuBQLE77JmbrEo2JTPgJQXJHXY4Q5zTBBvNB1+cQGjBquckXK404Fe
         uxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QwbIJmiyLmPJsz2898M/cKW1wrJYaBVyOrGjlzPUzPM=;
        b=JI8WZNLrbzdsAp+Vw1UoMiK0HHUxAbkxTedZ1FGXAfU7MXg+e/dc++Lul5weDpALXl
         7dZ+u3q7h1xfCpGdB2bOzU9BGEwu9HR+8V0cwdEc/E0x7/etmFOzzBkwbEyLqV2z/JOo
         G88/hPbNBZutjt1I8d32drVmRrDBBWWHQDHlhLdiJMlHhVFvJGZM8LMZyAi1PXyz95vA
         PSWU4VcoydYih8LeHz56KAtFm0C4hZs2L7h2b0Rk55d1pwd6GQz+GcKACqvMIFNx021z
         rkN2JP0EDKFj9P8XK1PVOugeIG9Xhc2mXvLG7vuCJtxEVJw8h+fqokyPbm8FGpkK/Klx
         FlfA==
X-Gm-Message-State: AOAM531vDnOZCLI6a+WW+I7HgB2bqMlQWcCjxtmBuNiLEXBSzm5nmc91
        7rYL9ZvRUjHnTF406Imo3qsOQVwGm4q5
X-Google-Smtp-Source: ABdhPJz+DlHTqa1DwdMIlck0KFDFQurTMv/sTMydH+BMvolVF8Nxsj4O7axBlt5IlDG82yTYuLXvIRhG4Ygt
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a25:e802:0:b0:60e:94cb:dbc0 with SMTP id
 k2-20020a25e802000000b0060e94cbdbc0mr1056681ybd.509.1644998603121; Wed, 16
 Feb 2022 00:03:23 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:03:02 +0800
In-Reply-To: <20220216080306.3864163-1-tzungbi@google.com>
Message-Id: <20220216080306.3864163-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216080306.3864163-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v5 1/5] platform/chrome: cros_ec: fix error handling in cros_ec_register()
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, pmalani@chromium.org,
        tzungbi@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cros_ec_register() to unregister platform devices if
blocking_notifier_chain_register() fails.

Also use the single exit path to handle the platform device
unregistration.

Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW")
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v4:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220216043639.3839185-2-tzungbi@google.com/)
- Add R-b tag.

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-2-tzungbi@google.com/)
- Simplify by initializing the variables at the beginning.

Changes from v2:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220209045035.380615-2-tzungbi@google.com/)
- Fix grammar error in commit message.
- Change the code that don't rely on zeroed memory.
- Remove unnecessary `if` checks before calling platform_device_unregister().

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit message.
- Use IS_ERR_OR_NULL() in 1st patch.

 drivers/platform/chrome/cros_ec.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index fc5aa1525d13..ff2a24b0c611 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -189,6 +189,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	ec_dev->max_request = sizeof(struct ec_params_hello);
 	ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
 	ec_dev->max_passthru = 0;
+	ec_dev->ec = NULL;
+	ec_dev->pd = NULL;
 
 	ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
 	if (!ec_dev->din)
@@ -245,18 +247,16 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (IS_ERR(ec_dev->pd)) {
 			dev_err(ec_dev->dev,
 				"Failed to create CrOS PD platform device\n");
-			platform_device_unregister(ec_dev->ec);
-			return PTR_ERR(ec_dev->pd);
+			err = PTR_ERR(ec_dev->pd);
+			goto exit;
 		}
 	}
 
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
 		err = devm_of_platform_populate(dev);
 		if (err) {
-			platform_device_unregister(ec_dev->pd);
-			platform_device_unregister(ec_dev->ec);
 			dev_err(dev, "Failed to register sub-devices\n");
-			return err;
+			goto exit;
 		}
 	}
 
@@ -278,7 +278,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		err = blocking_notifier_chain_register(&ec_dev->event_notifier,
 						      &ec_dev->notifier_ready);
 		if (err)
-			return err;
+			goto exit;
 	}
 
 	dev_info(dev, "Chrome EC device registered\n");
@@ -291,6 +291,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		cros_ec_irq_thread(0, ec_dev);
 
 	return 0;
+exit:
+	platform_device_unregister(ec_dev->ec);
+	platform_device_unregister(ec_dev->pd);
+	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
 
-- 
2.35.1.265.g69c8d7142f-goog

