Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA94C4C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbiBYR2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiBYR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:28:40 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78406398;
        Fri, 25 Feb 2022 09:28:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn3s97WR2z9RSf0QZ9+Hc6rtfa4/1cf4jj30pja5O/evEAxIBy/UAiBtdAuhvh2V40cKKJW+t1BOf/6UbT1nYFG0HlVyTddzKE+BNvq0ekU2lASXo83Efz9BMUZ7HdBV59FZHbBp1GRyEg9BJ43M7NDJ5XC1B49fKPYtHwyNZuoutSiDuNEQ75HkpNmp2a3TY2voq+fVuPJQHg+/+0g+ZjIryo6uVavLzaq91VVfOJUMfcwYNvQBHxwgBrhUkIdGprjXAMDR7bFMUkBnk9eAGH5B4Y9FD/j1A+rP41AyX7wFhjGORXYE6y0gNpXZJTOUfbDyJcg9meIsOKqNq0lnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVrh7TyekaZB38fRcwQl1oB2rWJwtm0fd5oxQta97xw=;
 b=PeXdW5RyqbpYqLCHhEuMopBur7Ek1D9xRcocZkdr8ZdDUKDTCVZX2oVfZdc0heLvHty7y/fnYL5KXRXSh1vQvQIXEkVcgV4SpXq7LT1cLWejobLanMSttSUB81Pf16WlJTrQ3kRwWNM5UklovfWSnWiTUjb5fNL7A9BbBttqW/bfqeq7ZjxlWn1lRPq0UMdpNH5xLnHiTbuGOaAxIus+fNudh22wjg/LLCIY4f8KwFB4taMlAYhnMpJea6Gs2utbGAsm+h1EFdDXW9gLGJONekQ+ha9fDRMtqg9E8Q3Sp0YokJOsAM/xtwz0vhA6v3ZPVI1UlTgHl7QAqtLbCgF0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVrh7TyekaZB38fRcwQl1oB2rWJwtm0fd5oxQta97xw=;
 b=YYaphVpzVtVT1iupF7sjanCAeYrf4/YXaAQVfI+g82uw2nEOYEtlpwElnb7+2u2Kjgnfx9AQUCnus5Zgg5ytrtSqGl6rM5aYKOhr4WJ3lCY/SzKPA5eW5hB1TsnBfUX/2eNjrX08tG5Ji5qbc+7TRQXkX/27w0werbXxHgteYlI=
Received: from DM5PR18CA0091.namprd18.prod.outlook.com (2603:10b6:3:3::29) by
 BY5PR12MB3969.namprd12.prod.outlook.com (2603:10b6:a03:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 17:28:01 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::e8) by DM5PR18CA0091.outlook.office365.com
 (2603:10b6:3:3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Fri, 25 Feb 2022 17:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 17:28:00 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 11:27:59 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <pmenzel@molgen.mpg.de>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/3] ata: ahci: Rename board_ahci_mobile
