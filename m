Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E444B7F85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiBPEhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:37:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbiBPEhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:37:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721DEF1EBB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:37:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h6-20020a253a06000000b0061de83305f2so1802853yba.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bYXXjRPc3+amq4nUn2zKlGGGB3ySddzbVS7PLxHhbGI=;
        b=AnyhfMfehc17BivQ/iPlxJOqaloiNeAlCKUVWzYDr2j6PopYBv8Ng6e396M+41Lo5/
         ILN70TE/GTQs8eFLLcavMUNDqUGxPrHfzJ7YhTtbNYkMJ2eUH0Ae7YmulGlJXed4VqyF
         NVb5MISdL6pKgQvJlo81UCNr+3s3SYhuVpy/fMyq03OJp4kWieR/Kmh81YxFDIBi0UlN
         Hxcr2DDYcw4mbQia8Zofh0E1kzQmGU000vSekQM2eWUqdQX8oA1fHt4l32Gsv7yNduzr
         HkBmRDzMTk4XP1Qe/QaDdnDlYyQuWKhyTtMugsLmbAkXF9QgnvEtuAL+4uXLl89ZF3n3
         3cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bYXXjRPc3+amq4nUn2zKlGGGB3ySddzbVS7PLxHhbGI=;
        b=qPxVFeXNOSF8uu3maDpa/0GYlQWLASdYMCJrES1J2jhgJGa1X+QwbOIjouPp3xXZUM
         Kvkm+AkmYOMoljj+IkZKw7O2yZsOs4esAQ4o2PeYNi93LK4U+XVhdcz/f01AGis/FH7Y
         ccVRm0CHHdTReruPtkA1Wq8I9xaRoAzEn6VGHqPyXpEO06KX0btlUNguvbk93ruWh663
         EXWdoAtga904uj5Y2WMowA0gWQBfKsxgdNUhfpRolvKe02snp///dCb5IfzV5+lAo7JN
         9beCpIofWePGFIjkGWPNG7nENPHcIjFhMvW1lR6/6Bj9yHCtO7ueCze3Qf3iDZX5pKAL
         kCPQ==
X-Gm-Message-State: AOAM533DvZMp9gInBWh7qhbzm2qJjwUV452dPvtZdqsiS+w31Jya/Jbj
        3G+cdG9hqZAG4jRjBPbp5dURV4OvGE/B
X-Google-Smtp-Source: ABdhPJw95YErySPO3wArh7ukWmaemcssepqzKqsZZ6nlYXHHAxFhSFXHWC8WbsD9bG5pE/NAuv1pbQV0/6MJ
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a25:dfd0:0:b0:61e:1ddf:a07e with SMTP id
 w199-20020a25dfd0000000b0061e1ddfa07emr756178ybg.242.1644986223292; Tue, 15
 Feb 2022 20:37:03 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:37 +0800
In-Reply-To: <20220216043639.3839185-1-tzungbi@google.com>
Message-Id: <20220216043639.3839185-4-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216043639.3839185-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v4 3/5] platform/chrome: cros_ec: initialize `wake_enabled` in cros_ec_register()
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

`wake_enabled` indicates cros_ec_resume() needs to call
disable_irq_wake() to undo enable_irq_wake() in cros_ec_suspend().

Initialize `wake_enabled` in cros_ec_register() and determine the flag
in cros_ec_suspend() instead of reset-after-used in cros_ec_resume().

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-4-tzungbi@google.com/)
- Change the patch title.
- Simplify by initializing wake_enabled in cros_ec_register().

No changes from v2.

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit message.

 drivers/platform/chrome/cros_ec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 25cd8df6e7b0..b6604a9ab315 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -191,6 +191,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	ec_dev->max_passthru = 0;
 	ec_dev->ec = NULL;
 	ec_dev->pd = NULL;
+	ec_dev->wake_enabled = false;
 
 	ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
 	if (!ec_dev->din)
@@ -383,10 +384,9 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
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

