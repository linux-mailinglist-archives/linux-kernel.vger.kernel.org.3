Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893E56806A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiGFHoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiGFHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:44:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A77237D8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657093448; x=1688629448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qKkHo7U93i0xJGO/erKhvmEQKF0npn2IZsa8m4BvJe4=;
  b=nParLiFyuWaSr2TKP9Z9+49/+tEEZe5iepOJKvqLZFdCkxM+2NKTBWYQ
   GfGvbghU3ox13GiS2oWVBC5MYRzjPnXB6LPa1H45oocqE6Ce2UqxgM3NM
   vF+7f3rxxbYBcPstqTUt8NbZQZy9VyQBr4lQ5prxoCKXxu8LkQdRJMvjp
   pJysfeajchovaueKwc1amZl0lJiLvpPf7gUHd6CvfA3oZ72aaIqrfHS+T
   iE4NDX2sQbVTaM3YEoDX+mpbKKTTLMS8IUdGIFwAR6mD8c0LgXAI5StfB
   R8SfiY3qiQo0/Ywuq8tlCu8ACDnNqsB7BITlwzlDiyEpRLzOr85beyF8g
   g==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="171229271"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 00:44:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 00:44:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 6 Jul 2022 00:44:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] irqchip/atmel-aic: remove #ifdef CONFIG_PM
Date:   Wed, 6 Jul 2022 10:46:29 +0300
Message-ID: <20220706074630.829607-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #ifdef CONFIG_PM around aic_suspend() function. Coding style
recommends (at chapter Conditional Compilation) to avoid using
preprocessor conditional in .c files.
gc->chip_types->chip.irq_suspend()/gc->chip_types->chip.irq_resume() is
called in irq_gc_suspend()/irq_gc_resume() which is NULL in case CONFIG_PM
is not defined. With this gc->chip_types->chip.irq_pm_shutdown is
populated all the time as it should be as irq_gc_shutdown() is not
conditioned by CONFIG_PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/irqchip/irq-atmel-aic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 4631f6847953..02a9f45a7d2e 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -102,7 +102,6 @@ static int aic_set_type(struct irq_data *d, unsigned type)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static void aic_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
@@ -132,11 +131,6 @@ static void aic_pm_shutdown(struct irq_data *d)
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_ICCR);
 	irq_gc_unlock(gc);
 }
-#else
-#define aic_suspend		NULL
-#define aic_resume		NULL
-#define aic_pm_shutdown		NULL
-#endif /* CONFIG_PM */
 
 static void __init aic_hw_init(struct irq_domain *domain)
 {
-- 
2.34.1

