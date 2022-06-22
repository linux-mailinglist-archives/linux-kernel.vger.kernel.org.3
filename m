Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0478C5551AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376960AbiFVQuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376841AbiFVQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD195403D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B7E613D5;
        Wed, 22 Jun 2022 09:47:41 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B2F3F792;
        Wed, 22 Jun 2022 09:47:38 -0700 (PDT)
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
Subject: [PATCH v5 16/21] x86/resctrl: Pass the required parameters into resctrl_arch_rmid_read()
Date:   Wed, 22 Jun 2022 16:46:24 +0000
Message-Id: <20220622164629.20795-17-james.morse@arm.com>
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

resctrl_arch_rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a hardware register. Currently the function
returns the MBM values in chunks directly from hardware.

To convert this to bytes, some correction and overflow calculations
are needed. These depend on the resource and domain structures.
Overflow detection requires the old chunks value. None of this
is available to resctrl_arch_rmid_read(). MPAM requires the
resource and domain structures to find the MMIO device that holds
the registers.

Pass the resource and domain to resctrl_arch_rmid_read(). This makes
rmid_dirty() too big. Instead merge it with its only caller, and the
name is kept as a local variable.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Added comment about where resctrl_arch_rmid_read() can be called from.

Changes since v2:
 * Typos.
 * Kerneldoc fixes.

This is all a little noisy for __mon_event_count(), as the switch
statement work is now before the resctrl_arch_rmid_read() call.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 31 +++++++++++++++------------
 include/linux/resctrl.h               | 18 +++++++++++++++-
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 51ab76f2dfbc..262141bf4264 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
-int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
 	u64 msr_val;
 
+	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
+		return -EINVAL;
+
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
 	 * with a valid event code for supported resource type and the bits
@@ -192,16 +196,6 @@ int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	return 0;
 }
 
-static bool rmid_dirty(struct rmid_entry *entry)
-{
-	u64 val = 0;
-
-	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
-		return true;
-
-	return val >= resctrl_cqm_threshold;
-}
-
 /*
  * Check the RMIDs that are marked as busy for this domain. If the
  * reported LLC occupancy is below the threshold clear the busy bit and
@@ -213,6 +207,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	struct rmid_entry *entry;
 	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
+	bool rmid_dirty;
+	u64 val = 0;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
@@ -228,7 +224,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(nrmid);
-		if (force_free || !rmid_dirty(entry)) {
+
+		if (resctrl_arch_rmid_read(r, d, entry->rmid,
+					   QOS_L3_OCCUP_EVENT_ID, &val))
+			rmid_dirty = true;
+		else
+			rmid_dirty = (val >= resctrl_cqm_threshold);
+
+		if (force_free || !rmid_dirty) {
 			clear_bit(entry->rmid, d->rmid_busy_llc);
 			if (!--entry->busy) {
 				rmid_limbo_count--;
@@ -278,7 +281,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			err = resctrl_arch_rmid_read(entry->rmid,
+			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
 			if (err || val <= resctrl_cqm_threshold)
@@ -336,7 +339,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
 
-	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
+	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
 	if (rr->err)
 		return rr->err;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index efe60dd7fd21..7ccfa0d1bb34 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -219,7 +219,23 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
-int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
+
+/**
+ * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
+ *			      for this resource and domain.
+ * @r:			resource that the counter should be read from.
+ * @d:			domain that the counter should be read from.
+ * @rmid:		rmid of the counter to read.
+ * @eventid:		eventid to read, e.g. L3 occupancy.
+ * @val:		result of the counter read in chunks.
+ *
+ * Call from process context on a CPU that belongs to domain @d.
+ *
+ * Return:
+ * 0 on success, or -EIO, -EINVAL etc on error.
+ */
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
-- 
2.30.2

