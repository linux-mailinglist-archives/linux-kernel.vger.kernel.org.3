Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108C25967D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiHQDro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiHQDrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:47:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AA72879;
        Tue, 16 Aug 2022 20:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj6sSRoyZ69+p4jStfZstVcBlwfD+O8TvLdcziZIYqYAiUIyxik0hE/Bn1l+n52G4YL+cs/q1/BqLgS7si80e9mcbc0TZJaG4y1mmp9KipM8yL7fOfF5drUht2IQ5XfJrpnbs9uawP8EZflYW8DRYQgNLBL+hQA/fmcgwW0aacSfQjROEydED6LkWh3AhNClYHIh/pSKOm+yAtd6sMnbPOjqMRd2mXsLgp/7ZR1VNhSUaIDEnlY/iurbj1gylblAHpSLwEfqQGrD0ZmNMgOySG83XEvijBnxQz7TI/OHk/u9mdF1S2LtDixpeQBfcyu5eZ1HPigIXDJM4PS8yTQxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsRshQ/paRZIC08P5BD6Yx/noh/kgZ31VIcSKfEJNr0=;
 b=S7Gy4aU7Jmej+D0wexbSagH0CSkEgAp+jyBCqMFm/12jGG5JLhOVWgvLaPJcIzqedWebTB71UFlVj/ODMb8K7psYpqe9bbRTvuAYPYdOa3E9iUbmUup/+86OqgZEB+TczM1eaCntBi0zfypYFXldP5lwZ//EifdNQIAQOlr9Pq9tp9UWWvSuorB1IJgrcJckCza/BgSEn7R4kEcfLkK3NJmNtEp1k9UyYQtTYkquwpkOjnk7twipCglZYB3Ecn+nrzBsa1gVQt8JGhOF+G7G6NjmN4mqjn1OkkY6362wS7ROM2SLajZwY0DWb20pok7T4L8VjJdYqEE+Fxkn3IfyGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsRshQ/paRZIC08P5BD6Yx/noh/kgZ31VIcSKfEJNr0=;
 b=UuLwci20gvMyKUxDyoiyEon9BcASX2BF2cR6xq5nPC5U7swHFcuyPCuMhMkPxMRUSKuxlJTR/H6aybufRlfuDzpJhwovsQ2DHqTS3IyTokW47E6Fxmec87srUPhWvrr/85jRh6USZqEC9iV/6BWgVV4olNVAtp6Sm0VIVt/8nAE=
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by BYAPR12MB3623.namprd12.prod.outlook.com (2603:10b6:a03:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 03:47:36 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::eb) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Wed, 17 Aug 2022 03:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Wed, 17 Aug 2022 03:47:36 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 22:46:53 -0500
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
Subject: [RESEND PATCH 0/4] Add unit test module for AMD P-State driver
Date:   Wed, 17 Aug 2022 11:46:26 +0800
Message-ID: <20220817034630.1172065-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a75546c5-e828-4e9b-542b-08da8003396a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3623:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+6XQ9vONiPP1y/wdEIC8a06gjv8tOOsxDA5oKZu9z4twg6Si5iCGniy1n+hD9/N0qXVyWPMUivJPcehmfVT8Exd3MksnGYEdOWu9B97G31PRkPFgyjBmadjd4AI3mHNB20NLs6RIS38qsDDnNouXmNOa8YBWhiqVlgSQ6PFY5WsNWRkpRrzT8EWt4EPY9nbJH+0eTAikN2Ut/gk/mP0pJqMEq+/Teq/HJIT7xnNuNRlDBydBmzQ7ouP6TpVtoWBKBZqxNdCpJk+C7Y4e1uuqUYj1xftMlwOq7BnTxyt6kNFLqfc7cWlIwySuurO+wreoVRxLjHyuBJFzkNWLzrOM2AadYcluzQ88zn9J1RjX21RMfL0KVch4N/tdXSZRlG7DiPE6FLIhYwD4m5zl6AAgIiRR3ysN+TwgePjf7b0Cdtmds7LSWCxHJe7bzDanpx9uZL5DJpziJkhrA31LOTBG2Elfs4xSjGFx6ZhbYImyfzBYirGPHPZDcQSEPrDgHUIrF+l2MbvhiEzTcGpPdhu70yEH69KMenY8RHssXjKYfcFRpzj8eHPB78jjU/iZKxB0lLoCBabYyvzWdrqSkeIkkpK571Kp/oSzePI4ppENkIH6rxfpJPq0ggKV7Vj7yDZ0iQAOWlqTRsEje33oag+xet5eMFZqJV3oM6kJMmIczIwjiH+meFpiYjytcg5q2T2babbhiDimYe033RqrTTviRiZhhBJVU+SId9phHlk6CZk+mgN/VjnVBMtMv+ZJoLlQ8s+iS71tRpjZoNEHklvK0or91jH8988nxj41T+8J9HjY+PonmacWmMQQau8V9Rsf42i9X5Rad4O3vyCEIUm3JwIHf8lE63esOtpVT2WzhKNh6rAZdozVkTaJuBBv5TXN+trVzg0VP3hzBkBBs80rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(40470700004)(46966006)(36840700001)(36860700001)(8936002)(40460700003)(36756003)(426003)(336012)(40480700001)(1076003)(47076005)(16526019)(316002)(966005)(186003)(110136005)(54906003)(83380400001)(478600001)(86362001)(2616005)(41300700001)(70206006)(70586007)(7696005)(4326008)(8676002)(6666004)(82310400005)(81166007)(5660300002)(26005)(82740400003)(356005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 03:47:36.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a75546c5-e828-4e9b-542b-08da8003396a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

According to shuah's review comments, update the patches based on
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next 

AMD P-State unit test(amd-pstate-ut) is a kernel module for testing the
functions of amd-pstate driver.
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

TODO : 1) we will add more test cases to improve the depth and coverage
of the test. E.X. use the script to trigger the tbench, gitsource,
kernbench, netperf, speedometer, and etc. testing and monitor the cpu
frequency and performance goals change, power consumption at runtime. 

Please check the documentation amd-pstate.rst for details of the test
steps.

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
- - move "insmod/rmmod amd-pstate-ut.ko" stuff into script
  amd_pstate_ut.sh
- - add a check of read back from X86_FEATURE_CPPC in get_shared_mem().
- Documentation: amd-pstate:
- - delete the test step about insmod/rmmod amd-pstate-ut.ko

Changes from V5 -> V6:
- cpufreq: amd-pstate:
- - add amd-pstate-ut test codes to drivers/cpurfreq
- - add the macro CONFIG_X86_AMD_PSTATE_UT
- selftests: amd-pstate:
- - delete amd-pstate-ut test codes from
  tools/testing/selftests/amd-pstate/

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
- - delete TEST_GEN_FILES$(TEST_GEN_FILES): $(HEADERS) form amd-pstate
  Makefile.
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

