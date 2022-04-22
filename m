Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109AC50B950
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448263AbiDVOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448260AbiDVOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:00:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B996C5A091
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGdHU8thuiPPHGvOxsi+05y1WtPsKdmzhD1sPlpAqsuwfgCdIUYJxuugG8MRkHn2yp/oufbZGhnLChNCen7FmY8GxGnpeXcj6BXDc9+KfNvtblLnt6iKZBsCdw4fHtWtwlMVyHgiqI6dmSzip7looXAF9XjFvvj7et2OltpIizEqmj42kwInAkv1D+IiJ2GlCUc7Bgon8qkvoadsIc4cz7esQd9cPW8ZYjcjUhGdPJkohdwtXQbeb63jT1BqA6vtPuYUd0hRTZ6sSGlxxSI7KwFM8wc+5mkSIvpvT/I7jSXoYDbMp2l0AziS+//7c/UDUTIGR/mbnMJGJzmDuemm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydcJf4WaUjoucqhxVp6oCuP4pT7lfq1bTMSlUyejUSc=;
 b=dWfRwcVq/fkYEF5Fswe0n1McNerWRywtqGSbvUnTUjiVcsSbHo0q5PJnbVEN5M5JvkPC0jdxnUXmdvOGJfwthz6swZJpF0UxJR+4HZEI7rAuLs5mYGwePtNz+h5cJtJsgfP4stjuv5Wyb0z8aVMTXrnW5Jn39pfXTxwgB/acQ11S8zlszdkXLJJISYZqcKo8eAM/YAtDNyowQxuj48oWy39z5oBQF6JTXkQWN51EYJD3et1aneyR2eAwGHNYSgsOVXFWt2bUbLydmGpD9M8d7i+8gU3Jh1s6DJPOlMQijxmkWq/j72PGIXOT+JnnN8tKHDTAndza/yMJntuHTlP1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydcJf4WaUjoucqhxVp6oCuP4pT7lfq1bTMSlUyejUSc=;
 b=IdBivRv8p/k4IVEqWEJOrJAbXIBpRudcCwwBcIiZ6DS6LEamSqVT5EivRLNZ4mtquVRCGjPtVUTH6an9q6MC2DpGe2g4OC2ZxmCgmVdzoRpC9EF2yf7QEeJdLvBVdxxjGlE4tZAVCT+4oZ6oifAU/w9l0KdJZSUZwqUq2IZTRbk=
