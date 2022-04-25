Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD450D872
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiDYErh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiDYEr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:47:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F9E96;
        Sun, 24 Apr 2022 21:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAuPDlcqJrqGrII+uuHZnoNf8yPVATUwBhpZk5PMXu1KIrosuUnlyCuQo4Khd+WQME2CYV2nXCcImC3MCj4DyMhpLnrl8tMSPDMb4O+9q55msoCaoNvug7v8Q13YZSAeqWd8o9PYLlZLkshzPGk3LDC9lKtM+Mj72GFfOyZpWm1CMpq091jktDqprORc4IK8008dwnxDwgsfdNJVTYz34IrohkyLV0cdfARQ5FKgzyJBHxsz2BccSGb+rNBaIo/0N7QwdlIQ4xBfLK245UuHVbcqQ5wUGyL4xAr3yGTwZFgSJknyXUMtsVNW9GfGqTXIWNHDtxCuBlcWxSyKGQ9Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPVG2hR3GOV/brrZ85JdNan6hUmWG0WwBwz2cw0yWhw=;
 b=AJt+GF/WuRvvAmrw6gLxJw6GHS4JQZ7Pz7iBSb80cAhDvjDxb8nA8JE00qwsIIxmarbsSxmL9ZEQMC7bzwQBenRcKkh+Dg7+wRmHKYHTtNIMC2n1GlMfab1q2aFFKvvJryU1M+cXRDKmXizRBlsCLbg0H00H12u/RE69SFBXsIFVNFB2ONuFVuM0OWV5CE5QGxs2iSw0ecHEFfTJDsepAlR/qZUfD6hq5TU5qB4NxKpul7C9RkVLXtuXCOTvjJJkfkRqMWQOCWl8rtmRIkTNeOizXo/sMYTRn1xF0XVj/nqZ11qBf1UGeVZjA/qN4eq+r/5mTSMhap1mkoZoJfOVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPVG2hR3GOV/brrZ85JdNan6hUmWG0WwBwz2cw0yWhw=;
 b=e7DgrqtwV1bG4Ca3ikPRkQwV/caMfIqMesk8ogUElzB0KZbBjyjEDgm2yxggLYz8xA+FFTZiZ6rxXzvfInRvZdGVdBPJqOLim2QnNqO+zLlNtsYcIxtZnwPiTSOLypNxTZn1PVTZralafTFFXhSr3utEqhHkd0zi4Iyv6h6MRZI=
Received: from BN9PR03CA0723.namprd03.prod.outlook.com (2603:10b6:408:110::8)
 by SN6PR12MB4733.namprd12.prod.outlook.com (2603:10b6:805:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 04:44:16 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::3b) by BN9PR03CA0723.outlook.office365.com
 (2603:10b6:408:110::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 04:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 04:44:16 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 23:44:01 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <rrichter@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 0/6] perf/amd: Zen4 IBS extensions support
Date:   Mon, 25 Apr 2022 10:13:17 +0530
Message-ID: <20220425044323.2830-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 901d588a-ba3b-4a57-a251-08da267640c5
X-MS-TrafficTypeDiagnostic: SN6PR12MB4733:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4733798B3A19486800DBBD03E0F89@SN6PR12MB4733.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TM/myTr7qZhd8pristpfHBdqSAeRF5LBcsOk1MjQlwFgDCMnwb2I6Vh0yFEUvRCsLjjevvfe+kSzbBg78DeGI3VVDEM36kGMudQ4IvxwunWu4cwzi12wWwmxDEy/AazbSH/ShuyuwonfgBgaI5G8LVpmgncLLzB72INULsmajqUQmHtToJOJ2TTZnyr92v6LbRTHjqqS8MG+FtmkD1AGVzdiQlvHbslBsroPQZHwEX0i2GOm8yRH3Wch+d0oGgVh+0kN5SvwpAgvAHSlN+WjMul3kYZeccAnm/S63NHsQg/O6lT5Xkoq7LHkGbATw50HBT1Jf1bMGIYTfn09UUKLwwkTvjlPR+KS5eYNusDlO5bvLcnrKSTv6K8E18Do5+aztimmS1evZjw2+CLVz1N7NuF0wXzvI5aiGFyVwiOsilAb2Ba9DErLjvGb09dUwSTx5jJvvrpTpg91AFsfqsS8iX4NHCMkYDOt+xBW/dVL67YNIUGKX6nZYc+IGKq5WtdwVZBj3TyvQzIQA0PsHKB0ghF1lX8bx1qb0Whnzq1L09PhT3b02k26OwlfvVd1vhnjHxlHhlAF3jZn0xukaOpn7vBgJwKtsBZFrNWyr5RtjtrqIXThhY5SJxQoXBjjroc+7B/yimZleKHlRTet+cby+T0M7kX5hINFRkdSfgxXdD84XSGlWNBkhq/MPHKGyVFrM7woxiJueOcOJcOnEFbWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(70206006)(8676002)(70586007)(316002)(44832011)(8936002)(86362001)(5660300002)(7416002)(356005)(6666004)(83380400001)(2906002)(47076005)(1076003)(2616005)(4326008)(7696005)(426003)(336012)(40460700003)(26005)(186003)(16526019)(110136005)(54906003)(508600001)(36860700001)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:44:16.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901d588a-ba3b-4a57-a251-08da267640c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Ravi Bangoria (6):
  perf/amd/ibs: Add support for L3 miss filtering
  perf/amd/ibs: Advertise zen4_ibs_extensions as pmu capability
    attribute
  perf/tool/amd/ibs: Warn about sampling period skew
  perf/tool: Parse non-cpu pmu capabilities
  perf/tool/amd/ibs: Support new IBS bits in raw trace dump
  perf/tool/amd/ibs: Fix comment

 arch/x86/events/amd/ibs.c                     |  76 +++++--
 arch/x86/include/asm/amd-ibs.h                |  18 +-
 arch/x86/include/asm/perf_event.h             |   3 +
 tools/arch/x86/include/asm/amd-ibs.h          |  18 +-
 .../Documentation/perf.data-file-format.txt   |  18 ++
 tools/perf/arch/x86/util/evsel.c              |  31 +++
 tools/perf/util/amd-sample-raw.c              |  68 +++++-
 tools/perf/util/env.c                         |  48 +++-
 tools/perf/util/env.h                         |  11 +
 tools/perf/util/evsel.c                       |   7 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 211 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 15 files changed, 483 insertions(+), 45 deletions(-)

-- 
2.27.0

