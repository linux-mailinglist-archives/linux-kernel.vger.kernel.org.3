Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB85628DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiGACZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiGACZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:25:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B22599E3;
        Thu, 30 Jun 2022 19:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TApxjE5/OxOdErjQhJmeYfQvXFVc8zU7LCPXdi76zclS69xf/Be1Sm/9TeO0qlyY1eoqYC7JdctQmLIDn4DwC63jdidropbYXcXmP+e006SlSBLcmovlAEtwOzufe6B1Dho2esZ6VgAlZLbNIVdlzt2mGFydFBFRWMYD99WgMpG3LZ9/vtWvjooIuP3sJp7fahJiGMpqCWKpfc5x88KZldpUyvYRo9AMmGI/r4ofUILT3sDaWqoOPQ52Dn8wDqfN1Aw2PLdoTmXmiVnvDfbMLnMd1/IDOvdJhZpGyKhG6vqctuFeervJUfUbT5gZLd2uDGYvcpLID7KEku/z1oRRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGSUShS1hyYCnhvncNZKIhv+nA8VrOtazzMpEQ4gWUM=;
 b=cHDuZzHX/PuJ2Hk77iiS3Ojxhm1ZoRiFeYl3wRy7OlIhulAxNPHbgQseanLzFqjVuoYFscx7PDl1zyyrhsiKC2oSnZX6678pNJ16F01IqshiQERHfHAHCYXDB0MHGveUpjW858wsPwNDhW4GIcLXhknO3fzktKvdfV1E91PkqHitAZ8R9ifXiX+JxWKH5iaf9ueNUIRAbBXLZxW8bP1JyfFgbvFnYXPUvYmtuWlzHVcf81UkQYBXbi0Xd/vRj4TQXvUALvkGF6HxevmI+tqufJYPmHqTIV5VwPY22o+zs21CsipfHRB/2iacXuutWRjvsvxVxLx7d/sSRGo06NCXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGSUShS1hyYCnhvncNZKIhv+nA8VrOtazzMpEQ4gWUM=;
 b=KFe6icZSRptDHmdfQpo0d3AlGcAnrY9Xu6ai4dj4ahiheoywQBgtaoOWzgRigxQDSBfYaqW9qQBDZF48yCHZ17wi0gic1NMWvKdSVUZIGn2vUjDMFsQ8+X5DnqEQOAkF6zldBGtqGE4n5GVbg9lmP1xtAOhCwrMDbhUPqnwXO6k=
Received: from DM6PR11CA0061.namprd11.prod.outlook.com (2603:10b6:5:14c::38)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 02:25:19 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d0) by DM6PR11CA0061.outlook.office365.com
 (2603:10b6:5:14c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 02:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:25:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:25:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     <perry.yuan@amd.com>, CUI Hao <cuihao.leo@gmail.com>,
        <maxim.novozhilov@gmail.com>, <lethe.tree@protonmail.com>,
        <garystephenwright@gmail.com>, <galaxyking0419@gmail.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
Date:   Thu, 30 Jun 2022 21:25:27 -0500
Message-ID: <20220701022529.2134-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caaae2a2-0e66-4186-57f8-08da5b08f111
X-MS-TrafficTypeDiagnostic: SA0PR12MB4463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzLaEzWAKUk44EQOA8Ej6bDTebSABnAMnVIkCDD8qS5HqKhjzVGkdU9I4xHHVhNJPiJtr9iSUR8mDZIR7fR5BVhinwl5A9lxcVh0CGsaUkd/Uqqzsb7nwI1rgQhzwE5wguX+JRDGLdK6knxXyO8eBxJs0+JTSrNeVtUBlwAkLSjdly4hvdhuHpuYg9QKvC2w37aCRw40993IYJLxZd5o0xSUQJMMlpD2yK6R0zqTeyBi0kFSg4YlNR9EEVB3hB1fFeUlz8Jtvk3d8816g0ntxxGljzL3BRFXEqMkzhHjCMAEmFVqcfV2nnLwDhxvKuHv6meE7xlAolPHY0vNn3S80ZezSyiPOdQBt4il9RtdjHZDHuMhMxUTE9JwQ9W1RZpOWY1u0hDDpWWsjD5X5kht9fFNCvhAH2y5Y3MCJgeFoAg+sSFo00uIN7hU5nZKeAZso3lGACVp6D+Bf5B7+p0qqeG/i1GKe6jd7kxVnIuvyJuqDWZ90jYjfVViKl51Q2/00CrfrK/Co3H2H9dh0yJXf+/XgYRb1GqrW6yeIu246yh8gU0kwv+hRU2ramq6E4fqoh1zKUVbHG3LZMIYC0GkKHtDLDY9TuPnZUDcSLHaB5R+/MKtbl5/arlB5Wx83lc/5x19EH3SRFfuY8YZbEH7BVaIKSDlrw4HEbrMJthSlhB+dYQYmCqY1Pw24Jz4oqQRiNl8ekUGfAO2okVKybd8YxPdBzd92mLL5ENgcL9BtU26+ycgQixd1Yvkdhn2USdFMOWnaZJVudtOwnMym1UyK5gKaSUBO+Y2D+Hi2/GyrDOGQF/qU04Jvk6U85jMYDtTyMhMdrNhZCSBvZMKY9C5KrQeb1iUJArAw6d/85YNnDRPnPv5Xy60GkGnM18rPYD+TdHfYx4+9wqlE+YQBACu9DuIa8CG8RLPTL9VTItiwOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(40480700001)(2616005)(336012)(7696005)(26005)(186003)(82310400005)(1076003)(16526019)(83380400001)(4326008)(47076005)(426003)(8936002)(8676002)(5660300002)(2906002)(44832011)(7416002)(70586007)(478600001)(316002)(36756003)(70206006)(966005)(54906003)(110136005)(40460700003)(41300700001)(81166007)(6666004)(82740400003)(86362001)(36860700001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:25:18.7720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caaae2a2-0e66-4186-57f8-08da5b08f111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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

