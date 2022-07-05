Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22CE567679
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGES3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGES3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:29:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B510CD;
        Tue,  5 Jul 2022 11:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFo5uqSzAjf3Q1rv1FHbM2+YxR27i4vjBTF5vzRYVQJ0OGkBH7t9yK5KKODQDIvNY0IuuMbRzMGpkcEh1WXZZy1KSgMmn123tgoeHUNbfouq4zHunRpMNkAADpzNMbp28OIeUKVvzZYlhzzhcQNR149xwlKxCInb2Bx9wEhi/ttxgZleHCBp9/LB3fFFIopx2cF2KOLq2gLud2k64mrVrrygS7/WEmUD9k8A4EWi1GlTuizFtcR+zJtaZIffOb3j7q6VWB5I1xguWP86R5QOnFGFR/FklD84Li5flF1FgaDPHpUhgvqI2IchTyQASRZlZAQ/39ydLVk6oJ+j8yjlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yVoil6hz1AbHVk8SjUMBI8nvLplcx2/lZ0ASje0NMA=;
 b=gFGlf05Pdi8EK7arpeXINzm+eAEXTbIEqw/Or18msY39HZSIdj/wobJywR3zIi1lRQveaOlx8qBBZQhx9uLl1q8d3V9q2y287Y4PGsFBUp7GJQPQgheZjIRJ/Q7NDJv0oBwUo5/MWeOhyAcYK5uegD8ix65OM+1iYGUqSflEmYs6FTGNqq862GzY6jfMNBYx464rsuaDeAXUAm67bIHqzNOHdfwM1LVO9jwrqN8YIP4vfQeVvfB/Se04A6u83H+qWcaAbkya7FyR23YvZbZNNG+RRbO7S/1hvqLsce1I1t/X0o/mHFjXvxkKqTpgIn5JWyYhccC9oMXhHicgaS+FPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yVoil6hz1AbHVk8SjUMBI8nvLplcx2/lZ0ASje0NMA=;
 b=Dw5MRWd+Lk/dhu5WU5dq5aEM7Asa0YbeNH3PGFZu7wjdwQPsOjqAFD7tHbuyldTWPfTC6c5dHSTUkc6UpzGZ+avtkRBAXBX65emUoBdT62Z96OCK5p69kJ8dUJwnilPlfckxvKMbbQULy4fYGvstSNhB4bpJGF7lAgSR7wZ0vbk=
