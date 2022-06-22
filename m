Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54475551AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376783AbiFVQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376643AbiFVQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EE6040E52
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC35E1477;
        Wed, 22 Jun 2022 09:47:07 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7033B3F792;
        Wed, 22 Jun 2022 09:47:05 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
Subject: [PATCH v5 03/21] x86/resctrl: Add domain online callback for resctrl work
Date:   Wed, 22 Jun 2022 16:46:11 +0000
Message-Id: <20220622164629.20795-4-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220622164629.20795-1-james.morse@arm.com>
References: <20220622164629.20795-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because domains are exposed to user-space via resctrl, the filesystem
must update its state when CPU hotplug callbacks are triggered.

Some of this work is common to any architecture that would support
resctrl, but the work is tied up with the architecture code to
allocate the memory.

Move domain_setup_mon_state(), the monitor subdir creation call and the
mbm/limbo workers into a new resctrl_online_domain() call. These bits
are not specific to the architecture. Grouping them in one function
allows that code to be moved to /fs/ and re-used by another architecture.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Fixed kfree(d) rebase artefact.

Changes since v1:
 * Capitalisation
 * Removed inline comment
 * Added to the commit message
---
 arch/x86/kernel/cpu/resctrl/core.c     | 57 ++++------------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 65 ++++++++++++++++++++++++--
 include/linux/resctrl.h                |  1 +
 4 files changed, 69 insertions(+), 56 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2f87177f1f69..25f30148478b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -443,42 +443,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
-{
-	size_t tsize;
-
-	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
-		if (!d->rmid_busy_llc)
-			return -ENOMEM;
-		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
-	}
-	if (is_mbm_total_enabled()) {
-		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_total) {
-			bitmap_free(d->rmid_busy_llc);
-			return -ENOMEM;
-		}
-	}
-	if (is_mbm_local_enabled()) {
-		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
-		if (!d->mbm_local) {
-			bitmap_free(d->rmid_busy_llc);
-			kfree(d->mbm_total);
-			return -ENOMEM;
-		}
-	}
-
-	if (is_mbm_enabled()) {
-		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
-	}
-
-	return 0;
-}
-
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -498,6 +462,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
+	int err;
 
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
@@ -527,21 +492,15 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (r->mon_capable && domain_setup_mon_state(r, d)) {
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
-		kfree(hw_dom);
-		return;
-	}
-
 	list_add_tail(&d->list, add_pos);
 
-	/*
-	 * If resctrl is mounted, add
-	 * per domain monitor data directories.
-	 */
-	if (static_branch_unlikely(&rdt_mon_enable_key))
-		mkdir_mondata_subdir_allrdtgrp(r, d);
+	err = resctrl_online_domain(r, d);
+	if (err) {
+		list_del(&d->list);
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
+		kfree(hw_dom);
+	}
 }
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8828b5c1b6d2..be48a682dbdb 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -524,8 +524,6 @@ void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 				    unsigned int dom_id);
-void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    struct rdt_domain *d);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index def7c6681f8b..030a70326ccc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2565,16 +2565,13 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
  * Add all subdirectories of mon_data for "ctrl_mon" groups
  * and "monitor" groups with given domain id.
  */
-void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    struct rdt_domain *d)
+static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   struct rdt_domain *d)
 {
 	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
 	struct list_head *head;
 
-	if (!r->mon_capable)
-		return;
-
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		parent_kn = prgrp->mon.mon_data_kn;
 		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
@@ -3236,6 +3233,64 @@ static int __init rdtgroup_setup_root(void)
 	return ret;
 }
 
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
+{
+	size_t tsize;
+
+	if (is_llc_occupancy_enabled()) {
+		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
+		if (!d->rmid_busy_llc)
+			return -ENOMEM;
+	}
+	if (is_mbm_total_enabled()) {
+		tsize = sizeof(*d->mbm_total);
+		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!d->mbm_total) {
+			bitmap_free(d->rmid_busy_llc);
+			return -ENOMEM;
+		}
+	}
+	if (is_mbm_local_enabled()) {
+		tsize = sizeof(*d->mbm_local);
+		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		if (!d->mbm_local) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	int err;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!r->mon_capable)
+		return 0;
+
+	err = domain_setup_mon_state(r, d);
+	if (err)
+		return err;
+
+	if (is_mbm_enabled()) {
+		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+	}
+
+	if (is_llc_occupancy_enabled())
+		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
+
+	/* If resctrl is mounted, add per domain monitor data directories. */
+	if (static_branch_unlikely(&rdt_mon_enable_key))
+		mkdir_mondata_subdir_allrdtgrp(r, d);
+
+	return 0;
+}
+
 /*
  * rdtgroup_init - rdtgroup initialization
  *
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8180c539800d..d512455b4c3a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -192,5 +192,6 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

