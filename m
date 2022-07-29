Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830F258513B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbiG2OBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiG2OBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:01:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F433421
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIoDl6O+qv8F0iKka1kU0fvKS2aTPNUiLZcq9xw7y80p2Kt/Ye1KZK82pWdxs5iYYZaNZw/z0pAqgspJEg3Hgc1s7KasvBu2Rncr9dMP1Z7p5lYjytX9yQKDgrz1Ptz/slNq8LPrNKblDtSjohY1YQSO750WUy4lJabwrH0qvgwxAz1pWK8OSxBH1UYwxhnmtjSmp16Q2BmMxsnVwpXVctuymBjoK1bP3x1cXq/qzjHOA6whtrjIOzsmlBIsYOVLve+RZqhGn6sBU4dwAeuqhsReYN5bEwtEfLrqvJdpwYY3S8nqK1ym7GDrfpjWRQSoeeX1rpnQ4m7u1CfTciksOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/tz33B0t5QDsWkkHM86Y1faWab12STOy1F42C3lr6g=;
 b=HijWby0AjOpWAjkWdlSQ6QU1emAg47EMlcaatwZHIwIVzCkmKW7JreNCmoW01pfg3x5BJS42gB5dJ3MxCnhV/rjSLOwjWskSJUXtR4hSLSnyXV30/20D00id+VPujFTqOF0qQNEzXBSjP/T6YYGnRkQVh5SDFtJ5nj4C6aMVyBj68GczSNjPf5ak5nzRu6Z2uL6Bsx2iUqvMNnxeROpFVX52U9kPgPr76pR0Qsjdbg/FRAxRSLwoplrzyhCBYs/wvh7zN+ZIOTzKtavsG+t8Tiu50pR0JQbBMkEAftyOsU6dONz2iBDfUKdCmtgya8+czKIjj+2B0PcJXpUgS3qRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/tz33B0t5QDsWkkHM86Y1faWab12STOy1F42C3lr6g=;
 b=5uQBLEFDotmxhJQf3LtVcRttzy8IFao9TbE9UMDbkpeo4ahC8SsYO7+wVr0xV3dVL389vO299RgVPIVJHNLWWJNQmwNjbvO8bmPw0qKwvnJwdtgQ+swmd7mrxrEDTaeeOBKPzfCkT7hUR9NlgVpmgjJ4POIq4D0u5Y6fgNGpxmc=
