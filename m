Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840B51B5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiEECds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiEECdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:33:43 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442FB506C2;
        Wed,  4 May 2022 19:30:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWH72k/RJGHcguldnfsC8XpjiM1mguayCHYfKNJ0Cvt11A17ejTna2xCHAsjJRGbSP95GrVuBbD7MJFTjptmKR/mQ3dE0QZ6jB/5TV6Z1D6O3aUrZLMA6A+R5AhNYqcvO3s0XpP/hktizvY0jhSk2zl1Zj4TpqRBxEB2CPavqZxf1bJwLYEmwMEgRrMeOHxbTH1yHbp/UBeb6T+fIapG+uQjegtcstNSv7b89osTZN+3NQlmYm+xdx3ACkYCgp8LaKcRQplA1HXWWtMkD1qEB8EWTsJd90TSa3TDWiluOkUv7C/GnklKrU/1mrl1ysNyLAL/5LEBKFqywdaiFU4JLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT+4mfkRr7MVGEB89tWrj/q81OM4L9M/85uwrwTbqEM=;
 b=l29m3fs2N7m+43UdfeJKWmH4Sdd9s+unJnROdqb8frBQSoeEggDggegaH2LtnCZpdaEEIBUDzp+/c9qX/eU8n/JhCSnsHZQcPcfjOV677xXS8CkDSovgx6qb+b+kR18flUgUGLgSTUmUIRcJCjqmIMnynUY7J0nHPZNlPJhywunqulwTYPTNvroST7HhRiEBMONinjirN2Yr0krZUrflthvkdBre7k+ktJ3amrcodonSmrQAkGHtGh/KQTdlCywXe8Og+wpr6pZow6M6dAMjhLwCF3yfYcuhNiqnjK6aWaQHqRdQLlMRJLB5uJeEwyzM4U1jES/N/xyE6SMbpFw7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT+4mfkRr7MVGEB89tWrj/q81OM4L9M/85uwrwTbqEM=;
 b=q32XFE3eC1KKaHcVshARmzZZ2fE6ecI4Kzhu0dUtOQMG5rWLwDS3DTcDBdWujQ0A+5hDVUWWUl0dWhtp1W4RxkKo1hT9amm75MjZXHdFUlQIid2VkddZgsa2Hgbr4Z3oc3cg6bEHYapbXhz5HeYOxQzJwVc6aHRTUJH8b2Y8Nek=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by BYAPR12MB3541.namprd12.prod.outlook.com (2603:10b6:a03:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 02:29:59 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::82) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 5 May 2022 02:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 02:29:59 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 21:29:54 -0500
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
Subject: [PATCH V5 3/3] Documentation: amd-pstate: Add unit test introduction
Date:   Thu, 5 May 2022 10:29:13 +0800
Message-ID: <20220505022913.329259-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505022913.329259-1-li.meng@amd.com>
References: <20220505022913.329259-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cd9703a-fc82-48b8-3828-08da2e3f2697
X-MS-TrafficTypeDiagnostic: BYAPR12MB3541:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3541CD8CF1AE4FBD2F09E460F7C29@BYAPR12MB3541.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YURXEh/AQzZHI05x5rhtzr49IQkhgt/HXeyp12GCJ+MFLaUycaaLQZSVuuqRzrGZAK9F6qeXeyGjQNzKsfS3spQzaZtgTBTFb9gflWY0jZ4MVOUQ0thUw3TIp4z+eQTuYNlX48jvTzIeS0KoOYY/ztL+6sLex9h2MIXE+SdRzgZiFFJ3llKv9H9QqIfaldsAq/wWYfey8cFQY97wFtWNvjcZAU15nioeimPdfFHpsafYEA7PpI9QpRmxLSX/taiRO7EemL/T2svWkF3KF0zP/65+dapfupBrOMHOJkHfUJxHH5kBI79O3Me5Y/RkE+Yrfmw6HYYeEEKWJnNOAm22GyJ9Pw4YBYt1iRV7cNV+JO8tNX1dApce3Q789e7+AZzAzUkjv7QXO6CcGShq8ooRXLVhxXTsuqFoU0iw4DJ9yDGkSdGKCprhSfSDM1M45shrlMaHGUoza1BGNL4JxGx7uP2WrvnpjN1arE+inoBcr/b9ItlkURIqqZQaEV/dHIRXAupO9IoEZMWG2ZvZG4CD951hRwFXEBdIxR6h+SeOwFRN7qSDdZOr7dxh+bpmHJCiagorKjBwqzPml/MutVlx4tY28FSIJqYFdEs41mu4pRzFXiEAvhHZ1ETi2oTRrzipVpQWAwvGhAzZOkYqII28oKgeZm/6tP5O+huC1XvqCEuYXrJeOyK9sT3No5XKAYYNyiVuMabR1M/kkdXjlusd3JDVF3mWobqirLbVQVz0qx2uYA6foaGqEwDPXR9KqaRAUcs2O0A/3rv44snXKVwiUNUc1AunC8wyD4c6bF+SnUhBbrcIzz5rFG6hl4bKYDZJUaRVAGCPTjMrCMoseVnkGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(82310400005)(8676002)(81166007)(70586007)(4326008)(356005)(40460700003)(8936002)(54906003)(110136005)(5660300002)(508600001)(86362001)(36860700001)(316002)(966005)(2906002)(2616005)(336012)(47076005)(83380400001)(426003)(36756003)(6666004)(7696005)(16526019)(186003)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 02:29:59.0358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd9703a-fc82-48b8-3828-08da2e3f2697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3541
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
---
 Documentation/admin-guide/pm/amd-pstate.rst | 85 +++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 83b58eb4ab4d..dbcc50e973f9 100644
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
@@ -393,6 +396,85 @@ about part of the output. ::
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
+    1. Build ::
+
+        jasminemeng@jasmine-meng:~/amd-brahma$ cd linux
+        jasminemeng@jasmine-meng:~/amd-brahma/linux$ make modules M=tools/testing/selftests/amd-pstate/amd-pstate-ut
+          CC [M]  tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.o
+          MODPOST tools/testing/selftests/amd-pstate/amd-pstate-ut/Module.symvers
+          CC [M]  tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.mod.o
+          LD [M]  tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.ko
+          BTF [M] tools/testing/selftests/amd-pstate/amd-pstate-ut/amd-pstate-ut.ko
+        jasminemeng@jasmine-meng:~/amd-brahma/linux$ make -C tools/testing/selftests
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
@@ -405,3 +487,6 @@ Reference
 
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
        https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
+
+.. [4] Linux Kernel Selftests,
+       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
-- 
2.25.1

