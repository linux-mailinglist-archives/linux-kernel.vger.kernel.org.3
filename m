Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3A5302D2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiEVLzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343671AbiEVLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:55:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF55F2CDD0;
        Sun, 22 May 2022 04:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW6472/SocVR/AQ6zYc18S756JGSjVhH/2TjrPXPpT9ZkmRzb7nxiqlKLvokpBrh20Ci+tZoLgh3LOW1b9cC6wS4xT7rL7T8xcM2pMR+8kG425Nrji4Z4IazHJ/m+E5HNGhuHmnFRjRuiCFHjZYFgP5hjUcbepCKpP53UNZAVhkQ4xZmhZDqj0OZZmJZ41NNZ02NHBzi7oAWAJEJm1CiWfN0qscmISWi/FCX5k0iNojPVjAhgwWfsZ3Yv/fmB4IVxstjuV+eHk22ZGoGLihrFk9s95NabwATfDVVcf284R1hoTgpbOQufCGV5FIyIznQqxSVc1rM06MiicbQ1chqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaZpx7mCdlxykciQ2vD5zUulSViy7eGhso2iX3ld8jw=;
 b=obYUX7BcDqeIrvJdmT++EQGmQFTXi2OZMEGpTNAl5fXUpLR1c6iVW3tmcLm4i+VsfY0NBSJIvPOZJAtrMKgf6rMg45pZ59rzuMZrcJh1WR0w5KhsqIHQ7U+G7+2pDy4Scc/e5wsyxY2re7hzaDxfWSXk04FKMf+ciWrwZ9akQUsvXYA3T9+2cjFK4AuTJWsbCg0WWTe3DPb5RByGQNk/7e5UoXQF1ITCHyUylJzMEDFTlaWWjJNJT6Uta5GaA4ptpgJuAQA4V3OuIqVlW7jvtxUH6+HExlR4It7l+k3xHMuIsTv1EFJcZmldaiksfMXmqqc/AT/EpTCN0LvkEi5Q6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaZpx7mCdlxykciQ2vD5zUulSViy7eGhso2iX3ld8jw=;
 b=fqdDQykjWnUL6TFtTcTurvtnsImqPMCcD+S7ZCV3DxXSp9Mx2totEhtRlO+poVkWD/Z4Bc6MOIeCvsbmELmrgO3ePNkzjtmqv+pqFGdeoitd8oz8wJo+IAgYPkWN7rjL+lwMa1emnfr7Yn8wgU3+9CExIqn10vJl4VbCDkhf9a0=