Received: from MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::34)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 14:01:42 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::6e) by MW4P220CA0029.outlook.office365.com
 (2603:10b6:303:115::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 29 Jul 2022 14:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 14:01:41 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 09:01:33 -0500
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
Subject: [PATCH v1 1/2] x86/sev: Use per-CPU PSC structure in prep for unaccepted memory support
Date:   Fri, 29 Jul 2022 09:01:14 -0500
Message-ID: <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c80b34ae-9663-4976-28af-08da716add4c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQAIRcu6pYX+j/S4u7PBUN6S/+pbVoNgcIBSQGqJEW3Imm9mygWMjmbnnhMV//LGlUA5r/n7/aYY1dPi789oQg6TVUHZx0b85datWsPLV3P1n8DnmZ+B384ULKeJf/Ykgtrn7g3jSjXE8GKNKMe27xUnE19jjyJ77rcDMoMWAB3nqkoVEG4WIb9Pya9tPeaqt07/PbHOTaFhOfHANEogxMBuEGOIh0NrK8ckWWh3GXtoncfx5ElBzec3+JBsJ2ja+VRpf6m0/sXpccFVzJ586y4Gksn7jLdjEg5yB/gUyYFfQa9b3RD/c8gFNu662yp0egl89zDxOuvgxD1t4IUT8lWf8HIZM0uWzE9xhfiAagvQ4fIxb7XzNHV859hceZnBlBMuZh8fDR8aVVhJq9QYeJGLRUNYKaFGnM5KvmrLyPzTg4Yk32ZJYeJ++6zee8CzEA7OAvXflDOjeo8B1YZk62bexxaqc/dgPTIdu83hgjXQGyV448+JGJzboVQZHJvgvfoKXE+Au1npMOVBVIcUixYmfIAVZlQURoTwVih+TeijbyrLqkR2zlW0f04VSGLU+s2WbK6SgX5EAq3WeTAQnrpgArawEYw+M5iaFWueB4HQdkSNcdlkUCCGw1gpzfawJ+Veb11v8wpiRLJ1STIEvyCZyfhbPvAuxE/qNZhFaw1V6KVNDd8fPo1+nb7L0h4gWG7+RKjlIe/9CthdIKRc4bzu+p3feG7SgJJ83Un2UT8klbwlzrwD9TOEbgwWx2nY6XD6lsVC3hBAJbX8sjCnH2Gq9pMEJ6sCGR7czBJJb/yE+QnUDzPP/l0RELv06wH7QJMH7+3We4REBff60fZCZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(36756003)(83380400001)(336012)(16526019)(2616005)(186003)(426003)(47076005)(110136005)(8676002)(4326008)(70586007)(54906003)(70206006)(316002)(86362001)(2906002)(478600001)(40460700003)(7696005)(26005)(5660300002)(7416002)(8936002)(81166007)(356005)(82740400003)(82310400005)(41300700001)(6666004)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 14:01:41.7855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80b34ae-9663-4976-28af-08da716add4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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
kmalloc() for allocating the Page State Change structure to using a
per-CPU structure. This is needed to avoid a possible recursive call into
set_pages_state() if the allocation requires (more) memory to be accepted,
which would result in a hang.

Protect the use of the per-CPU structure by disabling interrupts during
memory acceptance. Since the set_pages_state() path is the only path into
vmgexit_psc(), rename vmgexit_psc() to __vmgexit_psc() and remove the
calls to disable interrupts which are now performed by set_pages_state().

Even with interrupts disabled, an NMI can be raised while performing
memory acceptance. The NMI could then cause further memory acceptance to
performed. To prevent corruption to the per-CPU structure, use the PSC
MSR protocol in this situation.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 60 ++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c05f0124c410..1f7f6205c4f6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -104,6 +104,15 @@ struct sev_es_runtime_data {
 	 * is currently unsupported in SEV-ES guests.
 	 */
 	unsigned long dr7;
+
+	/*
+	 * Page State Change structure for use when accepting memory or when
+	 * changing page state. Interrupts are disabled when using the structure
+	 * but an NMI could still be raised, so use a flag to indicate when the
+	 * structure is in use and use the MSR protocol in these cases.
+	 */
+	struct snp_psc_desc psc_desc;
+	bool psc_active;
 };
 
 struct ghcb_state {
@@ -660,7 +669,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -742,26 +751,17 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
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
@@ -820,9 +820,6 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 out:
 	__sev_put_ghcb(&state);
 
-out_unlock:
-	local_irq_restore(flags);
-
 	return ret;
 }
 
@@ -861,18 +858,32 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		i++;
 	}
 
-	if (vmgexit_psc(data))
+	if (__vmgexit_psc(data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 }
 
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
+	struct sev_es_runtime_data *data;
 	struct snp_psc_desc *desc;
+	unsigned long flags;
 
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	/* Disable interrupts since a per-CPU PSC and per-CPU GHCB are used. */
+	local_irq_save(flags);
+
+	data = this_cpu_read(runtime_data);
+	if (!data || data->psc_active) {
+		/* No per-CPU PSC or it is active, use the MSR protocol. */
+		early_set_pages_state(__pa(vaddr), npages, op);
+		goto out;
+	}
+
+	/* Mark the PSC in use. */
+	data->psc_active = true;
+	barrier();
+
+	desc = &data->psc_desc;
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
@@ -887,7 +898,12 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 		vaddr = next_vaddr;
 	}
 
-	kfree(desc);
+	/* Mark the PSC no longer in use. */
+	barrier();
+	data->psc_active = false;
+
+out:
+	local_irq_restore(flags);
 }
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned int npages)
@@ -1339,6 +1355,8 @@ static void __init alloc_runtime_data(int cpu)
 		panic("Can't allocate SEV-ES runtime data");
 
 	per_cpu(runtime_data, cpu) = data;
+
+	data->psc_active = false;
 }
 
 static void __init init_ghcb(int cpu)
-- 
2.36.1

