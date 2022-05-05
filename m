Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C2151B5F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiEECdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiEECd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:33:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C4240A4;
        Wed,  4 May 2022 19:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clZZOtohWjGh0lNxwh8d20pwUVt7vQSAZGiF61zW1BJh31hcfV9Im/IRPwlKAcRglboUG++jf1ZYpHsfAG/7k3qIUecEGI/SYQv9nbcTdUTLzDuGQDPngerpBTHKUpCPUP0puU+qZMVir+Y07GScdU7XZXo5W5efpMVhMfeJWJyZjRvxZuz7MudFviPMd8lqkJo2jj8grfLnfBGVIba1AGueNhdvo2a8KRNsmacc0K+nodJ4YQ8VtIE16McNVyMxd/qhgKwtQCzQiW2uBeMobtZhMN3ZwFbCMQue5wGUygfx8bDIvINI3FaEKmAkP9O57WHGBCCUwrIFidcdfawC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tbicu/xoVJXVaItkk9R4MQpMdrwdIW2ciSZeVWDMCgM=;
 b=UCYQLLu6MzaJH1WmelE51tdHQFT4yx2P/lakE44pyvtxa7pagEoN4Iup0bpyKgMwM8yTEBX8JXcm4FOdVui/Qdicd3M+Kjeynsdi2CU/brmRsEX13tX8mdykyZw4Zoc1o+neKsCYCB0BCZjzZ2ivLAvwu0pGdfImuBFTUO365fcGQa1ZAZZNe2Ox3LeGWwSPEVNrkG+lphU/n4nKnnefPqDurUUx43pYrCsdaU0s8EKDX9829v0CgDzcZSGwKeVbio9NUESV3Fp1NbWh83PLMbZkWZjiZ30ZD6AvzcUxJZn8Tas6vQxPtPCZV2BPkpJhP3Xyv+BHBtnlx4RptsFc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbicu/xoVJXVaItkk9R4MQpMdrwdIW2ciSZeVWDMCgM=;
 b=ZLtDpfAv0gNya/WL14dp6zehh8YSj6q01TP61rtOdA8M29QVAjGAshB9iNbWBvR4xT2DiC6+QgdYxuU6QDTp1MifKIxtltBonfuqnwgoJ3sWfwpn+NcwVUnYoR2twQ/uBft3h0Eciv8pM5HmjCzls3DuZX4DZ5Ezu+7WN/geSxo=
Received: from BN7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:408:34::28)
 by BN6PR12MB1332.namprd12.prod.outlook.com (2603:10b6:404:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 5 May
 2022 02:29:45 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::55) by BN7PR06CA0051.outlook.office365.com
 (2603:10b6:408:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 02:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 02:29:45 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 21:29:40 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH V5 0/3] Add unit test module for AMD P-State driver
Date:   Thu, 5 May 2022 10:29:10 +0800
Message-ID: <20220505022913.329259-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a788d07-5fd8-4276-99f9-08da2e3f1e35
X-MS-TrafficTypeDiagnostic: BN6PR12MB1332:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13321DBABB66E80AA9E909CEF7C29@BN6PR12MB1332.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdjqybvdYVrBv9gq2FnNWJrt7SxRFb3IJPxPsO+xSZjX4O7iNpmD8EARcX6ixcajZs5Ha6cNuRz+UzgNMlUweEA1qHMZCUA5POMtL/hgj8o5oGrFP1WYTl6VejKF7rLz1jq8tUZecZpYsZ0P6aT+jXifVlpMT/Dhx/lRUzFqDHfQV1H7gn+6w5hPAJepb8kgvqZMVQOGDm03799ZsZRVSUMnI5ATuVhtzh9EysOSbRWrPvPyPc3N9Vulfcs75kBfABeAxU9hds0AHVjWejoZD0jALYMV4GmvJJOZDcpJCBGF2gc5b6jm3qO2NqUBjcmFaLx+iFLMEHg1du1Wro4Ww/E9MUdvBTjMakMGxv5KwV/tAAKhJtoCBuCiwRZ6AqrztsTvuwj8421BYRWI3KHY0QfyxRoqTdD1cCWnlc9iitNXPxFEPcN2f4XIahsEzb8YP4Il64NqznsI7i7ZILu3ZZluSHNHirO/1aWw5rWciaHSAHehM9cqXabsuH0aqp8dCXNWLHHSjenvfWi1VRDaKh3axIpYZVWxXnHm1VAOc0BO84Id4uP1GAG1wGYaAuEK6E8XQi++oNeow8xE3mpoMRWPQLrrQCY/cxFtpjBQDswn66Le0mPz4NhN/quSQVNREneajYPAsSKVOs/KSTrBy6eXGDPa2tkGo6nAy04eTXjNdEGN2/7YBW9uk6Gc7PaGMkX42/5aOxlSgR8JrwnBrOaOhX9oTBoT7ExwspejwJaiwg6QuCgfNxymeui9cIgRLSMWuwE58l3KAUbemY+adFhewkE4Qc7zaYjvZKC85XqitRIqtTQdes7aWco8ylcojo5I0n7lwq7ncpwgc6v/Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(186003)(81166007)(36756003)(966005)(5660300002)(508600001)(2616005)(1076003)(4326008)(6666004)(70206006)(8676002)(70586007)(40460700003)(8936002)(86362001)(316002)(110136005)(54906003)(82310400005)(26005)(2906002)(7696005)(36860700001)(83380400001)(47076005)(356005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 02:29:45.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a788d07-5fd8-4276-99f9-08da2e3f1e35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1332
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

AMD P-State unit test(amd-pstate-ut) is a kernel module for testing
the functions of amd-pstate driver.
It could import as a module to launch some test tasks.
1) It can help all users to verify their processor support (SBIOS/
Firmware or Hardware).
2) Kernel can have a basic function test to avoid the kernel regression
during the update.
3) We can introduce more functional or performance tests to align the
together, it will benefit power and performance scale optimization.

