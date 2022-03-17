Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399A4DBD7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiCQDWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCQDWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:22:46 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53092559B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:21:28 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 11:21:28 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 11:21:26 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <guoren@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] irqchip: Return true/false (not 1/0) from bool functions
Date:   Thu, 17 Mar 2022 11:21:24 +0800
Message-ID: <1647487284-30088-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/irqchip/irq-csky-apb-intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index d36f536..42d8a24 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -136,11 +136,11 @@ static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
 				     u32 irq_base)
 {
 	if (hwirq == 0)
-		return 0;
+		return false;
 
 	generic_handle_domain_irq(root_domain, irq_base + __fls(hwirq));
 
-	return 1;
+	return true;
 }
 
 /* gx6605s 64 irqs interrupt controller */
-- 
2.7.4

