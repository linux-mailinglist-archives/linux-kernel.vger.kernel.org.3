Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A329F4B827D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiBPIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:03:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBPIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:03:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544621546C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s11-20020a255e0b000000b0062277953037so2623273ybb.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SE1MVdE6VYYgYy0YdvS/4bDSsAOzBU2OrOAH/ZUOnFg=;
        b=oeGfckUJe6Fgl8bC2ziCgYFPG71l9XmLh+g9L4Yq4ppJfmoLfhqaRT7PhyCF92nQa8
         4j96bF3sQyGxNkZO/f1cnd1NQ909E/VE6a9nhLAA77BAfpEnT37UN2A9eC49FdNvXi6R
         cPuzJXe8hRvI79/fT5VfcPQInUsduFGfWbrkcYbuDfDdbB6CVUtn9XdHp8qzDc6X7oVG
         WtOts4TH2CYXrGzhymjUWttuElJqDwNCNmUf3GiuoB/I3rrg3YaZncqrSi6s6m5EixfI
         9j2uLGPci4eqhqDXA+YsoAXY9Wh3tZRmCib2wcZRL+Et7EiEZ2SGmN7Wsl77xLlbx0yT
         7jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SE1MVdE6VYYgYy0YdvS/4bDSsAOzBU2OrOAH/ZUOnFg=;
        b=CniIjszXd2t0+EOjO9zKrRmZm2kmqblmEyZxpcJ1Q232A4Z67wbvA3Uvt0P7jm5hXA
         dx2msdjmSgHeM3mHFQSiVdIADwa5FeMHec/IKLm55Qb107ayshMytPRboUa/QPIk/me6
         S0d4e6+QyDpy1e0TWi2hk/AFX8dvRic8kKTVTVNCJbKtgE1KP60K5anMdYX3dkig5DFG
         Varc+s/qYLA9DTCPaCxvs17RInGbgOdAby9S6vhj7DY/IJukeAcoewGbL60OhJIWuKSd
         n/5Akm7hgb5EL3C/RHomeue38NqCzvIhqxWIxbUHQkQj1ujzgUKFPgphyOCcqOjmNk+l
         i+aA==
X-Gm-Message-State: AOAM530gqvceAnNAccaTxqbW7MmCuVLK5dpqp2w7m8MgC1HBdPpShRoV
        vZs80H+5Bqte6UsUyhc8LtJazFoVeJCr
X-Google-Smtp-Source: ABdhPJxMKIQf7axeUM4rmevbTIpLdf4pXF/mgLIQe7ZVC5J4o0olbRMFcXkad1Mnde1GqBRBGMAZayKoyZu7
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a81:7707:0:b0:2d0:dc96:5729 with SMTP id
 s7-20020a817707000000b002d0dc965729mr1398343ywc.37.1644998611613; Wed, 16 Feb
 2022 00:03:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:03:04 +0800
In-Reply-To: <20220216080306.3864163-1-tzungbi@google.com>
Message-Id: <20220216080306.3864163-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216080306.3864163-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v5 3/5] platform/chrome: cros_ec: determine `wake_enabled` in cros_ec_suspend()
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

`wake_enabled` indicates cros_ec_resume() needs to call
disable_irq_wake() to undo enable_irq_wake() in cros_ec_suspend().

Determine `wake_enabled` in cros_ec_suspend() instead of
reset-after-used in cros_ec_resume().

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v4:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220216043639.3839185-4-tzungbi@google.com/)
- Undo changes from v3; rollback to v2.

Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-4-tzungbi@google.com/)
- Change the patch title.
- Simplify by initializing wake_enabled in cros_ec_register().

No changes from v2.

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit message.

 drivers/platform/chrome/cros_ec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 25cd8df6e7b0..a013fbceeb03 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -342,6 +342,8 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	if (device_may_wakeup(dev))
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
+	else
+		ec_dev->wake_enabled = false;
 
 	disable_irq(ec_dev->irq);
 	ec_dev->suspended = true;
@@ -383,10 +385,9 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
 			ret);
 
-	if (ec_dev->wake_enabled) {
+	if (ec_dev->wake_enabled)
 		disable_irq_wake(ec_dev->irq);
-		ec_dev->wake_enabled = 0;
-	}
+
 	/*
 	 * Let the mfd devices know about events that occur during
 	 * suspend. This way the clients know what to do with them.
-- 
2.35.1.265.g69c8d7142f-goog

