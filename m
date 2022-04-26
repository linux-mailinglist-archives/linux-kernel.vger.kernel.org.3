Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F9510056
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbiDZO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbiDZO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:26:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5271B787
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv72MTeE4qMDvePdmQf51K/uYAyXuw7zkla27blBsl+aYy47aqhv8sEasSpCTVFUNilzA5YLP8zHjb4WnFVDaUuwffQNRNGAWja86aA5UOkGwIhLBADjv5GKzB/5k+4+21V4T2J0Hzl4Es+06eES7ujz6LAF9JRQlUSQor3Jif11gemPwJy/wR5YBUdHQnBiCYv0RFV3hpa4JyVIdBDj/mRqg6smCyuemwT2hz6PDePzfXQmhqawj22Nov+A9h9E9/aOuV2+ojIuWFGfhXp6jcnrUSU52qXZ28vAgMbaSr5B5fFWeV6/zfsgOD3uJI0g1KBa96BXRmgVOL5miz4KAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5aDtbaDUQ3YyDK518ENIZFH0EnUQNB0gIyim/QAVcU=;
 b=dzM40GcKSnf9mborznCoXb2Zvbn9wt1oHHJQ+Z/bib/8QSZhFLenR3uhKYvqAXEr8U8XXblsmRV/4l4ELQfuhWZ8dU+gGBy3i5UtNA4v5PdSMCASY1vFFCWIT4Xl5KNvMmIBX70sFs1XWKw4Ljn9uv5vtui24B58Q/l4R75weCdQmo100UmPrhE7aZ7vcYg654HLC0j7ikiZzS0u3yuJxZox4IMZt7Dn5aTVKWB06ffPAh4G7HWZCJNQKsc2oqgJabDNN44lUP2UtTL0fKKqwZGDu6kqTsU40p+toqVUSRGJwUwkmo67S52n4eHa+rXyqsRRaSZTy1ZBPVS6JjL1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5aDtbaDUQ3YyDK518ENIZFH0EnUQNB0gIyim/QAVcU=;
 b=byiF5DswdJOazV2A/MTSK9LklRu7zDwSpt7o2PdC2FAbq6Ff2EAsjwukEQz3LevA9nI8gFtWuz6DWnXB2Hh2E/PJU5D6sAJ2X4RhgYvUvoFbqu44vN+tKXfQmMkjGsOPGen4mX1B2uf+DsYVILb5cQF5MFozWTX2BUFPy9y8PD4=
Received: from MW2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:907::46) by
 BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 14:23:05 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::61) by MW2PR16CA0033.outlook.office365.com
 (2603:10b6:907::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Tue, 26 Apr 2022 14:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 14:23:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 09:23:03 -0500
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
Subject: [PATCH v4 2/2] x86/sev: Get the AP jump table address from secrets page
Date:   Tue, 26 Apr 2022 09:21:47 -0500
Message-ID: <20220426142147.338412-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426142147.338412-1-michael.roth@amd.com>
References: <20220426142147.338412-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3f8c3b-7718-4680-0adb-08da27904757
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB519553432A42EEC02EEC04A195FB9@BN9PR12MB5195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQjGky3x+MNcNxaqhRhnQveL826RBOv6TPg4EX+zDfaGch1uQBVJL+Sj2AkNus6VKPV3onMe2AdI2cbbgHqcJV7RuCXobg6Y689682HfxzasG6EQPe7w4cSPoLQdoEDLAKU0ZluF6jAYwqQOgrSO700hGGWnqS6MI88jg7XtgxwrK/psGLP/toSiixPFjeZJzCAkq4vpO47Mv3SnjG8l0nsuzgSu0IPwUPG2YlSp4S1qvO5SNsUIfYK/YR/nmnQUMJmXKjac1oVB3+hC/TJEIQvEFTeXUZxtnMjAH6TB31c7S3Zx0ix7OcOZZdz+h2YGrj/SwCGJDwwOgqXUY25yId/fxTmh26KbZ257zqVm3sA83+RCjyfECJvtFO8rrokbHiFKObRjmdA5esSjUKjfqfjO/QnRcE3EZIst2miWrIrfQ4+qb9OYzhK94QMcg96VroVmQmffwVakAPAKdRvtpE+xaWrhfxhTXoye2b9rycV32FNbUWbCuNitm8M1OG719RWFapUcJ+LrrjhAfAH7jQhim+YuEFpfO7TGpYMj0oQYN0NSoYmPJfw+iim5pHUIyXTpBS/wxbkjZl6OitHMWF3J5Dh44z7reoimEAHX3YAJSRCSTCJptUAnGsJgdT2iyvmhdCx+pT/wsPuBAxEMWrxrTGuQLNWf4YeUU3/Xm/Gb3XcZsTAvc36FJAj1AwpzY0mqyutNawh6rkfdvlNbwfsMbJM4qA2kWxVaOo8PvOg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(336012)(426003)(16526019)(82310400005)(186003)(356005)(81166007)(8676002)(4326008)(36756003)(36860700001)(40460700003)(26005)(7416002)(54906003)(316002)(8936002)(6666004)(2616005)(70206006)(5660300002)(70586007)(508600001)(1076003)(86362001)(2906002)(44832011)(6916009)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:23:04.9976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3f8c3b-7718-4680-0adb-08da27904757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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
a guest should not rely on the hypervisor to provide the address of the
AP jump table. Instead, if a guest BIOS wants provide an AP jump table,
it should record the address in the SNP secrets page so the guest
operating system can obtain it directly from there.

Fix this on the guest kernel side by having SNP guests use the AP jump
table address published in the secrets page rather than issuing a GHCB
request to get it.

Fixes: 0afb6b660a6b ("x86/sev: Use SEV-SNP AP creation to start secondary CPUs")
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
[ mroth: improve error handling when ioremap()/memremap() return NULL ]
[ mroth: don't mix function calls with declarations ]
[ mroth: add missing __init ]
[ mroth: tweak commit message ]
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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

