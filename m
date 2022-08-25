Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7615A1386
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiHYOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbiHYOX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC1B6D77
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzY2F0Rc5UkE5eIUib+oaXEFAqL2am0mqpgwowNsB/1Ik8r/pM7RKwcfG8xeJymRTmWlM/WXf2vTxy2ywHnflJz0NOUdph1bc5DiffJ9n8GKqdasU3QCdfP935K9s+czP64b9YPBp9vyuxpYxi57txPOPVUGSkVEZWuaxH0Er6w744rQV0s/PEo+O2MskxJM/wpUq5HHEGg1JjGz6R6AS2Y4DmY7HXTaDtymOeCWNmunorYA8oAlT7WJ19Lpwy9H7cc03utoeFCok7WEkwEZ7V8jN7Mh6YzZAFtGCWNc1INmpFFZ+Zx2js7XCAabUVC3k5t3Qr2/ycwE+pouecLXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enmS4hA+2Vtj5l/uuu3jBd68XCfq87bjfE5NRD/sX8g=;
 b=Y79BWIFFZDCM0QRdISSsYtN8j2nTBbTjObG+e4kd5NOcyR8UvXW2QHOpd548ca+uVwk1EvNJPk9+ovt/CTqG9VYhfMJktOPIpq5UhrgMTxbRayoHD2mA94HAJTyE2ZMRPIOWlzUJkoIt3vp1OWVhx7ZdZfZwog0c+unnFcbR/NMIPlkJlXpiYAy6f5kTapMiwSFqMH0IpN8nYhBkgmhiH4wUD5gGrxdGbziakZoODe8cxNR0ladYNq/6rHeth2XiaRB1qLk4j3HQqlBCeDaKmZO+N5IMdpBQRyVsl3TpPvP0IPxOei1cfvJKWdcaq8nwlx+DZ1itgjhfMHKdl2eWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enmS4hA+2Vtj5l/uuu3jBd68XCfq87bjfE5NRD/sX8g=;
 b=5YQTxheYFvyKd9vDIS4sgl9er2th1bAEZ7fz7cnLJkxzQ8J15q/Wvgry5OGFPY3Qucvl1hpxA8aoD2T4GDWYV3n4h4rj+FVFNyhEkn9xSlTi35jpzg/buC6GsS6ez6pmuItlbmjAsTmNaVc9jqjAU2DsBGOgTlys2qLUR5Y43CI=
