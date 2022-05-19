Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA55752CB93
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiESFow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiESFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:44:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F399BA573;
        Wed, 18 May 2022 22:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LghwW2S5mWNxfYAAE5Heqx4ariPJJh2Me0cAlNZM2jkggq19iUKYnlyw1MaNNlQopcbCkpNCKWbrEiaMfVQbLMyq47OwQBp8R156LsyCBUh3a2fyNZr7qWHsp/+OEK5Y0Q1X5hRKrhRVd4JNUEXxOX9pg8js7TJGR7jQx587LeZfd6H48NmPMV9x95iIQ1PMWWl7oeO04BxrptlAhFRfgshIT5E65CrK+KuVkbUy5M0zImmINvkCRGxpTmu6FP8t3u9nAs//K8St5d7QJyXYLRDvJo1030c0ERcOGZMlpKJN2+1vrolccOljFRSrNNwea+P5jVOQKR1agYeO00Ev1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/s/KIzDWSxff86h8ZbcZwe5jNJ/OHpVkJvcRtwN1Pw=;
 b=cFMOy+qKcY1r+qx76EWfi8o1omt8Rbv7SzOeKRDxJn1t5YyYmAvjrBu3dLaLQBKMWB6GANMxnIPmONz6jUYq0LnMfdvybZWF9t0dldNcxjMrcXt2M60uoG2y5VGpRYZHPCNw25hCzqAOYHAUws7K21WfhEspMWH8BxVSEXbIHks/Ry+a9kcaZ6Y3oKvqVIjBkU042fWXnsv600LMGBpM5BcsTR9eJuRd8JcNxowrmW4ldc6XQ2NHWwgtg8SdoStZTAlMjCPacOv28v4ZfzLn755LvY4SbWypA3UbLNYJ+KRI7j+h1SozxtZxU2afUZe6uR3eZg3LZBi5JK+gaGQimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/s/KIzDWSxff86h8ZbcZwe5jNJ/OHpVkJvcRtwN1Pw=;
 b=EYWQOQ+0VGcVYptkXcJVOw0HzxSZu8zRjGxuP7Bsp1oOClGkU7pjAX6wqIjndkJ8iSvR2qx9rruaPacXRhmfoQU99AcGUXc4yXFM4uAPf6vsqB02YqdhTB+6pwthBQjpP/wj1Z4WtolHsQH09+JqzJIRPmZ8URdeVt8ADHgA/bo=
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by CH2PR12MB5545.namprd12.prod.outlook.com (2603:10b6:610:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 05:44:42 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Thu, 19 May 2022 05:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:44:41 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 00:44:25 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <rrichter@amd.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <irogers@google.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 0/5] perf/amd: Zen4 IBS extensions support (tool changes)
Date:   Thu, 19 May 2022 11:13:50 +0530
Message-ID: <20220519054355.477-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfa2b9cc-60f5-4107-bbb1-08da395aabe5
X-MS-TrafficTypeDiagnostic: CH2PR12MB5545:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB5545026E4CE431504135E058E0D09@CH2PR12MB5545.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oyz/vWcHAMqoXQofqefJ/00zC9gN1MB9eBawt9k3fUJHJBXs0zbFC9GwgwvXpy4KzkKV2llokm7l60Pr8aeRJNB/Jxobc1Qxy6sotz6btTetQUMJVY9CaDbAkJGuaYAWgPANqcTJdHrQV9TUHYO7EH6RgXposDMstsRVT8I7Hh/HIB4nrkH/XHVL/P7S02jD8gsWfH0EmdMjeJ432YTrJx6q8dioey5Q6Is5xtwGeAuJ3W5si6+WkFuFVZzsmpWJDK3R7aSZ4sRAWgoxuGrwUJT1f+fDNBtqi3gLBvetMOaKxMt2omygoB5J+yif6hx4BVHgF5p+h/0jsHE+8GdTQztqJ3M3i1JcjenWs6f375HCQC/MDYfUD2IrZQPfrzMih1P0Ed84hEMCZ4mTncpFgH2xwMm2X9eq0SMpkVwBQPNRHfbY8ToDS2TmuEDFbIUQPy6fQNO7DklexUeqsqJG9ZewHVIgHZAFcg+zCuhS+GIu9No6PyIxyaAyQ8fMCOAbVTdQmQQLiKfdbw+ypI0YRZt9Q7M08+BZ9PGnvs4o7FM6Ny09OzkeDD2ATgpPPNhq1I0fVR98jNMHQAnjyn24qqijXwFVHBacre+0dBaNvAf/qqvCDI4lEMw9STjmsrTS+lSfGyQuhh/kpemRUJm95IVFaVKDKT7fraDlKs/PoXZwuwv35WWYEgfnG1R0kSdhXzSMlchIgHzlnfNHp1fY4f63Fr2noB/6mLwTUEgh+pyhBYViCs2Rbf/+l3+x1jvwPyHUZL8hd0vjKhjKv6ubXs5m1XEipkDpOp+6QXG/Tk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(966005)(54906003)(6916009)(40460700003)(508600001)(5660300002)(7416002)(36860700001)(44832011)(86362001)(2906002)(81166007)(356005)(70206006)(70586007)(1076003)(4326008)(16526019)(186003)(8676002)(2616005)(47076005)(426003)(336012)(83380400001)(316002)(8936002)(26005)(82310400005)(7696005)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:44:41.8271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa2b9cc-60f5-4107-bbb1-08da395aabe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5545
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

v2: https://lore.kernel.org/lkml/20220509044914.1473-1-ravi.bangoria@amd.com
v2->v3:
  - Rename arch_evsel__warn_ambiguity() to arch__post_evsel_config()
  - Optimize arch__post_evsel_config() for non-AMD and non-IBS cases
  - Split header changes into separate patches
  - Rebase on tip/perf/core (841b51e4a3590)

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
 .../Documentation/perf.data-file-format.txt   |  18 ++
 tools/perf/arch/x86/util/evsel.c              |  50 +++++
 tools/perf/util/amd-sample-raw.c              |  68 +++++-
 tools/perf/util/env.c                         |  48 +++++
 tools/perf/util/env.h                         |  11 +
 tools/perf/util/evsel.c                       |   7 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 198 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 13 files changed, 427 insertions(+), 24 deletions(-)

-- 
2.27.0

