Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D865932A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiHOP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHOP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:59:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447171A820
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWzrf12fhEh6qQM/pcrn4R/fcolbkzcs1W1HO3dmtLRifo0vTY5xNlyJD9IRVG+0Rh1kjV/sicvTG2I5CLuaVpiHUVzfuDW7iCaXUrzcst+HIk9IC0VnW2zuCmE2xGjPONsDsIrD9w93YtEOf20PfVgNXiIa0JKaxOjovIh0QTeugBaQGbbxflaAfu+sQOUBCQBg8v5/B4HG6gRy5enE/oIpkU7zPGyQlTH/CIkVXPvHFaxwBCV8ThQsaD2YECxW/5Y+jJpzXtSmWPdrMn+pkHxaU3qmM7iPDCbyCECLGDHEQ7Q4RXicrmMwRz1ipJXoIoRcbHqOzbLotKlHGAIbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDzM/4KQPIQYRblWZ2Iv+3gYcSwszZxyT2xuKzysW58=;
 b=TR/wRgkqJa4fiT9+nZbLkqChxWC2GtaJ1OIm8NF4ENYhmEPvRl06dDp/8lSx2HbL8oSCf+3B0YllzP9QwL0jq9oQmxffS/gVncL6Lr+BwtjDLkbnKIqYzBjibFicd6pMIefzSXrtwjjCQvsDLCdIJBfwDGAMvb84/Jq7dhDY5KBhMcbfLGzu9QpEGxI7wfdisXdantgHD3wLpqWiItnO1pyw+a3cKJ6Y+43h/qCb9MyKBiyfTlYtiUM9yfCVYuHaB5ntf3zxInLRjjm4TkmOL+L1w1o3URANsSY3Ds4NDtDtMDIu//7a+baJ/M/HI/L8/NmGCJUMAxVzazVSGkmebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDzM/4KQPIQYRblWZ2Iv+3gYcSwszZxyT2xuKzysW58=;
 b=gs9EoQt1HCFLTYDJHF30XXljHK6kLRyRRU9RvBHcYAuBXZ+Xncl0LwxKjazD+Kv7oLOI15kKKwz2sYWUtd/Hr/WFwVjvrcLpJY6Yt90TbBgW70FgyIi9w8y3zG5cAwN/M4I1JRrWxaPrM5SpAa00IROfSrIJSzf7fBLZE1NaTHE=
