Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1A588133
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiHBRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiHBRkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:40:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA610EA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:40:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f5960500bso122626457b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ONVk+IwfQtxkQMEE1txHxraIYz5uS1JfsA6nTBwgy+I=;
        b=VPi1EX9sV3DI3/6YfkpEke2lO5PZ2alhRTtje8l5A7fsDOKzH3zs6lpGJSy3VD1Kwc
         gSTmLomYI5iNuo+5Dqa+wxPnj84hVgh40XecRcNFbjGl/DcJomF4EL5SW2MQzR0HRS3o
         0GRMM0y9FmEbHuaDTRci/3TrTZRz5Qkwp9ZLY0htMy51YggPCh+k6riQG7qBynu6Ljt7
         txyB+cVI8TajmI/Z4yiE37p1A9Wz+9JSgHW4g3VQLlfsiVZGY4znC33U/QUu/zKe1xeK
         dX9bi2BWvBTIC+gFLiM97+BKol+uHfNy3wfz3NdjPaTTpLfjFQs7vf9UrHszGXJQ4/5N
         zgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ONVk+IwfQtxkQMEE1txHxraIYz5uS1JfsA6nTBwgy+I=;
        b=If1wRt0ywiCrXmUHC9X3/NXZsMYovK6oV82SQbCYxchfb6sDqZs2D8XuwzHcQUFWFG
         /qMvGZyk1LUCteBauPbf6xT5olRcKqO7Sntnhlj/U5JdjIusxFUnuILGU1Uh2B/pwLwx
         /wqkXJ9GJa2xz7BUm5b5ezN7+pf93fVQ/A8wqNRQyT4KnhdkYwYfkM3roXomzOZE1RmC
         xy8enpZV0/beGh/0C1BfS9KainrRWqpnhbpCtgja186cAq/JOYXP7aXB5h4gX4tGVfmf
         Yj4NRm+tNTI7uXa6dojz1ASGsy/m+BK079/tBheuEuPGqadVOllOx788pRHZzCjrw0+y
         lXkw==
X-Gm-Message-State: ACgBeo0Y7W/gH4kx6PJ616dnausVgnxXn++LSI5Ojd0Jky+3FskCRj0r
        nT2bxhUcXWE0XFz7poSwKJ1REJXglA==
X-Google-Smtp-Source: AA6agR6G2fc61/vdfjDY2CqjeZK0f37dBSOoZhf6/RxQc1A4UreeeeNwIkSFEV8AcCr2cuFO5qqUDWYlZw==
X-Received: from timvp.bld.corp.google.com ([2620:15c:183:200:61dc:f28d:ccc1:638a])
 (user=timvp job=sendgmr) by 2002:a05:6902:1404:b0:64e:1ec0:cec with SMTP id
 z4-20020a056902140400b0064e1ec00cecmr15406103ybu.588.1659462017098; Tue, 02
 Aug 2022 10:40:17 -0700 (PDT)
Date:   Tue,  2 Aug 2022 11:40:08 -0600
Message-Id: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3] platform/chrome: cros_ec: Send host event for prepare/complete
From:   Tim Van Patten <timvp@google.com>
To:     rrangel@chromium.org, robbarnes@google.com
Cc:     Tim Van Patten <timvp@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
.prepare() and cros_ec_lpc_complete() during .complete(). This allows the
EC to log entry/exit of AP's suspend/resume more accurately.

Signed-off-by: Tim Van Patten <timvp@google.com>
---

Changes in v3:
- Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
- Update cros_ec_lpc_resume() to cros_ec_lpc_complete()

Changes in v2:
- Include cros_ec_resume() return value in dev_info() output.
- Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.

 drivers/platform/chrome/cros_ec_lpc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7677ab3c0ead9..4158bdeee197b 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -530,23 +530,31 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
 
 #ifdef CONFIG_PM_SLEEP
-static int cros_ec_lpc_suspend(struct device *dev)
+static int cros_ec_lpc_prepare(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
 
+	dev_info(dev, "Prepare EC suspend\n");
+
 	return cros_ec_suspend(ec_dev);
 }
 
-static int cros_ec_lpc_resume(struct device *dev)
+static void cros_ec_lpc_complete(struct device *dev)
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
+	.prepare = cros_ec_lpc_prepare,
+	.complete = cros_ec_lpc_complete
+#endif
 };
 
 static struct platform_driver cros_ec_lpc_driver = {
-- 
2.37.1.455.g008518b4e5-goog

