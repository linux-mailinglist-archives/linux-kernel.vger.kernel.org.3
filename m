Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939654BA823
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbiBQSYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244395AbiBQSYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:24:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB963D493
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:23:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A59615DB;
        Thu, 17 Feb 2022 10:23:53 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A7C83F718;
        Thu, 17 Feb 2022 10:23:51 -0800 (PST)
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
Subject: [PATCH v3 20/21] x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's boot_cpu_data
Date:   Thu, 17 Feb 2022 18:21:09 +0000
Message-Id: <20220217182110.7176-21-james.morse@arm.com>
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

resctrl_rmid_realloc_threshold can be set by user-space. The maximum
value is specified by the architecture.

Currently max_threshold_occ_write() reads the maximum value from
boot_cpu_data.x86_cache_size, which is not portable to another
architecture.

Add resctrl_rmid_realloc_limit to describe the maximum size in bytes
that user-space can set the threshold to.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 9 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 include/linux/resctrl.h                | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e91d9a7024a2..3a6555f49720 100644
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
@@ -744,9 +749,9 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
+	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
@@ -763,7 +768,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	resctrl_rmid_realloc_threshold = cl_size * 1024 / r->num_rmid;
+	resctrl_rmid_realloc_threshold = resctrl_rmid_realloc_limit / r->num_rmid;
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 93b3697027df..f77ee0f13efb 100644
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
index c79a180e578c..fc00bf1bafa7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -249,5 +249,6 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
+extern unsigned int resctrl_rmid_realloc_limit;
 
 #endif /* _RESCTRL_H */
-- 
2.30.2

