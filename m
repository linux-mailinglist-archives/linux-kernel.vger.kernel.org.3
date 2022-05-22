Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32F65302D8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344083AbiEVLzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbiEVLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:55:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D93C70D;
        Sun, 22 May 2022 04:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlGHjVaaGPtzcayYg6bVmgakTdO5jsEQ4FfodDCHYpPAlzVyvlGW/RZ3646PBvvl2zNKb9/9jrHXN5opu/VyQQv3Mdtcm58XpMlgQyTiStL86DrVJFrYwxqfn6OlTdM0OL7QQ7emEvMfutTGZAkG98thCiUXX/U96IfCypTBb99QKWHHm6Yyhq9V3WZrJug3Eln7JAJ7H716kVBvEpz/xtb+CxJXplYIg1SBj/FnZK+pK9KeWWdkFhy+xOzB8U1RmfhqeJ2fZD0fKrScJgBXjlAHiB+9ZFi2cHTO/GlF09BLMgObE4aBOQntB6hX6BEm0Cq99WfAC2pX5C27ZH38Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd2JK34WkxM19if/uquLUPTM8R7MNjHeR5olxZBm3Pk=;
 b=OFi0aafra3Xfc14NlLQifExHIBok8nI83quhoh2wSEBImLT3fmxz2cEd8+/kjwdORahh4qbQeFUfWnHcYkavBS7ZrINNOfGzznjBHJhKPn0rjeGPvjBJTk6YDdy6TqEz6v/awmWepCAOkGLpKyK7EMtL9iOYGxj3CVtYMQNoAmTLHAYN9nC8JgI2iOGzBAfCNIIJwBJD24H5w/0ecHSwPt8eiaBFpneDaYJ9IRU2rjDvNqb4DqZ6Fu3MzBiqqeTJg4HsWrpzlLE0GKb0xN+zEc3uVpxFj4N010y1E71N0fbJGLTxBUAZrptHPUo19W5RP1i7Ifikt+1sziux8OTxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd2JK34WkxM19if/uquLUPTM8R7MNjHeR5olxZBm3Pk=;
 b=1JBY4kYDyUOha6hjeSU0LvPfVWSMo5SrErmLKXFsg4p3VeT5+rd8wEa42h5gNkxOR8844hiSFB407wMm/2Mftk6EVWAtvE+v7XWA8ovuehb7D/yC5QEXG6T+MGqEymc2IFy3oQAVDSrtuDlaJ9zCUG117HegyYU5h5PCtR5siPU=
Received: from BN6PR13CA0044.namprd13.prod.outlook.com (2603:10b6:404:13e::30)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Sun, 22 May
 2022 11:55:12 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::b3) by BN6PR13CA0044.outlook.office365.com
 (2603:10b6:404:13e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Sun, 22 May 2022 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 11:55:11 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 06:55:07 -0500
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
Subject: [PATCH V7 4/4] Documentation: amd-pstate: Add unit test introduction
Date:   Sun, 22 May 2022 19:54:23 +0800
Message-ID: <20220522115423.1147282-5-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220522115423.1147282-1-li.meng@amd.com>
References: <20220522115423.1147282-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1fef3e-d5c7-4690-eaa3-08da3be9ed41
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45786E76C28C8F1582E128CEF7D59@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eW6Jxj56yDPnGrLqml4VDGfM0YGffCbbAmQrzOAeTfSq3t3si0hSa5CeMzg3jI4zewk4/KxpkWod6dLuOwKvxh/kMsa1j9P3BEZ6Jq1mmB732Y+MyiXAsT/51nzvtZ21n72WT7t8AslDAOCAkILqfBd8fk6RloSzsvsOG4v+kGsv9kesCC1rbcm+9ib6qf9v1z9MQVQgnquux7790RLhFKPAdQiT4JVimWErNYW+mmeym2lp7hOF6e0hIMxs2ZRP8np+ykLs4g5OAGh40fUz40/5hh4OnDR+WVomQGoq2NyAdDdZI/AaBPExHthYqXrXQGIoVLUlTwGkdtNL701sX+FcJfSS261yfmRTLnJD2uDeDFojzwvTTJHd8ZNA+mlDmcjzagAGwGUy3p1/NWvYdkh/3xifGHDEIH0nnoSKHgHDoSBK+3dD4YGqKb2P6nftRCtExvZR25631Mr9+cxmtAiAdyyxHrLVdDsIPj8RkjleHEDOggwtLNW/K4iS5yicih1ibN2E4ZEURdnWJC8NAmXBzqJBykbvat+jw9qPwK8DpIncWLCiicUdXLzlZBz+qz6Sj2G6zq29IEomjF+qZAAcuuq8MzEyvV2u0AV6JTqY+4I368caUvXuaHcNXYPvqG2P+AKlSKbcy8nT0FnJg/sF+Tlk5qmIxTpnefMy6k1mHc7dkPY1+P822b5TQzFcBnJ/4AYQXqP453jq25ZgO4IqwleK8NjeAt0XM1iwoeX5zz2qlqtC8bTwD7xlzRYEa61Fj0XwHDXJsWHWEYEX14fP4f/w7aAlycGqwrn9nSIKcCwgq/g3f+Z9e31azyPw9Fmzd9aFpqBf9U9NCsXuhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(47076005)(336012)(54906003)(8936002)(16526019)(1076003)(2616005)(70206006)(70586007)(2906002)(426003)(186003)(4326008)(110136005)(8676002)(36756003)(83380400001)(5660300002)(316002)(26005)(508600001)(82310400005)(6666004)(7696005)(81166007)(40460700003)(966005)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 11:55:11.9504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1fef3e-d5c7-4690-eaa3-08da3be9ed41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
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
 Documentation/admin-guide/pm/amd-pstate.rst | 76 +++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 83b58eb4ab4d..c2b8693601aa 100644
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
@@ -393,6 +396,76 @@ about part of the output. ::
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
+        | 0       | amd_pstate_ut_acpi_cpc_valid   || Check whether the _CPC object is present in SBIOS.                                |
+        |         |                                ||                                                                                   |
+        |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 1       | amd_pstate_ut_check_enabled    || Check whether AMD P-State is enabled.                                             |
+        |         |                                ||                                                                                   |
+        |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
+        |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
+        |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
+        |         |                                | request from AMD P-States.                                                         |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 2       | amd_pstate_ut_check_perf       || Check if the each performance values are reasonable.                              |
+        |         |                                || highest_perf >= nominal_perf > lowest_nonlinear_perf > lowest_perf > 0.           |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 3       | amd_pstate_ut_check_freq       || Check if the each frequency values and max freq when set support boost mode       |
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
+         jasmine@jasmine-meng:~$ dmesg | grep "amd_pstate_ut" | tee log.txt
+         [12977.570663] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
+         [12977.570673] amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
+         [12977.571207] amd_pstate_ut: 3    amd_pstate_ut_check_perf      success!
+         [12977.571212] amd_pstate_ut: 4    amd_pstate_ut_check_freq      success!
 
 Reference
 ===========
@@ -405,3 +478,6 @@ Reference
 
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
        https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
+
+.. [4] Linux Kernel Selftests,
+       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
-- 
2.25.1

