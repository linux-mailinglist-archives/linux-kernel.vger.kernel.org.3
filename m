Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F5C53D58D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350487AbiFDEqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiFDEqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:46:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEC4BE3B;
        Fri,  3 Jun 2022 21:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReSGZq5pAQ/vqSBChOqFGrMhru4dfbZGdgmAj8Veh/fzqsNtZtSstQbbN3AwR9YZ6HreZhPv6jThuJmIF0XpCztpD+s+7fdhpSfx2rUrreLOKmt1Wjhb8C31LAaMMv8q1+nwzDVeGxCjavsoVGK2Y1EU/Gr1iCXlPj4uTrtG6UdhlsOztamv9O5SiSKT/xVkifzwGGOuixZvUKbIH0aEkjuZe2uDHF5IJszQRzzJIoRp1SqMTCvGF66l3kp37bV510/k2obJuwTU322Hyyno+H3O8TVjB3qia/Fb8tBziY1pEgdQ6kiDYjRWbHvbyezcQJQOZ7vOce3NEgaztMRfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srMDc+dKow7PNxTmsa1YV1hkIhChV6OR4bt/XKJaFWo=;
 b=NfObsMUd0twoEkIuUVb/adjIDtN/PtE/VttuKrXnI1LvkEgIA7A03DLrfO4IhrlJMVTG/e/g7XEWGhEKsBAsABtCslb/dM+2N9sdmJzhSUVFM7hGLr8Fnqhs/SGwVz9NjelrQ2z29ph6MHdxanewML7Gve9GBAR/c3/6BEhHCZtHhndZiBmDpkqQ8PiPv+lgjgKa+mjHBKJLflCzAIqy7hvt00lRjut+SeLCS6DUo/FEDQ+jEmCFHq8euAp7eHLOm1IVXH7+EM7AojsMrO7EosY8jSMKf6bnnI63hgbavkXTPJZP2fyDt8C4rkQQ5nHqi6lu309v9Q17gQesFy8fiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srMDc+dKow7PNxTmsa1YV1hkIhChV6OR4bt/XKJaFWo=;
 b=FzjRLUVEVR7JQxrNVblLwoBhDm2QMHZXIF+8uoOBNfohAWChNW6xcUoyoKa7CVC+NQJeT61FbHEcGeOJReLsKRh+09vvAOG1Pr24P+DARUrA74DbSh+Y5+q9PfOPUda6r5Emjm2N9wxHq9zwd5gXK8zJWce23looNFiwXi/0kcI=
Received: from BN6PR13CA0055.namprd13.prod.outlook.com (2603:10b6:404:11::17)
 by MN2PR12MB3360.namprd12.prod.outlook.com (2603:10b6:208:c7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 4 Jun
 2022 04:46:25 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::94) by BN6PR13CA0055.outlook.office365.com
 (2603:10b6:404:11::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.5 via Frontend
 Transport; Sat, 4 Jun 2022 04:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:46:25 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:46:13 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <james.clark@arm.com>, <leo.yan@linaro.org>, <ak@linux.intel.com>,
        <eranian@google.com>, <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v6 0/8] perf/amd: Zen4 IBS extensions support (tool changes)
Date:   Sat, 4 Jun 2022 10:15:11 +0530
Message-ID: <20220604044519.594-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3721fade-3aff-4eb4-12f3-08da45e52e4f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3360CD76DF2595BF49D9A7D0E0A09@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfByS6wP7nTTfzpXjHvsSUB8UJRi2KUllpWies9hosnrOu/xDxgVwH+/Ggy6CWeEwKMan6uzv48MkI4TJ3as60zvPF6r7AH3nAw77JJm+LV6X8ygC1BdSQj5I6i0RxM1AbThzudcdxwlcCm+D8esDw3h6QhT8zpUcmdzf+MDZEHCjyFQUOY0KD7tzL+yrVoq6eUIeWMkzKUxOrb6wb0xyT2g4USbQIDz2bNE0uRPJQOJ3D3JlxpkC+7q8/VOG+0fV1TRJdndpPeqHiENSlMfpJtTEQZoBQ3TDwhieRypEneBQhR0z8JWkHfZZoQxB77OZPJm8ix8I7iLIE4NngApkRAcRMjWn9FFYNn+iM8M48kn5LWjFCXiCsaKV6ICe6wzC9o09kNHNw5FhMjYfzUnlvgQU8kEL8yPQqt4ArdqnieI30+pUApIIFms4tGv79iIG23F0Sv5IyIAsalcqcd9GJi487ysZXrLIPAfNgH/2B6QM1gkZqN80yFCSz/ySR4cxis7JtPitV19rspYO6jif3wGI613YYYS+7TCHjrP67nKarB2pZ5nMJbx8U7nQlgReOc5bTXMugQtowwboa7CwF3dhvf3PlyltJ71PYGQOGQPovd8QQcgpER3/PjywAS9XcGIfWijJ4MkJwUbNHZHhEPBeOZjGpzTfDWh2f4xN2LrCzqeLlJRKMs5vlHuo4AiN+2QNKeuUIhwuwrC8Zi3kOrEdOaHUB/d1NTOH725X8t5lnbvkLgUAXiz3kkNsGX3iX/Ip4mpJo+PoJVQHqWVX13HO07DibIqGSJ46qLWs0A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(81166007)(508600001)(82310400005)(8676002)(316002)(83380400001)(4326008)(40460700003)(47076005)(2906002)(186003)(336012)(2616005)(36756003)(16526019)(426003)(1076003)(86362001)(6916009)(5660300002)(70586007)(7416002)(36860700001)(966005)(26005)(8936002)(44832011)(70206006)(54906003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:46:25.2326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3721fade-3aff-4eb4-12f3-08da45e52e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel side of changes have already been applied to linus/master
(except amd-ibs.h header). This series contains perf tool changes.

v5: https://lore.kernel.org/lkml/20220601032608.1034-1-ravi.bangoria@amd.com
v5->v6:
 - Use macros instead of magic numbers for IBS l3missonly bits
 - Use asprintf() instead of allocating memory and copying data manually
 - Add Reviewed-by Kan Liang (patch 2-5). 

Patches prepared on acme/perf/core (9dde6cadb92b5)

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


Ravi Bangoria (8):
  perf record ibs: Warn about sampling period skew
  perf tool: Parse pmu caps sysfs only once
  perf headers: Pass "cpu" pmu name while printing caps
  perf headers: Store pmu caps in an array of strings
  perf headers: Record non-cpu pmu capabilities
  perf/x86/ibs: Add new IBS register bits into header
  perf tool ibs: Sync amd ibs header file
  perf script ibs: Support new IBS bits in raw trace dump

 arch/x86/include/asm/amd-ibs.h                |  16 +-
 tools/arch/x86/include/asm/amd-ibs.h          |  16 +-
 .../Documentation/perf.data-file-format.txt   |  10 +-
 tools/perf/arch/x86/util/evsel.c              |  52 +++++
 tools/perf/builtin-inject.c                   |   2 +-
 tools/perf/util/amd-sample-raw.c              |  68 ++++++-
 tools/perf/util/env.c                         |  62 +++++-
 tools/perf/util/env.h                         |  14 +-
 tools/perf/util/evsel.c                       |   7 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 189 ++++++++++--------
 tools/perf/util/header.h                      |   2 +-
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 14 files changed, 329 insertions(+), 127 deletions(-)

-- 
2.31.1

