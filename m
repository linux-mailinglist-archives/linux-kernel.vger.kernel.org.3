Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F335319E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiEWQ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiEWQ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:56:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA17633E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLrxBFYrmo77BWsaynhVIwQjnRUa8/FVvD6ZiCr4uE5gsPRULLy518jMYzE3gZ/6DoFqIFqpDk2bwmmySTgogmWdaCbGwPfpzuEf81765rIWw3+wUcwoeLaTrrihkN2DGr9355yPahuwT17rQXKIJWo6B5BbLzDT2d/JWLJby6enJVbfXvdL8zpYGxZDDmusMQ01iAK3JIkG9X1vx6kF7mUXVa3ARxr7hgSwuw8preHZmiD/eJNxSDolbZSYSobShfoOmJ2bNp2k5yGjAX1I0fIFw/mqMwptXnUwltvcUwJrDsm/bO8L5jBGjDQ986VhN5O9KOtmq4IFSaeB5Vch1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TPC45Tr33vkG0ivyCsxJH22/1WUBsKGTw07yU2oNJA=;
 b=aO6CGjnWtu8IKW+K4h3F5Ol99SgqkK/mYXzAfXTEqS46LZDNeD9ljtSgOUyx9CcbnhOTSYvA2KAQNp3OkjGtnH9nt4oi14t5C+ueTdkjGOWEgnGrtEabqNUtvYoCKHy5Xl4mb2ey/Nj/CEfpDf1Dp64xMxhgDBNkHO6yLGPFyW+4r2w7DRgt/p6iNn3gZcprNqQOD16aWEhX8frrNJd0YGMUlZQL1142CirQehOh6C8vKYYaKzX5WXQTw3MvzOV/qyrG71zoD5r87bn86aTm3S/LNuAWyBynLu6asdBErmp93fkIYX4RRmX2TcNSmEPnLuVpXHdpGxQsUrvdehQxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TPC45Tr33vkG0ivyCsxJH22/1WUBsKGTw07yU2oNJA=;
 b=EH1SlQYIl5V5om25kpPNO3jVwodCv7f2ohohMSC/DnBU6WRybJve/nlIJPfPDhm87PJB4HHhKCVjoq8DAqtSQsTzB7AijriKEy+3MeXYR1l/Ku+ly1hCkcJitOypwxbI7mXtdSZeC3CPKeKLcQwoq3sYRpN2e/tJuG9Wc4ScFvA=
Received: from DM6PR05CA0055.namprd05.prod.outlook.com (2603:10b6:5:335::24)
 by MN2PR12MB3069.namprd12.prod.outlook.com (2603:10b6:208:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 16:56:39 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::6a) by DM6PR05CA0055.outlook.office365.com
 (2603:10b6:5:335::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.12 via Frontend
 Transport; Mon, 23 May 2022 16:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 16:56:39 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 11:56:31 -0500
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
Subject: [PATCH v4 1/3] x86: Handle idle=nomwait cmdline properly for x86_idle
Date:   Mon, 23 May 2022 22:25:49 +0530
Message-ID: <7e5a66c4d383652c89a0b5ec0f57e0a95902f810.1653324016.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343c36a5-7654-42d2-fc97-08da3cdd3466
X-MS-TrafficTypeDiagnostic: MN2PR12MB3069:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3069B858C9835B07185EA91C84D49@MN2PR12MB3069.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSNZQiLyF1FQVSYELKepHZCai1WmPIGOXpsySJAOZ3N3rQup0K+Qpm6E7lc1xSX/ZKX+JT2F5LAUCcc2fj6oABOCxiYYIIiIpZMy6kWfqr3Gt0P6RCWjoriIC95xb8Ur/IpGLVk5CJfsMALd6DmovRKSxGVB3bZRMm0zZrC/F5N5lZNv6s2MABHALvUNneLFGh+FKZFLbho1ETGWq3j+ktQKz3n8rZrozMiYlWp0DKRJJiFM7vM3cacyJrKMKltBG+bq8dbEkHR8ck+1nmGPJ5I/e+MTFLSQKuCDKr7mi7QfysiTufQYtXtQvdukefI4H+I0l8hA9jhmGmreRFlqaPU7PQ+sY3xkiKrg1PSNMK3TOKjs6/CNRcSwOYtF/FJ4FSE28I2NNOWs8X6Ik3Fgu5muj4jY55SbGmtELkyA1LUelxrFO8akpBxN5HY3/hH5/6hubifka+SvM11criKwR+8aki9AiTAbIkETt2yN8xix8Wgbca5yxK0R6LMWpP5AoCX4IwG/cvCf30NBO5F26wrt9EYEjiFfyU9iRRMoNVKIbwnXiL4oCeVkCpuCHE5FmVsb99eE29jQWUwaszkKcRebnUU0S1aXawkyEuGmqFTyt1R/UKm+98yR1GuaVLn843mhn31wA7DcuBv+WddM28KKH6+O8ZrFkDiXY+nScMwPJIUVezRyCZjUjlsVxuB41uyTPM+/4nYza4MPNY2Y7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(36756003)(4326008)(8676002)(356005)(6916009)(16526019)(70586007)(186003)(82310400005)(70206006)(81166007)(36860700001)(54906003)(7696005)(44832011)(8936002)(83380400001)(40460700003)(6666004)(2906002)(47076005)(426003)(336012)(86362001)(508600001)(26005)(7416002)(2616005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 16:56:39.0012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343c36a5-7654-42d2-fc97-08da3cdd3466
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3069
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
---
Changes in v4:
- Update documentation around idle=nomwait
- Rename patch subject

 Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
 arch/x86/kernel/process.c                |  6 +++++-
 2 files changed, 14 insertions(+), 7 deletions(-)

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
index b370767f5b19..4e0178b066c5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -824,6 +824,10 @@ static void amd_e400_idle(void)
  */
 static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
+	/* User has disallowed the use of MWAIT. Fallback to HALT */
+	if (boot_option_idle_override == IDLE_NOMWAIT)
+		return 0;
+
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
@@ -932,7 +936,7 @@ static int __init idle_setup(char *str)
 	} else if (!strcmp(str, "nomwait")) {
 		/*
 		 * If the boot option of "idle=nomwait" is added,
-		 * it means that mwait will be disabled for CPU C2/C3
+		 * it means that mwait will be disabled for CPU C1/C2/C3
 		 * states. In such case it won't touch the variable
 		 * of boot_option_idle_override.
 		 */
-- 
git-series 0.9.1