Received: from MW4PR03CA0018.namprd03.prod.outlook.com (2603:10b6:303:8f::23)
 by BN6PR12MB1156.namprd12.prod.outlook.com (2603:10b6:404:1f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 25 Aug
 2022 14:23:51 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::5e) by MW4PR03CA0018.outlook.office365.com
 (2603:10b6:303:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 14:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Thu, 25 Aug 2022 14:23:51 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 09:23:49 -0500
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
Subject: [PATCH v4 3/4] x86/sev: Use large PSC requests if applicable
Date:   Thu, 25 Aug 2022 09:23:16 -0500
Message-ID: <a4a193bbfdea4e55787979b0f9fa2ee66a8c1fcf.1661437397.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0aebee1-f066-47dd-8790-08da86a56ee9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXh4D5Nxd0w3PjwDPajJv7ukUHocn2Nfudk6i034rsEEaJhjHjl68e7NuZoxeqfVIQ+duGIAmqsYBRCaglgfbuiEp82kzxkQzBZVbAlc5HnAt5Pmt/1ineiYrJgaqUbuDC8xp+YhLSQjynUsmT2W5IAPpdXL2UXl83cFnyFTbDzzVAvOYAHQRF8mO1R+xLzJaAXCaB9q1QsNMOcaJT7R7/n3foW5L9jNQpqWvUDxCAJouAPcD4BhkbbmMTXrVKapibTwsoBXnhj9YcA9tszLLvcmIGO/4J4rWvWEiScwDa/fhFGUkF/oE7IFWHexXlkKbxYmRqy2yZcbPJA94r5S1F1Q8DUmLOuKNcH4kXV21785vTFbvEV+qLd5JqMQDR6tNUyfxGWg104Dqy7q//d8jMhuFoszhBp+2vRApL5VaBgGyV9BtOHg35Ah+tuFq8iBDXz+00jX7S3CaFludHUZl/UywtjxfrFeEYulB+GGXEQOykbFg2CQyuHx5G7aBy+CUV97HHeRu4zfE2xdE+e3wLPna0M47Jdx10LNoj3hcIwnUhozxCTLp5EfQoWKELopvdCHLgwFsBEjlz3OLPoTtkfptd1swfTsb53vlfrptbk1AeHFgcDWFwylK0QNCSmQqGBdnG9XeoW1dNKLwMck+4L+fMnfru7lgwAmkHt+sYofthbphpQKQU58cw9U9f53bU0wN/OLUzexVIEF0XvvNRAGq2eZAX+SzqmheAF5PWs/KHDLRiyOs1fsm0Lb7ZAShfbJVhmueNSDCiUUmhfHtRsw1WL8fAl3A4qME62nZyo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(40470700004)(36840700001)(46966006)(7696005)(5660300002)(40480700001)(16526019)(8936002)(186003)(426003)(83380400001)(41300700001)(2906002)(6666004)(26005)(82310400005)(316002)(7416002)(40460700003)(478600001)(2616005)(336012)(70206006)(8676002)(54906003)(110136005)(82740400003)(4326008)(36860700001)(86362001)(356005)(36756003)(47076005)(81166007)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:23:51.3152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0aebee1-f066-47dd-8790-08da86a56ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1156
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

In advance of providing support for unaccepted memory, request 2M Page
State Change (PSC) requests when the address range allows for it. By using
a 2M page size, more PSC operations can be handled in a single request to
the hypervisor. The hypervisor will determine if it can accommodate the
larger request by checking the mapping in the nested page table. If mapped
as a large page, then the 2M page request can be performed, otherwise the
2M page request will be broken down into 512 4K page requests. This is
still more efficient than having the guest perform multiple PSC requests
in order to process the 512 4K pages.

In conjunction with the 2M PSC requests, attempt to perform the associated
PVALIDATE instruction of the page using the 2M page size. If PVALIDATE
fails with a size mismatch, then fallback to validating 512 4K pages. To
do this, page validation is modified to work with the PSC structure and
not just a virtual address range.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h |   4 ++
 arch/x86/kernel/sev.c      | 125 ++++++++++++++++++++++++-------------
 2 files changed, 84 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 19514524f0f8..0007ab04ac5f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -79,11 +79,15 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+/* PVALIDATE return codes */
+#define PVALIDATE_FAIL_SIZEMISMATCH	6
+
 /* Software defined (when rFlags.CF = 1) */
 #define PVALIDATE_FAIL_NOUPDATE		255
 
 /* RMP page size */
 #define RMP_PG_SIZE_4K			0
+#define RMP_PG_SIZE_2M			1
 
 #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a5f02b6b099b..a744f7f2e72b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -655,32 +655,58 @@ static u64 __init get_jump_table_addr(void)
 	return ret;
 }
 
-static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool validate)
+static void pvalidate_pages(struct snp_psc_desc *desc)
 {
-	unsigned long vaddr_end;
+	struct psc_entry *e;
+	unsigned long vaddr;
+	unsigned int size;
+	unsigned int i;
+	bool validate;
 	int rc;
 
-	vaddr = vaddr & PAGE_MASK;
-	vaddr_end = vaddr + (npages << PAGE_SHIFT);
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
 
-	while (vaddr < vaddr_end) {
-		rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (WARN(rc, "Failed to validate address 0x%lx ret %d", vaddr, rc))
 			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-
-		vaddr = vaddr + PAGE_SIZE;
 	}
 }
 
-static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+				  unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
+	int ret;
+
+	vaddr = vaddr & PAGE_MASK;
 
 	paddr = paddr & PAGE_MASK;
 	paddr_end = paddr + (npages << PAGE_SHIFT);
 
 	while (paddr < paddr_end) {
+		if (op == SNP_PAGE_STATE_SHARED) {
+			/* Page validation must be rescinded before changing to shared */
+			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
+			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+				goto e_term;
+		}
+
 		/*
 		 * Use the MSR protocol because this function can be called before
 		 * the GHCB is established.
@@ -701,7 +727,15 @@ static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum
 			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
 			goto e_term;
 
-		paddr = paddr + PAGE_SIZE;
+		if (op == SNP_PAGE_STATE_PRIVATE) {
+			/* Page validation must be performed after changing to private */
+			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
+			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+				goto e_term;
+		}
+
+		vaddr += PAGE_SIZE;
+		paddr += PAGE_SIZE;
 	}
 
 	return;
