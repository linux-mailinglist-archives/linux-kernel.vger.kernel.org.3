Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13D14F6CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiDFVkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbiDFViV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:38:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E526141DB6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:57:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so4877399ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmyOlWKtSNxj3DWsfduxZVZU5wGOGPxKyvHvnTz6lcI=;
        b=jq7jeMYa1/GWNQdm7SpRK9Xvt9vCIu2PnkTUcUEhDN34fqe8A1mwBwZbQpRoVisRQk
         bFNscfrmInpYye5WJvFEAB0/cDGkv2uaKerUby43BamFasp0304fBfSOwFXNB85SDP6X
         6MZEi480XiupbZ6uw1oGqX/NJ4IMuKzpDnjxrsEo6e11UCbZTHhkb6hoDvTeNN45MKmN
         rCI5Fe7l4au7J5uZWduHjBOQjW++4F7r9A9Tx/lipjSwToZzpZhVGgfBt6NrBKAVvQym
         V6qW9bScNq3LR6f8VDqy4g3BhP+ZZx2aBhMZKOAjzgUjbQFRREvDHX42uU2HVWeEciXz
         TGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmyOlWKtSNxj3DWsfduxZVZU5wGOGPxKyvHvnTz6lcI=;
        b=XoVtz+EshjnzgmUUHFOA2p+HyZIIqINxSGs4klPpfPBJix/5MilSXH+hN8PQoWUmoD
         7/KH9ZKnhczMgckZuZrtgihxHMTGzuZsK44pieaw/reSQ12nsQouAWBSSk/SALsiow6M
         lQIp7TnzDttt1lyq4NGTEa52IgNSaAW2YAchihsjnqR6VpXoDpuiat+LP4tiYOZ0H9zk
         ftFxm1I1/VUtaqJWc3tq6TVxq59CO3sgLJijt3XpeUR8jDFPMY1z875n1WOnMrLQh6tN
         3akDxRL4vXQnyjvhuIm1+N0xoi+veKltRg6cQ4hSKxcfePImmnLkTaJgvpIafn9uPi9S
         QjEg==
X-Gm-Message-State: AOAM531quVOz3it2jl7peSg9VcOlRrmDNjVN2EOVk41xJKY95DoikxBh
        1so0b/7As5hQylJCOhAenym1Xg==
X-Google-Smtp-Source: ABdhPJykjllUjWrbBsbw9MgTMptQWUmRwtV9PhKiS1HBV5kr4L/Yq3KlfOAlxjrC6M1nHBmpsq2SLw==
X-Received: by 2002:a2e:bf1d:0:b0:247:dea7:f657 with SMTP id c29-20020a2ebf1d000000b00247dea7f657mr6468467ljr.454.1649278636823;
        Wed, 06 Apr 2022 13:57:16 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t19-20020a19dc13000000b0044b022fd9f1sm1246586lfg.160.2022.04.06.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:57:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] clocksource/drivers/ixp4xx: Drop boardfile probe path
Date:   Wed,  6 Apr 2022 22:55:05 +0200
Message-Id: <20220406205505.2332821-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boardfiles for IXP4xx have been deleted. Delete all the
quirks and code dealing with that boot path and rely solely on
device tree boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/Kconfig                |  2 +-
 drivers/clocksource/timer-ixp4xx.c         | 25 ----------------------
 include/linux/platform_data/timer-ixp4xx.h | 11 ----------
 3 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 include/linux/platform_data/timer-ixp4xx.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1589ae7d5abb..8182ff2d12fe 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -80,7 +80,7 @@ config IXP4XX_TIMER
 	bool "Intel XScale IXP4xx timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select CLKSRC_MMIO
-	select TIMER_OF if OF
+	select TIMER_OF
 	help
 	  Enables support for the Intel XScale IXP4xx SoC timer.
 
diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
index cbb184953510..720ed70a2964 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -19,8 +19,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
-/* Goes away with OF conversion */
-#include <linux/platform_data/timer-ixp4xx.h>
 
 /*
  * Constants to make it easy to access Timer Control/Status registers
@@ -263,28 +261,6 @@ static struct platform_driver ixp4xx_timer_driver = {
 };
 builtin_platform_driver(ixp4xx_timer_driver);
 
-/**
- * ixp4xx_timer_setup() - Timer setup function to be called from boardfiles
- * @timerbase: physical base of timer block
- * @timer_irq: Linux IRQ number for the timer
- * @timer_freq: Fixed frequency of the timer
- */
-void __init ixp4xx_timer_setup(resource_size_t timerbase,
-			       int timer_irq,
-			       unsigned int timer_freq)
-{
-	void __iomem *base;
-
-	base = ioremap(timerbase, 0x100);
-	if (!base) {
-		pr_crit("IXP4xx: can't remap timer\n");
-		return;
-	}
-	ixp4xx_timer_register(base, timer_irq, timer_freq);
-}
-EXPORT_SYMBOL_GPL(ixp4xx_timer_setup);
-
-#ifdef CONFIG_OF
 static __init int ixp4xx_of_timer_init(struct device_node *np)
 {
 	void __iomem *base;
@@ -315,4 +291,3 @@ static __init int ixp4xx_of_timer_init(struct device_node *np)
 	return ret;
 }
 TIMER_OF_DECLARE(ixp4xx, "intel,ixp4xx-timer", ixp4xx_of_timer_init);
-#endif
diff --git a/include/linux/platform_data/timer-ixp4xx.h b/include/linux/platform_data/timer-ixp4xx.h
deleted file mode 100644
index ee92ae7edaed..000000000000
--- a/include/linux/platform_data/timer-ixp4xx.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TIMER_IXP4XX_H
-#define __TIMER_IXP4XX_H
-
-#include <linux/ioport.h>
-
-void __init ixp4xx_timer_setup(resource_size_t timerbase,
-			       int timer_irq,
-			       unsigned int timer_freq);
-
-#endif
-- 
2.35.1

