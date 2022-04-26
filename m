Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8C510050
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbiDZOZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbiDZOZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:25:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAB415714
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/ZHOIHHZ2zZe+pDrfSiniqRS9cnSBrv82zyuUHIyV1nLJ8LGrevVpK9vXvt3BN6HrB1drwP7K+1GKy8Y7qyutR2lh1M2rBC3rRAKQBpNpzciUgEhYQqibzuIkwetbPg8HAo9OrVwt4qu1GrLfOSndlK5MLr14hrGEuklCjm8ASMKHxkti+YhHYJQfhyWy9CZlGvplmDJ36Q2yl1NhtqhzNwoS6lRelwp4EYt82+cMQrzIvszIXSGrds0AdbJ50A1Z/diE1+7uZdgmX5rTWjP7EpxfcqPwfsej/sQZNIl6xEFmhI5lylwLTPMSPLsGTBNNB8W6vx+SPm/ivtYmrMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxds7ZBgB2Vcifo8P+TFns+xKefa0lTleeYfQDGyVO4=;
 b=kOWG1gXsr40wYokspgrBXCeg3Se9xF8vFCQphS+nEZ3goG/8jaztqfx6Vb11Kt7pmW25oVEw2TvOicPCVfhivPiVYHZakwjDHkgP2IpCZCpZha17QJo55WFrrFBpUQwyBN+sbpXX+YzKWQgg0AF/SB7UaRrg2FzZODShX8z1MUaJtgfxWoiClffCAC73gqY1fO2BFnCMkksbVgZxXiL8HHNLPR/KN791mdXi7aroY6N0Qh5JL4jqj+KJmoUFzms6UlL9vUKO1vJpc+qvTbDc56J2G+lebwD4a2sBJFPiMX8EYYIbDlP4WtL/7WLHqufLIEKOsVm3aI6i9pMsDmj9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxds7ZBgB2Vcifo8P+TFns+xKefa0lTleeYfQDGyVO4=;
 b=D4B+WdO6BZBhJk+G5lk2Itbe0C4ryL818Fy6LHCWXc9K+tHDHP2qqlueCbjVyiBaLBx/UyoaOc2D+uk2ox84YT2VE/CJEoPkAqpGJd9CGUwDSI+/v1BS9Fn3ACLu+MuRLrRtEJZgRQKf10Yts3Ppc7cgUxWZOmsvzLz37K3pjEo=
Received: from MW2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:907::47) by
 MWHPR12MB1598.namprd12.prod.outlook.com (2603:10b6:301:4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 26 Apr 2022 14:22:44 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::49) by MW2PR16CA0034.outlook.office365.com
 (2603:10b6:907::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Tue, 26 Apr 2022 14:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 14:22:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 09:22:42 -0500
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
        "Borislav Petkov" <bp@suse.de>
Subject: [PATCH v4 1/2] x86/sev: Add missing __init annotations to SEV init routines
Date:   Tue, 26 Apr 2022 09:21:46 -0500
Message-ID: <20220426142147.338412-2-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74820272-d3f1-4d7f-f089-08da27903aa9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1598:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15987CB92A6B90CFB3531CC695FB9@MWHPR12MB1598.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8dn0myultQgR5J8oTn9rfP3wSG1OjrPyGsmr9a5LvmuaCDcJkfP3SakQ8HJWgppXbAjc1TQv73NGq2InPbgJ4MWk+aX4OZewBMG+TEADoq82X3wJbDTU5D8AmYDkuotCRymngepiNP6ZqoIfxYlx2jmbU8Hp6h7hEsRsRFyWpA6EkEG1JiR8ZqiQoBD2z0T/OvCpepVzQGMRuwhar4s/P6KNpHKbWb53Xzs5Ss75uV+n4SzlVGXOwmg6MPK58ghlLfM+qm3p6JHX4HtChrVyzWolqpFTXnRIpUJkZpAdNYC598bN7cXl6RBHZSufm7rrZ1QMaUzXG+YjhPjWj58CQp8s05f98w0nI9fi3OGjN592ft4JiV08AD266BSsWKq0KI6jEJNyLjocphOEwBbLJWtWx6TTnSaA2BmbDbLrQ7JBEpChym9L/Pib2LO8FTclGPfx5fOr7fxjyPeWmh/aaYhFOPDHKixM9QYxChsgiBxxjckb6mkFyaeIEuk56S5eDU4LYui7t+tK8pvY/X8PP+8Dub+8ef42VcbzjNvM0IKFc/LjpeKR27/LZvplfSwbSZqoCmMM+ssNKuL3pKn8RGJEvTaUQuP2wPiytO5wjSsdNmY7H22/l6hizpnZKumEEs6SHRdsWApSzXPC3YbIbkKEzoDjSb2twV2vi3AGacvN+/qSX/w1frYlSsXFAA0Lf0Oqc+JRMjyzXWdE0f3dA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(47076005)(44832011)(2616005)(1076003)(16526019)(5660300002)(8936002)(356005)(36860700001)(83380400001)(81166007)(186003)(426003)(336012)(7416002)(86362001)(26005)(8676002)(4326008)(2906002)(70206006)(508600001)(70586007)(6916009)(316002)(54906003)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:22:43.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74820272-d3f1-4d7f-f089-08da27903aa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently get_secrets_page() is only reachable from the following call
chain:

  __init snp_init_platform_device():
    get_secrets_page()

so mark it as __init as well. This is also needed since it calls
early_memremap(), which is also an __init routine.

Similarly, get_jump_table_addr() is only reachable from the following
call chain:

  __init setup_real_mode():
    sme_sev_setup_real_mode():
      sev_es_setup_ap_jump_table():
        get_jump_table_addr()

so mark get_jump_table_addr() and everything up that call chain as
__init as well. This is also needed since future patches will add a
call to get_secrets_page(), which needs to be __init due to the reasons
stated above.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/kernel/sev.c    | 6 +++---
 arch/x86/realmode/init.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2fa87a07ab30..b7fd1915560d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -558,7 +558,7 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
-static u64 get_jump_table_addr(void)
+static u64 __init get_jump_table_addr(void)
 {
 	struct ghcb_state state;
 	unsigned long flags;
@@ -1077,7 +1077,7 @@ void snp_set_wakeup_secondary_cpu(void)
 	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
 }
 
-int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
+int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
 	phys_addr_t jump_table_pa;
@@ -2171,7 +2171,7 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
-static u64 get_secrets_page(void)
+static u64 __init get_secrets_page(void)
 {
 	u64 pa_data = boot_params.cc_blob_address;
 	struct cc_blob_sev_info info;
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index c5e29db02a46..41d7669a97ad 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -67,7 +67,7 @@ void __init reserve_real_mode(void)
 	memblock_reserve(0, SZ_1M);
 }
 
-static void sme_sev_setup_real_mode(struct trampoline_header *th)
+static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-- 
2.25.1

