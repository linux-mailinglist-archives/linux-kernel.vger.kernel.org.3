Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6712255519B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376793AbiFVQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359020AbiFVQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24E5839170
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:46:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 146D313D5;
        Wed, 22 Jun 2022 09:46:59 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4743F792;
        Wed, 22 Jun 2022 09:46:56 -0700 (PDT)
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
Subject: [PATCH v5 01/21] x86/resctrl: Kill off alloc_enabled
Date:   Wed, 22 Jun 2022 16:46:09 +0000
Message-Id: <20220622164629.20795-2-james.morse@arm.com>
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

rdt_resources_all[] used to have extra entries for L2CODE/L2DATA.
These were hidden from resctrl by the alloc_enabled value.

Now that the L2/L2CODE/L2DATA resources have been merged together,
alloc_enabled doesn't mean anything, it always has the same value as
alloc_capable which indicates allocation is supported by this resource.

Remove alloc_enabled and its helpers.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Removed duplicate words from commit message.

Changes since v1:
 * Fixed comment in rdtgroup_create_info_dir()
---
 arch/x86/kernel/cpu/resctrl/core.c        | 4 ----
 arch/x86/kernel/cpu/resctrl/internal.h    | 4 ----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 6 +++---
 include/linux/resctrl.h                   | 2 --
 5 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bb1c3f5f60c8..2f87177f1f69 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -147,7 +147,6 @@ static inline void cache_alloc_hsw_probe(void)
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	rdt_alloc_capable = true;
 }
@@ -211,7 +210,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	thread_throttle_mode_init();
 
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	return true;
 }
@@ -242,7 +240,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	r->data_width = 4;
 
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	return true;
 }
@@ -261,7 +258,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.shareable_bits = ebx & r->default_ctrl;
 	r->data_width = (r->cache.cbm_len + 3) / 4;
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 }
 
 static void rdt_get_cdp_config(int level)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1d647188a43b..53f3d275a98f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -459,10 +459,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 	for_each_rdt_resource(r)					      \
 		if (r->mon_capable)
 
-#define for_each_alloc_enabled_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_enabled)
-
 #define for_each_mon_enabled_rdt_resource(r)				      \
 	for_each_rdt_resource(r)					      \
 		if (r->mon_enabled)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index db813f819ad6..f810969ced4b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -835,7 +835,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	 * First determine which cpus have pseudo-locked regions
 	 * associated with them.
 	 */
-	for_each_alloc_enabled_rdt_resource(r) {
+	for_each_alloc_capable_rdt_resource(r) {
 		list_for_each_entry(d_i, &r->domains, list) {
 			if (d_i->plr)
 				cpumask_or(cpu_with_psl, cpu_with_psl,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f276aff521e8..526eb933333b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1756,7 +1756,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	if (ret)
 		goto out_destroy;
 
-	/* loop over enabled controls, these are all alloc_enabled */
+	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		fflags =  r->fflags | RF_CTRL_INFO;
@@ -2106,7 +2106,7 @@ static int schemata_list_create(void)
 	struct rdt_resource *r;
 	int ret = 0;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	for_each_alloc_capable_rdt_resource(r) {
 		if (resctrl_arch_get_cdp_enabled(r->rid)) {
 			ret = schemata_list_add(r, CDP_CODE);
 			if (ret)
@@ -2452,7 +2452,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	set_mba_sc(false);
 
 	/*Put everything back to default values. */
-	for_each_alloc_enabled_rdt_resource(r)
+	for_each_alloc_capable_rdt_resource(r)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 21deb5212bbd..386ab3a41500 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -130,7 +130,6 @@ struct resctrl_schema;
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
- * @alloc_enabled:	Is allocation enabled on this machine
  * @mon_enabled:	Is monitoring enabled for this feature
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
@@ -150,7 +149,6 @@ struct resctrl_schema;
  */
 struct rdt_resource {
 	int			rid;
-	bool			alloc_enabled;
 	bool			mon_enabled;
 	bool			alloc_capable;
 	bool			mon_capable;
-- 
2.30.2

