Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F2951A523
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353200AbiEDQTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353222AbiEDQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA046678
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:10 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7/awrMq8ptHu515E06FSFVcsH5aRD5n1ud0J2jAhGo=;
        b=iWPgQHzJIxlk+ssLKRcIkS1dU9HvYTcPk7Oc29RqbUC981nXOZh61Zp91b1BhGwppZc/0k
        FN2ErxxlBgYOvbHIzE1bvAfYYZORUznsl8/gQ8T5qQFvmmGHuGGWtwrYiE33V0Q4VQFvr0
        i9kVNg+1Q2WspxvIYpLQOLki56DAqgH2r36fNPqHOlG6yFopRqbGGo7oBWptDXJhUxg338
        9Ny/jqnlCG6z9RwpvXvME+BoE9ncydGVVX/dFVGVmH5eaBU8olBYTIp61xll8KYh6HQrNG
        g2e/WaiQs4VvCjJ/GmmXDysYCyI9KCHbPVFyAJOirKhoUPiq69gFMhmJihaCMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680909;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B7/awrMq8ptHu515E06FSFVcsH5aRD5n1ud0J2jAhGo=;
        b=x+XO0WDOIhePhx9Azie1fcRRGWBIVeqTImgoezh3Dfd8vnosJnkDKkzQCTiXhNDU/eXwUV
        LanxLrtNcthJvCDw==
From:   "irqchip-bot for Lucas Stach" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/imx-irqsteer: Add runtime PM support
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220406163701.1277930-2-l.stach@pengutronix.de>
References: <20220406163701.1277930-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Message-ID: <165168090796.4207.16097445461269415468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4730d2233311d86cad9dc510318d1b40e4b53cf2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4730d2233311d86cad9dc510318d1b40e4b53cf2
Author:        Lucas Stach <l.stach@pengutronix.de>
AuthorDate:    Wed, 06 Apr 2022 18:37:01 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:44:51 +01:00

irqchip/imx-irqsteer: Add runtime PM support

There are now SoCs that integrate the irqsteer controller within
a separate power domain. In order to allow this domain to be
powered down when not needed, add runtime PM support to the driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220406163701.1277930-2-l.stach@pengutronix.de
---
 drivers/irqchip/irq-imx-irqsteer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index e286e7c..96230a0 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
@@ -175,7 +176,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	data->irq_count = DIV_ROUND_UP(irqs_num, 64);
 	data->reg_num = irqs_num / 32;
 
-	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+	if (IS_ENABLED(CONFIG_PM)) {
 		data->saved_reg = devm_kzalloc(&pdev->dev,
 					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
@@ -199,6 +200,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto out;
 	}
+	irq_domain_set_pm_device(data->domain, &pdev->dev);
 
 	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
 		ret = -EINVAL;
@@ -219,6 +221,9 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 out:
 	clk_disable_unprepare(data->ipg_clk);
@@ -241,7 +246,7 @@ static int imx_irqsteer_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 static void imx_irqsteer_save_regs(struct irqsteer_data *data)
 {
 	int i;
@@ -288,7 +293,10 @@ static int imx_irqsteer_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops imx_irqsteer_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_irqsteer_suspend, imx_irqsteer_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx_irqsteer_suspend,
+			   imx_irqsteer_resume, NULL)
 };
 
 static const struct of_device_id imx_irqsteer_dt_ids[] = {
