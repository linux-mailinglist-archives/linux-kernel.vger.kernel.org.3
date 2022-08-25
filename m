Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DF5A1384
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbiHYOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiHYOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:23:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D944B69DF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc3kYvzOFewfLMqV56p+/mgZ9SrI7FKLg/EzH9qrK1osAlkPlkFbjVoF4NKgwTns1sekJCh9QRjS92uikBM6St+YG/yvow4seHIHYouM2WTmgpiSg8mOJRcc4sTcEkeFYOrZfhNgmeg4VO1538Xb4kPzUcrD50qtroGwHktJ6v22GiKiJmIPddgKi79M3CprCb4c0xQlOObFOTrl7WzqQSrVc9zFCy9q7KC283GdKxK9wUGS1SzHN+j/ASqEXGMH9rRLdeD9jN2+dXc/ykixRhCWMqtWdnRAo0QisouDxG3EnDsMTN8xMwTmXCo5rHYaQFV+rBd+qVhj52PIdGqrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGqmUAWXbV4R2yaqLurhwaF99dOfENzvIwNIjL9fUGo=;
 b=Nz1vIXIeZxiCCXbZQNQursp+br1hggq5BCjbokKY7YA93UM94XMrZXZqQIcH1yQtzuruvXgYDRplQxXsXbl6JbyQepvvzoILrnhumK6NhURf5cPTHkbHWURetat8Kn+w/Qx0kSx9U+7s30jydtYw2/dcoGmPHxe8zMgpvMq9mCv6DatrAOi6HXREb6S/rdlCjBkmt0PLRGfcc8w9YMiiQtetpXyJ4fRvwdvvVxSjSADQIlFQCo+7cGh5c2GsN8ExJPF1OGO2NpQU4j3ZLSeprsYRuc44N2MHQDNCcTSCu22HJ4OBHcgApIHCaMPBE7hkjCseRoGMTUP9RtPIdXaGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGqmUAWXbV4R2yaqLurhwaF99dOfENzvIwNIjL9fUGo=;
 b=tZeE0aKrZpjN7gQA4/SApkPL5d8C5B7/ww8fJ3b747mowq2mQfTu07u2gk2jDiXOgWysPbAI8gA/VTCD7n+dD8Bqqv2qQJ2RS1AxvIt/r+/4ko19REMFPo6mOT/IZE1Wt9KuP2rG8+/8NlS32qfkt/+1qTu0xWqn7DkSoaiZ32Q=
Received: from MW4PR04CA0093.namprd04.prod.outlook.com (2603:10b6:303:83::8)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 14:23:37 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::16) by MW4PR04CA0093.outlook.office365.com
 (2603:10b6:303:83::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 14:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Thu, 25 Aug 2022 14:23:36 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 09:23:34 -0500
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
Subject: [PATCH v4 1/4] x86/sev: Put PSC struct on the stack in prep for unaccepted memory support
Date:   Thu, 25 Aug 2022 09:23:14 -0500
Message-ID: <f960146482bbe69259b25741e0aad71463864929.1661437397.git.thomas.lendacky@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11a39e94-0338-45e0-b789-08da86a56605
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsz3YE08GL236muK1kZGZepu9aTGwvlN6jC3dbPyBcZBPqklhzPzmTYKCc5qvuE/pVaBW3AzceIwyL8cRyyz0GEZy98n23QGV6rKfSdMJOYnak3ZURzBKSOK3mu6RFNuDiVhAdmeSyiFiXe1SghP6asP7SyuNQColafqZsCoYm/1xAHzZAjPcVAR89X8UNq95szMAfyCl13Ajao6T8NSljtL16CG5VSdtfi4NYQigNsvieF0hnPOo4ZCHeJizKVTrY2a2SGxjBYHEYYLJSnY4Hrn1YuKvj5DJ6sHS8q0kGzAYd6G7Fh2LoUqJDNzSSefRMAzMJEXJnPhEMjXf/HNKB53m3c5X/zxzyR0kGyzOmIM6ZmV9Pc1411mDTlBKvoIHk9NsKmu090iA1zMgqta1qLPvWLdP5y063ZiDNM6BydzvTxuLdfmUXuuNVmPfaLXn9ugNtiO5LzJ+J81PvbHaJ+f7oi/HLn9i8pyMfvh49SVSD8xpP7eSRwnxSdFPY/NmoYuY/Yul7Pe9FoHzj6trADhuiMZt/oxrEKMb7gXSKEABnz2mhBagvAMXjrqHfkvMIIVR/NbIADp6hvSmkNWqQcUn5vyPBvK23E3CWII05d3xdmZ94hgk8DQoMz2tlHn9bKFkin2/cHXKjhKCfwElaAjFYkrcY7CxlhjFVA22MkWfUbn+eqCEYOsQOUWiWSxG6i82weaeAIJ4l7f+ylq07v3791UTxoisR1c0ouVSlDOhuRZJbM21pWeZ8LtiFIi7288dcePuAACGdEtDUx/3h4mQRHJTtk0Nwb1dvzEfGlYXXAOZb3MUgOaQFuTAh9I
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(40470700004)(8676002)(82310400005)(83380400001)(16526019)(336012)(47076005)(2616005)(36756003)(186003)(41300700001)(2906002)(26005)(478600001)(36860700001)(6666004)(426003)(40480700001)(40460700003)(7696005)(81166007)(7416002)(5660300002)(70206006)(82740400003)(54906003)(8936002)(110136005)(316002)(4326008)(356005)(70586007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 14:23:36.3848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a39e94-0338-45e0-b789-08da86a56605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

If the reduction in PSC entries results in any kind of performance issue
(that is not seen at the moment), use of a larger static PSC struct, with
fallback to the smaller stack version, can be investigated.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev-common.h |  9 +++++++--
 arch/x86/kernel/sev.c             | 10 ++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

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
index c05f0124c410..d18a580dd048 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -868,11 +868,7 @@ static void __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 {
 	unsigned long vaddr_end, next_vaddr;
-	struct snp_psc_desc *desc;
-
-	desc = kmalloc(sizeof(*desc), GFP_KERNEL_ACCOUNT);
-	if (!desc)
-		panic("SNP: failed to allocate memory for PSC descriptor\n");
+	struct snp_psc_desc desc;
 
 	vaddr = vaddr & PAGE_MASK;
 	vaddr_end = vaddr + (npages << PAGE_SHIFT);
@@ -882,12 +878,10 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
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
-- 
2.37.2

