Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BCB50B94A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448256AbiDVOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiDVOAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:00:05 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E5258E7F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IByKd1Mg67u+3Gtxog0hQhZx/2/2JFR6LMWtw36Y/njt1jFn9fxYeudInWvcZBPSZqPpWezdNeHWhfWx8NVcFwHFQt/bXRI2maZGOFY+bj40fdsriltw/JqgtBNNrT4eY2G3wHUt/gfF333nsHuOfRLRCli6kdAagfOE84UIyvuaBPk5N8NgYQtrUpfRnyLhKTpQHAW8BuHvvcdTdwMfg3tNAd5/bBf20t0RBYEmD7q9bvKMLa33hVG5DM9Js2YB5nQfUwBDBKg9L2KJemtipW2sk8VAQ2vYYanX07I3iREoPLNkE0VoqTo+TTHQidovufxK9+iLazhaMYC+/bS8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxds7ZBgB2Vcifo8P+TFns+xKefa0lTleeYfQDGyVO4=;
 b=EwDxAYTKcXFQ4YSjNav+u9xdso/XeXgOVD1Cb5Am3vppGwN5TES1cQai+S/b1FxMmWqdyzC6/g4nCjVXZ7p5KI4/JmLps/OoOF82TfQphuh60J1YjowUik37btfXDhq05HdLpatTsCdueRrKdYCQO43FfqmDaqu2b47v3ZNY7kvNHUxzlzd92U3kLwsaTYcLWjmSXJWVO9xXG78zFIk8Kg3xQFwb8GIDLlfj5YiWOwBzIGKpj5z3VUyy0Qn8JEJfZ/RMVStZUelijE9bjWzjDyzmG6WqGI89PZbZSBpie1dmUezEKLnzrrXjq7iusCTEMWVa8ksRVhlhLHEry6AR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxds7ZBgB2Vcifo8P+TFns+xKefa0lTleeYfQDGyVO4=;
 b=FfzwOIRk2rQycpZipcItXY45lU6P2eRpt1RL3Iylfq4O3DEo7qBiUs4tcmuLGBtKB/VmF93yYLjCi+K7xAp8Z54r1LoERAEUVfKY0T113ms1iLcq2nN3Agth3Q28mJJi/tehUYrslOEFobLW+bquvfCyctfu0FSDPEECiZbBcjg=
Received: from DS7PR07CA0002.namprd07.prod.outlook.com (2603:10b6:5:3af::8) by
 BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 13:57:10 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::30) by DS7PR07CA0002.outlook.office365.com
 (2603:10b6:5:3af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 13:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 13:57:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 08:57:08 -0500
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
Subject: [PATCH v3 1/2] x86/sev: Add missing __init annotations to SEV init routines
Date:   Fri, 22 Apr 2022 08:56:23 -0500
Message-ID: <20220422135624.114172-2-michael.roth@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb34b11e-7b89-4bc3-873f-08da2467fe6c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51928D07473C31784ED4530D95F79@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfwerDEmJBDfAzXF60tvFvcWaNWXc/cIM/41dWXas2j16ykRePwZjm4Nth4JSBIEJlOE6rGQpYNz8tty4yFXFSn3KgIaNsv/WzDAjnJATvQI6eFr3tRQiQZNo9FPPG5cbI3oGakMrRDaJZxDI2W65/WEWubogehW8HZ69z5QCAfMPCkNviA7qPBq0bqvE/IWS1SKDemqOpAifGvfGQa2FWFzQDuxQF7FR35J/qxNuL1CUP/L4fVA/rbhGE6DBrzCUawyOtUhyr4UcNMHwmrtnUe82CPdblVXG2DRJ9RMHR7a4ncODJ7zVfqbkmC2v+SLsbk2WziRA8Pl9J7fYEVPYJmYloTwfff18oes2vLkvFViXNXmKdma9XX/Xm0i+UzVNLF0WDZ38hBKpF26G5lnnJjV6bc8MivyI5W7Y0jZX51KwnlxuK3ovM6HzPyK+Gzxr2E/Eawftm8aVTg8vMU4tbzobGoboDVfEwrrJsajvK4HUhaVcD9BW1oN2PRCji7HQqoxoVlYG+WBWw52TzZjS1gFYH37FeOS1jXt+GYzKisypG/nJyZKy7av/8s2HOgoSzioIAiKXFkNFGUmA4vy7qQAQvtAsz4EBkV0K7zQeR0Ph6OR5P1RoSlkTQOsCmbrEu6gW8pRZmK5XRMId0s469Vqe/Y4COqgdvw1Pjjf1E9sJGLl3OSbo4g4Ui6F2LQbTGiyn9H2wcIgUxyWl7LpxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(508600001)(86362001)(336012)(16526019)(186003)(2616005)(26005)(54906003)(1076003)(83380400001)(81166007)(44832011)(40460700003)(316002)(6916009)(7416002)(4326008)(8676002)(70586007)(70206006)(47076005)(426003)(5660300002)(82310400005)(6666004)(36860700001)(36756003)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 13:57:09.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb34b11e-7b89-4bc3-873f-08da2467fe6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
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

