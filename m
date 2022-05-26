Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D053497D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344887AbiEZDsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344861AbiEZDsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:48:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD96D532DC;
        Wed, 25 May 2022 20:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK+MWbJs17H22fl7nCJPEXcwqOn6SMimo2bGMp59cw0ZHflzS4DHv78J/BgHPDnnYZGqp5u1uQt4jxH7tB9WPfuPU2JaybrL9aZbaWKSAQR0Lg8b+wVud+restgfAJAAbYagO20Qcq7aZ6vrgxUfXXq5+K0sVIt0ULGaKZ1PPIQrc5BQR4TDDa8Mio/XCphBJlMESkR3mEc6AlS/dpA03koWbm9rIYhpxaaeYn5TwftVP2NhIKiGrQe8NWkrRtxksPpy/QXhEz6AQorZ4tagEXiqIN1pEBEzLXOHF5RWUPV56UOunq2zbMGqdVAFziV2osTsm9l2esL4gA7El3f8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYkbSQC2Wb1E40TC6+os9NHgkzLRNn1CGGGEKK5fN4Q=;
 b=B3iAFM0i54mnVOyvycrSp7FnD7SleoqUO/j9ZgXOwVwVA1TiwaYuVE0sq+ogYhBeG2bxEnDm36uK1h9RmpIhIJqSXdlRFLaW7t0uEz5iX92vDy/sS13ybDOyTA3tZU1gBAAEUAVJQ18ZKeXUnux57r62gTPYHwMjHG+RdBKezXE9lfBrDpWQ/qK2noPVpaMib+m86Bk8116KdWEW86be/50vPQzaZ9dVTDathkuK1D8HWPvDN98ePaUvRi9hNpXYpJttpfeIfDmLjnlhRo8Jh+c9RWLEnDVTRcQLAB5oNNdwsYt41iCDsaH0d5/MXybdYAdEwh8TIA83BDzz67godg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYkbSQC2Wb1E40TC6+os9NHgkzLRNn1CGGGEKK5fN4Q=;
 b=jSgIFvcY3JORgueHGtiCgcNbFyeiXJSo9r1RUXCSiiOcPktfgEmOQ1K3RzqqI3/6p3AQsK4BmaaKuoFNaBtaFDARZXoEZndNikjT6fBBgaLa6lxsuSRTbD0bnaT31rrt05nat5zdGehO9Q3UdvYxUbjnakm+10VypLMLaaO3cs8=
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by BYAPR12MB3511.namprd12.prod.outlook.com (2603:10b6:a03:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 26 May
 2022 03:48:01 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::60) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Thu, 26 May 2022 03:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 03:48:01 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 22:47:56 -0500
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
Subject: [V8 PATCH 4/4] Documentation: amd-pstate: Add unit test introduction
Date:   Thu, 26 May 2022 11:47:25 +0800
Message-ID: <20220526034725.1708916-5-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526034725.1708916-1-li.meng@amd.com>
References: <20220526034725.1708916-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705cdc70-e138-4f5f-34e0-08da3eca8840
X-MS-TrafficTypeDiagnostic: BYAPR12MB3511:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3511076B9E4B2625C9BFA60FF7D99@BYAPR12MB3511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GLiUjYL0zyiULpg/wdzIOEOfrEzl/+eF+pbXxOcNraINaB7h18RdEbefOBXsB5NgGbLBvAc4YFNayH4DMYgp0pKqs0WwRu6CfVOHsL8BJclaLoGeHEayoT/pZZvT+lJ2pXRmXxjotzbNqD52SBCXmUEYCKUpFt9BJ9Ftrl/EWiUwXT+dlZ0tE2iYT4jHg2OTpiAkQxPxwKy338URR0C17CLXgLLtEgQZlY3QWLvZwsvV9pDRPyFqRGCfgkL4kgy3WuPjw/rOi8Nq+vTVSU3jYcZpNB+FzUpOV7RhlRxNKsp/TMjJ+1O8urJqM8Vi2quM4XER318A1aqkJpA81Us2Dgff5j8csvtYqTbJc43qzcRcdA6t5zspC13Y8WD3muTatEvxsN36r8TWHzOUaK1fUwPsuYWCUzdzTIiAskRFiwkR+UwVyi2llnwGR6ySIaAZK4eUCAL9DeYLJ0rOL7GXJdGjfGgojdWIEpfWebafb5cXHiX2hYXqTRtM346HA4aNAQd7pARogVW7PfbvaD5R/EbILeZl0xjCSsh+bH4wfLS7tPTcHXCzoEzWC8dSNHP8xmucadotyq79tNTTM4ZjC5KhDIn752/nYgEo5V4MHqZfWjcKcOYrBbKk+xwidgvg9VFidbnQ+U/EzwjoBQLuRroNc0hdy/gkh7rhEjC3Cgi0UBfBa8RE/RQJhdE0jRDfzzFnwqQCjVIUc+bQecQtUEgVFxj23HlRfzK9KZhZYkt3ICmppkbhthHSoItJgLZFMHPn1Q5ciMQd5BQgxaShjlsh2/HiVrp9lc+bY5MVoFVF+MOIKmQMnQVhMWPZZ1veou9EbzvA314m+GLHSqA0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(54906003)(2906002)(36860700001)(83380400001)(6666004)(8936002)(47076005)(5660300002)(2616005)(86362001)(426003)(508600001)(336012)(26005)(7696005)(81166007)(1076003)(966005)(110136005)(316002)(36756003)(4326008)(8676002)(356005)(82310400005)(70206006)(70586007)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:48:01.4852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705cdc70-e138-4f5f-34e0-08da3eca8840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
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
It also talks about kselftest and how to use.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 76 +++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 83b58eb4ab4d..8f3d30c5a0d8 100644
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
+            $ cd linux
+            $ make -C tools/testing/selftests
+
+    #. Installation & Steps ::
+
+        $ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
+        $ sudo ./kselftest/run_kselftest.sh -c amd-pstate
+        TAP version 13
+        1..1
+        # selftests: amd-pstate: amd-pstate-ut.sh
+        # amd-pstate-ut: ok
+        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
+
+    #. Results ::
+
+         $ dmesg | grep "amd_pstate_ut" | tee log.txt
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

