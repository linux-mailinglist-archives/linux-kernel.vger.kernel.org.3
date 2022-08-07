Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9C58BB6F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiHGOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiHGOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:55:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F68D9B
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883986; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43gAJLh+NO1r8Oyt6XxRvPraTLloEC1o3eOKZ6oy6Nw=;
        b=B6zlrFb7+LpdkfI9xxOJzHOPp4YViGVmXNLrD9rJ/0ymSiIj5Ktqo+x3WsbaFV/NPbu+F7
        h2jn5hzwWW0QT7/PYPNmVB9TcRSNfYnrcATDi+JmCeyPTvDAi/httHT1jztz+NJByHM4AA
        2l0ou23paU4aIaHhNr9m0c/oddll5sQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 16/28] mfd: tps6586x: Remove #ifdef guards for PM related functions
Date:   Sun,  7 Aug 2022 16:52:35 +0200
Message-Id: <20220807145247.46107-17-paul@crapouillou.net>
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

Use the new pm_sleep_ptr() macro to handle the .irq_set_wake() callback.

This macro allows the mt6397_irq_set_wake() function to be automatically
dropped by the compiler when CONFIG_SUSPEND is disabled, without having
to use #ifdef guards.

The advantage is then that these functions are now always compiled
independently of any Kconfig option, and thanks to that bugs and
regressions are easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/tps6586x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index c9303d3d6602..fd57c3974615 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -269,15 +269,11 @@ static void tps6586x_irq_sync_unlock(struct irq_data *data)
 	mutex_unlock(&tps6586x->irq_lock);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tps6586x_irq_set_wake(struct irq_data *irq_data, unsigned int on)
 {
 	struct tps6586x *tps6586x = irq_data_get_irq_chip_data(irq_data);
 	return irq_set_irq_wake(tps6586x->irq, on);
 }
-#else
-#define tps6586x_irq_set_wake NULL
-#endif
 
 static struct irq_chip tps6586x_irq_chip = {
 	.name = "tps6586x",
@@ -285,7 +281,7 @@ static struct irq_chip tps6586x_irq_chip = {
 	.irq_bus_sync_unlock = tps6586x_irq_sync_unlock,
 	.irq_disable = tps6586x_irq_disable,
 	.irq_enable = tps6586x_irq_enable,
-	.irq_set_wake = tps6586x_irq_set_wake,
+	.irq_set_wake = pm_sleep_ptr(tps6586x_irq_set_wake),
 };
 
 static int tps6586x_irq_map(struct irq_domain *h, unsigned int virq,
-- 
2.35.1

