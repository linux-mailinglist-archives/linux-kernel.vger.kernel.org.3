Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC54BA812
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbiBQSXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:23:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbiBQSXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:23:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3899138BF1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:23:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 062A21576;
        Thu, 17 Feb 2022 10:23:18 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC713F718;
        Thu, 17 Feb 2022 10:23:15 -0800 (PST)
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
Subject: [PATCH v3 08/21] x86/resctrl: Switch over to the resctrl mbps_val list
Date:   Thu, 17 Feb 2022 18:20:57 +0000
Message-Id: <20220217182110.7176-9-james.morse@arm.com>
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

Updates to resctrl's software controller follow the same path as
other configuration updates, but they don't modify the hardware state.
rdtgroup_schemata_write() uses parse_line() and the resource's
parse_ctrlval() function to stage the configuration.
resctrl_arch_update_domains() then updates the mbps_val[] array
instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
call that would update hardware.

This complicates the interface between resctrl's filesystem parts
and architecture specific code. It should be possible for mba_sc
to be completely implemented by the filesystem parts of resctrl. This
would allow it to work on a second architecture with no additional code.
resctrl_arch_update_domains() using the mbps_val[] array prevents this.

Change parse_bw() to write the configuration value directly to the
mbps_val[] array in the domain structure. Change rdtgroup_schemata_write()
to skip the call to resctrl_arch_update_domains(), meaning all the
mba_sc specific code in resctrl_arch_update_domains() can be removed.
On the read-side, show_doms() and update_mba_bw() are changed to read
the mbps_val[] array from the domain structure. With this,
resctrl_arch_get_config() no longer needs to consider mba_sc resources.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Fixed some names in the commit message.
 * Added missing 'or mbps_val[]' code to rdtgroup_size_show()

Changes since v1:
 * Squashed out struct resctrl_mba_sc
 * Removed stray paragraphs from commit message
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 44 ++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 10 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 ++++++--
 3 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 87666275eed9..9f45207a6c74 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -61,6 +61,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
 	struct resctrl_staged_config *cfg;
+	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
@@ -72,6 +73,12 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 
 	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
+
+	if (is_mba_sc(r)) {
+		d->mbps_val[closid] = bw_val;
+		return 0;
+	}
+
 	cfg->new_ctrl = bw_val;
 	cfg->have_new_ctrl = true;
 
@@ -261,14 +268,13 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 
 static bool apply_config(struct rdt_hw_domain *hw_dom,
 			 struct resctrl_staged_config *cfg, u32 idx,
-			 cpumask_var_t cpu_mask, bool mba_sc)
+			 cpumask_var_t cpu_mask)
 {
 	struct rdt_domain *dom = &hw_dom->d_resctrl;
-	u32 *dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 
-	if (cfg->new_ctrl != dc[idx]) {
+	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		dc[idx] = cfg->new_ctrl;
+		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
 
 		return true;
 	}
@@ -284,14 +290,12 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	bool mba_sc;
 	int cpu;
 	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	mba_sc = is_mba_sc(r);
 	msr_param.res = NULL;
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
@@ -301,7 +305,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 				continue;
 
 			idx = get_config_index(closid, t);
-			if (!apply_config(hw_dom, cfg, idx, cpu_mask, mba_sc))
+			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
 				continue;
 
 			if (!msr_param.res) {
@@ -315,11 +319,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 		}
 	}
 
-	/*
-	 * Avoid writing the control msr with control values when
-	 * MBA software controller is enabled
-	 */
-	if (cpumask_empty(cpu_mask) || mba_sc)
+	if (cpumask_empty(cpu_mask))
 		goto done;
 	cpu = get_cpu();
 	/* Update resource control msr on this CPU if it's in cpu_mask. */
@@ -406,6 +406,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
+
+		/*
+		 * Writes to mba_sc resources update the software controller,
+		 * not the control msr.
+		 */
+		if (is_mba_sc(r))
+			continue;
+
 		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
@@ -433,9 +441,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	u32 idx = get_config_index(closid, type);
 
-	if (!is_mba_sc(r))
-		return hw_dom->ctrl_val[idx];
-	return hw_dom->mbps_val[idx];
+	return hw_dom->ctrl_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
@@ -450,8 +456,12 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = resctrl_arch_get_config(r, dom, closid,
-						   schema->conf_type);
+		if (is_mba_sc(r))
+			ctrl_val = dom->mbps_val[closid];
+		else
+			ctrl_val = resctrl_arch_get_config(r, dom, closid,
+							   schema->conf_type);
+
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 497cadf3285d..5cc1e6b229d4 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -447,13 +447,11 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
+	user_bw = dom_mba->mbps_val[closid];
 	delta_bw = pmbm_data->delta_bw;
-	/*
-	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
-	 * based on is_mba_sc(). For now, reach into the hw_dom.
-	 */
-	cur_msr_val = hw_dom_mba->ctrl_val[closid];
+
+	/* MBA monitor resource doesn't support CDP */
+	cur_msr_val = resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e4313f907eb6..7b8a23e2eadd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1356,11 +1356,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
 	struct resctrl_schema *schema;
+	enum resctrl_conf_type type;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 	unsigned int size;
 	int ret = 0;
+	u32 closid;
 	bool sep;
 	u32 ctrl;
 
@@ -1386,8 +1388,11 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		goto out;
 	}
 
+	closid = rdtgrp->closid;
+
 	list_for_each_entry(schema, &resctrl_schema_all, list) {
 		r = schema->res;
+		type = schema->conf_type;
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
@@ -1396,9 +1401,12 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				ctrl = resctrl_arch_get_config(r, d,
-							       rdtgrp->closid,
-							       schema->conf_type);
+				if (is_mba_sc(r))
+					ctrl = d->mbps_val[closid];
+				else
+					ctrl = resctrl_arch_get_config(r, d,
+								       closid,
+								       type);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
-- 
2.30.2

