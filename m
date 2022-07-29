Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08DD5852CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbiG2PgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiG2PgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:36:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D92863CC;
        Fri, 29 Jul 2022 08:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqgS7qmuCp3pql9sg34kVVRa3Xb890pHjIjmcHXOCzxpeoj8luTtZyNcXnciMK+FVVyz/tiKhR97RPhroe7J+W32HNZln0z+bSTXOXjbB/knFmqVvXJDJdgGk/Ef4PWDU9vBIJcR527hdXxVOCADYlrns5mX7f1zQb4OKb5PUiMcwRWmQpfitN++/G5pbL6VcEQUARqtdOlvX5Ocws7d6F0oOGAtSFYWH0nRbVuXy5F1SaubXmhF60n3/aLI6NC4amG5Fh8dpBCzAh4cvVXaGYYnvTQsE75BR1IKRqh8uUVlKE1wtL1FjJZIJlKj95mj3CHh+gqOrsO0grxScVOqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLKrwHaj1uEqs5MWTrqI2l62IQ85QckPXxEivlWPa24=;
 b=lp/t5q3PP2DrHYlEF78Tl0Ym6Af6FYoS7bH5UVGKAeNsZUoWfz7H5sziuVJSqMzeDP2dXJIEgQaxmXSjBD/v1KYc3Qa4eqLyTQGIosIw/Xp80FLrvNa1afwg29M4RpEYgqwfzkC3cYOiIOfspsoiZhlaUwzB3lVtq4KHXStJkDoOSYOm6JSNIBTp9A33C631YDK4dfwLGL/t8rDO5EDzkSQNDoiyxvHLJyAT49/2zkAXTodAPFfUZwCzLiZAvzPSZ96HbtNVz9DgRSIJqEt0SBK5sDyUxNG9VDREvcqjYdJp8EEZ4nJQPtvfGFEX6wy/Tep3yfm4fzdxsNVlibEbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLKrwHaj1uEqs5MWTrqI2l62IQ85QckPXxEivlWPa24=;
 b=imb5hjiLO9iMA1/YlhshknTaGe8ZYgDraIdug83zi9zyiGx7kMXQO09YvjUxMcLLi3y8z4C4rdhl/c85fy9l+LHqE93LbgyN7BjnxRYNnP4zXVFZJ1Fshswj6r54ibT0zl0m5VT+542LQVXMkdycfeFxdQMiplPEHLmwuFq/TlM=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 CY4PR12MB1912.namprd12.prod.outlook.com (2603:10b6:903:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 15:36:09 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::f2) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Fri, 29 Jul 2022 15:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 15:36:08 +0000
Received: from ethanolx5619host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 10:36:07 -0500
From:   Jay Lu <jaylu102@amd.com>
To:     <jaylu102@amd.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <xueshuai@linux.alibaba.com>
CC:     <terry.bowman@amd.com>, <yazen.ghannam@amd.com>,
        <smita.koralahallichannabasappa@amd.com>, <robert.richter@amd.com>,
        <linux-acpi@vger.kernel.org>, <jayakumar.govindankalivu@amd.com>
