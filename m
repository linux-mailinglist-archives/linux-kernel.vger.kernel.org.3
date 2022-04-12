Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86AF4FE1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355163AbiDLNJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356407AbiDLND2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:03:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B61F8DFD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:45:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FAEA169C;
        Tue, 12 Apr 2022 05:45:39 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0923F70D;
        Tue, 12 Apr 2022 05:45:37 -0700 (PDT)
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
Subject: [PATCH v4 20/21] x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's boot_cpu_data
Date:   Tue, 12 Apr 2022 12:44:18 +0000
Message-Id: <20220412124419.30689-21-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220412124419.30689-1-james.morse@arm.com>
References: <20220412124419.30689-1-james.morse@arm.com>
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

resctrl_rmid_realloc_threshold can be set by user-space. The maximum
value is specified by the architecture.

Currently max_threshold_occ_write() reads the maximum value from
boot_cpu_data.x86_cache_size, which is not portable to another
architecture.

Add resctrl_rmid_realloc_limit to describe the maximum size in bytes
that user-space can set the threshold to.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 9 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 include/linux/resctrl.h                | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 00f6e27e4e0d..bc5c31920a66 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -64,6 +64,11 @@ unsigned int rdt_mon_features;
  */
 unsigned int resctrl_rmid_realloc_threshold;
 
+/*
+ * This is the maximum value for the reallocation threshold, in bytes.
+ */
+unsigned int resctrl_rmid_realloc_limit;
+
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 /*
@@ -744,10 +749,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	unsigned int threshold;
 	int ret;
 
+	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
@@ -764,7 +769,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	threshold = cl_size * 1024 / r->num_rmid;
+	threshold = resctrl_rmid_realloc_limit / r->num_rmid;
 
 	/*
 	 * Because num_rmid may not be a power of two, round the value
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7c35561e5216..0e9f9a527e6a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1059,7 +1059,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (ret)
 		return ret;
 
-	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
+	if (bytes > resctrl_rmid_realloc_limit)
 		return -EINVAL;
 
 	resctrl_rmid_realloc_threshold = bytes;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index fc4805901f1a..9c360999fb9b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -251,5 +251,6 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
+extern unsigned int resctrl_rmid_realloc_limit;
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

