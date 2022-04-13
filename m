Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC90C4FF2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiDMJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiDMJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:09:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6210943482;
        Wed, 13 Apr 2022 02:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIiXEnp1JUWnArQbg5Q+tqlXUXRA4d0m5yWIMoOJiDz9VBq7ZY8oTsuazodXu4NI3LkIcgwL3MTxaqSJmylF2DBJ6846Z5Trrx84scDbJAhQi6PeHcUZZFHawjlHDZxwYmm293shZ4fB/MFk3W8MUAeB3UIA8gc+tw0MQ/4fgE+Fz4OAvQInYMWnt4qaQvu4Rg+vTu2OLfh7S4wCbRetyvHb0aj+YJD2xsthBYyPEQoWx1zpbx0Mx6bNhPPiQ5VbfRnRxSUWOEoZQW5p/mbaz5GCaKnE/yOkRBk1eBKIMjZA3hCS9NBKVrhx83XKcN3ragJIzihqJjBAge0bQOHNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFhfwWP2JpSIITtzrxjnNCPm9zXDjiVGb/jIh5bbf2k=;
 b=DnCo7kZ6TPJXHS1CT6++F5ePld+m17YocoqiqI2uw63vIkT0gTkveCBxb6zngxkdz3eaYKqD80Gscu1DLDoWd/R73HCvloqZX2m1gVP7UE68CFc15sCnXsw+rTckiC0FjQ8uyYM2cVnzngoIiCozljL3hnnlR/QP5IrHj8WQd0RBJnkXzx5e91AhPwan1ewuYqqyET1PBI4G1eDuLeqXtJ8PcmjoXkoYRFXzDVqz61eE8mKuau8qWsZwPBl+OKy6YSBIgKLXtYF0KiX3cbRCrilf0wlBPgo1CAPmRfS+OOQXN3eFnMjv61+T+FBAcjqyy3/zwmhPqAFf7TksxalclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFhfwWP2JpSIITtzrxjnNCPm9zXDjiVGb/jIh5bbf2k=;
 b=Ia83ydL8cZnSZ2lZFidi0kcN3PIcdr2hTkIoMpiHqneZK9QGxTLrtqQip+9UczxjMz0wRf2JVCUQSLirO+Cw0LDPi0WWzbcftxZqqjvJs5A7bEYToKhvPF82Kn0XHNfPv88prLn9rbBbv2GnywhjKWl9pbxa18gUui/h4zqiw3w=
Received: from BN9PR03CA0404.namprd03.prod.outlook.com (2603:10b6:408:111::19)
 by CH0PR12MB5345.namprd12.prod.outlook.com (2603:10b6:610:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 09:06:35 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::cd) by BN9PR03CA0404.outlook.office365.com
 (2603:10b6:408:111::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 13 Apr 2022 09:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:06:35 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 04:06:30 -0500
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
Subject: [PATCH 2/3] selftests: cpufreq: Add wapper script for test AMD P-State
Date:   Wed, 13 Apr 2022 17:05:09 +0800
Message-ID: <20220413090510.4039589-3-li.meng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413090510.4039589-1-li.meng@amd.com>
References: <20220413090510.4039589-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61a88996-c496-4887-733b-08da1d2ce8fc
X-MS-TrafficTypeDiagnostic: CH0PR12MB5345:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53450A20D5BA7FE542B04C4BF7EC9@CH0PR12MB5345.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7E+A1+ATbtt7EEdPRc7EHih6H4LWo112+/AZ97Rr7eDeMe+LvxqRaMgBKqkcfpZr9uLkXOSrE+wVDXrBDTJpQCjXXVzmMzRUlf81fJUrdgwjj4EIBGmj9Oiny/zrNoYdvpVxk0o5q/li9rVs4ec2QEVS958aI5MrReImFRwcXGRd4hOxwZ3ubekn2Xzm0M09tGe2M4l5xUM7lRtSBf0J38mVuq2N/EQAavQTh2M1q7kBJ21NcZ7+lMeHPBJsGxVsV/kcw/bQN+ci9imCo6OeOB3PNNC8AsHj9DiyicMhk6kn6NOJpKHLz//Tw+7B3jaM747FcvYj6rJ+gqSJK0Ioor4vZUMmunKX+oyaHGPTI3TqKqTBT6jz1+eDM+PATkP3pi+PQvw0YRjUkEmEShGuWsT0kkJmVa2q+Rk8s0m6dgT8honMTXGDHGuK1nnXdGEG+5cBmfVR/CC8z7ru35nNK9LE3qrSFP9b8ww8v1ZbqCEI9Ynkr0MNqQr6I2C+RX/IOZJRvGT7ESfFg5qKSPRgoG0LJGD1O28Ee49NpHf+kMPwTFW7DcQs7cHmYe8XbVK25K0qY7rnJzcLSK7SetPN8LmrEdiT8fdYfO5n3ogvatH4SeugLOmtN3JnwEdowIvSFxPKjCuqYKhqQLs+J/g1I3PKqVCbQt8HUeqn/5sYY6Fe5CF3Sq2rO6u80dK4yFvw1mjkgPbYceao2aNvkG43aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(26005)(7696005)(6666004)(36756003)(81166007)(2906002)(86362001)(508600001)(82310400005)(5660300002)(8936002)(1076003)(110136005)(316002)(186003)(16526019)(356005)(54906003)(70206006)(426003)(70586007)(336012)(83380400001)(47076005)(4326008)(36860700001)(2616005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:06:35.0346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a88996-c496-4887-733b-08da1d2ce8fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a wrapper shell script for the amd_pstate_testmod module.

Signed-off-by: Meng Li <li.meng@amd.com>
---
 tools/testing/selftests/cpufreq/Makefile              | 2 +-
 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh | 4 ++++
 tools/testing/selftests/cpufreq/config                | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/cpufreq/amd_pstate_testmod.sh

diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
index c86ca8342222..c32adc59a1f4 100644
--- a/tools/testing/selftests/cpufreq/Makefile
+++ b/tools/testing/selftests/cpufreq/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 all:
 
-TEST_PROGS := main.sh
+TEST_PROGS := main.sh amd_pstate_testmod.sh
 TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh special-tests.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
new file mode 100755
index 000000000000..5398ad568885
--- /dev/null
+++ b/tools/testing/selftests/cpufreq/amd_pstate_testmod.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Tests the AMD P-State unit test infrastructure using amd_pstate_testmod kernel module.
+$(dirname $0)/../kselftest/module.sh "amd_pstate_testmod" amd_pstate_testmod
diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
index 75e900793e8a..374a8adbb34c 100644
--- a/tools/testing/selftests/cpufreq/config
+++ b/tools/testing/selftests/cpufreq/config
@@ -13,3 +13,4 @@ CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_LOCKDEP=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_AMD_PSTATE_TESTMOD=m
-- 
2.25.1

