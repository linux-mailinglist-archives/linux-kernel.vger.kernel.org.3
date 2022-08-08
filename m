Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434458CC95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiHHRQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiHHRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:16:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84A715708
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBBIBiZ9Z6ljoQwoeaoH801ALzSz7TAidK7djQlxsv8DU+nQm6fqptbvrSsgTrsqepL0kZht19r69g2bMjU7cnkQvq5uB2cvCLxDO4hXI03Nxxlhxd4lXz3ieY5klFRJsKSrvzyfXYzcb+w+iEDZiLK21Vp6GiTAXIAURMykBvaqOERu+YpF/pQMzaIGwp+Z59wbs83AShq1h5eaBI5QSvzZUjUjuNTYBwANpy+FSyvL9xrKYZvLAMiTJpeKtyVqGNUw9a5rLj2dnrXWglPLiZQXomA37D42mEIUxNX8Al2YI00lWrHUEbLu5hYumv+ja1t1hJzNuTM5JtXMar/REw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4d85BFRAFpL6oBd1UxfXGrV1n+gi1EEr/zfl6GsaXs=;
 b=A1/XNuMdZgcn83bjZ8vGckr6Y6rCpkYuk+M5Up8dBBVsX+69fRMgWzaitDp/vAzqu4Pd+T8Byf6HTH7xD9fcb5r84aEgbqcleJxOO8BT78yAdhcfit+g7iDMAN1ZX8CSIePX1pY25MGZEnwk5IcQ4qWs9pSjRP3Ken/buyvTQ3fcPWrmXSS/T8UITe5EBltH4HHXcw2mLmvyqT02VwO/TwLQhxaqzZdSX24MjMyo+1Ab93jHY0CZ2kfKGzynRf/E9uDmtY6FSXl+DrkNF+wLco2ovhoo5BwWfuNUcC94RXj1QXsq5FeoXlM6/7/BNxvBEefCVVwK657O59oH3eYNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4d85BFRAFpL6oBd1UxfXGrV1n+gi1EEr/zfl6GsaXs=;
 b=u2qwztPBpZZHZ7q6R7AFbHRwOj98SqkruDpZUGKHFV0EL23oIOyt5+QsZsxwp9MgxmqCaUVqTU12yWJEXKIYNp0DnrQR0eLwwI/YG2zcF/GV3Her7G7DNVACMLvxh4flFAfwCYjQ54FapUpBNPTNfjQbiG3TuuyDdHnrqv2TA+s=
Received: from DM6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:333::9) by
 BN6PR12MB1604.namprd12.prod.outlook.com (2603:10b6:405:c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Mon, 8 Aug 2022 17:16:45 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::15) by DM6PR03CA0076.outlook.office365.com
 (2603:10b6:5:333::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Mon, 8 Aug 2022 17:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 17:16:44 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 12:16:43 -0500
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
Subject: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Mon, 8 Aug 2022 12:16:24 -0500
Message-ID: <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93b1da3d-61ac-45e7-7ca5-08da7961c4cf
X-MS-TrafficTypeDiagnostic: BN6PR12MB1604:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WUVwQnKrmAKEvMcJtAQWzSAgMJ0liuaSPxUt6O+FkVYdiZxoX/jTukhjJMccD3O7pCXL5T+xTlFI2+qaJts2zbNAFbFKexL0NH34qsGGfdltMmZxPudoDiBj0dB95BLhUZ+0HdJeENJJUyMi4HtcC2/2c/3OqSrM84BsLrsvKhK0aZ4NTu//nnliFBpBOjLtz0QHQw3dJEcpIWV4taMLX+f3QKDbyhLpLADfnzlTKbvFPy21z0g2S10bOmbQlI574UhhUIT0+Ps2FA5arr+eJ8hgILJpno9kxA59ygeqdk40Iy5CwLCSz7ql943OlHrRRWYPjLEYga9jPo4Rt8pvFifh/v9wKVpyoYlOc8B+4rRtSyxDuMEo77+LDyv8d/FfaZY74+6OoVaULRnDWNIzjmU46dhoSan5yvsO8jmT1IOUWuShFn+8dyc9qFHRPLb6Ag0FBosHceDKE2MQ73qqzZcjDG/7mMxiuGftk+CcPLHOQw6o0m03eUwNhdEcootwD3DvMRJdkjcsRxtc77mZDFUFK6Kq+E2jCf5YRicKYAawrRl4hjATh3VjLkL11Byro/UnAq16pwx5DSpDOyIjj4I7WgRkyCe6VuYP4xpe9irdhpIrK8lr2t2aYZfAMY5EqdFnHav36LurPaAq0G99X1CY7r7v97ViWqRXeEEOiakss6lnR+B0QLR3pSYA1TtmcSRe9zieE0vRRbmIhBdFmRG3vHhDnsqmyCaqO/3VxQqibhik9z5N8EaEqv7l9IumCUyo+9+fQ3mli73C8RboBja6QS/3r24B1hQCz8/HUx+RMEC2aEbyDbVIzJpTzL3cGvALvtXLW5h5agoU9JnRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(40470700004)(46966006)(8676002)(8936002)(70586007)(36756003)(70206006)(4326008)(478600001)(186003)(336012)(16526019)(40460700003)(316002)(54906003)(5660300002)(7416002)(426003)(110136005)(86362001)(41300700001)(26005)(83380400001)(7696005)(6666004)(81166007)(356005)(2906002)(2616005)(82740400003)(82310400005)(47076005)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 17:16:44.5973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b1da3d-61ac-45e7-7ca5-08da7961c4cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1604
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
and total PSC requests.

Also, since set_pages_state() uses the per-CPU GHCB, add a static variable
that indicates when per-CPU GHCBs are available. Until they are available,
the GHCB MSR protocol is used to perform page state changes.

If either the reduction in PSC entries or the use of the MSR protocol
until the per-CPU GHCBs are available, result in any kind of performance
issue (that is not seen at the moment), use of a larger static PSC struct,
with fallback to the smaller stack version, or use the boot GHCB prior to
per-CPU GHCBs, can be investigated.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev-common.h |  2 +-
 arch/x86/kernel/sev.c             | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b8357d6ecd47..6f7268a817fc 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -107,7 +107,7 @@ enum psc_op {
 #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
 
 /* SNP Page State Change NAE event */
-#define VMGEXIT_PSC_MAX_ENTRY		253
+#define VMGEXIT_PSC_MAX_ENTRY		64
 
 struct psc_hdr {
 	u16 cur_entry;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f0124c410..275aa890611f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -66,6 +66,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb *boot_ghcb __section(".data");
 
+/* Flag to indicate when the first per-CPU GHCB is registered */
+static bool ghcb_percpu_ready __section(".data");
+
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
@@ -660,7 +663,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -868,11 +871,16 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
-	struct snp_psc_desc *desc;
+	struct snp_psc_desc desc;
+
+	/*
+	 * Use the MSR protocol when the per-CPU GHCBs are not yet registered,
+	 * since vmgexit_psc() uses the per-CPU GHCB.
+	 */
+	if (!ghcb_percpu_ready)
+		return early_set_pages_state(__pa(vaddr), npages, op);
 
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	memset(&desc, 0, sizeof(desc));
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
@@ -882,12 +890,10 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
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
@@ -1254,6 +1260,8 @@ void setup_ghcb(void)
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 			snp_register_per_cpu_ghcb();
 
+		ghcb_percpu_ready = true;
+
 		return;
 	}
 
-- 
2.36.1

