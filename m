Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17E58513C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiG2OB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiG2OBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:01:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14332EF7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ9N9nvC0ywPu0B+j6M38FD77MauoOwgL4omIJkzQ+Wl4CXdVwowc8OSGTTQuX+FX4bvkcsGnArp/CASuaN/O5rgSwQ+j1stcOR0M+BjLwv1ms/enCVzl2EbromDuaEKSzElF9vbuSpD67BFATs+FDNinRBpR+sugWcnRaJfWJKdwsq8iliUkqRx3g343p5pCuG9FgWi4fwxnnCtgHj784wFdLyKHhJfOrDY1lMm7ZppoX/xq1KbS9qkQ1QQiRiCW7fufudKY10OhIRE1stgP1aM245HAEEU53kb1+PDOCnLPnRUKyREROI0CDFStiU74nFJ9ubNs87goNk0Tuk8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrsBdeQMP3CMjSHHHyJIuDONYqcxpPi8fe2UZ0dWWR0=;
 b=ZFY/i7JTDMKIbUbpSMvvi5lTaA2kwvojJadAjRJCSUS3UTgfe2UvJqEClXs0i6VvoJcu2/x3GJn4eAJJzSGgxQ8F/7SRsVTP0onZmQlnEV/ieC53XqD6o4Ie/I9Ih02IfDKl/hd8xQJjBgJOw9SuL7wXJQ+gPXCoR2XV8YbALdn5C3PZSLhP9ydmez3+faadJueOuFUX+YCVu+jQc0JAEIQpoQKkl8d9w/RFaRP4GBNBEk9SgBAK0jRytEFjZUNinF1n5C29L0Fut+euW3bT6SjZucu5KZHnwUrppI8co02hQonYCz3UIOlIMtaq7DRfk+i3DIh69iS6nX0wjORRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrsBdeQMP3CMjSHHHyJIuDONYqcxpPi8fe2UZ0dWWR0=;
 b=ofU38f/VyuFmfZuLutPALUpsleC+YqQ2jjiQ8btmH+d3/GPMibUGDg4fn7qe0Nyn6TyQAD1IlT+aCjYDv+EyyqxdYEej5eG9mo0u/r/b5j5nIVyGyI4Lgffv9nGECoMsQKs7OY8CAgmIQfP4Nq1uiar0CJUYcWwvfMlkpcM0wYM=
Received: from MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::21)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 14:01:45 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::db) by MW4P220CA0016.outlook.office365.com
 (2603:10b6:303:115::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 29 Jul 2022 14:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 14:01:44 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 09:01:41 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v1 2/2] x86/sev: Add SNP-specific unaccepted memory support
