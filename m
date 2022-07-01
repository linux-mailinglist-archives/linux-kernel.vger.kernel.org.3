Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF079562930
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiGACeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiGACdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C751F61D4E;
        Thu, 30 Jun 2022 19:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHmRqX5Yq9G/Bu9ydvzo8CWr35xU/fnOJJr0BWCfBU0Z7prfYLWY/2g1JXk2b8gvDizHUpJUihaBi5DU5O388N86MkMcRUL7X9XpdSaeBOs1qfDlEXN8SJ95pNeNxKVUaWgf+a5jGJqIqgylvDxddF0y97MnA5LkoaAg9hBvy/xWzklpAGx0EHqy5Gg66FkD3z+3mHSIJKKsiHi7IZJx5pUeCEWKakerpJFSZDcH90Ii37Z+72YlywxHRwKdheeIV10R6FNZ8BdGM3eUmGShNB31QypXFaIhuyHAWaG2DlOumEB+bgmm8H8C2AfPT99sUD7K7qFgN3/gpnTtto4OZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkhZnEcXG6Nxb1XMlvDZn+rtSXKxubNTr7Rte8crIHc=;
 b=WQsQg+Ie+lceqv43uPUi06hIcCEe7KZnmLM8RErNrbbIQLbeDcnOaYafjm4dzIyanlhRQ75iORmCIQdoKDuqjXnZ751ykrFyX7g8J8wVE0lefbnRRZGdyLSIor7Fiex15qffZkdu1D1+MFyXC1RAsIeToFAisrGSqcFwwCBsg8h9f6hJmj7B2YXjQYokJWqJ2ex+csqzDCuouetfPPV0+WzAaxBynfccFEwf0sPll3Nd0MR4B7a0iQSIcapuf0btpnlkW8Dlx8Ei4Aou9wOa+dhWNXAVM+W1A91ibvAM1JKEPumdv1UjuCURPdpz9nbUzfLEKZi9NRdhRAxGAiW1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkhZnEcXG6Nxb1XMlvDZn+rtSXKxubNTr7Rte8crIHc=;
 b=kM/vr/xRKrYJIB3mVkjWrtE0k/l8Up9pjaoLjHbKuBQC+aZ70Qs6Xe7b9KIUawRF+7nsdQUWSN2oh0Xm6LGRbV7krKFpL6+RzlXwGJkG3Xo44BBnd3qvjf2pOrIJ/b+cvffpBLpeXD48JTT/lE7sp9rxX9hNPl+lKnGjFifsCc0=
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by BYAPR12MB5704.namprd12.prod.outlook.com (2603:10b6:a03:9d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 1 Jul
 2022 02:33:36 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::c9) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>
Subject: [PATCH v3 09/10] HID: I2C-HID: Use `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:27 -0500
Message-ID: <20220701023328.2783-9-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 652ef101-d437-44ce-a306-08da5b0a1941
X-MS-TrafficTypeDiagnostic: BYAPR12MB5704:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtK6JuCR3rSUtaM1C4BWBVB9Cl/FviRpKFfcQgYlvc9Utlfm5Czm2EZ1+mNxUQFtb+SzRioxhNTpBIJxTDNsoC81jMoJ3eyP8UwWnGtppdt3djOPZfvkGubh65qlI65/fBcs2QRxnkNO2TIOc4Ah5huAEtnF9XJtQU2bl/mVyWyQNCbQIcQkngwZB4EaBHCqrARMbIe+/XwmunXrF/myNyAcAJJRhq73M0tts+kkqrfIdMDo+7zL6SPdVN69czawMKAAgSQWHFHqVqUSofI8bbSAwxc851c1m6lIJZvQihpkPFEIrB7M0bZ3Uettm3kcwDa6RXUUGXp3ytJBW7yxVpLpqytCPYqTKa3sM/HXA63R5dDDC1SG0v6CAxZzkIyfUJRgImxlEoDz3RW6WMcuDsz5GWryl8oM+ZMJxwHec9YEmkHApuno+UUhZYALUoo6WJYB7X7APXcfALVPCiUq2pL5eEkTtU2xgIQ3UVeOHnsi20mdlLSdxCvhFt3bF218drV8NLBotYzhr15/PtPVsCcqqij9YuVIswvM075/NeY5ye9mMKqOY54fSBdNNeTrqtPZOe/VoV3hcK4CYIFr3rCmPua5UT/fTlONgbetnGHx33fT39KnLv2SNHr1yaxpSI6ctt88VnYXEUU3FbRL65pNstYmDFjYU0on7dVhDwJgSZEPhyRJKdFl8THAc8MCnQTqmAi78JRfkWjI7zFMiaEGL4akWV8xgdLtq6L19hMZNR28Nm5JuXrTXObxaAb/kvLasVW+SgAWUoqPI8tm6RISPHYrVx/zMLETtd3g8HP/VhUNpimUgwA4ruIwumeY7NZO8ZsG4CPWABfJmzrQ5fEGfH4BtmzMXvGoRpnFqk58rrjJFFmo4IJA46l5Xotl
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(4326008)(8676002)(316002)(70586007)(478600001)(81166007)(16526019)(70206006)(356005)(336012)(426003)(47076005)(82740400003)(186003)(41300700001)(6666004)(7696005)(26005)(1076003)(40460700003)(2616005)(110136005)(54906003)(40480700001)(44832011)(83380400001)(36860700001)(5660300002)(86362001)(2906002)(4744005)(82310400005)(8936002)(36756003)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:35.7254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652ef101-d437-44ce-a306-08da5b0a1941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5704
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
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index b96ae15e0ad9..84d51f309c53 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -105,7 +105,7 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 
 	acpi_device_fix_up_power(adev);
 
-	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
+	if (pm_suspend_preferred_s2idle()) {
 		device_set_wakeup_capable(dev, true);
 		device_set_wakeup_enable(dev, false);
 	}
-- 
2.34.1

