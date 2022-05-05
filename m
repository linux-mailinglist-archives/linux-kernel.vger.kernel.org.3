Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00E551BD7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356068AbiEEKxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEEKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:52:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33FA167E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm9S3dqNDShqNevbeq5scje9W3dwm+U6mo86Old5UH3n5kKa85HYP8dvrAX6QgDFQZFK24r0NU2VRvPIcfZ0l8kqdiC/f1sXH9TRb/Z3znu5EXWhvmWeaNbZTcRp8LAsK3ZwnubIDsG+j3C1FFqCeeEABiEe+3IJuDCHZQ7aGorpmH7aWr7VoD4FHdvCEjeiNwJjtGqQ+EhvDWjdzHfATMoz/8j1/rRJqpLZB1nzBF85PdbDLJ8T4k5p0GhQTDEmq/ZIFwhzvaIybK9V8iaOL8oEkccpwR7yIHaK+FvNoHhKrqGFcIl/OZnXWgMhfYdtvGJEomLG4nEg/HiKkxdZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLe6P3HYEBOxxzQSZherhQGydQVmV90l9xMe3as+HHA=;
 b=Je6OlA+rNBVEVmjdD0sTadToYUldKDeF2J7TF6iu4FCqZ7IyTfhhSNGNKbEEWbpHmT7zPeOicgTuGxd3pRRAu35Bf3WYpP8HWZB5F8G1oYiAmkSy4e/vUM8JkWgtXtdvX67txfKx+XNj8X7qj9PdO5xMhe0A8gv3HMZIdrVYuzxZLHIaHJ4pbqlnaL2FgKV3l4pQrQElFA06oRDNynFOqu5ov1CbY5qAuAwOWCY6yjqSAbUpBGU7lHkchNh0xvOXCUuoUIx37AFs6fXqjtsSzbcxCLH3jGMfYhbgNCsmveIsOLLdd5vf2ghur5GZuAQfKEl6nYS7SR+EJwdZ7kpNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLe6P3HYEBOxxzQSZherhQGydQVmV90l9xMe3as+HHA=;
 b=KFpNexYoeyvzqhBNjTrbBGJC8AFds5F1c1WSBDJRNsvOg4WTIKFEEy/xLDTLBwE0Bx4iP+dBkQ+p4xxfAiJJLBt9IrDdSq/v6TbD3s4axtv3uMEmLiJWQYsK1EfN6EtIJT6wzN5UFg6je0i+hkeMibYOIat5jW/breLJ8+Em5hQ=
Received: from MW4PR04CA0117.namprd04.prod.outlook.com (2603:10b6:303:83::32)
 by BN8PR12MB2899.namprd12.prod.outlook.com (2603:10b6:408:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 10:49:17 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ed) by MW4PR04CA0117.outlook.office365.com
 (2603:10b6:303:83::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 10:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 10:49:16 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 05:49:09 -0500
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
        <puwen@hygon.cn>, <rafael.j.wysocki@intel.com>,
        <andrew.cooper3@citrix.com>, <jing2.liu@intel.com>,
        <jmattson@google.com>, <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v2 0/3] x86: Prefer MWAIT over HALT on AMD processors
