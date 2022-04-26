Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C011850FE44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350573AbiDZNJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350645AbiDZNJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:09:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8ED111B;
        Tue, 26 Apr 2022 06:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wvw8Kc78gmk34kl0pPgLU/ElXJYPd3O2/ltYrO8vwHOoFCWJM3tv6zLamo4I7KNp/zSzxWv/LJN+RhlmUVUojzXtGlD85wrmLmn8fpB9J+fmas57Iy3slgpNAAO1cToTNjgj9VObja7xAKf0l7z0TT5VdQ+7zYtZou1WF7SbCMtljbW4aiTrunHTu6X8Kyf4SuZ/ow6OcA6kF3Lhg5uOOwsYk5Jhjriy/FjnEk8r8BdiXGoQF3OI+b+VDFkZhHfcJy/zHoOJTwGJCENqxHwlz9kNSVR0GsMOKMPVrozvw+JG9WMKcFJf4hw2bKST/ykLUBbPcjg/fKkJtvX5fk/JFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AWQITiyUj6dj21QdI/ZvFMxROVkn/D5pZbZgdKp4hE=;
 b=OocQdEAVj/UhKn4Z4hlo214dsT+PuqMKl7d0u5AiQuGDl7i35F4X/umhzFRGKLk5CA9GLCP9BmAUWtDZjSU+HWjsblFJoefcRjn1vIl9vBBeWXunUfZFR2AV+NtBJIWOrRM4i8Drd7wZpWCNlEhbmTN9JA6zuCZWJEyi7RPDOjFM9gOait6RtR70Y4rEUXqOVUwXfWwRfNQBHaf6OgZRlcZbR5KAg3pLT1EoBqzCvm3TivgyBzDNbB9Gyiv5++X+bjq6cHt24FLLmcmtuhbxkZ1gnBE1tvlQvHRObtrf/Iq7Z3xfOTRPFq8L1DpY38UST4LgkJHL6OnybJAoNhM0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AWQITiyUj6dj21QdI/ZvFMxROVkn/D5pZbZgdKp4hE=;
 b=Vmu/ESgKHFpRUAEz4KAUZPQEpXDAWs7P+WMAIVMhcc4/PuPa7Nd6oAD/pLrzSYhqvfyX/9tuTt/Dyhqbe190Pi98eIKFYFkjmKakY8PQ5LDZ3K62xjM0AuPL9sbnQp0TAb2Le2umxTYL3xCjNQ808EgKgv2PqqlYUAtlQRZPPpE=
Received: from MW2PR2101CA0016.namprd21.prod.outlook.com (2603:10b6:302:1::29)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 13:05:53 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::10) by MW2PR2101CA0016.outlook.office365.com
 (2603:10b6:302:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.4 via Frontend
 Transport; Tue, 26 Apr 2022 13:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:05:53 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:05:46 -0500
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
Subject: [PATCH v3 0/7] perf/x86/amd/core: Add AMD PerfMonV2 support
Date:   Tue, 26 Apr 2022 18:35:31 +0530
Message-ID: <cover.1650977962.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62b3d468-6d26-46dc-b12b-08da27857eab
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2550:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB255021B5029D5C56EE1610FF8BFB9@CY4PR1201MB2550.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfdQbzuzoxAMj7ffELBq57P09hvz0GPLwoFEFhvWMTpegonbPKvFQpGh2VxniBTwXITID34vDS6VFxpca0Gy5CHyFmHDpadw1xNHZOLtN9IRsXJ19m6fDhQ1ItSQ2dCRGAyDl2RdX0/8Owgr9Bbi/al/E4TF7ekAkcDZrT8KjkPIajjqvRt+nxzuCNM/G9eGsSkwlrFXvqbXAia6TsigJoYEKW7kHg4Go14vqu4Jh4jOpArFqf2O14QgcONw4XStf9TsjSWRSYW2IwgLZs5Gj/S1KuWF93acNX6xgevUqXEW8uP2jHfyQHhw93fQfeS/2nSL1svgvEvaCM6guthLAjLrcRT/ABTiwOl+WJYyvr8L6XFc0sQMs9lEMqaTsVrRH0vGiKIu120AUia5vWk90xdrfhAoKlI2CTOQcM2ZnpNapqOVX1J24WGYbyE9TO14wOPQkbH6uUBUSchsp3twqSl7mc4pFRRWYXjIB2el6KOrj/8bt54RjlGamrOCrcxcfKgYom5Tx6CNOvW/4VRq+Fv5zYOAnTSGli9tPFTtkwPVaNqYoi36PHKyLiWgK+biTrgCDNlZj67oy5qu3kfJ5zde5Qu/WvWOGbWiAtzARQZ+GqtTTXLIl8A0VeOGgBdD58y8dE/BZH+5avLPW9RE9iqIiIMue7fy0njwkheJL6lTZHpVWpJa1FFZjqME+C01SaYNxLtXB5kIZHKxL6F9AeXVSJs677TR6sz9P4cv1MJ1xiRud7JU0i2+3kqTkY7pNI7coMoY5x5aPE1xTouovdSdzfkA5BAE1xIZY7PHYsNCn0sQ+pkV4IusKHbi5Sra7iDQwewPMt9rnB026jLWUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(426003)(16526019)(26005)(186003)(54906003)(110136005)(336012)(81166007)(82310400005)(36756003)(966005)(508600001)(36860700001)(2616005)(5660300002)(86362001)(316002)(2906002)(7416002)(6666004)(356005)(83380400001)(47076005)(8676002)(70586007)(4326008)(8936002)(44832011)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:05:53.3786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b3d468-6d26-46dc-b12b-08da27857eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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
v2: https://lore.kernel.org/all/cover.1650515382.git.sandipan.das@amd.com/
v1: https://lore.kernel.org/all/cover.1647498015.git.sandipan.das@amd.com/

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
 arch/x86/kvm/cpuid.c               |   6 +
 6 files changed, 241 insertions(+), 17 deletions(-)

-- 
2.34.1

