Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2E49E96B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbiA0R4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:65462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244837AbiA0RzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306125; x=1674842125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f7V0dsd3Osql3GdcBex4B2w6PKjtIBuODoy6hMsgF5w=;
  b=oCIhi6yvjPKAH4nKuoToAGc81tPhmbfZ/UarkmVQLxGstW7ItcXMtvHC
   Rd3YMz2HH5HIN/hrxGKChrU+K/1DtawOw3ueV3SEQUcuOCoHA7uxQQAVA
   qCNJS4BdSPAguR0byO1u+otBfsVHB2sBn3QTHix5zO+giiZW8H5wtcauV
   ij2HObThwTNVOMtZdSrg+sn5XB9VPc2NYijhjUViK1BhT7v8GUJo/x8ZW
   BhOjc5MirFBYVeHCB2tClijTgkE/1b7xCFQnJ4NQ6shLCcO/5//t0Gef9
   rw31NsBrphzQ/+tVfqy69EvDpYwk/FO69LB3mRFl4niXnDpxwEOtW+Qzr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899124"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899124"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796073"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 09/44] x86/pkeys: Enable PKS on cpus which support it
Date:   Thu, 27 Jan 2022 09:54:30 -0800
Message-Id: <20220127175505.851391-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
specific, manipulation of permission restrictions on supervisor page
mappings.  It uses the same mechanism of Protection Keys as those on
User mappings but applies that mechanism to supervisor mappings using a
supervisor specific MSR.

Bit 24 of CR4 is used to enable the feature by software.  Define
pks_setup() to be called when PKS is configured.

Initially, pks_setup() initializes the per-cpu MSR with 0 to enable all
access on all pkeys.  asm/pks.h is added as a new file to store new
internal functions and structures such as pks_setup().

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Move setup_pks() into this patch with a default of all access
		for all pkeys.
	From Thomas
		s/setup_pks/pks_setup/
	Update Change log to better reflect exactly what this patch does.
---
 arch/x86/include/asm/msr-index.h            |  1 +
 arch/x86/include/asm/pks.h                  | 15 +++++++++++++++
 arch/x86/include/uapi/asm/processor-flags.h |  2 ++
 arch/x86/kernel/cpu/common.c                |  2 ++
 arch/x86/mm/pkeys.c                         | 16 ++++++++++++++++
 5 files changed, 36 insertions(+)
 create mode 100644 arch/x86/include/asm/pks.h

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3faf0f97edb1..fca56ca646a0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -786,6 +786,7 @@
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
 
+#define MSR_IA32_PKRS			0x000006E1
 
 #define MSR_TSX_FORCE_ABORT		0x0000010F
 
diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
new file mode 100644
index 000000000000..8180fc59790b
--- /dev/null
+++ b/arch/x86/include/asm/pks.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKS_H
+#define _ASM_X86_PKS_H
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+void pks_setup(void);
+
+#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+static inline void pks_setup(void) { }
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+#endif /* _ASM_X86_PKS_H */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..191c574b2390 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -130,6 +130,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_PKS_BIT		24 /* enable Protection Keys for Supervisor */
+#define X86_CR4_PKS		_BITUL(X86_CR4_PKS_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7b8382c11788..83c1abce7d93 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
+#include <asm/pks.h>
 
 #include "cpu.h"
 
@@ -1632,6 +1633,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	pks_setup();
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index cf12d8bf122b..02629219e683 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -206,3 +206,19 @@ u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
 	pkval &= ~(PKEY_ACCESS_MASK << shift);
 	return pkval | accessbits << shift;
 }
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+/*
+ * PKS is independent of PKU and either or both may be supported on a CPU.
+ */
+void pks_setup(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	wrmsrl(MSR_IA32_PKRS, 0);
+	cr4_set_bits(X86_CR4_PKS);
+}
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
-- 
2.31.1

