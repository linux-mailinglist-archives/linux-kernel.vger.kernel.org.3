Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1082E59C501
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiHVR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:28:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD1326C3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:28:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-337ed9110c2so155076887b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=yzjS+LywkTWL8WvWDA7N7t+zpqj6zc8ZGGsibUAWoXc=;
        b=HvLX6cWQF1notA4Yggh9p9vMeoaGyxWp/t/sue/w1EOhy3i1JIiuey4oxPZFoTXNkp
         P0xEOo5gccH+H9j24WUunpcJJ5nNsVe6U4DNlAGPE0q+NLNbItfpCnDKap4y590e6+I0
         DsREykmxLQzMWVi0O7PwTnp3DA05QKKE7r800Ei8eVr5Ku7wtgbvi1cWeHOwiOpzuGMW
         yK9vxeBzvWjVYDcWtWecyxrytUGB4q4rohMIum5MXXtJ+fkmC//pGsypRGYAIK2WKAVr
         DcQCTcMGzB6qMvz+QbE5y+SaivL0FXuiTyYe9IlNd2FR3urGrf1k936KA8QaPa9Y3yZY
         YbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=yzjS+LywkTWL8WvWDA7N7t+zpqj6zc8ZGGsibUAWoXc=;
        b=Nk6/FJDagpUlbmjvOuLwCj6oAXgrR57j/2HmsIho6m03koCWf+deKv/THBk+0s/g8N
         IM4fATn4WUweJ6c68z0F0yMn9SB3guzgd8ISo4r3THSEkbgNqCV57W3Rt7uPo9KEElEb
         PSYBqrJh9Kf2RriuiUUKNLJhaxIs5Pgbc7pgxGZkHjYPcFNOCZva5B4qBcsUPP7Zv/fX
         cqNFc/lquaxq337EIusCokpYaV8AYjCImcSK0MLsX2+bquZKaRcs/No4f/DwnCzYJeKi
         YgagmBYZrWA+ILpdr/mWW4AbHNT4Yug9ogWnFQQnKdazLWfnnPTgOVEc3oNDkQ8BvkcB
         8msg==
X-Gm-Message-State: ACgBeo1LwDFd+k+uYO5499kjYLqejJLloLTdoLxu50TAbXiT52wzSIBY
        YKzh1eygFVk41cbkn3XbM3ajqxVD6A==
X-Google-Smtp-Source: AA6agR5pKK4GPpIqDTf9/ajoMTVtP1y9QH/7kTtaiFafgYADIP+eyPoY+AVJfw7OFW9JT34FZvouDUfvwA==
X-Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:762:7c61:946f:731])
 (user=timvp job=sendgmr) by 2002:a81:7c2:0:b0:335:90cb:1962 with SMTP id
 185-20020a8107c2000000b0033590cb1962mr21509762ywh.173.1661189323446; Mon, 22
 Aug 2022 10:28:43 -0700 (PDT)
Date:   Mon, 22 Aug 2022 11:28:40 -0600
Message-Id: <20220822112832.v6.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v6] platform/chrome: cros_ec_lpc: Move host event to prepare/complete
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

