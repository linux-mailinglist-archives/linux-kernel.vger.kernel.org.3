Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05DC470B12
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbhLJT5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343709AbhLJT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064CC061746;
        Fri, 10 Dec 2021 11:54:08 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:54:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byy6TjXybvy8uoX3UZb4PAU3zUw+Lb2ObL2Q/IVhsvE=;
        b=SXLzS6JSxj9rnE85hClLf1TPrsbLuOWBFT3SakUMC0RyOTXQhK0/gt9ewztkYtj6GLtwFr
        S0jD2CMbgaFzealurpz9WqiMS38vLlx/DO0j2hmcVE6xzWyVCoxWfhNcUjpaC1kwyE8N+p
        NACyezUf8fKsuWn7T+/ogdeB5vtn0RmZtyM0l+C0pGlDSCAqjFyKd/UKhMwQJMhTxSra8q
        mvLS67XdvWSAf8zhb2NEWBPmUdiMShAM8fWC6MxGhfTW6iYH4g6EyB86FvvBZncfTkvOyl
        dpRKmYU8D92PY9MTujvqUi5zUATDqz8dFsjiSQ4OEwf9RpRrHRWpztXGEgwL3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byy6TjXybvy8uoX3UZb4PAU3zUw+Lb2ObL2Q/IVhsvE=;
        b=7k0hnsunb0bPfCR+w7b6Ww7WhhBqXHbhGh1fc1pHAe1tGq7uIQelQ0israpvd5mLw+MekO
        6bBuGnh+fkXraFDw==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ixgbe: Use irq_update_affinity_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-10-nitesh@redhat.com>
References: <20210903152430.244937-10-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604572.23020.11489515087571994461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cc493264c01d055742a34cfbaecaffb258dcc58c
Gitweb:        https://git.kernel.org/tip/cc493264c01d055742a34cfbaecaffb258dcc58c
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:25 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:39 +01:00

ixgbe: Use irq_update_affinity_hint()

The driver uses irq_set_affinity_hint() to update the affinity_hint mask
that is consumed by the userspace to distribute the interrupts. However,
under the hood irq_set_affinity_hint() also applies the provided cpumask
(if not NULL) as the affinity for the given interrupt which is an
undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_update_affinity_hint()
that only updates the affinity_hint pointer.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://lore.kernel.org/r/20210903152430.244937-10-nitesh@redhat.com

---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0f9f022..66068e1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3247,8 +3247,8 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter *adapter)
 		/* If Flow Director is enabled, set interrupt affinity */
 		if (adapter->flags & IXGBE_FLAG_FDIR_HASH_CAPABLE) {
 			/* assign the mask for this irq */
-			irq_set_affinity_hint(entry->vector,
-					      &q_vector->affinity_mask);
+			irq_update_affinity_hint(entry->vector,
+						 &q_vector->affinity_mask);
 		}
 	}
 
@@ -3264,8 +3264,8 @@ static int ixgbe_request_msix_irqs(struct ixgbe_adapter *adapter)
 free_queue_irqs:
 	while (vector) {
 		vector--;
-		irq_set_affinity_hint(adapter->msix_entries[vector].vector,
-				      NULL);
+		irq_update_affinity_hint(adapter->msix_entries[vector].vector,
+					 NULL);
 		free_irq(adapter->msix_entries[vector].vector,
 			 adapter->q_vector[vector]);
 	}
@@ -3398,7 +3398,7 @@ static void ixgbe_free_irq(struct ixgbe_adapter *adapter)
 			continue;
 
 		/* clear the affinity_mask in the IRQ descriptor */
-		irq_set_affinity_hint(entry->vector, NULL);
+		irq_update_affinity_hint(entry->vector, NULL);
 
 		free_irq(entry->vector, q_vector);
 	}
