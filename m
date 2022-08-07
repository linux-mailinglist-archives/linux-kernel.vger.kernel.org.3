Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844858BB78
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiHGO5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbiHGO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:56:32 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535EB1FA
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883988; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+c3KkknlLtwUBDEYtG1+TT7sAqGqh7aGNoFQtGPxwY=;
        b=LgE+N5Y8fnH6/Eby5wJnHx3/lB0wa8IBVwI7LmvEz9hJwlzNEZSf+IOOlx++OIWNiHgZqq
        JV1QCdVCezRgKWNQzI8hBVrFp+HRjKvQOmbpQ0gwOudUQp/goGTQprr9IEUL+ii+V9d85K
        XrHtlNr6EhWv7jiql6PwM+orprfsutw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 24/28] mfd: sprd-sc27xx: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:43 +0200
Message-Id: <20220807145247.46107-25-paul@crapouillou.net>
In-Reply-To: <20220807145247.46107-1-paul@crapouillou.net>
References: <20220807145247.46107-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
to handle the .suspend/.resume callbacks.

These macros allow the suspend and resume functions to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

The advantage is then that these functions are now always compiled
independently of any Kconfig option, and thanks to that bugs and
regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index d05a47c5187f..ea68d73e5d1c 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -215,7 +215,6 @@ static int sprd_pmic_probe(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sprd_pmic_suspend(struct device *dev)
 {
 	struct sprd_pmic *ddata = dev_get_drvdata(dev);
@@ -235,9 +234,9 @@ static int sprd_pmic_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops,
+				sprd_pmic_suspend, sprd_pmic_resume);
 
 static const struct of_device_id sprd_pmic_match[] = {
 	{ .compatible = "sprd,sc2730", .data = &sc2730_data },
@@ -257,7 +256,7 @@ static struct spi_driver sprd_pmic_driver = {
 	.driver = {
 		.name = "sc27xx-pmic",
 		.of_match_table = sprd_pmic_match,
-		.pm = &sprd_pmic_pm_ops,
+		.pm = pm_sleep_ptr(&sprd_pmic_pm_ops),
 	},
 	.probe = sprd_pmic_probe,
 	.id_table = sprd_pmic_spi_ids,
-- 
2.35.1