Subject: [PATCH 1/3] ACPI, APEI, EINJ: Fix Formatting Errors
Date:   Fri, 29 Jul 2022 10:35:48 -0500
Message-ID: <20220729153550.181209-2-jaylu102@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220729153550.181209-1-jaylu102@amd.com>
References: <20220729153550.181209-1-jaylu102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d870129f-c47f-46c9-921e-08da71780f29
X-MS-TrafficTypeDiagnostic: CY4PR12MB1912:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yumRXH1Z7ajd3jS9szUhd2ylSyW+1f0/KhJx1bDEEOrIRNPmGC/C6mKfphYT8WSi/iOkUqOss0+/wlAL8T97sUhKfxCeOt2zg7q4169/mIbCueRkJs+8sqNw0duNqYLdzuBGz5tgxJc9j1CdaydffLSF9Ar3OEaCQwpARS0Br2bQ1qpQ83gPogqTuKePkbqA7hYXcVZ7TIty/xWViwPs8q+yaijL/bPG8UbQe29u2GR6MwPP268/if/eLLFxNt+GLD0EsWqMOufo7yRRxog5253w7EDYSY5lNuNcGthx+onqGu7S0SpLiX9eInL3rAsuGbJ150QBSjNHYdLCD1X4NDgp7GATobZUgGDmNvV5EP2oMR8V7N58xZwLx21g6RqUneQaJsh7M6Mf6tigRG5+INUVHz+JRPSEoqPzVyEoM2KvYEqujaQLFGui/XPFRMlll3t0qaNVnsgDZW3BSvUiu0xAP/UGgq+Gn04E4bLu1BHijHbV3tFWi9kcUid2Y64EBrGwANk1pZbr2qbUi7J1ufE+a/3sUNSCYKiZrbixjniHjK+4Cv79B0daaVLx/MfsodbRW+jtdLvi62q6XY4scYJUjZkKvbxte7sT3S81ZoXBwGcXgTw5h9RWOHewFbSirL71p6yLHfGDA3vkofyQLQq/277pjnROlHTpEQr90LBWgHwoYGxsTy65UZkgD7mWzU90h14js+ynNnV75pJ3WvIh3tp1IgFVv5ONMxM9NupAlQ2PhTnS2n1utN6cZOfq9DoSP/lkwOV8X3Af0nfL4OP/YxvFVWOQoLf628ey7xDEAJLJI0rvIIfdr1Iv+CUz3q4pakwnyiEAmMoIfh/ZzwdYYi9bgW1tWVgGFyhZrk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(40470700004)(36840700001)(46966006)(40460700003)(41300700001)(6666004)(8936002)(2906002)(316002)(7416002)(83380400001)(478600001)(7696005)(426003)(82310400005)(2616005)(47076005)(336012)(36860700001)(1076003)(186003)(82740400003)(16526019)(70206006)(921005)(5660300002)(356005)(8676002)(40480700001)(70586007)(36756003)(110136005)(54906003)(81166007)(26005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 15:36:08.9805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d870129f-c47f-46c9-921e-08da71780f29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch reveals warnings and an error due to missing lines and
incorrect indentations. Add the missing lines after declarations and
fix the suspect indentations.

Signed-off-by: Jay Lu <jaylu102@amd.com>
---
 drivers/acpi/apei/einj.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index d4326ec12d29..da039c630fd0 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -358,6 +358,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	 */
 	if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2) {
 		struct apei_resources addr_resources;
+
 		apei_resources_init(&addr_resources);
 		trigger_param_region = einj_get_trigger_parameter_region(
 			trigger_tab, param1, param2);
@@ -432,11 +433,11 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			}
 			v5param->flags = vendor_flags;
 		} else if (flags) {
-				v5param->flags = flags;
-				v5param->memory_address = param1;
-				v5param->memory_address_range = param2;
-				v5param->apicid = param3;
-				v5param->pcie_sbdf = param4;
+			v5param->flags = flags;
+			v5param->memory_address = param1;
+			v5param->memory_address_range = param2;
+			v5param->apicid = param3;
+			v5param->pcie_sbdf = param4;
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -466,6 +467,7 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			return rc;
 		if (einj_param) {
 			struct einj_parameter *v4param = einj_param;
+
 			v4param->param1 = param1;
 			v4param->param2 = param2;
 		}
@@ -687,8 +689,7 @@ static int __init einj_init(void)
 	if (status == AE_NOT_FOUND) {
 		pr_warn("EINJ table not found.\n");
 		return -ENODEV;
-	}
-	else if (ACPI_FAILURE(status)) {
+	} else if (ACPI_FAILURE(status)) {
 		pr_err("Failed to get EINJ table: %s\n",
 				acpi_format_exception(status));
 		return -EINVAL;
-- 
2.27.0