Date:   Fri, 29 Jul 2022 09:01:15 -0500
Message-ID: <44495aa8acb666b447a08a1c3af80987aa3cea3a.1659103274.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659103274.git.thomas.lendacky@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com> <cover.1659103274.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c565fc3f-ee57-453e-be7b-08da716adeef
X-MS-TrafficTypeDiagnostic: IA1PR12MB6529:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJGrS4MKyoDOEO4trvJVFMxAS1pP1dJ65TmxTk85yRcgIY5hsYK6eVy6G/AYuoneeMrQjRPHQ+VnWlAkL2bUgAOF3KnfVx+Ed1bT8XvuFL1MkSaUkPwb+UeviYbVPE+FHqxRNmCOUduXGNdSjfATYOxXTQUJ7HSrpCa+hKAw94EUKRf/yL9alpifkypBsQxAgDL9q0bHB+fxoL+iSKzEZOdO4uYRrvPHwt0365IPRdjbHJoQJ/smI1SNB6RkdHAlqYD5aY8wMoj5WhfGrtfS3lt4leAqXE7cwh8EdgHP18amSYvaJ+AYlKgTnJu6gMMhqmuyncbY4Yu9qI+lxgz+ohT3977BgCeyOi2ZkpIy6KVNx3QAJnxMYUfoz5tn3k4Vyz+KTFjTKZ3VYOMZtic5KQgeju+ne/ycVV50TvL7ARoSWOOYgnFIxiI9h5VqZTKk3aHuoGBz8l4MbGPQlkubt6p6VCdzEaekwzTR/Yp3MJMgZtfxbaLi+VyvujWyWmtVxtzURcjysH/5ghAbwskORZCf1mwVAVKf+Qt/oYfw9xXUSjBmDURU832+4MFcrWi3udx87sy3/huJpmPKoYPO2pAFVYe9BsX40HLgd8mD4UYOAzHBJzbrpy8z8zQ+fwDXdO6nrWGOl3DmsFvkT8Z2RV2bpvLOvH8tfYlcrwAkYqTIHuKp8RNIQh/jXANMiQTH2lhtCSMCPIJIh7RMt0Qpw/3Vv7c1ERWybGWUAGbfhwIzdA1Qy3AFgNOCfXMy5PYsI6vEo1irRGuhVLbT6q8xc63hVhSJv5yMotgJdshbKtfUsSstptWz2SZF0JQWt8/j8+mTNwMlMDxfRBxPvrm5oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(41300700001)(336012)(47076005)(26005)(7696005)(426003)(2616005)(16526019)(6666004)(478600001)(36860700001)(82740400003)(186003)(81166007)(356005)(83380400001)(2906002)(4326008)(70206006)(110136005)(70586007)(36756003)(40480700001)(8936002)(8676002)(82310400005)(7416002)(54906003)(86362001)(316002)(40460700003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 14:01:44.5197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c565fc3f-ee57-453e-be7b-08da716adeef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SNP-specific hooks to the unaccepted memory support in the boot
path (__accept_memory()) and the core kernel (accept_memory()) in order
to support booting SNP guests when unaccepted memory is present. Without
this support, SNP guests will fail to boot and/or panic() when unaccepted
memory is present in the EFI memory map.

The process of accepting memory under SNP involves invoking the hypervisor
to perform a page state change for the page to private memory and then
issuing a PVALIDATE instruction to accept the page.

Create the new header file arch/x86/boot/compressed/sev.h because adding
the function declaration to any of the existing SEV related header files
pulls in too many other header files, causing the build to fail.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig                |  1 +
 arch/x86/boot/compressed/mem.c  |  3 +++
 arch/x86/boot/compressed/sev.c  | 10 +++++++++-
 arch/x86/boot/compressed/sev.h  | 23 +++++++++++++++++++++++
 arch/x86/include/asm/sev.h      |  3 +++
 arch/x86/kernel/sev.c           | 16 ++++++++++++++++
 arch/x86/mm/unaccepted_memory.c |  4 ++++
 7 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/sev.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 34146ecc5bdd..0ad53c3533c2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1553,6 +1553,7 @@ config AMD_MEM_ENCRYPT
 	select INSTRUCTION_DECODER
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
+	select UNACCEPTED_MEMORY
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 48e36e640da1..3e19dc0da0d7 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -6,6 +6,7 @@
 #include "find.h"
 #include "math.h"
 #include "tdx.h"
+#include "sev.h"
 #include <asm/shared/tdx.h>
 
 #define PMD_SHIFT	21
@@ -39,6 +40,8 @@ static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 	/* Platform-specific memory-acceptance call goes here */
 	if (is_tdx_guest())
 		tdx_accept_memory(start, end);
+	else if (sev_snp_enabled())
+		snp_accept_memory(start, end);
 	else
 		error("Cannot accept memory: unknown platform\n");
 }
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 730c4677e9db..d4b06c862094 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -115,7 +115,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
-static inline bool sev_snp_enabled(void)
+bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
@@ -161,6 +161,14 @@ void snp_set_page_shared(unsigned long paddr)
 	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
 }
 
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	while (end > start) {
+		snp_set_page_private(start);
+		start += PAGE_SIZE;
+	}
+}
+
 static bool early_setup_ghcb(void)
 {
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
new file mode 100644
index 000000000000..fc725a981b09
--- /dev/null
+++ b/arch/x86/boot/compressed/sev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD SEV header for early boot related functions.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#ifndef BOOT_COMPRESSED_SEV_H
+#define BOOT_COMPRESSED_SEV_H
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+
+bool sev_snp_enabled(void);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+
+#else
+
+static inline bool sev_snp_enabled(void) { return false; }
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+
+#endif
+
+#endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 19514524f0f8..21db66bacefe 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -202,6 +202,7 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -226,6 +227,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1f7f6205c4f6..289764e3a0b5 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -926,6 +926,22 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	pvalidate_pages(vaddr, npages, true);
 }
 
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long vaddr;
+	unsigned int npages;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	vaddr = (unsigned long)__va(start);
+	npages = (end - start) >> PAGE_SHIFT;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+
+	pvalidate_pages(vaddr, npages, true);
+}
+
 static int snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 9ec2304272dc..b86ad6a8ddf5 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -9,6 +9,7 @@
 #include <asm/setup.h>
 #include <asm/shared/tdx.h>
 #include <asm/unaccepted_memory.h>
+#include <asm/sev.h>
 
 /* Protects unaccepted memory bitmap */
 static DEFINE_SPINLOCK(unaccepted_memory_lock);
@@ -66,6 +67,9 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 			tdx_accept_memory(range_start * PMD_SIZE,
 					  range_end * PMD_SIZE);
+		} else if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+			snp_accept_memory(range_start * PMD_SIZE,
+					  range_end * PMD_SIZE);
 		} else {
 			panic("Cannot accept memory: unknown platform\n");
 		}
-- 
2.36.1

