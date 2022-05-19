Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CBC52D513
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiESNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiESNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:50:23 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923C1ADA8;
        Thu, 19 May 2022 06:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9KnTg7UCycog7m9iPHuPOTmsmL/b9jO0Ohlgf+Yym6ReovsSKkH6gDD/yyzIN0bxg/N8AtQ5kgM48Nktz7Yu9fObacFo7HtB0svUVZfFRaE66gFVJGJv/39E2F0pP3hw2gzJwmUS7NCW/suXn8yQr7FyNlipGc/Tgw+HG7BmuE17ZZv6samalhCImtwHy5ZJyVjcgzzE/nwpFaXdwz7n6m9VttpquKT4di14g5/B9dv4uLkUTh2kautsjhbJ1uogF2VeRe+D0C4Swa74VjiS+8od7sNy3epx9eLZr9Wj2URyWfl/UN/geNDzRHJ9KQyvf4uzdsaDv504tcS8NLCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jChhSp1yFME/28oSlxHG0PQNddb8/nx5ITcjib2DrtQ=;
 b=jQZoAmHm1aGcU1CH1Fh9070FPJBhJB/XeBDwSVksVWkNay2LcMSrV4m8D5GVKw6dVDbxVL1EVpS0YqAoI/oGMQ4ckn4aavYqX5/LL/90toQabZDZEkUKWko4kSociyEiGqjo69cQiJLEkZPFV+2OPEdvGtf6lCX/Uzb0y8n/bTJaxpdAqmdviQaWl3LsT7KwMSv+i26grb4vHYBAZb3xGmR9vR8HFA5oritv4aslres6w0tQEFaNsZ+ZXP3pZ+aAugYc+zd803j34W3YG10i5XdmzXs9tU6j4E1fKjtI3ghJXwM8er1XS2BNQKeW887doLht46DTqianeeqNtxiGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jChhSp1yFME/28oSlxHG0PQNddb8/nx5ITcjib2DrtQ=;
 b=d23giIzRWiCKy5TpdItEZNb7nhN8KyZmBMUW3ggiSV4lZlF9keLXynJUweGQLefd1RPG+IYMjBzg/HaX0gyD5aP3rxfyfXM6qSFO7SQpAjmpO1vnWW3GHgSl4xOWfn06sbVfCVAkcNHo2WBQIbV7XUxAwfbR8jUu+5hhLdylkmA=
Received: from BN0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:408:ec::10)
 by DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 13:47:57 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::8a) by BN0PR04CA0095.outlook.office365.com
 (2603:10b6:408:ec::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16 via Frontend
 Transport; Thu, 19 May 2022 13:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 13:47:56 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 08:47:52 -0500
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
Subject: [PATCH V6 0/4] Add unit test module for AMD P-State driver
Date:   Thu, 19 May 2022 21:47:33 +0800
Message-ID: <20220519134737.359290-1-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66476098-2784-47c7-ad6f-08da399e2e2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2794:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2794E4E13D5757A702B5D248F7D09@DM6PR12MB2794.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNegfr3IZbXEPCs8bOtYfz4mx60wEINk2wPsXFMHGfzMwQRbOXS/5Kr/TAD1Js61gAN+QXz4rk+sWpeJGGQCjESoIOdj91Tpc5ZGUMAvOio+MRDQGxOQbnpd+PsVWmSl12yu3aZwi5WdW0bQjRPPKaGgVd/yFi4eEYpnHGN3QUT/u+c25ZNzQKPafJDD69Nkf2tOdIsmtQ0Wug3wNI1aWp+wlimTG4eJvFN7kJGBwim0dVPX0IyqbGbkavZQGd8AYQ63/2CT/dASRN/sJ7e1sIWoRbGaXN50CButNBsxiqOj7zjPdCnte9rCDuo6hKdb28ntkfIwZxOm1ZJmI5X8DuiX9+LkKbxhyxUcvTejDKivlP5OhL+l+QGcPqAQrkMTPx+IWHpsR5EvQCSAq6Mv0uuNr7QNaEGNV9SpYsbVpNovfjuah6EUNHXUk3LS8fdsg0YQWhA6yzXNxsL8SCcflZSXhFGdc/U/Kj/Aj86ZgUbaDV1VeOgEUysPc/MIEovBjcKGOVettTLUW6gB1lMjBbgjDmGv3mDCwLcNLeInNYGUWOKfOi/1Eag6XQHAJVtMTzCz5iHlHWPbj2osIn/Mn3ixIxHKnCKWSIYbhnLvHF9WTm4ZFHcqhewQYn9DZkUwXWPfvtJFaR0qputBNDyECTp1YJBY3wHCm+/0ji/kxR9+RuKk8S+6eGZk0RxLRj8fUidkJUQQ6UwpJleAJ0+5Nt5Y9Q6Ai4qDaQpgwcnpa7gEe2ck6kNIcFOPoxzBEGIvLGorp5kuzDuv3LLxuvjNZvFlJv9H7dhrlZ78ec2SbkDUyPq5SA9MKAhOte4ZNxK+Hd77k+qNH4HHuZHg6HWAJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(966005)(2906002)(6666004)(47076005)(82310400005)(316002)(508600001)(70586007)(70206006)(4326008)(8676002)(7696005)(336012)(426003)(54906003)(110136005)(40460700003)(86362001)(356005)(16526019)(81166007)(2616005)(36860700001)(83380400001)(5660300002)(8936002)(36756003)(186003)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:47:56.8214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66476098-2784-47c7-ad6f-08da399e2e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Thanks,
Jasmine

Meng Li (4):
  cpufreq: amd-pstate: Expose struct amd_cpudata
  cpufreq: amd-pstate: Add test module for amd-pstate driver
  selftests: amd-pstate: Add test trigger for amd-pstate driver
  Documentation: amd-pstate: Add unit test introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  84 ++++++
 MAINTAINERS                                   |   1 +
 drivers/cpufreq/Kconfig.x86                   |   6 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/amd-pstate-ut.c               | 278 ++++++++++++++++++
 drivers/cpufreq/amd-pstate.c                  |  60 +---
 include/linux/amd-pstate.h                    |  77 +++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/amd-pstate/Makefile   |   8 +
 .../selftests/amd-pstate/amd-pstate-ut.sh     |  34 +++
 tools/testing/selftests/amd-pstate/config     |   1 +
 11 files changed, 492 insertions(+), 59 deletions(-)
 create mode 100644 drivers/cpufreq/amd-pstate-ut.c
 create mode 100644 include/linux/amd-pstate.h
 create mode 100644 tools/testing/selftests/amd-pstate/Makefile
 create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100644 tools/testing/selftests/amd-pstate/config

-- 
2.25.1

