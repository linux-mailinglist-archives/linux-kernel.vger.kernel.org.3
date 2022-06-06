Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5346753ED88
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiFFSHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiFFSFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:05:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB8125D5C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cohVzCuuUWfSE3k018mVDYt4cB5pLlVYR434mmeEdSYR44WMD2FTKxXPu4dgWTF6FN4MD0TbUHWAzDK11w6v5Z9lbpiKR1RlywLmbzpo8cyvTZYsecmLWRaw7h+krZm1MF/H6PXruG6gxikoX+80LxyBvRFCYabe+ZXtd35n1lkZoSMAdxqwhNeWlT489SNBx8Z3fF3szroAoNC0MXgiDPle9jBw9tkDqMZBkF2DZdZHGOgijlyOz17xaxCaZ0riysNPqNLVN6v0ch3yZBwVxzOGMfq0yuzKExaV2QDouNvd+QLhGYD24uHzwMtk2huHxd/7WQ6QQipL/i19H4jgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6ZQ4q2RRqXJvpMepNto6XwIARFnbOw06kx3d2j+Pfc=;
 b=H8OFUgL7SnD7+Jc31Lsx+rBIkItbR8q9gDuazJQfVxQfy53fCN7P99l9SVkUKI0SenKLMfs1WYWl7EIZqutXRyMucfxjSi6o8HlVfs2KPJVCJ80/7XRmqPuMpTDxV1rHq/Xs9XlCZzHByPj+/vx/LDNvpXpEa0vP77XpSvYFu7tsRuIUOlG2Wv33BVeZmAabMQWl8axiYaZM4NgNMKDZC+I83fpq8QLVFjUs/G2wnHlvFc5kYoFLcfmYfEHrkzOhp77Bwak64UgP/ppxVQ1d3M8SrhOnyFjvxoK6rpRcC5LpC/CuBn87zCNNIsoJcfxL7IWO+OjWC5TtgfeQemnq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6ZQ4q2RRqXJvpMepNto6XwIARFnbOw06kx3d2j+Pfc=;
 b=W/AsfDeiMArrvoNdf+rAXkl40bf6piv54L8ErFWgy0jsKoXYiu8yyh9JNFccGQ3bQmpuOvSqIO+6mQ8aIuQOZF9OoKEfOOpeXbIB7HnJeUZJF2g1Yd+0w8fwJaTkHfbFiMBjvL1QYGhtmoRJWkcwQ+o1cL8DGJt2x5uCMkRoZEk=
Received: from MWHPR14CA0041.namprd14.prod.outlook.com (2603:10b6:300:12b::27)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 18:04:24 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::7d) by MWHPR14CA0041.outlook.office365.com
 (2603:10b6:300:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Mon, 6 Jun 2022 18:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 18:04:24 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 13:04:16 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <Lewis.Carroll@amd.com>, <Mario.Limonciello@amd.com>,
        <gautham.shenoy@amd.com>, <Ananth.Narayan@amd.com>,
        <bharata@amd.com>, <len.brown@intel.com>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <peterz@infradead.org>, <chang.seok.bae@intel.com>,
        <keescook@chromium.org>, <metze@samba.org>,
        <zhengqi.arch@bytedance.com>, <mark.rutland@arm.com>,
        <rui.zhang@intel.com>, <puwen@hygon.cn>,
        <rafael.j.wysocki@intel.com>, <andrew.cooper3@citrix.com>,
        <jing2.liu@intel.com>, <jmattson@google.com>,
        <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v5 1/3] x86: Handle idle=nomwait cmdline properly for x86_idle
