Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B775551B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376876AbiFVQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbiFVQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E7BAD9A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00F5513D5;
        Wed, 22 Jun 2022 09:47:54 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 788F63F792;
        Wed, 22 Jun 2022 09:47:51 -0700 (PDT)
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
Subject: [PATCH v5 21/21] x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
Date:   Wed, 22 Jun 2022 16:46:29 +0000
Message-Id: <20220622164629.20795-22-james.morse@arm.com>
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

resctrl_arch_rmid_read() returns a value in chunks, as read from the
hardware. This needs scaling to bytes by mon_scale, as provided by
the architecture code.

Now that resctrl_arch_rmid_read() performs the overflow and corrections
itself, it may as well return a value in bytes directly. This allows
the accesses to the architecture specific 'hw' structure to be removed.

Move the mon_scale conversion into resctrl_arch_rmid_read().
mbm_bw_count() is updated to calculate bandwidth from bytes.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Only set val in one place in restrl_arch_rmid_read()
 * Use SZ_1M to improve readability
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  6 ++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 24 +++++++++++------------
 include/linux/resctrl.h                   |  2 +-
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index d3f7eb2ac14b..03fc91d8bc9f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -549,7 +549,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
-	struct rdt_hw_resource *hw_res;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -569,8 +568,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	domid = md.u.domid;
 	evtid = md.u.evtid;
 
-	hw_res = &rdt_resources_all[resid];
-	r = &hw_res->r_resctrl;
+	r = &rdt_resources_all[resid].r_resctrl;
 	d = rdt_find_domain(r, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
@@ -584,7 +582,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
+		seq_printf(m, "%llu\n", rr.val);
 
 out:
 	rdtgroup_kn_unlock(of->kn);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c05e9b7cf77a..5f7128686cfd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -279,13 +279,13 @@ struct rftype {
 
 /**
  * struct mbm_state - status for each MBM counter in each domain
- * @prev_bw_chunks: Previous chunks value read for bandwidth calculation
+ * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
-	u64	prev_bw_chunks;
+	u64	prev_bw_bytes;
 	u32	prev_bw;
 	u32	delta_bw;
 	bool	delta_comp;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8d15568d7121..efe0c30d3a12 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
@@ -189,7 +190,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
-	u64 msr_val;
+	u64 msr_val, chunks;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
@@ -214,12 +215,14 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (am) {
 		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
 						 hw_res->mbm_width);
-		*val = get_corrected_mbm_count(rmid, am->chunks);
+		chunks = get_corrected_mbm_count(rmid, am->chunks);
 		am->prev_msr = msr_val;
 	} else {
-		*val = msr_val;
+		chunks = msr_val;
 	}
 
+	*val = chunks * hw_res->mon_scale;
+
 	return 0;
 }
 
@@ -232,7 +235,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rmid_entry *entry;
 	u32 crmid = 1, nrmid;
 	bool rmid_dirty;
@@ -255,7 +257,6 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
 		} else {
-			val *= hw_res->mon_scale;
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
 		}
 
@@ -299,7 +300,6 @@ int alloc_rmid(void)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
@@ -311,7 +311,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
-			val *= hw_res->mon_scale;
 			if (err || val <= resctrl_rmid_realloc_threshold)
 				continue;
 		}
@@ -403,15 +402,14 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 cur_bw, chunks, cur_chunks;
+	u64 cur_bw, bytes, cur_bytes;
 
-	cur_chunks = rr->val;
-	chunks = cur_chunks - m->prev_bw_chunks;
-	m->prev_bw_chunks = cur_chunks;
+	cur_bytes = rr->val;
+	bytes = cur_bytes - m->prev_bw_bytes;
+	m->prev_bw_bytes = cur_bytes;
 
-	cur_bw = (chunks * hw_res->mon_scale) >> 20;
+	cur_bw = bytes / SZ_1M;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index cb857f753322..0cf5b20c6ddf 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -227,7 +227,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @d:			domain that the counter should be read from.
  * @rmid:		rmid of the counter to read.
  * @eventid:		eventid to read, e.g. L3 occupancy.
- * @val:		result of the counter read in chunks.
+ * @val:		result of the counter read in bytes.
  *
  * Call from process context on a CPU that belongs to domain @d.
  *
-- 
2.30.2

