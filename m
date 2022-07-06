Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E095B568006
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiGFHh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiGFHhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:37:21 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE7422BDA;
        Wed,  6 Jul 2022 00:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AikVvfv3W4dkSMBa27t5RqP3sK8k65pSec9enHAFOQu4HS1m8DqkGRHfYe8iv94IkmjWNSWkyPNMKQ5c2kAKVat8OIs47fcu8KjFkqZbyUCCEx3iXiQ5Q8QABMpV74KyQGlO4oGjUOjmUPnLY7D4qDdU3ySYhtuwkKw+lu5i5DC/aw3LY7NIcw7xUc2MmZNWalvDSq67o5zYwU8NascEWutvwv/CK1xT0Jp47iLxQzQK6hE1BJ8WQtuQ25ubIR2/xrK/QcQ1FPO9AxovUEE9k66bAPVxW8b0QvWjhwH3x1gNvHD02JA/uN5fVrikFMIfwZU1xF4TgqmLmGJmB2Emgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9jVD8VCQwj175Ua0vVRJi7aq/e/QgeG8zsInv6yQbM=;
 b=fItEhAuZkM6g9UJkHTumC0WRTziZ7HQV7uPmhIEyVrTSzwUAUHE2jQGRMDav6p8sbVA7U4eVCWHIKXmX9HvGfDYeefYgzWFIF2vHDZa1jybPfX4wo2Qkap2PlDlYOUkugV1/p4MhubbS0qymdde29Uk4vi5qr2KTKu+0AeTaOS0BiAWeK1128t4vfpI1CabwnEaD+YC3juYMveaseO3VpVCzZ0k13ay2xXFkJkJtWuJDNh41j33Dq5fu/gGGpKERxhoNTLSj8GOBrorwzxX9iTPIXGI1BMh77Dya77tFq8kNP2c871Q/BwYo+qoM5FXHUI3tOihH2KoCelOmdGlh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9jVD8VCQwj175Ua0vVRJi7aq/e/QgeG8zsInv6yQbM=;
 b=YzfIPc3yAVMme4nHGSew8uHt4uvi4ai9HVpOrbPL3e6sAQlUjRy4aUc2V8ssa6mZg2oAL5/Q67ANfXMotlkzpn91dmUz9suLj1hrpANEMryB4BsQDz9bN8pbvl0X8LGEBlhHZyeAZllWUJKtUHMyuXo1qJGmZd8F0rsCjXnCvkE=
