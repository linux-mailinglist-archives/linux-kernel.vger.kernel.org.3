Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268E1539BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349389AbiFAD1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349282AbiFAD11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:27:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DBF18357;
        Tue, 31 May 2022 20:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYWWQ7OAiOx2U0zpJroaVZBm19r+l5J+LoK1AAGAj3IIQkJlpEB+CGzVwrgOZ8fzeD4XIUfAaKIs1oGm5HQZDhLvUG1JS19CL13cp7BmL3oSXUFqmUEi9n6t3oduI59+Qwe/fLGtM3+h51T9u5bnviFL4qxoRJdtJDHnObhJHc9DGXLTzqoQFHFLIfKj6smQvXBYbv0WrGy2TspiXfn3/wrV/zA94EyJaMgamqfhHCZBa5yADvjWF9FgqEHmVNptgb2aRbcwxa2VM34kCU9j8Na1QltAuA3Qm22dNC3vcKNpr/VdhPAsIELEtfv5FGI0dGdoZ5fncu0OHz6ldzPimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f56CMUK4kLFgYhuLr0YFeBHc7/TBRNgpo9vOFqnLtYc=;
 b=F4U4yjigq8xTfQSD4QPdNiKxMfKR73ZVrHAOo/pEnfD/1JJ/M8g64Uf+v9wD0lCjWYMJdRtEjbNMDB6Ooh+4oNtWhBGrqbXqLEiNISiDJ/Zl4XMuvLHk5Zvpi9LIcsUpUyvrFI49fzu1roP/lGzaWUbtmMysBAL4crxQHC+7Y/M9JRdIx/soqI32IZJkVFs9NKjxfe7MZyx9E+P9vz8BchEFkylReFOHJNGp3ZvTWh9RvN7zwWFQ3NrXIDWVkdtz4sRW4eKj/YxQMfyY+vMrJbHclc0PK+Cu8CK18DC3PpiodRwkDBjQTSqvuW35lQ5BiWnBV1theRpDjgYef/tZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f56CMUK4kLFgYhuLr0YFeBHc7/TBRNgpo9vOFqnLtYc=;
 b=RHX556LtbuaPtCpqhQvAHQ4dOBXLiRoiTu4rnf/BvNymceagTFyPqYyFxKoeWcWdSVhA8qFCYf24lMFPs4BFkGhyDVCrg/J4r4XU+SUTArYMTi3ne3j0vGhaR3cbmUqD9AnUYhPbMnu16xNkK0Ed0fB83gZmcBizWzunCuDYApA=
Received: from MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::27)
 by MN2PR12MB3453.namprd12.prod.outlook.com (2603:10b6:208:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 03:27:22 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::89) by MW4P222CA0022.outlook.office365.com
 (2603:10b6:303:114::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 03:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:27:22 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:26:59 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <kan.liang@linux.intel.com>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v5 0/8] perf/amd: Zen4 IBS extensions support (tool changes)
Date:   Wed, 1 Jun 2022 08:56:00 +0530
Message-ID: <20220601032608.1034-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe37c81-d1d2-42b2-4bce-08da437ea43d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3453:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3453F28403DE5AEE02638995E0DF9@MN2PR12MB3453.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uSvZWrJcZzj5h7S400d2A/hQPPeoS/mJBcyK4Rg1HZRKMljWZJKFI2ln1aXpPWTbwBYF2mcK70VHJhlESTZ7VZeFTBVHdUbjRZY4+MoMYYJyBweY55qcAAVOr73eUH0eYvL8xTB42Bay4Y8gcLpVKvaVK2b7h8ut6rDzc3S2UK8s7mxS8edfAgjmic0k7wmpYGZcOIKshK9OBXOmSQ/gtXQN7Xg/4qnrHGbzjVzEpgvBOafD9Ij5+XzQX+473jxFoJ/lK1DtmWy0LFsq583VDDv4aW9dZiQaRZDVmH43SPWQdngmtRpRXOIbXjNxfsV73Vi2I0t3iaMXkv556ydk4dwTXe8ZNG0ICO8HO3Du0rJ9jgsLgH2Fv8ETff9NUu9eUO+m6d1WYXYZxOXwzu4eBU8r3sZkGFldJY91U8qBRgMBJ69PsgbGse+ilvcb7xu4TsCpGcZ/IkzVyhv02r2R7FaC2Uxtr6ZuvjVpt9XryJfneOdgxoRBLLfhfIGF2sgTskQXxKO5AV6owg6yP37rLoJBiqqxxOew6wcoME46gf+46ROeGfVPiqOCa3uB7B6qp91q/UyElmtn1f4nyFYgIuI79FJLc2Yr2vDqm4t5XJZEsjmOPQdk9eFvEItZXh5fHuKKGWsUJkvlBr20RpIEwj4fjvsTg/bo9QBYcSzHG6WY8wsNl8rgc/3dIw/DFbHedi8HORcCFUBe+YimH0aSfF60i2i9+3opRFFitJdW0lLXo5C8gncn469rtkT6pVSIxW6xnlz/UdaNxceVewtnScRwkVMESl6F3TX6zkUM3U0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(54906003)(44832011)(316002)(36860700001)(82310400005)(7696005)(6666004)(8936002)(70206006)(966005)(70586007)(2616005)(4326008)(86362001)(1076003)(336012)(8676002)(426003)(47076005)(26005)(16526019)(2906002)(356005)(508600001)(5660300002)(110136005)(40460700003)(83380400001)(186003)(36756003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:27:22.4892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe37c81-d1d2-42b2-4bce-08da437ea43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
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

Kernel side of changes have already been applied to linus/master
(except amd-ibs.h header). This series contains perf tool changes.

Kan, I don't have any machine with heterogeneou cpus. It would be
helpful if you can check HEADER_PMU_CAPS on Intel ADL machine.

v4: https://lore.kernel.org/lkml/20220523033945.1612-1-ravi.bangoria@amd.com
v4->v5:
 - Replace HEADER_HYBRID_CPU_PMU_CAPS with HEADER_PMU_CAPS instead of
   adding new header HEADER_PMU_CAPS. Special care is taken by writing
   hybrid cpu pmu caps first in the header to make sure old perf tool
   does not break.
 - Store HEADER_CPU_PMU_CAPS capabilities in an array instead of single
   string separated by NULL.
 - Include "cpu" pmu while searching for capabilities in perf_env.
 - Rebase on acme/perf/core (9dde6cadb92b5)

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
 tools/perf/arch/x86/util/evsel.c              |  49 +++++
 tools/perf/builtin-inject.c                   |   2 +-
 tools/perf/util/amd-sample-raw.c              |  68 +++++-
 tools/perf/util/env.c                         |  62 +++++-
 tools/perf/util/env.h                         |  14 +-
 tools/perf/util/evsel.c                       |   7 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 196 ++++++++++--------
 tools/perf/util/header.h                      |   2 +-
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 14 files changed, 333 insertions(+), 127 deletions(-)

-- 
2.31.1