Received: from DM6PR06CA0092.namprd06.prod.outlook.com (2603:10b6:5:336::25)
 by DM6PR12MB3850.namprd12.prod.outlook.com (2603:10b6:5:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 13:57:30 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::84) by DM6PR06CA0092.outlook.office365.com
 (2603:10b6:5:336::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 13:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 13:57:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 08:57:29 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        "Joerg Roedel" <jroedel@suse.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>
Subject: [PATCH v3 2/2] x86/sev: Get the AP jump table address from secrets page
Date:   Fri, 22 Apr 2022 08:56:24 -0500
Message-ID: <20220422135624.114172-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422135624.114172-1-michael.roth@amd.com>
References: <20220422135624.114172-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 637c9e5b-bcbd-4fea-942e-08da24680ab6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3850:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3850B39AD733FDFE4A34E8B095F79@DM6PR12MB3850.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpY23ufUlXD+fuz6y9lJQbMvYDVcR9K6KSg6z+PUQjcxDInuS3jaxdsI9OKJN9/EFnvjJlHgnlQQ8I5CS7HTaP0G80eGz+7PoGB1sbIryio64vWwMm6A6MlKnIiVhvp8yhukkhZMLBMTBvIJ1IDNdTCP/hoBc5yrJc6jXIc+dBBrNBUeX/735FFp80Rd7CA2WVBrWI77d235wkNIArm3ObgOxQi3aVXmKvwOSSjN5S5wlzCVJz+nj1ME+f6MtRsyKgJ/0iuGRls64nC7/eZg5WfhzHZa0ZK1Ei/DqIc1kmfZlzqR+1Re7PSI8rTCr8l5PosXAvRI3DNYLCPbcc79Y6UVrEatRCNi/HcuOuoikIZ3Wk1EIJF58biD8AbKQNb0vcW5g+CmNtoON9WxKbzKK1XvnYMcyQtNIopO87wT32Bp01NTPPoK7FZ/7hpCOj5vFUbOGebyGYEHUnSoahOLZhkdz/G4sdYDuC91bvtyhUmrecNeJHQ2FX0gsQFArrOTvGLmNg8bKEVOpPt16mIm4BHE9GzdvaUpfdcrgCywNgZyeDRHAbUN8VHHmAXw5fLCNIuqfQsHxvC/c/Uv6/PfWSLhJhgnXdQC/O8UE4ZWJIqfOFfVxpCqJe4Y+lRItvedoPRE7k4pRHTIAS2OjixBrEC7pqrRlful1+ICB0XHCBdHowsWqBT5nm24kDUo4nLxWAPWg8UzIVtwT9O2ONHZVE7vP2e88wwdvN44DDxvno0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(1076003)(2616005)(426003)(336012)(2906002)(186003)(47076005)(16526019)(316002)(54906003)(44832011)(7416002)(36860700001)(356005)(6916009)(8936002)(83380400001)(40460700003)(86362001)(82310400005)(26005)(6666004)(8676002)(508600001)(5660300002)(4326008)(36756003)(70206006)(70586007)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 13:57:30.0345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637c9e5b-bcbd-4fea-942e-08da24680ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brijesh Singh <brijesh.singh@amd.com>

The GHCB specification section 2.7 states that when SEV-SNP is enabled,
a hypervisor must provide the AP jump table physical address through
the SNP secrets pages.

Fixes: 0afb6b660a6b ("x86/sev: Use SEV-SNP AP creation to start secondary CPUs")
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
[ mroth: improve error handling when ioremap()/memremap() return NULL ]
[ mroth: don't mix function calls with declarations ]
[ mroth: add missing __init ]
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/include/asm/sev.h              | 35 ++++++++++++
 arch/x86/kernel/sev.c                   | 76 +++++++++++++++++--------
 drivers/virt/coco/sev-guest/sev-guest.h | 35 ------------
 3 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 6e3dda4f82b5..19514524f0f8 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -99,6 +99,41 @@ struct sev_guest_platform_data {
 	u64 secrets_gpa;
 };
 
+/*
+ * The secrets page contains 96-bytes of reserved field that can be used by
+ * the guest OS. The guest OS uses the area to save the message sequence
+ * number for each VMPCK.
+ *
+ * See the GHCB spec section Secret page layout for the format for this area.
+ */
+struct secrets_os_area {
+	u32 msg_seqno_0;
+	u32 msg_seqno_1;
+	u32 msg_seqno_2;
+	u32 msg_seqno_3;
+	u64 ap_jump_table_pa;
+	u8 rsvd[40];
+	u8 guest_usage[32];
+} __packed;
+
+#define VMPCK_KEY_LEN		32
+
+/* See the SNP spec version 0.9 for secrets page format */
+struct snp_secrets_page_layout {
+	u32 version;
+	u32 imien	: 1,
+	    rsvd1	: 31;
+	u32 fms;
+	u32 rsvd2;
+	u8 gosvw[16];
+	u8 vmpck0[VMPCK_KEY_LEN];
+	u8 vmpck1[VMPCK_KEY_LEN];
+	u8 vmpck2[VMPCK_KEY_LEN];
+	u8 vmpck3[VMPCK_KEY_LEN];
+	struct secrets_os_area os_area;
+	u8 rsvd3[3840];
+} __packed;
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b7fd1915560d..166375084b1f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -558,6 +558,55 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
+static u64 __init get_secrets_page(void)
+{
+	u64 pa_data = boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map = early_memremap(pa_data, sizeof(info));
+	if (!map) {
+		pr_err("Unable to locate SNP secrets page: failed to map the Confidential Computing blob.\n");
+		return 0;
+	}
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* smoke-test the secrets page passed */
+	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
+		return 0;
+
+	return info.secrets_phys;
+}
+
+static u64 __init get_snp_jump_table_addr(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 pa, addr;
+
+	pa = get_secrets_page();
+	if (!pa)
+		return 0;
+
+	layout = (__force void *)ioremap_encrypted(pa, PAGE_SIZE);
+	if (!layout) {
+		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
+		return 0;
+	}
+
+	addr = layout->os_area.ap_jump_table_pa;
+	iounmap(layout);
+
+	return addr;
+}
+
 static u64 __init get_jump_table_addr(void)
 {
 	struct ghcb_state state;
@@ -565,6 +614,9 @@ static u64 __init get_jump_table_addr(void)
 	struct ghcb *ghcb;
 	u64 ret = 0;
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return get_snp_jump_table_addr();
+
 	local_irq_save(flags);
 
 	ghcb = __sev_get_ghcb(&state);
@@ -2171,30 +2223,6 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
-static u64 __init get_secrets_page(void)
-{
-	u64 pa_data = boot_params.cc_blob_address;
-	struct cc_blob_sev_info info;
-	void *map;
-
-	/*
-	 * The CC blob contains the address of the secrets page, check if the
-	 * blob is present.
-	 */
-	if (!pa_data)
-		return 0;
-
-	map = early_memremap(pa_data, sizeof(info));
-	memcpy(&info, map, sizeof(info));
-	early_memunmap(map, sizeof(info));
-
-	/* smoke-test the secrets page passed */
-	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
-		return 0;
-
-	return info.secrets_phys;
-}
-
 static int __init snp_init_platform_device(void)
 {
 	struct sev_guest_platform_data data;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
index d39bdd013765..21bda26fdb95 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.h
+++ b/drivers/virt/coco/sev-guest/sev-guest.h
@@ -60,39 +60,4 @@ struct snp_guest_msg {
 	u8 payload[4000];
 } __packed;
 
-/*
- * The secrets page contains 96-bytes of reserved field that can be used by
- * the guest OS. The guest OS uses the area to save the message sequence
- * number for each VMPCK.
- *
- * See the GHCB spec section Secret page layout for the format for this area.
- */
-struct secrets_os_area {
-	u32 msg_seqno_0;
-	u32 msg_seqno_1;
-	u32 msg_seqno_2;
-	u32 msg_seqno_3;
-	u64 ap_jump_table_pa;
-	u8 rsvd[40];
-	u8 guest_usage[32];
-} __packed;
-
-#define VMPCK_KEY_LEN		32
-
-/* See the SNP spec version 0.9 for secrets page format */
-struct snp_secrets_page_layout {
-	u32 version;
-	u32 imien	: 1,
-	    rsvd1	: 31;
-	u32 fms;
-	u32 rsvd2;
-	u8 gosvw[16];
-	u8 vmpck0[VMPCK_KEY_LEN];
-	u8 vmpck1[VMPCK_KEY_LEN];
-	u8 vmpck2[VMPCK_KEY_LEN];
-	u8 vmpck3[VMPCK_KEY_LEN];
-	struct secrets_os_area os_area;
-	u8 rsvd3[3840];
-} __packed;
-
 #endif /* __VIRT_SEVGUEST_H__ */
-- 
2.25.1

