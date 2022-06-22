Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5338E5551AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376875AbiFVQuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376844AbiFVQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2761403F0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1CDD12FC;
        Wed, 22 Jun 2022 09:47:43 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 453773F792;
        Wed, 22 Jun 2022 09:47:41 -0700 (PDT)
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
Subject: [PATCH v5 17/21] x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
Date:   Wed, 22 Jun 2022 16:46:25 +0000
Message-Id: <20220622164629.20795-18-james.morse@arm.com>
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
read a value in bytes from a counter. Currently the function returns
the MBM values in chunks directly from hardware. When reading a bandwidth
counter, mbm_overflow_count() must be used to correct for any possible
overflow.

mbm_overflow_count() is architecture specific, its behaviour should
be part of resctrl_arch_rmid_read().

Move the mbm_overflow_count() calls into resctrl_arch_rmid_read().
This allows the resctrl filesystems's prev_msr to be removed in
favour of the architecture private version.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 --
 arch/x86/kernel/cpu/resctrl/monitor.c  | 35 +++++++++++++++-----------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1d2e7bd6305f..8039e8aba7de 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -281,7 +281,6 @@ struct rftype {
 /**
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
- * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
  * @prev_bw_chunks: Previous chunks value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
@@ -289,7 +288,6 @@ struct rftype {
  */
 struct mbm_state {
 	u64	chunks;
-	u64	prev_msr;
 	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 262141bf4264..862a4462ed60 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,9 +167,20 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
+static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
+{
+	u64 shift = 64 - width, chunks;
+
+	chunks = (cur_msr << shift) - (prev_msr << shift);
+	return chunks >> shift;
+}
+
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct arch_mbm_state *am;
 	u64 msr_val;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
@@ -191,7 +202,13 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (msr_val & RMID_VAL_UNAVAIL)
 		return -EINVAL;
 
-	*val = msr_val;
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am) {
+		*val = mbm_overflow_count(am->prev_msr, msr_val, hw_res->mbm_width);
+		am->prev_msr = msr_val;
+	} else {
+		*val = msr_val;
+	}
 
 	return 0;
 }
@@ -322,19 +339,10 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
-{
-	u64 shift = 64 - width, chunks;
-
-	chunks = (cur_msr << shift) - (prev_msr << shift);
-	return chunks >> shift;
-}
-
 static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m;
-	u64 chunks, tval = 0;
+	u64 tval = 0;
 
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
@@ -363,13 +371,10 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_msr = tval;
 		return 0;
 	}
 
-	chunks = mbm_overflow_count(m->prev_msr, tval, hw_res->mbm_width);
-	m->chunks += chunks;
-	m->prev_msr = tval;
+	m->chunks += tval;
 
 	rr->val += get_corrected_mbm_count(rmid, m->chunks);
 
-- 
2.30.2

