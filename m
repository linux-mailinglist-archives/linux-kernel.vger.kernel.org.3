Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4B5551B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376701AbiFVQu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376762AbiFVQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8D243FD80
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:47:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97B8912FC;
        Wed, 22 Jun 2022 09:47:15 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B4463F792;
        Wed, 22 Jun 2022 09:47:13 -0700 (PDT)
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
Subject: [PATCH v5 06/21] x86/resctrl: Remove set_mba_sc()s control array re-initialisation
Date:   Wed, 22 Jun 2022 16:46:14 +0000
Message-Id: <20220622164629.20795-7-james.morse@arm.com>
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

set_mba_sc() enables the 'software controller' to regulate the
bandwidth based on the byte counters. This can be managed entirely
in the parts of resctrl that move to /fs/, without any extra
support from the architecture specific code.
set_mba_sc() is called by rdt_enable_ctx() during mount and
umount. It currently resets the arch code's ctrl_val[] and mbps_val[]
arrays.

The ctrl_val[] was already reset when the domain was created,
and by reset_all_ctrls() when the filesystem was last umounted.
Doing the work in set_mba_sc() is not necessary as the values are
already at their defaults due to the creation of the domain, or were
previously reset during umount(), or are about to reset during umount().

Add a reset of the mbps_val[] in reset_all_ctrls(), allowing the
code in set_mba_sc() that reaches in to the architecture specific
structures to be removed.

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v3:
 * Spelling mistakes in commit message.

Changes since v2:
 * Moved earlier in the series, added the reset in reset_all_ctrls().
 * Rephrased commit message.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5830905a92d2..b32ceff8325a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1898,18 +1898,12 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
-	struct rdt_hw_domain *hw_dom;
-	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
 	    mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
-	list_for_each_entry(d, &r->domains, list) {
-		hw_dom = resctrl_to_arch_dom(d);
-		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
-	}
 
 	return 0;
 }
@@ -2327,8 +2321,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
-		for (i = 0; i < hw_res->num_closid; i++)
+		for (i = 0; i < hw_res->num_closid; i++) {
 			hw_dom->ctrl_val[i] = r->default_ctrl;
+			hw_dom->mbps_val[i] = MBA_MAX_MBPS;
+		}
 	}
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
-- 
2.30.2

