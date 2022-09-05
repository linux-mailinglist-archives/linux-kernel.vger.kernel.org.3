Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0E5ACC70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiIEHVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiIEHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:20:47 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84354DF18;
        Mon,  5 Sep 2022 00:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiIGHc8EStsGRbYB9eEJSD/cS4++C5InTh9WHW2q5T33O03y3h9MA3LTp8iCWEORtL515ZYqCOYZEG8EPMQ/sMnm8qOP2YPebBE3PVYUu44yOvm66DRsqF83aOroJImJgnnTozKY5GGE6R+XV6Rz6MErb3CcA62JKdzfL7zgleCaYUz6YFws5WP1Bs5orPdrRgKFErTt8NXDyfv0khBmN+J2YjB/0VxkXaxR+i8dChV8pFkswc7oV12AHbRXc0pGV974W7Lt1i7IbrFYYRt1UhpliLC9aLwFxEwCkFB07WLjiovOdCfCcICsfVuHfsLTOqFdIg3H+WFXr7wp3CetAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR4zj34YbRUntXALTpBlt35WplSgVVSrJVLvZSuISD4=;
 b=UxFEfrj8fKAm/Axpkad8AnCCgqB9X1QjVaDluUU7jTZhtlj+8D4AmCP4jWA80MqZYciY71SM0yAjUlbcsvfipc3wIgtN/z+b7Tbu5m+2JLqC6USzt0d9/85rvbu9aPlR2kmAflZGmfQNlWCfTeDZpXh+E+uG9V7o1ALCEB6HITBqP0fWeXJSGqBRHRNgS0SvQYNVN6neGB39DEgIkESTJsCITt/yqR9mhfFvdk1YJnPPnjOeLvvoS7BXVBstazcVALcBvnmfPYjj/nbc2l+hi1BtQXaifioBhRqTuefG6mnmPey/DiSRtEHmAv1cNCO1BsZEm/6GXXAIRt4TQgRqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR4zj34YbRUntXALTpBlt35WplSgVVSrJVLvZSuISD4=;
 b=ILGthgB6g9xpXxvh/O+UTh1O2tSfpOsknvEshgxZgk2J7YE0iG97fMWTlsJuyLBqz0jSgPvcDRrT7As3k6NxqHYTdKcTK1frvCS6cv6gYhRV6+QFigzMjw7LbKvyTEvpZwHEneQYvnKP9NidzKEYrAt+ayGPk4xtnAyVOsbLKv8=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 07:15:51 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::b6) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 07:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 07:15:50 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 5 Sep
 2022 02:15:45 -0500
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
Subject: [Suggested-by:Shuah Khan Patch V2 1/1] cpufreq: amd-pstate: Add explanation for X86_AMD_PSTATE_UT
Date:   Mon, 5 Sep 2022 15:14:18 +0800
Message-ID: <20220905071418.1518338-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905071418.1518338-1-li.meng@amd.com>
References: <20220905071418.1518338-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 734930c7-4f5e-459e-a7dc-08da8f0e7698
X-MS-TrafficTypeDiagnostic: BY5PR12MB4241:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TlGip8htRNCyG/aqsdDl2uXCAtS4DqriwX31jztLMBUw+jModicJOBPJ2BzLlIzuLMpzJ7i1+SnkPPNVJhiUzLhCDU2Rmhle14gjN6QAYYURNELnTdyVCjN9CHd7gDIiZehuDNw6u1p0QjpLiQmIcqkep4CBamsBQ150SsZs3JPBH/rMbRr0I1DFzv+RBT3qR4KgQAKSySJK74nteni+SXTD2xXF95nGV0TMBvMSNWWpdbLh1ONI2PVH5SEi4pX3N4MXovoeFTTP9POWgK2x9Y90vEPGjw8TjjmIzmSxN3WSYwiosff1v1kFfA5ge4rDUM+yWsHfOAUqJL/d1YYUnh1DWKlk+J6Wx2cvxOjtTjzVTLOFjNU059y5enMQLrZu/pJWY/J0gFxH0XPgW0MEzRriIjVx8QgjJOg4fsUhGtziZ7+iIZ+y/Nkit7m8eJDgh/0AYCOAOfLJY/Bxjmz1M1gV7LG0hqO6l7asItWltwgRXJ2I1cO0ryENObT6ve/f9ncZ2nDDVShhcx5hMQetQHdAOXqZJFte6dRR0oGxNm09Jw5EXEHSqA1jtd/QcN2o0d3Ej1KuAxbNLj2TA2nph76kaNEjzm1GgUei2gCpBu0SZlARdKFqSowXymxT13wjpN1WabX2RiPSjYvW5AQbeUDAx0MHGcZFGeZlbWV+030g3PLVAQFg80GenGNSalIkR+tL2CSpR4WNSpQvSIow8YASjRRLefgkB6kU0pWzQf0gL8WIAYLap63fKGh3Ovr3TorP9R6vM9NQ9DYovzbpONgLLL2Z3RIbyazNaqsunQL+ki9ZAEvB1bLhX78ulh8M
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39850400004)(376002)(36840700001)(46966006)(40470700004)(82740400003)(83380400001)(36860700001)(40460700003)(6666004)(5660300002)(26005)(47076005)(36756003)(16526019)(426003)(336012)(2616005)(186003)(1076003)(7696005)(2906002)(82310400005)(8936002)(40480700001)(86362001)(81166007)(54906003)(110136005)(356005)(41300700001)(478600001)(316002)(8676002)(4326008)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 07:15:50.6345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 734930c7-4f5e-459e-a7dc-08da8f0e7698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel module is used for testing. It's safe to say M here.
It can also be built-in without X86_AMD_PSTATE enabled.
Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
is set disabled, it can tell the users test can only run on amd-pstate
driver, please set X86_AMD_PSTATE enabled.
In the future, comparison tests will be added. It can set amd-pstate
disabled and set acpi-cpufreq enabled to run test cases, then compare
the test results.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/Kconfig.x86                         | 12 +++++++-----
 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index fd1582716c58..310779b07daf 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -58,11 +58,13 @@ config X86_AMD_PSTATE_UT
 	help
 	  This kernel module is used for testing. It's safe to say M here.
 
-	  It can be modprobed even without amd-pstate module.
-	  When the comparison test is performed, it can load other module
-	  like acpi-cpufreq to test cases, then compare the test results.
-	  When only the test for amd-pstate is performed, it can tell the
-	  users they loaded a wrong module like acpi-cpufreq.
+	  It can also be built-in without X86_AMD_PSTATE enabled.
+	  Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
+	  is set disabled, it can tell the users test can only run on amd-pstate
+	  driver, please set X86_AMD_PSTATE enabled.
+	  In the future, comparison tests will be added. It can set amd-pstate
+	  disabled and set acpi-cpufreq enabled to run test cases, then compare
+	  the test results.
 
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
index 273364650285..f8e82d91ffcf 100755
--- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
+++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
@@ -32,6 +32,7 @@ fi
 scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
 if [ "$scaling_driver" != "amd-pstate" ]; then
 	echo "$0 # Skipped: Test can only run on amd-pstate driver."
+	echo "$0 # Please set X86_AMD_PSTATE enabled."
 	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
 	exit $ksft_skip
 fi
-- 
2.34.1