We upstream out AMD P-state driver into Linux kernel and use this unit
test module to verify the required conditions and basic functions of
amd-pstate before integration test.

We use test module in the kselftest frameworks to implement it.
We create amd-pstate-ut module and tie it into kselftest.

For example: The test case aput_acpi_cpc is used to check whether the
_CPC object is exist in SBIOS.
The amd-pstate initialization will fail if the _CPC in ACPI SBIOS is not
existed at the detected processor, so it is a necessary condition.

At present, it only implements the basic framework and some simple test
cases.

TODO : 1) we will add more test cases to improve the depth and coverage of
the test.

Please check the documentation amd-pstate.rst for details of the test steps.

See patch series in below git repo:
V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/ 
V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/

Changes from V1 -> V2:
- cpufreq: amd-pstate:
- - add a trailing of amd-pstate.h to MAINTAINER AMD PSTATE DRIVER.
- selftests: cpufreq:
- - add a wrapper shell script for the amd_pstate_testmod module.
- selftests: cpufreq:
- - remove amd_pstate_testmod kernel module to
  .../cpufreq/amd_pstate_testmod.
- Documentation: amd-pstate:
- - amd_pstate_testmod rst document is not provided at present.

Changes from V2 -> V3:
- cpufreq: amd-pstate:
- - adjust the order of add amd-pstate.h in MAINTAINERS.
- selftests: cpufreq:
- - remove the call of amd_pstate_testmod.sh from cpufreq Makefile to
  main.sh.
- selftests: cpufreq:
- - add explain the goal or intention of the AMD P-State Unit Test
  module.
- - modify comments.
- - use the checkpatch.pl to check my patches.
- - add conditions judgment before formal test.
- - delete some unnecessary test cases.
- - modify test cases about perf and performance etc.

Changes from V3 -> V4:
- selftests: amd-pstate:
- - remove script and test module to tools/testing/selftests/amd-pstate/
- - uniformly named amd-pstate-ut.
- - check current architectures and cpufreq driver in amd-pstate-ut.sh
- - delete codes about conditions in amd-pstate-ut.c 
- Documentation: amd-pstate:
- - add introduce document about amd-pstate unit test.

Changes from V4 -> V5:
- selftests: amd-pstate:
- - add print the current scaling_driver.
- - add amd-pstate-ut.ko into TEST_GEN_FILES.
- - move "insmod/rmmod amd-pstate-ut.ko" stuff into script amd_pstate_ut.sh
- - add a check of read back from X86_FEATURE_CPPC in get_shared_mem().
- Documentation: amd-pstate:
- - delete the test step about insmod/rmmod amd-pstate-ut.ko

Thanks,
Jasmine

Meng Li (3):
  cpufreq: amd-pstate: Expose struct amd_cpudata
  selftests: amd-pstate: Add test module for amd-pstate driver
  Documentation: amd-pstate: Add unit test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  85 ++++++
 MAINTAINERS                                   |   1 +
 drivers/cpufreq/amd-pstate.c                  |  60 +---
 include/linux/amd-pstate.h                    |  77 +++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/amd-pstate/Makefile   |  15 +
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  45 +++
 .../amd-pstate/amd-pstate-ut/Makefile         |  20 ++
 .../amd-pstate/amd-pstate-ut/amd-pstate-ut.c  | 278 ++++++++++++++++++
 tools/testing/selftests/amd-pstate/config     |   1 +
 10 files changed, 524 insertions(+), 59 deletions(-)
 create mode 100644 include/linux/amd-pstate.h
 create mode 100644 tools/testing/selftests/amd-pstate/Makefile
 create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/Makefile
 create mode 100644 tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.c
 create mode 100644 tools/testing/selftests/amd-pstate/config

-- 
2.25.1

