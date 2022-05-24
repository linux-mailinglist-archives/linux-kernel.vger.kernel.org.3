Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA1532F60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbiEXRFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbiEXRFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:05:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE2F78925;
        Tue, 24 May 2022 10:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTjY+E5+kOVk8OAy9x5jzdokwkzIeZgiYpPfRbTRlwp9S/cUHFzHr8IqrVaFD+zUiIaa4aXHeOXTP9m1W5PPfq5okvU8SkQ7GZZk8Mtt32uiDUMvFoUqXrmvB05/8U+EVZpCR52cM19AsZ/MSd+GT/8An/jZ9HCwITbJoBSDOlHLsA64CVYJK5EpJFTuCr/6lG5AP9F2XwVKZwhu0kmbSBoImbWbPIcnGHJnBZP28/oN2gZnQkljJ/Eh6fNBfrlkqi3Vh68bOQqvnplcoJwSVTu2CcKoa2akVsEg+Z5fQQy6nqrWZDm/k1XDWINy9lpSjOkdCwUD0aXy2wDEtakBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdMwF9BMgH9dUhvnz1mq2RLS9YiY9jla8hyfsGxkExs=;
 b=dmea4t60fwIz5lWkkyprhmsyYRxQl8hdbXGAlqllz0n6XZZCX7+tvKPr6og2uLFuij/fKKNexuK+43WVqDgkXYOrP324tq02hbDMuv2XRHqnUQt08LytKyvT0Y5jCoGfg/0NM0nUCg0+sZ4f38wrkf9O4zCuxlSjIpw6KkmrmFb1HscvvkS45L5WoEqeOm5lDimKL1Rwy/fxCLz7jrDytK7iXGGdf9c6XzYYd/HzQnPNyspvb2GuuHv1UigFVtsTJ9Goi8UvWOktrzWQqrPApzOnxYvyHDcICLl/iR4wC3RqUBelxDrcxiiO2I7vABet0Colp6duj6VWJjjy5V/GhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdMwF9BMgH9dUhvnz1mq2RLS9YiY9jla8hyfsGxkExs=;
 b=jveb2xJqz9tT7gRmLbRTiaAo0FQpwmRZOKQFkkYT1cT1cJbhkyfVlQule15HR/INctF9fDv8PSji3jMyMeO+y57VNW/vnmJxq96FnG0fU3JpB+/j1Ec0PRMhi3nrgzUYNPL/kZnNrWL6vNcLwiz0lm81ohWZi2kGKy7wrEKID4w=
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by MWHPR1201MB0189.namprd12.prod.outlook.com (2603:10b6:301:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 17:05:14 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::62) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 17:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:05:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 12:05:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] ata: ahci: Drop low power policy board type
Date:   Tue, 24 May 2022 12:05:06 -0500
Message-ID: <20220524170508.563-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3916cf90-8942-486f-3956-08da3da7922d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0189:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB018904CB324699C893CED65EE2D79@MWHPR1201MB0189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxOqXHd7yYl1qjY8G+oZjOXWtpKWYdu6FDVpIhqmr75NWYDjFxC9Y7Gl8DgnQWDLRxtVzmwdJcjvjBhLOh2DQbiNvUm3Eikc3FYkbpj+yunR6Qn4KSuMs6sbPl6vT6nf2MK9TMy0HBK81A0oYVToNxQsiIeGL2NFPxa/hSLCg9LojObgjnannf73uHGrQr/6q0sbXxodxARGMJWbvnS0OHeuqrhQvtkPJzSflzk6buCOXktaRIm4J1t09GvikWjwg3cyWFR5dr5VNtHz/kFvKYR4RbB/GhqNm45eSO7BDuYAgYrVZf+WOnGZvBEUgIJDTNJhFAH8ruCF//tbE0dgCd7CJoDwV8lRfOlOIvde150dfBjzUzqsulUB/S++poWi/yzv3FXFgmpAJDOUxxYQu2rf0zqLYaN8OmnxRy3rDwsPf57kmTQUTThGeEiiaZoT/MO97iVE942vARhrulPfel8a5AY4D/uSQ+sm9GrOKPX67IxBJov0WfJQiKavNrbRlMCUuo2UQ0kyZ8YxjWPTua/q5fWz3WKeDuBHgui/Igr1uSW/7+OGNNMJZkPqRA+ovHoWNE0xaJLBYnK5WgWb4otw6vEFBvwIMolmdg8rcqIWbl9cn6t7P7TOMiHpLN7rgKTahiEMUYlTtOMAxS+xcMZmsBdXmPaMJRtV2cVsQHVGfCmv4q4XoPNGp2guTg1buZjVCH7sQgm/oril56D49w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(81166007)(356005)(4326008)(70206006)(8676002)(70586007)(316002)(86362001)(336012)(26005)(54906003)(6666004)(1076003)(44832011)(82310400005)(36756003)(426003)(83380400001)(47076005)(2906002)(8936002)(2616005)(36860700001)(5660300002)(30864003)(16526019)(6916009)(7696005)(40460700003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:05:14.6991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3916cf90-8942-486f-3956-08da3da7922d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The low power policy board type was introduced to allow systems
to get into deep states reliably.  Before it was introduced `min_power`
was causing problems for a number of drives.  New power policies
`min_power_with_partial` and `med_power_with_dipm` have been introduced
which provide a more stable baseline for systems.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/Kconfig |   5 +--
 drivers/ata/ahci.c  | 105 +++++++++++++++++++-------------------------
 drivers/ata/ahci.h  |   7 +--
 3 files changed, 50 insertions(+), 67 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index bb45a9c00514..8ad73a30f405 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -116,15 +116,14 @@ config SATA_AHCI
 	  If unsure, say N.
 
 config SATA_MOBILE_LPM_POLICY
