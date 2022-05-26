Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BFA534978
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiEZDr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiEZDrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:47:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28443257;
        Wed, 25 May 2022 20:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRRbs7YFwzCqO5WJVMSPSerRhbmdZ3gzrzWghBwtVuMSuv9NGYpYN7gqWcGmqupgOJ5MSpr/TCCLI36Mln+jY6QWBI9IcmzCdKuSif15xg4zZ3VN1pNB389gcolVruf2XOS+8HajWz1MzM4JdOH0D1hbIVG7Q3bjCPE+WPoBGZFd82Eqs0cbi648O8UZOvjmn2Q2JQMJ687ngeRMjhZxg2MLKwW6pY3n5/9FO2UFIykamGAVfnzHWj+AvSXIQuBaPs54xuUjGqhAO0Z+lcJraoGkYPd7RfyDNO+O+Tz6e7LipZyc7ar0RKugo6+AVEAIkv1HMUUBbIjLWVvFCPqnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+Ejk4YeBfl8BJ1TV/rkBEJMhcy/0dv1fZso7p5Adrk=;
 b=N2Vfun+SWZanLinBgx74RSGyV0uoXFCuxlLQsN/t/3LO7b+UFUWyozsHLxZcnFrUHqA/PAEDZ72+ykhjUDS7y2hrwCcBi+n9JaxrXKTh6yo5BCwOx6xN7Rcg0WtB8tBQYpkT7qrmZeo/HtICFYgWOEIAvO9hj3cKE4Q1tA/MI9Vi63Kf3eBZZ1muMkyUC/VKf4kfMPq3/vgoMSdFvAtWpkm11qW3wjnEx7XxjHC7fa4uFem0drVGb9G7ccv7I/BDnKKWcN1zzId+iqyXEmqkQef20y1IKtMR9CYKZ6+36KGASD4op8k+otqqfycgG6JYm6HyFjLwYMThItWKeRLU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+Ejk4YeBfl8BJ1TV/rkBEJMhcy/0dv1fZso7p5Adrk=;
 b=Y29/nf0NoEg6TpF9ksxGXuLWwzFgU42DbfAFmXptk4Gva3ppQ58eoyNEwET53IZUq8i3tgZ+Qan5cX+8oTyFYrYrb9du98vz9N6UoW9OrCMWha26FIdTK7L/kl4DHxOFuskuTGzMzDbgtFZSjvJL0FVSBFj6CqihDSr3rkNhVww=
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 03:47:46 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f4) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 03:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 03:47:46 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 22:47:41 -0500
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
Subject: [PATCH V8 0/4] Add unit test module for AMD P-State driver
Date:   Thu, 26 May 2022 11:47:21 +0800
Message-ID: <20220526034725.1708916-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f10f127-eb89-41db-dad8-08da3eca7f51
X-MS-TrafficTypeDiagnostic: DM5PR12MB1164:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1164DD552F0760B908DC3418F7D99@DM5PR12MB1164.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2UBM3asoOop2fspPVTlNy/lFWGge2KZMfDgXL7y5P6fyWIjMXQ2H9PvssBC6yqOOLbC6R7/WbNOi+R3CPJ+yFD1aOx792L/JkSwM6hX0k8rkmlWd6wZ1X+9L9gBescPquq+pmk2fsS/CoRgXG2aYDX/dH8hYTZueW8nN/cbHB1XiVVxeN+TrZHNSF1ZTAHOvTbi6bDueo41ltLpcrRE4O4saLQM4mCphD72q3zZd8KAhq8MuGLEe822tiZXEUjKTpyTfuxEe6EO3FA6EMYKkEdDpy5+nYilbXv7xKQFm8cUL2hynb19xo/q64zpGhkIeHOsxxuAxLhDrZvVVrLs0EtTQW/lV4bn4Oh9w5nEUC0j4xbOvGzcfQ1Tauv5JpgphYZ757eCZJBeFnFSNtkeLp/rlBrgKqTPv7WzWCmrtCXPjdKEHyYRSRHpxwEkKuXfqDb8lp4kYAlFlcuJ39ORJMsFFkUOmhGOAtpo+SBAOgxip61wsvBkfN5CG05VbHhskxFKgxJLd+tnsBUCyBB1N0imH/yyQvsli71P0IST06bY+BvwGCLjRp+SVGb65eisNI3iCP59Nn0/v+1n+HvGSEDEJwhTvLnJFdAw8We+wxZnWPWGadTq3yk+9wgXSZN3GYT1KAUX+C9++j8c8KeV7QV4Fd5oPBRxNrYt9mL8uK7KH4KqIRx/my4n5ajETuWwAe19HfZ3IblWpYjBKcVfhWqLbG7JVCYa6eiss5jKGPMhTJx5ByKwUzGkSK3nVR/blRNhNcsZ6G8dSRrdFMfTg/YCD3CW0VQ5ZA2ijNDpTL/Ibo2VS2ve/ovT02P+dRwHEqkXCP6d/43WUSxjxzv8JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(336012)(83380400001)(26005)(36756003)(1076003)(81166007)(356005)(16526019)(186003)(966005)(426003)(2616005)(86362001)(47076005)(316002)(2906002)(110136005)(40460700003)(54906003)(8936002)(70206006)(70586007)(82310400005)(5660300002)(4326008)(508600001)(6666004)(8676002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:47:46.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f10f127-eb89-41db-dad8-08da3eca7f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
V7: https://lore.kernel.org/lkml/20220522115423.1147282-1-li.meng@amd.com/

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

Changes from V7 -> V8:
- cpufreq: amd-pstate:
- - amend commit message.
- - amend module description.
- Documentation: amd-pstate:
- - amend commit message.
- - Remove the personal data.

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

