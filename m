Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB44D4579
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbiCJLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbiCJLRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:17:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F29141473
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:16:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9nrffsGI//KGXb3Yd8TSuQB96lE6oTBRAjGUnelNyiNJJ19d0H9CRunGZA5eWpGmebjYJkc27+CZIWawId3U2apR0crtwvYB7O7dW3n5+V5U2/XCD3bEDRypot23HMzYwx9E/9/Zllgs1lOQYcFthnUuirGEeMZunDVrM81EvxrAUzXAcqXSTk6Zhs9sa7mqjOPZgTbShphjd7MUInGsfVMyymnaMF3dkYLEgvISR9NjN6nrrkDEE+ZrUaCH8yxX+oXIsHiKu4CIy2sg2icjKWCxejq4telHJv33Vzs/0zOFoc4KonGtk+gsVtO8/Z3GVyFo/XSd8pH7X3dGJj7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SudsVIi3obuN2snFXsZgYoY2KU/BgUvR8OGtpfgZI+I=;
 b=U8XGmIawe8vL8DufxXRJAhWKNOom25XnDMCmdTxc6uj+aw/MuJV9rqZOFUi66OSz/6+a0PM8AA753fQ1yRSo27DvQQZ0nnGz+kGK85Sh5JmDZsyM5Drm3u6Hd5BZ4k/YV3zctoSuD+ezpySB6GKEtIDlCYsq/DRRxAsAGwGOSxyGwMutYoq00JUNkniXPzM5i5vuKexFpjWV05zsOnNsbbslaKeWdvoJKbKSfBqd6laYsGu9W6V4VVwC4UBCCEFbCYcA3azyY0Esl6l3TKonKYjarWvv9A40jgCudMzn2pUiYriMOZg0RvOVhm9FWAJsqMlMT9z+2gQ2+hJC2/4Peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SudsVIi3obuN2snFXsZgYoY2KU/BgUvR8OGtpfgZI+I=;
 b=PQ2zmnzdsvSAZPRM57neB0W8wWBmJGITm+c/2SNz5BMDjQ6LlVp8KxM3YoVllrHkb5wpHnopozsLro7kf1YKiL8rDG0wZGVbsj/FY7kCbOBhlzufG2D9MiNnGNhdgAo4WKsvMg3gQR75qHixaoXX0HrHQvReG40QV1rF1zPgpWk=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by BL0PR12MB2820.namprd12.prod.outlook.com (2603:10b6:208:80::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Thu, 10 Mar
 2022 11:16:28 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::d2) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 11:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 11:16:26 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 05:16:20 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <x86@kernel.org>,
        <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <shuah@kernel.org>,
        <oleg@redhat.com>, <ananth.narayan@amd.com>,
        "Bharata B Rao" <bharata@amd.com>
Subject: [RFC PATCH v0 3/6] x86: Enable Upper Address Ignore(UAI) feature
Date:   Thu, 10 Mar 2022 16:45:42 +0530
Message-ID: <20220310111545.10852-4-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310111545.10852-1-bharata@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f33297ab-f11a-4c4e-e3bf-08da02876b62
X-MS-TrafficTypeDiagnostic: BL0PR12MB2820:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2820B4F8DC834AA768BA3837B00B9@BL0PR12MB2820.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgTzMtLQLEqbV+ZNMgggJCsI2DhZf12KazrmuNnKVFM0bXSRshGxq9Mu6LtVQAuKAEmPDAo6FnZ2Acq/iuXwDzDSGNH90IuJJbdY6nJ4lu0daAaIBgZNWtfOx+XuUOFPCoJ8OoWfoioxlOG3zcwDiSQCt6EhJCIGAM7k9HzBhDuuzz0VY1GTCwE7pB6wqu6SkYz3q2PN+CCgcX6OFCu/9Q8lbSqnVccX7X3QGy1JUG4HiVH6SDtbcpsUsfIljQnQYFGaz0Vcg5iEZPl+ZuQU68aCFBcP8CFw561ivQSRDXxrRT930YrN3jG6kuf0pxiRngIzwpDOzjQitpbTAEKIIV3MQiL84u3bVsrnSGpmF5JtAPGoItZGT7H8iBv05hDDNksoKObTlFu6hFboeWlcIdjOW6YJGuIJ13S4CD5HAtUsQ0j6JQSle4b4UM2pmZ8z37XOJ9U4XlGhnJxCdmzsZ9YRcApJDKzQ43wuDHDi51KBu9OQ4m90/ZuO+o73fNgxJDh1cBpijgh70unaPPTNX1ajz/NwJNp6Sgtv9wX333FhsWoCGaQhY7JmJLLIDjx5HigXb5ExMSFgWyPzhF199k62KeBSQWePD+thT2OFoJ4sjb9jdICAlf4ZIa1iqL8MoGQWfnYk7Opjr/HFgVS+jdqk9ELsCKwHqbnTL96KVZZK+ADo+8YtB4kJlTvPFDR61zgAmhC2GJXyBYBhVVLhSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(2616005)(6666004)(47076005)(81166007)(1076003)(8936002)(82310400004)(83380400001)(7416002)(5660300002)(8676002)(70206006)(70586007)(2906002)(316002)(4326008)(40460700003)(36860700001)(6916009)(7696005)(86362001)(36756003)(16526019)(26005)(54906003)(508600001)(426003)(336012)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:16:26.9955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33297ab-f11a-4c4e-e3bf-08da02876b62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UAI feature is enabled by setting bit 20 in EFER MSR.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 arch/x86/include/asm/msr-index.h | 2 ++
 arch/x86/kernel/setup.c          | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a4a39c3e0f19..ce763952278f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -30,6 +30,7 @@
 #define _EFER_SVME		12 /* Enable virtualization */
 #define _EFER_LMSLE		13 /* Long Mode Segment Limit Enable */
 #define _EFER_FFXSR		14 /* Enable Fast FXSAVE/FXRSTOR */
+#define _EFER_UAI		20 /* Enable Upper Address Ignore */
 
 #define EFER_SCE		(1<<_EFER_SCE)
 #define EFER_LME		(1<<_EFER_LME)
@@ -38,6 +39,7 @@
 #define EFER_SVME		(1<<_EFER_SVME)
 #define EFER_LMSLE		(1<<_EFER_LMSLE)
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
+#define EFER_UAI		(1<<_EFER_UAI)
 
 /* Intel MSRs. Some also available on other CPUs */
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f7a132eb794d..12615b1b4af5 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -740,6 +740,12 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
+static inline void __init uai_enable(void)
+{
+	if (boot_cpu_has(X86_FEATURE_UAI))
+		msr_set_bit(MSR_EFER, _EFER_UAI);
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -1146,6 +1152,8 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.paging.pagetable_init();
 
+	uai_enable();
+
 	kasan_init();
 
 	/*
-- 
2.25.1

