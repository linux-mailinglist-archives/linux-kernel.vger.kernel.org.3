Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796105932A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiHOP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiHOP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:59:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF21A3BA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cug2e1kpKPJRoQMxYylLTyJm7Hi4N0mRrvny2xwRap8JDq39ewgvyq43G8CXoqPH0UQHHkqNeITHydqkxh4KxaP7FN3MPUMBwMwpQZC7T6D6kmbuL7kSpTtvX5rz/4FZjmUpBf0+GgTcbLHlIGB1IWL1KPHykLsgWvHCnkmDCPYzpPfJ4nrYK8uZbWuyE0d7A6tQY8mJv2yt/+ye8BCOh5I5TBQnoO40t9DwNZ1U4eCGdIcqpfbmA8cRfqTxu9Tt+rCyjBmT9k/Z+O0kmap0PVDLU1XEfW2pcCP9aZTlv22nhqIHaQje2tgOVFvKxavNYZq3kjwgai6tefT6126m0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3xZh/cPCE8DRlTOvlj8h922QDtkfoufbsjZD102+EM=;
 b=bRUSUxlOERNn5/Whw/akK6ob3m2AUnl8DLQSVy1rVxWuQDcrQyV/GOz4ZNYXNB21ROi74vQivCEm746ukJbWp0ST86MnkBak0W/PZLctvAwak8ve0W03CQG2MLFdu4g1QQuAvz4qIrvGMOWcilEHAjWVlJkNb7rQ5Hh+5EfPhdaZAWXWAIidljg4YxVVIgNqRDfxsbHu2D8V0ZgYp2nOm8ijILeDvs4aA1cRuhB/vtyENANZnAjr4e7EwZ5sEfl9Lj1JSzZWBcNLcdaYzcNY16pSGE0gqprdRt52wh9Qp2x9JahmoNRC/D6viBWBnsCiVzhP1n5ApVK+W4HoJYc3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3xZh/cPCE8DRlTOvlj8h922QDtkfoufbsjZD102+EM=;
 b=MxQRyIZ3l8JkcVnWXVMKFR0QHMJpCVN6uNkGmd4CErTdgDpZIcigHZ5HTlXpMXbIM58oxUirTZdIdExsn9u4dv9QMT/f4uVQVRExu6dl+n7ctMCdaFtDyEsMwAgWmTnmECbmDv1NcyO7b7tdguBZFjIdhISKSCj4KutaKnmNwTA=
Received: from DM6PR06CA0040.namprd06.prod.outlook.com (2603:10b6:5:54::17) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Mon, 15 Aug 2022 15:59:39 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::a) by DM6PR06CA0040.outlook.office365.com
 (2603:10b6:5:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Mon, 15 Aug 2022 15:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 15:59:39 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 10:59:31 -0500
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
Subject: [PATCH v3 2/2] x86/sev: Add SNP-specific unaccepted memory support
Date:   Mon, 15 Aug 2022 10:57:43 -0500
Message-ID: <202f4e1ed9fc585f503da57cb8a8dd35e83758d1.1660579062.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1660579062.git.thomas.lendacky@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com> <cover.1660579062.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1750bc32-ff7e-4ef5-205d-08da7ed728de
X-MS-TrafficTypeDiagnostic: DS0PR12MB6534:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tjuFjfIbWZ4Qhcs+B8Ddffc4RwJX16TBm9+s2jR/mO+47OcpYrjpwq4I0++vZTA5qTD2yczxmMOvORKURe/o+DjQFdGlUdzkgrZQEVoR14zw6zQSwtL8WId0IDMk+q1LAa3W8xSXpHplXsQA+xu5GNo8LsdRoTzPnqMiXfsuHWDfNcBtO2GcFeGnujhpd72CBDyHqj7+8D8s6VI4TOPjnNXerzoQ+RL0Dw2d6U6ngD1MHuisHcFgTF2nBtF0iPbJc/88gsqkJVBzbhUR8itIXGpcVSJCRCOQMNmkQQBS9Wk0lL/aES63rTCajcpdQKpr9p7vYqJzIyHLeNY4T6ysWXwvEQ1EJZjvzauI4mnCXOa+oHvQOW7OKpOmN1gah1jUB6tD0AtYeUsdO25yjbHQANxTlAVADPgxf/dknlhbkgfjYkOjjfCKemwtcUrzCQmHA8HRLKOF6QABiGdFbDjgXatl2CFLdpqWiQwPSFYJKsKWMCAR7TSqmSJet4VCKmAOMfzjtFMROM/armkJXIsfGs/j4POJrzwT+TiEQTRp4ae7tl/3I/5DeFMivi+j6/06SLhpjpIEtzJcb7Z6Gi0ZUDawswFOE7TEmlTzOqbvsKhy5kgqIy1gs5vfFh+n9dacFe5BxV1ZYJnkwMzDnv5vJ2FjWHXzveonAOGRbRE8QTQIX4uIWpU18Tm6P6hZXTDecFSwMo3SwQRaFAcWaXA2buS36vYcOR9bCsHHio3xwpNha+DgZGpzj3qbW4sEViUI/g3huY4PfLQpTJ5MHAHr/mM+QUGLX3g72a8MbpWPXFZ8GejRpNzzao78N1SETpXU0fWV8EPu87pq0XFxBneFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(40470700004)(46966006)(82740400003)(8936002)(47076005)(36756003)(2616005)(426003)(336012)(186003)(16526019)(81166007)(26005)(7416002)(6666004)(36860700001)(82310400005)(40480700001)(356005)(7696005)(54906003)(110136005)(86362001)(316002)(2906002)(70206006)(4326008)(8676002)(41300700001)(70586007)(83380400001)(5660300002)(478600001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 15:59:39.3967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1750bc32-ff7e-4ef5-205d-08da7ed728de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 40268ce97aad..d71740f54277 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -924,6 +924,22 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
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