Received: from BN0PR04CA0197.namprd04.prod.outlook.com (2603:10b6:408:e9::22)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 18:29:29 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::27) by BN0PR04CA0197.outlook.office365.com
 (2603:10b6:408:e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Tue, 5 Jul 2022 18:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 18:29:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 5 Jul
 2022 13:29:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>
CC:     CUI Hao <cuihao.leo@gmail.com>, <maxim.novozhilov@gmail.com>,
        <lethe.tree@protonmail.com>, <garystephenwright@gmail.com>,
        <galaxyking0419@gmail.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
Date:   Tue, 5 Jul 2022 13:29:14 -0500
Message-ID: <20220705182915.11663-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e30cefb-fc84-48c1-b6fa-08da5eb44c13
X-MS-TrafficTypeDiagnostic: SA1PR12MB5659:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b3uhX9yhrzwpiLuxFbhUE2ViM29T5zj3JX26dS3q0/6ueoi6RMWr7O/fsUYo?=
 =?us-ascii?Q?frU9wyGhH3BiHikvms+SUwohc0E13MuHHqKoqidOy1UF0pdKFOW43ARrVgRd?=
 =?us-ascii?Q?vAvSME9JhIDSasrJq3S/J2A61BBSzUU2SvlvjfhHgAFHhqQtW9YgvXjNaVGd?=
 =?us-ascii?Q?rD332l4LAhi2blUUvuCSKwxKrO9+3j+Z/B0EZis2IpkbLUSmSOd5ob5dId5P?=
 =?us-ascii?Q?gLy2QdTLHIyHt8pSWeCUQWpyFSh+4xsVTGdmSgrhdoNsLyheLNlVKqOsfpeE?=
 =?us-ascii?Q?80pqgvK8rTf/qG2olcbCBXbHJaIWlOf66Y50JOqWHL8DAE+Hy2Yh6g9vVmWs?=
 =?us-ascii?Q?6AjeTSmBL+b+lZ9EBovk/LVspBNeQOIuqyyjsJULRK/pUlw2ZVe/MRef+kXx?=
 =?us-ascii?Q?9d0pIxASwV0JbCBP9tQ+HeIR1mTRP48K54XRS2rVFjuU9wBX9u6yGcw14no0?=
 =?us-ascii?Q?rDlkTkHlzjhAMYFyC1WQ7m4e1k/TgM9EVrZBNlKg+tTvj+GVPDSu5nbtjnb8?=
 =?us-ascii?Q?2uU8xISTpiPysx3Hzq165FsfZaqfsZYfR4c+PnGPytb3ohXPZWwwrJg+qgOC?=
 =?us-ascii?Q?x2fUlEbgbkvzd211YMifmlpCFJBoGUlFOUBDJf8PZLcGqubAPRpSvfm2uHYc?=
 =?us-ascii?Q?80yype11hQbSbzQDKnbMIwJW4eTe4RuUwIr39C9ERL9QCJH0iTZDGIql8ihm?=
 =?us-ascii?Q?H1eLDZoeCYhUIfhGvpqxQks9epXwvXgp49dL8z6+a8jcV2+sKT1zWONs47t8?=
 =?us-ascii?Q?F2yvmGWG8T7pMFCfZuA9VOPgzDY7MhiaeObd9t5bMTDu+kRW2hDJiNJZaHYy?=
 =?us-ascii?Q?lzXC4kRH/fYsvfbUdKohXCeLWd+ZmRtmqmGNSs2SKjm7MtCSNfsjqv8VAOdU?=
 =?us-ascii?Q?ZUOHNOIWI3vtI0UadJ7A0jBdixXYomCCZuYrHRrZ7KqYUB7zBtTmR/cSnzeu?=
 =?us-ascii?Q?WnJgEmFyPxPVvNZheGyHWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(316002)(82310400005)(110136005)(54906003)(6636002)(36860700001)(40460700003)(336012)(426003)(47076005)(83380400001)(36756003)(26005)(34020700004)(16526019)(186003)(2616005)(86362001)(2906002)(5660300002)(7416002)(44832011)(81166007)(1076003)(7696005)(70206006)(8676002)(4326008)(70586007)(6666004)(478600001)(966005)(41300700001)(82740400003)(40480700001)(356005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 18:29:28.7956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e30cefb-fc84-48c1-b6fa-08da5eb44c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the kernel used to ignore whether the firmware masked CPPC
or CPPCv2 and would just pretend that it worked.

When support for the USB4 bit in _OSC was introduced from commit
9e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
the kernel began to look at the return when the query bit was clear.

This caused regressions that were misdiagnosed and attempted to be solved
as part of commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities
to the _OSC regardless of the query flag""). This caused a different
regression where non-Intel systems weren't able to negotiate _OSC
properly.

This was reverted in commit 2ca8e6285250 ("Revert "ACPI: Pass the same
capabilities to the _OSC regardless of the query flag"") and attempted to
be fixed by commit c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not
supported by firmware") but the regression still returned.

These systems with the regression only load support for CPPC from an SSDT
dynamically when _OSC reports CPPC v2.  Avoid the problem by not letting
CPPC satisfy the requirement in `acpi_cppc_processor_probe`.

Reported-by: CUI Hao <cuihao.leo@gmail.com>
Reported-by: maxim.novozhilov@gmail.com
Reported-by: lethe.tree@protonmail.com
Reported-by: garystephenwright@gmail.com
Reported-by: galaxyking0419@gmail.com
Fixes: c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
Fixes: 2ca8e6285250 ("Revert "ACPI Pass the same capabilities to the _OSC regardless of the query flag"")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213023
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2075387
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: CUI Hao <cuihao.leo@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Pick up tags

 drivers/acpi/bus.c       | 11 +++++------
 drivers/acpi/cppc_acpi.c |  4 +++-
 include/linux/acpi.h     |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a21826c..e2db1bdd9dd25 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -298,7 +298,7 @@ EXPORT_SYMBOL_GPL(osc_cpc_flexible_adr_space_confirmed);
 bool osc_sb_native_usb4_support_confirmed;
 EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 
-bool osc_sb_cppc_not_supported;
+bool osc_sb_cppc2_support_acked;
 
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
@@ -358,11 +358,6 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		return;
 	}
 
-#ifdef CONFIG_ACPI_CPPC_LIB
-	osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &
-			(OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT));
-#endif
-
 	/*
 	 * Now run _OSC again with query flag clear and with the caps
 	 * supported by both the OS and the platform.
@@ -376,6 +371,10 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 
 	capbuf_ret = context.ret.pointer;
 	if (context.ret.length > OSC_SUPPORT_DWORD) {
+#ifdef CONFIG_ACPI_CPPC_LIB
+		osc_sb_cppc2_support_acked = capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPCV2_SUPPORT;
+#endif
+
 		osc_sb_apei_support_acked =
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
 		osc_pc_lpi_support_confirmed =
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 903528f7e187e..d64facbda0fb7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -684,8 +684,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	acpi_status status;
 	int ret = -ENODATA;
 
-	if (osc_sb_cppc_not_supported)
+	if (!osc_sb_cppc2_support_acked) {
+		pr_debug("CPPC v2 _OSC not acked\n");
 		return -ENODEV;
+	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
 	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4f82a5bc6d987..44975c1bbe12f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -584,7 +584,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
 extern bool osc_sb_native_usb4_support_confirmed;
-extern bool osc_sb_cppc_not_supported;
+extern bool osc_sb_cppc2_support_acked;
 extern bool osc_cpc_flexible_adr_space_confirmed;
 
 /* USB4 Capabilities */
-- 
2.25.1

