Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F98576887
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiGOUwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGOUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:52:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B62558E4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657918320; x=1689454320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sQXlsF0dU0h7TKwhfyBx9K7vKWjShXkwHIUD/Ch8sf8=;
  b=TqUr4fDaCbDlvVUOHsbrYsQt8+Y8wjODPoHbZaZVZF7DlY8rM+CLRTAl
   rJTXXBS+nHqKofhJn3WVXW86PL7A+cqx6njs8pHZA20kCJt2962b2GcAl
   +FjlVI6jtBdHuYoOii7pxjlzhc/BUK3zh2kKVdHsOJ5s4SY+zL3DVaOs8
   RvpO3qVsnAQyavyCuCoPXJCNJQlE2rfwiEh6ZloETL3dY9A0KCvDY9mki
   GfSEMqXbGFMwruPL9VjcBKwphimtNw5bzuPxkrZJC1OLEyC7sIpseHhsA
   a6CjbA4gxjfM9SAfVZf6nddrFsSSmzfbRefdNjWEIUa4Fo5wqKU8zlwgV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="372212158"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="372212158"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 13:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="654494812"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2022 13:51:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC51A1A0; Fri, 15 Jul 2022 23:52:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] irqchip/stm32-exti: Use INVALID_HWIRQ definition
Date:   Fri, 15 Jul 2022 23:52:03 +0300
Message-Id: <20220715205203.82591-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use specific definition for invalid IRQ. It makes the
code uniform in respect to the constant used for that.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/irqchip/irq-stm32-exti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index a73763d475f0..a6ae9f38aaf0 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -170,7 +170,7 @@ static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
 static struct irq_chip stm32_exti_h_chip;
 static struct irq_chip stm32_exti_h_chip_direct;
 
-#define EXTI_INVALID_IRQ       U8_MAX
+#define EXTI_INVALID_IRQ       ((u8)INVALID_HWIRQ)
 #define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
 
 static const u8 stm32mp1_desc_irq[] = {
-- 
2.35.1

