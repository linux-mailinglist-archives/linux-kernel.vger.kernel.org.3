Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414351F39A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiEIE6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiEIExv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:53:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59824A1446;
        Sun,  8 May 2022 21:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfDKNc2e8NBNhRcJvc+eXqtIgpmdP7CBHIr0PvE4vggEZCiuV1kCwT/cn82Zb0pUl7za6rdP/iItniFng4FlSp2pBF+zj/qSwlD1vYZmpCOPHvCXeb3M9xVsYaVS6s5yKIoNehK0X04UU/XtdXJlba4UK5H6GDCKYFqH+EG7U1MMEGXbBz+xFvOzon/T5QnEfSC21DPqUfi1/u7MFc+OZdloYFbjbRldKh/KqvPKEMMhy49hbcBFvlCh/aS9AILr848wGvilDObKq++mhYOjeSta9/t4EZsizaZZ0NCkUQZe9zyf08Jx674Mb97mCkn5bLmvxxWfqjCCumRwhd2LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viSfehRVSWPnv8Dg8kKvgeXoTdkTLRPOYBxgFyiNSNw=;
 b=G6oiYueeS6If72CNiBTdzXamD6OHPDpAkq08m4ITTAIAVzmz8M0VzQCYRj2r1dxD+Vrb7xBvrpqsjKFtjGg3hKUPPCCcJxA6ZGJgkSHgnWwYRG4epLIgLDEeZt8KUxoNm4C9UXyeWaXX+Eyz1vgaVJ27b1fe8kDEB5H1G/NQ2zC1wjSNllhsNwgSQ/vbVmHe26P/9XFgkC6+keG974TOHi2UqXCz1IGiemtN08JbtrSTVjm9wRVwF2C9uwGqcY3Z5ovy2LNsC59K5DiVmJxv/WhlP2+U9DDzf0ak1KVcfSobZ+EBvVUyBKHrx1JK+qqKFwjn3QCw7z+ANHDkqEh6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viSfehRVSWPnv8Dg8kKvgeXoTdkTLRPOYBxgFyiNSNw=;
 b=NHr0EQp5aaBeYAlgLlnks74hHWbYsZPF3SPkvzQMcc+XBFeTpjBFuBfQNOaCxqYsfM0Wc3RCeNe0xd0qh8KebbKurJqyQOE08RQyB9vpgETYKtfC77S3m9+6/9fOk9KP7L06GNxW22mYXPXdCiGUWFx8Mc4HeCCVN3RIQ0S1aUM=
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 04:49:56 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::75) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 04:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 04:49:55 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 23:49:46 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 0/8] perf/amd: Zen4 IBS extensions support
Date:   Mon, 9 May 2022 10:19:06 +0530
Message-ID: <20220509044914.1473-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 917a202c-0b70-4a85-a630-08da31775d38
X-MS-TrafficTypeDiagnostic: CY5PR12MB6622:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6622322FCCAD4C544381D1EAE0C69@CY5PR12MB6622.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w7116qwfS63/QWdqdEosdAVFKsERGS2KAM541iHSwytBieWZTT8xZ6GTIiWTQOkE0PQNiCsLS4arSFmeJhN8WDKxgw0A8hZs0vnv1OTsVgoZZqT7yCQXSyd0n/2kiX6R/twcnpddrqcZpTx2rwnIdF9znRYUy+/lLBt47tdrJ/85bqFOdhjUAPK9I0EUwozW41+1GXnFhbMTn9pd7FyCVDdndAkDlmZP3D9UsRLnioU/CvvesfbbWv8u/nhNsLww2bTU6D5J0qvH5nPDe+tHY0fx5RN9SXDn+rZPqbY6DTmHnqdwYsr2oiV9CuKk/BN2zX2OpFGOOEVg7jjN8Li2eePcnNpVmaSR9k+Dw/SeGNQ/bceOeBNO2UhoFnPg0bMJMhE7EJ1COTwXd7A0nMw0N7YR04eMjWVjxq5gzt0fPfcoHrtQiQ2bLE/25ZLqTElPF6AIWqQQmOzxVWDH0nRY8MFvZourveD2EZuNBzLs283vug6NSEMFktIgdek7qNb+BO5ZB6oZNsf8ZtMsHMOQcQk9MwuCRfhprGxKJ1XItTle0tTpsdqCVVZhWdh0EKCVIYy5rNzasYfj+kxv+Kn8hGaSrx0oj1yWVCwF7hei1UgkAUsgElrUG8HD6GPCZOElLFnHs6ibrbkH57TcN7ryMJlO69SpKYEHMsahG3Ja/wi/cOxrwa53VMg1VjvGwqXFo81yHYs+4IAWZwPXfs8dEhFBlYuC+uQZEYDDDpWux9TUNPwGMfTdaltUuKprwxciQ1KCrRZ5r06Qk8DuXA5y+fyHtF1wWnHk6dXCZe4jb14=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(966005)(86362001)(6666004)(7696005)(8936002)(7416002)(5660300002)(508600001)(2906002)(44832011)(81166007)(83380400001)(356005)(26005)(2616005)(36860700001)(40460700003)(1076003)(16526019)(47076005)(186003)(336012)(426003)(70586007)(54906003)(70206006)(110136005)(316002)(8676002)(36756003)(82310400005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:49:55.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917a202c-0b70-4a85-a630-08da31775d38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

v1: https://lore.kernel.org/r/20220425044323.2830-1-ravi.bangoria@amd.com
v1->v2:
 - patch 1 and 2 are new. 1st patch passes on return value of pmu init
   functions. 2nd patch refactors pmu attribute code by using
   ->is_visible() callback.
 - Patch 3 and 4 now also uses ->is_visible() callback for pmu format
   and capability attributes respectively.
 - Other minor improvements suggested by Robert

Ravi Bangoria (8):
  perf/amd/ibs: Cascade pmu init functions' return value
  perf/amd/ibs: Use ->is_visible callback for dynamic attributes
  perf/amd/ibs: Add support for L3 miss filtering
  perf/amd/ibs: Advertise zen4_ibs_extensions as pmu capability
    attribute
  perf record ibs: Warn about sampling period skew
  perf header: Parse non-cpu pmu capabilities
  perf script ibs: Support new IBS bits in raw trace dump
  perf ibs: Fix comment

 arch/x86/events/amd/ibs.c                     | 191 +++++++++++++---
 arch/x86/include/asm/amd-ibs.h                |  18 +-
 arch/x86/include/asm/perf_event.h             |   3 +
 tools/arch/x86/include/asm/amd-ibs.h          |  18 +-
 .../Documentation/perf.data-file-format.txt   |  18 ++
 tools/perf/arch/x86/util/evsel.c              |  34 +++
 tools/perf/util/amd-sample-raw.c              |  68 +++++-
 tools/perf/util/env.c                         |  48 +++-
 tools/perf/util/env.h                         |  11 +
 tools/perf/util/evsel.c                       |   7 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/header.c                      | 211 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 15 files changed, 586 insertions(+), 60 deletions(-)

-- 
2.27.0

