Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73858CCE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbiHHRnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbiHHRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:42:59 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0BEB51
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980502; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41LrJxU80KiCvA5q7AmgY7aUdotJZRC7pzTXsCNxuuM=;
        b=OFMDW6XQixraFgh45wkJkcmWw2U2iTcQQNvR4jtTMEOpiBzGu6ba1C4sKMONwrc99WaB8p
        PTJznhOEWyJEh/a60sD6o3lKXdeyak2tRXh05TZNJUisy1zXl/X2n9WTDpDhOFUBVFzs1F
        nUgyKmYNHLly57sroFgDlprweg1b2Xs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 08/30] mfd: rc5t583-irq: Remove #ifdef guards for PM related functions
Date:   Mon,  8 Aug 2022 19:40:45 +0200
Message-Id: <20220808174107.38676-9-paul@crapouillou.net>
In-Reply-To: <20220808174107.38676-1-paul@crapouillou.net>
References: <20220808174107.38676-1-paul@crapouillou.net>
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

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/rc5t583-irq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/rc5t583-irq.c b/drivers/mfd/rc5t583-irq.c
index b374a3d34688..621ea61fa7c6 100644
--- a/drivers/mfd/rc5t583-irq.c
+++ b/drivers/mfd/rc5t583-irq.c
@@ -228,15 +228,12 @@ static void rc5t583_irq_sync_unlock(struct irq_data *irq_data)
 
 	mutex_unlock(&rc5t583->irq_lock);
 }
-#ifdef CONFIG_PM_SLEEP
+
 static int rc5t583_irq_set_wake(struct irq_data *irq_data, unsigned int on)
 {
 	struct rc5t583 *rc5t583 = irq_data_get_irq_chip_data(irq_data);
 	return irq_set_irq_wake(rc5t583->chip_irq, on);
 }
-#else
-#define rc5t583_irq_set_wake NULL
-#endif
 
 static irqreturn_t rc5t583_irq(int irq, void *data)
 {
@@ -317,7 +314,7 @@ static struct irq_chip rc5t583_irq_chip = {
 	.irq_bus_lock = rc5t583_irq_lock,
 	.irq_bus_sync_unlock = rc5t583_irq_sync_unlock,
 	.irq_set_type = rc5t583_irq_set_type,
-	.irq_set_wake = rc5t583_irq_set_wake,
+	.irq_set_wake = pm_sleep_ptr(rc5t583_irq_set_wake),
 };
 
 int rc5t583_irq_init(struct rc5t583 *rc5t583, int irq, int irq_base)
-- 
2.35.1

