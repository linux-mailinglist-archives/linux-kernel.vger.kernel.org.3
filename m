Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD5532F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiEXRF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiEXRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:05:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A2F7938B;
        Tue, 24 May 2022 10:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjSG4XXK1UayFaMm6mwq5of07MjADQBLaXxafnFrTuHigTYqthwIb9ScWSUJbTJ0QniPDoBZwuQfU/xDONEjpBDX68VXKs51JynIJyWG6Z8zt/afWjkvqie38UzBTXXlamTGORWizESc8kRwE/s0u3z4Ez6hHzIiJ8vT4GcSDGMr31EOyq3CpBULKgTypd20isMYLyrie3Ip2vx8wG3h9zMxkBI+0ChQDl582K3k0XbMNgcdWcvCgGk+CDdS43FVPgAecfvwUz03v5RrWDhnZ2edyP0DrrSXEnxb3dt1+Cl/B7qBk7I0DnXgG0I5CH1zCY5zLAUPH/mvAfIqvapuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOcVzkAfqLWZX6lFhzvfmi2oe6rC2/LYtJ8etQwpzag=;
 b=d2PMngvMpMemkbW5eVCYXfp8jLZWefzU+JMo8+QwRpw/Zf89l1hu8YNaKCwvyl6X03Wo2foLjcKktKmadEngqypK6QIF59+hAx6i9T/0536rWrESzFVq/7EYZMLLeVDroz6kR4clTF1Okwl/Pkkx2zJFfcMiO43Z1FWXRXdrGvNZosDwU4DQDChz+b7dUJYj590boDpFeTmlyy9TL9NafVj9oPWbDNatZwTEbby1VQtM8Mw2mf4CVODHru7s1/vODLltHmF3WiCVWHxvM8fpeDYuYRaICBpXkU3/TvGidai8F9VODxoFyO49O65NmPbdU9VtnNUripQwKGgT6LnmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOcVzkAfqLWZX6lFhzvfmi2oe6rC2/LYtJ8etQwpzag=;
 b=vUBNPZoAWioh6CDdwUjxkkR8eNdz7gM9jaYP3M5XNVUspD3T0hi8eOLperFRdKPKT+wgwb2qXzPEJVIEl69pUT8Mf+4bLC5voFqiQBskDX86ZS5kDJamdD7SXvZKQtT1fiV28qHNzerusD79F83EkNTCjHF9JBMazrKuLd2Z3yA=
Received: from BN0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:e8::10)
 by DM6PR12MB3724.namprd12.prod.outlook.com (2603:10b6:5:1c9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.20; Tue, 24 May
 2022 17:05:16 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::e2) by BN0PR04CA0035.outlook.office365.com
 (2603:10b6:408:e8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Tue, 24 May 2022 17:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:05:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 12:05:13 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] ata: ahci: Rename module parameter for lpm policy
Date:   Tue, 24 May 2022 12:05:07 -0500
Message-ID: <20220524170508.563-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524170508.563-1-mario.limonciello@amd.com>
References: <20220524170508.563-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c88bfc-2186-4a64-3c6b-08da3da79338
X-MS-TrafficTypeDiagnostic: DM6PR12MB3724:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3724FA42B262B72D3E8822F0E2D79@DM6PR12MB3724.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fIimEB3ylZhdrXR1KturUBQllFcGa/2r8kt6cD7JL1j5niS5GeR39OIixHu5pC3WUPtU1YNKMsEPziOAPKofR/TGgQ6rrJPeNvC/qV40nZ5UmgyG1/7iBN3svpENZertnm5n/3o1uP+al0PoylvASIU/77GClxozVH8UEYqoeNyH9ck/pxhpBBN1LM2h0GO1JiwVrJWVn6Yrl1lYCkAOAxbMiSJaRnCAtb6aWv0fLqd1tSfzbmDc+MaOf3IjxqVk7KZhNkWrirQ5SLDPhtut4dE8HS649rWi8ME/zHIboUccHZIwtpWEHjIkmWVq5ITi6qhT0w0r5omxgkr6E65fYAQhys6LVZr/qAl4oXwe3N+wUscWSB0vnSk3WPT0NRSDUeeaI5ORSqezMZt0AhWn7TG9zi8pq4G2cC+BBaUHQODBrXagxuykWCokbPfSQ2VPIYryoIfkJ1X25krMPclfTZsSXUSgIpUTY3js7Rtp9yjCL7a4xGwUsea+Z/DI+dVzmnTkkIExsXwJpRnzrSsfrfypze7D2N/sPTGxJz5Uzdrmgzb94D+27Ka0G413Oweyxim7QXa/5GiKLp7LPErFm/mJ09P93PyJOAkdXvLHMxTfgVVS5/Yob7xwV2if+nPbD/M18Gqo8PRg76lz2wxjAbBuE41Ml1REsy/1AfvKXlPalWYE1GmJVvB0MOUn4Vu0Azd1rzhrYiw/Pkn0tWKmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(336012)(47076005)(426003)(316002)(70586007)(16526019)(8676002)(26005)(1076003)(2616005)(186003)(36756003)(70206006)(6916009)(54906003)(44832011)(7696005)(6666004)(81166007)(4326008)(86362001)(8936002)(508600001)(2906002)(356005)(40460700003)(5660300002)(82310400005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:05:16.4490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c88bfc-2186-4a64-3c6b-08da3da79338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3724
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPM policy is applied to more chipsets than just mobile designs.
Update the module parameter to drop the word "mobile" to make this
clearer to users.

Also, document this renamed parameter in the admin-guide for users
as it was missing previously.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 drivers/ata/ahci.c                              | 10 +++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9336d98fc670..9e6bd212004d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -268,6 +268,17 @@
 			try_unsupported: try to drive unsupported chipsets
 				(may crash computer or cause data corruption)
 
+	ahci.lpm_policy= [AHCI]
+			The Default SATA Link Power Management (LPM) policy to use
+			for chipsets / "South Bridges" supporting low-power modes.
+
+			The value set has the following meanings:
+			0 => Keep firmware settings
+			1 => Maximum performance
+			2 => Medium power
+			3 => Medium power with Device Initiated PM enabled
+			4 => Minimum power
+
 	ALSA		[HW,ALSA]
 			See Documentation/sound/alsa-configuration.rst
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c39cdf6a44f1..1e2febea2f28 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -640,9 +640,9 @@ static int marvell_enable = 1;
 module_param(marvell_enable, int, 0644);
 MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");
 
-static int mobile_lpm_policy = -1;
-module_param(mobile_lpm_policy, int, 0644);
-MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
+static int lpm_policy = -1;
+module_param(lpm_policy, int, 0644);
+MODULE_PARM_DESC(lpm_policy, "Default LPM policy");
 
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
@@ -1591,8 +1591,8 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
 
 	/* user modified policy via module param */
-	if (mobile_lpm_policy != -1) {
-		policy = mobile_lpm_policy;
+	if (lpm_policy != -1) {
+		policy = lpm_policy;
 		goto update_policy;
 	}
 
-- 
2.34.1

