Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9A5551B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359639AbiFVQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376839AbiFVQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB7B13FDBD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9C7E1042;
        Wed, 22 Jun 2022 09:47:38 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9E73F792;
        Wed, 22 Jun 2022 09:47:36 -0700 (PDT)
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
Subject: [PATCH v5 15/21] x86/resctrl: Abstract __rmid_read()
Date:   Wed, 22 Jun 2022 16:46:23 +0000
Message-Id: <20220622164629.20795-16-james.morse@arm.com>
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

__rmid_read() selects the specified eventid and returns the counter
value from the MSR. The error handling is architecture specific, and
handled by the callers, rdtgroup_mondata_show() and __mon_event_count().

Error handling should be handled by architecture specific code, as
a different architecture may have different requirements. MPAM's
counters can report that they are 'not ready', requiring a second
read after a short delay. This should be hidden from resctrl.

Make __rmid_read() the architecture specific function for reading
a counter. Rename it resctrl_arch_rmid_read() and move the error
handling into it.

A read from a counter that hardware supports but resctrl does not
now returns -EINVAL instead of -EIO from the default case in
__mon_event_count(). It isn't possible for user-space to see this
change as resctrl doesn't expose counters it doesn't support.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Fixed __rmid_read in comment.
 * Renamed ret_val ret.

Changes since v3:
 * Changed return type of __mon_event_count().
 * Clarified comment in mon_event_count()

Changes since v2:
 * Capitalisation
 * Stray newline restored
 * Removed rr->val set to the error value, and replaced it with clearing the
   the error to hide Unavailable from monitor group reads. (and added a block
   comment).

Changes since v1:
 * Return EINVAL from the impossible case in __mon_event_count() instead
   of an x86 hardware specific value.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c     | 62 ++++++++++++++---------
 include/linux/resctrl.h                   |  1 +
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index ece3a1e0e6f2..d3f7eb2ac14b 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
-	if (rr.val & RMID_VAL_ERROR)
+	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
-	else if (rr.val & RMID_VAL_UNAVAIL)
+	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
 		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b34a1403f033..1d2e7bd6305f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -94,6 +94,7 @@ struct rmid_read {
 	struct rdt_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	int			err;
 	u64			val;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e9755143492b..51ab76f2dfbc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,9 +167,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
-static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
+int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
-	u64 val;
+	u64 msr_val;
 
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
@@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
 	 * are error bits.
 	 */
 	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-	rdmsrl(MSR_IA32_QM_CTR, val);
+	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
-	return val;
+	if (msr_val & RMID_VAL_ERROR)
+		return -EIO;
+	if (msr_val & RMID_VAL_UNAVAIL)
+		return -EINVAL;
+
+	*val = msr_val;
+
+	return 0;
 }
 
 static bool rmid_dirty(struct rmid_entry *entry)
 {
-	u64 val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
+	u64 val = 0;
+
+	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
+		return true;
 
 	return val >= resctrl_cqm_threshold;
 }
@@ -259,8 +269,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r;
 	struct rdt_domain *d;
-	int cpu;
-	u64 val;
+	int cpu, err;
+	u64 val = 0;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
@@ -268,8 +278,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
-			if (val <= resctrl_cqm_threshold)
+			err = resctrl_arch_rmid_read(entry->rmid,
+						     QOS_L3_OCCUP_EVENT_ID,
+						     &val);
+			if (err || val <= resctrl_cqm_threshold)
 				continue;
 		}
 
@@ -315,19 +327,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
+static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m;
-	u64 chunks, tval;
+	u64 chunks, tval = 0;
 
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
 
-	tval = __rmid_read(rmid, rr->evtid);
-	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
-		return tval;
-	}
+	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
+	if (rr->err)
+		return rr->err;
+
 	switch (rr->evtid) {
 	case QOS_L3_OCCUP_EVENT_ID:
 		rr->val += tval;
@@ -341,9 +353,9 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 	default:
 		/*
 		 * Code would never reach here because an invalid
-		 * event id would fail the __rmid_read.
+		 * event id would fail in resctrl_arch_rmid_read().
 		 */
-		return RMID_VAL_ERROR;
+		return -EINVAL;
 	}
 
 	if (rr->first) {
@@ -399,11 +411,11 @@ void mon_event_count(void *info)
 	struct rdtgroup *rdtgrp, *entry;
 	struct rmid_read *rr = info;
 	struct list_head *head;
-	u64 ret_val;
+	int ret;
 
 	rdtgrp = rr->rgrp;
 
-	ret_val = __mon_event_count(rdtgrp->mon.rmid, rr);
+	ret = __mon_event_count(rdtgrp->mon.rmid, rr);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups and
@@ -415,13 +427,17 @@ void mon_event_count(void *info)
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
 			if (__mon_event_count(entry->mon.rmid, rr) == 0)
-				ret_val = 0;
+				ret = 0;
 		}
 	}
 
-	/* Report error if none of rmid_reads are successful */
-	if (ret_val)
-		rr->val = ret_val;
+	/*
+	 * __mon_event_count() calls for newly created monitor groups may
+	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
+	 * Discard error if any of the monitor event reads succeeded.
+	 */
+	if (ret == 0)
+		rr->err = 0;
 }
 
 /*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 818456770176..efe60dd7fd21 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -219,6 +219,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
-- 
2.30.2

