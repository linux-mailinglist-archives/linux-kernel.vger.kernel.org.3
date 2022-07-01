Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2652B563744
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiGAPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiGAPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:54:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C715FC7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:54:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31838c41186so21816367b3.23
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nhCCzZMa1NRxw8NA7BhUvRU+X+N/8lSC/+E4poQXxXg=;
        b=GwgECqQfra9vVYA3QvdkTdaAb2D9IVUyR9uGRyWgTcDgxzxUrHgC3N3VCkF13Kfpea
         U1iWeRJfXV4EFTbea/73wvzow60RLTEFwKnp6djpYBaBX0iTekhkHv+P0kixnppFKorw
         En+D7SEVMyjmu8G+Txk6xf30szE+rn5RuV29kAIgsgtpmb+YRmNZBKpe1LJbVtHvKfdV
         Xy6tRJNeCwUD/ae7wY/cRCuHdCIFq4MbAH746J5m/tTPjjw1amSBk+gOhUg0UXbzrBdB
         uNrbDhIgcj3TEEwq3XOL+xLQp+Z55B8XvS5W7MhM/RF4TNY3M2HMyhyMczoZVKWtG3bx
         vReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nhCCzZMa1NRxw8NA7BhUvRU+X+N/8lSC/+E4poQXxXg=;
        b=IT/Gr+EzlQcU+EBzr0NXRsiG4BmmvIcsbx8jbaHMkK2ARfykEuJwY73CERPw0iIB3X
         Ro/wq3TwjpLDijURltFV+O2sTftskbbs0K5rkXDIFvBUlX+d0Kvb3dgxkq9SsHjSdRXC
         CkapqXNaNDO46ESauFhZQI2Kc6pgCi7rSm6lfCVF5tUhkM2ie9T246RrwK6ummaPUpBN
         Jvdq09ZUdRoNQZLgo1TqKFT+vLTro2IAKvR0UOMxyaP/x0i7JtdvWbYUbM2AmSt/0EKo
         dwr0bZeL1pak069JxGl/5iw+kHubN1P4jcTuuBMnV+9FUYnSHB9pxnD35B1W1NRGo1lL
         ZJDw==
X-Gm-Message-State: AJIora+k0ujmbVVa9eU3kesotJ81ACNPUNZpUR1btXFWSHNgwYqmaKf7
        dRLDIPqwyTsNhRVpi6R0dt+bWWYEs8uLGC88GTV9udiZMenVugcXZRqL/Q4KEksqDpSeByMU7hN
        9/x8fTW0YwhsX/hvkgp6bYRcufSHzEfNSZbIR9Toz9RRLaYEbPUrNokHyJcVi2lt27WI=
X-Google-Smtp-Source: AGRyM1v1m+1kAkaGguGEjtHSsXlrp3OWRf0ZqANHx5xmqifvAHQx6lQWEmGIMGySj89JqO8Q/CqOR0nffA==
X-Received: from timvp.bld.corp.google.com ([2620:15c:183:200:fb13:9807:34b4:6d59])
 (user=timvp job=sendgmr) by 2002:a81:8ac6:0:b0:31c:11fe:d215 with SMTP id
 a189-20020a818ac6000000b0031c11fed215mr17802733ywg.417.1656690867969; Fri, 01
 Jul 2022 08:54:27 -0700 (PDT)
Date:   Fri,  1 Jul 2022 09:54:23 -0600
Message-Id: <20220701095421.1.I78ded92e416b55de31975686d34b2058d4761c07@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] platform/chrome: cros_ec: Send host event for prepare/complete
From:   Tim Van Patten <timvp@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     robbarnes@google.com, rrangel@chromium.org,
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

 drivers/platform/chrome/cros_ec_lpc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7677ab3c0ead9..783a0e56bf5f3 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -534,19 +534,24 @@ static int cros_ec_lpc_suspend(struct device *dev)
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
 
-	return cros_ec_resume(ec_dev);
+	cros_ec_resume(ec_dev);
+
+	dev_info(dev, "EC resume completed\n");
 }
 #endif
 
 static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
+	.prepare = cros_ec_lpc_suspend,
+	.complete = cros_ec_lpc_resume
 };
 
 static struct platform_driver cros_ec_lpc_driver = {
-- 
2.37.0.rc0.161.g10f37bed90-goog

