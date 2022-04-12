Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6E4FE17A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358031AbiDLNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356355AbiDLND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:03:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F5F426E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:45:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C83E6150C;
        Tue, 12 Apr 2022 05:45:13 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 765653F70D;
        Tue, 12 Apr 2022 05:45:11 -0700 (PDT)
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
Subject: [PATCH v4 10/21] x86/resctrl: Abstract and use supports_mba_mbps()
Date:   Tue, 12 Apr 2022 12:44:08 +0000
Message-Id: <20220412124419.30689-11-james.morse@arm.com>
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

To determine whether the mba_MBps option to resctrl should be supported,
resctrl tests the boot CPUs' x86_vendor.

This isn't portable, and needs abstracting behind a helper so this check
can be part of the filesystem code that moves to /fs/.

Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
on this system. An 'alloc_capable' test is added so that support for the
controls isn't implied by the 'delay_linear' property, which is always
true for MPAM.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Added use in resctrle_online_domain()

Changes since v1:
 * Capitalisation
 * Added MPAM example in commit message
 * Fixed supports_mba_mbps() logic error in rdt_parse_param()
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 441c1b7981c2..f494ca6b8bdd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1922,17 +1922,26 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
 }
 
 /*
- * Enable or disable the MBA software controller
- * which helps user specify bandwidth in MBps.
  * MBA software controller is supported only if
  * MBM is supported and MBA is in linear scale.
  */
+static bool supports_mba_mbps(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+
+	return (is_mbm_enabled() &&
+		r->alloc_capable && is_mba_linear());
+}
+
+/*
+ * Enable or disable the MBA software controller
+ * which helps user specify bandwidth in MBps.
+ */
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	if (!is_mbm_enabled() || !is_mba_linear() ||
-	    mba_sc == is_mba_sc(r))
+	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
@@ -2287,7 +2296,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		if (!supports_mba_mbps())
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
@@ -3336,7 +3345,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (is_mbm_enabled() && r->rid == RDT_RESOURCE_MBA) {
+	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA) {
 		err = mba_sc_domain_allocate(r, d);
 		if (err)
 			return err;
-- 
2.30.2