Date:   Fri, 25 Feb 2022 11:23:17 -0600
Message-ID: <20220225172319.846891-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 827375a1-b43a-41ce-a773-08d9f8842c0a
X-MS-TrafficTypeDiagnostic: BY5PR12MB3969:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3969DA63F117C9FF30D6CC51E23E9@BY5PR12MB3969.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUunby27Z/4t98qrs/P4v+p5D6qKbYaRvhgsZhSy0bXxSQfPSEYjE8vT1WPSrJyZGHJxoH4T6GjBkImnwNY9kbAb38sLgD9yOOWXBAx2F6k3VYDOr+s4es/hB5f3fxrF3xrPAkGY5SjfryiGnYH8tRcF3HxPYjQOgZIrEwRffGX3ar7fXYJpZOaFRsgfXdhOLIUG7+ghW/dO6GZHtmBJsgfW88fco9AvVO5Xxqc4KkIzrglAU0kyi8YQ5GFq3jMw4dFzhZ1IqsJ5BU0CsYdKh8j8E+f4R4+hJZZ5CnOuY6E6o7o7wX4ble/e+VwcA9Trj++vw+CO+Hk9/G7PExj3VboInYsynoQM/g7yVRPhwLdzZTyBAujx6W2t+P7dPr9YanGPmu9pmKRDywUMYJg+0OevFjS7g8v7iO8chACvCFokIIlhDN6DKlMcbPahL97KbJq/J3EZDAqZ3TdBBHsuoFfH4OwSNT/AArVv8cFxauIiLo6zgutjopniEMdlUCuBfvDtLMwObhx/P3GVu3dW3Z8/b0MEtOOfGofLXj+v0GweI8VdrN0cBmm3X6q99P7j26UOitl1nJ9inHc3DqzQCxySMmOgA878P/elHsqcdiNwnpEG0Tio71WFy8xR+2Pq2d0TAloyvSpAMlGWGK/NjEEBaaRhvbOabKlHowAV1a/H5H32+eHphur/VI8lrqpME1ZuRRdn99NOl7UsbMPwgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(36756003)(8936002)(356005)(5660300002)(81166007)(508600001)(86362001)(40460700003)(8676002)(70586007)(70206006)(47076005)(1076003)(6916009)(316002)(2616005)(336012)(426003)(186003)(26005)(2906002)(6666004)(36860700001)(83380400001)(4326008)(30864003)(16526019)(82310400004)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 17:28:00.6809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827375a1-b43a-41ce-a773-08d9f8842c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board definition was originally created for mobile devices to
designate default link power managmeent policy to influence runtime
power consumption.

As this is interesting for more than just mobile designs, rename the
board to `board_ahci_low_power` to make it clear it is about default
policy.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v2->v3
 * Add tags
 * Move new board ID name to correct location in the enum
 drivers/ata/ahci.c | 96 +++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ab5811ef5a53..8f38244eda23 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -50,7 +50,7 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_ign_iferr,
-	board_ahci_mobile,
+	board_ahci_low_power,
 	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
@@ -135,7 +135,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_mobile] = {
+	[board_ahci_low_power] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IS_MOBILE),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
@@ -275,13 +275,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_mobile }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_low_power }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_mobile }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_low_power }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
@@ -291,9 +291,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_mobile }, /* PCH M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_low_power }, /* PCH M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_mobile }, /* PCH M RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_low_power }, /* PCH M RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
@@ -316,9 +316,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_mobile }, /* CPT M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_low_power }, /* CPT M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_mobile }, /* CPT M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_low_power }, /* CPT M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
@@ -327,29 +327,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_mobile }, /* Panther M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_low_power }, /* Panther M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_mobile }, /* Lynx M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_low_power }, /* Lynx M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_low_power }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_low_power }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_mobile }, /* Lynx M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_mobile }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_mobile }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_mobile }, /* Cannon Lake PCH-LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_low_power }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_low_power }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_low_power }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_low_power }, /* Cannon Lake PCH-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
@@ -381,26 +381,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_mobile }, /* Wildcat LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_mobile }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_mobile }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_mobile }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_low_power }, /* Wildcat LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_low_power }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_low_power }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_low_power }, /* Wildcat LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_mobile }, /* 9 Series M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_low_power }, /* 9 Series M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_low_power }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_low_power }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_mobile }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_mobile }, /* Sunrise LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_mobile }, /* Sunrise LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_mobile }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_low_power }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_low_power }, /* Sunrise LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_low_power }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_low_power }, /* Sunrise LP RAID */
 	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_mobile }, /* Sunrise M AHCI */
+	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_low_power }, /* Sunrise M AHCI */
 	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
+	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_low_power }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
 	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
@@ -413,13 +413,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
-	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
-	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
-	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_mobile }, /* Comet Lake PCH-U AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_low_power }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_low_power }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_low_power }, /* Cherry Tr. AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_low_power }, /* ApolloLake AHCI */
+	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -447,7 +447,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
-- 
2.34.1

