Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127E521205
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiEJKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiEJKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:23:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E12550B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMjOmJUdxhlJMeag8lPP8nAbdTmT+TVrqjza1Gdc0XP8UiUNLqGHM0UBUE0oEKz7xPxzSkrgAMowNGPFGHqylZjVmL6nu01o3GSNSeg/1+Pi/jVhKZk5eEtkvcKhrgOl9O0y651fuuhWkl3z6Zv83LqLW0BI43FYBBJfO37mofyk3/zg9qQUgcsLmQRIIigZn2OPjETaKuox0XmlXMb3Y1pTuaCMQtgJQk/9LzY9Vh0pL76LDiHlbSGwp0AJTPk4YOTyRlQWAV6w0zAbL2Kfr31hOu93ihxE/LOj78Mow7poAsu8VYt6PagLCY8lVZN0gVXZM7xdR1EBDDmINV3u7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzUtXc8CR7FthY0oQwt832P7gd8vyDglMds/geh9hnw=;
 b=MAHXoC7hUgqewYiOLtLFkyj46meFpnpZxqwbrzFpT0CBkAxhjeJF1N98w9qFegd5VEe0CvxfVFwQG+l920HX1rcyGskIPgpoY5Dc9RJzhez2f683YpFvZaUMjUWJgNL44AkkmrvFxmE8Qv8jD1neWB3MFW5jWS8k+et78WR/aeT+x60FFCs9S7YOXkSzZE8M5UJxx8op6pBfqfElUkEad2mPVlQGDmnM+WQtzb1IYXPLfaFNF00vdZqFUAtaRP/W76h59ocRs8PrOMvDgTGQzbbjMYyPYEU7PmLTFPuZ0XM+uex9fQDnry97qYeUHvDOvRgq7pNl74WWz//oMrg7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzUtXc8CR7FthY0oQwt832P7gd8vyDglMds/geh9hnw=;
 b=BdzMiZb2YxcCTh+RPu8pLQzLzyf7aTc8PbZU16iggtlqc46c52YqFgb2xKsUiL1f9uD++cNcOOPPbV78BPTat/XOiRUjO5pY14HiNRT0CrF9hr2Fcxy42NjJticKvIdoWUP2BNWEcI9cDOLE/oy6BBTrCISS9q6vuaOA7b+tPFQ=
Received: from DM6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:5:1c0::40)
 by CY4PR1201MB0149.namprd12.prod.outlook.com (2603:10b6:910:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 10:19:18 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::f9) by DM6PR12CA0027.outlook.office365.com
 (2603:10b6:5:1c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 10:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 10:19:18 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 05:18:47 -0500
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
        <puwen@hygon.cn>, <rafael.j.wysocki@intel.com>,
        <andrew.cooper3@citrix.com>, <jing2.liu@intel.com>,
        <jmattson@google.com>, <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v3 1/3] x86: Use HLT in default_idle when idle=nomwait cmdline arg is passed
Date:   Tue, 10 May 2022 15:48:06 +0530
Message-ID: <1b24cadcf1d86a91352baa13905218015b9d4fed.1652176835.git-series.wyes.karny@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
References: <cover.fba143c82098dffab6bbf0a2f3c4be8bae07ccf1.1652176835.git-series.wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed07e99-553b-440e-1bea-08da326e8ab5
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0149:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0149F6FFC5C5C7BB7A660CFE84C99@CY4PR1201MB0149.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPexCSMBIe4T6OkhfYUChsCLkxFUbj5GFqpEAl0MhWuMvhjRYM2H+R3S2Uht1OyVtsWCewaP7SbJZ9I674IYRFoMSBVm0/+QeEDElROGx3wGMecYkoalZ8IzzaEUBdwbP1x0mFEAQimSJQjG1E6C77Eo4dfjNgXhtCi7MwC3vl3R4vLbJVBdzv81UJtKMECqnWvzXVizcvJhIyFczkmEjLbVKhSCyRqklpas60tKJH8hUAiKC3MEQ+zAKTBFFdO6fzmc5G2cottDI6GMbhPEk66X6+qo5DuHj0Gvf9Ulh9G5+fUGVL0Svx3+UUSJHOK1x2y8ptNvoqhndhi2DPCSnMU/DsblH1FFWrGw7Aenl5o5KzOecJR2Bd+Nbk05ttgOJ9Js+0bJb9pe8TYIghUby9Wb+Jeft2St4ErcU6LDY32o6YjMp88NRkyO4Nt3dHuovsKeT/VuBpN9EC9mmWXaxThMx8e9/JoyclDxciDOyY/u8JflhA9V29WmkIj8lM4tkfWvj+sNXdffHxmHHqQg8yv0dX/vkTHxR8MoDhOobza3zckBnbvxyWhHzhVrHQgQjmwvnY/dYt17HhbFXT6XokIDcEX2Mrj12vdvot5vsrtLz0015KdVRgfMxNLtBpvIblZ76ppAPuP/QaYHYHSuKEKiRSOQD0/qTuECnQgG36T6ILkawielv2nG8d8PqrH1huVcb01o1UEjK+sRJdXhsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(47076005)(40460700003)(316002)(2616005)(336012)(426003)(186003)(82310400005)(26005)(44832011)(16526019)(5660300002)(7416002)(8936002)(36860700001)(36756003)(81166007)(2906002)(70206006)(70586007)(356005)(7696005)(83380400001)(6916009)(54906003)(6666004)(508600001)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 10:19:18.0169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed07e99-553b-440e-1bea-08da326e8ab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v3:
- Update documentation around idle=mwait

 Documentation/admin-guide/pm/cpuidle.rst | 15 +++++++++------
 arch/x86/kernel/process.c                |  4 ++++
 2 files changed, 13 insertions(+), 6 deletions(-)

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
index b370767f5b19..49b915d1b7b4 100644
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
 
-- 
git-series 0.9.1
