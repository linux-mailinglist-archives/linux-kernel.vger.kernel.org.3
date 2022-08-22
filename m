Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2159C45B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiHVQqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiHVQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:46:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708D1D0DF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:46:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-336c3b72da5so191779887b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=rtaEMsVUgxkEpbiKW/IF/USL8m9F2ihukaZ79pkCq9I=;
        b=mjqMv7yH264vsDiv7u0L+VSabvq7vtfkSvTACtXqss1McRB5WTAjXotwOuQPfHoVcI
         4ALfVqaz/i/+R9HFZDHd+cuKM2aZXIOo9h27kRzBozz1Bfou4C32SWVET0W4VM7ykgig
         F4kFVGyhXN+nCcvNwy+4Fo87+LmmRcAhkTRCN9tBMOKRJeA2w0aNEywMYbBGWbZwfa2V
         Jc1mjfXsz5UWcDQba1FCyc5jtmXgulIIjtprrGPdbZawbNtPC6+x14nLlJBYPNGHxRxH
         X+nmRev7OSqjtLLteH/fslfAn46KdkaDn+SDK1icthm98S5+HJ7m+Z32FyvCyEtvnB2t
         32qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=rtaEMsVUgxkEpbiKW/IF/USL8m9F2ihukaZ79pkCq9I=;
        b=1+GgFJAMjwcTDeYaRUydGj0UslxW6DS7u/XjrnL4P8lQvLODh+JVoRIYcGsjG+S/mP
         dc8sPtMcLH1Ed7N1z3yigWh9zmvYAjXEdDQXmSiR9HVb6fSX5tO8ynJRo8FPgmIAa3bh
         FS19gUEZaI/i9Uc6e65aMVfu5ychUTkkqFXmFgkpW6JYDN7QvC8dO8l1+310vsNsaDQO
         S3MTHxw71/x2ClNFuxgEPiq6PpMhcGIA4PTzLmkScgKgwleD2FYpNrfRpd0eZPA1VbU8
         9aD2e7EYH2/soc7ofQ+lnTpFsVvSibMPMtTNP704BiTh4phqZvySc9RlbeovTE5lZO7v
         DjNA==
X-Gm-Message-State: ACgBeo0IJ9ZN4r1qlpF+ybhyfNlXUcnS5XsFzOI+YrX4f+JyRWTUmBnn
        NxX3cbC7BSeA2tzMDDVkoLwQQgRePA==
X-Google-Smtp-Source: AA6agR73Sy+VVh3pbE8Fb3F5GAchuoB8ByQOwyUn1gZ4RUvfD1b2rHWZBQAjl5Z99T3oBIwnrEepHKeZpg==
X-Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:762:7c61:946f:731])
 (user=timvp job=sendgmr) by 2002:a05:690c:823:b0:339:cd73:5be9 with SMTP id
 by3-20020a05690c082300b00339cd735be9mr11068057ywb.21.1661186792797; Mon, 22
 Aug 2022 09:46:32 -0700 (PDT)
Date:   Mon, 22 Aug 2022 10:46:30 -0600
Message-Id: <20220822104624.v5.1.If155ede36f7d344f15d153d5d75b45c7612bcb8c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5] platform/chrome: cros_ec_lpc: Move host event to prepare/complete
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
index 7677ab3c0ead..5a8f3a3f9c85 100644
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
+static int cros_ec_lpc_complete(struct device *dev)
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
2.37.1.595.g718a3a8f04-goog

