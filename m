Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A84BA8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiBQS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbiBQS5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861A5D642;
        Thu, 17 Feb 2022 10:56:53 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvX3VcVTdDFf7XLd1SSfYubyFz74SefeqCtNmezfg4s=;
        b=KLFLrl+7m5fbrPb6Zl9HQPrEPpJUJMBxhQsV6EmyAq0/99GOilk2o7u7iI4afgwLMD3NGd
        QWTp1Cs1KIDoCLP4Cy/RcdzKTOtSBG7ZOu0E9mAcGyj7rsAKerCpJG3G7WAic1AizVGN7r
        drMjxzRjUnTnS+PKz1Colgaq75fPI5Xe0S69QdogaUU69ytagbbF9lE4PfXHQgtSBxFA9j
        bc52o9/694ni3tt/vmNxQKUYVuczjHRVUZP+rh68drLUvmkIoxJK6IHd1VUQg+kT+mJebE
        +j0O0GM3vvTId0KJ8acgsZEqWjpEBwFk0K5Ce+3VgLrJzDH0FAPrasFrX6CzWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvX3VcVTdDFf7XLd1SSfYubyFz74SefeqCtNmezfg4s=;
        b=OI3ztUFrmfgI9MHO6wpJ2NBlfSqg7DocyMaEKGJAcOG55gW3mzTeEH4JWuigpws2jukaSI
        rrYHdSLa0nCGf0CQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207155910.527133-2-frederic@kernel.org>
References: <20220207155910.527133-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <164512421082.16921.14468730232385715895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9d42ea0d6984044a82258f41d8407ee442687f30
Gitweb:        https://git.kernel.org/tip/9d42ea0d6984044a82258f41d8407ee442687f30
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 07 Feb 2022 16:59:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:54 +01:00

pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare each of the HK_FLAG_* entries to move to their
own cpumask with enforcing to fetch them individually. The new
constraint is that multiple HK_FLAG_* entries can't be mixed together
anymore in a single call to housekeeping cpumask().

This will later allow, for example, to runtime modify the cpulist passed
through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
parameters.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20220207155910.527133-2-frederic@kernel.org
---
 drivers/pci/pci-driver.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 588588c..4a5792c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -350,7 +350,6 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 			  const struct pci_device_id *id)
 {
 	int error, node, cpu;
-	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	struct drv_dev_and_id ddi = { drv, dev, id };
 
 	/*
@@ -368,17 +367,29 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
 	 * device is probed from work_on_cpu() of the Physical device.
 	 */
 	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
-	    pci_physfn_is_probed(dev))
+	    pci_physfn_is_probed(dev)) {
 		cpu = nr_cpu_ids;
-	else
+	} else {
+		cpumask_var_t wq_domain_mask;
+
+		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
+			error = -ENOMEM;
+			goto out;
+		}
+		cpumask_and(wq_domain_mask,
+			    housekeeping_cpumask(HK_FLAG_WQ),
+			    housekeeping_cpumask(HK_FLAG_DOMAIN));
+
 		cpu = cpumask_any_and(cpumask_of_node(node),
-				      housekeeping_cpumask(hk_flags));
+				      wq_domain_mask);
+		free_cpumask_var(wq_domain_mask);
+	}
 
 	if (cpu < nr_cpu_ids)
 		error = work_on_cpu(cpu, local_pci_probe, &ddi);
 	else
 		error = local_pci_probe(&ddi);
-
+out:
 	dev->is_probed = 0;
 	cpu_hotplug_enable();
 	return error;