Received: from MWHPR20CA0041.namprd20.prod.outlook.com (2603:10b6:300:ed::27)
 by CY4PR1201MB2503.namprd12.prod.outlook.com (2603:10b6:903:d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 07:37:12 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::9e) by MWHPR20CA0041.outlook.office365.com
 (2603:10b6:300:ed::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Wed, 6 Jul 2022 07:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 07:37:12 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 02:37:07 -0500
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
Subject: [PATCH V1 4/4] Documentation: amd-pstate: Add tbench and gitsource test introduction
Date:   Wed, 6 Jul 2022 15:36:22 +0800
Message-ID: <20220706073622.672135-5-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706073622.672135-1-li.meng@amd.com>
References: <20220706073622.672135-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d2242aa-9b9d-4bbf-0ebb-08da5f225746
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EpgYX8ntRwEFUrGPue6E3L4ezsYuIGrTfCjujGo9bc6vouncqcVAvzJp4enIBbDXQQqlMFXtyVh7nxtOIOAHyNtAQBAtG2kvDJmeTIpB1xvS5vVB9f8C7uq4UQNSw1t0Z1Llb/+3w6AcVGlcE8DBTjSu1lnXAdMP6HNwIApmwQWJ8zKO0ZG6hJeWGS5G7a5HJHVOH+DfSVfQ2ikucOaQBzrR8cDLR/+wb+Avmu7JjGoApft50Aui71lse/3gz8Yylz1Xum5cfvTxgiWw7Hu08N0sqGDudkX0PHTXjKSpPX6KbHfC5VwilaH1hfLM3hjB4OeUh2yVoT9Ymoje81Dtu3TAJDfHeJOXiSC3FnkotIIht9vssW7kmNvRRYhzx4XYoiJx98hhkrg0JtGE846FmjMR1iLTNIJ6qVgHjT+D0ByKw+1KW8guN9bYiGHZHUqcNWGlD7Z8eRyg0xPyrt7M8Lr8Y1LmWMruRaYI9RBUBei05cx53X0nCMut4aennwOuOq0UuYgpqpjwCknpT1w8k3ieLe1riP2askgfL0AA/7SBtrzSTjVxNsNAPa+yqBB6qa1YrlQMVv69Og+FxpWrl6X4zId/SpfBhUP7CEhPxAkOoADF4q72JYFtXn3PMG8en2XyTturQqZxEMb4GG+T+nBcPhkdjYR8JXjsseumj5DHXJRJougrjlwXJQnRKGITJjFqgDPNzu4azkkhLz7T05w1rqkbv4tjXDgNDBAY1qGuBWAR4F2L5Ndu45xEOanHPhsjJ8P5VCm7obMrkwnGQJqz4PKxJUzrACLWHuo2bv05xvTxzh3Tl//xnZH2l43Nd17aBrbsgx9DG5f4zm8a8Nphemzk0cWr3neQYJvm/Sy/BqNHvpZ/8oHCmAmnOTl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(40470700004)(46966006)(316002)(86362001)(478600001)(8676002)(6666004)(40480700001)(356005)(110136005)(41300700001)(2906002)(54906003)(82310400005)(81166007)(82740400003)(8936002)(36756003)(47076005)(70206006)(186003)(426003)(336012)(1076003)(2616005)(83380400001)(16526019)(70586007)(34020700004)(26005)(36860700001)(7696005)(5660300002)(40460700003)(40140700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 07:37:12.2363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2242aa-9b9d-4bbf-0ebb-08da5f225746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce tbench and gitsource test cases design and implementation.
Monitor cpus changes about performance and power consumption etc.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 124 +++++++++++++++++---
 1 file changed, 106 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 8f3d30c5a0d8..48fb488e000e 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -409,37 +409,53 @@ Unit Tests for amd-pstate
 
 1. Test case decriptions
 
+    1). basic tests
+
+        Test prerequisite and basic functions for the ``amd-pstate`` driver.
+
         +---------+--------------------------------+------------------------------------------------------------------------------------+
         | Index   | Functions                      | Description                                                                        |
         +=========+================================+====================================================================================+
-        | 0       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
+        | 1       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
         |         |                                ||                                                                                   |
         |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 1       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
+        | 2       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
         |         |                                ||                                                                                   |
         |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
         |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
         |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
         |         |                                | request from AMD P-States.                                                         |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 2       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
+        | 3       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
         |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
-        | 3       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
+        | 4       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
         |         |                                | are reasonable.                                                                    |
         |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
         |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
         |         |                                | the one in ``cpuinfo``.                                                            |
         +---------+--------------------------------+------------------------------------------------------------------------------------+
 
+    2). Tbench test
+
+        Testing and monitor the cpu changes when running tbench benchmark under the specified governor.
+        These changes include desire performance, frequency, load, performance, energy etc.
+        The specified governor is ondemand or schedutil.
+
+    3). Gitsource test
+
+        Testing and monitor the cpu changes when running gitsource benchmark under the specified governor.
+        These changes include desire performance, frequency, load, time, energy etc.
+        The specified governor is ondemand or schedutil.
+
 #. How to execute the tests
 
    We use test module in the kselftest frameworks to implement it.
    We create amd-pstate-ut module and tie it into kselftest.(for
    details refer to Linux Kernel Selftests [4]_).
 
-    1. Build
+    a. Build
 
         + open the :c:macro:`CONFIG_X86_AMD_PSTATE` configuration option.
         + set the :c:macro:`CONFIG_X86_AMD_PSTATE_UT` configuration option to M.
@@ -449,23 +465,95 @@ Unit Tests for amd-pstate
             $ cd linux
             $ make -C tools/testing/selftests
 
+        + make perf ::
+
+            $ cd tools/perf/
+            $ make
+
+
     #. Installation & Steps ::
 
         $ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