Received: from BN9PR03CA0212.namprd03.prod.outlook.com (2603:10b6:408:f8::7)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Sun, 22 May
 2022 11:54:57 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::e5) by BN9PR03CA0212.outlook.office365.com
 (2603:10b6:408:f8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Sun, 22 May 2022 11:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 11:54:56 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 06:54:52 -0500
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
Subject: [PATCH V7 0/4] Add unit test module for AMD P-State driver
Date:   Sun, 22 May 2022 19:54:19 +0800
Message-ID: <20220522115423.1147282-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 245b4e78-10f7-4e74-d749-08da3be9e42f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573456867FF14EEFAC6D233F7D59@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnmJSClmPP9Inrkd5Nk2pUekEq538t6CM57M1UC7O9plsNTO5gI2FAnkWGKbNl8izrT5YxwfR8A7lbi+5QdV0lUgw5eFwp/wzOgReokHzkMj5ZikffesXZPM8pMWhMklS8ebbdolBlGlf6AwtnXG4IARF92HJ7h5dXfvwJwQY6nm5hXMIfPtYBzIvAcfOq7lyccMGlKaeTt3ehcoDl5kl6FewMf3+KfeYEd3WDoOLBBa7BypOsbglV13pkWd9E3IgK28HXO/2xkupq5eWRKEhOX64Y2cDWrR1KphJ/wohlTrl13cFnWRWCMmBgpRPmnDpFoLqJt2/WrOmfI+mYuNvJBplP/SDGS/Buta5rGv3VRMMRMREnOJVDf62/oF4Br6w9wSkicJrD2Sg5/Z3JRopYJdPhfHrldSztugPDQeOqVfPcDMqNNfFkcXyaRZv6UpL0TM7x0hIBmq7x1JIifnkk4K38hsxfojIe8e+rV2wPrCBjHFZj4Vzo11If4NjL/SVB1WiOq53nzWlhKp3TftClzCgyWtyPe1Ppgoj89L+fzsJ/1MizysYAkYf6lQTjMp6Kayy39MOiXAzJ3bB0YVd3douwcRDta7oUKW9cSWVGZTdjoYLCJb6dSwa1DMKiYjyH/xTeRHDrMOvVjgf5BkEemOBBzuNuFIEgwiuPmapNAGUmI3R3SZgMRHWCXyYVEwhR9+B8NR2Qz+LoUMrHY7sLCmzze9G7d2HMLa1aaq/7KUvFY4Q4irc7BmOjakCXJHy4zuYYZCc/vcF86mNeUNimVDZOQ/WpvTe407esQkKJZ48q3kyVVkUFD9LmXVQBBU454AtodBjOjFgPU2k3TbQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(4326008)(70586007)(70206006)(1076003)(26005)(36860700001)(86362001)(54906003)(110136005)(508600001)(2616005)(82310400005)(5660300002)(47076005)(336012)(426003)(83380400001)(6666004)(36756003)(966005)(81166007)(356005)(40460700003)(186003)(316002)(16526019)(7696005)(2906002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 11:54:56.7480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245b4e78-10f7-4e74-d749-08da3be9e42f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=ham autolearn_force=no version=3.4.6
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
the test. E.X. use the script to trigger the tbench, gitsource, kernbench,
netperf, speedometer, and etc. testing and monitor the cpu frequency and
performance goals change, power consumption at runtime. 

Please check the documentation amd-pstate.rst for details of the test steps.

See patch series in below git repo:
V1: https://lore.kernel.org/linux-pm/20220323071502.2674156-1-li.meng@amd.com/
V2: https://lore.kernel.org/lkml/20220413090510.4039589-1-li.meng@amd.com/
V3: https://lore.kernel.org/lkml/20220421074152.599419-1-li.meng@amd.com/ 
V4: https://lore.kernel.org/lkml/20220427135315.3447550-1-li.meng@amd.com/
V5: https://lore.kernel.org/lkml/20220505022913.329259-1-li.meng@amd.com/ 
V6: https://lore.kernel.org/lkml/20220519134737.359290-1-li.meng@amd.com/

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

Changes from V5 -> V6:
- cpufreq: amd-pstate:
- - add amd-pstate-ut test codes to drivers/cpurfreq
- - add the macro CONFIG_X86_AMD_PSTATE_UT
- selftests: amd-pstate:
- - delete amd-pstate-ut test codes from tools/testing/selftests/amd-pstate/

Changes from V6 -> V7:
- cpufreq: amd-pstate:
- - modify X86_AMD_PSTATE_UT dependencies and default value.
- - modify a brief description of the amd-pstate-ut module.
- - remove kselftest_module.h header include.
- - modify shortform for AMD P-State unit test.
- - add prefix for the names of test cases.
- - in the file operation log, add the file path.
- - add comments about the test cases.
- - correct syntax errors.
- selftests: amd-pstate:
- - delete TEST_GEN_FILES$(TEST_GEN_FILES): $(HEADERS) form amd-pstate Makefile.
- - simplify the judgment about ARCH.
- - add the judgment about cpu vendor.
- - modify the method about load the amd-pstate-ut module.
- Documentation: amd-pstate:
- - update the name of the test function.
- - update kernel log about test result.

Thanks,
Jasmine

Meng Li (4):
  cpufreq: amd-pstate: Expose struct amd_cpudata
  cpufreq: amd-pstate: Add test module for amd-pstate driver
  selftests: amd-pstate: Add test trigger for amd-pstate driver
  Documentation: amd-pstate: Add unit test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  76 +++++
 MAINTAINERS                                   |   1 +
 drivers/cpufreq/Kconfig.x86                   |   7 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/amd-pstate-ut.c               | 293 ++++++++++++++++++
 drivers/cpufreq/amd-pstate.c                  |  60 +---
 include/linux/amd-pstate.h                    |  77 +++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/amd-pstate/Makefile   |   9 +
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  55 ++++
 tools/testing/selftests/amd-pstate/config     |   1 +
 11 files changed, 522 insertions(+), 59 deletions(-)
 create mode 100644 drivers/cpufreq/amd-pstate-ut.c
 create mode 100644 include/linux/amd-pstate.h
 create mode 100644 tools/testing/selftests/amd-pstate/Makefile
 create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100644 tools/testing/selftests/amd-pstate/config

-- 
2.25.1

