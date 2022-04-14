Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7DD501997
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiDNRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbiDNRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E449CB2;
        Thu, 14 Apr 2022 09:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU0gBkRK4Inim/KM2M1Bhh5xck8Yfz5POfQrii7D9oXm+cyDEWywZjY5V2GbE8ANJV0R1r5zrulsDPK28u7pstUonQPZWUqKwdWULtlq/Yjr8dtYuaUzRd8MKWjCFUmVWKNE8luqvsLuHM/VIkAI17F8ZDJa335bd8gw1AMJBX3fmUPDFaWCqCftgr7rmkKNem3BT5c0uSoJ01ctFJ09/Bp7NAA6xXMzzFitaDeUqzpoydcUt2aPOBwHwiYEv3uhT6G5geMyQv7hvtyKpPAHOM1wi0c2CauonqHH8kIMvatl5pBCZO2nledRejS+gSWjQvsn5zW0JZIDhDbWOzJ1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv46hVZhOh36hdtM/zKZRvRF3Pwxj0M6Wex6v4rRaEI=;
 b=bjJW3EvqcsaZrE7/3nixvlIjftT2pOicrn79Cc56nMFVeQMRKfS81SaDNeLwR23w0ei+HeuFf2MS/2LQ0PmGnSbk1E/RnvX3i6l515bNA6GdvsP9p/GakCAiwPR/oPs8WBRO1xwpzF0K5j0wsR/uLv8Nyl5bnOFXy3g1BphZsEl6r3V7qLypDJ7qz7PWqtGP8i/yp+0xxSpAbTOispj+wpAiZm3ZSg0RhLB81MIaCpI2O1/UydOjkbXLCn+H+V+/y4a/oZe+ShpfRZhiqep8Il6A1BSXn1SgSbzENtSVPiD5dbpWIU85dsoOtTkqg8BzFEpmq9qug58s2HpnEsfFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv46hVZhOh36hdtM/zKZRvRF3Pwxj0M6Wex6v4rRaEI=;
 b=ia5GOs1n5BCgotVeKhkZfbquRLtLzdTTCJ1jSOFBpD38hcmoMOGWPPGE71EMIac6i6y/8/eByEYQ/oQn54/o7tE4nRQLnURMwt+Gd4QyggYbahcsQS/TFZ+I4CWJzSzZz7qD2RRM8/Uu+9Yh5RaPYDNPaX6ePJtZcymFFNshPKI=
Received: from BN6PR2001CA0013.namprd20.prod.outlook.com
 (2603:10b6:404:b4::23) by CY4PR12MB1671.namprd12.prod.outlook.com
 (2603:10b6:910:c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 16:48:15 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::90) by BN6PR2001CA0013.outlook.office365.com
 (2603:10b6:404:b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 16:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 16:48:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 11:48:09 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 4/6] cpufreq: amd-pstate: Allow replacing acpi-cpufreq when loaded
Date:   Thu, 14 Apr 2022 11:47:59 -0500
Message-ID: <20220414164801.1051-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414164801.1051-1-mario.limonciello@amd.com>
References: <20220414164801.1051-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1160d358-80d6-470d-4230-08da1e3691b7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1671:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16718A2EEBF50E5F053BE97CE2EF9@CY4PR12MB1671.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0MBncQEM/yrcCun4yRsVanUUgBZVWmOMJqMRDCFWi3sH6m+Q+WdanGBomFBuPbyD+Aw6evkiBrz7BX67biNUjHhdBSmtIXQSt84cg8DIs6o9lBkbIR/JHzi4c4DJeck6QwnT9Uswd3kY68OT96LCSy3BDYVvnA4juGp4h6HFFas8S6oehPGh0GL8BA7KlcE4usFXTe10vLnQjYfDhsRgZtsn8BsKvZG5XvAc7WnH4bTC9cXbR/5IZmfkWY2SMXRbChl0UWZ1ThV5y0BxVjPYExXjW5JoCyE5n34m4s26xBkfqnAFRQ1vR6tisO7NFVbqHtLOWapu313aqk1B5RaE1Xcy4d+jl3OTH76dceAxyNYON5VqBUB5GFw94nJ9e0iVTV/KenD/2acWUmIkH6AFb1NmlUpgB4H+vG+ms00TD/bW4FhOhknEfn1XLGn7+z5qBd74vtr450WHhT98sm9pOmffS51oOx2B24By/g3upCq1TFUpuy/uEsc5Y0afeHiNDn5AKe4QStiOFPAj4y7x9Y6GSWdP4LFEPN8Oqz3T/2hi2buJRdQtJ3wLI0LvzrDorr8dczp7uBd4RT4sPEjtNSTeDTfO/zdrcsN2WDbCRROynIin+B0+g6ffHJYFlDII4gl1kWpPmzXorAiH7Lk//ETaS7UaJO93i3AEDrsUePVoW6Upco7/uYad6nt637TG8qJKpUmRNbRVYCWnkzuCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(110136005)(54906003)(316002)(4326008)(70586007)(70206006)(8676002)(36756003)(426003)(16526019)(336012)(83380400001)(1076003)(186003)(26005)(40460700003)(47076005)(7696005)(6666004)(36860700001)(508600001)(356005)(81166007)(2616005)(86362001)(82310400005)(2906002)(5660300002)(44832011)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:48:14.7495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1160d358-80d6-470d-4230-08da1e3691b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1671
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`amd-pstate` can be compiled as a module.  This however can be a
deficiency because `acpi-cpufreq` will be loaded earlier when compiled
into the kernel meaning `amd-pstate` doesn't get a chance.
`acpi-cpufreq` is also unable to be unloaded in this circumstance.

To better improve the usability of `amd-pstate` when compiled as a module,
add an optional module parameter that will force it to replace other
cpufreq drivers at startup.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Rebase on earlier patches
 * Use IS_REACHABLE
 * Only add replace parameter if acpu-cpufreq is enabled
 * Only show info message once
v1->v2:
 * Update to changes from v1.
 * Verify the driver being matched is acpi-cpufreq.
 * Show a message letting users know they can use amd-pstate.

 drivers/cpufreq/amd-pstate.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d323f3e3888c..8ae65a2072d6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,13 @@ module_param(shared_mem, bool, 0444);
 MODULE_PARM_DESC(shared_mem,
 		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
 
+#if defined(CONFIG_X86_ACPI_CPUFREQ) || defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
+static bool replace = false;
+module_param(replace, bool, 0444);
+MODULE_PARM_DESC(replace,
+		  "replace acpi-cpufreq driver upon init if necessary");
+#endif
+
 static struct cpufreq_driver amd_pstate_driver;
 
 /**
@@ -643,6 +650,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 
 static int __init amd_pstate_init(void)
 {
+	const char *current_driver;
 	int ret;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
@@ -666,9 +674,19 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
-	/* don't keep reloading if cpufreq_driver exists */
-	if (cpufreq_get_current_driver())
+	current_driver = cpufreq_get_current_driver();
+	if (current_driver) {
+#if IS_REACHABLE(CONFIG_X86_ACPI_CPUFREQ)
+		if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {
+			acpi_cpufreq_exit();
+		} else {
+			pr_info_once("A processor on this system supports amd-pstate, you can enable it with amd_pstate.replace=1\n");
+			return -EEXIST;
+		}
+#else
 		return -EEXIST;
+#endif
+	}
 
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
-- 
2.34.1

