Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B802B49E95F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbiA0Rzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:19418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243792AbiA0RzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306111; x=1674842111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NeRBtAKXgYs7FnziQDnUBv0DLxfYL661IYkJjUwFj+I=;
  b=AbTjo2Ly6lHau8/eh0oNR5QozABytakfG0fPp6k0v/JnsYwKswVpo51N
   0Y2eyguGMJAu8YTyUUE7DliHK35RU5CPbVol7GG6c6ozs6isanu4sYx9o
   f+vWnCMThPRy/aptMAjBclO12gdGl3TeVrBFIfc7f8g9eCWTU+dU+kv6X
   jrUvgvId8PcyMA7EVRwJrB2WV+tVKhWXf0w3Wt3F3TM22c+HTR5JOnFEb
   H83yHLUpO38Bx1fDEGTbvdoPWEYl3a4MbZcRRT9RNrcIwm5MqcZSmNbE4
   fUnslnHFWDIG3FSi1skGoN63RrXyAyy2f7RohC3mOOkv9SmKvQ0dnby/t
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302424"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302424"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796092"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 14/44] x86/pkeys: Introduce pks_write_pkrs()
Date:   Thu, 27 Jan 2022 09:54:35 -0800
Message-Id: <20220127175505.851391-15-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Writing to MSR's is inefficient.  Even though the underlying
WRMSR(MSR_IA32_PKRS) is not serializing (see below), writing to the MSR
unnecessarily should be avoided.  This is especially true when the value
of the PKS protections is unlikely to change from the default often.

Introduce pks_write_pkrs() which avoids writing the MSR if the pkrs
value has not changed for the CPU.  Do this by utilizing a per-cpu
cache.  Protect the use of the cached value from preemption by
restricting the use of pks_write_pkrs() to non-preemptable context.
Further restrict it's use to callers which have checked X86_FEATURE_PKS.

The initial value of the MSR is preserved on INIT.  While unlikely, the
PKS_INIT_VALUE may be 0 someday which would prevent pks_write_pkrs()
from updating the MSR.  Keep the MSR write in pks_setup() to ensure the
MSR is initialized at least one time.  Then call pks_write_pkrs() to set
up the per-cache value to ensure it is in sync with the MSR.

It should be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
serializing but still maintains ordering properties similar to WRPKRU.
The current SDM section on PKRS needs updating but should be the same as
that of WRPKRU.  So to quote from the WRPKRU text:

	WRPKRU will never execute transiently. Memory accesses affected
	by PKRU register will not execute (even transiently) until all
	prior executions of WRPKRU have completed execution and updated
	the PKRU register.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
index a5b5b86e97ce..3dce99ef4127 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -209,15 +209,56 @@ u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
 
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
+	 * If the PKS_INIT_VALUE is 0 then pks_write_pkrs() could fail to
+	 * initialize the MSR.  Do a single write here to ensure the MSR is
+	 * written at least one time.
+	 */
 	wrmsrl(MSR_IA32_PKRS, PKS_INIT_VALUE);
+	pks_write_pkrs(PKS_INIT_VALUE);
 	cr4_set_bits(X86_CR4_PKS);
 }
 
-- 
2.31.1

