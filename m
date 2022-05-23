Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FEB53081E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355545AbiEWDkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiEWDkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:40:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9092A10ED;
        Sun, 22 May 2022 20:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLN2ZUta0wp/qLpO4laAC1eU8CTmKvncVKdbJslVluOLr+vEhMAiuDHa/2l4PjDRvFh2kCjGu+TBQqyF0qpu8LG9eVGOwpQc2Zp1af9MzivQ8oYl5Dbi8wNMHNx3dy7lteayr7vPMOVN/iy5lzBX8uYySHSow+XCg3T/vEZJkzqKlGeRxcXMvpZuKaA+uy+KWcjPvqUbenW7TB6HBwSx2tAr4cjzkkbdLnYn9fCfjVs7pu7RZujZ5/DjM2a+u0guSmM+L20jdOCF0aT6tlPlatZcUSRmVgLh69IzsZ2rUGI2Z2VOTR9ELUbP80NNCwkd6/gOqw4aFth6XIPk+Z0/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEltbGBQq5eql1f69jbAprc+Kxyhm3G2zdy8Clsc2f4=;
 b=IBlPFuZoahu3swHwj1CCT/ynoDkP4U3aU3t0BmvIQuXkDtWk4sjrxZFG3pO4zLDi6p62tuJ6vq8Je/7ppNYKc3Lr2lPypaD1spFBnSGcfWwDVc0ul9EAcchYLYwRW3lFI0PyCFGQq6l0CJmGAvQpmbgH/vczKqUlERZHwUy9ILhJmibhFEVUBbKjrk7/7zyXK69USFcAMewUP+I9zn5XbqWpjg8XnMjzACR/NX0Gm9trJqeCF9C9NfODsRSA2JULH3C75tss075MYY4NQIU/8Kfn6VHq2LANj0A7Tsk2RsAEaAyrw9kYuge8pVchLurp5fXM/Leb09Qin0RgubbZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEltbGBQq5eql1f69jbAprc+Kxyhm3G2zdy8Clsc2f4=;
 b=F5ktStgAw2NhIkRz/qsoi0r5E1jhakYonvfL7Kc5dwO9N6Wt43ZLZz522O4iIkUuy8syjNyhnzqptdkRKudYLQooHhpOMSr+7jPAfHsPTc4kGM4hwb8Gw3v1YrJe2ep/ezwXOD+kB658Uxb95YjabNaWRDEnw7hu91T40nUqsEc=
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 03:40:12 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::27) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Mon, 23 May 2022 03:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 03:40:12 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 22:40:00 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 0/5] perf/amd: Zen4 IBS extensions support (tool changes)
Date:   Mon, 23 May 2022 09:09:40 +0530
Message-ID: <20220523033945.1612-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe475acc-c7e2-4297-337f-08da3c6df15d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3435:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB343567BF1E24976727E437F7E0D49@DM6PR12MB3435.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1tWJ629Id73Qe1PN03Gw52gL2AgAnIhImwtD9R8FiCk/1n2tieYjeyZAlyXP5i3Y38cjHZ7DqbMNwwLb7io9mZAzA8qvkGFzSYR/nI3GTdctmhiswxpX7zmK3vNesr0GYOnKYEMnUjp8xm1HBMsujietH5Dv8+atFFJtG4bijFf+za+dI0LVbCmESFhIHjfrxo2aek2CPGVpKfiB2edzXhJsXm6tvyHJjAzzJC4urwqAwwYAOqHJiluBUJMEaJoGsnjq5H+x7X+BdUQNsVUaR+tkydgpGHJjaSL49jJFuaG6t6oyg+xqxgt6bYOCD9wTBKcQ/SDfDBWqoX+kKnlZOR9Be2ndiJRvDT+izXSXNUuEtqNJuRIwjPJ4JAFt3RRwV9juPHBZvnugnYKt5p2gh+JBbfTHwKpdwLte/UJ6bDym37wiIc22dE3q1dQp9zzPG0LPjGYu3h3IytnKi/N2xpz3yeN1PPe6+3x0xWxL3+8lqOWOKz4oLNiP/bgi1UWLhKSaE1dTzL27RXZxLwYdRk9sJtBd/dFaMrNKd5ayKn8O316iE8zD+p50RzXBj9VF4tcL0XXntnADmnMRGQKk/Z60p2lOV9N5+n8WsO1xlIz/Oj0f8WTRHhpOpuopOm9HKA1avMJsu7zVdDAJbjWTzMLkhRWm3XwTrK2s1dGVdKGsuw0AoArQxthvlAQNMxezoe9K7ethDXuNkKXye+lHCex74sFQFp3+AhmE1OTrS371NMCTBT9o9uS7ZeCRaxhk+D7FLdLw5XN9eHoHLd8M9UrpQlyz9Y/CJQMz6275GKsZvoeD49A7LpcBGSSgeVPFUa8gIQksYm64IlyiFyN1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(7416002)(5660300002)(44832011)(2616005)(4326008)(86362001)(16526019)(508600001)(186003)(36756003)(8936002)(40460700003)(47076005)(426003)(6916009)(54906003)(316002)(26005)(336012)(83380400001)(2906002)(36860700001)(82310400005)(6666004)(356005)(7696005)(70586007)(70206006)(1076003)(966005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 03:40:12.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe475acc-c7e2-4297-337f-08da3c6df15d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel side of changes have already been applied to tip/perf/core.
This series contains only perf tool changes.

v3: https://lore.kernel.org/lkml/20220519054355.477-1-ravi.bangoria@amd.com
v3->v4:
 - Pmu name won't repeat for different core types on heterogeneous
   systems. Remove core_type field from HEADER_PMU_CAPS.
 - Include rational to change code besides header sync in patch #4
   description.
 - Add Acked-by Ian Rogers (patch #1 and #3).

Original cover letter:

IBS support has been enhanced with two new features in upcoming uarch:
1. DataSrc extension and 2. L3 Miss Filtering capability. Both are
indicated by CPUID_Fn8000001B_EAX bit 11.

DataSrc extension provides additional data source details for tagged
load/store operations. Add support for these new bits in perf report/
script raw-dump.

IBS L3 miss filtering works by tagging an instruction on IBS counter
overflow and generating an NMI if the tagged instruction causes an L3
miss. Samples without an L3 miss are discarded and counter is reset
with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
This helps in reducing sampling overhead when user is interested only
in such samples. One of the use case of such filtered samples is to
feed data to page-migration daemon in tiered memory systems.

Add support for L3 miss filtering in IBS driver via new pmu attribute
"l3missonly". Example usage:

  # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5
  # perf report -D

Some important points to keep in mind while using L3 miss filtering:
1. Hw internally reset sampling period when tagged instruction does
   not cause L3 miss. But there is no way to reconstruct aggregated
   sampling period when this happens.
2. L3 miss is not the actual event being counted. Rather, IBS will
   count fetch, cycles or uOps depending on the configuration. Thus
   sampling period have no direct connection to L3 misses.

1st causes sampling period skew. Thus, I've added warning message at
perf record:

  # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
  WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
  and tagged operation does not cause L3 Miss. This causes sampling period skew.

User can configure smaller sampling period to get more samples while
using l3missonly.

Ravi Bangoria (5):
  perf record ibs: Warn about sampling period skew
  perf header: Parse non-cpu pmu capabilities
  perf/x86/ibs: Add new IBS register bits into header
  perf tool ibs: Sync amd ibs header file
  perf script ibs: Support new IBS bits in raw trace dump

 arch/x86/include/asm/amd-ibs.h                |  16 +-
 tools/arch/x86/include/asm/amd-ibs.h          |  16 +-
 .../Documentation/perf.data-file-format.txt   |  17 ++
 tools/perf/arch/x86/util/evsel.c              |  50 +++++
 tools/perf/util/amd-sample-raw.c              |  68 ++++++-
 tools/perf/util/env.c                         |  47 +++++
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/evsel.c                       |   7 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 185 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 13 files changed, 411 insertions(+), 24 deletions(-)

-- 
2.31.1

