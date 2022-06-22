Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671E5551A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376850AbiFVQtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376350AbiFVQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C92F03FD83
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2B4313D5;
        Wed, 22 Jun 2022 09:47:20 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 353023F792;
        Wed, 22 Jun 2022 09:47:18 -0700 (PDT)
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
Subject: [PATCH v5 08/21] x86/resctrl: Create mba_sc configuration in the rdt_domain
Date:   Wed, 22 Jun 2022 16:46:16 +0000
Message-Id: <20220622164629.20795-9-james.morse@arm.com>
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

To support resctrl's MBA software controller, the architecture must provide
a second configuration array to hold the mbps_val[] from user-space.

This complicates the interface between the architecture specific code and
the filesystem portions of resctrl that will move to /fs/, to allow
multiple architectures to support resctrl.

Make the filesystem parts of resctrl create an array for the mba_sc
values. The software controller can be changed to use this, allowing
the architecture code to only consider the values configured in hardware.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v4:
 * Use supports_mba_mbps() in resctrl_{on,off}line_domain().
 * Don't call mba_sc_domain_destroy() for error handling - it can't happen.
 * Whitespace.

Changes since v3:
 * Always allocate the array.
 * Move the array allocation above the r->mon_capable check.

Changes since v2:
 * Split patch in two, the liftime parts are a separate patch.
 * Added reset in set_mba_sc() now that we can't depend on the lifetime.
 * Initialise ret in mba_sc_allocate(),
 * Made mbps_val allocation/freeing symmetric for cpuhp calls.
 * Removed reference to squashed-out struct.
 * Preserved kerneldoc for mbps_val.

Changes since v1:
 * Added missing error handling to mba_sc_domain_allocate() in
   domain_setup_mon_state()
 * Added comment about mba_sc_domain_allocate() races
 * Squashed out struct resctrl_mba_sc
 * Moved mount time alloc/free calls to set_mba_sc().
 * Removed mount check in resctrl_offline_domain()
 * Reword commit message
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 ++++++++++++++++++++++++++
 include/linux/resctrl.h                |  7 +++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e12b55f815bf..a7e2cbce29d5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -36,7 +36,6 @@
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
-#define MBA_MAX_MBPS			U32_MAX
 #define MAX_MBA_BW_AMD			0x800
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 49d9e2c3c743..bb1faf4f5b38 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1889,6 +1889,30 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
+static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_domain *d)
+{
+	u32 num_closid = resctrl_arch_get_num_closid(r);
+	int cpu = cpumask_any(&d->cpu_mask);
+	int i;
+
+	d->mbps_val = kcalloc_node(num_closid, sizeof(*d->mbps_val),
+				   GFP_KERNEL, cpu_to_node(cpu));
+	if (!d->mbps_val)
+		return -ENOMEM;
+
+	for (i = 0; i < num_closid; i++)
+		d->mbps_val[i] = MBA_MAX_MBPS;
+
+	return 0;
+}
+
+static void mba_sc_domain_destroy(struct rdt_resource *r,
+				  struct rdt_domain *d)
+{
+	kfree(d->mbps_val);
+	d->mbps_val = NULL;
+}
+
 /*
  * MBA software controller is supported only if
  * MBM is supported and MBA is in linear scale.
@@ -1908,12 +1932,20 @@ static bool supports_mba_mbps(void)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	u32 num_closid = resctrl_arch_get_num_closid(r);
+	struct rdt_domain *d;
+	int i;
 
 	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
 
+	list_for_each_entry(d, &r->domains, list) {
+		for (i = 0; i < num_closid; i++)
+			d->mbps_val[i] = MBA_MAX_MBPS;
+	}
+
 	return 0;
 }
 
@@ -3247,6 +3279,9 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
+		mba_sc_domain_destroy(r, d);
+
 	if (!r->mon_capable)
 		return;
 
@@ -3311,6 +3346,10 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
+	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
+		/* RDT_RESOURCE_MBA is never mon_capable */
+		return mba_sc_domain_allocate(r, d);
+
 	if (!r->mon_capable)
 		return 0;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5d283bdd6162..93dfe553b364 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,6 +15,9 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
+/* max value for struct rdt_domain's mbps_val */
+#define MBA_MAX_MBPS   U32_MAX
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
@@ -53,6 +56,9 @@ struct resctrl_staged_config {
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
  * @staged_config:	parsed configuration to be applied
+ * @mbps_val:		When mba_sc is enabled, this holds the array of user
+ *			specified control values for mba_sc in MBps, indexed
+ *			by closid
  */
 struct rdt_domain {
 	struct list_head		list;
@@ -67,6 +73,7 @@ struct rdt_domain {
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
 	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
+	u32				*mbps_val;
 };
 
 /**
-- 
2.30.2

