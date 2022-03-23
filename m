Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329954E4D28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbiCWHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbiCWHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:17:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD07272E35;
        Wed, 23 Mar 2022 00:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxoTfsIemCasLUtqf7mhHE5QI1otjfj/U0C7y+1aGF6uhYXAVzDeImcShhonFIkklCZT8qyyUt4O6qlEBwmoZbUJb5tEYf/8lEN00RUPzBaYDaUdXwEh0SAKlQLJv4okddZEGWrGrQwlUvOqn1f+KZwhaRaHKPIafTzwKuQHsFFG/818mxt52NGr7eCSwadqdwzlJDMppL1h/GuBmB8HZcGdR4EM6i9sW5DGO3fPyBISqM3VK4AyHhZg28KVC1yUds1GrT7xk1MJBXwENI9VZa/TF3TKavedwWOmtxnyoe2QFhByKLOghuj/5yNYT8L3vEqof7iVTFdWrxls1PCGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ocsgDF5nwBiT8/PJ+vX1Op6kBbPu2arivJjVUjhn8g=;
 b=E4E0WMcrRGTZaJutjUnhS09JoxalxISdu3Q+2b9PoVkRcCZMayhm5x2cJMtFKiY1QpmT84aUrV35TqbE4aYUHR/2Sb7tzz6CY36qsHR8oAkCi8wsw8FMbdNvrN78BazZeVKGRfuQZOW7Tt1fgL3W2qG9bXl5ceySWBYUougXNrvGEK89gxCjjtztSsZo9jy7kUw6AMJ4pFfNTt6Zdb3grkq5Ey7NQJIF5wlyVV6QsMKsd0tgdqP1LktoFP8UT2erjYbHEgO54LqHCajq7RTdIBjJRt/UcHS+zrXJqBhFJWpLCujQ6saoPXo1M3mNSwQczHX6laHblBDoMr1nxTaj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ocsgDF5nwBiT8/PJ+vX1Op6kBbPu2arivJjVUjhn8g=;
 b=Y3eIX2YEWKsOa9Go6PMDScQwpZUDdtdcIPAT+SEzjGhclIEBgqAeH9oMjo7LwH4VcGPuKRBZs4511t7wZQ+41pt/sAPx225KSBdL2aLaMaXg9hf//8vWkS+YJuTxMxrAQCP+5fCXD8A0t+7HSoz1wsnr7GKUwb8vhs03wqs9cN0=