Date:   Mon, 6 Jun 2022 23:33:34 +0530
Message-ID: <fdc2dc2d0a1bc21c2f53d989ea2d2ee3ccbc0dbe.1654538381.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.12ae0052320eae3574e421a17822624143a4bc61.1654538381.git-series.wyes.karny@amd.com>
References: <cover.12ae0052320eae3574e421a17822624143a4bc61.1654538381.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25ba2ee9-ffeb-41c9-707d-08da47e6fd38
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41927A873EE4FD796487E6FD84A29@MN2PR12MB4192.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: It0sfQob+BjvxvDvyyD8I/+8/7TiFcPfin9RukWoIOlcBMxxork5KWKJg4KfalpIWJ+ZGbdK3N+uMhQQ/becFvuoq0yXOBvAnbogARS/ADGDuXRwMNVS7UqdvNQ8VxQs90dxkCAw8SUA4vscaiVulEXJqB+JNsJP9sgccOLQ0WsJbO0InnBqWPk3iJOb8jTpd8BnJrb0PY9XR4xGZnVnYRdOblQOLfj4Fmk6mo//auKKigtCsj8CJ0mWs4FZQg3zpI/esLpm52rIn8Syr3+xaiWEXIG5eLLINMyFxk4kJ2YvnqzaM5uO3nyDBMq3WF6AhRMJWs/b+QY3ZaFLno8M/+ruSAuULgEIHM1/mlE2kLgZnJGR+8XCCcmd0f4LNvvAHstMS9qbqYWTioOxeVWBpMUgFvOFnNQonbmeDwWWdh3A3/BcGtc1ZIay83UqTr1BQywh/0wnM9ulIXhSaFYsblDCrYmkuQnqJV2Q0CZ5Bs8QD7THEenMSXS8RE6uIEVuUnpoiH9g8TamJJqkFdq1brsBgH+yYMijSynD304kOuNKyZlOVeOlfg/NF1bljsuzrhauSZdkrUsoVQ7egU8+DDQu3odSWxvdO1ZfolMmtJhY968GTNI69oDDgd+SymlaMcD2H9TDacB+uA7pD2SVLO62vwqFD+TqSTFcQB7MFpBQQDmmzYvlxaFc7A2iNmBfiTpvPLVIdeM6xupFncnx3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7416002)(4326008)(8676002)(316002)(356005)(40460700003)(2906002)(36756003)(86362001)(44832011)(5660300002)(426003)(70586007)(8936002)(81166007)(70206006)(26005)(47076005)(336012)(186003)(508600001)(16526019)(7696005)(6666004)(2616005)(54906003)(82310400005)(6916009)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 18:04:24.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba2ee9-ffeb-41c9-707d-08da47e6fd38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel is booted with idle=nomwait do not use MWAIT as the
default idle state.

If the user boots the kernel with idle=nomwait, it is a clear
direction to not use mwait as the default idle state.
However, the current code does not take this into consideration
while selecting the default idle state on x86.

This patch fixes it by checking for the idle=nomwait boot option in
prefer_mwait_c1_over_halt().

Also update the documentation around idle=nomwait appropriately.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
 arch/x86/kernel/process.c                |  9 ++++++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index aec2cd2aaea7..19754beb5a4e 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -612,8 +612,8 @@ the ``menu`` governor to be used on the systems that use the ``ladder`` governor
 by default this way, for example.
 
 The other kernel command line parameters controlling CPU idle time management
-described below are only relevant for the *x86* architecture and some of
-them affect Intel processors only.
+described below are only relevant for the *x86* architecture and references
+to ``intel_idle`` affect Intel processors only.
 
 The *x86* architecture support code recognizes three kernel command line
 options related to CPU idle time management: ``idle=poll``, ``idle=halt``,
@@ -635,10 +635,13 @@ idle, so it very well may hurt single-thread computations performance as well as
 energy-efficiency.  Thus using it for performance reasons may not be a good idea
 at all.]
 
-The ``idle=nomwait`` option disables the ``intel_idle`` driver and causes
-``acpi_idle`` to be used (as long as all of the information needed by it is
-there in the system's ACPI tables), but it is not allowed to use the
-``MWAIT`` instruction of the CPUs to ask the hardware to enter idle states.
+The ``idle=nomwait`` option prevents the use of ``MWAIT`` instruction of
+the CPU to enter idle states. When this option is used, the ``acpi_idle``
+driver will use the ``HLT`` instruction instead of ``MWAIT``. On systems
+running Intel processors, this option disables the ``intel_idle`` driver
+and forces the use of the ``acpi_idle`` driver instead. Note that in either
+case, ``acpi_idle`` driver will function only if all the information needed
+by it is in the system's ACPI tables.
 
 In addition to the architecture-level kernel command line options affecting CPU
 idle time management, there are parameters affecting individual ``CPUIdle``
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9b2772b7e1f3..5cd30eedd33c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -821,6 +821,10 @@ static void amd_e400_idle(void)
  */
 static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
+	/* User has disallowed the use of MWAIT. Fallback to HALT */
+	if (boot_option_idle_override == IDLE_NOMWAIT)
+		return 0;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
@@ -932,9 +936,8 @@ static int __init idle_setup(char *str)
 	} else if (!strcmp(str, "nomwait")) {
 		/*
 		 * If the boot option of "idle=nomwait" is added,
-		 * it means that mwait will be disabled for CPU C2/C3
-		 * states. In such case it won't touch the variable
-		 * of boot_option_idle_override.
+		 * it means that mwait will be disabled for CPU C1/C2/C3
+		 * states.
 		 */
 		boot_option_idle_override = IDLE_NOMWAIT;
 	} else
-- 
git-series 0.9.1
