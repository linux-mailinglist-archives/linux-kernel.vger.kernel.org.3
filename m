Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF994C7C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiB1VgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiB1VgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:36:00 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D213CEEC;
        Mon, 28 Feb 2022 13:35:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob92y6zAD3I9Nz5MYN9x3nne4KONKmEu0n2ztiG84iyTzwLrks7RmQKRRi3Po6DtKfJZzdsNxAbXdrigTlcMVGEQ7BB2mSSkc9nSOnc4dQtv+bLYBm7zUMTHP0I2wZkvvWiNBCtBynxzkUOocu7eU3v+9ZXXrM+LV3CJ4+YrqoEGsu4zo3iEM1+vX39UQ8n4QvcNb9PCn6O+TX0cJyKP5xEaFZRF7MRDxtdKpIaaoFcXUWZugDUqt2C9+Vousj0WkbCbJrgLc5pP6aWI70Ex7yW0jKhsQZC8zQ8EYXWC2Bm+xzkwCnM8peQIWJ3RJT2JxOCLgBWUhjWCO3msi9yhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHhkSn5adVcO5rm9uEbdAoQgB5bgi+mEQYYRkSvnkdc=;
 b=PxM6BzTHKY+/XKQiCUqO++3/pMRVImzwpAtZ49lY5YvKfJ01+zRwJwqRsIg/0I6dfaQp1figRyQjSMnWI2s2aBm54qb3QFWkW5SIf2kal7P87cKdglRSyrSkGiUHEU0i5dSh3S98wqvWDlH6h/HjCRSInUhirNChHBKi2X5FsJyWrqRY/FdSsZWXjI2AgGkHJ5abeE3PqcXfKa3Shmdh28aT4O+/BkRo/e+Ol7eeipp3uN1Qb088qMK93mZ07e2H/5W//OVX/MExdrzAZqQmv+gXC9Sh6HkRq+raKOomr1aNDmAgRLK6I62kQoTeofPMJA96XNqOSxO1sTISmKDJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHhkSn5adVcO5rm9uEbdAoQgB5bgi+mEQYYRkSvnkdc=;
 b=tBq7EbNSgz0xEeiY2hppPm6mUSsEhnZHkW+xCyY+JZunOgDERP7XeCujPVy7td1jg0qRvHuVP7XYGoKvb2VJwYow0LFGwPsHVUTcJwPZkp9dfvZsNP3HSpC1rFWEjESj4ZvvIjH/PdukNbwjjmSxOd6hCJyjouL4MgKHeAA7r68=
Received: from BN6PR12CA0047.namprd12.prod.outlook.com (2603:10b6:405:70::33)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 21:35:17 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::71) by BN6PR12CA0047.outlook.office365.com
 (2603:10b6:405:70::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Mon, 28 Feb 2022 21:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 21:35:17 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 15:35:16 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/2] ata: ahci: Drop low power policy board type
Date:   Mon, 28 Feb 2022 15:33:01 -0600
Message-ID: <20220228213302.2915071-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7c78fa0-ad99-4920-1b4a-08d9fb023670
X-MS-TrafficTypeDiagnostic: BL1PR12MB5077:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB507773A5FAC20512010FE9B1E2019@BL1PR12MB5077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3L5lYsO75lW12t+HdhbxH3wIKsYKRIn3/XkXOEChGXPRNlwUTKRnyHMt/4oOH3D4DPxf9o0zygCgLF2e6JN1To3AMP6w0aRc7cRYWJAOw/IuCXv2e47/v6HFKb9etMqCywsy7pBQ/okg2ODGA6JBfpmielicV8JQqee1/geZN0+cXUsA08sNyLdVyh03miRl3iA5M+oi+J0ZghVGuiwwYvsc0d+dUhlKFqWsQawsOE/F1kqBzcvpcouFsJXfuG349g1g/dDZQFnM16VYaOnGdLdpbauCZ4Sjn2jNEIRPWrGfknlQ4v0WHrwewR6Zr41emQVWfySqJHN7+8lOQJkOs4DPoY4D7+aZpg5L4X0fAY5YDHsXgAa6oE7EMTFqVHWqVg0Ba4p7ecp8kzhuy9vIq2ztXXOrttzH2S/+Ze7tiCnwk2Pnp53oXXd49j9z3f29mnIudZCUVe7Rciob4gcAZZAOuePCJ5/RQl8SsFELgcrtftmPOyp1FviL4iHR/1U6R0wS/hgHQ2FiDGlkXITqDlJbj78+SnQ1f39IJzZvwtYfy/4Pa/8yskxZvQEu6d2q2re20O6EvBQSErqoMxHPt6tH9yclv4L7lCf3k+5tUzgtxceN7qpfokGO9SX5fJIxUZeboDQUnVWH1LSpF+KNmndbcRKYY4MqqNzuIXuCftME7JOnyJU0DMOPRtbLA5S20PGPu5soyjxlvUKkR2NYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(2616005)(70586007)(4326008)(30864003)(2906002)(47076005)(70206006)(8676002)(44832011)(186003)(16526019)(26005)(6666004)(426003)(336012)(83380400001)(82310400004)(6916009)(1076003)(356005)(81166007)(508600001)(316002)(86362001)(40460700003)(36860700001)(54906003)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 21:35:17.0833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c78fa0-ad99-4920-1b4a-08d9fb023670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
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

As discussed in the RFC, if this patch introduces regressions they need
to be examined closely to decide if reverting makes sense. Some things
that make sense to look at:

1. Check what modes are set by the disk
2. Check what policy is set by the user in kernel config (or module parameter)
3. Verify the firmware version of the system and check whether updating it helps
4. Check the firmware version of the disk and whether updating it helps

The outputs from these can be used for building a disallow list rather than
a flat revert of this commit.  If that list grows too large, it might make sense
to revert however.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from RFC v1-> PATCH v1:
 * Update commit message to talk about regression potential

 drivers/ata/Kconfig |   2 +-
 drivers/ata/ahci.c  | 105 +++++++++++++++++++-------------------------
 drivers/ata/ahci.h  |   9 ++--
 3 files changed, 50 insertions(+), 66 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cb9e71b4ca4d..3624d56d32b4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -116,7 +116,7 @@ config SATA_AHCI
 	  If unsure, say N.
 
 config SATA_LPM_POLICY
-	int "Default SATA Link Power Management policy for low power chipsets"
+	int "Default SATA Link Power Management policy"
 	range 0 4
 	default 0
 	depends on SATA_AHCI
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ffaad9eaa79d..17d757ad7111 100644
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
@@ -327,29 +319,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
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
@@ -381,26 +373,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
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
@@ -413,13 +405,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
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
@@ -447,7 +439,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
@@ -1594,11 +1586,6 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 {
 	int policy = CONFIG_SATA_LPM_POLICY;
 
-
-	/* Ignore processing for chipsets that don't use policy */
-	if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
-		return;
-
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
 		policy = mobile_lpm_policy;
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 5badbaca05a0..a2ca78e1df5c 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -235,14 +235,11 @@ enum {
 	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
 	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
 							only registers */
-	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
-							SATA_LPM_POLICY
-							as default lpm_policy */
-	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
+	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 25), /* handle PHYs during
 							suspend/resume */
-	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
+	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 26), /* ignore -EOPNOTSUPP
 							from phy_power_on() */
-	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
+	AHCI_HFLAG_NO_SXS		= (1 << 27), /* SXS not supported */
 
 	/* ap->flags bits */
 
-- 
2.34.1

