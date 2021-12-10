Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCD0470B18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343812AbhLJT6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:58:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbhLJT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:48 -0500
Date:   Fri, 10 Dec 2021 19:54:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8B5d9/EXY91ILom1/cpxSvNo7yd/4TfcQf6FFH0R+M=;
        b=hYnWQItkTruBfz/OxI+ImXIOyY78biBkqqzd5Zcm1zFcR2dOMbHIw1KaesgcrR+O31YmGh
        wx85SPxazuIVneeEciOtwYMEl7eStedbFIVivVQXzjwPCjpIfevFejNSD5WlxcuPuBR8G8
        8QIONo9FvB4O5vTNYuK/XNNSHMi9W8ezkPU+DIiQSFDyiWp4BWhjk7wpUTgjzD9MsLPBxv
        69I55PQN1YrHLGCO7N+lknWPJruaw0cwQuMtPpw+SDpyxT4+B8WYf+9V4PsOO1xK8r8pak
        NV8hBMlOpjycXIpghUIveiEbstB+/I1JhLxGY0R6qzIvldb6I87Y2l6ZehdS7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8B5d9/EXY91ILom1/cpxSvNo7yd/4TfcQf6FFH0R+M=;
        b=Y8XX4Msa+FIZPC0sNs4ccIyKyD2WMNYONai/zy0nujAvy7uA5wng3VJibDz5gHyd+CtsMr
        kT82Nbl5nl7e7JAA==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iavf: Use irq_update_affinity_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-3-nitesh@redhat.com>
References: <20210903152430.244937-3-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916605096.23020.14587161369898352612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0f9744f4ed539f2e847d7ed41993b243e3ba5cff
Gitweb:        https://git.kernel.org/tip/0f9744f4ed539f2e847d7ed41993b243e3ba5cff
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:18 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:38 +01:00

iavf: Use irq_update_affinity_hint()

The driver uses irq_set_affinity_hint() for two purposes:

- To set the affinity_hint which is consumed by the userspace for
  distributing the interrupts

- To apply an affinity that it provides for the iavf interrupts

The latter is done to ensure that all the interrupts are evenly spread
across all available CPUs. However, since commit a0c9259dc4e1 ("irq/matrix:
Spread interrupts on allocation") the spreading of interrupts is
dynamically performed at the time of allocation. Hence, there is no need
for the drivers to enforce their own affinity for the spreading of
interrupts.

Also, irq_set_affinity_hint() applying the provided cpumask as an affinity
for the interrupt is an undocumented side effect. To remove this side
effect irq_set_affinity_hint() has been marked as deprecated and new
interfaces have been introduced. Hence, replace the irq_set_affinity_hint()
with the new interface irq_update_affinity_hint() that only sets the
pointer for the affinity_hint.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://lore.kernel.org/r/20210903152430.244937-3-nitesh@redhat.com

---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 14934a7..1980e62 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -492,10 +492,10 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
 		/* Spread the IRQ affinity hints across online CPUs. Note that
 		 * get_cpu_mask returns a mask with a permanent lifetime so
-		 * it's safe to use as a hint for irq_set_affinity_hint.
+		 * it's safe to use as a hint for irq_update_affinity_hint.
 		 */
 		cpu = cpumask_local_spread(q_vector->v_idx, -1);
-		irq_set_affinity_hint(irq_num, get_cpu_mask(cpu));
+		irq_update_affinity_hint(irq_num, get_cpu_mask(cpu));
 	}
 
 	return 0;
@@ -505,7 +505,7 @@ free_queue_irqs:
 		vector--;
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &adapter->q_vectors[vector]);
 	}
 	return err;
@@ -557,7 +557,7 @@ static void iavf_free_traffic_irqs(struct iavf_adapter *adapter)
 	for (vector = 0; vector < q_vectors; vector++) {
 		irq_num = adapter->msix_entries[vector + NONQ_VECS].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &adapter->q_vectors[vector]);
 	}
 }