Date:   Thu, 5 May 2022 16:18:53 +0530
Message-ID: <20220505104856.452311-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fabea406-96a1-4e1c-97bf-08da2e84e6cf
X-MS-TrafficTypeDiagnostic: BN8PR12MB2899:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB289924945D4CFD5927CB014584C29@BN8PR12MB2899.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZNwW+ftROUMRuC3o9J4Y9tDpNEE4PoedTsWioFE/GSrhOH7aUtedVz/4oRVuj3HS5sqDCywUwr6QUEaBHtNM1gbQvoo2xcPdUGUkaQ8ourfJoWUeNBO9YrHJzVd9EIh96CRYsIcupjv9BN7QZV+IYFOO1DCrUSrWLi8qxdrCPfuivFzlIwXkW7TR/069s6qHvCRIDW+omuxkxhxs3m1eqkcWj/5aAnFZ25xiPUYTjQ2YTdHOOeI1Owh/yQDDghfO2443+PRPPAfIas6spW/Q+DN2qErBeZcO2mp3YtDXhs8jSXVtksX3xvbir1ICSi/XT3i6RRuvh7uF4YCOHRxt/HdGfrvwAd78Nx1pRARd4aMrJbg+ov8ZH9uQvcBY86VzekAP82PE5LO/f5tfMxM/kJoz5pFIuc6CgoeWf5NdE5m691F9SjxVvxrV87iWtWdJwr9zMmge0NTV3qj1vnIYr6SGetEDt6tKbA68zM8Ny2rUw58PLUVke5LfmLuSI38rITBKVmmq6Ssb7jqjldw0I/KNmYHhmGxpI8AzpU8mL0jyq9Zj971SzVmruYH6Kqmcg3v2qNBtVKIzRhxILEREzrs9NxYmNBdKxWFbPyl0FBwmvUczOEoOL7iOsIi4eFJRq1jGm/+2jPmgDpPyd4Q7+PPtaAtfhoYLqukLiTHH7+v32c/dkYwjnHFblNnLnyQH+iO6XhMLX+A6lh9tFNNPsGI66YSQXvXdAg5d7gguD25S8GG8s+MOVdSVkdjrxMP4qJfGJx2s1V73BBSimyM5lNgOtHvxs+pGaUb4Xqcryo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(8936002)(81166007)(186003)(2906002)(16526019)(40460700003)(1076003)(316002)(356005)(966005)(44832011)(82310400005)(508600001)(70206006)(4326008)(8676002)(70586007)(5660300002)(7416002)(83380400001)(2616005)(6666004)(54906003)(47076005)(426003)(6916009)(36860700001)(36756003)(336012)(7696005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 10:49:16.7865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fabea406-96a1-4e1c-97bf-08da2e84e6cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2899
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in the absence of the cpuidle driver (eg: when global
C-States are disabled in the BIOS or when cpuidle is driver is not
compiled in), the default idle state on AMD Zen processors uses the
HALT instruction even though there is support for MWAIT instruction
which is more efficient than HALT.

HPC customers who want to optimize for lower latency are known to
disable Global C-States in the BIOS. In this scenario, the cpuidle driver
will not be loaded and the kernel will continue with the default idle state
chosen at boot time. On AMD systems currently the default idle state
is HALT which has a higher exit latency compared to MWAIT.

The reason for this is 

1. Families prior to 10h didn't support MWAIT
2. Families 10h-15h supported MWAIT, but not MWAIT C1. Hence it was
   preferable to use HALT as the default state on these systems.

However, AMD Family 17h onwards supports MWAIT as well as MWAIT
C1. And it is preferable to use MWAIT as the default idle state on
these systems, as it has lower exit latencies.

The below table represents the exit latency for HALT and MWAIT on AMD
Zen 3 system.
Exit latency is measured by issuing a wakeup (IPI) to other
CPU and measuring how many clock cycles it took to wakeup.
Each iteration measures 10K wakeups by pinning source and
destination.

HALT:

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

Below is another result for context_switch2 micro-benchmark,
which brings out the impact of improved wakeup latency through
increased context-switches per second.

Link: https://ozlabs.org/~anton/junkcode/context_switch2.c

with HALT:
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

Here we enable MWAIT instruction as the default idle call for AMD
Zen processors which support MWAIT. We retain the existing behaviour
for older processors which depend on HALT.

This patchset restores the decision tree that was present in the kernel
earlier due to Thomas Gleixner's patch:
commit 09fd4b4ef5bc ("x86: use cpuid to check MWAIT support for C1")

NOTE: This change only impacts the default idle behaviour in the
absence of cpuidle driver. If the cpuidle driver is present, it
controls the processor idle behaviour.

Fixes: commit b253149b843f ("sched/idle/x86: Restore mwait_idle() to fix boot hangs, to improve power savings and to improve performance")

Changelog:
v2:
- Remove vendor checks, fix idle=nomwait condition, fix documentation

Wyes Karny (3):
  x86: Use HALT in default_idle when idle=nomwait cmdline arg is passed
  x86: Remove vendor checks from prefer_mwait_c1_over_halt
  x86: Fix comment for X86_FEATURE_ZEN

 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/include/asm/mwait.h       |  1 +
 arch/x86/kernel/process.c          | 39 ++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.27.0

