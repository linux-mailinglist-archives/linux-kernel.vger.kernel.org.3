Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE089470B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbhLJT6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343786AbhLJT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568CC061A72;
        Fri, 10 Dec 2021 11:54:12 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0X47jCtW5pjwq36Q//lgYeModKw/MEUHpxHsRt3GKjs=;
        b=Ocj0aRxe3szM0KD93xVKNnM0Pl9dIOoUXEEeoZ1fWkPPXzo24VpGRblRhjvMcmXGjmBWCI
        141nWno14mNfYOnhWK5HKmFsTbGDtQpk+irowJIYM94Ixbu+tJDMDLk2ItI9/9n3tcdgl2
        SS6n0tNERfvSa2RRB9kWfWMVAEVyt3f2veAsdVP67mGHlGgzA+79XpCX24GA3LxUTP8TyV
        XmtUtBZd6zLt087lGjSaTPmLg1e7xoZziNsPYXUpFmt8kNNf+Xh/qQ9INzJXkMPjUk1nKq
        a8jAtAehwqn09XyVcTXflZZKe4QBgPEkYElagSL2gOrBXzrYf4SEitaEg1E3Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0X47jCtW5pjwq36Q//lgYeModKw/MEUHpxHsRt3GKjs=;
        b=DozSfP1ExHfaFb7GVxNnvkgoYt8Ad6LQoRNUHpffhTC6dytSr3OG5DkyXIFUc88nnaBQvB
        c/x0TaghDLY64LBg==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] scsi: megaraid_sas: Use irq_set_affinity_and_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-5-nitesh@redhat.com>
References: <20210903152430.244937-5-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604949.23020.15564762185103133685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8049da6f3943d0ac51931b8064b2e4769a69a967
Gitweb:        https://git.kernel.org/tip/8049da6f3943d0ac51931b8064b2e4769a69a967
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:20 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:38 +01:00

scsi: megaraid_sas: Use irq_set_affinity_and_hint()

The driver uses irq_set_affinity_hint() specifically for the high IOPS
queue interrupts for two purposes:

 - To set the affinity_hint which is consumed by the userspace for
   distributing the interrupts

 - To apply an affinity that it provides

The driver enforces its own affinity to bind the high IOPS queue interrupts
to the local NUMA node. However, irq_set_affinity_hint() applying the
provided cpumask as an affinity for the interrupt is an undocumented side
effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
where the provided mask needs to be applied as the affinity and
affinity_hint pointer needs to be set and replace with
irq_update_affinity_hint() where only affinity_hint needs to be updated.

Change the megasas_set_high_iops_queue_affinity_hint function name to
megasas_set_high_iops_queue_affinity_and_hint to clearly indicate that the
function is setting both affinity and affinity_hint.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Link: https://lore.kernel.org/r/20210903152430.244937-5-nitesh@redhat.com

---
 drivers/scsi/megaraid/megaraid_sas_base.c | 27 ++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index aeb95f4..82e1e24 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5720,7 +5720,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
 				"Failed to register IRQ for vector %d.\n", i);
 			for (j = 0; j < i; j++) {
 				if (j < instance->low_latency_index_start)
-					irq_set_affinity_hint(
+					irq_update_affinity_hint(
 						pci_irq_vector(pdev, j), NULL);
 				free_irq(pci_irq_vector(pdev, j),
 					 &instance->irq_context[j]);
@@ -5763,7 +5763,7 @@ megasas_destroy_irqs(struct megasas_instance *instance) {
 	if (instance->msix_vectors)
 		for (i = 0; i < instance->msix_vectors; i++) {
 			if (i < instance->low_latency_index_start)
-				irq_set_affinity_hint(
+				irq_update_affinity_hint(
 				    pci_irq_vector(instance->pdev, i), NULL);
 			free_irq(pci_irq_vector(instance->pdev, i),
 				 &instance->irq_context[i]);
@@ -5894,22 +5894,25 @@ int megasas_get_device_list(struct megasas_instance *instance)
 }
 
 /**
- * megasas_set_high_iops_queue_affinity_hint -	Set affinity hint for high IOPS queues
- * @instance:					Adapter soft state
- * return:					void
+ * megasas_set_high_iops_queue_affinity_and_hint -	Set affinity and hint
+ *							for high IOPS queues
+ * @instance:						Adapter soft state
+ * return:						void
  */
 static inline void
-megasas_set_high_iops_queue_affinity_hint(struct megasas_instance *instance)
+megasas_set_high_iops_queue_affinity_and_hint(struct megasas_instance *instance)
 {
 	int i;
-	int local_numa_node;
+	unsigned int irq;
+	const struct cpumask *mask;
 
 	if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
-		local_numa_node = dev_to_node(&instance->pdev->dev);
+		mask = cpumask_of_node(dev_to_node(&instance->pdev->dev));
 
-		for (i = 0; i < instance->low_latency_index_start; i++)
-			irq_set_affinity_hint(pci_irq_vector(instance->pdev, i),
-				cpumask_of_node(local_numa_node));
+		for (i = 0; i < instance->low_latency_index_start; i++) {
+			irq = pci_irq_vector(instance->pdev, i);
+			irq_set_affinity_and_hint(irq, mask);
+		}
 	}
 }
 
@@ -5998,7 +6001,7 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 		instance->msix_vectors = 0;
 
 	if (instance->smp_affinity_enable)
-		megasas_set_high_iops_queue_affinity_hint(instance);
+		megasas_set_high_iops_queue_affinity_and_hint(instance);
 }
 
 /**
