Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DEE5A335F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 03:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiH0BP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiH0BPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:15:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747AF7A74E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:15:50 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDzFV4WJPz1N7YB;
        Sat, 27 Aug 2022 09:12:14 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 09:15:47 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <tglx@linutronix.de>, <frederic@kernel.org>,
        <peterz@infradead.org>, <nitesh@redhat.com>,
        <bigeasy@linutronix.de>, <douliyangs@gmail.com>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>, <xuqiang36@huawei.com>
Subject: [PATCH -next 1/3] genirq/affinity: replace managed with is_managed in irq_affinity_desc
Date:   Sat, 27 Aug 2022 01:13:49 +0000
Message-ID: <20220827011351.9185-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This submission is based on the following two considerations:

1. The definition of is_managed field is misleading to assume
   that it only uses 1 bit of memory, which is not the case;
2. from the actual use of is_managed, it should be a Boolean type;

Fixes: c410abbbacb9 (“genirq/affinity: Add is_managed to struct irq_affinity_desc”)
Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 include/linux/interrupt.h | 4 ++--
 kernel/irq/affinity.c     | 2 +-
 kernel/irq/irqdesc.c      | 2 +-
 kernel/irq/manage.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..9fb36545c8b2 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -294,11 +294,11 @@ struct irq_affinity {
 /**
  * struct irq_affinity_desc - Interrupt affinity descriptor
  * @mask:	cpumask to hold the affinity assignment
- * @is_managed: 1 if the interrupt is managed internally
+ * @managed:	true if the interrupt is managed internally
  */
 struct irq_affinity_desc {
 	struct cpumask	mask;
-	unsigned int	is_managed : 1;
+	bool		managed;
 };
 
 #if defined(CONFIG_SMP)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d9a5c1d65a79..2a9fef1713df 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -483,7 +483,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 
 	/* Mark the managed interrupts */
 	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
-		masks[i].is_managed = 1;
+		masks[i].managed = true;
 
 	return masks;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5db0230aa6b5..8388b821e58b 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -486,7 +486,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		unsigned int flags = 0;
 
 		if (affinity) {
-			if (affinity->is_managed) {
+			if (affinity->managed) {
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe7806cc8c..c3423f552e0b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -431,7 +431,7 @@ int irq_update_affinity_desc(unsigned int irq,
 	if (activated)
 		irq_domain_deactivate_irq(&desc->irq_data);
 
-	if (affinity->is_managed) {
+	if (affinity->managed) {
 		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
 		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
 	}
-- 
2.17.1

