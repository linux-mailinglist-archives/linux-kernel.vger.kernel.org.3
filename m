Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B035656806B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiGFHoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGFHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:44:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BD2DC6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657093451; x=1688629451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFYssEOqQQ+BQQUBnZ5+qyOVdKd7T65+VE37vRgnlK4=;
  b=UatuhbJEa2QOAxOOD/kXKs+GJB1FdrkuK8ciZaL+k1W480uWwxbrovSE
   EIhs4p/NOeUsPTC2DjoOPXHQZgvz3r3XjX9COdo0lL8wsEHB2ljdbSvsw
   cAJcGjDN7Jl0BqrLoYM4hlG/idr/609jzkJoJy64vDQS4Om0S8z0NRzuR
   lP3rSGy/MUAot3Bk+J1MkOP3xiEHVSchxKayhWJS0XwjOrJO83FICkas3
   lUUpQq5sfaIPaJY2bcleI5uyOa3TMnlchbpB73xfCKQKQ9r/kvWdGxg0B
   ee2rw+hC0JyR/+5VxWSykDJ4FULr8K7eK3qoVZU3FhUGhkbqHk6oKqnbH
   A==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="166576966"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 00:44:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 00:44:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 6 Jul 2022 00:44:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/2] irqchip/atmel-aic5: remove #ifdef CONFIG_PM
Date:   Wed, 6 Jul 2022 10:46:30 +0300
Message-ID: <20220706074630.829607-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220706074630.829607-1-claudiu.beznea@microchip.com>
References: <20220706074630.829607-1-claudiu.beznea@microchip.com>
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

Remove #ifdef CONFIG_PM around aic5_suspend() function and from
aic5_hw_init() function. Coding style recommends (at chapter Conditional
Compilation) to avoid using preprocessor conditional in .c files.
gc->chip_types->chip.irq_suspend()/gc->chip_types->chip.irq_resume() is
called in irq_gc_suspend()/irq_gc_resume() which is NULL in case CONFIG_PM
is not defined. With this gc->chip_types->chip.irq_pm_shutdown is
populated all the time as it should be as irq_gc_shutdown() is not
conditioned by CONFIG_PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/irqchip/irq-atmel-aic5.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535bd7560..890df0cf57d6 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -149,7 +149,6 @@ static int aic5_set_type(struct irq_data *d, unsigned type)
 	return ret;
 }
 
-#ifdef CONFIG_PM
 static u32 *smr_cache;
 
 static void aic5_suspend(struct irq_data *d)
@@ -234,11 +233,6 @@ static void aic5_pm_shutdown(struct irq_data *d)
 	}
 	irq_gc_unlock(bgc);
 }
-#else
-#define aic5_suspend		NULL
-#define aic5_resume		NULL
-#define aic5_pm_shutdown	NULL
-#endif /* CONFIG_PM */
 
 static void __init aic5_hw_init(struct irq_domain *domain)
 {
@@ -369,12 +363,10 @@ static int __init aic5_of_init(struct device_node *node,
 static int __init sama5d2_aic5_of_init(struct device_node *node,
 				       struct device_node *parent)
 {
-#ifdef CONFIG_PM
 	smr_cache = kcalloc(DIV_ROUND_UP(NR_SAMA5D2_IRQS, 32) * 32,
 			    sizeof(*smr_cache), GFP_KERNEL);
 	if (!smr_cache)
 		return -ENOMEM;
-#endif
 
 	return aic5_of_init(node, parent, NR_SAMA5D2_IRQS);
 }
-- 
2.34.1

