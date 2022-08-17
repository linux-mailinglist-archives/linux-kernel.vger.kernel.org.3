Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96945967D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiHQDtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbiHQDti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:49:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230B77EFF0;
        Tue, 16 Aug 2022 20:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKwmsEQLpYybRAA459Fi6vY09hQi9fw84gPN6swOs8S4gBdD0hd1h1/beYlrnj3KQBG8djgs6+M4PbcYAp/NzzxBf2nAA4u+pFGt6LSynPRjwVSkUl8furs4TakRHH3/sNJA4gS7Hmc5Q2Blsk4zU21t9jopoTI+6Tk6bvgiDMlxJwFpsobpbk3CZ/uSVkAuT8TLIKzm+ZBgVNknA8Shanl3avAaVI7vTnbO16QxHCEf2R6JCn437tzS03iRvBJgMGxg/f/AZiFaBhppMXfRvl3x2CjifE7G5mcmEnDOPx3uJRzrwFe5NyGSHeulmz8fMEzSc7aGc4uYRIAM1+ejnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYkbSQC2Wb1E40TC6+os9NHgkzLRNn1CGGGEKK5fN4Q=;
 b=UgmY/GBB+7YdD/phR5qBFfE95dli99bjrc/+UlNxFc2RWxU1aQKQ2TBylIqvCFY1oxW0XveBAuJhHEDrD4wPtYGbkyRggkEgRRgyciE7i0e+ytOf+GXuC4Mq1MTPDtTSSllZrZnpXfV5PRzQvUqP120ryXpByZfiZwKrDsJmaHNfV+XgvK1qmeNfinBZU7rbV+AsTCkOoixui0TlFB9V5AvZYy1CqzNQYqeZGgm5XrEdMZMB9srJs7D3qwFO0znSqlzMuus+ZpaYhy8iyZJFqUNTN7MTbjZHMHaPLlyEJCnLunhZYv+KjoX2TRwoJvIl6esnBQ0U+M1lYgpKqBxszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYkbSQC2Wb1E40TC6+os9NHgkzLRNn1CGGGEKK5fN4Q=;
 b=Kezp+QCUk9CDqYNrI4Xi1XT1Gc6ooZEAzSWjFuBGIaiTn+xqLZqTiTgoVQy6PBJLCVk+dog1n1FC4huDLupzLyKB0imj6+44fU9WHgBRWAzkhOTgAnsydB8GbFosrsl+hpf2Nk++iiH5D0ID18quLTVdQkgPf4kwjgVAFW0dbYk=
Received: from BN9PR03CA0809.namprd03.prod.outlook.com (2603:10b6:408:13f::34)
 by BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 03:49:32 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::40) by BN9PR03CA0809.outlook.office365.com
 (2603:10b6:408:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Wed, 17 Aug 2022 03:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Wed, 17 Aug 2022 03:49:31 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 16 Aug
 2022 22:49:02 -0500
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
Subject: [RESEND PATCH 4/4] Documentation: amd-pstate: Add unit test introduction
Date:   Wed, 17 Aug 2022 11:46:30 +0800
Message-ID: <20220817034630.1172065-5-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817034630.1172065-1-li.meng@amd.com>
References: <20220817034630.1172065-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd6ace22-5225-4645-81d6-08da80037e2c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2693:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pw4IebPLL/NP4tYcIAmC2ON+4mMlHcrUrypvnHwjhLJlnhlzq21fEwX+MtshLUoOc7yoh5jeDauFSwY/+N9/Rj0FuEHsYuNMxWZmryi3CtQiGgdSonmbs58pGNgdgvX3GGWZ30w8ZGWQI6kTMRn+PStZZ/KT3sqchuSJfILm0YJDcqhV8EYG2O2rgZvMCAc0pM28LBIg/ETE5w2mf88TFm/Ih1O32GLYK5/ZNPeUlqNrvWT78VZ7aJtEb5/nhyZo64d10sjPqRmj4G3Eq/TO/NbWOa+tLcZ+k7XR6GnsKsiIp7TsegMoPYeh5G6TwN7OGTZTo1aKiD/XVwdUX7IVoPw0Z9385EoRKrtuv6KSt3hKdcH37rg1ivfF2ZktFI60S6YgTNcbc2yqkvQ3cwbCmi4J+pDAYvn9mFOG+lm1fsSEAUXpnsCE+tlKRLcoouVzH58ZWWo8DFU9NzFLuJ2WMSinJaRw/DlP9IYcuJLEZUDVXJj7AhXpyH138qWS1riE+Ti6iXLzNRabUerBfkWZyGDFUx1a051Aba83PXtd2U9VHfCMGZhg5QM3MiYmGO+t6EEhMI1VQhO5mF6PDXjjuInT1vW/pdJWhOIv0dTiX1HNuXmOozasRHbaQ7YfXQYWP6gb3QbcjLE5NdiKWoLXLfrh0rjnlLeyuTbdJFUU185gHnNS3QPkZBe+sIyT4XZstNAZiEf02Kw1SUMmJEbFlL92wGE7kZ7ZVB3K2QGqU9+76PXVslJNcuCeZzAKjYKxWQ6f2o46tVvA7z4mBGCdy25BHynu37xggWatkWNT49JP+3njxJ3n1bQJimE95joNmeVmfsAXT8SwQ+KrmZ+c4mQCNnuOMdmDJ6onqHkopKInVycBJikNKyef7T9cPtypd4IrOvqDr/qM/0tiMdz2CODxqcKTyaL0JZG/pUQt4lY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(40470700004)(36840700001)(2616005)(336012)(356005)(47076005)(82740400003)(8676002)(40480700001)(4326008)(2906002)(36756003)(1076003)(70586007)(81166007)(86362001)(54906003)(186003)(70206006)(110136005)(426003)(36860700001)(316002)(40460700003)(16526019)(5660300002)(83380400001)(966005)(41300700001)(82310400005)(8936002)(6666004)(26005)(478600001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 03:49:31.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6ace22-5225-4645-81d6-08da80037e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2693
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

