Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD13477320
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbhLPNaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:30:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54538 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbhLPNaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:30:12 -0500
Date:   Thu, 16 Dec 2021 13:30:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639661410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2JKGNSX92r+LHp5070D/RJ7oZDysZfsU6/VI3rtDmg=;
        b=x2++yWgDJArLx+ZowTEB72WnwHWTVx//hLYReFvsuDItuDX9puG/h5Bvn86ySv+q+umMAC
        7FPQYj74Gci8X1l5pm3dXpcnPOxGLameMTE84ZkjtiiwNa8LXLRFTdNEuBNecYrNCozfDP
        2h5GJttgLOtZu/l8IisOu9t2ER7d5xrHaH/QhhdqrGzWgCFlyuRwcaaqQiD5E9Dso9f2cb
        +B+y2qnblTsQfi6RUJ9/sWvE6uBXSj0QtwUzShblp6L4EkQ5rrDkYhoeOs6D/XFAqt4DsQ
        4nZ/qFebapOqhsU+0MgeCnYiXFcqBAeTdAeXna+BI4353ShelpN/AHXVEYqUJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639661410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2JKGNSX92r+LHp5070D/RJ7oZDysZfsU6/VI3rtDmg=;
        b=lxi32fEP3XzxNKxR/AlFtcTUZT+zS9lv2OHRiRM4bBFHKd7NZvWKZgN3Q7hXVKs4DPOasA
        pWEdYY6LKtySJvCg==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Limit memreserve
 cpuhp state lifetime
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211027151506.2085066-4-valentin.schneider@arm.com>
References: <20211027151506.2085066-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <163966140942.23020.6280326120381615215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     835f442fdbce33a47a6bde356643fd7e3ef7ec1b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/835f442fdbce33a47a6bde356643fd7e3ef7ec1b
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 27 Oct 2021 16:15:06 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 13:21:12 

irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime

The new memreserve cpuhp callback only needs to survive up until a point
where every CPU in the system has booted once. Beyond that, it becomes a
no-op and can be put in the bin.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211027151506.2085066-4-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3-its.c   | 16 ++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f860733..ee83eb3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5203,6 +5203,15 @@ int its_cpu_init(void)
 	return 0;
 }
 
+static void rdist_memreserve_cpuhp_cleanup_workfn(struct work_struct *work)
+{
+	cpuhp_remove_state_nocalls(gic_rdists->cpuhp_memreserve_state);
+	gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
+}
+
+static DECLARE_WORK(rdist_memreserve_cpuhp_cleanup_work,
+		    rdist_memreserve_cpuhp_cleanup_workfn);
+
 static int its_cpu_memreserve_lpi(unsigned int cpu)
 {
 	struct page *pend_page;
@@ -5231,6 +5240,10 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
 	}
 
 out:
+	/* Last CPU being brought up gets to issue the cleanup */
+	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
+		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
+
 	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;
 	return ret;
 }
@@ -5425,6 +5438,7 @@ int __init its_lpi_memreserve_init(void)
 	if (!efi_enabled(EFI_CONFIG_TABLES))
 		return 0;
 
+	gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "irqchip/arm/gicv3/memreserve:online",
 				  its_cpu_memreserve_lpi,
@@ -5432,6 +5446,8 @@ int __init its_lpi_memreserve_init(void)
 	if (state < 0)
 		return state;
 
+	gic_rdists->cpuhp_memreserve_state = state;
+
 	return 0;
 }
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 51b8550..12d91f0 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -624,6 +624,7 @@ struct rdists {
 	u64			flags;
 	u32			gicd_typer;
 	u32			gicd_typer2;
+	int                     cpuhp_memreserve_state;
 	bool			has_vlpis;
 	bool			has_rvpeid;
 	bool			has_direct_lpi;
