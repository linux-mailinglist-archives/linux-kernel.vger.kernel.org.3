Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78452D50E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiESNuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbiESNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:49:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4922BDB;
        Thu, 19 May 2022 06:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDjoGXBfdv4YWc24z4ktAknHCKJWGxVkLz402zfspu564JEPClv6fwNefAYNoSTdmqOtpWUdAbR3lV2UzcvBzIBH1UZGJo0wuB8QwK/xLTxVUVcxdY7pTcQnwUngv15/q4NKAlssc2Hv9RsVJC0arFN4Ji6eEbs1gZfQwuvrSZLcqo6UngG/d+YaB0ss3OYesmSQbMQwwLLkhk3GJG9rs9iJLtV+sIW4mdGYLOO4Q2zAYi5A1X9+ADrrWiYUff1x8xsjx6PHYs4zxFujYSPno0Nxpbo1in0bgw8AqODpWiz9Qtg4AzZO3YigW8C5riaRzTiUIwLks0rFxbaEpFPFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLmwWQZUqP97jUg1+MjO3pUICs4LXiAjz+nWYZn0J1E=;
 b=Xave0ILWUhD5U+bDJaQ3ARGiDzqi6n55o8Ezis3RseIv/vNdGPzXCC8XD/INpede6D8LI1z+bOuuA0ULEQeCbB5lgLpYytm7KYFXi933+aRr99Y8eztQPiNJ2h77Ub9Vi4icb31vHNPigpxgZQs32+r0Zp4ycyW6SNRfL2mp+wQD2RVd16cqmCG52GweNm0R81ayykzWOITJMxYdlBiHR1ZlPg2A582ObVqvPZ1F7OSW7VK9IZQkY3Usvq6ss/4EmV1YA2zmTLNg8zLSaC9D7tKqgHvm/fuOVKz6Y9YbOwm9KSdiV8lae61qPfdbvvBYBBWubQ1MX7w1CEJuPdAADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLmwWQZUqP97jUg1+MjO3pUICs4LXiAjz+nWYZn0J1E=;
 b=h3RmVh2a63psniaD2hBK+MmYQBH97YZYtbls44sHw9dlOcA6w9nEpPtDrepnx+8WQN4UngHm98GLsJfG06Mrh8UslRA8tREooL6yS+ADfIoJjhosJ/MANPjU4LwTScqG/LuQ9uFsSrp+y/rmkTCfhy5Hw36H6ZSHCTHoW10DR3E=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 13:48:13 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::10) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 19 May 2022 13:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 13:48:12 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 08:48:08 -0500
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
Subject: [PATCH V6 4/4] Documentation: amd-pstate: Add unit test introduction
Date:   Thu, 19 May 2022 21:47:37 +0800
Message-ID: <20220519134737.359290-5-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519134737.359290-1-li.meng@amd.com>
References: <20220519134737.359290-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6dd3333-74ac-4100-bd0e-08da399e37b9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3191:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3191744DADDA07767AA07FDBF7D09@BYAPR12MB3191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6hJA53/y9aZEk3LqNDenD/L+K1JioOevr3XCZ9+d/SNN/Cq1OSrTLx5VWGiAsYZdlTu10EtV0YHi8mT9s+QiYZo6OiaIHYu8nAeVeWzArRmDxhhOUVUc/hb2QtUbOiFyflylp78EQkcHgO0rMxOugAYM/wXKs+UXCIVN19z+No2daqLdhDtpJ5FbHVOWxdqW+H+CazWWuIwWrGGx6mwZ2umanVh1jew231/GJdYzJX33SwFpJ6HkFn0VVS9FBn2oK2Y3ZwS4tXzm5W4UPqvR1pssr8gGA48F7T1u8o8P0oOU8nVnhdUFzhB5DKMWWFHiyKaiAmAnC9yLR59lRpuOPHnrv63s0n1mAZy60a36OpmrIW5G2SuyIDfIzH3kml6m1UCO+dPlonaIPcqwEOMItXRXjOv9YTX4F5v/6tRhrgN0vbzaWWx+MbEQgXhvBGUIHfAjknB6K55ZCMfKxrQF3x+Sz5sCXLexu2Uqtb8H/CfxoMD3R9Y+GJr6zCcO7RdGzmgFEa5PmZXy8uvIyPpD/lzci/QkupYs9tQkNdO29Q9A00QZ3vFl7hDehN5IUvVTHCVDtLzhNd+ijjXnwP0+J1EhOVthJQM0bPso4o4PuZ8AqaTAfR5CLW5Kc/olnYvOGuYJHrfQlDvkHweDQGe/SA8xY3BLhniik90qNhQMxKY1OXcGnTGPergqhFjQerCaW4O3ljEJLM5IM/9EinA6gPoohEW8gVY/y+wOMdd1m9nUdAnQeunYSMgdsB6L0lY3j5ENpbcefoAamvX4WYLpWzlSYWb2d8c4/0o1QoedXy6EgKD+Rree3RUlvu5T6iHPeyt12Mg7xhIF377UkSC4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(966005)(2616005)(26005)(2906002)(186003)(36756003)(1076003)(8936002)(5660300002)(8676002)(81166007)(70586007)(4326008)(336012)(82310400005)(426003)(508600001)(70206006)(47076005)(7696005)(83380400001)(86362001)(356005)(110136005)(40460700003)(316002)(54906003)(36860700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:48:12.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dd3333-74ac-4100-bd0e-08da399e37b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the AMD P-State unit test module design and implementation.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 84 +++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 83b58eb4ab4d..222e4f5fd817 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -182,6 +182,7 @@ to the ``struct sugov_cpu`` that the utilization update belongs to.
 Then, ``amd-pstate`` updates the desired performance according to the CPU
 scheduler assigned.
 
+.. _processor_support:
 
 Processor Support
 =======================
@@ -282,6 +283,8 @@ efficiency frequency management method on AMD processors.
 Kernel Module Options for ``amd-pstate``
 =========================================
 
+.. _shared_mem:
+
 ``shared_mem``
 Use a module param (shared_mem) to enable related processors manually with
 **amd_pstate.shared_mem=1**.
@@ -393,6 +396,84 @@ about part of the output. ::
  CPU_005     712          116384        39        49        166       0.7565  9645075 2214891 38431470  25.1   11.646       469         2.496         kworker/5:0-40
  CPU_006     712          116408        39        49        166       0.6769  8950227 1839034 37192089  24.06  11.272       470         2.496         kworker/6:0-1264
 
+Unit Tests for amd-pstate
+-------------------------
+
+``amd-pstate-ut`` is a test module for testing the ``amd-pstate`` driver.
+
+ * It can help all users to verify their processor support (SBIOS/Firmware or Hardware).
+
+ * Kernel can have a basic function test to avoid the kernel regression during the update.
+
+ * We can introduce more functional or performance tests to align the result together, it will benefit power and performance scale optimization.
+
+1. Test case decriptions
+
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | Index   | Functions                      | Description                                                                        |
+        +=========+================================+====================================================================================+
+        | 0       | aput_acpi_cpc                  || Check whether the _CPC object is present in SBIOS.                                |
+        |         |                                ||                                                                                   |
+        |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 1       | aput_check_enabled             || Check whether AMD P-State is enabled.                                             |
+        |         |                                ||                                                                                   |
+        |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
+        |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
+        |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
+        |         |                                | request from AMD P-States.                                                         |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 2       | aput_check_perf                || Check if the each performance values are reasonable.                              |
+        |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 3       | aput_check_freq                || Check if the each frequency values and max freq when set support boost mode       |
+        |         |                                | are reasonable.                                                                    |
+        |         |                                || max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0                   |
+        |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
+        |         |                                | the one in ``cpuinfo``.                                                            |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+
+#. How to execute the tests
+
+   We use test module in the kselftest frameworks to implement it.
+   We create amd-pstate-ut module and tie it into kselftest.(for
+   details refer to Linux Kernel Selftests [4]_).
+
+    1. Build
+
+        + open the :c:macro:`CONFIG_X86_AMD_PSTATE` configuration option.
+        + set the :c:macro:`CONFIG_X86_AMD_PSTATE_UT` configuration option to M.
+        + make project
+        + make selftest ::
+
+            jasminemeng@jasmine-meng:~/amd-brahma$ cd linux
+            jasminemeng@jasmine-meng:~/amd-brahma/linux$ make -C tools/testing/selftests
+
+    #. Installation & Steps ::
+
+        jasmine@jasmine-meng:~/amd-brahma/linux$ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
+        jasmine@jasmine-meng:~$ sudo ./kselftest/run_kselftest.sh -c amd-pstate
+        TAP version 13
+        1..1
+        # selftests: amd-pstate: amd-pstate-ut.sh
+        # amd-pstate-ut: ok
+        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
+
+    #. Results ::
+
+         jasmine@jasmine-meng:~$ dmesg | grep "amd-pstate-ut" | tee log.txt
+         [76697.480217] amd-pstate-ut: loaded.
+         [76697.480222] amd-pstate-ut: ****** Begin 1             acpi_cpc_valid          ******
+         [76697.480227] amd-pstate-ut: ****** End   1             acpi_cpc_valid          ******
+         [76697.480228] amd-pstate-ut: ****** Begin 2             check_enabled           ******
+         [76697.480253] amd-pstate-ut: ****** End   2             check_enabled           ******
+         [76697.480255] amd-pstate-ut: ****** Begin 3             check_perf              ******
+         [76697.480554] amd-pstate-ut: ****** End   3             check_perf              ******
+         [76697.480556] amd-pstate-ut: ****** Begin 4             check_freq              ******
+         [76697.480558] amd-pstate-ut: ****** End   4             check_freq              ******
+         [76697.480559] amd-pstate-ut: all 4 tests passed
+         [76697.482507] amd-pstate-ut: unloaded.
+
 
 Reference
 ===========
@@ -405,3 +486,6 @@ Reference
 
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
        https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
+
+.. [4] Linux Kernel Selftests,
+       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
-- 
2.25.1

