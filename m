Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EC511B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbiD0N56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbiD0N5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:57:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F320F6C;
        Wed, 27 Apr 2022 06:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7qVCD0/sXb6enBNJ7sM2ofyMxGRaIOhuusGEhHpUWCI7AthGJG6xSllZ+mH/WzCuU1scDwiqQvZMhAvm5KZgyuP+RmiNkgCCXqlkJO3BbGNeEoF6sfB0NLscFNveX/vUd1+0M1CYYZTjddZQXgQfQ0KvumhTMmWlmIpYrWtG6vVSh70uL/myfdafCfudB6+5mgEToGjUaH1s3oyAeoKZ86LkxNzQrLmlLxgxQWiHClcFT512jcZDw89XbZMWfrfb7SPXNy6DND6Q+gppQpPD85/1HS9DgtTpfvRbKVWWDy60p3kR2tSaZ70kwCgT/btSjncAF20zfTPLPL3yfd+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvOLDAbToXcmfOhr5nY7lrSGWT/PWx74q9X6rcB8jNM=;
 b=JWY2mt8UYp0fhRrFkGfk+1+4/rSjCuWlVCRHXq4a4Y9NJEJUECo/ZXprNONMGKk8WDF09leT0ORFRAQ1Bse+8HWOfjO5uJkP0gNYOVbqhTnTiyERFYY4ohs16JLwIYZ/he7JpLABqjItf8MJ4Py27GmfW4+Ez83oOzuxXz1mAp1DMQBEy8afTXnYVO8ygn/ithSgu4uPiCXRFP9T+1P5O1BaLNJZv8Wc7X7IEV6x9NEswpyNAOHXefahwetRZXv39tiLyM36jFNynpipgpremuLyPaAUEdLAcjaxF0zhXIyssSX1Dsct0BGu7kgf6/c3ko52Y3cIJIKZQStkLf+UCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvOLDAbToXcmfOhr5nY7lrSGWT/PWx74q9X6rcB8jNM=;
 b=bJ/0LfGXHcN79SWcdKjBfRUz5cYA6m5eW4Fu/lzokv2EM4+cYKGYuPERRZFFY8QAL289pW67dKq9HHpMeC3iU6QbZ1Ek53fAyJxtoPmh+PIoEWxLhEVNeolGr2MKmZgSuzZxI1Ki9KoK9FAf809LrL9bFNJlEYTffZ3ds96bA2c=
Received: from BN9PR03CA0923.namprd03.prod.outlook.com (2603:10b6:408:107::28)
 by DM6PR12MB3979.namprd12.prod.outlook.com (2603:10b6:5:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 27 Apr
 2022 13:54:34 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::21) by BN9PR03CA0923.outlook.office365.com
 (2603:10b6:408:107::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 27 Apr 2022 13:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 13:54:34 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 08:54:29 -0500
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
Subject: [PATCH V4 3/3] Documentation: amd-pstate: Add unit test introduction
Date:   Wed, 27 Apr 2022 21:53:15 +0800
Message-ID: <20220427135315.3447550-4-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427135315.3447550-1-li.meng@amd.com>
References: <20220427135315.3447550-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13ca91ca-ba2e-4442-d472-08da285575d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3979:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3979C7B60B3981424A53A0DAF7FA9@DM6PR12MB3979.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVHAG7DdMD5AO+SVI+8luf+Kok4SjH4bTRSPXvRfWq4meD2jVHDK1+nSBvx6qNaxu61i/brE2XbmrRxPfikmGUZNQhwDTUo7QzICoff6VhbRM5zUDM6ofb7fozWSxQzOwB5PScZfk9gBSYSy1Xmjgm6AtRCsr04zaao8eSkaX6QYLz3ca57TWNGq69W+fE09KQ/ZJ28QMTqyaFYqtnI9Zxnu64tzSh9LB1kJSbYUjORDBIfO7JQof0HONwj87YFg4YkC7V61VYyIifOQzJDjX+/a7Qq5tHUXZQ/FNUtDs3AaCrw1RX3YKr99ioTiIzq/CsCv7uyHC8T2X7RAXNFbzWiOCeZQ8nyBCVF7mmGVNyqksKDlgKY4ewofsWMLzk46iCgJB6x2bzNxMkkOgD0zagIuCDlKv38zIzPH2AkNGY0jWH7Ylxo0cyUjPQrWdDlrVfZ2ch2NDqG4PH+wfFWpKJYtnoqybPEP3oWq+AgfiN2YpKH/h96b5U1bLu0K0YYGykxHOq47xMkyQ8rt7Gla1gDWd+8wxd7DoHP+0TD0oJeC77kU3g0FIF5zrWY55hcs4SzraEhBLFalskcheEi9CO6QZ7kazdcztukr+30PxvIDyAhA4sky/gGzJQdC4RQ61BHmA83jAZczxkAUI1fXVMLcJPm+eMNwA33i0f8FgGWk/ck6K5Fm0C0/XBN9CogJPkkvgcS7p94u33LihtFBQOW0n0paNlaGMurAd3Us2CAra6qRtdlfA1Z52nyE5xkD2rAJxL3Z+6GHF06NyXv/3bxNB0ubP6wtX+NPtGLC5TLExtVhtjeIXiAz6BBM8OEM9d+HXIK+64TKEBfaOBgtqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(2906002)(6666004)(5660300002)(356005)(54906003)(26005)(36756003)(8936002)(1076003)(2616005)(336012)(426003)(47076005)(83380400001)(186003)(82310400005)(16526019)(508600001)(966005)(36860700001)(70206006)(70586007)(86362001)(81166007)(316002)(4326008)(40460700003)(8676002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:54:34.0106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ca91ca-ba2e-4442-d472-08da285575d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the AMD P-State unit test module design and implementation.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 87 +++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 83b58eb4ab4d..395b8b5c680c 100644
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
@@ -393,6 +396,87 @@ about part of the output. ::
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
+        jasmine@jasmine-MayanDAP-RMB:~/amd-brahma/linux$ make -C tools/testing/selftests install INSTALL_PATH=~/kselftest
+        jasmine@jasmine-MayanDAP-RMB:~$ sudo cp amd-pstate-ut.ko /lib/modules/5.18.0-rc2+/
+        jasmine@jasmine-MayanDAP-RMB:~$ sudo depmod
+        jasmine@jasmine-MayanDAP-RMB:~$ sudo ./kselftest/run_kselftest.sh -c amd-pstate
+        TAP version 13
+        1..1
+        # selftests: amd-pstate: amd-pstate-ut.sh
+        # amd-pstate-ut: ok
+        ok 1 selftests: amd-pstate: amd-pstate-ut.sh
+
+    #. Results ::
+
+         jasmine@jasmine-MayanDAP-RMB:~$ dmesg | grep "amd-pstate-ut" | tee log.txt
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
@@ -405,3 +489,6 @@ Reference
 
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
        https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
+
+.. [4] Linux Kernel Selftests,
+       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
-- 
2.25.1

