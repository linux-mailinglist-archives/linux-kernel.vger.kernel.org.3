Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711164D5051
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbiCJRWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiCJRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:22 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F4D199D4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932877; x=1678468877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bpNLdvD0glY7GspXdaBYQNJVO+MYEUPR9GUQkRRXSOU=;
  b=PSApOHzp+PBrweRcBANy51TsHElAoey0l1QBTQUDkdLPx70w5COrM0P5
   c0yf9crFGkjufg9CcrK0ktnG/a/OJ1WQ10SNBuIIEFZbs8tgBJNzfj5aO
   f5Sp1umGHAOgLJ41yD/W/GPEQbQ2vEhV7uugQrfEOWcsfrTkkkrwn4zKn
   JAgVLI8XqFWrSM/nHi26OoAfY2Uv5Mch7zf9O+40xTihmNtbQB9dBOmrn
   W35KsSk3h8IG5aQjCW2smkSghyREelUuh/GhsaiU1YqPFxYaGNeODaAPC
   TGzA3Ev8KJZIY4J3gRxMVjzCFM4nhWubjInksfcXk9ClgXlKIA3o46tMu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="242758937"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="242758937"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:50 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="633064339"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:49 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 11/45] x86/pkeys: Enable PKS on cpus which support it
Date:   Thu, 10 Mar 2022 09:19:45 -0800
Message-Id: <20220310172019.850939-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
specific, manipulation of permission restrictions on supervisor page
mappings.  It uses a supervisor specific MSR to assign permissions to
the pkeys.

When PKS is configured and the cpu supports PKS, initialize the MSR, and
enable the hardware.

Add asm/pks.h to store new internal functions and structures such as
pks_setup().

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Reword commit message
	Move this after the patch defining PKS_INIT_VALUE

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
 arch/x86/mm/pkeys.c                         | 17 +++++++++++++++++
 5 files changed, 37 insertions(+)
 create mode 100644 arch/x86/include/asm/pks.h

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a4a39c3e0f19..6b0a6e0300a4 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -787,6 +787,7 @@
 
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
index 7c90b2188c5f..f904376570f4 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>		/* debugfs_create_u32()		*/
 #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
 #include <linux/pkeys.h>                /* PKEY_*                       */
+#include <linux/pks-keys.h>
 #include <uapi/asm-generic/mman-common.h>
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
@@ -209,3 +210,19 @@ u32 pkey_update_pkval(u32 pkval, u8 pkey, u32 accessbits)
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
+	wrmsrl(MSR_IA32_PKRS, PKS_INIT_VALUE);
+	cr4_set_bits(X86_CR4_PKS);
+}
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
-- 
2.35.1

