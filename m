Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394BD56290D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiGACdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiGACdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:32 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57583703B;
        Thu, 30 Jun 2022 19:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuBWGnPhYLuDZYvWwskGpaxe+95Sok/GpyKzYmYnBRWLhnls4EnETGnL+i6+9W8wyv/OZa5JYdqksRAMdbkSaSlKBj5qcUJmM98nM8dXli94YYpwG98TuxdgQJtweZ7tmy+yGGMVGb2ZhxrdJgtXfjQz/3MOIKj+59uUb9ZvwboJayRzlyBc7tYGKbu/PKHedE9ragsPY86Zh98eECrruWl/jXqOoQMSDQA2AFIwxw818klw6dP+QQOnI+/CxJFMSNSaAnsIx0yKy2DXeXzILivx/bjPgC/NGVe7NIanmkZO7+GhSBgZRhHnjU7XQnIpwlfOLtG7r7iP7A2oNLAPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4OYHeLBiGCTdHytHu79OW+y55R0NXOUkWnfnEDMBeo=;
 b=mI9CKUX46Cs9wgnzdUnSsSNyjVbQloCN6crIPOpqEbBDgFoZfAzwqsn8zNReqejl7TEL/BzXinecFtk8anDEZoxBHZoA050fJH0Hi+m5RK+MTfOr5i5veQIt5+qRFx/QyC6Vm2uebLvIH4EyzF43TLg188/cqZxmUFKDvNsV+aTO8ywIcYRR3YiwwqakXR/pkVOnXTw/MgtGNVVVq7kqUZCxXE09JB++5I5gOY7gr158Zyhs2tmP6E3kSQP5GywSPyGUKmG2u7wnj3h8NXufaqoxJVlrQFn4eR5OGXvvGR75MEDR8CZ9eiBplt7dG6FMxvgWBvyYFwuxJZb5rxsBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4OYHeLBiGCTdHytHu79OW+y55R0NXOUkWnfnEDMBeo=;
 b=y0WIO5/2tDcR9vpn4Fc+0ujzkr2TR0QwLVtGDEZopR94I4Ybq4dfQaJdExgKFP8mlDzhx/7edfck42gI38TFx9TY1CejLrsziaG51DT868c9k4n+fy7KTBSZiD2dHRQbedEHki6x4/oWrGvDQlfX6s83rpYO74uduwGoZO5atPg=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 02:33:30 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b3) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:29 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:28 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 02/10] ACPI / x86: Use new `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:20 -0500
Message-ID: <20220701023328.2783-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701023328.2783-1-mario.limonciello@amd.com>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a4537d-5b43-42dd-d5ef-08da5b0a15ce
X-MS-TrafficTypeDiagnostic: CY5PR12MB6299:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxuJ08nGb30ahGIW0KkuLrMeUySnLQ2fEx0GXTRBdnaNorfum03mA6dtrutWbSiYZffqQ2SHmuq/mCtn2rjdb7iqhGVU47OXJwcMKkJlA30YCiBGsPd3gSmyHjvXBZ1PYjrUbVV7KRiHEs7jt/597GA+jp8Ex/rawMrINhLrzEZh2RJIn8UbzJbwLQlu9QHMFfPBoaKes2RQy44wqJIM10eYtjLH3yCy5UVLwmb98mgFGegw9Imuk2YHInBfqr5Aeb2vgqkn72PZjM9LsuUmoLBKSirHGypkiExK0bTAejSA0TUITdpOEeGSlVERtPb6VivqK+eQZgWgFaYDDA/Pn2axV3wAteNtbcJMmSLK+6N9JNV3Nrh0CN8fNkWmlaMWnyvNr8iMM1aUN3u+xCPngn+grNwjtNQnV/TvuEkisH+22meb9uaj18KMv2KjvDAEcRHNqxjDCVyYMOHZeLn5dYaF38bHmf7GAMKpXDhzMDx4fB2s7D4GCWhvu6d8q2LbpeApLl3jXPo64gmRglEGzYG3XFJXwIelNSAyDi3JxdhifO8wTOYygZv2EdRz36u6JCDaYVRjVPbA7jM9Jpd+ISm8mNfj4iE+SmxlMKTUljehZOwBX0RvYnx03y9iBijMKgILNuR2YAFgM3R3cNskxI6gOblCTkTzjFqUWjLdsZGhufh5Fx10JyYKElkXwfimKgyhPVgGVwSpSIM61YglzVGNmUwGcJ7A7Er4JybBizF4qcWbYvGq/mydUj0PGDJZvcJREO07hDiDJxPeOlR3j+lMCaXyBqkGvBLufDBqx0cg0o/tg2NQI4SL0OazBDgUAm8orAPXPILD1IzhtD0Jq7LvMuZs/drpvN7S698QsnoPubzrF3ymF9e0vLNyWSP9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(1076003)(478600001)(2906002)(8676002)(7696005)(26005)(316002)(54906003)(110136005)(36756003)(8936002)(4744005)(86362001)(5660300002)(44832011)(2616005)(70206006)(4326008)(70586007)(40460700003)(83380400001)(81166007)(186003)(16526019)(336012)(426003)(47076005)(82310400005)(6666004)(41300700001)(356005)(40480700001)(82740400003)(36860700001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:29.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a4537d-5b43-42dd-d5ef-08da5b0a15ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the direct check from the FADT and use the helper instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2963229062f8..b1483d5092c1 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -369,7 +369,7 @@ static int lps0_device_attach(struct acpi_device *adev,
 	if (lps0_device_handle)
 		return 0;
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+	if (!pm_suspend_preferred_s2idle())
 		return 0;
 
 	if (acpi_s2idle_vendor_amd()) {
-- 
2.34.1

