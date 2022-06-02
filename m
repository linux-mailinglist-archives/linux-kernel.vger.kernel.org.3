Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD4F53B7BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiFBL0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiFBL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:26:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E362AA9B0;
        Thu,  2 Jun 2022 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654169175; x=1685705175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cgfuRmHrTeFqvcYBq0C9Iw5AXdUXD14yLAeaLC+r37o=;
  b=XcU1xzNhsHK1uIGmtYRoGBUcf/Qr1G/r2xDKL1V056oN2l6YOiIHAIce
   bmLRId8RZNYc/YKO3PFSXp4GLCbSyYLr+UUVg2lB6CXNyAfpntEy/6/9V
   NU4JsjD8zzfeactrDURiukZ+JYje4Oy0id8pKkW1ttvzV1mHMZSC+bygt
   OcyPqKGREO6iqgeVfv6rv4fn1KVhaL1TEYYr1xc3kQN/uGj0cLXtWbE0U
   7zM/sZKhX8ngFKRPmtygFV2LNYrA0K+b6N4bcUkIdgn8x3QfVEqo3hl2t
   zZQLkEfel1fs6MyqHQHCLtSfH2XxLcfFrQ4Tkp5rlPJI1Aen9oswz5xBB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="256396926"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="256396926"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 04:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="634005648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2022 04:26:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9328DF8; Thu,  2 Jun 2022 14:26:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/3] gpio: crystalcove: Use specific type and API for IRQ number
Date:   Thu,  2 Jun 2022 14:26:00 +0300
Message-Id: <20220602112601.12010-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602112601.12010-1-andriy.shevchenko@linux.intel.com>
References: <20220602112601.12010-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use specific type and API for IRQ number in the callbacks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/gpio/gpio-crystalcove.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index cf33041533aa..36870d14323f 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -188,8 +188,9 @@ static int crystalcove_irq_type(struct irq_data *data, unsigned int type)
 {
 	struct crystalcove_gpio *cg =
 		gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
-	if (data->hwirq >= CRYSTALCOVE_GPIO_NUM)
+	if (hwirq >= CRYSTALCOVE_GPIO_NUM)
 		return 0;
 
 	switch (type) {
@@ -226,12 +227,12 @@ static void crystalcove_bus_sync_unlock(struct irq_data *data)
 {
 	struct crystalcove_gpio *cg =
 		gpiochip_get_data(irq_data_get_irq_chip_data(data));
-	int gpio = data->hwirq;
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
 
 	if (cg->update & UPDATE_IRQ_TYPE)
-		crystalcove_update_irq_ctrl(cg, gpio);
+		crystalcove_update_irq_ctrl(cg, hwirq);
 	if (cg->update & UPDATE_IRQ_MASK)
-		crystalcove_update_irq_mask(cg, gpio);
+		crystalcove_update_irq_mask(cg, hwirq);
 	cg->update = 0;
 
 	mutex_unlock(&cg->buslock);
-- 
2.35.1

