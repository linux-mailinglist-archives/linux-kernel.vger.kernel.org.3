Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577DC4E6DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358386AbiCYFnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358365AbiCYFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:43:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB75C55BA;
        Thu, 24 Mar 2022 22:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvYnKx+VoaeHMC6/D1cexuSrQP+WfyikC2b1cbeAYmgPn0UVPBoTRGEg8ZnYxjXVqYfAc7NHkqcyIrGy0NxralxZfVRMgvq2m4XNx5nfZwoelCiMrvo9KEKLu/qR6XSGPsNF32V/PxRNX56VY5iWxr+awh9gV/g2+3C0xVGB8WtD54q8tYu3EOt6LITu0qMBAI+PMwRfTkrDexvowm8i68lWZ1+HHNd7XUdvU9RDkm13ivsPBsxNHhT6OPekGq+TjzybvkXhQDNSObhkK3+mUEMbdkRyI9WpY6cG8zEHpKvjddxm7pBSJQZihLXIGf+fp9dgsGJs9ua7TRNanCWMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CGsHSEQJXnt77wx7yyCge/9mAd3jPFALjLkRT07oEE=;
 b=UGgBRd8XAoMZCHDGpVX/IA0L6B3SG3myZxsd9HvE9UQK3r3goGN4SjveFHa1jLvvwku3Vbhmpbdgznb+bl69Fd/kHX8UXUWD+GzIMBuQIvmPvsvaU0ZJsSGNzQVhDkgf7G0+QLj0AwUVnLJG6CRMu6BY9PqO7d170XwQjsIcyy3+eJQM+Guae03Wdp5UFR3LdXUOjxAyfyekdxCagVH4yHXz2HAb97+vWZcp9TvR0vDwRRcB67/Dw3ErCKxzMkryikD6RGs3yhDSoYBlGha79QeQe3hWIfNioayJ0p2dLfSMdqzzoyxHsK0PnGFOOUZhsPopFLrF8GjK/FMDYfJMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CGsHSEQJXnt77wx7yyCge/9mAd3jPFALjLkRT07oEE=;
 b=pa0RCZzIhToV5jHajaKFkYdlDt3V2DH1gX8/523g/uJQHq1Kq4SnZPs6VAlnTMQJZPBEsRymRG8EfAYBktCfjeC9wPJMXksAtQ/bkEe0zKmsKhO85YKWZfJ5tTaXi58OFnggKl5WpX2fiqAydgkIEcjb/NCPyDSssx78VhoId9c=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DM5PR1201MB0042.namprd12.prod.outlook.com (2603:10b6:4:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 25 Mar
 2022 05:42:04 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e6) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 05:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 05:42:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 00:41:59 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 3/3] cpufreq: amd-pstate: Add a module device table
Date:   Fri, 25 Mar 2022 00:42:28 -0500
Message-ID: <20220325054228.5247-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325054228.5247-1-mario.limonciello@amd.com>
References: <20220325054228.5247-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d242e7e0-2722-47cd-7bb1-08da0e2230c8
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0042:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00422FB936953A84D306B67AE21A9@DM5PR1201MB0042.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XiKUJEeEfno5kWwLR/e6M7NTbpJBmWQdkmL+QOjDWgEvhszgNomQwxLGl/jaYywZbUfSevwmOutnonhtQsn3Pyw5Mi2WGIBCEHoNybZLCAUs9UBC4G3DU2TgDKMIOAj3eZGK5IYwOSxzh+3LLuhPMlwb2g+5eDYcDEICAC3YdVankRznp9UUqjtEaeJn+/1+AAnzQ/+bST8ckSnjY744RjjMPkg+Jhif5EsLfyh0xTXnHgijiyclRKCSGHyuYB9uLvVYG+XKyWAWfcFzFcLWEBEPjERy3oH5rm/8M8gjZgdVr/AnWE/xjFAEOMFQaQHs0S5teHZ3PQ35NJT4Tq3VezI2q8pRgAiVZ/qrMCGiqWXuUHMAuOt8JAlhX9bbxds6I3/vZui3uq1jNbbz2pXvFGvwDQHFRFYQfhYaE9TZQcjQQ20kr+6COj2zaIfcZb2RVLAn/vr4k3EAEZqIX+okBX/oeY63DetvvLKv9Ns/ZUSgwNlA5n8VskS/ttclNA6GWGWDUzPwwgpBuNoRoA4N+B2JshKB7XEMR1WNctBNMy9IA4ZXsaAoO4KY6qlMYqOukIFg24xBwe3LRV1aZ7/RwZ5CK0mI+OtmtRgqcA3jXmjrNPVeFpjvso3uROHR29ZPvtZo3IHH0UajLpJbRIPrmw8n8z5DMcbed5ddG/HtPNeIkiDmDMDj3duL9uxVDSUCG/4vyPB/xQDkA/1LCY0v2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(1076003)(186003)(336012)(426003)(81166007)(356005)(26005)(86362001)(40460700003)(5660300002)(36860700001)(2906002)(70586007)(16526019)(36756003)(8676002)(70206006)(83380400001)(4326008)(4744005)(47076005)(6666004)(508600001)(7696005)(82310400004)(8936002)(54906003)(110136005)(44832011)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 05:42:03.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d242e7e0-2722-47cd-7bb1-08da0e2230c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0042
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 31a04e818195..44490292fa72 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -644,6 +644,12 @@ static void __exit amd_pstate_exit(void)
 	amd_pstate_enable(false);
 }
 
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

