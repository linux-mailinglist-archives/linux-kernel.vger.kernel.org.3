Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0854E01F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbiFPLiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359848AbiFPLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:38:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7FD39825;
        Thu, 16 Jun 2022 04:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiUVxVLHt7k2BcMfudiU1+eDznKjmzJiOxYOsRyyNiZA3BlcKNriCC95ApwlHaYwf4S2G22ylD3iUCl5HANq6FTfnIx85owLUO67wiFXAq6ta+BVJim3VqIncFVxSozKLoCnAKOKZ2O9y0Pq+bzbXTD1ruhH9whXmDFk2kXTF+IxhHF9fBITpPQefwagq254cdTHflTuimYYVJqlzqxOtakdTVNcmmhhJ1tihFXiZRfYXDKJxPBFE+I2JdVpv1NLpzgunzeKPtzjdcUfsvCLC3Ef5s+ugpmZ7643JhomZPNBTkuCNZgfM55twftytzWjGHfJgyIKSGMaKKJnrSkVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnb2X1gD07FwjsdgniYGzEIIHfqASMEzVSxzWqOfRFE=;
 b=h4SsfPQQCHnWdKdXLt/zBQartPt/ce5OhiFBZzZbX2M0sr3jJ2pivMD6Pv/37LUrKnKiChBMhwTqFUQEtm0t0D8Xqd8O5iwRpv9rggMHcKuqA3WuZ73k86+Na5eOCrhC650v6wBbvIElehqfsbP0H4Rq5BzycVVXaDmDHMifzLmJeBWAgEZxccy3ACBCgt4YVFK2X8Zz2RF3e4+boy+Aeu75TN2iFA0LEOXzxSvVuflyoXN1f0o6kswXYU94gN0kUKMuVIglQG2Xwa6fY5AOGZdRLEjNYWvYjx52Ha8sW1k0aTCtcyRZADWuvxvAJVsQdTE1wRnW2zLKhNMyf7oPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnb2X1gD07FwjsdgniYGzEIIHfqASMEzVSxzWqOfRFE=;
 b=OlTPwg1iO/p+Ybf1Nt0+E9uFsBH9zQ1qV+qle99PEz/RtVmvEj9cBmTWMFmV5/Km6xmx/GKVxbgTpzhlxWGJmNwPdAIA6GUb5a7DnNKz+sd2Qz7+FiFSvfVRAHX8/bJa7FT6TMCa4/SegbCVKlVLtz7H1NZF1Qu22tzWKcTyD1Y=
Received: from MWHPR14CA0016.namprd14.prod.outlook.com (2603:10b6:300:ae::26)
 by CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 11:38:12 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae::4) by MWHPR14CA0016.outlook.office365.com
 (2603:10b6:300:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 11:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:38:11 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:37:36 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 00/14] perf mem/c2c: Add support for AMD
Date:   Thu, 16 Jun 2022 17:06:23 +0530
Message-ID: <20220616113638.900-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed1a577-668f-44b3-92c6-08da4f8cb16d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4955:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4955C0F0EB0ACD1864244D2CE0AC9@CH2PR12MB4955.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/Rc4egRDYXyIM99JrGaFKfoZ/2V9Rm7JaLqZl4SvkbwsMGfPU4BV5Zqfc6sjag2rA9IFwOhTH7Pqiro2nKycWXBG1ObfGMHbHNehbnmHB2967kYyJt4e6zp8i7LEbg5DgSr7WlshE0vkDfWgoJrsr4GgM6YvxPn79SudUg6d6mnNwlfQaojUMBRKUuNyc0j5nqTI1LS3FKf28DfKspDZJMUihMmo17mKhc4xwt/BQQJKhPsjnBX/hHvMTFNryiKNDroBjzWzzBW64VGAPZozIkYxC7k9gTQHL6qag2JTCrX5cA8wBt3947jab5RnO0+3QOP4LeWTbU6Lu4w40INp9tn/Tej1ugRdpT71qFHf/HEFX/ELO2oWpxdei6HUd/alMb93oUg4EH7r+6hr1tTTsmTzLbZqiMEJq1Zrk97NbZnomuDsh9q0k1iODAH0K3qux9vzsI3W9/gjjwRvd2IlkbOf2bs6gB+0/tbf6AJxr5W/AyFFu8yr2HwkFx0QT2Ev1tDZHDnH3rjYORaXTMLVubjnRto1qRS1PHmNzAdPp05huXv99HvfrcLJrx9HYiD54WaLLFrducsEwEyDbU6AZDUjMeFQjhOVQkNTxcP1GFeh/VPIUpLipyE8Dt6Cx2hqKPUEt0kxqk4W6/gEWfRUm2414s9sdGQqhJ9jvxM57iuOtWfWo6rffVjhqHG3P5t/vDRVAJGGDhhxqud1Beoj89rzHE/ZNT7ymXtHtKLBHulwR9Qm5o+6xsKazWYRhzEjI3guOcT/7JcxMcQ2OuzUNeprNVN+Hn96sLrYOeKgcb3lYPAoPn0l4zVpI/6Hw6gC4ogBnIGFJtg6XoTRDvkYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(47076005)(81166007)(40460700003)(36756003)(36860700001)(356005)(316002)(86362001)(26005)(336012)(16526019)(7696005)(2616005)(426003)(1076003)(508600001)(7416002)(186003)(83380400001)(44832011)(966005)(8936002)(54906003)(6666004)(110136005)(2906002)(70206006)(70586007)(82310400005)(4326008)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:38:11.5235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed1a577-668f-44b3-92c6-08da4f8cb16d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4955
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf mem and c2c tools are wrappers around perf record with mem load/
store events. IBS tagged load/store sample provides most of the
information needed for these tools. Enable support for these tools on
AMD Zen processors based on IBS Op pmu.

