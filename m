Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CAD533A17
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbiEYJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiEYJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:41:58 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF51113;
        Wed, 25 May 2022 02:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKD1/qLu65GVqSeIVLu2qiQ757KBJKlDMOetKPW9xWs19GM+CoDpgRthwKdRztDSko1h8KUmRfIDaDMcJ+LjhjUOWe5Qjy6Bm7YVZKtN2YcDnIDI2yl0b0OueS7WxtSS0MDQMRp5uCqgYYd4ty6/rxIE7LedEoJzh6ZfFuM/rQqIVY05L2mFx70LF5wEKH55tJqQ1xOeaMrkte1ykPh+mt+xHVZ1jjZDopV8olxPKQlxf4sLcZbYke11xFKhOLYakBcInaE3RsI2rJsGEqYMUNFKMn/Jw5cf6m2288mKKkKg/P31DcY7Iu88KgNcCEFoRIkFRQQB85FwpU3JD75Xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSUb1lgpDMnF8+tOxkLd8LPFyBOWPHQAkW5o/I2e7Qk=;
 b=DfTM5AaTI2vqJdDcCMZY0sYlgaKciRk9XKLnDvsZA2Q96Ggft8tZVpilJYvietFFxrwAntzSs4Q27J84hB6j266CYEuINfRGWje47PgZlPL03IMZL2ctMCUU8Fk7lIm9mD/F3jOdaHGy1SqWskC7oqUGUuzjPdFE99RiC0FneCZY8KyI6+y0CUm22FapbVTETtPa+jy4d0MClCUEYs+zsOuH+miBswkYM4b3k4RXRtM+4zgMZccuJw4v81mdf0UA266eVu49oAh9gb7uqY0tDhMLxsDUpfyE0mCWObj2wZCuwMJUjPPoL9uash7Z0atORxw7zDaxNF0YiLjpysZHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSUb1lgpDMnF8+tOxkLd8LPFyBOWPHQAkW5o/I2e7Qk=;
 b=MV0NOeW8wfJE8fH0u+1zSpYH1KKAT3+SgFaXuWgJPaE9BNBX9Lh4y2UzZQk8BPZZ2FOR6rjAJUDREmTIpX7Jj24dGp/rVlQAWMOSN3yT8maO/tYIuuBt+nkbrWAc6sUQxTrWZFET8pyJGHi9c7zd7dLegSVLhjmY8CPk1VQSWd8=
Received: from MW3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:303:2b::23)
 by MN2PR12MB3599.namprd12.prod.outlook.com (2603:10b6:208:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 09:41:53 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::b1) by MW3PR05CA0018.outlook.office365.com
 (2603:10b6:303:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 09:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 09:41:52 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 04:41:38 -0500
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
Subject: [PATCH 00/13] perf mem/c2c: Add support for AMD
Date:   Wed, 25 May 2022 15:09:25 +0530
Message-ID: <20220525093938.4101-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fae5b5f-f900-41d0-facb-08da3e32ccc7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3599:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB35991AAC772922BD30FAADC8E0D69@MN2PR12MB3599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyQBz9E6UfJiFZ5U8AWTWFWNbYSnNIMQhYXtIYp78DUySCmQpj33ms3Sz3Y8zRWGxxVK/ztqwukXbNaOItlHeH9TTafVXXkPzGtMuMS4kxQAB1f+TcU52cIGzgRphRQDcN65lY6twdV2EhW1X39cgeRoZaK2GCAIayjCSSOeYz7NFMFlMZ5cQoEbZT2tH97sS9d5YjK97D19+2lR9GRAVQkpLysPpJEXHyBHKQ5nN5uSJ82qByIH7ZYXcSQtaRWLmScb0MVcgathyHM0nNSPgW+y/qOOJsH5DAV3g9noHLSJYBHSvpSascYTSFTv+07vBkZ87T27BWFd+TOz/F59kwqveG0Xwe5qE2nlXJTGErv65ZYWzltDJA2rJdA7dEVqfdEIeGe7oPqO+8OoBm352x84lftG4Dc0hHVJNQg/s7pjsDObI9+Lve2skB+g7TXMg3hswKUTtT/ivUH4dXbW3CZ+75W56t1TYr3uqmzbknddvFtpf3ZTIXKoJFU8JNsUGB7Jl5a/WR3pfMQWml1/IuIrJykXYoDlsoZ3zXif1AogkQe8YBOSgeeLwyrYx3UMlMsFT5x4MMCEpKmX8XcKigN0YV74sKMucqDpk5JLG/gqrJ/HrHg0SNVPgqxhFS+PNtfxxA+xxEIuYaWnF49bJlXdokwFjtUUBwhIKlncppTlQQj/j2A7KuP4bozvr9R7aEYkK3pkqjhQUjvyJBR0vXQf3SQUN8zq9TIFi9WKUtgSPt8mW0I8kv9ikGnuF+Dd+xkLKY9alQGWU+XNhf+fqE/LWybpObTKyYHDjfUz2MY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(82310400005)(316002)(2906002)(110136005)(508600001)(70206006)(966005)(44832011)(7416002)(5660300002)(86362001)(36756003)(8936002)(2616005)(8676002)(4326008)(26005)(426003)(336012)(54906003)(356005)(81166007)(47076005)(40460700003)(36860700001)(83380400001)(186003)(16526019)(6666004)(7696005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 09:41:52.9260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae5b5f-f900-41d0-facb-08da3e32ccc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3599
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

[1]: https://lore.kernel.org/lkml/20220113134743.1292-1-ravi.bangoria@amd.com

Prepared on tip/perf/core (bae19fdd7e9e)

Ravi Bangoria (13):
  perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
  perf/x86/amd: Add IBS OP_DATA2/3 register bit definitions
  perf/x86/amd: Support PERF_SAMPLE_DATA_SRC based on IBS_OP_DATA*
  perf/x86/amd: Support PERF_SAMPLE_WEIGHT using IBS
    OP_DATA3[IbsDcMissLat]
  perf/x86/amd: Support PERF_SAMPLE_ADDR using IBS_DC_LINADDR
  perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR using IBS_DC_PHYSADDR
  perf tool: Sync include/uapi/linux/perf_event.h header
  perf tool: Sync arch/x86/include/asm/amd-ibs.h header
  perf mem: Add support for printing PERF_MEM_LVLNUM_{EXTN_MEM|IO}
  perf mem/c2c: Set PERF_SAMPLE_WEIGHT for LOAD_STORE events
  perf mem/c2c: Add load store event mappings for AMD
  perf mem/c2c: Avoid printing empty lines for unsupported events
  perf mem: Use more generic term for LFB

 arch/x86/events/amd/ibs.c                | 351 ++++++++++++++++++++++-
 arch/x86/include/asm/amd-ibs.h           |  76 +++++
 include/uapi/linux/perf_event.h          |   4 +-
 tools/arch/x86/include/asm/amd-ibs.h     |  76 +++++
 tools/include/uapi/linux/perf_event.h    |   4 +-
 tools/perf/Documentation/perf-c2c.txt    |  14 +-
 tools/perf/Documentation/perf-mem.txt    |   3 +-
 tools/perf/Documentation/perf-record.txt |   1 +
 tools/perf/arch/x86/util/mem-events.c    |  31 +-
 tools/perf/builtin-c2c.c                 |   1 +
 tools/perf/builtin-mem.c                 |   1 +
 tools/perf/util/mem-events.c             |  17 +-
 12 files changed, 557 insertions(+), 22 deletions(-)

-- 
2.31.1

