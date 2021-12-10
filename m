Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15734470B16
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243165AbhLJT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbhLJT5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B6C061353;
        Fri, 10 Dec 2021 11:54:11 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:54:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0QVYIgsZprSTKmHZHHShHbldrgPwCuRXAbOdi16Yzo=;
        b=1LopK7h4C6eBUdYHH8djy+QyDigzG3JvUoiKAwf1fBodbuQFDII8iILQkWbwM2BgK+phjT
        qpb6h0vhhzCcsjtHroF/gh9aHg8XpJcnOJVlMZnJ8RCeIk+6vGmdzgpw1NhtA7beKSJo4b
        w8n+XXVRmiMvuKuo9eLA1cBsKr5QDZhshj0iq07XZVs3UFS535vX5BU2zGje6AGS0lHHjS
        QFOMh09Uh8KwIWTbDvxSxZFw6E4KoQ86xZW0W2EuE0M5qS2HqF4Me0jOVDclM+04XRcYQI
        EAneTtWl83jwo/CTjJ9IUYzClqQmrKIWwNE9wbeUUC4IiXENXeow2LpAZqg+tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0QVYIgsZprSTKmHZHHShHbldrgPwCuRXAbOdi16Yzo=;
        b=pOWn/Fzu7lUDgLgoSWXepjWK882oPcE4zTGqe+FH+jdiSmmwQsnyNVqV4JCbfDO8Q/4nUf
        5nKn2l+CtAvJovCQ==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] scsi: mpt3sas: Use irq_set_affinity_and_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-6-nitesh@redhat.com>
References: <20210903152430.244937-6-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604872.23020.15587930198801556013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fdb8ed13a77270c8e6e05b3ff9f4cb2f57e16d6a
Gitweb:        https://git.kernel.org/tip/fdb8ed13a77270c8e6e05b3ff9f4cb2f57e16d6a
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:21 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:38 +01:00

scsi: mpt3sas: Use irq_set_affinity_and_hint()

The driver uses irq_set_affinity_hint() specifically for the high IOPS
queue interrupts for two purposes:

 - To set the affinity_hint which is consumed by the userspace for
   distributing the interrupts

 - To apply an affinity that it provides

The driver enforces its own affinity to bind the high IOPS queue interrupts
to the local NUMA node. However, irq_set_affinity_hint() applying the
provided cpumask as an affinity (if not NULL) for the interrupt is an
undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
where the provided mask needs to be applied as the affinity and
affinity_hint pointer needs to be set and replace with
irq_update_affinity_hint() where only affinity_hint needs to be updated.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Link: https://lore.kernel.org/r/20210903152430.244937-6-nitesh@redhat.com

---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 81dab9b..511726f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3086,6 +3086,7 @@ _base_check_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 void
 mpt3sas_base_free_irq(struct MPT3SAS_ADAPTER *ioc)
 {
+	unsigned int irq;
 	struct adapter_reply_queue *reply_q, *next;
 
 	if (list_empty(&ioc->reply_queue_list))
@@ -3098,9 +3099,10 @@ mpt3sas_base_free_irq(struct MPT3SAS_ADAPTER *ioc)
 			continue;
 		}
 
-		if (ioc->smp_affinity_enable)
-			irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
-			    reply_q->msix_index), NULL);
+		if (ioc->smp_affinity_enable) {
+			irq = pci_irq_vector(ioc->pdev, reply_q->msix_index);
+			irq_update_affinity_hint(irq, NULL);
+		}
 		free_irq(pci_irq_vector(ioc->pdev, reply_q->msix_index),
 			 reply_q);
 		kfree(reply_q);
@@ -3167,18 +3169,15 @@ out:
  * @ioc: per adapter object
  *
  * The enduser would need to set the affinity via /proc/irq/#/smp_affinity
- *
- * It would nice if we could call irq_set_affinity, however it is not
- * an exported symbol
  */
 static void
 _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 {
-	unsigned int cpu, nr_cpus, nr_msix, index = 0;
+	unsigned int cpu, nr_cpus, nr_msix, index = 0, irq;
 	struct adapter_reply_queue *reply_q;
-	int local_numa_node;
 	int iopoll_q_count = ioc->reply_queue_count -
 	    ioc->iopoll_q_start_index;
+	const struct cpumask *mask;
 
 	if (!_base_is_controller_msix_enabled(ioc))
 		return;
@@ -3201,11 +3200,11 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 		 * corresponding to high iops queues.
 		 */
 		if (ioc->high_iops_queues) {
-			local_numa_node = dev_to_node(&ioc->pdev->dev);
+			mask = cpumask_of_node(dev_to_node(&ioc->pdev->dev));
 			for (index = 0; index < ioc->high_iops_queues;
 			    index++) {
-				irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
-				    index), cpumask_of_node(local_numa_node));
+				irq = pci_irq_vector(ioc->pdev, index);
+				irq_set_affinity_and_hint(irq, mask);
 			}
 		}
 
