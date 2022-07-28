Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA16583C12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiG1KcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiG1KcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:32:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E82BC86
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:31:59 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ltn326tBqzmVKj
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:30:06 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 18:31:57 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Jul
 2022 18:31:57 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <chenlifu@huawei.com>
Subject: [PATCH v2 -next] genirq: Separate warning messages of enable of suspended irq
Date:   Thu, 28 Jul 2022 18:29:12 +0800
Message-ID: <20220728102912.474772-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both unbalanced enable for irq and enable of suspended irq
print same warning messages, such as:
......
[20220314100142]------------[ cut here ]------------
[20220314100142]WARNING: CPU: 1 PID: 10332 at kernel/irq/manage.c:723 __enable_irq+0x58/0xa4
[20220314100142]Unbalanced enable for IRQ 38
......

It's confusing. Separate the warning messages to make it clear.
No functional changes.

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 kernel/irq/manage.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe7806cc8c..bf4f5f63b2d3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -775,17 +775,19 @@ void disable_nmi_nosync(unsigned int irq)
 
 void __enable_irq(struct irq_desc *desc)
 {
 	switch (desc->depth) {
 	case 0:
- err_out:
 		WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n",
 		     irq_desc_get_irq(desc));
 		break;
 	case 1: {
-		if (desc->istate & IRQS_SUSPENDED)
-			goto err_out;
+		if (desc->istate & IRQS_SUSPENDED) {
+			WARN(1, KERN_WARNING "Enable of suspended IRQ %d\n",
+			     irq_desc_get_irq(desc));
+			break;
+		}
 		/* Prevent probing on this irq: */
 		irq_settings_set_noprobe(desc);
 		/*
 		 * Call irq_startup() not irq_enable() here because the
 		 * interrupt might be marked NOAUTOEN. So irq_startup()
-- 
2.37.0

