Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B54843B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiADOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:49:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41676 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiADOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:49:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E606612E7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A340C36AF4;
        Tue,  4 Jan 2022 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307794;
        bh=cJkpsMsk8EI3sJ8PqluUGLW+fhH0tNSXs7iR4dXdCtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ch/lBCHLSyq8gCEdNHCkdKkmiQk6No64C4YwAuEk/f+DdhQ+RSUZnIB5Sh8nJs5qm
         wNkzNghyO3YRgoTA9o8MDWCsnDB++oW4Iab2HxsacZN31CLahucsOfV8RiadgFFYhb
         mjCtSIxU/risED/X4UWqa+wnabGuZWYZrZyPhYe0cohAkTdNuTEX5OMxpcsFvQduvn
         npSl2Lvh62t6QdmJkUPpIVtilgPmDjtzr6sJbMOnlxd5x8gUcU3ohRO2tgHZf4/AAs
         ubMpsdq0eke/1UWCF8KX0KrGcwfnlkJKW9hIMvaFCAN4r1ed3rEui8PQY+nE1WeQua
         Kwk9SaBuVxuPw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/8] pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Tue,  4 Jan 2022 15:49:37 +0100
Message-Id: <20220104144944.1278663-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104144944.1278663-1-frederic@kernel.org>
References: <20220104144944.1278663-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare each of the HK_FLAG_* entries to move to their
own cpumask with enforcing to fetch them individually. The new
constraint is that multiple HK_FLAG_* entries can't be mixed together
anymore in a single call to housekeeping cpumask().

This will later allow, for example, to runtime modify the cpulist passed
through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
parameters.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
---
 drivers/pci/pci-driver.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 588588cfda48..4a5792c82d08 100644
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
-- 
2.25.1

