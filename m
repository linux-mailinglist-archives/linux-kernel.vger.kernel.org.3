Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585F58FC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiHKMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHKMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:30:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C069ADC9;
        Thu, 11 Aug 2022 05:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUBYRA2wReZ21CDqfzxNlIV/Blt1mhdm0aksz7oSc+euiMCZFDuWG4ezzcyIRZ0PQj/1/75G39p9aPPHhwGZGph/qkvW50VY4cSjXqzOTy8iDR21AvY7VV68Wo/9nNdGZgW1oNdWM2ESwZc2htp6LYCZf2aZdoAQMRB7WDgWJ1S40lJ79R2kMVo/TRLL/Jys+I01LUhZwmmH9monUL4n1rAPo/gx8WQq1pgwj4XU3RbSVR9YScUgkXbqNutTLbK/ditVeOiOoFGj8T7b/sZcJbNx+rVmMXi8aS1cgUi2BBhJrugGrFggOuiE0F0+h6Lgfv3faPKmJ/1rT6X8WtxeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhxz62pPebNwiXmKkY48CDHnplEASDNrssq4l40Jfcc=;
 b=LSdy8ReXrLwaKa5Bv9uqZKZ+XOHeKcs41Tzlv9zsqtwotQLiQLDGHJCRqRgYMEA33RcPlHEvlzFqV0qA9NbCWzjiJ3ZUED9gqhKeTpalEkNe/oEs0eMLn9IXnso+vewt+duQDWRHa2e9+hwIXaBvNvsqFmyrPrl9nHMSFiAjsysXXSw3x9hn4BwaoA7sQI41EF1SFgFXrkVzVUR02U8/281tqmnOfAg6cxSkf/zjdoCezz9uv6NuVBulpPaxSfwfw3BZPabkkmj69g3zlLiw8GgbhEZUC3o1pYw/A9Yra0NpoizhMWAcsFIf+72cFcU6FpIq1YNffsNQ7WK3WIjXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhxz62pPebNwiXmKkY48CDHnplEASDNrssq4l40Jfcc=;
 b=5DRyrmNDwdtQE7ZMs8lirOz36mmG+Nqf9STHVu7YblfvWDh4ybs6VOBBvH3CKXq6OhLGhBXfE2HuNwulqA8iLvODd/yAE6s3NWKmkrPWlJFBj0cjX4hLc8/yMCJ4f8mfIyXjzQ5iKDdVNIHXXZAQULOcoY3SRlncvS1C0c/2tnQ=
Received: from MW4PR04CA0367.namprd04.prod.outlook.com (2603:10b6:303:81::12)
 by CH0PR12MB5169.namprd12.prod.outlook.com (2603:10b6:610:b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 12:30:48 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::6c) by MW4PR04CA0367.outlook.office365.com
 (2603:10b6:303:81::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15 via Frontend
 Transport; Thu, 11 Aug 2022 12:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:30:32 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:30:24 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 00/13] perf/x86/amd: Add AMD LbrExtV2 support
