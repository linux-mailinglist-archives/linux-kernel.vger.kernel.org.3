Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6747C589213
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiHCSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiHCSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:11:42 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C168501B8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UohSEDnzuVA1gK+IbOH31Q8h9PtBNibCxFKpdkpfjiIfBQ6suVppQPTwc8lbEQPdEG1kXE45Ko0tEUw0PJ7ataI2bgumBxSv7LAn42HHBn4RaDsXWE80YovUJX1Hc8PJS31/RH8Su8Y6+nX1ncBGHXNFZzh+5ZJ62Cjl+LyD3RXoLFl5mgcSHOJYwwxRiF19x9bHlkoCoyD6w8G3ZSONm1BpVW0hwJ0nCF35t7ur89HK4JXGsqppPacuWqrQyaU1IZ/BDRXli3jtkqnfeGpNoB54O6NQQmCmS6u431EVekuM28FNJVXSl1ZwqRl1DJ4Rd3PXY1OzWWX5Leit6uXXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2m9YBmgUWFet5dkU5/VtGVJM1BgocB7tS6uA3usHQSs=;
 b=D/+rEu5V303V5CeBTC04GtCSZzLEKNBpqfwvF8lDoTYZiPtHn1/TdqThjQJANDulpY5mpRR9jZf+tCvUkx8x7ZDqVDGSpvJewwEcCkfvZtuSs2etfOeZ774fwAa787o2nlkmJHZfcjqHw5fpCB2S+x+DMqHP58136Ax1vFMTd9GC3Toi7lKbesBybK+C+zASPOGZ6KW7czWG/+7maoxAy3hVB7HgP88X65O7lLsPsI8WEL0hEVh2i7qeQSL+mEk2/n+iQWVwVvy6iDVHhqZ9YteqFL1IfOwrlHBU6i88iU0v9wHkaJ72BfbYxx6wB4kNsXkcl0/fXVZ4cJGKULRfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m9YBmgUWFet5dkU5/VtGVJM1BgocB7tS6uA3usHQSs=;
 b=Py7Q+ovSwMR3aDhQgvnaO4WTx8Ldx9t41nxAbCqHjopOHip+KR7NxBDO72wx31nf1jOc6T2YIQY3FymAio4M9GwkVsy3RLO8659K97uoXIM3MgAdBY/K2/cp8eFOV8zyykQ717OHD+e+XOSu7L+IPVjwj+16BvDO11FSJvFtRA4=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 18:11:38 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::5f) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Wed, 3 Aug 2022 18:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 18:11:38 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 13:11:30 -0500
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
Subject: [PATCH v1.1 2/2] x86/sev: Add SNP-specific unaccepted memory support
Date:   Wed, 3 Aug 2022 13:11:05 -0500
Message-ID: <5b23d1ae9de7072afe26f385f3d80323792879c0.1659550264.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659550264.git.thomas.lendacky@amd.com>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com> <cover.1659550264.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37ac9621-ee8e-44fa-d571-08da757b9bc4
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7083:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gltG6IItr/Hzdoso5y/8tcTJDwLYJmQ3Pq1CKYXkEVdh9WrP78u8vSFxzfmg8yOHazWHtGV1fSqVvrl0Bs+KJMr7Q8kDPiN43d9wO4ODW2jbYGOpB3H783eom3oFNKEzvSss4KVyvhNCuxbgX007KalflcfigPIMdepeTM1P7W70b7nQhEk/Jbj9nBLmOnDTXbDB+IEjsV3CRqvnMjvH/qjU6O4VG4peGwxWOMf1rR4S3nvo+rysziIbhL0GJqlRIJfBLN+JnpUM08xUCmGw18Fsv9XMZzIR0zUjRehHWCdZyYNtCfeUL1xt5OjpZcdCzD9PzbHm3Wzb522HPFZsa8xI8jcio9utrQIApto4KR3F5cbUfMr4v+5TAkGxISawHjxELibyz5sGMzhcUBNRNX0U3JP+8oXF3ukrh4ED+hxAe4m+nMw9dE7raJ+RaaLNMkfyJyO7cFSdFuk5HIQPULSmRFP7uGPQ6RZccdFmlYGWPn7XCorloRHeWCTKMWoxH1ClsqzIR65dmSSemN7YAV49PpnEo2qdiqMgJ4vyLwz+j0x5TEro71yDex1oKwsIkBnt8XvibZnoepChcKa3tRDTkPOUEjJG2GpsrOV1IEym59972uYhHSxbFqzUka2weydTJ0gxe4fizHkca9nU8Xjn9jBbumxi1/AKcaV0rLq4sXdFNai6miZh2kGLFKNHwtr7mMAAyA/b4T/6hzni6QOv+FZDKmJDXQxCtj8eCwDtsHITZyWLKGtqiwUdMMflA2X5YFGF+x2Dsnh+N3zBk61TQCKeKO8mLvXUj7VQbw4xXixcshTNtq+Pc2OJWxqhGxydTXnrG6Qtt3TtyKW0lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(40470700004)(46966006)(426003)(336012)(47076005)(36860700001)(83380400001)(16526019)(2616005)(40460700003)(186003)(478600001)(2906002)(26005)(4326008)(36756003)(8936002)(6666004)(7696005)(70586007)(81166007)(5660300002)(7416002)(41300700001)(8676002)(70206006)(82310400005)(86362001)(54906003)(110136005)(316002)(40480700001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 18:11:38.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ac9621-ee8e-44fa-d571-08da757b9bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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
index 84d94fd2ec53..db74c38babf7 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -917,6 +917,22 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
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

