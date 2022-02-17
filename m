Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB14BA81C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiBQSYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:24:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiBQSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:24:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCCCF3E5EF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:23:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C4BD15BF;
        Thu, 17 Feb 2022 10:23:56 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CDB93F718;
        Thu, 17 Feb 2022 10:23:54 -0800 (PST)
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
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
Subject: [PATCH v3 21/21] x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
Date:   Thu, 17 Feb 2022 18:21:10 +0000
Message-Id: <20220217182110.7176-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220217182110.7176-1-james.morse@arm.com>
References: <20220217182110.7176-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  6 ++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 22 +++++++++-------------
 include/linux/resctrl.h                   |  2 +-
 4 files changed, 14 insertions(+), 20 deletions(-)

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
index e26a4d67e204..d6ce6ce91885 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -279,13 +279,13 @@ struct rftype {
 
 /**
  * struct mbm_state - status for each MBM counter in each domain
- * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
+ * @prev_bw_bytes: Previous bytes value read when for bandwidth calculation
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
index 3a6555f49720..437e7db77f93 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -186,7 +186,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
-	u64 msr_val;
+	u64 msr_val, chunks;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
@@ -211,10 +211,11 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (am) {
 		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
 						 hw_res->mbm_width);
-		*val = get_corrected_mbm_count(rmid, am->chunks);
+		chunks = get_corrected_mbm_count(rmid, am->chunks);
+		*val = chunks * hw_res->mon_scale;
 		am->prev_msr = msr_val;
 	} else {
-		*val = msr_val;
+		*val = msr_val * hw_res->mon_scale;
 	}
 
 	return 0;
@@ -229,7 +230,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rmid_entry *entry;
 	u32 crmid = 1, nrmid;
 	bool rmid_dirty;
@@ -252,7 +252,6 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
 		} else {
-			val *= hw_res->mon_scale;
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
 		}
 
@@ -296,7 +295,6 @@ int alloc_rmid(void)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
@@ -308,7 +306,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
-			val *= hw_res->mon_scale;
 			if (err || val <= resctrl_rmid_realloc_threshold)
 				continue;
 		}
@@ -400,15 +397,14 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
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
+	cur_bw = bytes >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index fc00bf1bafa7..4e0a7a549280 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -227,7 +227,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @d:			domain that the counter should be read from.
  * @rmid:		rmid of the counter to read.
  * @eventid:		eventid to read, e.g. L3 occupancy.
- * @val:		result of the counter read in chunks.
+ * @val:		result of the counter read in bytes.
  *
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
-- 
2.30.2