Date:   Thu, 11 Aug 2022 17:59:48 +0530
Message-ID: <cover.1660211399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6e6672c-566b-494e-d79c-08da7b9551c7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nrn248+pesIgYVE4v32B8PHcji+G2S5bWFdNHmjPx1qTTVCncR4EODpWrg9WkhHSyEeamGp30S8xW4RcCvX4swt1xMK62Ay7lDT/S5qOfLMQXsshQ3/7OJZO1qBXhcLki9+S85xHZzODJ8EdY5dnsqT3bpaKqFau7JyXoRJ5zrVel+yY9+KptyjPqGbFn15dgmUVF9gEK0Facd0cx91fEi4JbjORNT3DJf2XCwMtf2e+s3yZMHNVSAdnyqRdRshkKxR6aL4xsQ6/4JQVDWGTlEAZCZSpMPgdqMEN4tOEdAfMWkhuDteMBRFs5Wk3VDONVt79MSLD3bpzzDTIP+QMVHnnGiqX0SIRa+e5cxKg61OjyImapGdhAXwWdGHfuXKi/FrCqaA/iGoHjDbml+aH4CMn16S5kZBdEgNWAPMg6KoKqGMYuRUKrKgtX1DRtfULY5pUK+Nkudk++qYOhnpnYxYu/S89cIEdTApkaVdlOsBJao+M/6oQcEJ2u+aZEss6QruuQ06NTtsHGIGNIBcCIMepyEq9iLUBKSlAFWbxGUw+5E+jIwkYxm1UjS0FzUS6+zaaM3wxzEdwdZJCe7i9NXXwof0W4cZhWkcfX6XOUX6y5rlM4EkOKek0ygwXfIVWoYdMF3WG95mhk6M5pu6o/CVm+icSvoIOebIbhEHGCxqnRr6KkE+ubnyAXRenUyAsXplMHdjJb9Fy4hNMf7uzSBmesLRuKmut94YEXMX/pkcncfWDV+xvtgzTYUymC82JndOxRJ2VO1MOIYDt8AF3W2qzgpHtUWDoGuEwdqEdfZCMAKIU68g8IPxWnXsZBtVRlFT/h4kF3F+ZWdJ9JOVgdkTSuvMGq3wiKTO6sRpYsOaK1uECavKMFuH/x53LiGo
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(70206006)(7416002)(41300700001)(70586007)(7696005)(186003)(6666004)(4326008)(316002)(2616005)(40480700001)(16526019)(83380400001)(8676002)(82740400003)(26005)(426003)(336012)(54906003)(47076005)(110136005)(86362001)(36756003)(2906002)(966005)(40460700003)(356005)(81166007)(8936002)(478600001)(44832011)(36860700001)(5660300002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:30:32.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e6672c-566b-494e-d79c-08da7b9551c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last Branch Record (LBR) is a feature available on modern processors for
recording branch information. It helps determine the flow of control by
logging branch information to registers in realtime and helps with the
detection of hot code paths.

Add support for using AMD Last Branch Record Extension Version 2 (LbrExtV2)
features on Zen 4 processors. New CPU features are introduced for LbrExtV2
detection. New MSR definitions are added for configuring hardware branch
filtering and for enabling the LBR Freeze on PMI feature.

The LBR Freeze on PMI feature is essential for ensuring that branch records
remain consistent with the point of PMU overflow in order to provide a
precise correlation between the two.

Hardware branch filtering allows users to record only specific types of
branches and can be mapped to most of the existing filters supported by the
perf tool. Additional software filtering ensures that some special branches
(syscall entry and exit) for which direct hardware filters do not exist are
also recorded. This expands the scope of filters like "any_call".

Additionally, the perf UAPI is now extended to provide branch speculation
information, if available. LbrExtV2 provides this information through the
"valid" and "spec" bits in the Branch To registers. The tools-side changes
for this will be submitted as a separate series.

Users of perf tool can now record branches as shown below. The 'div'
workload used here is from https://lwn.net/Articles/680985/.

E.g.

  $ perf record -b -e cycles:u ./div

Before:

  Error:
  cycles:u: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

After:

  [ perf record: Woken up 49 times to write data ]
  [ perf record: Captured and wrote 12.197 MB perf.data (29601 samples) ]

  $ perf report --stdio

  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 473K of event 'cycles:u'
  # Event count (approx.): 473521
  #
  # Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
  # ........  .......  ....................  ......................  ......................  ..................
  #
      29.69%  div      div                   [.] main                [.] main                -
      23.84%  div      div                   [.] compute_flag        [.] main                -
      23.41%  div      div                   [.] compute_flag        [.] compute_flag        -
      23.04%  div      div                   [.] main                [.] compute_flag        -
  [...]

No additional failures are seen upon running the following:
  * perf built-in test suite
  * perf_event_tests suite

Sandipan Das (13):
  perf/x86/amd/brs: Move feature-specific functions
  perf/x86/amd/core: Refactor branch attributes
  perf/x86/amd/core: Add generic branch record interfaces
  x86/cpufeatures: Add LbrExtV2 feature bit
  perf/x86/amd/lbr: Detect LbrExtV2 support
  perf/x86/amd/lbr: Add LbrExtV2 branch record support
  perf/x86/amd/lbr: Add LbrExtV2 hardware branch filter support
  perf/x86: Move branch classifier
  perf/x86/amd/lbr: Add LbrExtV2 software branch filter support
  perf/x86: Make branch classifier fusion-aware
  perf/x86/amd/lbr: Use fusion-aware branch classifier
  perf/core: Add speculation info to branch entries
  perf/x86/amd/lbr: Add LbrExtV2 branch speculation info support

 arch/x86/events/Makefile           |   2 +-
 arch/x86/events/amd/Makefile       |   2 +-
 arch/x86/events/amd/brs.c          |  69 ++++-
 arch/x86/events/amd/core.c         | 200 +++++++------
 arch/x86/events/amd/lbr.c          | 435 +++++++++++++++++++++++++++++
 arch/x86/events/intel/lbr.c        | 273 ------------------
 arch/x86/events/perf_event.h       |  81 +++++-
 arch/x86/events/utils.c            | 247 ++++++++++++++++
 arch/x86/include/asm/cpufeatures.h |   2 +-
 arch/x86/include/asm/msr-index.h   |   5 +
 arch/x86/include/asm/perf_event.h  |   3 +-
 arch/x86/kernel/cpu/scattered.c    |   1 +
 include/linux/perf_event.h         |   1 +
 include/uapi/linux/perf_event.h    |  15 +-
 14 files changed, 952 insertions(+), 384 deletions(-)
 create mode 100644 arch/x86/events/amd/lbr.c
 create mode 100644 arch/x86/events/utils.c

-- 
2.34.1

