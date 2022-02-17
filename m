Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3054BA828
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbiBQSX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:23:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbiBQSXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:23:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6B273879F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:23:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B47701597;
        Thu, 17 Feb 2022 10:23:23 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84AE23F718;
        Thu, 17 Feb 2022 10:23:21 -0800 (PST)
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
Subject: [PATCH v3 10/21] x86/resctrl: Abstract and use supports_mba_mbps()
Date:   Thu, 17 Feb 2022 18:20:59 +0000
Message-Id: <20220217182110.7176-11-james.morse@arm.com>
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

To determine whether the mba_MBps option to resctrl should be supported,
resctrl tests the boot CPUs' x86_vendor.

This isn't portable, and needs abstracting behind a helper so this check
can be part of the filesystem code that moves to /fs/.

Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
on this system. An 'alloc_capable' test is added so that support for the
controls isn't implied by the 'delay_linear' property, which is always
true for MPAM.

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Capitalisation
 * Added MPAM example in commit message
 * Fixed supports_mba_mbps() logic error in rdt_parse_param()
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 22ebfdb4472d..7ec089d72ab7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1922,11 +1922,21 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
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
@@ -1934,8 +1944,7 @@ static int set_mba_sc(bool mba_sc)
 	struct rdt_domain *d;
 	int i;
 
-	if (!is_mbm_enabled() || !is_mba_linear() ||
-	    mba_sc == is_mba_sc(r))
+	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
@@ -2295,7 +2304,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		if (!supports_mba_mbps())
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
-- 
2.30.2

