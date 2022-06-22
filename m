Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC23E5551A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376935AbiFVQt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376832AbiFVQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2859403EB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9142E150C;
        Wed, 22 Jun 2022 09:47:33 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 148733F792;
        Wed, 22 Jun 2022 09:47:30 -0700 (PDT)
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
Subject: [PATCH v5 13/21] x86/resctrl: Add per-rmid arch private storage for overflow and chunks
Date:   Wed, 22 Jun 2022 16:46:21 +0000
Message-Id: <20220622164629.20795-14-james.morse@arm.com>
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

A renamed __rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a counter. Currently the function returns
the MBM values in chunks directly from hardware. For bandwidth
counters the resctrl filesystem uses this to calculate the number of
bytes ever seen.

MPAM's scaling of counters can be changed at runtime, reducing the
resolution but increasing the range. When this is changed the prev_msr
values need to be converted by the architecture code.

Add an array for per-rmid private storage. The prev_msr and chunks
values will move here to allow resctrl_arch_rmid_read() to always
return the number of bytes read by this counter without assistance
from the filesystem. The values are moved in later patches when
the overflow and correction calls are moved into __rmid_read().

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Capitalisation
 * Use __rmid_read() as this patch is earlier in the series.
 * kfree() one array in arch_domain_mbm_alloc() when allocating the other
   fails, instead of relying on domain_free().
 * Remove the documentation that domain_free() has to be called to cleanup
   if this call fails.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 35 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 14 +++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 90ebb7d71af2..de62b0b87ced 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -413,6 +413,8 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 
 static void domain_free(struct rdt_hw_domain *hw_dom)
 {
+	kfree(hw_dom->arch_mbm_total);
+	kfree(hw_dom->arch_mbm_local);
 	kfree(hw_dom->ctrl_val);
 	kfree(hw_dom);
 }
@@ -438,6 +440,34 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+/**
+ * arch_domain_mbm_alloc() - Allocate arch private storage for the MBM counters
+ * @num_rmid:	The size of the MBM counter array
+ * @hw_dom:	The domain that owns the allocated arrays
+ */
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
+{
+	size_t tsize;
+
+	if (is_mbm_total_enabled()) {
+		tsize = sizeof(*hw_dom->arch_mbm_total);
+		hw_dom->arch_mbm_total = kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_total)
+			return -ENOMEM;
+	}
+	if (is_mbm_local_enabled()) {
+		tsize = sizeof(*hw_dom->arch_mbm_local);
+		hw_dom->arch_mbm_local = kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_local) {
+			kfree(hw_dom->arch_mbm_total);
+			hw_dom->arch_mbm_total = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -487,6 +517,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+		domain_free(hw_dom);
+		return;
+	}
+
 	list_add_tail(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 46062099d69e..4de8e5bb93e1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -303,17 +303,31 @@ struct mbm_state {
 	bool	delta_comp;
 };
 
+/**
+ * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
+ *			   return value.
+ * @prev_msr:	Value of IA32_QM_CTR last time it was read for the RMID used to
+ *		find this struct.
+ */
+struct arch_mbm_state {
+	u64	prev_msr;
+};
+
 /**
  * struct rdt_hw_domain - Arch private attributes of a set of CPUs that share
  *			  a resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
+ * @arch_mbm_total:	arch private state for MBM total bandwidth
+ * @arch_mbm_local:	arch private state for MBM local bandwidth
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
+	struct arch_mbm_state		*arch_mbm_total;
+	struct arch_mbm_state		*arch_mbm_local;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
-- 
2.30.2

