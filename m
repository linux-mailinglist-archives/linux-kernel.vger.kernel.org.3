Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DBC50199A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbiDNRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244906AbiDNRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:05:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5049CB3;
        Thu, 14 Apr 2022 09:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBJ7Nx/xb/VQejZ2zpJnEZOc758IQUlGu6O6KpkbB4iNPwnn3tKQgQt4gpUROcHPEfKWJfrBGLvwa3U/3Zd/uE/2LATiZqeJnSFiq3mUxEYUAZCPXjW9+H0ekUXaa+rfrRWQ/WhgCyg7fNsWyddbnwBfbt4qcZhgSk+8KRb5iR5moFobl3rLYYC9Ogzf0l82H+Bc3a4/W3C2lfgVJ47KV4YDJDjLPBCQgbOBJcidP7bf1PlUUK+NpL1oRO7BRFRRp8JBSTIdPdDwwENr/TaSQG4NEWsCyhUcaaezb5JBIsJ2zK+kD//acVRhGeXxVdx54Wt2/5Ct2X6wFgTYwouPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l68433YVMq66wTCNnzwadv9YbsWeBaN8JOpghfEUYyM=;
 b=K/V4Ep3ceetRfE0RHF2VHRLx07d2276JGO3+kryZMggmQZAjF7FoezExJzT28WU6zUeaOHu0lhNyrnIPmQ7mh/X7qdUwAM8sDN3XxD5YB/ptAewdBoB8SftDrcIVE18neC/CIPCU6spczOhQ3R0mSxgSX5+gg5+CTNz+i/12C/4498X0cPW24fsPaOeigX5E5PyVeWw5aaOsBfs5OSZBCzEDWdle6BbGHwz6p4oGg82SrYX9pHzz+3lON1nYLYC8BsWSFXzN34nNtzlYK5eSL6WPZLSTfp+Ptn4KFZ390q8IhmqRpEGnasXjxNImYSCuq/n2xZeR538171Rq6aLJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l68433YVMq66wTCNnzwadv9YbsWeBaN8JOpghfEUYyM=;
 b=l2cxLH+Ma80FAiFlelsm+JOHt7PeIn4Hmi5bTftcNDnliYYGEufKOV1ioTF3aeEeBUf6EKEb0NZ13SKjIPy1yFqoXkopqA+d+2rRccLij+0hVYqQSta+0BeB+2TPU+eAztY3lJ9OWxemBlsXVseQJjqvGjTiYNyMv7R3XSjtVts=
Received: from BN9PR03CA0778.namprd03.prod.outlook.com (2603:10b6:408:13a::33)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 16:48:15 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::7f) by BN9PR03CA0778.outlook.office365.com
 (2603:10b6:408:13a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Thu, 14 Apr 2022 16:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 16:48:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 11:48:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Rui Huang <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 5/6] cpufreq: amd-pstate: Add a module device table
Date:   Thu, 14 Apr 2022 11:48:00 -0500
Message-ID: <20220414164801.1051-6-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8838f436-60e9-4766-1e44-08da1e3691df
X-MS-TrafficTypeDiagnostic: PH0PR12MB5608:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5608C40578E25EE0B28E3598E2EF9@PH0PR12MB5608.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyxsT4ns4eis8pMyoxbIOs69nCRQx3ISPDmmbJyzVlUcE/XAVi/Ik/kTkmba6RLCWUNXH+SSapfWqKHs0b7Zf52ooRMLcmGdwEWyzqoNVhQ88fnrkEptOhBWEOBATcOl84hbATf3xZ9VrDNAR71tO/3TtmjfZVvm5qrsLp/CctTr+Rx2WMJv+Sg4rM6aRyISq0SOzCSLoR0WxR1xcJ3fpevKRhwmhOciFJ45izJpxHrRXl48AXqVYWP9PrQyVCA9v4sV6r+fl4RczECen7C05EObbxY+KsBz5LJIEKR0sOnRdCLIJyAPA3ozT/L2syvg21d6Sc8O/SHoRZBNf8XkrCh8jIt4X9dznrR9N7+WsPoccJv6gmKT2YIHo2avUb+cuBvNdiNHA/LWEemJsBc3pHBgS6REL3xa8G3E1Lh5vwMIHhHptU+MijshSDUnzoUQaTADkuEaLgk4pk3/qKwIXL9/Ya/mPMB3ItsrR0hEvRSx3coe+/WbvccgWps+FYCSYcb9um8OkgqFSianOEatYh1D0m9E2BYrVgrH2rGaUma4oYQ+MKwgoS7lfyd5nKOWKA3YVwCEwhb/K68HTvVHcdQFyLjzJQOS+QeqGvU7IKS/GSUSqLVxmuhYGm8oBl8WQk6fJHOxAK+QrtXJBF4zWB3dSyDYAzcP1Y7EbOaE+if91HeAsuMgMyw17dkVzqwOJjZCMK2pncCYm3vW4Dpg2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(81166007)(6666004)(7696005)(4326008)(508600001)(40460700003)(426003)(86362001)(83380400001)(26005)(36756003)(186003)(16526019)(1076003)(82310400005)(356005)(2616005)(336012)(5660300002)(44832011)(316002)(54906003)(8676002)(47076005)(110136005)(8936002)(70586007)(2906002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:48:15.0107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8838f436-60e9-4766-1e44-08da1e3691df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`amd-pstate` currently only loads automatically if compiled into the
kernel.  To improve the usability, add a module device table that
will load when AMD CPUs that support CPPC are detected.

Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add Ray's tag
v1->v2:
 * Add comment to indicate need of SBIOS support.

 drivers/cpufreq/amd-pstate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8ae65a2072d6..3330504b7070 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -710,6 +710,17 @@ static void __exit amd_pstate_exit(void)
 	amd_pstate_enable(false);
 }
 
+/*
+ * This will only match the HW feature, there still needs to be appropriate
+ * SBIOS support, so it's possible that in such cases this causes a module
+ * load with -ENODEV as the result.
+ */
+static const struct x86_cpu_id __maybe_unused amd_pstate_ids[] = {
+	X86_MATCH_VENDOR_FEATURE(AMD, X86_FEATURE_CPPC, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, amd_pstate_ids);
+
 module_init(amd_pstate_init);
 module_exit(amd_pstate_exit);
 
-- 
2.34.1

