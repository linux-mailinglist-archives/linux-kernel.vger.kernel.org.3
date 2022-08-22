Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB259C41D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiHVQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiHVQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:28:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0D613D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:28:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-333f0d49585so193742027b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=AxrrQ/cU54Du/u6O6i3La3esh5CO5fel4eR9JQBqAWo=;
        b=S3lkQEZjJ1frFfLakQXlelf15iQfOokMGlDcgxARv/KBBT/r2A1LzgMC1e4XwLS20J
         oP5iWjbcOlW5Z8J5UwdsKts+WuCMiLZTXDmS7ONa+zjN0++zr2IRViU7+5sgaDcatEw0
         H4aPGKJkv0GX2aTP/N7ddrNADyht+To69kQGwMECr3OTofmPiqND0KG2LYKRzrPJsJIy
         fbMAjEsOPTfukK/yZkcFtpJuKAQ1P/rMJkkNAdh9XSjISCuH1lEp99PufbtCGSmB25Wc
         yroZOr+6mNwK9Z5/6bypdf4KR/tPb1JII+jVp7Lt9+5sU901o/Y80V5nEeEZdghsSz/k
         rsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=AxrrQ/cU54Du/u6O6i3La3esh5CO5fel4eR9JQBqAWo=;
        b=3j2O/KLWkOjVLRp/qsCm5rxQeVxw+nhREAodcu7Xc8NadlmIgrxSZzPZVcLc1W9p7Q
         Vclsk/C3NMJNS3Gn/AxCf1xVBhCbNFX7nSCgtDFUL1/MBodzRbjnQ/4CKnd2xhzEXuJN
         Wx9hWMOIL9xouSkAK1DSjEnR+oTlM8ynszJa1DUI7OWMS+2ZehZyMya5k2v2wcqWu5f8
         JCH0jk1hps2VXdep5WW9nqEDR/f9/lSDYexI5yVznPHt0fjbMuufQfXah/1UznwG+T8D
         bwo65MLH1eB0IGtwJLSphsYGRe6zGuvsA3CIITeEDEIMomZoXxcvBuf+f4PfILDvyodM
         9bpg==
X-Gm-Message-State: ACgBeo3uqfFpYPF4xrpRlBZaMfeDfWky36U0TlfAr3A2O5Tpjt0AQsr+
        b9gcu5RvHjE3CbNpfBYsnjbY1DroAw==
X-Google-Smtp-Source: AA6agR7Mw58dFCBQKrf04lrAy5d1aWcFcyQvhwDseobFsnt7EMHiq+aZlF5HNSA7qRRwrRN8i20UJVnkeA==
X-Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:762:7c61:946f:731])
 (user=timvp job=sendgmr) by 2002:a81:1e0d:0:b0:33b:fb67:9895 with SMTP id
 e13-20020a811e0d000000b0033bfb679895mr5820461ywe.188.1661185703445; Mon, 22
 Aug 2022 09:28:23 -0700 (PDT)
Date:   Mon, 22 Aug 2022 10:28:20 -0600
Message-Id: <20220822102812.v4.1.I0c49f19e953a76ff6e6debc2990a1d108d6f842a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v4] platform/chrome: cros_ec_lpc: Move host event to prepare/complete
From:   Tim Van Patten <timvp@google.com>
To:     rrangel@chromium.org, robbarnes@google.com
Cc:     Tim Van Patten <timvp@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
.prepare() and cros_ec_lpc_complete() during .complete(). This moves the
host event that the AP sends and allows the EC to log entry/exit of AP's
suspend/resume more accurately.

Signed-off-by: Tim Van Patten <timvp@google.com>
---

Changes in v4:
- Update title and description.

Changes in v3:
- Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
- Update cros_ec_lpc_resume() to cros_ec_lpc_complete()

Changes in v2:
- Include cros_ec_resume() return value in dev_info() output.
- Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.

 drivers/platform/chrome/cros_ec_lpc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7677ab3c0ead..ce49fbc4ed2e 100644
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
2.37.1.595.g718a3a8f04-goog

