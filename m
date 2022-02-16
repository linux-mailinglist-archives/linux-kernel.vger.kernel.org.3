Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9244C4B8283
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiBPIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:04:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiBPIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:04:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4821D425
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h6-20020a253a06000000b0061de83305f2so2645537yba.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cBsOjcPnmLH7/AqklcuehpI9b0p1xbakmUIE5IP9keU=;
        b=IOikt31P2zEAtluISzAwx5beeMxSU+NsFh4G/wCC2BPZHmo5C2myILKNgUnhx7jIsr
         5u1gca1R0sgoUJXWzmNxx+IPiBlv93cY3G2d66YrxGpcD9nUwzXrBzESt8m3gnuPVXX9
         Z2f4kXgs7fxoOwbtzUyUbhBMrSiwMuGA5+DN52h/GSaGYQU4LEK9G7b7vRskRbg6zNiQ
         4ntsP7jnUj2Pb/JpFYBObmW8NZdFH7XwtW+/mdOH8cz9GDqHH9+lHuNeqJx450ymbW1F
         JEHs9Q0IJmyclfGlwjN8NQUUPF0l48kvAfWwRBA80U8jmjZoHMadvGHdk7mDydWCUGm3
         5FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cBsOjcPnmLH7/AqklcuehpI9b0p1xbakmUIE5IP9keU=;
        b=SBzwvYMICKgKsD0hN82XVrKt8ynPO+uXP1M0EtDEgfntytZ4uoWWl7sVoVsU55Q2r3
         1idxCRiC10eL3bA3W/BeUwr3EGNmUrkEANqZgzJLTzh9YtZNKMlFn2Ij8syG1Td/iaBz
         51yoFFQzaMEXogYIkErZz0wq2NbI6OD7yL5eBOQuq/uN3BZO0DezksKwW38JsfaBfF6o
         eobjYYWbcDPhbD+/6hE+BRj6KRPEH3Ohg/iLXuwGcv04lGyVfx7rlNbKDv1UVf94AC7q
         05jO8ayAeWoYATObkjtANqcbosXVyKlr5EQG7gTyMKVWSAQCclC4doYHL21sQRqs+3ZM
         VFVQ==
X-Gm-Message-State: AOAM530P/Fn0OpPbVUI+SSbeSqF3As3hJarX1r+/F9y+RGy7osEdWNWd
        3rqJCtZjjrbg2V93K98+yGQS55grJ3RL
X-Google-Smtp-Source: ABdhPJwIKjl5qpVIgCVJ6WFHe5Q6tyytpUjKF+fO3a8yu4ekaUbz6G5cuNxkcJXUaxbtAWEwmzQeSHmbSR5p
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a0d:ef82:0:b0:2ca:287c:6c5b with SMTP id
 y124-20020a0def82000000b002ca287c6c5bmr1424157ywe.256.1644998620185; Wed, 16
 Feb 2022 00:03:40 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:03:06 +0800
In-Reply-To: <20220216080306.3864163-1-tzungbi@google.com>
Message-Id: <20220216080306.3864163-6-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216080306.3864163-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v5 5/5] platform/chrome: cros_ec: append newline to all logs
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, pmalani@chromium.org,
        tzungbi@google.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>
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

To be consistent, append newline ("\n") to all logs.

Reviewed-by: Guenter Roeck <groeck@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
No changes from v4.

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-7-tzungbi@google.com/)
- Add R-b tags.

No changes from v2.

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit message.

 drivers/platform/chrome/cros_ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 1e1a24a80d9f..1395c764d938 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -215,7 +215,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"chromeos-ec", ec_dev);
 		if (err) {
-			dev_err(dev, "Failed to request IRQ %d: %d",
+			dev_err(dev, "Failed to request IRQ %d: %d\n",
 				ec_dev->irq, err);
 			return err;
 		}
@@ -266,7 +266,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	 */
 	err = cros_ec_sleep_event(ec_dev, 0);
 	if (err < 0)
-		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
+		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec\n",
 			err);
 
 	if (ec_dev->mkbp_event_supported) {
@@ -337,7 +337,7 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	ret = cros_ec_sleep_event(ec_dev, sleep_event);
 	if (ret < 0)
-		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec",
+		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec\n",
 			ret);
 
 	if (device_may_wakeup(dev))
@@ -382,7 +382,7 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 
 	ret = cros_ec_sleep_event(ec_dev, sleep_event);
 	if (ret < 0)
-		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
+		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec\n",
 			ret);
 
 	if (ec_dev->wake_enabled)
-- 
2.35.1.265.g69c8d7142f-goog

