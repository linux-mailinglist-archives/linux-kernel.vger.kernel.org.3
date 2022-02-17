Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6DD4BA824
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiBQSYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:24:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbiBQSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:23:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF2F9396A4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:23:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8CC15AD;
        Thu, 17 Feb 2022 10:23:29 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DDB93F718;
        Thu, 17 Feb 2022 10:23:27 -0800 (PST)
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
Subject: [PATCH v3 12/21] x86/resctrl: Calculate bandwidth from the previous __mon_event_count() chunks
Date:   Thu, 17 Feb 2022 18:21:01 +0000
Message-Id: <20220217182110.7176-13-james.morse@arm.com>
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

mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
second. It reads the hardware register, calculates the bandwidth and
updates m->prev_bw_msr which is used to hold the previous hardware register
value.

Operating directly on hardware register values makes it difficult to make
this code architecture independent, so that it can be moved to /fs/,
making the mba_sc feature something resctrl supports with no additional
support from the architecture.
Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
register using __mon_event_count().

Change mbm_bw_count() to use the current chunks value most recently saved by
__mon_event_count(). This removes an extra call to __rmid_read().
Instead of using m->prev_msr to calculate the number of chunks seen,
use the rr->val that was updated by __mon_event_count(). This removes a extra
calls to mbm_overflow_count() and get_corrected_mbm_count().
Calculating bandwidth like this means mbm_bw_count() no longer operates
on hardware register values directly.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Expanded commit message

Changes since v1:
 * This patch was rewritten
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3b9e43ba7590..c50c8911ef59 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -289,7 +289,7 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
- * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
+ * @prev_bw_chunks: Previous chunks value read when for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
@@ -297,7 +297,7 @@ struct rftype {
 struct mbm_state {
 	u64	chunks;
 	u64	prev_msr;
-	u64	prev_bw_msr;
+	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
 	bool	delta_comp;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ac1a2e8998bb..8ae375e29256 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -315,7 +315,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_bw_msr = m->prev_msr = tval;
+		m->prev_msr = tval;
 		return 0;
 	}
 
@@ -329,27 +329,32 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 }
 
 /*
+ * mbm_bw_count() - Update bw count from values previously read by
+ *		    __mon_event_count().
+ * @rmid:	The rmid used to identify the cached mbm_state.
+ * @rr:		The struct rmid_read populated by __mon_event_count().
+ *
  * Supporting function to calculate the memory bandwidth
- * and delta bandwidth in MBps.
+ * and delta bandwidth in MBps. The chunks value previously read by
+ * __mon_event_count() is compared with the chunks value from the previous
+ * invocation. This must be called oncer per second to maintain values in MBps.
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 tval, cur_bw, chunks;
+	u64 cur_bw, chunks, cur_chunks;
 
-	tval = __rmid_read(rmid, rr->evtid);
-	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
-		return;
+	cur_chunks = rr->val;
+	chunks = cur_chunks - m->prev_bw_chunks;
+	m->prev_bw_chunks = cur_chunks;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
-	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
+	cur_bw = (chunks * hw_res->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
 	m->delta_comp = false;
 	m->prev_bw = cur_bw;
-	m->prev_bw_msr = tval;
 }
 
 /*
@@ -509,6 +514,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 	rr.first = false;
 	rr.r = r;
 	rr.d = d;
+	rr.val = 0;
 
 	/*
 	 * This is protected from concurrent reads from user
-- 
2.30.2

