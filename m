Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512F15A1385
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiHYOZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiHYOYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:24:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C6B72A6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l85zNNZlZ70oW0Adc97amDL1F/0VEfSBGIWeeaJ0edHcP+ywSoPpgwpQBmiZy5Evj7wCCXwS1IVUPDRDD/kRTtDVP72hZFSYbf4pj8DXruxTXe/giSYrOYHTcnYvU5g9FL+/DIVGg+CDWnVR2Las6U8L2Qs/kAVJLhr6ObduQKEU7MnC7h+Gb7js+dkUpw7RuumHRxD/Xo9R2ZN5Q/xybgR3AtrBiiqnPbVun5yL02IXQrHRPLrzHg2Ct+vrVwxoekfRtIMX4xpL9/UMUbvM6k3rx0Ew/lQMwNQ9s7MAbGr0Hscygzmmb74QO2JbtCAIkipiUbyQ4cwmG+4p94GXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JzzXaHk6zgoONGrhd4B9QP03pdV1/xgO8PuNBiuOj0=;
 b=k7UKJ34moorciZPPpk81PpbvT0vu739ExDf5haNpWBdJLRuklxb7Cfx3o5ZP2+Xo6b/wMM9wWA5k8qQX58+gONEWYy6tAzEM7CrwoYiZQQmeE2BhYMaA122zBRzx4vrKe1pk+7fPN5ReF1J8gq8F4wftE0Ks2IiI7XtZo8cBjFHA+K7HpEnDZwc4hXGSocWuxEBPnJHQ5zcSWe+zT0bDvqvylQGUfBvknyq8XadPYpLYsRHyyTJ3OgkWikZjY1vVhPL7qytzarIKOSi9/OEtrYt4vOT4fD1z8DRXt2cHoAC1b7omkm4TGrkz4f3HBG/iFrq4I4/2s0U98F9HoQITsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JzzXaHk6zgoONGrhd4B9QP03pdV1/xgO8PuNBiuOj0=;
 b=UJLQWlqBza+6411l3WFiZt8+x2dkwgLwDvmyzranKlG+lBpqEYamhZHi+pnuubBJtHz4zdXj9gEZnNoFeLZ49ige58ke9HItV5s0rUQvISINMlDSLumf9Q+Br67SMyT+TWIR1p+fbQpikoraTGZyx7QNbLdDhdu8fZ3PCg6aoS4=
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by MWHPR1201MB0206.namprd12.prod.outlook.com (2603:10b6:301:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 14:23:59 +0000
Received: from CO1PEPF00001A62.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::7a) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Thu, 25 Aug 2022 14:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A62.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Thu, 25 Aug 2022 14:23:58 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 09:23:57 -0500
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
Subject: [PATCH v4 4/4] x86/sev: Add SNP-specific unaccepted memory support
Date:   Thu, 25 Aug 2022 09:23:17 -0500
Message-ID: <fe519747d14dd16a64e0e92e4c0354cb2ec55f59.1661437397.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661437397.git.thomas.lendacky@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com> <cover.1661437397.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bdfa57-a7cf-44cd-d859-08da86a57362
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0206:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuoAMGpeWilytIB8JS0OUFi52UmGBmg9Sgj8zBncygixPbeWRl19sLh0127LnsDCnZsu7sDaJFbe5rZ1rCVCJdh2wz6DWqZ/G65okMP5s4RmxS0mIs7K0VmI+NnRalIPo/9F1k61iz1VqRI5Z4m7rxtxLefK4WTLEQVPIjnfdrPQ2b1B0QFrNVAsJClDnHtcUsh5hIE1vtenwbf2TeB5EkIjuILBSlTHPjaZye1USUS3NpEArC8fjCZ5oAir0rFdXB7gDwFbVdYzwo8m+nwjUotXOCeLFkFc+ge7BEs0oQ43VWp46RBECvI6oFMb7RWgv4Fam9JzSzbzsahRSdocvd+R311KkdyfJIk3BjYbN/8VYdN32Mg4nNZC92umZMcNu/qsRVFqY/9g7UgQa9uyBq/VyQdyjtAt73nyZVz9EnLDX7OnvhnVs2sWVoQqyRoHTXemdJy1kH6yI6J989yZoltIzRJwO4dB8nNYHnxEugzQftcEr3Xyp+3IDyXixa+giroGWNONSe14KBkV8JjWsKWNBqadREmMa4qurao585xWtXqHSFtOtTqof0ke3I32d65ebv4sVJpB5PRXaCcbOZMdSJuOlQTeTqlbIpCVLzGNgDFeBiNbtOJiQReRG67dfWzRjzfr9B9l+4NRZ1OJ+wrOQ6NAIQz5mg5IWIhK7Ni9uSlkGL6dNrxHS7jdaK3q3wFtu69GSgkOmZDsAY2HoTos2vFINb8srdCQfoFOBTia6uXKzbpGGbHW9GOCMVKmPncTUA6BMZ6Ne1klS3PdlY+ELCzOATL5N/2LKN+yb1cXkCMB9J6cC71wx9NwJYlf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(316002)(30864003)(8936002)(54906003)(478600001)(7416002)(82310400005)(82740400003)(6666004)(110136005)(36756003)(5660300002)(40460700003)(41300700001)(4326008)(70586007)(70206006)(186003)(16526019)(2616005)(81166007)(47076005)(336012)(8676002)(83380400001)(26005)(7696005)(2906002)(36860700001)(426003)(86362001)(40480700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:23:58.8055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bdfa57-a7cf-44cd-d859-08da86a57362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Since the boot path and the core kernel paths perform similar operations,
move the pvalidate_pages() and vmgexit_psc() functions into sev-shared.c
to avoid code duplication.

Create the new header file arch/x86/boot/compressed/sev.h because adding
the function declaration to any of the existing SEV related header files
pulls in too many other header files, causing the build to fail.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/Kconfig                |   1 +
 arch/x86/boot/compressed/mem.c  |   3 +
 arch/x86/boot/compressed/sev.c  |  54 ++++++++++++++-
 arch/x86/boot/compressed/sev.h  |  23 +++++++
 arch/x86/include/asm/sev.h      |   3 +
 arch/x86/kernel/sev-shared.c    | 104 +++++++++++++++++++++++++++++
 arch/x86/kernel/sev.c           | 112 ++++----------------------------
 arch/x86/mm/unaccepted_memory.c |   4 ++
 8 files changed, 205 insertions(+), 99 deletions(-)
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
index 730c4677e9db..22da65c96b47 100644
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
@@ -181,6 +181,58 @@ static bool early_setup_ghcb(void)
 	return true;
 }
 
