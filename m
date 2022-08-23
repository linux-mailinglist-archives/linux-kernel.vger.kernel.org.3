Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CF059EA61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiHWR5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiHWRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:55:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FCC2EAE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:59:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5960500bso245866007b3.14
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=s208mFKW5mux3x3fFQzuS0oklKHocAknnwXo8nQY6YI=;
        b=onfDdlrNeXjaHJVDclJvl6kkSSZkwz5ngSB+xHxpci91JPwn/QO5fmV/397a+aKKxp
         zTPVzXdt1umOXjW8wgznpZ1IlQ4kZgOHnBZiB55z16cURRuftdST3FqI3I+UVo3b11h3
         XxkIIXmNoF0oLdrwDceCt/wTQn9UJbLIdHuQgggVxuaVm5+KNac5PQPzdHbFe2CFjx9I
         hbcEIsznWyLSkDngLXclu2/eSvs7K2b1fH4EzzNEg86OETq+ltNOkV9PIpYilyHRkqL4
         1nBZFFUXLC3aJEPGR7WT+kszNxPVrmIjbjrjcAfyeFB3LvUdjBuoo1vlYq60nMCIA7S1
         lpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=s208mFKW5mux3x3fFQzuS0oklKHocAknnwXo8nQY6YI=;
        b=1HMeLnUEJ5RI8PNtuAgikkbzWTujWh7v1sxavaxnC4jTlkEYa9vhIj7WYDcFrR+QE9
         2CJKJK1MfQHER6MR76uTgQa111TGzN+5PH5nB31IygQKkkzy+EMSKWuRVrAk56wp0v2+
         lxDmFYsmAR09KU+N+xOWsbOFxyvyS9RvjvLBDDV+IfcMLc7/3ONXAn5DHQWNnaE4A4Uw
         ZpiVIkG0yJg0spaWIk5BI9QpH8SdQaLC78J+TIO+D38QyywN7bHB77C4C27dkNF2tHo8
         QNx6VcXMTD1IZCrqwhjDGpEo6lwWBLxp1RyKb5pH68GAREszpSSuKR1JifYRW7DM6/UE
         nYMQ==
X-Gm-Message-State: ACgBeo0b1ZZUP4L2K+onySZvvBFF+2ZS9vuCu0glvmXyOpmN0MfDEYPX
        M6hCE9aK3pwfu4ZTD6UlruFFARcKxA==
X-Google-Smtp-Source: AA6agR6lvaz85tu0pzAuiS+DWBgUc/EfOcw88DjqRBJtufUAKYnAyUkyBx9LWajcnsGGF57Q4v0iO+5xwQ==
X-Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:2f3b:1daa:d20:c362])
 (user=timvp job=sendgmr) by 2002:a5b:d09:0:b0:695:f25c:fa14 with SMTP id
 y9-20020a5b0d09000000b00695f25cfa14mr3450377ybp.163.1661270359512; Tue, 23
 Aug 2022 08:59:19 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:59:17 -0600
Message-Id: <20220823095915.v7.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v7] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
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
host command that the AP sends and allows the EC to log entry/exit of
AP's suspend/resume more accurately.

Signed-off-by: Tim Van Patten <timvp@google.com>
---

Changes in v7:
- Rename "host event" to "host command" in title/description.

Changes in v6:
- Fully restore fixes from v3.

Changes in v5:
- Restore fixes from v3.

Changes in v4:
- Update title and description.

Changes in v3:
- Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
- Update cros_ec_lpc_resume() to cros_ec_lpc_complete()

Changes in v2:
- Include cros_ec_resume() return value in dev_info() output.
- Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.

 drivers/platform/chrome/cros_ec_lpc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7677ab3c0ead..4158bdeee197 100644
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
2.37.2.609.g9ff673ca1a-goog

