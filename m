Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7B4589212
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiHCSLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiHCSL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:11:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFE5A15C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjyofSzvz5ycpVUfLQM8q0VsGtzxuUQa+cJXRp/VftPFgj5TiI9Li/ptkqPDyNLEwVHaKXmYuFGrm3DcBQR0vaGed1hwnLaI1veWh/WLZtdNsjG+Q0OqYf4YLnmSQJhxMY0XGoFSqSofcZly8CMJ9ym3uB1P1TuYzmNN6wByp8flE3dq6X57FXN01uMlHbEDGNpdFY3Og+TBsHybsBIYAaJAowb+h5aWHukO/TcqM8WXqKK6ON5zpFW2iLdB3PWJtp8srrmGjtBoYTguIsbgxOBOASNtmO0au7uyVQ3ahmbnplutm8ljLI8jIs/40i7qvs7vBlfXjC4joXOaaqd1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQm50REmriNtQMj/y/MIf4aYGb8z8zyH9M/azBpOqHo=;
 b=ida1Obj92zWcGsrdjcqMlmDgYlfnj77GZ+lNNLgt0NuwyMpA6mCBATQRey+dUlHTjO0ca62yeMGIH/0NyR7L5LaXmJSJk8gVBkUEXjEsQM0E9te9ulhy01O2eWmHc1e8TwxNI7dq5o1mUjBNpIN/sRwkKI52N5uu/MPzrirTNHVO1H4ojz4julHnXmMVrnYA7Uz7zQhp//gKMN3CrjC0GKtNwnfzVl/5xoC+UXUEa9WSN2jLm8DEYIYJN7HrAoBnvVy49bzKTcaXVrIjeBpK25nnCOlBTJfg8iFkeWzJVwwYRcx9s0LU1z01nJnlXR7fx1BPTvtuFuAtCRC9o9HQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQm50REmriNtQMj/y/MIf4aYGb8z8zyH9M/azBpOqHo=;
 b=DMlSGcCB7rTLmZkE3p/8kQyCyDe8Ni3yUyywvJe/KX4iu44vQNczOrEK6HTbvUqxVP2h0LXSveza1PBEadsPTnOlGNUl6yB8ulD3NRaaUbVZyEc9zGAKpr6/W6nWTbe94RKvKRbgiwL1BxrMvWZnbz9uXErdy+xtPkAb6ZBXBGg=
