Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4AF470B04
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbhLJT5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:57:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbhLJT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:39 -0500
Date:   Fri, 10 Dec 2021 19:54:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f54kEYtdTnf14yhEifHqMgC0mj0OkMFAF1RXhsPUl6M=;
        b=iKb8kHL43mvW6E6h00tzvFq4zg1YhFPCVX1b9Xfwg26j8fkZN7KMJ5cX0kvANdBJGhXtY0
        zqeQa0p987fv6cYuVa47pmdtpAMD+HXPOy+AC+VfKCi5FVjHMDHySYkoB3J6Fdx6OVNsIB
        jjHWQjbj27Uauw8nf+wg7p8LOxqsaeMjlgJFdBrjhryLrhKMHD2o9+GXFJr9s12sKK8C6x
        xi0guHuZEfixqimqBExE6pquoqwCIqIr32bBjzV9EWmSCyUa6f8jmhAYgVSmEniVpymk9a
        Iid7TUQcFtPNntvO0UL7jGiAH39obpi51TfbvPl3T8hwb2ppSFWFfTwe5+Ks1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f54kEYtdTnf14yhEifHqMgC0mj0OkMFAF1RXhsPUl6M=;
        b=M98J7wgXneAy2r94owon1tdFOZEL/CKWgH1HWu7PNSSOma6CspNU1a68BArhyLwqXkoWpz
        QJYSIRXSoM18AyDA==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net/mlx5: Use irq_set_affinity_and_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Leon Romanovsky <leonro@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-14-nitesh@redhat.com>
References: <20210903152430.244937-14-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604220.23020.2152112272681001749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7451e9ea8e2055af39afe7ff39a5f68d8ec6b98d
Gitweb:        https://git.kernel.org/tip/7451e9ea8e2055af39afe7ff39a5f68d8ec6b98d
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:29 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:39 +01:00

net/mlx5: Use irq_set_affinity_and_hint()

The driver uses irq_set_affinity_hint() to update the affinity_hint mask
that is consumed by the userspace to distribute the interrupts and to apply
the provided mask as the affinity for the mlx5 interrupts. However,
irq_set_affinity_hint() applying the provided cpumask as an affinity for
the interrupt is an undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
where the provided mask needs to be applied as the affinity and
affinity_hint pointer needs to be set and replace with
irq_update_affinity_hint() where only affinity_hint needs to be updated.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/20210903152430.244937-14-nitesh@redhat.com

---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 830444f..54fb67c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -143,11 +143,11 @@ static void irq_release(struct mlx5_irq *irq)
 	struct mlx5_irq_pool *pool = irq->pool;
 
 	xa_erase(&pool->irqs, irq->index);
-	/* free_irq requires that affinity and rmap will be cleared
+	/* free_irq requires that affinity_hint and rmap will be cleared
 	 * before calling it. This is why there is asymmetry with set_rmap
 	 * which should be called after alloc_irq but before request_irq.
 	 */
-	irq_set_affinity_hint(irq->irqn, NULL);
+	irq_update_affinity_hint(irq->irqn, NULL);
 	free_cpumask_var(irq->mask);
 	free_irq(irq->irqn, &irq->nh);
 	kfree(irq);
@@ -316,7 +316,7 @@ static struct mlx5_irq *irq_pool_create_irq(struct mlx5_irq_pool *pool,
 	if (IS_ERR(irq))
 		return irq;
 	cpumask_copy(irq->mask, affinity);
-	irq_set_affinity_hint(irq->irqn, irq->mask);
+	irq_set_affinity_and_hint(irq->irqn, irq->mask);
 	return irq;
 }
 
@@ -399,7 +399,7 @@ irq_pool_request_vector(struct mlx5_irq_pool *pool, int vecidx,
 	if (!irq_pool_is_sf_pool(pool) && !pool->xa_num_irqs.max &&
 	    cpumask_empty(irq->mask))
 		cpumask_set_cpu(0, irq->mask);
-	irq_set_affinity_hint(irq->irqn, irq->mask);
+	irq_set_affinity_and_hint(irq->irqn, irq->mask);
 unlock:
 	mutex_unlock(&pool->lock);
 	return irq;
