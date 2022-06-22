Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44A05551A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376889AbiFVQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359307AbiFVQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9644C37BCE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 785981477;
        Wed, 22 Jun 2022 09:47:28 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6AA3F792;
        Wed, 22 Jun 2022 09:47:25 -0700 (PDT)
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
Subject: [PATCH v5 11/21] x86/resctrl: Allow update_mba_bw() to update controls directly
Date:   Wed, 22 Jun 2022 16:46:19 +0000
Message-Id: <20220622164629.20795-12-james.morse@arm.com>
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

update_mba_bw() calculates a new control value for the MBA resource
based on the user provided mbps_val and the current measured
bandwidth. Some control values need remapping by delay_bw_map().

It does this by calling wrmsrl() directly. This needs splitting
up to be done by an architecture specific helper, so that the
remainder can eventually be moved to /fs/.

Add resctrl_arch_update_one() to apply one configuration value
to the provided resource and domain. This avoids the staging
and cross-calling that is only needed with changes made by
user-space. delay_bw_map() moves to be part of the arch code,
to maintain the 'percentage control' view of MBA resources
in resctrl.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Call msr_update() directly from resctrl_arch_update_one().

Changes since v1:
 * Capitalisation
---
 arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 21 +++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 -
 arch/x86/kernel/cpu/resctrl/monitor.c     | 13 ++++---------
 include/linux/resctrl.h                   |  8 ++++++++
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f0e2820af475..90ebb7d71af2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -296,7 +296,7 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
  * that can be written to QOS_MSRs.
  * There are currently no SKUs which support non linear delay values.
  */
-u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
+static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 {
 	if (r->membw.delay_linear)
 		return MAX_MBA_BW - bw;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9f45207a6c74..ece3a1e0e6f2 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -282,6 +282,27 @@ static bool apply_config(struct rdt_hw_domain *hw_dom,
 	return false;
 }
 
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	u32 idx = get_config_index(closid, t);
+	struct msr_param msr_param;
+
+	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
+		return -EINVAL;
+
+	hw_dom->ctrl_val[idx] = cfg_val;
+
+	msr_param.res = r;
+	msr_param.low = idx;
+	msr_param.high = idx + 1;
+	hw_res->msr_update(d, &msr_param, r);
+
+	return 0;
+}
+
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 373aaba53ecd..3b9e43ba7590 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -527,7 +527,6 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 16028b2f756a..3e69386cfe00 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -420,10 +420,8 @@ void mon_event_count(void *info)
  */
 static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
-	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
+	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	struct rdt_hw_resource *hw_r_mba;
-	struct rdt_hw_domain *hw_dom_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
@@ -433,8 +431,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	if (!is_mbm_local_enabled())
 		return;
 
-	hw_r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
-	r_mba = &hw_r_mba->r_resctrl;
+	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
 	pmbm_data = &dom_mbm->mbm_local[rmid];
@@ -444,7 +442,6 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
 	}
-	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
 	user_bw = dom_mba->mbps_val[closid];
@@ -486,9 +483,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		return;
 	}
 
-	cur_msr = hw_r_mba->msr_base + closid;
-	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
-	hw_dom_mba->ctrl_val[closid] = new_msr_val;
+	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
 
 	/*
 	 * Delta values are updated dynamically package wise for each
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 93dfe553b364..f4c9101df461 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -197,6 +197,14 @@ struct resctrl_schema {
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
+
+/*
+ * Update the ctrl_val and apply this config right now.
+ * Must be called on one of the domain's CPUs.
+ */
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val);
+
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
-- 
2.30.2

