Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39A2569E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiGGIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiGGIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:50:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F914326D7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:50:04 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657183803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RBtZzfLYOb4jPoClv0jPGkdLfcJHGv+0mwynAdY2cg=;
        b=UOYAhGQd+YIdFuTdNkjOkcq/heFkjNY4c2fBFfYZQgDpgI5OvHmGTdDTpSimhx3r9urtHT
        +vR3KGSKHK8cbRXNx09k7p3xQReXMeVJcPQV7Mkn5DAV/AWWoVrO5534120bM5YQ+4ANAV
        tkNOTr1oHL90GMMHZCkfeg7PEOAebJXkq2Tu3ucT4kMKZ0gJFq/VRBt9u6H4ThVEHVgcfD
        4YeFvk0KebHmqFBUuG9mRbMe+LWQrEIfYcNgw5Qj8tqI88fp9c/x1ThwWVn0LMGO6nCqDv
        q5j2nMPeVkuQ/dCYlXhn6rUN9EdpIBmy24QDsW3gIZOgWA/IESFhaNzUxpG//Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657183803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RBtZzfLYOb4jPoClv0jPGkdLfcJHGv+0mwynAdY2cg=;
        b=SHDsf+Z0AwP0OEVCRKpckHy0VKNscmSyBJtuGGXrXJy++/tCAUz9D2xePsk3dYpi8u5vlE
        8uyusl2jXYs0PPDg==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Add and use an
 irq_data_update_affinity helper
Cc:     Samuel Holland <samuel@sholland.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220701200056.46555-7-samuel@sholland.org>
References: <20220701200056.46555-7-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165718380207.15455.13488510423496954619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     073352e951f60946452da358d64841066c3142ff
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/073352e951f60946452da358d64841066c3142ff
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Fri, 01 Jul 2022 15:00:54 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:38:04 +01:00

genirq: Add and use an irq_data_update_affinity helper

Some architectures and irqchip drivers modify the cpumask returned by
irq_data_get_affinity_mask, usually by copying in to it. This is
problematic for uniprocessor configurations, where the affinity mask
should be constant, as it is known at compile time.

Add and use a setter for the affinity mask, following the pattern of
irq_data_update_effective_affinity. This allows the getter function to
return a const cpumask pointer.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> # Xen bits
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701200056.46555-7-samuel@sholland.org
---
 arch/alpha/kernel/irq.c          | 2 +-
 arch/ia64/kernel/iosapic.c       | 2 +-
 arch/ia64/kernel/irq.c           | 4 ++--
 arch/ia64/kernel/msi_ia64.c      | 4 ++--
 arch/parisc/kernel/irq.c         | 2 +-
 drivers/irqchip/irq-bcm6345-l1.c | 4 ++--
 drivers/parisc/iosapic.c         | 2 +-
 drivers/sh/intc/chip.c           | 2 +-
 drivers/xen/events/events_base.c | 7 ++++---
 include/linux/irq.h              | 6 ++++++
 10 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index f6d2946..15f2eff 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -60,7 +60,7 @@ int irq_select_affinity(unsigned int irq)
 		cpu = (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
 	last_cpu = cpu;
 
-	cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
+	irq_data_update_affinity(data, cpumask_of(cpu));
 	chip->irq_set_affinity(data, cpumask_of(cpu), false);
 	return 0;
 }
diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index 35adcf8..9930085 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -834,7 +834,7 @@ iosapic_unregister_intr (unsigned int gsi)
 	if (iosapic_intr_info[irq].count == 0) {
 #ifdef CONFIG_SMP
 		/* Clear affinity */
-		cpumask_setall(irq_get_affinity_mask(irq));
+		irq_data_update_affinity(irq_get_irq_data(irq), cpu_all_mask);
 #endif
 		/* Clear the interrupt information */
 		iosapic_intr_info[irq].dest = 0;
diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index ecef17c..275b9ea 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -57,8 +57,8 @@ static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
 void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
 {
 	if (irq < NR_IRQS) {
-		cpumask_copy(irq_get_affinity_mask(irq),
-			     cpumask_of(cpu_logical_id(hwid)));
+		irq_data_update_affinity(irq_get_irq_data(irq),
+					 cpumask_of(cpu_logical_id(hwid)));
 		irq_redir[irq] = (char) (redir & 0xff);
 	}
 }
diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
index df5c28f..025e513 100644
--- a/arch/ia64/kernel/msi_ia64.c
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -37,7 +37,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
 	msg.data = data;
 
 	pci_write_msi_msg(irq, &msg);
-	cpumask_copy(irq_data_get_affinity_mask(idata), cpumask_of(cpu));
+	irq_data_update_affinity(idata, cpumask_of(cpu));
 
 	return 0;
 }
@@ -132,7 +132,7 @@ static int dmar_msi_set_affinity(struct irq_data *data,
 	msg.address_lo |= MSI_ADDR_DEST_ID_CPU(cpu_physical_id(cpu));
 
 	dmar_msi_write(irq, &msg);
-	cpumask_copy(irq_data_get_affinity_mask(data), mask);
+	irq_data_update_affinity(data, mask);
 
 	return 0;
 }
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 0fe2d79..5ebb177 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -315,7 +315,7 @@ unsigned long txn_affinity_addr(unsigned int irq, int cpu)
 {
 #ifdef CONFIG_SMP
 	struct irq_data *d = irq_get_irq_data(irq);
-	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(cpu));
+	irq_data_update_affinity(d, cpumask_of(cpu));
 #endif
 
 	return per_cpu(cpu_data, cpu).txn_addr;
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 142a743..6899e37 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -216,11 +216,11 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
 		enabled = intc->cpus[old_cpu]->enable_cache[word] & mask;
 		if (enabled)
 			__bcm6345_l1_mask(d);
-		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+		irq_data_update_affinity(d, dest);
 		if (enabled)
 			__bcm6345_l1_unmask(d);
 	} else {
-		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+		irq_data_update_affinity(d, dest);
 	}
 	raw_spin_unlock_irqrestore(&intc->lock, flags);
 
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 8a3b0c3..3a8c986 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -677,7 +677,7 @@ static int iosapic_set_affinity_irq(struct irq_data *d,
 	if (dest_cpu < 0)
 		return -1;
 
-	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(dest_cpu));
+	irq_data_update_affinity(d, cpumask_of(dest_cpu));
 	vi->txn_addr = txn_affinity_addr(d->irq, dest_cpu);
 
 	spin_lock_irqsave(&iosapic_lock, flags);
diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
index 358df75..828d81e 100644
--- a/drivers/sh/intc/chip.c
+++ b/drivers/sh/intc/chip.c
@@ -72,7 +72,7 @@ static int intc_set_affinity(struct irq_data *data,
 	if (!cpumask_intersects(cpumask, cpu_online_mask))
 		return -1;
 
-	cpumask_copy(irq_data_get_affinity_mask(data), cpumask);
+	irq_data_update_affinity(data, cpumask);
 
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 46d9295..5e8321f 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -528,9 +528,10 @@ static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
 	BUG_ON(irq == -1);
 
 	if (IS_ENABLED(CONFIG_SMP) && force_affinity) {
-		cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
-		cpumask_copy(irq_get_effective_affinity_mask(irq),
-			     cpumask_of(cpu));
+		struct irq_data *data = irq_get_irq_data(irq);
+
+		irq_data_update_affinity(data, cpumask_of(cpu));
+		irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	}
 
 	xen_evtchn_port_bind_to_cpu(evtchn, cpu, info->cpu);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 69ee4e2..adcfebc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -884,6 +884,12 @@ static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 	return d->common->affinity;
 }
 
+static inline void irq_data_update_affinity(struct irq_data *d,
+					    const struct cpumask *m)
+{
+	cpumask_copy(d->common->affinity, m);
+}
+
 static inline struct cpumask *irq_get_affinity_mask(int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
