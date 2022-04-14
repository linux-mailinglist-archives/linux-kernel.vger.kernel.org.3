Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18F501991
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiDNRGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiDNRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20125E0;
        Thu, 14 Apr 2022 09:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRLPDJDDMGQR35P0GlZIj+jtowbamRysKVZWv5zFNE+IUJ1OH5SY+8xhmxT8WdtnCQRviF9E680AMV6m5XjVv2YO0m4n1j4FjbqETr/oas233zIAc2foW10urWUgdkQcSGJ8s3Z2o9zxLaZFfod4ZEwi1o75NS1F/AYwEtdBJuITM9Ra+KlAaaezT9IAdRBC04VqcaOVsT9wH1vPfqL+ME21Tmd29GqJYDA/lZVoA5nhJrRYwCyPb222QTXUDpghSNPi6moeUZ2SERd/7GSskUxuI3QqdBh10I7od4hSMRxhwwuqkoCVoQEH5XdjOBebYLvHUD+rfYYE//CNnM9hEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsH9v9VH2C3CZrHYQj8mjGeSpGLVTuZ58YPEeXGvtjg=;
 b=DVHhVPzLuAE42nMIVahWvgco6H++2hJH1SAjF0pVdCRQjoI3+dUMqU6H05bX5U3NNchSaSlFMuj3v4kzkyGj3vbs+mlX/+1P22sf/i2SOO2ChU5t+PnDrwZ9l+Jn9W3hHNZOlYx1JNfOZlG9EuLrsg0dyMXdw2zbYGJvh0oL7EP/4Ym1jE+3Z94hLaRtTqnEDvjOu9dmzOjok4vjoG9aRy7mZUC5NtPwXvllXhcbdyigfG81WJN8TEggnPPhzZt0okksooF/GeUxMp8xajbYdcmsF/BKuRSPeOvtAT9ypBAvJIAyhRuBm3vCHyAztQm6DVNoE5Cq47LuceFhEaPkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsH9v9VH2C3CZrHYQj8mjGeSpGLVTuZ58YPEeXGvtjg=;
 b=AwQKvf1PuKsts2sBfBgYJ5blbTNb6c9XZo6d7YrjAugFS3lcyTTnDseMB47d/S47ZP7bk6/hP1hxd4LrXCQcbeoBILXZdHWmRmwvkVSk+c3TmV3hWa3pSEwTU0ADaZIVKQ7I+4hbwsjWW8GgnCRDc45m6yaC3ZbbPzAPSmI9/78=
Received: from BN6PR2001CA0019.namprd20.prod.outlook.com
 (2603:10b6:404:b4::29) by BYAPR12MB2613.namprd12.prod.outlook.com
 (2603:10b6:a03:69::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 16:48:13 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::84) by BN6PR2001CA0019.outlook.office365.com
 (2603:10b6:404:b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 16:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 16:48:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 11:48:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 1/6] cpufreq: Export acpu_cpufreq_exit for other drivers to call
Date:   Thu, 14 Apr 2022 11:47:56 -0500
Message-ID: <20220414164801.1051-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93a64e5b-59b8-44f4-c3c6-08da1e3690f3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2613:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB261376A501ADC515D7DB8D38E2EF9@BYAPR12MB2613.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XZpx5xkHH+VGlI5etn80u53SnSD5Mw+OsQcz+d8rDLwlg0hPOrL9RgDOU0N7mn1THnUiC3cwWV+Lql0qA46NAFExmbHwFfUsyxKG7T+PhlXnxUK8GzF1hXIuZx7ARZMYnTs8ZDaf3sLSqOORPzVrxYfNq3USOIAvAVNiGc+Mniaf3W2DlyL6/1I/b4O5ANCvUj1g2rJbOvqxNgLbFcuYTXWCat2j3X88QAfDlRo4kamx7JWcH3y8HPZkdQ+TsnGC8FkII5lQjqALiumWRFwvFnN5++YHsPzAAe2hyBeFp9Mx003wOktw9kqwhmkLjdzGMOmpzXkiw4Mipy26eBgTccfG0g90B/Mu2WDjLFfJzxQfg8k4L126wqb+dgQivmn2EjLpDmExpAwHmPzcOiMcdT3busC2t3PV2ZdfVUcDv6Ht93S8LyhcJ2O4QtI1Ixd+9C+4O1DSXfTFsHKndhjOxm3vpV0xHUzt4WueyTDj9MsvzrDP4a/7uDDylf4MrEJKr6YPnbZMaMEpiSKFvDMlvfuYSUctexsYrHXRlfO3T7s4WF8S1OHGd4uqNomvoIC5i4ZKOmKrJWbfMHdmjIJzVdMehAiYNfqWoVANQlX92yhb4weQEqMvu2YFlbUw+tyGtsb/cBUhYRNk2MA9NDBP8EyMOw8/jguBsloaZaqsNZwktLNJUlBwnI4uKLZmKC/kdj6WQ8HErHxJMBKUmEq5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(40460700003)(508600001)(5660300002)(44832011)(8936002)(82310400005)(6666004)(1076003)(81166007)(186003)(26005)(16526019)(7696005)(2616005)(356005)(54906003)(110136005)(86362001)(83380400001)(36860700001)(426003)(316002)(70206006)(8676002)(47076005)(336012)(36756003)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:48:13.4683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a64e5b-59b8-44f4-c3c6-08da1e3690f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2613
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the only way to load an alternative cpufreq driver is to unload
acpi-cpufreq first.

Loosen that restriction to allow other kernel modules to unregister a
registered driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Move to include header
 * Create a new symbol to prevent NX protected page fault calling exit
   function from other modules.
v1->v2:
 * Export symbol instead of changing internals

 drivers/cpufreq/acpi-cpufreq.c | 10 ++++++++--
 include/linux/cpufreq.h        |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3d514b82d055..38358ed1f932 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1033,7 +1033,7 @@ static int __init acpi_cpufreq_init(void)
 	return ret;
 }
 
-static void __exit acpi_cpufreq_exit(void)
+void acpi_cpufreq_exit(void)
 {
 	pr_debug("%s\n", __func__);
 
@@ -1043,6 +1043,12 @@ static void __exit acpi_cpufreq_exit(void)
 
 	free_acpi_perf_data();
 }
+EXPORT_SYMBOL_GPL(acpi_cpufreq_exit);
+
+void __exit acpi_cpufreq_module_exit(void)
+{
+	acpi_cpufreq_exit();
+}
 
 module_param(acpi_pstate_strict, uint, 0644);
 MODULE_PARM_DESC(acpi_pstate_strict,
@@ -1050,7 +1056,7 @@ MODULE_PARM_DESC(acpi_pstate_strict,
 	"performed during frequency changes.");
 
 late_initcall(acpi_cpufreq_init);
-module_exit(acpi_cpufreq_exit);
+module_exit(acpi_cpufreq_module_exit);
 
 static const struct x86_cpu_id __maybe_unused acpi_cpufreq_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 35c7d6db4139..223bf9760117 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -273,6 +273,9 @@ static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy
 						   unsigned int new_freq) { }
 #endif /* CONFIG_CPU_FREQ_STAT */
 
+#if defined(CONFIG_X86_ACPI_CPUFREQ) || defined(CONFIG_X86_ACPI_CPUFREQ_MODULE)
+void acpi_cpufreq_exit(void);
+#endif
 /*********************************************************************
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
-- 
2.34.1

