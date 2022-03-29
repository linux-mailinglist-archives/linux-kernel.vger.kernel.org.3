Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE244EA4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiC2CBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiC2CBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:01:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE532DABC;
        Mon, 28 Mar 2022 19:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUWsRGMJ5+bB24X0NxIdFPPG6e5tX32G7v/jOvu1ce3dW3GK93TLlHNzKkHbSMz7bnyNxTU6pdfg6SqsfzNT9oadfQGSV+peY/G2RXOOhZA6up2+WGs1cChmbABPAlzyz83G6KdebdJUSl4zIAiObxSLc8Rsr5WFTGT4vfhCLqrXkXFPt5dmsZXbEcW3twkTT1DKmRPSVR77Iay+yZQf+mLEu9+n7IAVYXxe+jkwsa0fgDzKIvoPeA2g2H3dWcmTlctHHpqcMbj04H94hlKAzFhDSuuBe+BgBMnRjO9fKTD1kQayGvIXaa11gBGBUVTEuQ+bdPULOOrIxuymLFn0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7b0a/n3EcVwAMYUlKPOj3ZNQSRX9uRlXJ2/fHY7ILw=;
 b=N9JOawXhusy1Pl8iFj9+jkG+iYSws1rA3WsMVnK+c5cv6p/EkTL31kPEM5x0EF4IKdemEmG+KYV0AutwPJxu8UbSFamZNu5ZMT1iqeolThL25oIacG4audNUe1LYuGHYgZ8KiPOa153EBOk4Nu1+I7GhtblpjLIqOQ2E9GG079HbIRSgi+QTGlx5xNv2vAg7sQ/fXklnQtBhZzNV1rhrqHZfMfocTmiaTp7hGvR4266OBJog04frNiMspfw1ROnQHvvJzQawnouEae8YEFEm3wtmEkupXwNNEi/spadYosOZpGc5PK0gm+OWTTPEFZ30Yh/uwRVMo7WAKANCkWUwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7b0a/n3EcVwAMYUlKPOj3ZNQSRX9uRlXJ2/fHY7ILw=;
 b=amAaTuQ7ocfEann3jTWnYUtrqKQsBBBz5Nh5A1em2O/L6OhTP4lM/yTBRlykqhX4MNeQqJKhOAxCCicANkyluC72WrikA8DGrKkjpcUKUpo9aFpnUHbG+UcB0+esj2KDj0Wk/dzoHvgzYzerQSgK0RBor347nP138BPwsNC/RxM=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 02:00:00 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::d4) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Tue, 29 Mar 2022 02:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 01:59:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 20:59:54 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/3] cpufreq: amd-pstate: Allow replacing acpi-cpufreq when loaded
Date:   Mon, 28 Mar 2022 20:59:46 -0500
Message-ID: <20220329015947.565-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329015947.565-1-mario.limonciello@amd.com>
References: <20220329015947.565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a07a08-67a8-4903-dc2e-08da1127d4be
X-MS-TrafficTypeDiagnostic: CH0PR12MB5217:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB521725DA18EFD97DD4786418E21E9@CH0PR12MB5217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNpr9LKWQicsuIsa5FX5GlZgZylVXXbLtMzDGGHR0pqr2aUesKRsfxI+3PloItIm4CIVu3JVXvbCVAVIk4NKiR9jqDkBJ9Fqnw4fUGtfzoVme6S63NSVb/1xuCBuQFLSFOV5EIBxaKS068bccXCaxix6kSkIK+3lQbTcjzhHLxb6EHtIaFJ7LBUBM447Me/1BBhY8UcVhmLhfe7nnjVa0QrLrDBH2psT7kGa/nMPruZz2Bozp1eWfkTmgpgsypwXtc6F4S+g5vvRG20FR4zSqB22j4UIEnqINjWIpZIWcUOnzWMHp/uDcodWF/6ttwZeFoP1l8QcAsW+jMlergMIQYDKIm1quggYJxZFk3eaI/G1xhGxsQfPnSsdxE0+KYl871hExgbIJOR14r0oGGgtAXPZpyaH+bRtOsF3I1IXQ2ilwz+58a/OMcOqtHpjXSYHa8+VW2NTfR3iZf67AnUPWsivGuH+BOQKnAmp6LIanIazi3Zx3F4v9qj+qVSIjE+rsJy0T/fkiiaT0Ncann1jz8lz2W2ArRxM124FMl+3WsoN3c/eYh80tRS2iOB0r+3R7ip/IZG3KrjLgEiE8Lg18T85aG0WrEu0uhjv5BTcemYrpkzjH/dadViobiDkiQLx0BM8TLVOn1p0kY8XOUrdq6edbHOaO95B5U/bo/Thx/e7WWO53nFgnjIeN9DVQ97YB0m9812YYWZ1LaHtjr2dig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(110136005)(2616005)(81166007)(54906003)(508600001)(16526019)(186003)(26005)(336012)(1076003)(70586007)(8676002)(47076005)(316002)(36860700001)(426003)(4326008)(70206006)(40460700003)(82310400004)(356005)(83380400001)(44832011)(2906002)(86362001)(5660300002)(8936002)(7696005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 01:59:59.5927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a07a08-67a8-4903-dc2e-08da1127d4be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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
v1->v2:
 * Update to changes from v1.
 * Verify the driver being matched is acpi-cpufreq.
 * Show a message letting users know they can use amd-pstate.

 drivers/cpufreq/amd-pstate.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7be38bc6a673..7dc2e344f222 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -63,6 +63,12 @@ module_param(shared_mem, bool, 0444);
 MODULE_PARM_DESC(shared_mem,
 		 "enable amd-pstate on processors with shared memory solution (false = disabled (default), true = enabled)");
 
+static bool replace = false;
+module_param(replace, bool, 0444);
+MODULE_PARM_DESC(replace,
+		  "replace acpi-cpufreq driver upon init if necessary");
+extern void acpi_cpufreq_exit(void);
+
 static struct cpufreq_driver amd_pstate_driver;
 
 /**
@@ -643,6 +649,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 
 static int __init amd_pstate_init(void)
 {
+	const char *current_driver;
 	int ret;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
@@ -653,9 +660,15 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
-	/* don't keep reloading if cpufreq_driver exists */
-	if (cpufreq_get_current_driver())
-		return -EEXIST;
+	current_driver = cpufreq_get_current_driver();
+	if (current_driver) {
+		if (replace && strcmp(current_driver, "acpi-cpufreq") == 0) {
+			acpi_cpufreq_exit();
+		} else {
+			pr_info("This processor supports amd-pstate, you can enable it with amd_pstate.replace=1\n");
+			return -EEXIST;
+		}
+	}
 
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
-- 
2.34.1

