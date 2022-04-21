Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C39509700
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384608AbiDUFwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384587AbiDUFwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:52:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A412AC7;
        Wed, 20 Apr 2022 22:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH/dIQPR7mGVBylm5++55yJHp8l2IdbDxNDoszduODoEhSfPhY9ZlqdusiF97jX2FZDz76V+9oFhA/zj5cY+aRUkYzWkVaaOiOxIE7xAavhwpK1sfsZHVMgnPqeRwskNAXXUJCRMPtUg9itYgH00/qEkEI6oUpji2rjtbcmDbV1HtFvL4mxxWV/nQW8Sg4PtVwN5m0jB6L1c/sG4em7yfUXzSx6LYX5Xqx2oPP10hYyemwNblgfffagxzjYY+aJnGDxh0IrbXTA5YUw3Z5CFaUR2ujkDJdYXq3eSAi2li9N8UGc3TWHYWmr0eA0Qc2izWmKHwm5bGcH878xtpEEmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giezbty3/L0iSeImVWYcjLtVvxY/ggCYadhxru5hJoI=;
 b=g+hJjTv9F2Zo5t91fto2ZR5nYipwT5hcpk4ToMTcLNtux1m+zX7vp40rnO5upJ3etzkS9AdXvXTp/9Vha/LkBveomSQ9vcwNgEd6qd8ylV0dEMkaBfr5iZgdzxnc7zTzH31ew1/58Zx0q/uhRwNeEvg9lwDsH8gnLm2USsqy9x2XDKmDvEyPU3iGjuXeQyKjewQ0nVmR/EShCGOUxdVcN84aCOEFOyLLdKa0LqvHw1Xr/9c260ZnBTCHv85YlMFQKYKEjwT0jgqJRVFfXXGTjqnsr7B1QM3Ii/eCphPE8RCTQg6GCxtJHyd7t2Sc5tVtoByd84d/JRAuqZrpoQyuDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giezbty3/L0iSeImVWYcjLtVvxY/ggCYadhxru5hJoI=;
 b=HtlBNo1ElpYjhV7tAQsaq7eqCn1Iz13Ou+gqWoKEdEzGnNodxss3/CuGlUL427kXMq/vp97btqmMbDre5OOH57IEAXEHQt8d+4VT8cGz5Uo3dwc2Mq5ZOO4imkX1zdODZSEV5g9y7vHePvtvMSk6A492Mtc96Br3y2k5iriyZRk=
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 05:49:27 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::d3) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 05:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:49:27 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:49:21 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 7/7] kvm: x86/cpuid: Fix CPUID leaf 0xA
Date:   Thu, 21 Apr 2022 11:16:59 +0530
Message-ID: <54bc7fe4cadf6bdef823bab1fba43d4891d2e1a9.1650515382.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650515382.git.sandipan.das@amd.com>
References: <cover.1650515382.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1dd1f05-41d2-4ac6-e9c0-08da235ab26d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB444661ACD36C8F433CA2084D8BF49@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fwm8JyzYmPd9LlQiJ5nxo16PhYneSr842BDsRSuWKxQ4rJYKL05sXJvcyTPZu5PPhyb+f/lID8pos2BbPGwrZ+PQSWk2B+o3ClG81G5z9WhtxSwZnZuIOLiw0JLr6kvCfT0ydKw1CBhn+XuZ3ULtL5wOj2QwAMtnlo+7ZbGQIlt+FxVaNVJVcZgbzrxVBuVOMTTe8cZCaSUzJp0N3i8T7SmBBQVG+7QrxWPH+x3Zb8w8nd0MNQ28YEFVKcz6InfB/07a5bse+sPojnnz8GHpl5KSm5oLUmewVqro6XrrKfUwBOdfkV2VhSZnFUviZvV5TQfsm69cwXN1QXTZtZBZgHbcL4pXHHkvLpwXPyn2Efm4JKIhxoWcQqVeWobaRMXDkgoFQkb2/9a8lJ74hlbMkXMcQBwc0g88Uj3IlFVybHUKf65e3C+C0fITXiAXHRv5+lkebke4zvKJp4daGmYnGFgwHMQ7TMMdljOqwd1m/LA+n7sGyf/MwbYuaHnGMpD6AZOxi3GPqxbipGblbneo1cR0E59asy5zhlO0Rq1LUPw4b6gWiJO6tWkfYMwOZLrnHamiJqgk9w/VO/bxHJNva0QBUvLgj+ILOSOtZGh/GPgFltMDlFdObb5QJZyiKQxqgaXZWojen74tXOiSFuZdOx2CYWkQ7nGU3VVASLoQw5GzwYmFlpMKlUIR+hhbxooIPUKnpG1NR6zoRfFOkClFYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(2906002)(36756003)(83380400001)(7416002)(86362001)(8676002)(8936002)(508600001)(336012)(426003)(82310400005)(2616005)(186003)(16526019)(4326008)(47076005)(26005)(81166007)(36860700001)(316002)(5660300002)(356005)(70206006)(70586007)(40460700003)(44832011)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:49:27.2829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dd1f05-41d2-4ac6-e9c0-08da235ab26d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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
processors. If PerfMonV2 is detected, the PMU version is
set to 2 and guest startup breaks because of an attempt to
access a non-existent MSR. Return zeros to avoid this.

Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
Reported-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/cpuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4b62d80bb22f..6bd65cad75ef 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -872,6 +872,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		union cpuid10_eax eax;
 		union cpuid10_edx edx;
 
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+
 		perf_get_x86_pmu_capability(&cap);
 
 		/*
-- 
2.32.0

