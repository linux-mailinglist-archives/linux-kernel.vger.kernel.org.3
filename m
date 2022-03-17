Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85914DBF91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiCQGcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiCQGcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:32:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38611C2D;
        Wed, 16 Mar 2022 23:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRvHXGg9rbesdZeg2ZIQGElhJYuRdhbW8c7Lqv5cG2ZFzFVoFy7VCBwKUTl1NotS4I1iJRQ/jNxNZeqW+ZRSqpJAqDUVzTwb4AYAGrW/8dvpXuSOeWL1YjpG/sOJcPuV6W9bOx43jVBHHhC9BuK1oRvO5RUYyLfEVsUrTZ7ZeUv2tRt2xEwDPqkFvb8tEYzbGD/tca0dxbB4xEfbdbiXlaYk6Bb9VFJhIVvr2rJSDAPOSK8Vo4661e9czD7T18kpCRcKxpwgXEuf2M6zGp7h43BHiDBkH0NL46AzBwizcUVBmvXsLSESxjvvsebMwBX1ZSPiLbGe1jx544zfwhK3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY962XeFknOn3nvO3dxLHJIqqMCM6fwQUq39Sv8W+OY=;
 b=A76OegnwTwVXrOfgklOaLG6ePKWt9lTWjMVmk1eQ8Ni0c5WzWBW0xO3g3VlTROivVDsqGoxBl48pEVUdwAeQYxqgUxcXcmxNL2MDvetxm/fdBm3AQNS0D/Yt3JTrA87XuNctOKcEACfHrKoVtKZIHK82zhmrAVzn8qbkaIRhp5ubwThzEJpr5ebG9T9gfq4Z8YUleqWZmDAp1CpOJ0Lj0u9+0oezkiOjuL9sFUDbgV97EsOVLNntyHiRTZJuCr0kiG+qr8oVzB2Ir5GDeIFQzhk3r9bm9zZoNDtMTWPpwZy2Bj3EJBrRlwq8riHgJGvO7wIPQMhH7T2gggMLxyYHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY962XeFknOn3nvO3dxLHJIqqMCM6fwQUq39Sv8W+OY=;
 b=js+lZDbO82PjBuBjpsPXHy2esJ0PLz9yKUhIYF2TZUbIhmsBsl0wsab+AWxDAROePvDVHZ1mcdnDRkgcWV+qHvtpgYTfYHxuxDGsa3cAB03FXLZROWTfX9XTdeInUbl3Vl08xOuMX69EncX6e0VJepFF2PApM1ENm/J00w5pdLo=
Received: from DM6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:5:bc::34) by
 CY4PR1201MB0152.namprd12.prod.outlook.com (2603:10b6:910:1b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 06:31:04 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::59) by DM6PR13CA0021.outlook.office365.com
 (2603:10b6:5:bc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10 via Frontend
 Transport; Thu, 17 Mar 2022 06:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:31:04 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:30:57 -0500
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
Subject: [PATCH 7/7] kvm: x86/cpuid: Fix Architectural Performance Monitoring support
Date:   Thu, 17 Mar 2022 11:58:36 +0530
Message-ID: <bc58ac02d642ea1fcbd04a525046dfe978e9f323.1647498015.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1647498015.git.sandipan.das@amd.com>
References: <cover.1647498015.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae809090-7c6c-492b-2981-08da07dfb637
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0152:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0152C3EC8956FCD391B578778B129@CY4PR1201MB0152.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ell5NkIGtVeOMOgjarofNP2l9VytSRvUuc5uRbYxrhn5Uzki70IiW669CNZsbG63iuenAPL/LU4eeKFkbaTO/jJFeG6jIgAijmkMCwfTj3wy0eHaZ0iLwD2Pi022/oDr8JSK0idbuRPvqAucnIqEZ6OeIpWC2am0HOto9W5fg6MnZG9p2h0f//2prVx43FhyY4o291YESQRcI/l4YY+dTVPdN36lRyB0Iyk1FO63uEVdcWFB0toj0fVI+ca2OyYqbcgHYQlHFxPqhc3y1+6sF08QOnA422mNIXlA8ajLZjNRczutv+p2cgl/1+JzVoGkXLtzZjDjnNBW3z6GJiNc9V9iXb+WcU/qTGhanek3pySgz5pgL6D/ynsco8iz8QKnbUmqxh5APyPco0CzeONFzcewoXKXKhC/WvwH964w0LmyaYKmLiGXXBsXmL1JfyExXWzeioqny2NBb3dOuSG0U/9u6i+BW0W3lAYGZvMJDUvGtvIGu2WBHV5lXJK6J2acYgheS9AzW+BkwNpHvBzEwEXn2CUgI1w4/PsL2HEHOvy+ohSH8W5n1gSzLNWl8MNvYU6aFYOjPw+7rno69gXklp7DLRYZ60FKSdFeHuizGdQ040Bb5IA218eik1/qAUc7AJWbWVxAcREHvbLC6ow/lap6qWUenZupSMGxaC27b2xr3Ce80wbpR5NCOz99RzSqOdyZt/AxALT4zf6w2fAfdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(356005)(54906003)(40460700003)(8936002)(86362001)(47076005)(81166007)(36860700001)(6666004)(83380400001)(7696005)(26005)(336012)(16526019)(426003)(5660300002)(2616005)(186003)(2906002)(508600001)(82310400004)(36756003)(4326008)(8676002)(44832011)(7416002)(110136005)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:31:04.1422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae809090-7c6c-492b-2981-08da07dfb637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID 0xA provides information on Architectural Performance
Monitoring features on some x86 processors. It advertises a
PMU version which Qemu uses to determine the availability of
additional MSRs to manage the PMCs.

Upon receiving a KVM_GET_SUPPORTED_CPUID ioctl request for
the same, the kernel constructs return values based on the
x86_pmu_capability irrespective of the vendor.

This CPUID function and additional MSRs are not supported on
AMD processors. If PerfMonV2 is detected, the PMU version is
set to 2 and guest startup breaks because of an attempt to
access a non-existent MSR. Return zeros to avoid this.

Fixes: a6c06ed1a60a ("KVM: Expose the architectural performance monitoring CPUID leaf")
Reported-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/kvm/cpuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b8f8d268d058..1d9ca5726167 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -865,6 +865,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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