-	int "Default SATA Link Power Management policy for low power chipsets"
+	int "Default SATA Link Power Management policy"
 	range 0 4
 	default 0
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
 	  for chipsets / "South Bridges" supporting low-power modes. Such
-	  chipsets are typically found on most laptops but desktops and
-	  servers now also widely use chipsets supporting low power modes.
+	  chipsets are ubiquitous across laptops, desktops and servers.
 
 	  The value set has the following meanings:
 		0 => Keep firmware settings
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c1eca72b4575..c39cdf6a44f1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -50,7 +50,6 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_ign_iferr,
-	board_ahci_low_power,
 	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
@@ -135,13 +134,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_low_power] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_USE_LPM_POLICY),
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	},
 	[board_ahci_no_debounce_delay] = {
 		.flags		= AHCI_FLAG_COMMON,
 		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
@@ -275,13 +267,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_low_power }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_low_power }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_low_power }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_low_power }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
@@ -291,9 +283,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_low_power }, /* PCH M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_low_power }, /* PCH M RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH M RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
@@ -316,9 +308,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_low_power }, /* CPT M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_low_power }, /* CPT M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
@@ -326,29 +318,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1d06), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci }, /* Panther M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_low_power }, /* Panther M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_low_power }, /* Lynx M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci }, /* Lynx M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_low_power }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_low_power }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_low_power }, /* Lynx M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_low_power }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_low_power }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_low_power }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_low_power }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_low_power }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_low_power }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_low_power }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_low_power }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_low_power }, /* Cannon Lake PCH-LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci }, /* Cannon Lake PCH-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
@@ -382,26 +374,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_low_power }, /* Wildcat LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_low_power }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_low_power }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_low_power }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci }, /* Wildcat LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci }, /* Wildcat LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_low_power }, /* 9 Series M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci }, /* 9 Series M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_low_power }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_low_power }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_low_power }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_low_power }, /* Sunrise LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_low_power }, /* Sunrise LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_low_power }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci }, /* Sunrise LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci }, /* Sunrise LP RAID */
 	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_low_power }, /* Sunrise M AHCI */
+	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci }, /* Sunrise M AHCI */
 	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_low_power }, /* Sunrise M RAID */
+	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
@@ -414,13 +406,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
-	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_low_power }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_low_power }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_low_power }, /* Cherry Tr. AHCI */
-	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_low_power }, /* ApolloLake AHCI */
-	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Tr. AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* ApolloLake AHCI */
+	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci }, /* Ice Lake LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci }, /* Comet Lake PCH-U AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci }, /* Comet Lake PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -448,7 +440,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
@@ -1598,11 +1590,6 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 {
 	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
 
-
-	/* Ignore processing for chipsets that don't use policy */
-	if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
-		return;
-
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
 		policy = mobile_lpm_policy;
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index ad11a4c52fbe..a085228ce4ff 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -235,12 +235,9 @@ enum {
 	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
 	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
 							only registers */
-	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
-							SATA_MOBILE_LPM_POLICY
-							as default lpm_policy */
-	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
+	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 25), /* handle PHYs during
 							suspend/resume */
-	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
+	AHCI_HFLAG_NO_SXS		= (1 << 26), /* SXS not supported */
 
 	/* ap->flags bits */
 
-- 
2.34.1

