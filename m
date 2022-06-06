Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF053ED85
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiFFSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiFFSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:04:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70151E4B44
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:04:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcEo8Qu8Kc4ye4c5A2DQTGT5WAKZ+GvjNqwa6fxqajqqf+Wx/GFzVtstvvOytUp0+QhNs43FluBNaF3g4C3ZEbNtRyWNu8FwkAY769Krr/q8/1XB7HaxKoCZou+/w1ZqyFeyPTCoi/1ghry13L2GCyliXi+UgsSaim0eDHsE+Q3EaOao+XBONpOgQTjmF7NcYwOOG9NXEU4I9VvEX3pXp0fIfHOjJHK2M3amqWFtl3xezarwy/tLGTCSxMUVXw5nkonJP/3FkYmevVPJNH5mlLFVk7KmVN7azxHXJRObHkPV+065rVyQOAbmZOo1RlqRFwUmZAIf+VB7iZ6xyJ//gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yACaPfYXajTc2ffMjqN26TtnEpHGnYZvFWlsjudVpzc=;
 b=Y4hlgqrZxz+yw8eaMvmpz75OOwrvoUPX0QawnopHlLZ2s4AoCGujsiVJz9WYOIEuCH/mrhBQxRgnNuAubomx9t7ozZJw8n0cp6K4DBeM43W1yoolPurm0I5asfALaDn0bovHJaOZqxTkYKeaZEnuXXUPeQqdELpJtBVEEcQfUxrJNcz53qdThjkA2HpJYOor6k/wwMA7jiVafXmzvF8c/sO1DSI8dy1PGy4yl8dyq9+ZC2/eUXTe6hhxmJKrrb+PxJl7jar7eEGPjl1hT+hsuUdRrwf5NhA87YFYdZYIhdg6VSti8krsnk6OhKwyFtVjE0VwfD3i6/plzDQIs2sEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yACaPfYXajTc2ffMjqN26TtnEpHGnYZvFWlsjudVpzc=;
 b=rCRI5wy+KxgzENQRW67TxvqPFfi6VUdevquZrPV/4d0TWUcXvIUVR/o4pUXDFGQFYrciTBBZggaUWxB+PlcCzDrV9o0whN+dAz7oYRx23CDEZG2N8oFeVUVlG17MJr70/0hgrrUYWqPaeX4XLINk+D6T9EZmX4sglKBJXclOvRY=
Received: from MWH0EPF00056D18.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:19) by MN2PR12MB3453.namprd12.prod.outlook.com
 (2603:10b6:208:c3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 18:03:59 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::207) by MWH0EPF00056D18.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.1 via Frontend
 Transport; Mon, 6 Jun 2022 18:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 18:03:58 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 13:03:50 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <Lewis.Carroll@amd.com>, <Mario.Limonciello@amd.com>,
        <gautham.shenoy@amd.com>, <Ananth.Narayan@amd.com>,
        <bharata@amd.com>, <len.brown@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <peterz@infradead.org>, <chang.seok.bae@intel.com>,
        <keescook@chromium.org>, <metze@samba.org>,
        <zhengqi.arch@bytedance.com>, <mark.rutland@arm.com>,
        <rui.zhang@intel.com>, <puwen@hygon.cn>,
        <rafael.j.wysocki@intel.com>, <andrew.cooper3@citrix.com>,
        <jing2.liu@intel.com>, <jmattson@google.com>,
        <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v5 0/3] x86: Prefer MWAIT over HLT on AMD processors
