Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6117477321
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhLPNaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:30:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54546 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbhLPNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:30:12 -0500
Date:   Thu, 16 Dec 2021 13:30:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639661411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VD+GiwMtVHizkJquBtRoVZe2ruoG7hIk5DncvKcmPGg=;
        b=w/Z306yjk3wrrWnXCM4fn0J7YmVZd2OXciOlJZl0dpULxC1b4eFaA3lzkeOmjZeJcZD+gy
        u7iN+9NPrHKyaHz2zrS/s99ab8akNuVQVIkjrOeuOC6q271mO3Emmmu7H/XlrbXCXpjlIC
        LN/sbqLGl/EoPBQmMC7GBztG96wD/OY+NH5Mnogc2X3qComPiz54zBJMm7dVRqocZhqANZ
        60L342qXFNVr5IRtmi1jyKj2DeU9DPFhWIGzg+5ZK8mqeDNJhdvXAGz5jvFTvAiFQ7YqM6
        r4MvXnqHu9ey2TJc2A+cJV3T7Nd2J+iXs+QhDSp2Ehvutu3kY7C/R51vtj9qMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639661411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VD+GiwMtVHizkJquBtRoVZe2ruoG7hIk5DncvKcmPGg=;
        b=J+QprvE72CPVosVAHylXg7a1oNv3Z93/KjJlTQcacHX2LvAmJ5ngUqZ9iMPH0+ld0ObIwP
        gpmen0KmQIsu6/Dg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Postpone LPI pending
 table freeing and memreserve
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211027151506.2085066-3-valentin.schneider@arm.com>
References: <20211027151506.2085066-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <163966141037.23020.7999461944932342134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d23bc2bc1d634658d7fa96395419c1c553a784f0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d23bc2bc1d634658d7fa96395419c1c553a784f0
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 27 Oct 2021 16:15:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 13:21:11 

irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve

Memory used by the LPI tables have to be made persistent for kexec to have
a chance to work, as explained in [1]. If they have been made persistent
and we are booting into a kexec'd kernel, we also need to free the pages
that were preemptively allocated by the new kernel for those tables.

Both of those operations currently happen during its_cpu_init(), which
happens in a _STARTING (IOW atomic) cpuhp callback for secondary
CPUs. efi_mem_reserve_iomem() issues a GFP_ATOMIC allocation, which
unfortunately doesn't work under PREEMPT_RT (this ends up grabbing a
non-raw spinlock, which can sleep under PREEMPT_RT). Similarly, freeing the
pages ends up grabbing a sleepable spinlock.

Since the memreserve is only required by kexec, it doesn't have to be done
so early in the secondary boot process. Issue the reservation in a new
CPUHP_AP_ONLINE_DYN cpuhp callback, and piggy-back the page freeing on top
of it. A CPU gets to run the body of this new callback exactly once.

As kexec issues a machine_shutdown() prior to machine_kexec(), it will be
serialized vs a CPU being plugged to life by the hotplug machinery - either
the CPU will have been brought up and have had its redistributor's pending
table memreserved, or it never went online and will have its table
allocated by the new kernel.

[1]: https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com/

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211027151506.2085066-3-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3-its.c   | 58 +++++++++++++++++++++++++++--
 drivers/irqchip/irq-gic-v3.c       |  1 +-
 include/linux/irqchip/arm-gic-v3.h |  1 +-
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 74c2274..f860733 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -47,6 +47,8 @@
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
 
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
+#define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
+#define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
 
 static u32 lpi_id_bits;
 
@@ -3065,15 +3067,13 @@ static void its_cpu_init_lpis(void)
 		paddr &= GENMASK_ULL(51, 16);
 
 		WARN_ON(!gic_check_reserved_range(paddr, LPI_PENDBASE_SZ));
-		its_free_pending_table(gic_data_rdist()->pend_page);
-		gic_data_rdist()->pend_page = NULL;
+		gic_data_rdist()->flags |= RD_LOCAL_PENDTABLE_PREALLOCATED;
 
 		goto out;
 	}
 
 	pend_page = gic_data_rdist()->pend_page;
 	paddr = page_to_phys(pend_page);
-	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
 
 	/* set PROPBASE */
 	val = (gic_rdists->prop_table_pa |
@@ -3163,7 +3163,8 @@ out:
 	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
-		gic_data_rdist()->pend_page ? "allocated" : "reserved",
+		gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED ?
+		"reserved" : "allocated",
 		&paddr);
 }
 
@@ -5202,6 +5203,38 @@ int its_cpu_init(void)
 	return 0;
 }
 
+static int its_cpu_memreserve_lpi(unsigned int cpu)
+{
+	struct page *pend_page;
+	int ret = 0;
+
+	/* This gets to run exactly once per CPU */
+	if (gic_data_rdist()->flags & RD_LOCAL_MEMRESERVE_DONE)
+		return 0;
+
+	pend_page = gic_data_rdist()->pend_page;
+	if (WARN_ON(!pend_page)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/*
+	 * If the pending table was pre-programmed, free the memory we
+	 * preemptively allocated. Otherwise, reserve that memory for
+	 * later kexecs.
+	 */
+	if (gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED) {
+		its_free_pending_table(pend_page);
+		gic_data_rdist()->pend_page = NULL;
+	} else {
+		phys_addr_t paddr = page_to_phys(pend_page);
+		WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
+	}
+
+out:
+	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;
+	return ret;
+}
+
 static const struct of_device_id its_device_id[] = {
 	{	.compatible	= "arm,gic-v3-its",	},
 	{},
@@ -5385,6 +5418,23 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
 
+int __init its_lpi_memreserve_init(void)
+{
+	int state;
+
+	if (!efi_enabled(EFI_CONFIG_TABLES))
+		return 0;
+
+	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				  "irqchip/arm/gicv3/memreserve:online",
+				  its_cpu_memreserve_lpi,
+				  NULL);
+	if (state < 0)
+		return state;
+
+	return 0;
+}
+
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index daec330..9fa3e1d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1802,6 +1802,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 		its_cpu_init();
+		its_lpi_memreserve_init();
 	} else {
 		if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 			gicv2m_init(handle, gic_data.domain);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 0dc34d7..51b8550 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -632,6 +632,7 @@ struct rdists {
 
 struct irq_domain;
 struct fwnode_handle;
+int __init its_lpi_memreserve_init(void);
 int its_cpu_init(void);
 int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
