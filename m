Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF86E5551A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376829AbiFVQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376767AbiFVQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21F263C709
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11163150C;
        Wed, 22 Jun 2022 09:47:13 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 889453F792;
        Wed, 22 Jun 2022 09:47:10 -0700 (PDT)
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
Subject: [PATCH v5 05/21] x86/resctrl: Add domain offline callback for resctrl work
Date:   Wed, 22 Jun 2022 16:46:13 +0000
Message-Id: <20220622164629.20795-6-james.morse@arm.com>
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
free the memory.

Move the monitor subdir removal and the cancelling of the mbm/limbo
works into a new resctrl_offline_domain() call. These bits are not
specific to the architecture. Grouping them in one function allows
that code to be moved to /fs/ and re-used by another architecture.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Moved kfree()ing to domain_destroy_mon_state() for later re-use.

Changes since v1:
 * Removed a redundant mon_capable check
 * Capitalisation
 * Removed inline comment
 * Added to the commit message
---
 arch/x86/kernel/cpu/resctrl/core.c     | 26 ++-------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 --
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 +++++++++++++++++++++++---
 include/linux/resctrl.h                |  1 +
 4 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e37889f7a1a5..f69182973175 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -523,27 +523,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
-		/*
-		 * If resctrl is mounted, remove all the
-		 * per domain monitor data directories.
-		 */
-		if (static_branch_unlikely(&rdt_mon_enable_key))
-			rmdir_mondata_subdir_allrdtgrp(r, d->id);
+		resctrl_offline_domain(r, d);
 		list_del(&d->list);
-		if (r->mon_capable && is_mbm_enabled())
-			cancel_delayed_work(&d->mbm_over);
-		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
-			/*
-			 * When a package is going down, forcefully
-			 * decrement rmid->ebusy. There is no way to know
-			 * that the L3 was flushed and hence may lead to
-			 * incorrect counts in rare scenarios, but leaving
-			 * the RMID as busy creates RMID leaks if the
-			 * package never comes back.
-			 */
-			__check_limbo(d, true);
-			cancel_delayed_work(&d->cqm_limbo);
-		}
 
 		/*
 		 * rdt_domain "d" is going to be freed below, so clear
@@ -551,11 +532,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		 */
 		if (d->plr)
 			d->plr->d = NULL;
-
-		bitmap_free(d->rmid_busy_llc);
-		kfree(d->mbm_total);
-		kfree(d->mbm_local);
 		domain_free(hw_dom);
+
 		return;
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index be48a682dbdb..e12b55f815bf 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -522,8 +522,6 @@ void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
-void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    unsigned int dom_id);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 030a70326ccc..5830905a92d2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2499,14 +2499,12 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
  * Remove all subdirectories of mon_data of ctrl_mon groups
  * and monitor groups with given domain id.
  */
-void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
+static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   unsigned int dom_id)
 {
 	struct rdtgroup *prgrp, *crgrp;
 	char name[32];
 
-	if (!r->mon_capable)
-		return;
-
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		sprintf(name, "mon_%s_%02d", r->name, dom_id);
 		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
@@ -3233,6 +3231,45 @@ static int __init rdtgroup_setup_root(void)
 	return ret;
 }
 
+static void domain_destroy_mon_state(struct rdt_domain *d)
+{
+	bitmap_free(d->rmid_busy_llc);
+	kfree(d->mbm_total);
+	kfree(d->mbm_local);
+}
+
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!r->mon_capable)
+		return;
+
+	/*
+	 * If resctrl is mounted, remove all the
+	 * per domain monitor data directories.
+	 */
+	if (static_branch_unlikely(&rdt_mon_enable_key))
+		rmdir_mondata_subdir_allrdtgrp(r, d->id);
+
+	if (is_mbm_enabled())
+		cancel_delayed_work(&d->mbm_over);
+	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
+		/*
+		 * When a package is going down, forcefully
+		 * decrement rmid->ebusy. There is no way to know
+		 * that the L3 was flushed and hence may lead to
+		 * incorrect counts in rare scenarios, but leaving
+		 * the RMID as busy creates RMID leaks if the
+		 * package never comes back.
+		 */
+		__check_limbo(d, true);
+		cancel_delayed_work(&d->cqm_limbo);
+	}
+
+	domain_destroy_mon_state(d);
+}
+
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
 	size_t tsize;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d512455b4c3a..5d283bdd6162 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -193,5 +193,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