Date:   Mon, 6 Jun 2022 23:33:33 +0530
Message-ID: <cover.12ae0052320eae3574e421a17822624143a4bc61.1654538381.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38505a17-a19a-45db-61e5-08da47e6edf5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3453:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3453C3E56E0A4D73E7B8B47D84A29@MN2PR12MB3453.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3T0CmhnE27Q+evtup0bM9KjsBvoaF9nbgRCVPmqC5lYLADm7V1iwyFYGtqIkH3bc7zD7febHYfRJgsfIdpPe3AtOnYh/LPdqhSfO08KVN/XBzHPPS9AwUqpXiIByGQM5rM4QiECSuckXexYEHVFXk1yUS1uNuLWZWuyJ9+n1zGX/ALOys3IaaJEV1TUyxADCm7OzFTtgYP7yc0nVMlvkvMuDpM3d+Zf13c85PBF9lETGv51Lx1J+npWYYkbirL3tmgh4cuplr1UMqAH6vj0so/sRKzoTaW66rq85dEihEEDfXSTV7cEDbGwlkubA4ZZo7vVtVxdMxfaI5WZw8ZnGbqwekCPeM0jo86hrsGlDvRYkvV6PMQxmUT1HsOlmRMmQ+AyaPcSePh2R4smlBBezj6zGDUjbz+YvIX7fdBn06AKWPMnha7HPjVFz63GA+UpHSK6kp8BBzCgoutrgw3x+IoDZWraMJ5VCszIu4qNq/7CNH822zvSNKiGboKoA1G4ue5rLX4JmO1XzlTJbnwbbIQ6TQc+ctLxxUYiO10EBp6zDRmsTYL4qCkPP9CqTfA20tjvLNEaN17WejfPgNAVPe3/WzAAsOszYkzYsq55hCNcNmjEraIOvvy+HoVTlymXG0WZhiDVaodVz/RppFmzee6XCOUO/twusAo2OYCuzUHnR03CoRbSBhyTZ8yFn6x0anyWLHVBGQzmw23c3U78F7h3COVO9Ng+ZFdOgyvc7N7YTYumlZ/f13v8CFVzdpAKZ494DWflqHYMEmJXmQTV7WvR/eKZOb5+pCLpuYFJq6j3xCgevf+w+4qHHex9Ka4CcYp50l43YR+ZfVKjdGoQJTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(36756003)(2616005)(40460700003)(16526019)(7416002)(44832011)(5660300002)(6916009)(54906003)(86362001)(2906002)(316002)(26005)(336012)(36860700001)(47076005)(426003)(83380400001)(82310400005)(70206006)(70586007)(356005)(81166007)(6666004)(966005)(8936002)(186003)(8676002)(4326008)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 18:03:58.4803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38505a17-a19a-45db-61e5-08da47e6edf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3453
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a version 5 of the patchset to "Prefer MWAIT over HLT on AMD
processors"

The previous versions are:
v4: https://lore.kernel.org/lkml/cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com/
v3: https://lore.kernel.org/lkml/cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com/
v2: https://lore.kernel.org/lkml/20220505104856.452311-1-wyes.karny@amd.com/
v1: https://lore.kernel.org/lkml/20220405130021.557880-1-wyes.karny@amd.com/

Changes between v4 --> v5:
- Update broken documentation around idle=nomwait
- Rebase

Changes between v3 --> v4:
- Update documentation around idle=nomwait

Changes between v2 --> v3:
- Update some text in commit messages
- Update the documentation around idle=nomwait
- Remove unnecessary CPUID level check from prefer_mwait_c1_over_halt function

Background
==========

Currently in the absence of the cpuidle driver (eg: when global C-States are
disabled in the BIOS or when cpuidle is driver is not compiled in), the default
idle state on AMD Zen processors uses the HLT instruction even though there is
support for MWAIT instruction which is more efficient than HLT.

HPC customers who want to optimize for lower latency are known to disable
Global C-States in the BIOS. Some vendors allow choosing a BIOS 'performance'
profile which explicitly disables C-States. In this scenario, the cpuidle
driver will not be loaded and the kernel will continue with the default idle
state chosen at boot time. On AMD systems currently the default idle state is
HLT which has a higher exit latency compared to MWAIT.

The reason for the choice of HLT over MWAIT on AMD systems is:

1. Families prior to 10h didn't support MWAIT
2. Families 10h-15h supported MWAIT, but not MWAIT C1. Hence it was
   preferable to use HLT as the default state on these systems.