Received: from DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15)
 by MWHPR12MB1360.namprd12.prod.outlook.com (2603:10b6:300:12::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 18:11:25 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::50) by DM6PR08CA0041.outlook.office365.com
 (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 3 Aug 2022 18:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Wed, 3 Aug 2022 18:11:24 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 3 Aug
 2022 13:11:22 -0500
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
Subject: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for unaccepted memory support
Date:   Wed, 3 Aug 2022 13:11:04 -0500
Message-ID: <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f379e6a2-e288-4fa3-6718-08da757b93f9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1360:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32+SHe8veVwode5Tk5XdApH8BuIYM3h9CgtV3oOV0zSMVUfBLilWMY0AbdjSQweg1IymI9UIm+m39imFFsGAw3PKRxsbT591vGxrkZ4kvj5qq4n9JeTY7gzJo/qIBhZs7GDcXl7xtmjM8/GEQXtCE7miOJ6B452NKkCJgdtJKQcM7kf0ZYDhixOIHtjJBi7OPvennL3Zrh+cUFUDySGqg2Hjhc2DlS7LP1xca7Ndb0uM8ouPIaxDSWIPUcaixyGApndAL0wSPukRDcMN16BVElXgqqSRFWiV8rn78vdzaXcOAL8sV8m9fsqEAfIZL22xIhcVyquzclFplJf2JnJXsrnJSmPxOfKyJUABXoF7nkvbAL5ebqJ6LDZGrYqsPkLGvz7GDi3FJHKFmyPnZmH/HSEA5AyuEDi0DyTRM0eDAOOkzkHCuSXe69890EARoetaM5ps9j+jV7kGF6r0NFiZtAgLWc3m7/QaXD1ZvgeJfz3IAmL4AxLDMnMCd0CzXq22LKt8tn7mUuwp9mRVAZfIJGAFNT4VKkg7F1sGn/DJ+taZFyVNQd6RKihUoCyvM8uFJHD+cou7LPqqbxwMmBign3qOzLi2pFAPfPiXEQi2KhOh8KFNU7AfjWa1I5LO07ADrNfqfBLestKCOOMHGallDCvsgbXgx128Rs8RZpiBQ8lKdqP3X3cMl1wo0mKRzd6BlgqZ1ASXiPtHq91UIYQm7yIkfTE4GKLQMXLe4AFS9kBktF5/2eD6jpCm8sjup6nUZZybzlyhgAoWO4p2hmkwYTLqPxaU0d/A+GFW7rvwvFSKiHCR7a60y5TULVNWa0HhG2C8ypaEsFLVh1orkyZEtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(6666004)(478600001)(186003)(336012)(426003)(316002)(16526019)(83380400001)(36756003)(26005)(54906003)(40460700003)(41300700001)(2616005)(8936002)(7696005)(4326008)(7416002)(40480700001)(356005)(2906002)(8676002)(81166007)(47076005)(110136005)(82740400003)(70206006)(70586007)(86362001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 18:11:24.9431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f379e6a2-e288-4fa3-6718-08da757b93f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In advance of providing support for unaccepted memory, switch from using
kmalloc() for allocating the Page State Change (PSC) structure to using a
static structure. This is needed to avoid a possible recursive call into
set_pages_state() if the kmalloc() call requires (more) memory to be
accepted, which would result in a hang.

Page state changes occur whenever DMA memory is allocated or memory needs
to be shared with the hypervisor (kvmclock, attestation reports, etc.).
Since most page state changes occur early in boot and are limited in
number, a single static PSC structure is used and protected by a spin
lock with interrupts disabled.

Even with interrupts disabled, an NMI can be raised while performing
memory acceptance. The NMI could then cause further memory acceptance to
be performed. To prevent a deadlock, use the MSR protocol if executing in
an NMI context.

Since the set_pages_state() path is the only path into vmgexit_psc(),
rename vmgexit_psc() to __vmgexit_psc() and remove the calls to disable
interrupts which are now performed by set_pages_state().

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 55 +++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f0124c410..84d94fd2ec53 100644
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
 
@@ -122,6 +125,15 @@ struct sev_config {
 
 static struct sev_config sev_cfg __read_mostly;
 
+/*
+ * Page State Change structure for use when accepting memory or when changing
+ * page state. Use is protected by a spinlock with interrupts disabled, but an
+ * NMI could still be raised, so check if running in an NMI an use the MSR
+ * protocol in these cases.
+ */
+static struct snp_psc_desc psc_desc;
+static DEFINE_SPINLOCK(psc_desc_lock);
+
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -660,7 +672,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -742,26 +754,17 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
-static int vmgexit_psc(struct snp_psc_desc *desc)
+static int __vmgexit_psc(struct snp_psc_desc *desc)
 {
 	int cur_entry, end_entry, ret = 0;
 	struct snp_psc_desc *data;
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
-	unsigned long flags;
 	struct ghcb *ghcb;
 
-	/*
-	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
-	 * a per-CPU GHCB.
-	 */
-	local_irq_save(flags);
-
 	ghcb = __sev_get_ghcb(&state);
-	if (!ghcb) {
-		ret = 1;
-		goto out_unlock;
-	}
+	if (!ghcb)
+		return 1;
 
 	/* Copy the input desc into GHCB shared buffer */
 	data = (struct snp_psc_desc *)ghcb->shared_buffer;
@@ -820,9 +823,6 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 out:
 	__sev_put_ghcb(&state);
 
-out_unlock:
-	local_irq_restore(flags);
-
 	return ret;
 }
 
@@ -861,18 +861,25 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		i++;
 	}
 
-	if (vmgexit_psc(data))
+	if (__vmgexit_psc(data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
-	struct snp_psc_desc *desc;
+	unsigned long flags;
 
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	/*
+	 * Use the MSR protocol when either:
+	 *   - executing in an NMI to avoid any possibility of a deadlock
+	 *   - per-CPU GHCBs are not yet registered, since __vmgexit_psc()
+	 *     uses the per-CPU GHCB.
+	 */
+	if (in_nmi() || !ghcb_percpu_ready)
+		return early_set_pages_state(__pa(vaddr), npages, op);
+
+	spin_lock_irqsave(&psc_desc_lock, flags);
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
@@ -882,12 +889,12 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 		next_vaddr = min_t(unsigned long, vaddr_end,
 				   (VMGEXIT_PSC_MAX_ENTRY * PAGE_SIZE) + vaddr);
 
-		__set_pages_state(desc, vaddr, next_vaddr, op);
+		__set_pages_state(&psc_desc, vaddr, next_vaddr, op);
 
 		vaddr = next_vaddr;
 	}
 
-	kfree(desc);
+	spin_unlock_irqrestore(&psc_desc_lock, flags);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
@@ -1254,6 +1261,8 @@ void setup_ghcb(void)
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 			snp_register_per_cpu_ghcb();
 
+		ghcb_percpu_ready = true;
+
 		return;
 	}
 
-- 
2.36.1