Received: from DM6PR02CA0049.namprd02.prod.outlook.com (2603:10b6:5:177::26)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 15:58:56 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::b8) by DM6PR02CA0049.outlook.office365.com
 (2603:10b6:5:177::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 15 Aug 2022 15:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 15:58:55 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 10:58:53 -0500
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
Subject: [PATCH v3 1/2] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Mon, 15 Aug 2022 10:57:42 -0500
Message-ID: <9017076fe1050b8a38d5ee8447b827a5c41c4e72.1660579062.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf29e465-ef03-4b29-e314-08da7ed70ee8
X-MS-TrafficTypeDiagnostic: PH0PR12MB5647:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0m7py7ACaVGdD4D4aREIRfFBwxWd0p0zLfGd9qF/L5//Zsoi/blR0rtnKolfJ9g/fkAQsat9jY/Mlcoi65rvZBK0w85K9LDbC/lWq/XB2GIa3yNPP10TSLSVn1pNvhrBKTn9TfZblBjK0g8Lm2giFLKgRYlxlhumyePiqpUIClX5hH4EH9u2KmoVtA74+tAzk0zG+OUNVQlFmy5e23rWlY5wbh3+SP28qvOyfeM+EZ2yHuyol7jZbR8Fukf6of0PmoRx0GsMP54QOjn04ZXQVlSnxzUkvqwCo+/AC+3vE7lSLUrpHGx9CQ9sOyYIPLWj5yY+iWhDGo7ZTH1Xxkrt/SR9E/4TcjmQ3/TRvCyt2AiARgtlonEWGMoiTFeaqkIsGQ/QCBfHcq+rlZNrvlh6csDWXV7uf/TLcEXlZTOfEEOLtAAcr/gjBND64xJQ02vZyk2Jaqq6ofsmnADs4uzodjDqzioDBxy27DfnQa5acFGUtTEEF37V5L/ofM4Lhbt3X0DNbYYsOuIwUjpayJst0+4tW6bCE/IODuMizFDd4OHOio4/MIdI46igfZwCgNiUKLrm9q6Je/fkJQEvCoIjai5gM2GrjxbKK0OGE8HYDK0gKNnq7Xrx6NvvQt9/OuB50tvbFBtisGbfscp/pyvur/wQtNCDqbeuZYAD84QUpWuyeBEaj/MbKmUStAsTq7Vx1pWkbvUPKmhwuOncipivZX4MnEWhM6e3afvrsRfPSoPVKt/uad9QVTouRIg8w4sdHSMpKmXa06/qfcy872kyUahCa4qGg/+HKBi2oYE++PZaeosLHvSYINx2wu657q2OCPTzqmoAFeuHeNfbZKUCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(40470700004)(46966006)(36840700001)(81166007)(83380400001)(40480700001)(356005)(36860700001)(2906002)(8676002)(4326008)(8936002)(7416002)(5660300002)(70586007)(70206006)(36756003)(41300700001)(54906003)(110136005)(426003)(2616005)(186003)(336012)(16526019)(40460700003)(82740400003)(47076005)(82310400005)(86362001)(6666004)(7696005)(26005)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 15:58:55.8620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf29e465-ef03-4b29-e314-08da7ed70ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In advance of providing support for unaccepted memory, switch from using
kmalloc() for allocating the Page State Change (PSC) structure to using a
local variable that lives on the stack. This is needed to avoid a possible
recursive call into set_pages_state() if the kmalloc() call requires
(more) memory to be accepted, which would result in a hang.

The current size of the PSC struct is 2,032 bytes. To make the struct more
stack friendly, reduce the number of PSC entries from 253 down to 64,
resulting in a size of 520 bytes. This is a nice compromise on struct size
and total PSC requests while still allowing parallel PSC operations across
vCPUs.

Also, since set_pages_state() uses the per-CPU GHCB, add a static variable
that indicates when per-CPU GHCBs are available. Until they are available,
the GHCB MSR protocol is used to perform page state changes. For APs, the
per-CPU GHCB is created before they are started and registered upon
startup, so this flag can be used globally for the BSP and APs instead of
creating a per-CPU flag.

If either the reduction in PSC entries or the use of the MSR protocol
until the per-CPU GHCBs are available, result in any kind of performance
issue (that is not seen at the moment), use of a larger static PSC struct,
with fallback to the smaller stack version, or use the boot GHCB prior to
per-CPU GHCBs, can be investigated.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev-common.h |  9 +++++++--
 arch/x86/kernel/sev.c             | 32 +++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6ecd47..6c3d61c5f6a3 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -106,8 +106,13 @@ enum psc_op {
 #define GHCB_HV_FT_SNP			BIT_ULL(0)
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
 
-/* SNP Page State Change NAE event */
-#define VMGEXIT_PSC_MAX_ENTRY		253
+/*
+ * SNP Page State Change NAE event
+ *   The VMGEXIT_PSC_MAX_ENTRY determines the size of the PSC structure,
+ *   which is a local variable (stack usage) in set_pages_state(). Do not
+ *   increase this value without evaluating the impact to stack usage.
+ */
+#define VMGEXIT_PSC_MAX_ENTRY		64
 
 struct psc_hdr {
 	u16 cur_entry;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f0124c410..40268ce97aad 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -66,6 +66,17 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb *boot_ghcb __section(".data");
 
+/*
+ * A flag used by set_pages_state() that indicates when the per-CPU GHCB has
+ * been created and registered and thus can be used instead of using the MSR
+ * protocol. The set_pages_state() function eventually invokes vmgexit_psc(),
+ * which only works with a per-CPU GHCB.
+ *
+ * For APs, the per-CPU GHCB is created before they are started and registered
+ * upon startup, so this flag can be used globally for the BSP and APs.
+ */
+static bool ghcb_percpu_ready __section(".data");
+
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
@@ -660,7 +671,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -751,6 +762,8 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 	unsigned long flags;
 	struct ghcb *ghcb;
 
+	WARN_ON_ONCE(!ghcb_percpu_ready);
+
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
 	 * a per-CPU GHCB.
@@ -868,11 +881,14 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
-	struct snp_psc_desc *desc;
+	struct snp_psc_desc desc = {};
 
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	/*
+	 * Use the MSR protocol when the per-CPU GHCBs are not yet registered,
+	 * since vmgexit_psc() uses the per-CPU GHCB.
+	 */
+	if (!ghcb_percpu_ready)
+		return early_set_pages_state(__pa(vaddr), npages, op);
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
@@ -882,12 +898,10 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 		next_vaddr = min_t(unsigned long, vaddr_end,
 				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
 
-		__set_pages_state(desc, vaddr, next_vaddr, op);
+		__set_pages_state(&desc, vaddr, next_vaddr, op);
 
 		vaddr = next_vaddr;
 	}
-
-	kfree(desc);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
@@ -1254,6 +1268,8 @@ void setup_ghcb(void)
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 			snp_register_per_cpu_ghcb();
 
+		ghcb_percpu_ready = true;
+
 		return;
 	}
 
-- 
2.36.1

