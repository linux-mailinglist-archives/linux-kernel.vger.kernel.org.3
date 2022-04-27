Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BEF51176F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiD0Lhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiD0Lhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:37:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE13CFFE;
        Wed, 27 Apr 2022 04:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnipiRBmb8e0V3xTNHsR8ZKrCzSNdc1OEHlD/6lPcHbIAUTZOSR8nrV0NoKZlO2Rj7JZhMkvQ8LWZfVbQ29pP2pP9ngv7RM+lrNi52sFBPrRqQVjkvNGs7DaqoAT8iQlmEmQGHsUFcJV3vfczI1fjwbLTE7pW6LtmMQa9OXDkqwfCT7RuAxCBwlRkp8/twg5hksehXoT5/8HLOpWNRackRfX/IsGeOYX7GOhp2N2FsoZxv+0kyNbpXmZ/5FgRatEN+bhcoKoynw+h2juaPY6bWONEMHCq4D2ksDPdEHS8eAQ3GPcIJ7avG6sEhX9u3cz/6R88DPlgjwy+C9bWgxrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qip2NrDTkpI14TY2w/bAHCeae3vYLrldpaHlsKEDMY=;
 b=XuvMB5AVcb0HpjAoLpTeqQReYryHFIwXC6PRgUFG0ozkI9uNskWjPjEt73A9X86eXlFdinAg4u30UU2ApD1iSKR+hiQcdcb4PuvWKCNMpgNgOUsUjDQg2EWmvuPo/1TK3szCwBdrkTRaqbN7G5z1czo4i9O4QVCXulvMid3+/iHnXEuYdjsVhGbMVGGcXYq5OgtRqbZ9dGqOgT/Rh70NLAG6LqovXKVternZqFKM4ZVqWIBTCyYGPO6tTqynuu+EMQ+BvmMaUozsU8PfbbH397AgVg8rOTgbt8oBKmwNd1M9bpjHXUUq944NZFjIjmIsWlTvOT+Xr41OzTNvPNLxNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qip2NrDTkpI14TY2w/bAHCeae3vYLrldpaHlsKEDMY=;
 b=HDCIDhENHMB2/q4yBtRT+RuSkIov1v9ZzCVHEo4aeYMsLQJSiK8pAYlV/JCFV9HV1zwmGf6Emi9/ojp7IBPwg2gcc4SThBCEckUfHo2lh7AJO2XyqMIc9KOaKkUymXdeF1yK3FWHSXiV2aE1exQ6Kb02fi7bHnqol79lRVwmXsU=
Received: from MW4PR04CA0275.namprd04.prod.outlook.com (2603:10b6:303:89::10)
 by BYAPR12MB2709.namprd12.prod.outlook.com (2603:10b6:a03:6d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.19; Wed, 27 Apr
 2022 11:34:21 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ad) by MW4PR04CA0275.outlook.office365.com
 (2603:10b6:303:89::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 11:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:34:21 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:34:14 -0500
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
Subject: [PATCH v4 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Date:   Wed, 27 Apr 2022 17:01:49 +0530
Message-ID: <3fef83d9c2b2f7516e8ff50d60851f29a4bcb716.1651058600.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651058600.git.sandipan.das@amd.com>
References: <cover.1651058600.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7294ec6-acbd-4068-bfa4-08da2841dfaa
X-MS-TrafficTypeDiagnostic: BYAPR12MB2709:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27090866C56FCD13EB0B441D8BFA9@BYAPR12MB2709.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYK5IpRQkaTOYLBhD7zhHnYeuMrzel3DkY7WxVyOqUfVPXjy3Mto20BTePcxSCJ6x4q2JaV0DyJJkqud333ucaaX5p2DRAqFwBv1yyMHTFE1z8d14eWeVXM3rMt/ekq4/ojaXkgGMcdcnXhP7+SdmL1yip4XmgjLM5OJlmJlSL7zvynVLutfARLi6koor+QGrcaBrmHQZTT9PUJ03JcRgnK3Saiw52m3H8dtp1LCCag6dPFUGEEs6tJ+7VuuKXAoDo+zf3mn7YIx086iC6jYTXMsr6e+SWUm9+7+yDBz8BRJOb1kWWvaH2ECEBHbkZiI/U3Dg0j01r9wzXny+y42X20epNegdide9ympFmgyce4Y+Ee1BanoS7DcORJJjxntxYOdubBNT7WyzyRw+05QlHndYpsM1AvutUoUI94R5bUaxVKaqS1OeD7usbUsMawMcC7zBll9/t61f/JjrWm/2RXl3dfcHfXI3wCwjrk3rwiGLQXR+aqmIpjQgtQK+cbk3lFG8zejqy6ACi1hPaJDdwW5+JVUItLv6K/Xj44SlM9foDvdQ+q0EfC/qe9Fxqs10Tu6IJ/Ws8pZTTMb4HMHSZOtsugGlDvVmYPcfn6pZyUkgHeZTA23/pO3P5lscTuxLJ7acNXLofvvdN27SoU1m9yRAh45hs7QIToKxheiOEQgTkKJ3eY/zQB/vrvr7UjTSRPBi6qlmXjQWeGY2Qji5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(5660300002)(508600001)(47076005)(8936002)(40460700003)(44832011)(82310400005)(36756003)(83380400001)(316002)(426003)(336012)(2616005)(54906003)(7416002)(356005)(70586007)(6666004)(2906002)(81166007)(70206006)(86362001)(26005)(110136005)(16526019)(36860700001)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:34:21.4966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7294ec6-acbd-4068-bfa4-08da2841dfaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2709
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
 arch/x86/kvm/cpuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4b62d80bb22f..e66ebb747084 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		union cpuid10_eax eax;
 		union cpuid10_edx edx;
 
+		if (!static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+
 		perf_get_x86_pmu_capability(&cap);
 
 		/*
-- 
2.34.1

