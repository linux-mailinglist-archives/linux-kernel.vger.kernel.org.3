Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C734F50760E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355902AbiDSRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355655AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006F611A30
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388030; x=1681924030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99E8DhfEk0Ekd5my6kcIYaxIlJz7qBZKJBWjSrZUA94=;
  b=N+RwRk573jPr9h/dhD2px3bnJdJm5iKkO9dtX0u2FQa4MXAqAULgfbY2
   +J5e7ABfWZIsgqH3qetCl2Z3QO9QHireuEGnBlpRSI6VF69xrtmjUvfy2
   5SAdVO1iPHnS7YyylX+Iwq7p150PSqwpn1LlvcBay82hXtp5l8LqvOT5K
   HkdgmBcwmAfnlpQaLh/A+cLjbKrkeLPZBF19KzKwzIbODT/NyGR2A3Mci
   Z5+MPR0iIPG2oUqGEsWmugqYCfLyGZfKH0jUuYXe5KrVqDply9YcmXHNl
   FR7ww7dFVinAZvPYrZNdXXDXOr9AE+gh29UTJPY+IKr4YrsVxYrFztu5C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261420786"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261420786"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="657714575"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:01 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 12/44] x86/pkeys: Introduce pks_write_pkrs()
Date:   Tue, 19 Apr 2022 10:06:17 -0700
Message-Id: <20220419170649.1022246-13-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

