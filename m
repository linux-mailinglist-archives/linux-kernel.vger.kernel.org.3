Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAF5A1382
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbiHYOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbiHYOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE35B69D9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVwWhvjGw5hmGEPxX4MqEXKg1iOPMLAVLgrhx6JbrDWFD9Q1N3exy8Rcd4synIVSjFTnC2fgWDIpqf9VW3T3G6zsqtlo+9secIV0DXpcoEGr0eCcXP/FJoe0saz20akCVhWsWbdRxis5QaCmf6r6MmScQqtFMJD5YQebxDx/PuCHiiwHA8q0jS6a3CJgOr1UnsKyyXegMhgVCgglk1TUmE3/lMs1TxVGpHZ33guMSPFMNEqlBKsAFWFevJVhqW2UMR7RMn/45Kxz60wU6TOvEJpOhu3VyXmfo3gg9/J59+RhXW5PfJl1sBjSBXYU9yh8a/yhSXl8igP6Vjpa+OamAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51+trjUh26fqqYT4GkpAWOWZZCUB3xEytjk3EhJ3jR0=;
 b=JPreNq3UBTfkL0f+9xE/9B9V74z1RfDAmjtpzwhCNdhAcIWpr1HwyNK0YPIUmrgyjuDxBR/oECwhPPP7PKNDT8DJ3s7+e1ly+u09niqciXG7NF3H5cLPBVQBIKIV3+cROBjlI3TEs0/39KNGk6gabI18yUpRbqHSv+UtuyGObW+wc0Y81XB5hN9kAy49S6XNEiaEKgzDR0MKDPiEMnynLO6HH8BJ2HKRAjqTO/M2B4DwYemhdqyI67my01I5dyS3v5VKsRzHEXrTmD5yP4fOng1tpMPE3rWqmAuXQcxkJVUhOha/vZkDCaqDrM3PI073PhZdjCAPtzVhbh5xziJX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51+trjUh26fqqYT4GkpAWOWZZCUB3xEytjk3EhJ3jR0=;
 b=TBEPQsUAlm+Y75IhxvhMtJ7lzMppGuktfpZHYcFp+Z0y4xWTxNI7W91pyVWARaNCXS68PppO+WkOIGr19gJHMGE7KQRSFpQGiIyz7SVBt10dzP3hq8vxbkdEcDxz3Vg1vf1xp0NTjz3v8xrzEkjxbf/dghaAF1P/0QxGpnhsNkg=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by DM5PR12MB1609.namprd12.prod.outlook.com (2603:10b6:4:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 14:23:44 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::43) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 14:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Thu, 25 Aug 2022 14:23:43 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 09:23:42 -0500
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
Subject: [PATCH v4 2/4] x86/sev: Allow for use of the early boot GHCB for PSC requests
Date:   Thu, 25 Aug 2022 09:23:15 -0500
Message-ID: <afa9130ca68425bfd83e52393c065cd836510766.1661437397.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e524d94f-72c9-429f-471e-08da86a56a71
X-MS-TrafficTypeDiagnostic: DM5PR12MB1609:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0pqgIkIhe/wFqcYMKzx8UawKTkXpwNkW6Q6G84T/aANdDnPjTopVd+IKSICS/6y6LLglyl6exsusEXuA3UYGBSU1CtkZP0/9rSygg+4aXVUZGx2GT0S7RLMQEPujgGdAvTTwRXFtlnOVLoRayoILZJQDJ0AZTD+3UaT9fX7fPh32RXiXFt0XTra/d9yqjDn19yHwkHFPEHU/Cg7zzVhz6/dmB3K8eb92D5bymcKMxttvhLIPmmmdmQGA/pYIO6fdCSsjlGlKt4N8W1aB0SuSHF5zzdS9olJYVE4AhFi8mUqqsWeZec+or13gdaHkPTzGbAkQcPynQ+D4ebwqq9L2hIymYM4bbJWDk9MuRLjYmEkDx/DliVP8w7Z/Pk0TxPFkvEsnllO5OcMQ5GO4/+2cQz2h44JhLAZAygSKsga3dDcNX7LpEHi5wOut2zMg1SuNXLKFeftIYcuX+kKb2+Ynt47jlLrpMlos4vAup2Bg6kJBlOi1q8CUIt030y0KDE4jSuoJw4nrIfbVuLO1dME7REKI/l2uZIqbddT9jo4c2oVMd8MhNGppktgIoxxAWpM9eUIsRqUXQ3PmyYLoQgnu7WklRHCmbsQweqlNLtNVSrtKAvqC+9SK/cVvli0b5OUJdDVSunrJIM/H7Na5chgvf/prT1neMtjY+UCXaC95LUaHOqdOjGdkbb17bxu2JdPMjH+g15Mvf0QSOPkM1+jGrcsn7+TVnIaN7iIJhhQ3dcfgvKp242dZ99toJt5lNGqDbaphBjaKAeNV8lmQq0l19ZwCe0hDGbYXBbvhaNqsl1u6Uy22SvFXI2wxB0QluZ1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(83380400001)(5660300002)(336012)(16526019)(2616005)(41300700001)(478600001)(7416002)(70586007)(4326008)(8936002)(47076005)(40460700003)(426003)(82740400003)(8676002)(70206006)(186003)(82310400005)(40480700001)(36860700001)(110136005)(86362001)(6666004)(81166007)(7696005)(54906003)(2906002)(356005)(26005)(316002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:23:43.8161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e524d94f-72c9-429f-471e-08da86a56a71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a GHCB for a page stage change (as opposed to the MSR protocol)
allows for multiple pages to be processed in a single request. In prep
for early PSC requests in support of unaccepted memory, update the
invocation of vmgexit_psc() to be able to use the early boot GHCB and not
just the per-CPU GHCB structure.

In order to use the proper GHCB (early boot vs per-CPU), set a flag that
indicates when the per-CPU GHCBs are available and registered. For APs,
the per-CPU GHCBs are created before they are started and registered upon
startup, so this flag can be used globally for the BSP and APs instead of
creating a per-CPU flag. This will allow for a significant reduction in
the number of MSR protocol page state change requests when accepting
memory.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 61 +++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index d18a580dd048..a5f02b6b099b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -117,7 +117,19 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
 struct sev_config {
 	__u64 debug		: 1,
-	      __reserved	: 63;
+
+	      /*
+	       * A flag used by __set_pages_state() that indicates when the
+	       * per-CPU GHCB has been created and registered and thus can be
+	       * used by the BSP instead of the early boot GHCB.
+	       *
+	       * For APs, the per-CPU GHCB is created before they are started
+	       * and registered upon startup, so this flag can be used globally
+	       * for the BSP and APs.
+	       */
+	      ghcbs_initialized	: 1,
+
+	      __reserved	: 62;
 };
 
 static struct sev_config sev_cfg __read_mostly;
@@ -660,7 +672,7 @@ static void pvalidate_pages(unsigned long vaddr, unsigned int npages, bool valid
 	}
 }
 
