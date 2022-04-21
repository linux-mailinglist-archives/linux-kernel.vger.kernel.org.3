Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C985094FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 04:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383847AbiDUCS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383796AbiDUCSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:18:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15226251
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2rKnaEXDotXRtDYpOzOwytpnXTkVdHT05tQayvJk8NsH717n4MZ8Bd+S95Gi6YaYkNLzXTvZ+F5wpK7OYs7r6bDPUkgbS99JuuX3+9GdkvFzi3CKQ7GGLxKg3URw9+N/8UusFw2CBocVF48t8/Bf14emGGwMm4tHLRz5dXlTxbSRaFBTQ/SU6K9NLEFKvLOzGbuzcc/xF3v48BkxprKtTNAqDNJo+mAoQ2wmjzP1LMS7u1RzHnJGfrYgzgVP0nZxtnUYymPis6j6aGUzB/UnkzWmF3AAeqMb5Pj3hD8OlgM6o1e3H+z4T/+yrae2CIDI4AgjLnsvi4Re0G2oCTbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7aW1iZ/CGXZPE+PuIbPIatRqwFQJDOxgdquHlyrxqE=;
 b=DNgqJ5wqlNKj5fm3osXUU0V1ueLPNZX08HBwys5LgJ5om+yvP/BU8Bc3k6G5/7PVKCjwcpms79do9sNlnMUDJ7fffdYc8fbu1iguivxEDvASOSg7GqLV7D8y5q9e8rJTjInPWwMe5PLijzwfvxppQp7b2Eke6Fz1emUIq42sSkLppanNl4aQgQB6ZqQF76B8sRF5nhDtdFoc/vUfV5yE7oyBO+HjL9pQ/oNtxFfc4LUqpZBqiePez2He/YP6W0fessXukOmfdW6+nL/LzVPVWcIct6OtEGl8kIFB8jOExrtqZE9/lp/wvIuf3I9uSldtKhR/+wmQOAmbe1x3UejIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7aW1iZ/CGXZPE+PuIbPIatRqwFQJDOxgdquHlyrxqE=;
 b=0wCXusdwy4AA+0vzvPK4rAP/fhDQbXIcYbspkLIkKpVyCLrBiimUnc17eaRbMDEk7zyvr6RkzrFmu8hUfJoUhCTDcLLeDNtAVZKvsTswc0BNoXKQGeAJBz0uyNkt3aRgyZ/vFSLfZsba02co9zNgkD7dtG793P06xmHn5E4GzDw=
Received: from MW4PR03CA0103.namprd03.prod.outlook.com (2603:10b6:303:b7::18)
 by SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 02:15:11 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::b2) by MW4PR03CA0103.outlook.office365.com
 (2603:10b6:303:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 02:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 02:15:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 21:15:09 -0500
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
Subject: [PATCH v2] x86/sev: get the AP jump table address from secrets page
Date:   Wed, 20 Apr 2022 21:14:45 -0500
Message-ID: <20220421021445.24307-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6441cdff-a65e-45ba-5448-08da233cc3a3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2847A32CAEECA9801B868D5095F49@SN6PR12MB2847.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9QKaJxYCTohRG4Qile7R0tO/bREx3axYvhEDQWJYr8adzUmup0zpfPU1jqB2SUm7VXhL6LjyzhwITOxVAGesmL8KnzCH3nEa2WVfy4T0y85YBPbQ2aX7ARxlNsRr86R0bWk1NocNFsUzXF+eZRnaoFWVnwpEfihKtJnqpoSOKHh9ha/iAaTSp+UFCNkhkC0v6GYaiKZn1S6c+RG6jD4IgTOkbk3Btbo8o9sZDZgA9LnXrnkQKtnbf5W32oEJ/mwO14+l83vetW7gXHDRKe+x/5WXIQ9RYoRi/9AtlutrrHGxiqXBRoVlDZxp4Dd7L0aX1sKN2TDqhtRajCgDKDFEA/CMI45Y+C9hSnt+1Tp7Ly6gZgQNOCVhVT7TvaP1lEkH+hBZqfJKfAknrT5DNWL0gzAzCTueWaYkM6sojGYJaiUxXA8ObWFf4Pmz3/ZSc1BXrsVUS1Lbo3LYKiEvzjZhDlUoMksBt7WdvC7VWqcC7AnIkPf5zRP15sAeOApRIZdlLQJDU88EvELtdYT5uqmJYIoa9F+kNFl9NZWX2cxBnVFvAaH9FtWf1UWGyYCqSNyy1mg/H7gyLcvdqHzFUNQ7ge7z0tdIxiaF7l/lGirz0R1t6dduVTzf7JQYRno2r36Kk5tjNmNH1VSDo07+iNqCbufyzdKJPjuR4GRy2sdd+44A/uPWxqg1DLjVkbyU4EtSlmC2pY728cH5QoROkgnxBKLLGcgTWA0GGCDgvV8yqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(4326008)(316002)(6916009)(47076005)(82310400005)(8676002)(356005)(186003)(7416002)(5660300002)(81166007)(36860700001)(83380400001)(54906003)(70586007)(70206006)(508600001)(16526019)(44832011)(40460700003)(6666004)(26005)(8936002)(1076003)(336012)(426003)(2616005)(86362001)(2906002)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 02:15:11.1742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6441cdff-a65e-45ba-5448-08da233cc3a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
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
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
v2:
 - add handling for memremap()/ioremap() failures (Boris)
 - don't mix function calls with declarations (Boris)

 arch/x86/include/asm/sev.h            | 35 ++++++++++++
 arch/x86/kernel/sev.c                 | 76 ++++++++++++++++++---------
 drivers/virt/coco/sevguest/sevguest.h | 35 ------------
 3 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9c2d33f1cfee..509a23c85fe8 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -99,6 +99,41 @@ struct snp_guest_platform_data {
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
index f01f4550e2c6..29b832c3f27f 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -558,6 +558,55 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
+static u64 get_secrets_page(void)
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
+static u64 get_snp_jump_table_addr(void)
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
 static u64 get_jump_table_addr(void)
 {
 	struct ghcb_state state;
@@ -565,6 +614,9 @@ static u64 get_jump_table_addr(void)
 	struct ghcb *ghcb;
 	u64 ret = 0;
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return get_snp_jump_table_addr();
+
 	local_irq_save(flags);
 
 	ghcb = __sev_get_ghcb(&state);
@@ -2171,30 +2223,6 @@ static struct platform_device guest_req_device = {
 	.id		= -1,
 };
 
-static u64 get_secrets_page(void)
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
 	struct snp_guest_platform_data data;
diff --git a/drivers/virt/coco/sevguest/sevguest.h b/drivers/virt/coco/sevguest/sevguest.h
index d39bdd013765..21bda26fdb95 100644
--- a/drivers/virt/coco/sevguest/sevguest.h
+++ b/drivers/virt/coco/sevguest/sevguest.h
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

