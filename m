Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC2521204
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiEJKWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiEJKWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:22:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732925559E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbAdlaUMHyFeEnwLPnsP7OyQNzI/x23TqNhDzN1ic7Srd9AVwP/tN8frIX525odqKai/Km/MMnbXXyEJFZRYJxuBquUBNPw7ERuHifYNvM94hsDciGYg7Jy717vDtYFBYamNeFALVJjGc3Q8ochYxCjuArczkSo4Wkd4b7+y2OfA5z7OdblKPt/jrlrduBWxeOg8E+Y19LQtn1jbHnJoNbBWn9QU7PrskfXLHuUtIKeyZsjCcDppXJosnD72zZlF0hLN2l7hE55GtRRvhjGUHrX6snaQdTC0K/1ladIaxL2lc0lho2+yNsCIuDLi15Ius2rzF2xuqL5ORelDjh30fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oh4Oey/TO0T7x4cNdA1XlnYgdcCZHiGFyLBjYu+4QE=;
 b=Cj3xaHLlYv0AjykqtR5P47ITi6V5NNZCCRBBMbIojPRwqOsR75mzE8vAB/uv+Sf/UJrOijcLDilHhi1M55vkl30Dr0a/CfXactdO+Dr1N5AbjQ3laXGqXYsGUZ8wq4VMFQWDk/TB6y/KBoc1OrrJqbpD6W0TMXD6UAo2TOlE169WXCoZ/Au9u/kNwPtbR41Kq4fhFXGYucd6A/ZENKQW/YFPYZMw1n4gUwsnHMJ2t4QGkk21RJxqSNQ/0JGiKhCE/pysuday7Uby02RknJjIZ+fkmoyBJA7my5+c9jk7de8+m7gSnPRfNNvSNIDvOmg2xPnP2QP9qSMfAU79j6yCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oh4Oey/TO0T7x4cNdA1XlnYgdcCZHiGFyLBjYu+4QE=;
 b=gMHpqtoY2SuIv3wds92JP94iRt4s3YHFxJ6roJDYqx/kr0c4IT0WJSyROhRKcvUrf43DsFO/7uOJHU0aNdU5o/SFOrHC6KsyxYQQ3R95Z90tpA21FNQ3+XPIqVeUCfAwLLj2ur5z3kqcGMD1dCII+vkIyJ0XYPmyYm4tCAC0bpE=
Received: from DM6PR18CA0018.namprd18.prod.outlook.com (2603:10b6:5:15b::31)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 10:18:29 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::6e) by DM6PR18CA0018.outlook.office365.com
 (2603:10b6:5:15b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 10:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 10:18:29 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 05:18:22 -0500
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
Subject: [PATCH v3 0/3] x86: Prefer MWAIT over HLT on AMD processors
Date:   Tue, 10 May 2022 15:48:05 +0530
Message-ID: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b675e062-3590-4110-1fdc-08da326e6dc7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4370:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4370E5D83A8743F022E9047784C99@DM6PR12MB4370.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iv5aO1B7PtKQ4E907PBcHrg/Ive5YtQe2B0RoBPzOOzOpcjnV0bfdH3HaVjxaWf6eRY3LUi7Fg3wdAFewP97i8jwhtJ4VoiJcVtgD+kFTcUlHuECaGGVMDMxmNW6nZgbci44kN5R74nfbGKFa6s1Zo9YKMihsZRd6lXvY99sULHLe0/5CaxkyZbgGCs1kFHGXqLE+Mhu4lJ8167a9FBhtIKAuWzYsa3BkB/v7hLoJnnAzVkxqh2w2btgKldMBYEbBtkT9SuIr5PX8LBqU4bfC+8VenOLVf+E+GugEtAwyTaHhMySdUVksyy5pI/Dq6zxqLQ7xjPo3QCz4s2f7UCWxJWfs0NwMTzyARHk2ktd1Pw5mXgjUlGCse7WS87QkRxglf4bPV3DPab8enNvVK/hQ6sJav2TUUH/IFJQht+hajNGcfvtlA04ixWPuJI0SG2CmeHlGNIGQOoQ+VtaMDm99L8vCg5oC1kEjXpTP92lWPZ8S8MMndnOFwP1dJdcFC6SP7D7EEhyyIdBybVO7Nx0xFOa1FsrC2ux1SLzC5r5+1ws4egOSJa6hMNKuLLXwoyG/7JvYviI8DGO/+UsJbWmAI8iLENXHkyXwtRReA9h7GMRQCPwOJYDZnu7Qc+Lxzpfzdby5P5ci4lV4nq7CMa+5JgzUQwrPU/h2L2Invs3dVH+z4yFYJLQC5NZ9mT/d+Y2SddpBeYC/U6veZf7xxIvSUP+xlF4S+w0A9kh12TcDS7DaWgpSAsSuHLBBpCj8lkhOJUM8D3bG++wIe0puhk2/oReyRYFvM1x9f4ZbXFQglvdHtRW+qykpeTEERG1orNgn3XGrcuLkOEPI0F0i0Y29A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(2616005)(86362001)(356005)(5660300002)(36756003)(83380400001)(8936002)(7416002)(316002)(70206006)(47076005)(966005)(44832011)(508600001)(6666004)(26005)(70586007)(426003)(4326008)(54906003)(8676002)(336012)(6916009)(81166007)(40460700003)(16526019)(2906002)(186003)(7696005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 10:18:29.4966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b675e062-3590-4110-1fdc-08da326e6dc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a version 3 of the patchset to "Prefer MWAIT over HLT on AMD
processors"

The previous versions are
v2: https://lore.kernel.org/lkml/20220505104856.452311-1-wyes.karny@amd.com/
v1: https://lore.kernel.org/lkml/20220405130021.557880-1-wyes.karny@amd.com/

The change between v2 --> v3 is
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
v3:
- Update documentation around idle=nomwait
- Remove unnecessary CPUID check from prefer_mwait_c1_over_halt function
v2:
- Remove vendor checks, fix idle=nomwait condition, fix documentation

Wyes Karny (3):
  x86: Use HLT in default_idle when idle=nomwait cmdline arg is passed
  x86: Remove vendor checks from prefer_mwait_c1_over_halt
  x86: Fix comment for X86_FEATURE_ZEN

 Documentation/admin-guide/pm/cpuidle.rst | 15 ++++++----
 arch/x86/include/asm/cpufeatures.h       |  2 +-
 arch/x86/include/asm/mwait.h             |  1 +-
 arch/x86/kernel/process.c                | 39 ++++++++++++++++++-------
 4 files changed, 40 insertions(+), 17 deletions(-)

base-commit: d70522fc541224b8351ac26f4765f2c6268f8d72
-- 
git-series 0.9.1
