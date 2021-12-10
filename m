Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB6470B05
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbhLJT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:57:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242900AbhLJT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:40 -0500
Date:   Fri, 10 Dec 2021 19:54:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a54FzCTLRPXybuYPepkhCVeAph9Lj7ZfXy3e9L+sJLU=;
        b=28HN/NjPPXnKKifzLDPHjsNEHjE39cBTagGRKeiSCTFsGio/sXGRSxo3QfZblX8zeSPPg/
        OBL8okswgymfWg6ady9soaLot6HV96XflHLV1g+ZX1b+IgGqj8RuYFNqJwBdVdJQ1E8MLL
        GxOh0vlVXg4QCwVZLA5m2opXlWK0QJhwrNydi5rGV4kA6JUm8ldpBFRLgNve3hTQr7koZ7
        OmRn20adAyuajsaz84XrIbalKIwQnTMOozFLI2iniNcqe5ibWHNaY/e+xC5c87D9rqV0eU
        Kf/aIYSDDN8/rMu6kimLk0S92y3mN3Sw150rYqpIhFCgP7/TQCwT74jLxKKqvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a54FzCTLRPXybuYPepkhCVeAph9Lj7ZfXy3e9L+sJLU=;
        b=68B+U6iKeuOe9QMJM4hoUx+Rpy3hEf7scGJkCWlWFSL2Veo1maZylsIPRIMetSmFnr2OvG
        wGHBqL9LafpTz6Dw==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] hinic: Use irq_set_affinity_and_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-13-nitesh@redhat.com>
References: <20210903152430.244937-13-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604299.23020.78251471901767101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2d1e72f235d665aa699fb821f6da6e8bde84cbde
Gitweb:        https://git.kernel.org/tip/2d1e72f235d665aa699fb821f6da6e8bde84cbde
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:28 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:39 +01:00

hinic: Use irq_set_affinity_and_hint()

The driver uses irq_set_affinity_hint() to:

 - Set the affinity_hint which is consumed by the userspace for
   distributing the interrupts

 - Enforce affinity

As per commit 352f58b0d9f2 ("net-next/hinic: Set Rxq irq to specific cpu
for NUMA"), the hinic driver enforces its own affinity to bind IRQs to the
local NUMA node. However, irq_set_affinity_hint() applying the provided
cpumask as an affinity for the interrupt is an undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked as
deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
where the provided mask needs to be applied as the affinity and
affinity_hint pointer needs to be set and replace with
irq_update_affinity_hint() where only affinity_hint needs to be updated.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210903152430.244937-13-nitesh@redhat.com

---
 drivers/net/ethernet/huawei/hinic/hinic_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index fed3b6b..b33ed4d 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -548,7 +548,7 @@ static int rx_request_irq(struct hinic_rxq *rxq)
 		goto err_req_irq;
 
 	cpumask_set_cpu(qp->q_id % num_online_cpus(), &rq->affinity_mask);
-	err = irq_set_affinity_hint(rq->irq, &rq->affinity_mask);
+	err = irq_set_affinity_and_hint(rq->irq, &rq->affinity_mask);
 	if (err)
 		goto err_irq_affinity;
 
@@ -565,7 +565,7 @@ static void rx_free_irq(struct hinic_rxq *rxq)
 {
 	struct hinic_rq *rq = rxq->rq;
 
-	irq_set_affinity_hint(rq->irq, NULL);
+	irq_update_affinity_hint(rq->irq, NULL);
 	free_irq(rq->irq, rxq);
 	rx_del_napi(rxq);
 }
