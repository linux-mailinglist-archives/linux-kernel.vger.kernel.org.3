Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA8470B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbhLJT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:58:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48804 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343738AbhLJT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:45 -0500
Date:   Fri, 10 Dec 2021 19:54:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qoBufiz4nPotnVAff6kRAsvnO9mII0ITZTDq4AIvcxQ=;
        b=m4VAEI0TjWKJkYQ0vlkV3mbiFBs+26RvRosTTMA956UE8PokSAvARIjym2zv0bEWER2a/Q
        tt6BfauEJjORORYOQxrSjT15CeSjbkNvxlMzuNuzT/7QGbsSB1fZc1zmiC4tjWLROWEpLa
        MSMOSwl11YijHrrq21d9HX3uMwl5z+H4PMTxChDTx1ZWWz++XdmtyE3CN/s4HAOqY45KnZ
        TWZBedT4ln/LPP/DNDc20lOTLeDoR7hdaDWPNwctqL7Bw/8I+EBCUacO+Wrk3+jWTdxmYW
        LtygrxcDsfIs8IvHYxQQa7HqKfMo2yBGbCOK9sM+mBpB/TvsRQgRp8B2O9mVuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166049;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qoBufiz4nPotnVAff6kRAsvnO9mII0ITZTDq4AIvcxQ=;
        b=lpMm+ZyunQ3IHv7j+oAQlbbV8nnD+PkugOXzQBUTXzmZnRL1CQtaCD1bhe5klVoT742wCw
        VQpaLha6e/mt/3Ag==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] RDMA/irdma: Use irq_update_affinity_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-7-nitesh@redhat.com>
References: <20210903152430.244937-7-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604799.23020.11731892167259120191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fb5bd854710e410e5544f8ba348a5be6541e4939
Gitweb:        https://git.kernel.org/tip/fb5bd854710e410e5544f8ba348a5be6541e4939
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:22 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:38 +01:00

RDMA/irdma: Use irq_update_affinity_hint()

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
Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Link: https://lore.kernel.org/r/20210903152430.244937-7-nitesh@redhat.com

---
 drivers/infiniband/hw/irdma/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 4108dca..367f121 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -545,7 +545,7 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 
 	dev->irq_ops->irdma_dis_irq(dev, msix_vec->idx);
-	irq_set_affinity_hint(msix_vec->irq, NULL);
+	irq_update_affinity_hint(msix_vec->irq, NULL);
 	free_irq(msix_vec->irq, dev_id);
 }
 
@@ -1095,7 +1095,7 @@ irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	}
 	cpumask_clear(&msix_vec->mask);
 	cpumask_set_cpu(msix_vec->cpu_affinity, &msix_vec->mask);
-	irq_set_affinity_hint(msix_vec->irq, &msix_vec->mask);
+	irq_update_affinity_hint(msix_vec->irq, &msix_vec->mask);
 	if (status) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: ceq irq config fail\n");
 		return IRDMA_ERR_CFG;