There are some limitations though: Only load/store instructions provide
mem/c2c information. However, IBS does not provide a way to choose a
particular type of instruction to tag. This results in many non-LS
instructions being tagged which appear as N/A. IBS, being an uncore pmu
from kernel point of view[1], does not support per process monitoring.
Thus, perf mem/c2c on AMD are currently supported in per-cpu mode only.

Example:
  $ sudo ./perf mem record -- -c 10000
  ^C[ perf record: Woken up 227 times to write data ]
  [ perf record: Captured and wrote 58.760 MB perf.data (836978 samples) ]

  $ sudo ./perf mem report -F mem,sample,snoop
  Samples: 836K of event 'ibs_op//', Event count (approx.): 8418762
  Memory access                  Samples  Snoop
  N/A                             700620  N/A
  L1 hit                          126675  N/A
  L2 hit                             424  N/A
  L3 hit                             664  HitM
  L3 hit                              10  N/A
  Local RAM hit                        2  N/A
  Remote RAM (1 hop) hit            8558  N/A
  Remote Cache (1 hop) hit             3  N/A
  Remote Cache (1 hop) hit             2  HitM
  Remote Cache (2 hops) hit            10  HitM
  Remote Cache (2 hops) hit             6  N/A
  Uncached hit                         4  N/A

Prepared on amd/perf/core (9886142c7a22) + IBS Zen4 enhancement patches[2]

[1]: https://lore.kernel.org/lkml/20220113134743.1292-1-ravi.bangoria@amd.com
[2]: https://lore.kernel.org/lkml/20220604044519.594-1-ravi.bangoria@amd.com

v1: https://lore.kernel.org/lkml/20220525093938.4101-1-ravi.bangoria@amd.com
v1->v2:
 - Instead of defining macros to extract IBS register bits, use existing
   bitfield definitions. Zen4 has introduced additional set of bits in
   IBS registers which this series also exploits and thus this series
   now depends on IBS Zen4 enhancement patchset.
 - Add support for PERF_SAMPLE_WEIGHT_STRUCT. While opening a new event,
   perf tool starts with a set of attributes and goes on reverting some
   attributes in a predefined order until it succeeds or run out or all
   attempts. Here, 1st attempt includes WEIGHT_STRUCT and exclude_guest
   which always fails because IBS does not support guest filtering. The
   problem however is, perf reverts WEIGHT_STRUCT but keeps trying with
   exclude_guest. Thus, although, this series enables WEIGHT_STRUCT
   support from kernel, using it from the perf tool need more changes.
   I'll try to address this bug later.
 - Introduce __PERF_SAMPLE_CALLCHAIN_EARLY to hint generic perf driver
   that physical address is set by arch pmu driver and should not be
   overwritten.


Ravi Bangoria (14):
  perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
  perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
  perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
  perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}
  perf/x86/amd: Support PERF_SAMPLE_ADDR
  perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR
  perf tool: Sync include/uapi/linux/perf_event.h header
  perf tool: Sync arch/x86/include/asm/amd-ibs.h header
  perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
  perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
  perf mem/c2c: Add load store event mappings for AMD
  perf mem/c2c: Avoid printing empty lines for unsupported events
  perf mem: Use more generic term for LFB
  perf script: Add missing fields in usage hint

 arch/x86/events/amd/ibs.c                | 372 ++++++++++++++++++++++-
 arch/x86/include/asm/amd-ibs.h           |  16 +
 include/uapi/linux/perf_event.h          |   5 +-
 kernel/events/core.c                     |   4 +-
 tools/arch/x86/include/asm/amd-ibs.h     |  16 +
 tools/include/uapi/linux/perf_event.h    |   5 +-
 tools/perf/Documentation/perf-c2c.txt    |  14 +-
 tools/perf/Documentation/perf-mem.txt    |   3 +-
 tools/perf/Documentation/perf-record.txt |   1 +
 tools/perf/arch/x86/util/mem-events.c    |  31 +-
 tools/perf/builtin-c2c.c                 |   1 +
 tools/perf/builtin-mem.c                 |   1 +
 tools/perf/builtin-script.c              |   7 +-
 tools/perf/util/mem-events.c             |  17 +-
 14 files changed, 467 insertions(+), 26 deletions(-)

-- 
2.31.1