+static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
+				       phys_addr_t pa, phys_addr_t pa_end)
+{
+	struct psc_hdr *hdr;
+	struct psc_entry *e;
+	unsigned int i;
+
+	hdr = &desc->hdr;
+	memset(hdr, 0, sizeof(*hdr));
+
+	e = desc->entries;
+
+	i = 0;
+	while (pa < pa_end && i < VMGEXIT_PSC_MAX_ENTRY) {
+		hdr->end_entry = i;
+
+		e->gfn = pa >> PAGE_SHIFT;
+		e->operation = SNP_PAGE_STATE_PRIVATE;
+		if (IS_ALIGNED(pa, PMD_PAGE_SIZE) && (pa_end - pa) >= PMD_PAGE_SIZE) {
+			e->pagesize = RMP_PG_SIZE_2M;
+			pa += PMD_PAGE_SIZE;
+		} else {
+			e->pagesize = RMP_PG_SIZE_4K;
+			pa += PAGE_SIZE;
+		}
+
+		e++;
+		i++;
+	}
+
+	if (vmgexit_psc(boot_ghcb, desc))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	pvalidate_pages(desc);
+
+	return pa;
+}
+
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	struct snp_psc_desc desc = {};
+	unsigned int i;
+	phys_addr_t pa;
+
+	if (!boot_ghcb && !early_setup_ghcb())
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	pa = start;
+	while (pa < end)
+		pa = __snp_accept_memory(&desc, pa, end);
+}
+
 void sev_es_shutdown_ghcb(void)
 {
 	if (!boot_ghcb)
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
index 0007ab04ac5f..9297aab0c79e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -206,6 +206,7 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -230,6 +231,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
+
+static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index b478edf43bec..7ac7857da2b8 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -12,6 +12,9 @@
 #ifndef __BOOT_COMPRESSED
 #define error(v)	pr_err(v)
 #define has_cpuflag(f)	boot_cpu_has(f)
+#else
+#undef WARN
+#define WARN(condition...)
 #endif
 
 /* I/O parameters for CPUID-related helpers */
@@ -998,3 +1001,104 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 			cpuid_ext_range_max = fn->eax;
 	}
 }
