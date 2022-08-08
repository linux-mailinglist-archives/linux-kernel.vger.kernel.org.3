Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6216A58CC96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiHHRRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbiHHRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:17:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D1D1704C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9NvzdO1fVEcEFz90WDrcg0AsMBSbgQ/d0LzBaaycX+ENry69PjkSIv50nmTxwayUwIrxurY11g1OMlM2pct5pssHmP/62GKbDbOhae3aqufraXbqPVzBOOfRDfm62GoJ3TJ8bFSISCvPMp//n3ZrVMHBuT7qLMS3BkG0N3hZBkMSpLoxr5MjtKnmDeofkVPNTY7NXZ4HObrZjmNNMDXM+2HtXF70O4eN/evgGEWyV3VgRQRggrsqwFxMOKU6rx7DldYM6IurPMthcplDIPag4ClDHpmdq4htPkjOcW/P2lg6bKtlEBpkl3CBuSntpgSzeb3cSWbMqOB6vRgcUZIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19wo7GR/bKNd1YY3mZvvQVPnSOwkXxFuFWuYTJV/Jg8=;
 b=iM6/6cD+HV5oOXfWotMv9Hpv/n2mns5nJHQpWB8kuqQgl5MgIMS0QVE5M0+FzNVILM6wpBsX5lgKc73KFL8N5aA3zEaMP+3ZaAuEMqblyIJPL/EXfb53mWE35vKIiR0RGvn31Xcqd12EO9tVeEWpMUtR9Cw9QBrldZ+3QIfENztQCG784vgA76OXdL00dzX0FuaI541ZpnkB9kQtnkYOvPQr+rAzmNPUgmum+V85m3fMI3CJQ74oiqnoUwzFljLxzDlJxNx4Yo5TD5LAsZ/qZHNFXyrSEwKuoQBlnVHApcRCqJERnqfe5f+EOiipibjyAhUt16v5iDsnTmxpmDgEgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19wo7GR/bKNd1YY3mZvvQVPnSOwkXxFuFWuYTJV/Jg8=;
 b=jhiCKBF9uTqLK1dFknp5H0YhhXZVdzqYFqKg8WzKo9SjFz3/qt3eq003YdVpebI96FsJSxQcVMyOdI+Adz/QRnburuvPGk9ZdDX7EssP5NsBkLgvzOiq4odz/cAgy08M8Sv/lgo2Qdt2Y8a6lHbEQxyR8l14RF/zeU9XuE5VL40=
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 17:16:52 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::eb) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Mon, 8 Aug 2022 17:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 17:16:51 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 12:16:50 -0500
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
Subject: [PATCH v2 2/2] x86/sev: Add SNP-specific unaccepted memory support
Date:   Mon, 8 Aug 2022 12:16:25 -0500
Message-ID: <0a6f8c7fa4fb7314b7b786eb207756e3160145ab.1659978985.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659978985.git.thomas.lendacky@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com> <cover.1659978985.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0802c8dc-727a-4ec8-73e7-08da7961c925
X-MS-TrafficTypeDiagnostic: MN2PR12MB4990:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z71mqPuovUJEm1xTzGqJ2uxvkbSgDF8Rnf+aIXuT0woHZ6ia3Dt9XEUGQUniHxoH0zCr5+hS1lgRFHUnWTZqzM0NvQd+Mglnah7T2BP0ZpPkiQy7gFg0NWl3giJMF3RVykvorTM4xyPcm/ZIHdvkPiChsaDW9rTvMiyxKAEnV1EM3GrPbRdoePQm+2VsR0zR7dQwMxA8hDZ5OdnXeY58DRwthp6EtqmDHAsr4hgLzLLrDk9qMUQkSCHTde2avDb+1MAiXkYgt6k9NSw04cJuSyYvMpqMOEEVek6CfqPdxj7N8bIjFcmQ/zFXNzqgTzawXenJ8CAxgtJa9huWQDQ3Q9hbfur1CqyFxYkRHxhAX/hpQHzwEVxPA8OhMEs83+khxHctrn0fDy4TPQRG4uoAEZqWb3WON2vzBMt9fYpCQEDfyFTuiuj4z8CFM6TxcIlBt53iETckytfn8u9w+zE7dihvelW8a2OCFUkAgPj44mDBnZ0vSW6xZUPX2bTd6+Ch+PbJtFDuRy4bFbsSaSgXQomV5Qm6unGAp8DxqTarBF8LPRgHLC+lR5TzXPEybGKogydcIZGRLLlDXmtPUzFN8U7dA/XzSVnYCs/G/2Btnaoy0fySsbR9XoNk8vczpFo3HXSehWrSaOZLqB8DIA5N1l3riY3BLej7okNyGWtZN98KeC4fIcb+8MBSXRXtIF4RWGev8a+gH4Z7NG7YtF62U5DFGfiuprizEdUxpPxGew9pO8muL55Y5mY0RjgXI6F2at+PMYCQWcTu7wTOIlevQ3DZwGcplTWUFEAnSw81dpOpK88hVhxIpjcNItGTQOQLBFcS0e5sgXvN8/oDRVuJuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(40470700004)(54906003)(110136005)(316002)(478600001)(41300700001)(70206006)(2906002)(40460700003)(40480700001)(82310400005)(70586007)(4326008)(8676002)(5660300002)(7416002)(8936002)(82740400003)(36860700001)(81166007)(356005)(36756003)(86362001)(47076005)(2616005)(186003)(16526019)(426003)(26005)(6666004)(7696005)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 17:16:51.8716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0802c8dc-727a-4ec8-73e7-08da7961c925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
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
index 275aa890611f..f64805fa5dcb 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -916,6 +916,22 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
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

