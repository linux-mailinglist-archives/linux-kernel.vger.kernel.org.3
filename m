Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D1508C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380269AbiDTPgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346215AbiDTPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:36:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F80B3EBB4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5gE5kun4zVCoYvdyxseFUDoB9sFYEHZBr8Npd8AWJkMOMaqP7NVZjVkbOSj4eZXXWZQ6Bi+7vqmOkVTvligGMXn3A6YESbfnqFr/jeLvpJBZdB1uT/zVXpRQSJ0B9v3t8EKKise5a9KiXUo4RJ5AxEWHLIzYxWZMnWtaP5Do+qg7kfau0WENsgaOvaYIqt399QaDOtB1MbFAs9gS6cYQyTdXRGrv9fjyepPMKehoszgcq40dsQqswPiqpwbOFPhQmcEDC1c/Rreq9f1gU/sxDPwKBGFA9hTSqf7wgIIL47inEMROoMq7MPLvcnY+nW+ScUcmj/SO/VlwKMELnHaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wIL+qRfGg7BqDNctAjokZGZAqIIHfOkut2KlYqJKK4=;
 b=GXjv797qNnYGpiCnW8C/zNCvxK5JVLUcqpA5a+EbJctDbvIGvTtGSnggOtduQ802j8NHUySQAO+79qs1RtoUMM1fOtqIE7Fn8EKq8R/qATXf4v+JHGwRgH30Bx0g3bc2xxZUlgymtrCTRpNDIF371P6VTwWLuE59tOGptTU/x1ud2EqxhyRDCWtafV9AVV6/pETxj11UrVYZWwVozcIgnphTVIt9fGOT4BeY2WgRWZsuMVMN7t/9k7LMFgrxpSKN+wfiVr67A4gVWq8SRtk1BRMxotc+Biyt44Xcg7Q1Lr1Yb9PTgRlZ1zNJ02K+iJwK9BHlUBlwtMMxPVpn+nPqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wIL+qRfGg7BqDNctAjokZGZAqIIHfOkut2KlYqJKK4=;
 b=G01EN5hQB/y3H+nNSHwLuRYtUzTAR9niRUx9Te4gZV8xyw2BZ01xhELY/DklYXnGOl5KngZVUoJFfXrNgRVV5FbGmUO6atTBxKe+xqcOvZ+k/fdMzW6aZQFRuhq14Tmu26E0tYqwoCi5Jh1uF2kWILktBBPyfP0XabCCg7S9xVQ=
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 MN2PR12MB3342.namprd12.prod.outlook.com (2603:10b6:208:c3::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Wed, 20 Apr 2022 15:33:51 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::e9) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 15:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 15:33:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 10:33:47 -0500
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
Subject: [PATCH] x86/sev: get the AP jump table address from secrets page
Date:   Wed, 20 Apr 2022 10:27:51 -0500
Message-ID: <20220420152751.145180-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5b0b6c1-084d-4a0b-2ec5-08da22e32bb3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3342:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB334218259CFF8302851C70CB95F59@MN2PR12MB3342.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ceoei1lgT/mv6GO0be2PBjF38W7uVe/a/ZixkFihFrwDviGl7437ovpRC5sucVPUh18wCAINgw4ftMTmOweilIimQvCu8z/7jaS6q819dHXYf/kKl0bJ1n6MrnZJx7SAQQv8+pr10Web7IplhfFcaSR1hhoeLosbOTXPYusttzUBPLmY4+GxBQOH0kCwqBfSJmptYIm8ep/9ncym012e3TKSMFnJ4SBVXA+6t9iLMbl9LoR8KMWLecu5TyC8FLr9l9pl7rHgtw78HEvVHahYR5sAVsdrlzUZLU8BAa0+s/3i4hvFPnUFvZ8Wr/sqCTPnRBpg8NZ/rjgC+vb16mCcOkzsRSdu08dlSjtPXRLU2d+/N8nfKSYxm0PDTRcxvpr6k/RX+6sHAbSLI4EDidglaYwzLWiUxeCe/5lkn45lnBLrBmlPCt3ZLcOfaI+0+VJ3FSY5iwogtCD5cONUEibzc3NMkALTLJ9PDUW97/d1e8X4mfgWIHxYVKfu77Mmb8Ywrppr96FyOhAWmjchLdB9RDZuHabps9zhx3i9esxiKeCEpm2IJsX08GEOkBak3A3jqazfv6DaI2u1n4Uz/cgJaf7FrarVELGIxcFn314Sb+AIjc1dc3fbf0YJ39B0a3InkBXjGCSoc8wwpZnglJkUJFx5tI6GRHTk9uFKb8+81ZPd4ZJrQHjx3iWcnUzryRsBccLv7ulvFZuRR76mUImCWdXEeleBoCMSwyiGUS1tr9Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(82310400005)(6916009)(54906003)(2906002)(1076003)(186003)(16526019)(2616005)(47076005)(6666004)(426003)(336012)(4326008)(36756003)(316002)(40460700003)(8676002)(508600001)(86362001)(5660300002)(356005)(70206006)(70586007)(44832011)(83380400001)(36860700001)(26005)(7416002)(8936002)(15583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 15:33:51.1492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b0b6c1-084d-4a0b-2ec5-08da22e32bb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
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
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/include/asm/sev.h            | 35 ++++++++++++++
 arch/x86/kernel/sev.c                 | 70 ++++++++++++++++++---------
 drivers/virt/coco/sevguest/sevguest.h | 35 --------------
 3 files changed, 81 insertions(+), 59 deletions(-)

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
index f01f4550e2c6..9cb27490745c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -558,6 +558,49 @@ void noinstr __sev_es_nmi_complete(void)
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
+	u64 pa = get_secrets_page();
+	u64 addr;
+
+	if (!pa)
+		return 0;
+
+	layout = (__force void *)ioremap_encrypted(pa, PAGE_SIZE);
+	if (!layout)
+		return 0;
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
@@ -565,6 +608,9 @@ static u64 get_jump_table_addr(void)
 	struct ghcb *ghcb;
 	u64 ret = 0;
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return get_snp_jump_table_addr();
+
 	local_irq_save(flags);
 
 	ghcb = __sev_get_ghcb(&state);
@@ -2171,30 +2217,6 @@ static struct platform_device guest_req_device = {
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

