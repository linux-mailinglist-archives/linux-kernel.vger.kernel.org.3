Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1C50FE51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350639AbiDZNL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiDZNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:11:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5CE45AFF;
        Tue, 26 Apr 2022 06:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pvq/3eJYDfs44wyJvTJFUyqjWnF/t5Qe22HFW6l/sC5xiGT09g/sTbbxbzuHt9saU4qMWm5TXEC9tX8uvRjEhNJvvpzB4RYj7OynBmQ/035nCjD4GjDoxvY6H42zu9jVB0d2Q+H2c4Oc7neTKCDxbuNxichHgMH5OupHOJp67o8hrNrjBwfSauRgXnisGaLm+3sKWT7Pswj9sTctYzxnuJjhNiR9RlQGV5/3o9hIqvAnn+HNVjaZeA2kxeB9UrBFepdgCu/587x6OfyCvh23qTcozjqHNZN48BTWEVVsQGlRzx71W8VqOIN9RwC6C7d6n35+MvAPxeiBgFj69Z6eSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRE9rJl1IDZBkXPsETmZhYc6pmFlZEIetglvHDbIy8M=;
 b=lNuSJ6C2aOo9Lqx0y1b//3t1nfd5tWJ4gQ9+A5GAsbmML/vcdL9P65xiJIYDB2ImJTDXTVGhSNZPM8+qwrv2ZyzsS6f8UXyoBNr829dZQHmp8d9BLvuSzXb4CpSSgdo0zP8Hg944ckhNRPM13pz2uXV+zPqFhBUduSHBm5LFmwTGyWwiyV3LUEZYLmX876Uj44b5sfJQGh+6s0Yc2j9tRzANSbTanChZgSJAfir3j1bpnrSlhnNnWlzLfDdn7A2vBMdYBPk2pXV+MiGQH0ElLKtk4ynTyWzK6k1S7hfchhsedemjMZKejrnqap14AzYk/rzvQyShSjbeRhahbHX8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRE9rJl1IDZBkXPsETmZhYc6pmFlZEIetglvHDbIy8M=;
 b=c92v1yNJm0vPD0ABtzabnI69ia97EAzhRn4DxE3dTgJt6pgxNdbTLRVpoqgaWM901wqqcwYV9JHQGfWSY+quNmAwU57Xd4agFH/6Kd38DQZ4uiq+MlPegdY84XRjbq2KEZNM4T3NVgXAWmGWJsRB3V1QIUrtQ12oGF1RBOwZetc=
Received: from MW4PR03CA0180.namprd03.prod.outlook.com (2603:10b6:303:8d::35)
 by BYAPR12MB3575.namprd12.prod.outlook.com (2603:10b6:a03:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 13:08:10 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::6b) by MW4PR03CA0180.outlook.office365.com
 (2603:10b6:303:8d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 13:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:08:10 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:08:03 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>, <puwen@hygon.cn>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Date:   Tue, 26 Apr 2022 18:35:38 +0530
Message-ID: <476a0d6feef8016ed19e4911ac25abdd20aabeb3.1650977962.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650977962.git.sandipan.das@amd.com>
References: <cover.1650977962.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d17b94c-1969-4fbd-9ba1-08da2785d03d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3575:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35755E64566E6F67AF1D53748BFB9@BYAPR12MB3575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxB0K1rg0yw8BnMdkrcUeSq8pH9ov9PYS5kFnDeFx7Wmn6BYQH8rd7PYcFZX6eFPpI8pUCh3hS2JEvUTV/Ma3ncTU+LAhFu1e3lK761NVAIxlAcFKLsD4w34vWKMB/OlqRENZYwrbyYaqzA9bISQmSmZ4DNQ8dMKKu5CkfLF89/yPcPAql/hoy2WhZTMTpl61RadNxsGCSEht8csPvxE10Uy9UsEeLsw9mYCrpJaHZBIDid4G37qZwiy/UNFKaqKnoxIi71ZgsBIDX81GKHvmg4SEG8gasYiSfvd4EGKvLErveOChES5XGyXdQ7WLmZBucxhmOahpFvRLqawCb+JYo6CkoPF6zZKx/9xJ2Gs6JBgvj6w51M32ZlTOCYSz/yqsSMWWsFCV8TcQ1Vjs2Ou7mO300r8XpeRIkM+KIFafDQQIn0jag0/tfHj31xiypnwHXwkIlplC1IdtnWnsf35e+d0ajNn/OCnxrXWdqMk2uhjqUVr1Em55tWPPv1yKrNagwQYYwel4nGylFHTjp7JdkcATb72oc5iaYKkPZ+lX+pycV6Nq5m0Yx4WmiHEc4hwMJNwl+GQO/eJCvAHxw7bmf08ufnGEy0ZgUh2aeBemwSivV8oN+sFxiVtnLHIM7Kw4kWVZfvesSMEljj66yOKytmAgZgJjJwqjEmnSqO12xxSrci/GZnmLqRU7VAERCEN3ls2wjHyPAdMaTjOwloJDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(336012)(16526019)(47076005)(186003)(83380400001)(2616005)(36860700001)(82310400005)(426003)(2906002)(316002)(86362001)(54906003)(36756003)(110136005)(40460700003)(508600001)(81166007)(5660300002)(44832011)(356005)(4326008)(26005)(70586007)(8936002)(70206006)(8676002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:08:10.2303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17b94c-1969-4fbd-9ba1-08da2785d03d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3575
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some x86 processors, CPUID leaf 0xA provides information
on Architectural Performance Monitoring features. It
advertises a PMU version which Qemu uses to determine the
availability of additional MSRs to manage the PMCs.

Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
the same, the kernel constructs return values based on the
x86_pmu_capability irrespective of the vendor.

This leaf and the additional MSRs are not supported on AMD
and Hygon processors. If AMD PerfMonV2 is detected, the PMU
version is set to 2 and guest startup breaks because of an
attempt to access a non-existent MSR. Return zeros to avoid
this.

Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
Reported-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/cpuid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4b62d80bb22f..d27d6a8f601a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -872,6 +872,12 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		union cpuid10_eax eax;
 		union cpuid10_edx edx;
 
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+
 		perf_get_x86_pmu_capability(&cap);
 
 		/*
-- 
2.34.1

