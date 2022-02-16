Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB394B7F88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344399AbiBPEhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:37:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbiBPEhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:37:06 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65478ECC4C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:36:55 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id ay10-20020a17090b030a00b001b8a4029ba0so3862656pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L2Rv1HN3aOgdNDlKvNWeNesh39hy8goLHfRj+y0FOyo=;
        b=RyOJ8/c/bdvV3j2m1WsUTqbrWRYq+AVhJSMj4Kvyi1gL1WX4Q5fOqhLHqxp6dLwNJ7
         12B//cGyKUk2u6j1O/zjOu+Bx2U/cDqEGHoEaMLMjlq5tVzl+OibSHg2LsUy3B/aBl4P
         6fk+a62qWrYADmfTm0Ea5a1wFNU8GTIrOxGp5xJm3m0SBNmDHJTARr+NBVOiuBmLkD2u
         Z49xhDdP/yiOaoKQ7h2DuoqaEGVS8M8D+14Ya0jI43fU+UoEt5guJNReIlmmImpBW2gu
         HMZz8MM+OpbLpl1v9gMThr68sI/GgMmP3BUM+9if+5B8Ocg4fvhd545U4ZBb0Edfkj/L
         Jgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L2Rv1HN3aOgdNDlKvNWeNesh39hy8goLHfRj+y0FOyo=;
        b=tm8NhKNFuBWOTg0g1EmUc+QkEA3mgWIeXWpRoryYgGGk8MHoDiikKDXGf0YKV9Rket
         idwE6lkQfEdkIS5pVjzD8A6xyjsB6nYSzwbSaBroqGkjwhIU+VCqK+oItEzakw8JoHnG
         xOcZ41Miwekntf3AvOTajraVQQ3fy0DkBfAQ/dVEHUzR10095ClYk0V8A9J5xZgZFAA9
         q3sGSgV/q19UmvaEoEhqLKTorr9jX1nzHesVir9zig8JSXmMxpllRmBxzrbAAS3+huuN
         UApN9A5GvMZ8cCY5B8OmfWHSFXGj8j7Cq4jEXaSWKDS4AbfINSCwn3TgJp/mwgO7xcLP
         AjaQ==
X-Gm-Message-State: AOAM530p+dcgfP1HWMvdKOse/L96jH1250dME0x/DqWVe1DEh+SfRkAt
        IoTn7zZhzdk/Q5+yiHhH6jb/NvsnckLC
X-Google-Smtp-Source: ABdhPJxjaNkNFssd+42CZAQI78GS0fwSyxgzKNfs+CeFwS+D9dBy8OghmG9/u2ygTNyjyJokWgiLhEYqIHHc
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a17:902:c651:b0:14d:bd13:6ff5 with SMTP id
 s17-20020a170902c65100b0014dbd136ff5mr671657pls.170.1644986214845; Tue, 15
 Feb 2022 20:36:54 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:35 +0800
In-Reply-To: <20220216043639.3839185-1-tzungbi@google.com>
Message-Id: <20220216043639.3839185-2-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216043639.3839185-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v4 1/5] platform/chrome: cros_ec: fix error handling in cros_ec_register()
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        pmalani@chromium.org, linux-kernel@vger.kernel.org
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
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
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

