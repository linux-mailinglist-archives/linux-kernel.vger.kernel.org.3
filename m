Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E78477322
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbhLPNaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhLPNaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:30:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:30:13 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:30:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639661412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGEZMbyth6Lskg+UXr7MdyWPPxE4VQV+SNzXAPyvEYU=;
        b=ZwQd1KJ0pj9Tu0A/CRu5T1W4aVAdFyU9r4MLj/rP4tzbUPu7oSNr7DP0ouZNqJnOz18uzu
        GQwWmHba6JFEhmOtLE/O/HUny086FXCTbkP8JdECnF0O06EFQ7vHaEI2ys+op5PYViwmVN
        THhaNeemN2A800Js0jcYMeprPdA01AMQnxd03IMK9pjXaLbYMkIchctdM8Fo1PU+nDoMc8
        6u8NQIHNyUEjLTsFiunJbDmerdOJe/D21Sg0j4Tr5iNeCh7RGwyckG+NinCXOELbTATk6S
        afQgDisdRqdcq1kfhfnT2901pnZXurDRobW6mJXJf3VOSfmHUtkauvXM+y7YJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639661412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGEZMbyth6Lskg+UXr7MdyWPPxE4VQV+SNzXAPyvEYU=;
        b=797gVqZnaanjxUmaAwCvp6qCsw62Z6B3SzsWS1mDeCOTz5Qn3oc/xewQiZ5yTECceUeeXU
        gdieAnlLxNJ/FhBg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Give the percpu rdist
 struct its own flags field
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211027151506.2085066-2-valentin.schneider@arm.com>
References: <20211027151506.2085066-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <163966141130.23020.13254907219278053545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     c0cdc89072a3e1ae3981437f385de14b7bba8fd8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c0cdc89072a3e1ae3981437f385de14b7bba8fd8
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 27 Oct 2021 16:15:04 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 13:21:11 

irqchip/gic-v3-its: Give the percpu rdist struct its own flags field

Later patches will require tracking some per-rdist status. Reuse the bytes
"lost" to padding within the __percpu rdist struct as a flags field, and
re-encode ->lpi_enabled within said flags.

No change in functionality intended.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211027151506.2085066-2-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3-its.c   | 8 +++++---
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index eb0882d..74c2274 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -46,6 +46,8 @@
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
 
+#define RD_LOCAL_LPI_ENABLED                    BIT(0)
+
 static u32 lpi_id_bits;
 
 /*
@@ -3044,7 +3046,7 @@ static void its_cpu_init_lpis(void)
 	phys_addr_t paddr;
 	u64 val, tmp;
 
-	if (gic_data_rdist()->lpi_enabled)
+	if (gic_data_rdist()->flags & RD_LOCAL_LPI_ENABLED)
 		return;
 
 	val = readl_relaxed(rbase + GICR_CTLR);
@@ -3158,7 +3160,7 @@ static void its_cpu_init_lpis(void)
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
-	gic_data_rdist()->lpi_enabled = true;
+	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
 		gic_data_rdist()->pend_page ? "allocated" : "reserved",
@@ -5138,7 +5140,7 @@ static int redist_disable_lpis(void)
 	 *
 	 * If running with preallocated tables, there is nothing to do.
 	 */
-	if (gic_data_rdist()->lpi_enabled ||
+	if ((gic_data_rdist()->flags & RD_LOCAL_LPI_ENABLED) ||
 	    (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED))
 		return 0;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 81cbf85..0dc34d7 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -615,7 +615,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
-		bool		lpi_enabled;
+		u64             flags;
 		cpumask_t	*vpe_table_mask;
 		void		*vpe_l1_base;
 	} __percpu		*rdist;