Received: from DM6PR10CA0011.namprd10.prod.outlook.com (2603:10b6:5:60::24) by
 CY4PR12MB1591.namprd12.prod.outlook.com (2603:10b6:910:10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.18; Wed, 23 Mar 2022 07:15:53 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::f6) by DM6PR10CA0011.outlook.office365.com
 (2603:10b6:5:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Wed, 23 Mar 2022 07:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 07:15:52 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 02:15:48 -0500
From:   Meng Li <li.meng@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, <linux-pm@vger.kernel.org>
CC:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        Meng Li <li.meng@amd.com>
Subject: [PATCH 3/3] Documentation: amd-pstate: Add unit test introduction
Date:   Wed, 23 Mar 2022 15:15:02 +0800
Message-ID: <20220323071502.2674156-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220323071502.2674156-1-li.meng@amd.com>
References: <20220323071502.2674156-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f27ff9b-5c50-453f-9e42-08da0c9cf744
X-MS-TrafficTypeDiagnostic: CY4PR12MB1591:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB159106896413E10645483E87F7189@CY4PR12MB1591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PkYbfO2C/6QbBgLEtUaySzhcwF+YwzgIb8ODjUJjNbgyUBt4a5SchUw1V53CtCk7jG6jAsVF3J3NFOV8Trrcy9071EDsAP9zouEECu2mTw9xHbZ0+3UWKUOfk1ngvaQ9FNxqSbTSbbVVsAIi51QlAC26km9teCLZOhwbbzIKBRnkTHecNcHpCkfgUxyeqf1liQXqU1nbnpY6DAyieAzwyvn9U2zCD5uDPjJGBKaFqEkeenzk50RQWWknjxS+LnaZqkjDNjHvWb5DXMpqOtmMN6oPum0uS3K9zwBpymcu6bSPAMZLSLOPhfeeNhy4N54CjOpFcImlDQkQw56Dxa2qOcx5WosD4yfXOq8XUQ2NtKuPHXSKNiFuyXk/Yg8VOW4DCT0fu0Osb9/amScAGfxDydPlL07Kuergapl2oQCLEmiZYdf+yKNZ0s/RZSTVRDGFq5bUIY1xzyAzjtHN21eL7GItDi9Vk80OdyRiELbG0LIlJckeSISnODJ+ZtEiBp4I1rweXN2GiX5Dnjg/AOQkt5oxoCkiq3qM50+NF9kLkkhfa8+sX+AR/9RSY3AAjlKIjB9LvqIdq3l/G8lv77gg3seoeOcX5hpm4pOs6yoYfIEAN0KMAMFcu25oVdvSaLt1e5LtSrJ4Rwqqaoo0E/Q/Cn2SSBxT1L1+1O8mNGltzvEfHSBrUpQV4y6XoRaO/wIN/ASe9FSo68coVGNhGgQBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(186003)(40460700003)(1076003)(2616005)(426003)(83380400001)(70206006)(54906003)(70586007)(316002)(110136005)(81166007)(16526019)(36756003)(4326008)(8676002)(356005)(508600001)(6666004)(7696005)(86362001)(2906002)(47076005)(82310400004)(5660300002)(336012)(36860700001)(8936002)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 07:15:52.8153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f27ff9b-5c50-453f-9e42-08da0c9cf744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
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
 Documentation/admin-guide/pm/amd-pstate.rst | 221 ++++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1923cb25073b..47ba6eeb2e38 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -182,6 +182,7 @@ according to the ``struct sugov_cpu`` that utilization update belongs to.
 Then ``amd-pstate`` updates the desired performance according to the CPU
 scheduler assigned.
 
+.. _processor_support:
 
 Processor Support
 =======================
@@ -283,6 +284,8 @@ efficiency frequency management method on AMD processors.
 Kernel Module Options for ``amd-pstate``
 =========================================
 
+.. _shared_mem:
+
 ``shared_mem``
 Use a module param (shared_mem) to enable related processors manually with
 **amd_pstate.shared_mem=1**.
@@ -395,6 +398,224 @@ about part of the output. ::
  CPU_006     712          116408        39        49        166       0.6769  8950227 1839034 37192089  24.06  11.272       470         2.496         kworker/6:0-1264
 
 
+Unit Tests for amd-pstate
+-------------------------
+
+``amd-pstate-ut`` is a kernel module for testing the functions of ``amd-pstate``.
+It can verify the required conditions and basic functions of ``amd-pstate`` before integration test.
+
+1. Test case decriptions
+
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | Index   | Functions                      | Description                                                                        |
+        +=========+================================+====================================================================================+
+        | 0       | stop                           || Stop the test currently in progress.                                              |
+        |         |                                ||                                                                                   |
+        |         |                                || For example: if the n test case is being executed, it needs to be completed and   |
+        |         |                                | the next test case will not be executed.                                           |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 1       | all                            || Start all test cases.                                                             |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : all cases pass                                                           |
+        |         |                                || - Fail : only one case fail                                                       |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 2       | x86_vendor                     || Check whether the boot CPU x86_vendor is AMD.                                     |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : yes                                                                      |
+        |         |                                || - Fail : no                                                                       |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 3       | acpi_cpc_valid                 || Check whether the _CPC object is present in SBIOS.                                |
+        |         |                                ||                                                                                   |
+        |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : yes                                                                      |
+        |         |                                || - Fail : no                                                                       |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 4       | modprobed_driver               || Check whether cpufreq_driver module is load.                                      |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : yes                                                                      |
+        |         |                                || - Fail : no                                                                       |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 5       | capability_check               || Full MSR Support: check whether cpu set feature flag :c:macro:`X86_FEATURE_CPPC`. |
+        |         |                                || The detail refer to `Processor Support <processor_support_>`_.                    |
+        |         |                                ||                                                                                   |
+        |         |                                || Shared Memory Support: check whether module param shared_mem enable               |
+        |         |                                || The detail refer to `Shared Memory <shared_mem_>`_.                               |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : yes                                                                      |
+        |         |                                || - Fail : no                                                                       |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 6       | enable                         || Check whether AMD P-State is enabled.                                             |
+        |         |                                ||                                                                                   |
+        |         |                                || AMD P-States and ACPI hardware P-States always can be supported in one processor. |
+        |         |                                | But AMD P-States has the higher priority and if it is enabled with                 |
+        |         |                                | :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond to the      |
+        |         |                                | request from AMD P-States.                                                         |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : yes                                                                      |
+        |         |                                || - Fail : no                                                                       |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 7       | init_perf                      || Check whether AMD P-State init perf sucessfully.                                  |
+        |         |                                | Include highest_perf, nominal_perf, lowest_nonlinear_perf and lowest_perf values.  |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : yes                                                                      |
+        |         |                                || - Fail : no                                                                       |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 8       | support_boost                  || Check whether all cpus support boost.                                             |
+        |         |                                ||                                                                                   |
+        |         |                                || If boost is not active but supported, this maximum frequency will be larger than  |
+        |         |                                | the one in ``cpuinfo``.                                                            |
+        |         |                                ||                                                                                   |
+        |         |                                || - Pass : yes                                                                      |
+        |         |                                || - Fail : only one cpu not suppport boost                                          |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+        | 9       | clear_status                   || Clear all test results.                                                           |
+        |         |                                ||                                                                                   |
+        |         |                                || **This test case is always at the end and cannot be changed.**                    |
+        +---------+--------------------------------+------------------------------------------------------------------------------------+
+
+#. How to execute the tests
+
+    a. Build ::
+
+        jasminemeng@jasmine-meng:~/amd-brahma$ cd linux
+        jasminemeng@jasmine-meng:~/amd-brahma/linux$ make modules M=tools/power/cpupower/debug/kernel/
+          CC [M]  tools/power/cpupower/debug/kernel/amd_pstate_ut.o
+          MODPOST tools/power/cpupower/debug/kernel/Module.symvers
+          CC [M]  tools/power/cpupower/debug/kernel/amd_pstate_ut.mod.o
+          LD [M]  tools/power/cpupower/debug/kernel/amd_pstate_ut.ko
+
+
+    #. Installation & Steps
+
+       Test all cases ::
+
+        jasmine@jasmine-MayanDAP-RMB:~$ sudo insmod amd_pstate_ut.ko
+        jasmine@jasmine-MayanDAP-RMB:~$ cd /sys/module/amd_pstate_ut/parameters/
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ sudo chmod 666 unit_test
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ cat unit_test
+        Index	 Test cases          	 Status
+        0    	 stop                	 [ ]
+        1    	 all                 	 [ ]
+        2    	 x86_vendor          	 [ ]
+        3    	 acpi_cpc_valid      	 [ ]
+        4    	 modprobed_driver    	 [ ]
+        5    	 capability_check    	 [ ]
+        6    	 enable              	 [ ]
+        7    	 init_perf           	 [ ]
+        8    	 support_boost       	 [ ]
+        9    	 clear_status        	 [ ]
+        ------------------------------------------
+        begin_index = 0 end_index= 0
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ echo 1 > unit_test
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ cat unit_test
+        Index	 Test cases          	 Status
+        0    	 stop                	 [ ]
+        1    	 all                 	 [P]
+        2    	 x86_vendor          	 [P]
+        3    	 acpi_cpc_valid      	 [P]
+        4    	 modprobed_driver    	 [P]
+        5    	 capability_check    	 [P]
+        6    	 enable              	 [P]
+        7    	 init_perf           	 [P]
+        8    	 support_boost       	 [P]
+        9    	 clear_status        	 [ ]
+        ------------------------------------------
+        begin_index = 1 end_index= 8
+
+       Clear test resut ::
+
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ echo 9 > unit_test
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ cat unit_test
+        Index	 Test cases          	 Status
+        0    	 stop                	 [ ]
+        1    	 all                 	 [ ]
+        2    	 x86_vendor          	 [ ]
+        3    	 acpi_cpc_valid      	 [ ]
+        4    	 modprobed_driver    	 [ ]
+        5    	 capability_check    	 [ ]
+        6    	 enable              	 [ ]
+        7    	 init_perf           	 [ ]
+        8    	 support_boost       	 [ ]
+        ------------------------------------------
+        begin_index = 0 end_index= 0
+
+       Test specific case ::
+
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ echo 3 > unit_test
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ cat unit_test
+        Index	 Test cases          	 Status
+        0    	 stop                	 [ ]
+        1    	 all                 	 [ ]
+        2    	 x86_vendor          	 [ ]
+        3    	 acpi_cpc_valid      	 [P]
+        4    	 modprobed_driver    	 [ ]
+        5    	 capability_check    	 [ ]
+        6    	 enable              	 [ ]
+        7    	 init_perf           	 [ ]
+        8    	 support_boost       	 [ ]
+        9    	 clear_status        	 [ ]
+        ------------------------------------------
+        begin_index = 3 end_index= 3
+
+       Test some cases ::
+
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ echo 5 8 > unit_test
+        jasmine@jasmine-MayanDAP-RMB:/sys/module/amd_pstate_ut/parameters$ cat unit_test
+        Index	 Test cases          	 Status
+        0    	 stop                	 [ ]
+        1    	 all                 	 [ ]
+        2    	 x86_vendor          	 [ ]
+        3    	 acpi_cpc_valid      	 [P]
+        4    	 modprobed_driver    	 [ ]
+        5    	 capability_check    	 [P]
+        6    	 enable              	 [P]
+        7    	 init_perf           	 [P]
+        8    	 support_boost       	 [P]
+        9    	 clear_status        	 [ ]
+        ------------------------------------------
+        begin_index = 5 end_index= 8
+
+
+    #. Results
+
+        +-----------+--------------------------------+
+        |  Status   | Description                    |
+        +===========+================================+
+        |   [ ]     | Not test.                      |
+        +-----------+--------------------------------+
+        |   [P]     | Test pass.                     |
+        +-----------+--------------------------------+
+        |   [F]     | Test fail.                     |
+        +-----------+--------------------------------+
+
+        Enable all the messages in the ``amd-pstate-ut`` module. ::
+
+         jasmine@jasmine-MayanDAP-RMB:~/3_Cr$ su
+         root@jasmine-MayanDAP-RMB:# echo -n "module amd_pstate_ut +p" > /sys/kernel/debug/dynamic_debug/control
+
+        When you start to test all cases, you will get the follow logs. ::
+
+         jasmine@jasmine-MayanDAP-RMB:~$ dmesg | grep "AMD P-state UT" | tee log.txt
+         [  732.084122] AMD P-state UT:param_set_index 1 0 result=0!
+         [  732.084140] AMD P-state UT:!====! Begin all unit test! !====!
+         [  732.084146] AMD P-state UT:****** Begin 2    	 x86_vendor          	 ******
+         [  732.084152] AMD P-state UT:****** End   2    	 x86_vendor          	 ******
+         [  732.084156] AMD P-state UT:****** Begin 3    	 acpi_cpc_valid      	 ******
+         [  732.084162] AMD P-state UT:****** End   3    	 acpi_cpc_valid      	 ******
+         [  732.084165] AMD P-state UT:****** Begin 4    	 modprobed_driver    	 ******
+         [  732.084168] AMD P-state UT:****** End   4    	 modprobed_driver    	 ******
+         [  732.084172] AMD P-state UT:****** Begin 5    	 capability_check    	 ******
+         [  732.084174] AMD P-state UT:****** End   5    	 capability_check    	 ******
+         [  732.084176] AMD P-state UT:****** Begin 6    	 enable              	 ******
+         [  732.084222] AMD P-state UT:****** End   6    	 enable              	 ******
+         [  732.084225] AMD P-state UT:****** Begin 7    	 init_perf           	 ******
+         [  732.085016] AMD P-state UT:****** End   7    	 init_perf           	 ******
+         [  732.085026] AMD P-state UT:****** Begin 8    	 support_boost       	 ******
+         [  732.085033] AMD P-state UT:****** End   8    	 support_boost       	 ******
+         [  732.085036] AMD P-state UT:!====! End   all unit test! !====!
+
+
 Reference
 ===========
 
-- 
2.25.1