+        $ cp tools/perf/perf ~/kselftest/amd-pstate/
         $ sudo ./kselftest/run_kselftest.sh -c amd-pstate
-        TAP version 13
-        1..1
-        # selftests: amd-pstate: amd-pstate-ut.sh
-        # amd-pstate-ut: ok
-        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
-
-    #. Results ::
-
-         $ dmesg | grep "amd_pstate_ut" | tee log.txt
-         [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
-         [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
-         [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
-         [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
+
+    #. Specified test case ::
+
+        $ cd ~/kselftest/amd-pstate
+        $ sudo ./run.sh -t basic
+        $ sudo ./run.sh -t tbench
+        $ sudo ./run.sh -t gitsource
+        $ ./run.sh --help
+        ./run.sh: illegal option -- -
+        Usage: ./run.sh [OPTION...]
+        [-h <help>]
+        [-o <output-file-for-dump>]
+        [-t <all:       All testing,
+        basic:     Basic testing,
+        tbench:    Test tbench,
+        gitsource: Test gitsource.>]
+        [-i <tbench time limit>]
+        [-p <tbench process number>]
+        [-l <loop times for tbench/gitsource]
+        [-n <amd tracer interval]
+
+    4). Results
+
+        + basic
+
+         When you finish test, you will get the following log info ::
+
+          $ dmesg | grep "amd_pstate_ut" | tee log.txt
+          [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
+          [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
+          [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
+          [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
+
+        + tbench
+
+         When you finish test, you will get selftest.tbench.csv and selftest.tbench.result files form amd-pstate.
+         Open selftest.tbench.csv :
+
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+         + Governor  | Round   | Des-perf | Freq    | Load     | Performance(MB/s) | Energy(Joules) | PPW(MB/J) |
+         +===========+=========+==========+=========+==========+===================+================+===========+
+         + ondemand  | 1       | 203.244  | 3.2225  | 87.5064  | 35368.2           | 6626.1         | 101.4164  |
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+         + ondemand  | 2       | 205.861  | 3.24948 | 88.9281  | 34795.7           | 6547.06        | 100.9794  |
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+         + ondemand  | Average | 204.553  | 3.23599 | 88.2173  | 35081.9           | 6586.58        | 101.1991  |
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+         +           |         |          |         |          |                   |                |           |
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+         + schedutil | 1       | 253.735  | 3.26755 | 96.6481  | 34653.9           | 6622.85        | 99.4170   |
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+         + schedutil | 2       | 254.654  | 3.44086 | 92.3564  | 31707.8           | 6573.67        | 91.6456   |
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+         + schedutil | Average | 254.195  | 3.3542  | 94.5023  | 33180.8           | 6598.26        | 95.5456   |
+         +-----------+---------+----------+---------+----------+-------------------+----------------+-----------+
+
+        + gitsource
+
+         When you finish test, you will get selftest.gitsource.csv and selftest.gitsource.result files form amd-pstate.
+         Open selftest.gitsource.csv :
+
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
+         + Governor  | Round   | Des-perf | Freq     | Load     | Times(s) | Energy(Joules) | PPW(s/J) |
+         +===========+=========+==========+==========+==========+==========+================+==========+
+         + ondemand  | 1       | 29.7305  | 1.13025  | 8.49585  | 341.61   | 6811.02        | 0.0501   |
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
+         + ondemand  | 2       | 28.0523  | 1.33848  | 8.16496  | 339.21   | 6999.84        | 0.0484   |
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
+         + ondemand  | Average | 28.8914  | 1.23436  | 8.33041  | 340.41   | 6905.43        | 0.0492   |
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
+         +           |         |          |          |          |          |                |          |
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
+         + schedutil | 1       | 29.6971  | 0.834149 | 9.57879  | 278.15   | 5992.26        | 0.0464   |
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
+         + schedutil | 2       | 31.6573  | 0.99686  | 8.60513  | 280.28   | 5772.59        | 0.0485   |
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
+         + schedutil | Average | 30.6772  | 0.915504 | 9.09196  | 279.215  | 5882.43        | 0.0474   |
+         +-----------+---------+----------+----------+----------+----------+----------------+----------+
 
 Reference
 ===========
-- 
2.25.1

