Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90956C9F7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiGIOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGIOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:20:11 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D671581A;
        Sat,  9 Jul 2022 07:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkhNJSclXluM41Kd3G3GlgBclt4+B9cb9u7atKutpHmlgj6oTvQrYif6yA1RkwbtJaaygO+hO8BZcJJcbIWvemRInNMrB6EzSuZbdsW2Pjy2iPb0bHpmIX6QNoPfy9iSTJLr2mpMf2LG1sryu1jQ/bWHpdEFMzI//5AQDQ7z7tHY06Rbp1cpamdu2JtYRhd1ajZrwEN4Bo+PPTIco8qAeA+a3RuM68j0v9aiCH+CHgxcHhoyzSexlx8khmp4zIVMJ1LdHRfxTdtzzj0g5FboB51GUaFmoMHE76ypwKpo8/uFtRkTtUX5oHs5ei5oECN3t7iN+jwoiDnIhYpttPQADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPbCBR/Hipu+K4GFIOUAEHBzfzQfFDWGmqfnqBuvd1M=;
 b=LDljm48fYEPwfi0zrHU273ZU13AiJjvJEH/QBdHxcw1G0E2rvxspMEvh5hmfii5nzjpw7/vcj94v4Jdh4O6XFA/kIohdVtfdBLB47VFhD0CIhMftGOYGO4k+0lGdi8xA9Cb5zNSrLBPHrYD79QirPU280CJ74XL8K2brm1kh48MPTtAAHmRt2HQHIovSYDCrajfQxKsONKc677WY0OpDRVPUHjMC2EcMrETZjrjTowRDerWVCLbGhDlUjdcpWhvwqq7gXTWq8fCDdxg+DaLe5RDexcdm7us/GlR9+ijVxaWz4uEtitCVNvH/ULZ92VqfEK7oz6pui/3uwZ73H2xTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPbCBR/Hipu+K4GFIOUAEHBzfzQfFDWGmqfnqBuvd1M=;
 b=oKaNXzFYKpR4HtkWN+q9kroOxc11P9QyQUNRBiHUnfa7wUtx9BkWqkG3fZItmPqb1rTACkdOqbsLGJv2xupu1Ckr1QrJQsTINBIUXmxy+o1qftIZ13chYszsRKfCVkExF1VWo093c3RaWLsthNImGBAuezYrWWBWtv/CgNUpobA=
Received: from BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34)
 by BYAPR12MB3224.namprd12.prod.outlook.com (2603:10b6:a03:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Sat, 9 Jul
 2022 14:20:07 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::5a) by BN9PR03CA0299.outlook.office365.com
 (2603:10b6:408:f5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Sat, 9 Jul 2022 14:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:20:06 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:20:02 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 11/14] cpufreq: amd-pstate: add ACPI disabled check in acpi_cpc_valid()
Date:   Sat, 9 Jul 2022 10:19:52 -0400
Message-ID: <20220709141952.836578-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ed890e-6425-4b0d-191c-08da61b61f7b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3224:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dT2ynngnVgrTPX1FBzZYXNnWwL8I5ooZNTFsuZrU7G0T90rv96leOHDWTFSJKC+rtvZ20cQ5VAkGnxVGUx4orzQIfXjHGT5Gam5f4X7SC0st+P1NPA/VQgbszN/RsM3KfrIOSvkunsfEljQtO4v9W3ZQZWvNWd+W8VQgUKTpUd9Py0PimR5qgEkK9XeOz+zB8F/LVFbPn+0EC44ffJj/1cDXc64QpyL6mSeKCFa606Y0vYFZ2yieTCjjUmlsh4bM6oXfP+xeNSmez+CWT5JTVU5m3p1LgPxYTSCWcKjlXhG/3cTBvjNBe4KnIXQUvAk7NXbx1kSVP0uaqfPRm0nbyGC89xQcLww7n9oUkKgijGfl2G6Dv1mxG6+VQK2gc7YOUt0nF36n1VvqyHn19/XPKl7z62wv8Jz05bvR0yIA+oSMsK3iPh3nXPLKL2SaVK9OQqJg5fuxjpHN04jLEm5I0wsmt+eENrlXK54dpAzRMgfO3BBFgif3LCkT4VpqjoFda7umHX4MuIYJnuDkS2GHY5W5BSZ0zMo+Sn2UtRJeM6/TXYaL5HABb7LA9o4cWegI+sIL2UZenb8oYzXsTn1i+VAi40yXBCPTErzXMBDS6MOkiIeLWqBJO2yb4uuIT8bsZ1MZ/rWpAtrr7GzMmMbylSPQg2gZXQct/hv0B8WLxP65Fw93gT10psjK7OQw5WVAmn3wx8jeW9FBiZK2d2zZe/qbTFpnddYBJTqHRh8iKYxGW5gmz7OXLzHdJXtJYM79SGmGhdB+1+5Ha1RXx7DIbNIOdSn04xMvXDbtOGYGhVTIYrj0/85PkrIxWPHOp3SzsuIEAv0TXCEncBBe6Ey41FwiIiEDN56qkwQvugL64McBgCB6Lgkhsu5qoDD2vF2u
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(40470700004)(36840700001)(46966006)(83380400001)(426003)(4326008)(82310400005)(41300700001)(81166007)(5660300002)(70586007)(8936002)(86362001)(6666004)(70206006)(110136005)(36860700001)(54906003)(2616005)(7696005)(2906002)(34020700004)(82740400003)(316002)(40480700001)(186003)(36756003)(47076005)(40460700003)(26005)(6636002)(16526019)(478600001)(8676002)(356005)(336012)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:20:06.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ed890e-6425-4b0d-191c-08da61b61f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acpi function check in case ACPI is not enabled, that will cause
pstate driver failed to call cppc acpi to change perf or update epp
value for shared memory solution processors.

When CPPC or ACPI is invalid, warning log will be needed to tell
user that AMD pstate driver failed to load and what is wrong.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c     | 3 +++
 drivers/cpufreq/amd-pstate.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6ff1901d7d43..17d67e3ededf 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -424,6 +424,9 @@ bool acpi_cpc_valid(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
+	if (acpi_disabled)
+		return false;
+
 	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 21037935e869..4c600cd7cb5b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -684,7 +684,7 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 
 	if (!acpi_cpc_valid()) {
-		pr_debug("the _CPC object is not present in SBIOS\n");
+		pr_warn_once("the _CPC object is not present in SBIOS or ACPI disabled\n");
 		return -ENODEV;
 	}
 
-- 
2.25.1