+
+static void pvalidate_pages(struct snp_psc_desc *desc)
+{
+	struct psc_entry *e;
+	unsigned long vaddr;
+	unsigned int size;
+	unsigned int i;
+	bool validate;
+	int rc;
+
+	for (i = 0; i <= desc->hdr.end_entry; i++) {
+		e = &desc->entries[i];
+
+		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
+		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		validate = (e->operation == SNP_PAGE_STATE_PRIVATE) ? true : false;
+
+		rc = pvalidate(vaddr, size, validate);
+		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
+			unsigned long vaddr_end = vaddr + PMD_PAGE_SIZE;
+
+			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+				if (rc)
+					break;
+			}
+		}
+
+		if (rc) {
+			WARN(1, "Failed to validate address 0x%lx ret %d", vaddr, rc);
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+		}
+	}
+}
+
+static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret = 0;
+	struct snp_psc_desc *data;
+	struct es_em_ctxt ctxt;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Check whether all the entries
+	 * are processed. If not, then keep retrying. Note, the hypervisor
+	 * will update the data memory directly to indicate the status, so
+	 * reference the data->hdr everywhere.
+	 *
+	 * The strategy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest accesses the memory pages. If the
+	 * page state change was not successful, then later memory access will
+	 * result in a crash.
+	 */
+	cur_entry = data->hdr.cur_entry;
+	end_entry = data->hdr.end_entry;
+
+	while (data->hdr.cur_entry <= data->hdr.end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		/* This will advance the shared buffer data points to. */
+		ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
+
+		/*
+		 * Page State Change VMGEXIT can pass error code through
+		 * exit_info_2.
+		 */
+		if (ret || ghcb->save.sw_exit_info_2) {
+			WARN(1, "SNP: PSC failed ret=%d exit_info_2=%llx\n",
+			     ret, ghcb->save.sw_exit_info_2);
+			ret = 1;
+			goto out;
+		}
+
+		/* Verify that reserved bit is not set */
+		if (data->hdr.reserved) {
+			WARN(1, "Reserved bit is set in the PSC header\n");
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * Sanity check that entry processing is not going backwards.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry) {
+			WARN(1, "SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			     end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry);
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a744f7f2e72b..abdf431622ea 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -655,38 +655,6 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void pvalidate_pages(struct snp_psc_desc *desc)
-{
-	struct psc_entry *e;
-	unsigned long vaddr;
-	unsigned int size;
-	unsigned int i;
-	bool validate;
-	int rc;
-
-	for (i = 0; i <= desc->hdr.end_entry; i++) {
-		e = &desc->entries[i];
-
-		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
-		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
-		validate = (e->operation == SNP_PAGE_STATE_PRIVATE) ? true : false;
-
-		rc = pvalidate(vaddr, size, validate);
-		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
-			unsigned long vaddr_end = vaddr + PMD_PAGE_SIZE;
-
-			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
-				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
-				if (rc)
-					break;
-			}
-		}
-
-		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
-			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-	}
-}
-
 static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 				  unsigned int npages, enum psc_op op)
 {
@@ -782,72 +750,6 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
-static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
-{
-	int cur_entry, end_entry, ret = 0;
-	struct snp_psc_desc *data;
-	struct es_em_ctxt ctxt;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/* Copy the input desc into GHCB shared buffer */
-	data = (struct snp_psc_desc *)ghcb->shared_buffer;
-	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
-
-	/*
-	 * As per the GHCB specification, the hypervisor can resume the guest
-	 * before processing all the entries. Check whether all the entries
-	 * are processed. If not, then keep retrying. Note, the hypervisor
-	 * will update the data memory directly to indicate the status, so
-	 * reference the data->hdr everywhere.
-	 *
-	 * The strategy here is to wait for the hypervisor to change the page
-	 * state in the RMP table before guest accesses the memory pages. If the
-	 * page state change was not successful, then later memory access will
-	 * result in a crash.
-	 */
-	cur_entry = data->hdr.cur_entry;
-	end_entry = data->hdr.end_entry;
-
-	while (data->hdr.cur_entry <= data->hdr.end_entry) {
-		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
-
-		/* This will advance the shared buffer data points to. */
-		ret = sev_es_ghcb_hv_call(ghcb, true, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
-
-		/*
-		 * Page State Change VMGEXIT can pass error code through
-		 * exit_info_2.
-		 */
-		if (WARN(ret || ghcb->save.sw_exit_info_2,
-			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
-			 ret, ghcb->save.sw_exit_info_2)) {
-			ret = 1;
-			goto out;
-		}
-
-		/* Verify that reserved bit is not set */
-		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
-			ret = 1;
-			goto out;
-		}
-
-		/*
-		 * Sanity check that entry processing is not going backwards.
-		 * This will happen only if hypervisor is tricking us.
-		 */
-		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
-"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
-			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
-			ret = 1;
-			goto out;
-		}
-	}
-
-out:
-	return ret;
-}
-
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 				       unsigned long vaddr_end, int op)
 {
@@ -952,6 +854,20 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
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
2.37.2

