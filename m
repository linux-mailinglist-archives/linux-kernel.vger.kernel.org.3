Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538DB51162E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiD0LfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiD0LfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:35:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A46E396A0;
        Wed, 27 Apr 2022 04:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG96/LfDI7mbGl7+Ecb2ninsznChCx9PdBiyPTWFcmH5ia/YXgj5VgxyvMsJOVEU4vL8wIH0KkMOFdET37jpImJAB7cnsW/jTh/n2lT2v+wSQwfud3nJWZM0dtUFcil96n4x5tclt+v21HSR8BmYj0s3H1y+MvUUpL4+34nukBk0L9xzYQxL3ZlBXOQrGdSfJlECysXkj15m3VFa6JdNt8hIW42GT0HU7MlTXDtWZff1TaowxhMbAuyoJp54yBTK+Y/BMHGv+eULrl0oTOQPLId+GxnuSi/OYU6tuK76mnHBapPB+dRJ0ltiSsnlf7VBsCToIoFeJfEweOMRhInkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHgHuNTX+j/MbtvXkiPUktKJGgseCAq8jQgmd5QGXN4=;
 b=Lp80rPkUuGNOToLvcQbQjBiI4UWemrtP/GwWUgWqq+Br6KnSNNlfawo1dOHpvmiosQptbyXs6D2FPT4W2Burx3bJ8jE0DxTF4z6bKNrl/JtnKFqr53sxfvtznEhkBhQZ34GcSAfdoQ2AgE1bM55UVVUFxRQriI2ZMgg+Vls4Q8tW7EyW/pSX6C+E5xBBpofqXPA6VJrFJNxagyVkPG3XRLSl0P/ebrKKHBZbSy8ACKwdxQwWtv+cKoEODRyIA3piFOlyyRIG+YnQGgLpBEwPYgdSgVGfcn6GcYmteVTS3YOODq/F9GEDrZrqpn8bSZKnlLDKJ4EYV70fJZXeEQKirg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHgHuNTX+j/MbtvXkiPUktKJGgseCAq8jQgmd5QGXN4=;
 b=L0tEbkRbhJYYgFlq34WnsRJ2FxCm6Ks3feiTfjYf9JmaTPMKw6i27TCULQSx0dkl2RmN7XKhFG2OrGQMYR9VpdmmPiBsnoDa4RxuyzR3r/UupxBV6+uQ0LKjXiC4Kea00IMDgOBACxmu6PgaK+1Hr0xOvuTd3TxEWyFHWDXeVWI=
