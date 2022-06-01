Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1375D53A9A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354955AbiFAPHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354963AbiFAPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:05:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2E56D196;
        Wed,  1 Jun 2022 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654095896; x=1685631896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZyrxPk/I084gSJFG7JZq6Z4iA6d08Wm2lxWibV0UvV0=;
  b=iiZAM+pwKSJXvG5qupdLfEyaBrrKUhgw4PdMFxu+8RYszZMvaJnuOZUm
   rfIgpkjla7IGNp4h6ODEa0C8/obziF0Y86eK3qbATuFljjjkuqkjaa4IA
   HpbkWM2HnbaVnTVAnXeEn76nUb0YHaI+6aw9P9yBE1XsrUNc7O89fbHyv
   3PHwRtKj8kfvtyd/LI5o/z8h8AmAc0WVeX6MjH14LW71wrlWMZFWV7Ofs
   E6VuV3s5m34NdHnXIlCYiub9Dv69iLMgcbT0JhNAXLt4A9dFkIO/EaqS3
   lFIRWnNpnZIo1N3QZNs7LMQ61yGoXi5HMZKoQWnw9UDm7FiwvBjJqcSrm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257687423"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="257687423"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 08:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="552349785"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2022 08:04:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EDFB849; Wed,  1 Jun 2022 18:04:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/3] gpio: crystalcove: Use specific type and API for IRQ number
Date:   Wed,  1 Jun 2022 18:04:45 +0300
Message-Id: <20220601150446.25866-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
References: <20220601150446.25866-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use specific type and API for IRQ number in the callbacks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-crystalcove.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index f40d3b133527..d4d01e734e22 100644
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

