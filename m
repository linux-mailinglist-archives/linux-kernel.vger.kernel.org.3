Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13D5551B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376861AbiFVQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376729AbiFVQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19F303FDAE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E54E512FC;
        Wed, 22 Jun 2022 09:47:25 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6897E3F792;
        Wed, 22 Jun 2022 09:47:23 -0700 (PDT)
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
Subject: [PATCH v5 10/21] x86/resctrl: Remove architecture copy of mbps_val
Date:   Wed, 22 Jun 2022 16:46:18 +0000
Message-Id: <20220622164629.20795-11-james.morse@arm.com>
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

The resctrl arch code provides a second configuration array mbps_val[]
for the MBA software controller.

Since resctrl switched over to allocating and freeing its own array
when needed, nothing uses the arch code version.

Remove it.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Made setup_default_ctrlval() static.

Changes since v1:
 * Fixed spelling mistake
 * Capitalisation
---
 arch/x86/kernel/cpu/resctrl/core.c     | 20 ++++----------------
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +---
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f69182973175..f0e2820af475 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -397,7 +397,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	return NULL;
 }
 
-void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
+static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	int i;
@@ -406,18 +406,14 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	 * Initialize the Control MSRs to having no control.
 	 * For Cache Allocation: Set all bits in cbm
 	 * For Memory Allocation: Set b/w requested to 100%
-	 * and the bandwidth in MBps to U32_MAX
 	 */
-	for (i = 0; i < hw_res->num_closid; i++, dc++, dm++) {
+	for (i = 0; i < hw_res->num_closid; i++, dc++)
 		*dc = r->default_ctrl;
-		*dm = MBA_MAX_MBPS;
-	}
 }
 
 static void domain_free(struct rdt_hw_domain *hw_dom)
 {
 	kfree(hw_dom->ctrl_val);
-	kfree(hw_dom->mbps_val);
 	kfree(hw_dom);
 }
 
@@ -426,23 +422,15 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct msr_param m;
-	u32 *dc, *dm;
+	u32 *dc;
 
 	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val),
 			   GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val),
-			   GFP_KERNEL);
-	if (!dm) {
-		kfree(dc);
-		return -ENOMEM;
-	}
-
 	hw_dom->ctrl_val = dc;
-	hw_dom->mbps_val = dm;
-	setup_default_ctrlval(r, dc, dm);
+	setup_default_ctrlval(r, dc);
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a7e2cbce29d5..373aaba53ecd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -308,14 +308,12 @@ struct mbm_state {
  *			  a resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
- * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
-	u32				*mbps_val;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -529,7 +527,6 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2b43bb9a9b76..572fc07c9608 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2370,10 +2370,8 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
-		for (i = 0; i < hw_res->num_closid; i++) {
+		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
-			hw_dom->mbps_val[i] = MBA_MAX_MBPS;
-		}
 	}
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
-- 
2.30.2

