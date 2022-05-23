Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72F531B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiEWQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiEWQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:56:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43A65F8F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ileNYcI4qLGhV/s0zwWsI7rMfSD1VaQevzOcrXfee/2L9eCXTSHFHMikhC24WLiPdYnrtEx/O11P1dbYivayL0oL6f8IBeow1cMupbIv+RnQC5SuXUDo6JYAzi2O1mZWOM8c2+EJSTghscY/aSw43qnHh9agnhGDB1f+GfaRJ2woh+tVXVQo/6eW47uCxI+s3dtWFXIr1HKg7F8e2fwI8/fKmKc/KVDrw9TRi1PMmlrhLqaf5HQOb1hoxQSwyoPuqkclSBmPBgVI4lR4wur1edhND6sm5sol5gyRKUsQozqUtAYSq31jdLrRuwddrdwlQLLnRZctpMo1/tc5zFzX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V9pfQ6JcKKCq6e5z6MeS/fN0VcDARhcNY9Rgbrh0Qw=;
 b=ZjRvVXp7nLT5a5INYF2WQSE2zsdgfjKYsr1a0NNqewwnVPeyREGYrKYy+h7B8YN0DDhKUS7J8Nj2PZ4H7CUjsip315IhJ8/PxM5HszARwNehCsd/b4FmQnCjZJDKqgT8/YA2tQ8tTOtU0VZBmdTn2vSmAaOfjx8T3XG+CONjUQkb3uk+AGWAtH7bj5rL218q68yP+v+ZHpyFa2HswJl2q9zkbaXEaHM9n+0Dz0XKq2/r+sVi70Fi+q8bUZz4t0awoUX7sYl5EJzTrhJi+7tnfQ8oYzYyIubyV9BfB4qUJ1JI0Jy414fCW9ogDfmrtxWj7ub1H7u0ZnJcDexIFhy5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V9pfQ6JcKKCq6e5z6MeS/fN0VcDARhcNY9Rgbrh0Qw=;
 b=Nm9P/0qxXrS3jtVE5WrpzPSpw36ACrHJdw6l6iaXCEfHjxuvxxyUyaloPJILAJ2SoyW4n01/ksUgDErg9Nzwlzbk9LKg/bZcNQpT6DyjtS9H7YhtKDmbbAgQnyH9oHdA9McISBU2JkVuasXH5X5k4grPYgMb8uhQlhdGMt6SnWs=
Received: from DM3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:0:50::21) by
 CY4PR1201MB2548.namprd12.prod.outlook.com (2603:10b6:903:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 16:56:12 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::76) by DM3PR03CA0011.outlook.office365.com
 (2603:10b6:0:50::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19 via Frontend
 Transport; Mon, 23 May 2022 16:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 16:56:12 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 11:56:04 -0500
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
Subject: [PATCH v4 0/3] x86: Prefer MWAIT over HLT on AMD processors
Date:   Mon, 23 May 2022 22:25:48 +0530
Message-ID: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfe738ff-18a6-4232-f703-08da3cdd24a8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2548:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB254897CE3F3879576EECE95D84D49@CY4PR1201MB2548.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUEsHuP3Jtlspd1+6KbjW0XkCUe/2IrexbmiSMV5HGXFjF96JqWN0csG9pbSkOGesTFbL42Lhex+3e23g2IbD967KHmWpPOsQbzAiWK2Y0oIC2nx1IbmXjWI+5p54mgDz2D6WYM34Oj9cw01yGGtpa77B3Hg+fhua4oVVsiSBS9ITU0qct17Hc4vT21xo4gLizNEySc8kVnewJVyu0zkIfHeh/tD8CIYs25FcJCN7kIqHyhGi8uvyAdqF4o/4NWPbCTjTQK3mYOuTbstoGgRVhAughZhC+DuU6kI3JM45HG6xPBpmpyLaulpuAeD4BnxQYGYlslrOi6Qjf3vw4g/TDHxvmW4Cw1OPxkyGqvyIsiju12LKCB4QdThqfbAkcDs95+LPdE/91teGVYWCudN7Q1WPmbwe6/V7o9Q4Aeb2NvhS57wQK/zP+xjH/VLzciLgb/y2pxiEDadH9UPelAtcY+tuC7FfimZ6v/uDkcy2cjjrBR9nMPfP0vqCZjt8adeB6AK8QFTWv7q7ORRBqBsNiSYCNMt/8nNczTx9SnrXWOeF47fNoVkxl2hoWhSUsL9zC58q3Gk9g2Zb0eS7GW1NqBDmMCeARVvwg3MPirgUjQZRNLUoh4osEUwabUBwSNFZnGBe0DRjbIpQl+P37COhWvwfqLJNFYbyyNFrCDDPi2EnBNq7YJRroByFU+wsTY769vDECC1MEBo+ftEP4d3XO3ag9JY7e2fU+pQXZsAoZZ8eQstVfiasI91Vw1FA7aEh+My3TXIgl6RdEUpTxx93zB3iVHnTcYnz87S06wN0ZWTyDHG2BkIRM8DfU2RudQ8K3GcVZYDyhVnpNKJlGYbdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(8676002)(26005)(81166007)(4326008)(6666004)(7696005)(966005)(2906002)(40460700003)(8936002)(83380400001)(508600001)(5660300002)(7416002)(356005)(44832011)(316002)(6916009)(186003)(36756003)(54906003)(16526019)(36860700001)(47076005)(70206006)(82310400005)(70586007)(336012)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 16:56:12.5901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe738ff-18a6-4232-f703-08da3cdd24a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a version 4 of the patchset to "Prefer MWAIT over HLT on AMD
processors"

The previous versions are:
v3: https://lore.kernel.org/lkml/cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com/
v2: https://lore.kernel.org/lkml/20220505104856.452311-1-wyes.karny@amd.com/
v1: https://lore.kernel.org/lkml/20220405130021.557880-1-wyes.karny@amd.com/

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
v4:
- Update documetation around idle=nomwait
v3:
- Update documentation around idle=nomwait
- Remove unnecessary CPUID check from prefer_mwait_c1_over_halt function
v2:
- Remove vendor checks, fix idle=nomwait condition, fix documentation

Zhang Rui from Intel confirmed that this patchset has no impact on
modern Intel processors.

Wyes Karny (3):
  x86: Handle idle=nomwait cmdline properly for x86_idle
  x86: Remove vendor checks from prefer_mwait_c1_over_halt
  x86: Fix comment for X86_FEATURE_ZEN

 Documentation/admin-guide/pm/cpuidle.rst | 15 +++++----
 arch/x86/include/asm/cpufeatures.h       |  2 +-
 arch/x86/include/asm/mwait.h             |  1 +-
 arch/x86/kernel/process.c                | 41 ++++++++++++++++++-------
 4 files changed, 41 insertions(+), 18 deletions(-)

base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
-- 
git-series 0.9.1
