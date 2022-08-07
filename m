Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7541158BB5E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiHGOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiHGOxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:53:42 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB205A461
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883981; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kpn39KorDFOqH9PIAfsq4TNql93fwh4pKumyo2NZK3k=;
        b=bQa3hvVg2oiDma8ImHf+Rl0gUDoBzKonkQtuZDhzsawMMZDwWchTyglysi6ZzqLodaoiUU
        hae1zID3mHBIeX2YXhOycUcIPHSPsJEAFslAHEnoYxlc7XzNGe5B562ggPF75kjOmmoOBI
        0iHUf7TvE91ucKOirUI2p7f3iNTjzDQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 04/28] mfd: max8925-i2c: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:23 +0200
Message-Id: <20220807145247.46107-5-paul@crapouillou.net>
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
---
 drivers/mfd/max8925-i2c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 114e905bef25..649310b5bb3e 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -208,7 +208,6 @@ static int max8925_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max8925_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -228,9 +227,9 @@ static int max8925_resume(struct device *dev)
 		disable_irq_wake(chip->core_irq);
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(max8925_pm_ops, max8925_suspend, max8925_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(max8925_pm_ops,
+				max8925_suspend, max8925_resume);
 
 static const struct of_device_id max8925_dt_ids[] = {
 	{ .compatible = "maxim,max8925", },
@@ -240,7 +239,7 @@ static const struct of_device_id max8925_dt_ids[] = {
 static struct i2c_driver max8925_driver = {
 	.driver	= {
 		.name	= "max8925",
-		.pm     = &max8925_pm_ops,
+		.pm     = pm_sleep_ptr(&max8925_pm_ops),
 		.of_match_table = max8925_dt_ids,
 	},
 	.probe		= max8925_probe,
-- 
2.35.1