@@ -720,10 +754,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	  * Ask the hypervisor to mark the memory pages as private in the RMP
 	  * table.
 	  */
-	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_PRIVATE);
-
-	/* Validate the memory pages after they've been added in the RMP table. */
-	pvalidate_pages(vaddr, npages, true);
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
@@ -732,11 +763,8 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
-	/* Invalidate the memory pages before they are marked shared in the RMP table. */
-	pvalidate_pages(vaddr, npages, false);
-
 	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
 void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
@@ -820,10 +848,11 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 	return ret;
 }
 
-static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
-			      unsigned long vaddr_end, int op)
+static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
+				       unsigned long vaddr_end, int op)
 {
 	struct ghcb_state state;
+	bool use_large_entry;
 	struct psc_hdr *hdr;
 	struct psc_entry *e;
 	unsigned long flags;
@@ -837,27 +866,37 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 	memset(data, 0, sizeof(*data));
 	i = 0;
 
-	while (vaddr < vaddr_end) {
-		if (is_vmalloc_addr((void *)vaddr))
+	while (vaddr < vaddr_end && i < ARRAY_SIZE(data->entries)) {
+		hdr->end_entry = i;
+
+		if (is_vmalloc_addr((void *)vaddr)) {
 			pfn = vmalloc_to_pfn((void *)vaddr);
-		else
+			use_large_entry = false;
+		} else {
 			pfn = __pa(vaddr) >> PAGE_SHIFT;
+			use_large_entry = true;
+		}
 
 		e->gfn = pfn;
 		e->operation = op;
-		hdr->end_entry = i;
 
-		/*
-		 * Current SNP implementation doesn't keep track of the RMP page
-		 * size so use 4K for simplicity.
-		 */
-		e->pagesize = RMP_PG_SIZE_4K;
+		if (use_large_entry && IS_ALIGNED(vaddr, PMD_PAGE_SIZE) &&
+		    (vaddr_end - vaddr) >= PMD_PAGE_SIZE) {
+			e->pagesize = RMP_PG_SIZE_2M;
+			vaddr += PMD_PAGE_SIZE;
+		} else {
+			e->pagesize = RMP_PG_SIZE_4K;
+			vaddr += PAGE_SIZE;
+		}
 
-		vaddr = vaddr + PAGE_SIZE;
 		e++;
 		i++;
 	}
 
+	/* Page validation must be rescinded before changing to shared */
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_pages(data);
+
 	local_irq_save(flags);
 
 	if (sev_cfg.ghcbs_initialized)
@@ -865,6 +904,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 	else
 		ghcb = boot_ghcb;
 
+	/* Invoke the hypervisor to perform the page state changes */
 	if (!ghcb || vmgexit_psc(ghcb, data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
@@ -872,29 +912,28 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		__sev_put_ghcb(&state);
 
 	local_irq_restore(flags);
+
+	/* Page validation must be performed after changing to private */
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_pages(data);
+
+	return vaddr;
 }
 
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 {
-	unsigned long vaddr_end, next_vaddr;
 	struct snp_psc_desc desc;
+	unsigned long vaddr_end;
 
 	/* Use the MSR protocol when a GHCB is not available. */
 	if (!boot_ghcb)
-		return early_set_pages_state(__pa(vaddr), npages, op);
+		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
 
-	while (vaddr < vaddr_end) {
-		/* Calculate the last vaddr that fits in one struct snp_psc_desc. */
-		next_vaddr = min_t(unsigned long, vaddr_end,
-				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
-
-		__set_pages_state(&desc, vaddr, next_vaddr, op);
-
-		vaddr = next_vaddr;
-	}
+	while (vaddr < vaddr_end)
+		vaddr = __set_pages_state(&desc, vaddr, vaddr_end, op);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
@@ -902,8 +941,6 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return;
 
-	pvalidate_pages(vaddr, npages, false);
-
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
@@ -913,8 +950,6 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
 		return;
 
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
-
-	pvalidate_pages(vaddr, npages, true);
 }
 
 static int snp_set_vmsa(void *va, bool vmsa)
-- 
2.37.2

