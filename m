Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A347F56985B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiGGCvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGGCvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:51:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0452F3B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:51:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z8-20020a056902054800b0066e2f4d7ae8so8979214ybs.18
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7LPSlq7Trkpni6Jiwio8XRfrUDHcOcS9L2wBFBR2Vzo=;
        b=abzazCQT38DTazMiKkJ2tFav1z5MzZhausH2mwikpoIfOK5eCPul9C4byXwCWzLOXT
         xhWQL709yuL0pVbkXWaW5K+AjBEWpvihA98fJhwMJn/OIqLAXF6Shi6B+NSxcOw+wHZf
         pcnPXwc4JBaHkMYDqlIlE7KjNr/uDUgN5443g6weKVY1Z73u+0XxnMPkxh+Imd8V66x7
         snjGnB4jYIyvwGmkLd6IxcgwES5AtwFd2OBUt6eZsu/RHseCE/L6WO04BAMXge5uscNA
         UuwnwCqOHx5M8cjTWO77p1d3CrFvCp7ePhNo+QPLwaetw2HcmdKMBnorMsRG2/SIUD+4
         Q7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7LPSlq7Trkpni6Jiwio8XRfrUDHcOcS9L2wBFBR2Vzo=;
        b=a7Aa73mnw2UPRdxFLGiUZzR8XDRrf1k+qpJXMsqJZOtmNqTlfOzmV5h+I9FGtz0E7P
         p9N8/N1LOEZHxsIJBuBB+0TGhiQvk1HRBtLT1EP/+QLPYg2dKgZaGHtVY8txNQPezixM
         xwspkoo11yF1ekyKMT/PZ//xNHlc4/WLnBLgLpKVqY6dUMI0/fHiFB8UUj2P9Pe/WAym
         JQ/OsIYtDcL/vofi43QkqbD/+gyVgAD1n/0+0IRRBjHyzXiM7/HSKritaY9zjD1zv5jA
         sautt6oOXhGuz70+DybN/bijdKUG9cAs/II1eKBTsdR8MYQF75YwwpO39gDfx3z8iEUx
         oPFA==
X-Gm-Message-State: AJIora8ikkz5wuP4u5a2NhhMXCRA2SEXPEb9mSpEoIi8leb06UtsisTQ
        dxHeCEtQnU4d733iWBuAqLPYCIv4wDr//ctDjLzcRi2GUyGfcLJIMdL//HXYX+WDZePhJphHEI7
        LMYwYSm2UkA7R0LXRugkeJi863WQF1luS+worahsBoUArIJE/oysZe0DZGbIfHv4H/mQ=
X-Google-Smtp-Source: AGRyM1sv2sZJGNvWqq79iz8jLwYOOA59LiIbMmIQLBcMUQ60SAqPfvBk+4L77cgS6cOmbTQVOiDruUFRyg==
X-Received: from timvp.bld.corp.google.com ([2620:15c:183:200:7d77:c591:814b:4db6])
 (user=timvp job=sendgmr) by 2002:a25:3414:0:b0:66e:4752:b055 with SMTP id
 b20-20020a253414000000b0066e4752b055mr21451158yba.40.1657162303830; Wed, 06
 Jul 2022 19:51:43 -0700 (PDT)
Date:   Wed,  6 Jul 2022 20:51:39 -0600
Message-Id: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] platform/chrome: cros_ec: Send host event for prepare/complete
From:   Tim Van Patten <timvp@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     rrangel@chromium.org, robbarnes@google.com,
        Tim Van Patten <timvp@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
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

Update cros_ec_lpc_pm_ops to call cros_ec_lpc_suspend() during PM
.prepare() and cros_ec_lpc_resume() during .complete. This allows the
EC to log entry/exit of AP's suspend/resume more accurately.

Signed-off-by: Tim Van Patten <timvp@google.com>
---

Changes in v2:
- Include cros_ec_resume() return value in dev_info() output.
- Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.

 drivers/platform/chrome/cros_ec_lpc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7677ab3c0ead9..ce49fbc4ed2e1 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -534,19 +534,27 @@ static int cros_ec_lpc_suspend(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
 
+	dev_info(dev, "Prepare EC suspend\n");
+
 	return cros_ec_suspend(ec_dev);
 }
 
-static int cros_ec_lpc_resume(struct device *dev)
+static void cros_ec_lpc_resume(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cros_ec_resume(ec_dev);
 
-	return cros_ec_resume(ec_dev);
+	dev_info(dev, "EC resume completed: ret = %d\n", ret);
 }
 #endif
 
 static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
+#ifdef CONFIG_PM_SLEEP
+	.prepare = cros_ec_lpc_suspend,
+	.complete = cros_ec_lpc_resume
+#endif
 };
 
 static struct platform_driver cros_ec_lpc_driver = {
-- 
2.37.0.rc0.161.g10f37bed90-goog

