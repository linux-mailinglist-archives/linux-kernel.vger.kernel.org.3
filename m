Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E85096FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384542AbiDUFuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384527AbiDUFuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:50:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037764D9;
        Wed, 20 Apr 2022 22:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSOulrohCeu1Pz5PIV0/LSP6uED1m+DPyt3Cf13Bg7qRK1J8NDJBj8v3dvDy+71tHbp5y9euYh/Snri/RS9y/5b1rzMxzf57C1DKUpj0ymIcaHw9oLnSVeUQ7EIdh9JnA1loMdnLp25CnUFTTKHPgmmr6fuLCgVfydF5VDtH6Q5GO40ozj/6EA4VfT94pcEtWH0fJj4Fa4a+KoFSdNQQ6/oDmrfeF1H9KKpsImSJ5Ni0OhPl8n/CL4sb3AHq+3oLuFma2Ld25+YyJGp9qIoR1nDxi/A9vDAngGUUyUHKZDa2ZdYHSTkF1l00p0mPDoGDkAQ2YOAxUmvTMTTymqPSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t1H3P+UVHz+rkIFFbFdl3BwP7sEgvFHrbzWQ/CTQeA=;
 b=R/7G7P1zbnewFpGfA/YMUjTjzK2RCPpvOLr55ud3miunlNk1TnEG2uLZwADDYhwUpsUWPfuBQhW0zn/Dj5RiTT3oCnv28M20zXYZKFykRbnt2AVc9RkxBbyRM2b1iSoX5h6sP0DLD/3xDnfC6R53fJlOyEycB0WVR4Syo6+ZSyyxqsIOj9+f+DoYNhemCWbwcgtgplNd4UwZgstkFj4TRpqCnG4P7d/y2Nw8Dp1UPrQ6nDJ+xePClpJtpt8J7cWIPuybpws2dBFCMF2iSC73vB8MmNKLiTU1cbNACSmLZPzRbcI4xMK3bdfWRQ50gJuL7/JB+dbDkOTaqqiEKxp4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t1H3P+UVHz+rkIFFbFdl3BwP7sEgvFHrbzWQ/CTQeA=;
 b=PeVLI+qKlTC+Rk05zDawXvBF9ygmvb5zAs70fn4SiyU6iMZmLI2T4SCRC2+CD1nL4F8L6UrQijUuHA2V8D2EK3TZVpJR61Ry+ZohQK0fMhXXONcvMsA1nM5IpWFSLor+eEAgEllKsTAXyAAiPn9bGam8KIxwvO8ouC759TnYn4c=
Received: from BN1PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:e0::15)
 by BN6PR12MB1204.namprd12.prod.outlook.com (2603:10b6:404:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 05:47:14 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::8f) by BN1PR10CA0010.outlook.office365.com
 (2603:10b6:408:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 05:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 05:47:14 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 00:47:07 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 0/7] perf/x86/amd/core: Add AMD PerfMonV2 support
Date:   Thu, 21 Apr 2022 11:16:52 +0530
Message-ID: <cover.1650515382.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e04f9fc-e7ac-4d18-7710-08da235a630f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1204:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1204D0DD326A96F9B73672EF8BF49@BN6PR12MB1204.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIGmriLgjA/mFSbpkpPxwptFO7XdVw0p5U3QqbJEfQGqKOQOawzj2VhTyHQkVr4gSeA4fhcVPKzvxnsomzTY95hI9r7SW3Qz+jFIhqrq217vdOVP6iovfr6IYJHbCyz88H1DjGHEZD0VaayX55WgTAm+gXzQ2lt01l8/bh1FpKrYs43fSMx189yiBxVqO6s9eREbs9FLgK466/FXRLN9Mze5VbGNmDX9QkOqut/y1Qtk+oxDoFCUjGBOTsNkIKok3x7eE2HHXdfGeYGq/8o5FXF3hSKOcxL+2LHNUMDLloyn/Rlq/VAFXvId9b470CodkU7M4dwjX5RvbL7pSHxyvmdfnZLzOAAryXWH4yVuS5nTEMiWoNg9/KhMkYYBq7l3Bn69MaSyUGvL4KrTB6JEyQzN1ORT1VhknaQ5oSrTzW1KIkGGQWYqsdEqngEOR/Qo4T1JHwJJh4d2GAJZp+ipmHsFNS/1hgxgE3yQChhIvzxwDl8s+BiC0uNlZnUtK79ACFLa+VIXcYCUWCHIeR2b4HNsRQudBVi6W+Wpe88lgbBl7AV4Gf6bJRY3E4v3r9WiDdlY1iB2KMXzwONC1XfRzDDRc/aAE+DGK/durGv2T2o95UYVSdcwz7tn9RBp5VUfc60J4f/1dKFrLY6mfQGjdT3p0n+IOo6FcYK5BGKxT0+e3FpTMbFiw3PbpTG6uJzmTzYjioyiUzQFT3gsTUM5NiJiBih2p7+TqlHEo3rKVQvx9VuWrLY+6cj6NUDmzDhi5eoJwPa3R/kWepCUc2Bl8VuAlmu1uIUNmY5nDdwHrFI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(356005)(26005)(81166007)(966005)(5660300002)(316002)(54906003)(4326008)(86362001)(70206006)(70586007)(8676002)(82310400005)(40460700003)(2616005)(47076005)(110136005)(508600001)(186003)(336012)(16526019)(36756003)(8936002)(7416002)(44832011)(83380400001)(426003)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 05:47:14.1551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e04f9fc-e7ac-4d18-7710-08da235a630f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1204
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
v1: https://lore.kernel.org/all/cover.1647498015.git.sandipan.das@amd.com/

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
 arch/x86/kvm/cpuid.c               |   5 +
 6 files changed, 240 insertions(+), 17 deletions(-)

-- 
2.32.0

