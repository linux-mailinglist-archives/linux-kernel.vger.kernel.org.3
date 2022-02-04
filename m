Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E34A99A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbiBDNEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:04:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43522 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiBDNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:04:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0704F61B7C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA7BC340F0;
        Fri,  4 Feb 2022 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643979886;
        bh=12lpq3N2GTXe+NLF6Remlqvk4jUFS3sVYR8vsgOt120=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PxcnnFqfmlGc8oUEfEOORcThkjuVrzD78ndarjQLi3YL0exnntNz4QDfKM8JNWXTX
         SV7+a0DvldEOSNP/r9eIlNOMC8tTGNErKRGBKSgJgH0GKObwLjZFrrxEBL5Zv3kA3u
         0kGiUp69vrF8kYH9hvR8KXPTSimWdj5yezS21VVJ5F9AGjnY3GdYXn/IxiBRpmG2Y3
         t62SLGncYJp92hc0FQ0NnaMP8JYlMYx4I3LbEOvjp38qB2MRuvIG1urQKh2eT7wUUW
         u3IOWiD48utj8n03M6dTPy+a05yToecQweFvahZ3ssxI5S3cCNGsdl/esRE+8gRDlg
         7HfkgP5Bs+x4w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 1/8] pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Fri,  4 Feb 2022 14:04:26 +0100
Message-Id: <20220204130433.488085-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204130433.488085-1-frederic@kernel.org>
References: <20220204130433.488085-1-frederic@kernel.org>
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

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
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
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Paul E. McKenney  <paulmck@kernel.org>
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