-static void __init early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
+static void early_set_pages_state(unsigned long paddr, unsigned int npages, enum psc_op op)
 {
 	unsigned long paddr_end;
 	u64 val;
@@ -742,26 +754,13 @@ void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op
 		WARN(1, "invalid memory op %d\n", op);
 }
 
-static int vmgexit_psc(struct snp_psc_desc *desc)
+static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 {
 	int cur_entry, end_entry, ret = 0;
 	struct snp_psc_desc *data;
-	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
-	unsigned long flags;
-	struct ghcb *ghcb;
 
-	/*
-	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
-	 * a per-CPU GHCB.
-	 */
-	local_irq_save(flags);
-
-	ghcb = __sev_get_ghcb(&state);
-	if (!ghcb) {
-		ret = 1;
-		goto out_unlock;
-	}
+	vc_ghcb_invalidate(ghcb);
 
 	/* Copy the input desc into GHCB shared buffer */
 	data = (struct snp_psc_desc *)ghcb->shared_buffer;
@@ -818,20 +817,18 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 	}
 
 out:
-	__sev_put_ghcb(&state);
-
-out_unlock:
-	local_irq_restore(flags);
-
 	return ret;
 }
 
 static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 			      unsigned long vaddr_end, int op)
 {
+	struct ghcb_state state;
 	struct psc_hdr *hdr;
 	struct psc_entry *e;
+	unsigned long flags;
 	unsigned long pfn;
+	struct ghcb *ghcb;
 	int i;
 
 	hdr = &data->hdr;
@@ -861,8 +858,20 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 		i++;
 	}
 
-	if (vmgexit_psc(data))
+	local_irq_save(flags);
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else
+		ghcb = boot_ghcb;
+
+	if (!ghcb || vmgexit_psc(ghcb, data))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
 }
 
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
@@ -870,6 +879,10 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 	unsigned long vaddr_end, next_vaddr;
 	struct snp_psc_desc desc;
 
+	/* Use the MSR protocol when a GHCB is not available. */
+	if (!boot_ghcb)
+		return early_set_pages_state(__pa(vaddr), npages, op);
+
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
 
@@ -1248,6 +1261,8 @@ void setup_ghcb(void)
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 			snp_register_per_cpu_ghcb();
 
+		sev_cfg.ghcbs_initialized = true;
+
 		return;
 	}
 
-- 
2.37.2

