Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3252D52E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiESNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239411AbiESNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:51:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BA6E64DD;
        Thu, 19 May 2022 06:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/hDW6nlfzwVIxvRKbfMF956pn0C/AGO9ZojX8bW1YgRoPO5jcMWwWK9lriEDfYDal4Y1/+XLMAsN7gEuWQynXR97zxeNFxkEKoO5LXKK78v8xCsL2i+56+SaqUJEMAlcZBbExvKChTMTeR9PGpCpEAN5EE8XTEuWOpYt0szGblYJgkmRnRRTgGICbH7LT/+KqRPBnys4Q9rOjdDYsWoLcX7BgY1QsWdPbxa15OWlZQXTVGopxrJX4Xc8dkzrz5Q09vXMbt3CHfFQyEJsj7U26Ty6nMmgPMJzSxaTbajnRg3AI6PRrAKGbBM9awE9+ia705JNsEybuBjG3istLXkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx/7h0LqjSd+GsV2tfSqOvfm43DcSuET83U+A1CnloA=;
 b=GHJ4hLhDZhDxhcjxN5bUiTvrihdygaYMgdAREIHQ/a6rrWw6PLWA3GSc0i1L4xL8ciUYOyV9vYD7/2fw4DtjvYBjKF9uDRByOz5AH33tJxM+xKqKEEHrycGZQbrWz+Hc5CbhwZc1GaFcuDdjaRPHkUoLH+/TX8o3tA2KfIxuPPb1Sa1QYiytmPa/py6wq5nvy5kLH8J0IKo70Ri9C237vu+aS54vna033k0OuLneezKWYYdyYrvzmToecMLyJQNx+DczMKC3Co1V9kvEV6Cxr8ZPD/tmv+rASiFXMIxwUHlWVF8rA8NoRUfp09FAM8I3eR6pfifhnRHfcTNDSHD0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx/7h0LqjSd+GsV2tfSqOvfm43DcSuET83U+A1CnloA=;
 b=xNu0pWBJFM3JQHInlTK3CcuNtwopHr+xJOaojPx7ICPrPtNjTCcOmKIIsOsukZ4j+jT627AF0lfgWJWj04HylUh4q7+SrbFfcZdiZAkAA/cl/Vf3RifkIAz23kDrHKfDlecVpfRZI7K+LotvvWMxFmSxMmjdIPCkDVwGHbV0kt4=
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 13:48:08 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::45) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7 via Frontend
 Transport; Thu, 19 May 2022 13:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 13:48:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 08:48:04 -0500
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
Subject: [PATCH V6 3/4] selftests: amd-pstate: Add test trigger for amd-pstate driver
Date:   Thu, 19 May 2022 21:47:36 +0800
Message-ID: <20220519134737.359290-4-li.meng@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59180a30-b65a-498c-6617-08da399e353c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2470F9AB907CE2E7576346ACF7D09@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkmAVhG3K80g0vy5aVm3tLPCLUHMOpnoWxQEm6vJgNMmCU2EpMFNwSI6WDGm88ZM4a4SfphQIzJOKx56DuQMWeQ5o4o0gLWWuxM0yLz8e40BQquR7fAuVhBxwnd2f+fMpDRa3+1LYxQokB1SwSQdzJq63mYiXo+pu7Z0Q8k5YgnpD+4PTZE8q7yS94h/r2Z3Bf9AQfDt6fs7AwHb+ATIleZUlpkunmBemriMQw3+ue4tdU3YQmbQx438W9yhbhxma1aDM3hZVC1GkltqkwTynub8mpuDRIIpkBrBkCsK+78T6DcZWZj78nyul7SdR7cGoQvyXeKRhg+lUh+bLqT4oGYiRSht6iCqE7gdtLy50mJXd0DZK+rVNDH7xqCTAQlJfU4SjjZ0YPEjQ5olYMSLCJO/ijUFrHTWoipK8Tf0Niyex3mOxdLD1QZUi2NEGWLsWrUNttrA/O1hMBQp2SaDb20R4luLpJ+K3S568glFkHloaPeo0CweU6nZGf6QeYWOfed4P1z11Qyo2eCUWWsLDilIFICUUxe/Cv8bC7gByN0qbfmZnD0ick6HpdDcJDQbr77QvXUzcJXR6h5hH1l+cXfo/mR6giQkZIbBaXyTz/z7j7x77KPfHN6cX0R+oTzIIwwDQc9f7Tv42xMj2w0XO284/wTjGeBhfMjV1y0ip4WD0OgRUkzIbcgaLY2p4RUdPxLh0muM+eioy4Di4vAKYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(8676002)(508600001)(186003)(2616005)(2906002)(83380400001)(5660300002)(7696005)(36756003)(8936002)(70206006)(81166007)(336012)(316002)(40460700003)(426003)(6666004)(36860700001)(4326008)(110136005)(26005)(54906003)(47076005)(70586007)(1076003)(356005)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 13:48:08.6488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59180a30-b65a-498c-6617-08da399e353c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add amd-pstate test trigger in kselftest, it will load/unload
amd-pstate-ut module to test some cases etc.

Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/amd-pstate/Makefile   |  8 +++++
 .../selftests/amd-pstate/amd-pstate-ut.sh     | 34 +++++++++++++++++++
 tools/testing/selftests/amd-pstate/config     |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/amd-pstate/Makefile
 create mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
 create mode 100644 tools/testing/selftests/amd-pstate/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2319ec87f53d..975c13368286 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TARGETS += alsa
+TARGETS += amd-pstate
 TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
new file mode 100644
index 000000000000..e1432112fb70
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for amd-pstate/ function selftests
+
+TEST_PROGS := amd-pstate-ut.sh
+
+include ../lib.mk
+
+$(TEST_GEN_FILES): $(HEADERS)
diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
new file mode 100755
index 000000000000..970f7a76c7d5
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# amd-pstate-ut is a test module for testing the amd-pstate driver.
+# (1) It can help all users to verify their processor support
+# (SBIOS/Firmware or Hardware).
+# (2) Kernel can have a basic function test to avoid the kernel
+# regression during the update.
+# (3) We can introduce more functional or performance tests to align
+# the result together, it will benefit power and performance scale optimization.
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
+	echo "$0 # Skipped: Test can only run on x86 architectures."
+	exit $ksft_skip
+fi
+
+msg="Skip all tests:"
+if [ ! -w /dev ]; then
+    echo $msg please run this as root >&2
+    exit $ksft_skip
+fi
+
+scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
+
+if [ "$scaling_driver" != "amd-pstate" ]; then
+	echo "$0 # Skipped: Test can only run on amd-pstate driver."
+	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
+	exit $ksft_skip
+fi
+
+$(dirname $0)/../kselftest/module.sh "amd-pstate-ut" amd-pstate-ut
diff --git a/tools/testing/selftests/amd-pstate/config b/tools/testing/selftests/amd-pstate/config
new file mode 100644
index 000000000000..f43103c9adc4
--- /dev/null
+++ b/tools/testing/selftests/amd-pstate/config
@@ -0,0 +1 @@
+CONFIG_X86_AMD_PSTATE_UT=m
-- 
2.25.1