However, AMD Family 17h onwards supports MWAIT as well as MWAIT C1. And it is
preferable to use MWAIT as the default idle state on these systems, as it has
lower exit latencies.

The below table represents the exit latency for HLT and MWAIT on AMD Zen 3
system. Exit latency is measured by issuing a wakeup (IPI) to other CPU and
measuring how many clock cycles it took to wakeup.  Each iteration measures 10K
wakeups by pinning source and destination.

HLT:

25.0000th percentile  :      1900 ns
50.0000th percentile  :      2000 ns
75.0000th percentile  :      2300 ns
90.0000th percentile  :      2500 ns
95.0000th percentile  :      2600 ns
99.0000th percentile  :      2800 ns
99.5000th percentile  :      3000 ns
99.9000th percentile  :      3400 ns
99.9500th percentile  :      3600 ns
99.9900th percentile  :      5900 ns
  Min latency         :      1700 ns
  Max latency         :      5900 ns
Total Samples      9999

MWAIT:

25.0000th percentile  :      1400 ns
50.0000th percentile  :      1500 ns
75.0000th percentile  :      1700 ns
90.0000th percentile  :      1800 ns
95.0000th percentile  :      1900 ns
99.0000th percentile  :      2300 ns
99.5000th percentile  :      2500 ns
99.9000th percentile  :      3200 ns
99.9500th percentile  :      3500 ns
99.9900th percentile  :      4600 ns
  Min latency         :      1200 ns
  Max latency         :      4600 ns
Total Samples      9997

Improvement (99th percentile): 21.74%

Below is another result for context_switch2 micro-benchmark, which brings out
the impact of improved wakeup latency through increased context-switches per
second.

Link: https://ozlabs.org/~anton/junkcode/context_switch2.c

with HLT:
-------------------------------
50.0000th percentile  :  190184
75.0000th percentile  :  191032
90.0000th percentile  :  192314
95.0000th percentile  :  192520
99.0000th percentile  :  192844
MIN  :  190148
MAX  :  192852

with MWAIT:
-------------------------------
50.0000th percentile  :  277444
75.0000th percentile  :  278268
90.0000th percentile  :  278888
95.0000th percentile  :  279164
99.0000th percentile  :  280504
MIN  :  273278
MAX  :  281410

Improvement(99th percentile): ~ 45.46%

A similar trend is observed on older Zen processors also.

Here we enable MWAIT instruction as the default idle call for AMD Zen
processors which support MWAIT. We retain the existing behaviour for older
processors which depend on HLT.

This patchset restores the decision tree that was present in the kernel earlier
due to Thomas Gleixner's patch: commit 09fd4b4ef5bc ("x86: use cpuid to check
MWAIT support for C1")

NOTE: This change only impacts the default idle behaviour in the absence of
cpuidle driver. If the cpuidle driver is present, it controls the processor
idle behaviour.

Fixes: commit b253149b843f ("sched/idle/x86: Restore mwait_idle() to fix boot hangs, to improve power savings and to improve performance")

Changelog:
v5:
- Update broken documentation around idle=nomwait
- Rebase
v4:
- Update documetation around idle=nomwait
v3:
- Update documentation around idle=nomwait
- Remove unnecessary CPUID check from prefer_mwait_c1_over_halt function
v2:
- Remove vendor checks, fix idle=nomwait condition, fix documentation

Wyes Karny (3):
  x86: Handle idle=nomwait cmdline properly for x86_idle
  x86: Remove vendor checks from prefer_mwait_c1_over_halt
  x86: Fix comment for X86_FEATURE_ZEN

 Documentation/admin-guide/pm/cpuidle.rst | 15 +++++----
 arch/x86/include/asm/cpufeatures.h       |  2 +-
 arch/x86/include/asm/mwait.h             |  1 +-
 arch/x86/kernel/process.c                | 44 +++++++++++++++++--------
 4 files changed, 42 insertions(+), 20 deletions(-)

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
git-series 0.9.1
