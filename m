Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1574D5062
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbiCJRWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbiCJRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1703E198EE2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932859; x=1678468859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99E8DhfEk0Ekd5my6kcIYaxIlJz7qBZKJBWjSrZUA94=;
  b=JrQnDs41f+HMC/Lsn4Za79LjdaruY+yRMB30BDetXiF5HdJR9+TJEyPI
   CccwGK01xp16uQvYRs9jZDj/LR38TEZdjs7Feh0h8uzHETGPOkUf29+gP
   UNcPjq7Qex2ccn2zGsSTZoRK/iCToTqe1Hsyt2ROdWq9bCrVmZPd3QX/H
   fAdhOz5qyKgJzPMX4O482dCGsY15lYjgl1QRhOEYj0R3N+wDX9T3XWfbv
   7vlWnaCn9Tm+IuPHTrXQFDProoZ+8RuK9tX0nTAKROmnKfSBhqOFWOb9C
   1fw3CZoPSZoCXfnqBYPH9tjMc5U0EXWBf3fKvajLRWh77cKQyni+wcVcG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254141965"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="254141965"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="538541792"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:57 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 15/45] x86/pkeys: Introduce pks_write_pkrs()
Date:   Thu, 10 Mar 2022 09:19:49 -0800
Message-Id: <20220310172019.850939-16-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Writing to MSR's is inefficient.  Even though the underlying PKS
register, MSR_IA32_PKRS, is not serializing; writing to the MSR should
be avoided if possible.  Especially when updates are made in critical
paths such as the scheduler or the entry code.

Introduce pks_write_pkrs().  pks_write_pkrs() avoids writing
MSR_IA32_PKRS if the pkrs value has not changed for the current CPU.
Most of the callers are in a non-preemptable code path.  Therefore,
avoid calling preempt_{disable,enable}() to protect the per-cpu cache
and instead rely on outer calls for this protection.  Do the same with
checks to X86_FEATURE_PKS.

On startup, while unlikely, the PKS_INIT_VALUE may be 0.  This would
prevent pks_write_pkrs() from updating the MSR because of the initial
value of the per-cpu cache.  Therefore, keep the MSR write in
pks_setup() to ensure the MSR is initialized at least one time.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	From Dave Hansen
		Update commit message with a bit more detail about why
			this optimization is needed
		Update the code comments as well.

Changes for V8
	From Thomas
		Remove get/put_cpu_ptr() and make this a 'lower level
		call.  This makes it preemption unsafe but it is called
		mostly where preemption is already disabled.  Add this
		as a predicate of the call and those calls which need to
		can disable preemption.
		Add lockdep assert for preemption
	Ensure MSR gets written even if the PKS_INIT_VALUE is 0.
	Completely re-write the commit message.
	s/write_pkrs/pks_write_pkrs/
	Split this off into a singular patch

Changes for V7
	Create a dynamic pkrs_initial_value in early init code.
	Clean up comments
	Add comment to macro guard
---
 arch/x86/mm/pkeys.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index f904376570f4..10521f1a292e 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -213,15 +213,56 @@ u32 pkey_update_pkval(u32 pkval, u8 pkey, u32 accessbits)
 
 #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
 
+static DEFINE_PER_CPU(u32, pkrs_cache);
+
+/*
+ * pks_write_pkrs() - Write the pkrs of the current CPU
+ * @new_pkrs: New value to write to the current CPU register
+ *
+ * Optimizes the MSR writes by maintaining a per cpu cache.
+ *
+ * Context: must be called with preemption disabled
+ * Context: must only be called if PKS is enabled
+ *
+ * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
+ * serializing but still maintains ordering properties similar to WRPKRU.
+ * The current SDM section on PKRS needs updating but should be the same as
+ * that of WRPKRU.  Quote from the WRPKRU text:
+ *
+ *     WRPKRU will never execute transiently. Memory accesses
+ *     affected by PKRU register will not execute (even transiently)
+ *     until all prior executions of WRPKRU have completed execution
+ *     and updated the PKRU register.
+ */
+static inline void pks_write_pkrs(u32 new_pkrs)
+{
+	u32 pkrs = __this_cpu_read(pkrs_cache);
+
+	lockdep_assert_preemption_disabled();
+
+	if (pkrs != new_pkrs) {
+		__this_cpu_write(pkrs_cache, new_pkrs);
+		wrmsrl(MSR_IA32_PKRS, new_pkrs);
+	}
+}
+
 /*
  * PKS is independent of PKU and either or both may be supported on a CPU.
+ *
+ * Context: must be called with preemption disabled
  */
 void pks_setup(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_PKS))
 		return;
 
+	/*
+	 * If the PKS_INIT_VALUE is 0 then pks_write_pkrs() will fail to
+	 * initialize the MSR.  Do a single write here to ensure the MSR is
+	 * written at least one time.
+	 */
 	wrmsrl(MSR_IA32_PKRS, PKS_INIT_VALUE);
+	pks_write_pkrs(PKS_INIT_VALUE);
 	cr4_set_bits(X86_CR4_PKS);
 }
 
-- 
2.35.1

