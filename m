Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4335B111C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiIHA25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHA2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:28:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9785AD0205;
        Wed,  7 Sep 2022 17:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBdV0m1V4y+sOS/IrD46vUXKXhDEIFk74McZT0O8H4WD/75eiQFckhzpseEHxhMEuw5FKY0IfIO4VGP/ksPKfxosPqk3v0h1sDZZp5FUjAFp6KqKx+mNFbHZ4U6wjQV5BWhKSNnWiCsq6Yy6qexQ/CwQbi3go6w0mZeg/vgc0gWmlV7HFtUVqzEQgyr8YirQ/qlPQMhXB90Coa5zbhdm1qd8/oD9PC08N61JRQ0T7bsmpxTiaiwmiV9kR0Q3B+Nd8a/RSc28xMaK0yaZhqokiTZjTH06deLx0fBQRpFBiBE2YwgfzeK/zRmIl77b83cOpgaOqr1a4KoRmIeLw50dvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCMSbnxbO7oAgC4J7x9Y3L4VevIlnzuc/VnPjYyHHSI=;
 b=OklTFtwbWmiMdelje48d4wEPZDCq3DNpP8dvFzJTf7soWJtQ7wJwDzDWAJivvUnJzl1hdpMAXD+I8C4S9PDvTgCErswhp13BujXCs15NJNn/6L31b5fLi6dkgQVEJbkLht/Qg6xq8omQzC6f9AQbro/luAx3RCpDDgGdegnLqoFX1xrhmXiJ/Mkqui+XYLCPCjsBa1l5S+UdBG/c+ZZbanXWfHG0jwXGK8Ov8KgibF2d0kXW5gKDOgFa6tlLr6tG9xhlGIfd9ru+3xpnlGHXt/Bz8I/+rifOL8I3STohd4e/ffHDc+6bUEE7e3v8VwxkF40wD2F0Rnx620KBdkvTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCMSbnxbO7oAgC4J7x9Y3L4VevIlnzuc/VnPjYyHHSI=;
 b=T5FvfWhv3xc59E/F+d4A1cQVCxMAOqIgs3iKTrtE0Rpo/QERYkyxs15z2+luDO/pQ4fWbGyuyuJkLMC5KHP9ZxZFj/VH5Fi0hwuZVjMAuqvpJog6oWU2m3qHp3/xtOr3yIWTCRr8XbQOULr6/PFBz6vqh1FBpOmedGVUMWbMi34=
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Thu, 8 Sep
 2022 00:28:47 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::f9) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 00:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 00:28:47 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 19:28:43 -0500
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
Subject: [RESEND PATCH] cpufreq: amd-pstate: Add explanation for X86_AMD_PSTATE_UT
Date:   Thu, 8 Sep 2022 08:28:21 +0800
Message-ID: <20220908002821.1648880-2-li.meng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908002821.1648880-1-li.meng@amd.com>
References: <20220908002821.1648880-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2b4c3f-45e9-40f4-8345-08da9131187d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYow9Vmh9WmRvcDNnVc1vaLc7uByPtwPzMG00eJSMpTDeDsSP2+h0mnL6z5XBXc+eSDxEcir7CFbtIptFdJFXSS35ncXPbWgymf63YhzsuLVo6JJ8723Lgpzv5IiTlDwxgSE2eZVfJUYxC+Aw+42CUUBeF7JLVNxSvPUg84YHhaxdqosVLvKnJRr02Iwkjzg8s390j47TOlHgeaBY/25PxyN8k/sEMsLcmozpHEQ2fvfE+eKNMqeWb6XLKaiu/D7KXSl4rQ0nKCGHjVbjK5+KsNHy1UZDSqDN6ujRHJB8JV7viilpIB1p6soXRjEBRpQIJ0ZtxIL3lhO6Eh8voUiFzn+2IpApxX0GBjvRAwL4lssy5HuyPlvCCCz7eCfGfOvhwGhG6SI9stFV/7z8Rf7Xs0vvNtzw3HP26NRwkFRg60ZhbqydWyRd5pQyj3tQUaLan3TXHDUqsBQcsLYy/as1tfq5xuB2+wmBnc9cP5ZJl9Qkc1ZQq9vOMNzu6d1gsmb7VR0IYtABI+7NpMVjoPjqNwimUTWILc0lez60qYOp3Fhvob5iI929uHJmfsyHcR7nWKFl6c1WcUShospJM+4mSujWJEtSFVQjxdMTKPCFjYsbrUFSqzRyQ0zEkMeP/kCrv65vAfWzc05hsYEzeUQ1BR6ky8vJzMilpmWBVWXKq90RtdZxdnD6jfiVgKn8Bdr1cgtLwyi+rB4dTPY2kZG9ObIfqoJuS5UZI8EA78bDRBXJYEacXnQ1C1I5WH3b+jK+42BCotVJn+iCPb+jDza0XXVVgZVRK4nzqqNFCJpjWknp7/by02lWP9y3gEi6SOe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(86362001)(7696005)(2616005)(426003)(83380400001)(16526019)(1076003)(186003)(81166007)(47076005)(82740400003)(36860700001)(356005)(336012)(26005)(8676002)(70586007)(70206006)(2906002)(316002)(110136005)(8936002)(478600001)(5660300002)(40480700001)(54906003)(82310400005)(36756003)(41300700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:28:47.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2b4c3f-45e9-40f4-8345-08da9131187d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/cpufreq/Kconfig.x86                         | 8 ++++++++
 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index fdd819069d72..310779b07daf 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -58,6 +58,14 @@ config X86_AMD_PSTATE_UT
 	help
 	  This kernel module is used for testing. It's safe to say M here.
 
+	  It can also be built-in without X86_AMD_PSTATE enabled.
+	  Currently, only tests for amd-pstate are supported. If X86_AMD_PSTATE
+	  is set disabled, it can tell the users test can only run on amd-pstate
+	  driver, please set X86_AMD_PSTATE enabled.
+	  In the future, comparison tests will be added. It can set amd-pstate
+	  disabled and set acpi-cpufreq enabled to run test cases, then compare
+	  the test results.
+
 config X86_ACPI_CPUFREQ
 	tristate "ACPI Processor P-States driver"
 	depends on ACPI_PROCESSOR
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

