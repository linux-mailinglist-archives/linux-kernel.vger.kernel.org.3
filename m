Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906B3507617
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355563AbiDSRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355571AbiDSRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08E1138
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388019; x=1681924019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0S/vlajBtLo9jFtd2sMm4bJOGT0tFshhyI9/QZbLLIo=;
  b=OT8URNPojUS4/P8SGhXEK1MKPfG4mvSCw4ylAttyVmY47leo9owgslNa
   ztbMJmK9j/50+5a6S50/6JOQEb51F6KRk7tz9UWcpBRskE4g27DuAzkt7
   Akt4hoIufHKwKlP1NPBMDQWgKUmWdExpSCxoCN4vbD81pLQByi1Nzqc3w
   492qiYxdtY1zsvkKyzUjMSHZPRUoVDyERiqwpLwet7ZEOQl+TTkuNjUxP
   wkxfr3GPga6pCtht3wTuYNtz9KhoOlQaqS/DPINSZY2iPKTdAt+J7vFZY
   0bgHmx7lrD5Zebo58rG4Hjxt6QKVBXzqUUDd6G44JsISWA1IwdLduCqh0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350267560"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="350267560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="510207076"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:58 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 10/44] x86/pkeys: Enable PKS on cpus which support it
Date:   Tue, 19 Apr 2022 10:06:15 -0700
Message-Id: <20220419170649.1022246-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes for V10
	Update to latest master branch

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
index ee15311b6be1..e8e33b5ed507 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -809,6 +809,7 @@
 
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
index c47cc7f2feeb..21b7783885b3 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -132,6 +132,8 @@
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
 #define X86_CR4_CET_BIT		23 /* enable Control-flow Enforcement Technology */
 #define X86_CR4_CET		_BITUL(X86_CR4_CET_BIT)
+#define X86_CR4_PKS_BIT		24 /* enable Protection Keys for Supervisor */
+#define X86_CR4_PKS		_BITUL(X86_CR4_PKS_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index e342ae4db3c4..4c0623783bd8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -60,6 +60,7 @@
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
 #include <asm/traps.h>
+#include <asm/pks.h>
 
 #include "cpu.h"
 
@@ -1764,6 +1765,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	x86_init_rdrand(c);
 	setup_pku(c);
 	setup_cet(c);
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