Received: from DS7PR03CA0153.namprd03.prod.outlook.com (2603:10b6:5:3b2::8) by
 SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Wed, 27 Apr 2022 11:32:04 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::99) by DS7PR03CA0153.outlook.office365.com
 (2603:10b6:5:3b2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 11:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:32:04 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:31:57 -0500
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
Subject: [PATCH v4 0/7] perf/x86/amd/core: Add AMD PerfMonV2 support
Date:   Wed, 27 Apr 2022 17:01:42 +0530
Message-ID: <cover.1651058600.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c63308a-e584-44fa-1e47-08da28418dfc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4575D0F56E466F80924FCC728BFA9@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuSXKsmioLSBFkjVKb4n1RfllRlaDii5oq/BQDiw918eAmcqcqQlcjz9ylRach4GhO9pOqbKABQvw21gpUB5aN8FkIOzETNsUbRgupMMvmfLLoyBkYzG1+tzwsdn9/4T/sSSQ/J2qYlmRhKVwHhycAnvNuLBQJro0RIKiXuAnE7tMns9lwQQI/95XHhPUKIb9neW9DFQTEFCSc75VYHyBEZtnxj9DchzulCfYJfFizejcTD4QPsa0Cv9XOjoV2mx9nLp8ANfrj/YYwpRRjmE/ZiZ/nkCWDF5WkUhiP+oPcM7hpptMJbX7YPxLm2qG6It4NY8vJwhGuf9LiPV4XN9cyofL/vV9KRWAiSzR76zpwR0BYfnNgeVFmnAlJwLnhteCIl5g44TMTE8y+TMSq+6K8FQ+ru0/WteFsbh2Qf0mDhncpEg5lxZ9mB5ZP91zJFwjOLGUDmv9heVoUzLqP3uR3hwhf4HlWSlNau4mwLLI/dI1nDDnkAnGn4mFO1+tshZZ1s6ymMonBtsQu3pbckUOyL37kePTTNqJBMFzQmY4dF4owfbSiu33rJUW2464wSZMfqauH80whiIMkkHlWCXufvjOHZCmT0IwlHOqnvTgMhDW+fcHZyNXrvdrf7ROHNqJwcWjWDWWe5jT43vEqZdw31juk8nqTc/4myu3QwKgy2/X4M7+DXtWRuaG5tqX1NoqCCLLRNBXIiN1y7xD3RwnNXH6vfcIGsIQowWAuxbmS7UZhruTThyquaBh6FQEd7eQMjUYIqfUpgdeo6J4uHt9ySYOp7jGUK6NOwEpp9Sjton+P+gaZKXFBwzCchg1fAgnNhkdvtb0+jcK4DatJZKQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(8676002)(83380400001)(16526019)(82310400005)(186003)(426003)(336012)(356005)(36756003)(36860700001)(40460700003)(110136005)(54906003)(8936002)(70206006)(316002)(26005)(7416002)(5660300002)(70586007)(6666004)(2616005)(81166007)(4326008)(966005)(508600001)(2906002)(86362001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:32:04.5348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c63308a-e584-44fa-1e47-08da28418dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using AMD Performance Monitoring Version 2
(PerfMonV2) features on upcoming processors. New CPU features
are introduced for PerfMonV2 detection. New MSR definitions
are added to make use of an alternative PMC management scheme
based on the new PMC global control and status registers.

The global control register provides the ability to start and
stop multiple PMCs at the same time. This makes it possible
to enable or disable all counters with a single MSR write
instead of writing to the individual PMC control registers
iteratively under x86_pmu_{enable,disable}(). The effects
can be seen when counting the same events across multiple
PMCs.

E.g.

  $ sudo perf stat -e "{cycles,instructions,cycles,instructions}" sleep 1

Before:

   Performance counter stats for 'sleep 1':
  
             1013281      cycles
             1452859      instructions              #    1.43  insn per cycle
             1023462      cycles
             1461724      instructions              #    1.43  insn per cycle

         1.001644276 seconds time elapsed
  
         0.001948000 seconds user
         0.000000000 seconds sys

After:

   Performance counter stats for 'sleep 1':
  
              999165      cycles
             1440456      instructions              #    1.44  insn per cycle
              999165      cycles
             1440456      instructions              #    1.44  insn per cycle
  
         1.001879504 seconds time elapsed
  
         0.001817000 seconds user
         0.000000000 seconds sys

No additional failures are seen upon running the following:
  * perf built-in test suite
  * perf_event_tests suite
  * rr test suite

Previous versions can be found at:
v3: https://lore.kernel.org/all/cover.1650977962.git.sandipan.das@amd.com/
v2: https://lore.kernel.org/all/cover.1650515382.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/cover.1647498015.git.sandipan.das@amd.com/

Changes in v4:
- Use ARCH_PERFMON feature bit instead of vendor info to determine the
  availability of CPUID leaf 0xA.

Changes in v3:
- Remove unused parameter from amd_pmu_cpu_reset().
- Add Hygon as a vendor that does not support CPUID leaf 0xA.

Changes in v2:
- Sort PerfCntrGlobal* register definitions based on MSR index.
- Use wrmsrl() in cpu_{starting,dead}().
- Add enum to extract bitfields from CPUID leaf 0x80000022.
- Remove static calls for counter management functions.
- Stop counters before inspecting overflow status in NMI handler.
- Save and restore PMU enabled state in NMI handler.
- Remove unused variable in NMI handler.
- Remove redundant write to APIC_LVTPC in NMI handler.
- Add comment on APIC_LVTPC mask bit behaviour during counter overflow.

Sandipan Das (7):
  x86/cpufeatures: Add PerfMonV2 feature bit
  x86/msr: Add PerfCntrGlobal* registers
  perf/x86/amd/core: Detect PerfMonV2 support
  perf/x86/amd/core: Detect available counters
  perf/x86/amd/core: Add PerfMonV2 counter control
  perf/x86/amd/core: Add PerfMonV2 overflow handling
  kvm: x86/cpuid: Fix CPUID leaf 0xA

 arch/x86/events/amd/core.c         | 227 +++++++++++++++++++++++++++--
 arch/x86/include/asm/cpufeatures.h |   2 +-
 arch/x86/include/asm/msr-index.h   |   5 +
 arch/x86/include/asm/perf_event.h  |  17 +++
 arch/x86/kernel/cpu/scattered.c    |   1 +
 arch/x86/kvm/cpuid.c               |   5 +
 6 files changed, 240 insertions(+), 17 deletions(-)

-- 
2.34.1

