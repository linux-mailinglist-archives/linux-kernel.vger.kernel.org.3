Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2364B7E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbiBPDCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:02:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiBPDCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:02:00 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F54766602;
        Tue, 15 Feb 2022 19:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSg7NfZwegnRCD0349Kuo8IHpgfedNNBRy3l6w+rAhUTilc4/f/jWn28PDAEGFT5uJCLkBFZboFQwfnYFh08+87ATa4VCR33nkskki1JAqQNveLPDNhpPjnqBvnCOjg/KqfW3CouyA5QMvnbRcGus0WB0lu4hznHP4TH5zLBFQVL2wNmEa4q0UqpUKg5EVUtAYG+EC3rGuERTffwBGBK91Ci9Ho2iQOnuUm4of6g8EynPjTshvwNJMRG4v6p4skzUp1cPJZE4u3OtYiy/LWWYo7LUGc2vgoTVLMMaKMgAiQ+EwzwN6gFbp7AoC4U5l++F7dyUUDc4d29O90hb6BEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4bRLejKkx/PfVxpZcx0VTMRijhO4qBdgvhysnKTzdg=;
 b=UXJA4GFxC530fK1c7xJuVowMG2Smbpv2+yFkHCrOn+VPjcV5JiO32c7v7VGWaRs8blfiXbX9BVRJ4qQzl9f/YtFqo/BcA+xzBU98J0lrTUda38MYiwjIkpmA6AHpPedwDrRSs5Tny2spkHEyBzW9HU1sTmJGFLITOH04qEx9dZwzwndJ+aikHk4LYZuqFKqxxwDYXs1MhKtW3t0lr8l5GRnjP8zTK295cL4cVSabHR9MJelBXdNIrZfn9awKylfkhWXflyqQIcOTmK4jdUggG8ZytLfTU2GRqpK/MMYHQS8oI8L0zkljjxxXbznvyUr7/nZn9zjAiDG10Xn5Xt/VSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4bRLejKkx/PfVxpZcx0VTMRijhO4qBdgvhysnKTzdg=;
 b=yZsuC+lz/uKepwi213wzrWnrdy0LlI8gM0hH8NrtUPksghu/6LFLa7mN2zL3lbnHXN3jYM96ttLUFMEYIqqN6oaG4dNaApe+Pb9pWCyorsY65RV4JTrfED5Na9UMvspTDRpE2AqUl4znSOgibYAtNJCy3g2dlTcSUaXqITw0huk=
Received: from BN6PR16CA0031.namprd16.prod.outlook.com (2603:10b6:405:14::17)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 03:01:46 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::48) by BN6PR16CA0031.outlook.office365.com
 (2603:10b6:405:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Wed, 16 Feb 2022 03:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 03:01:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 21:01:45 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <pmenzel@molgen.mpg.de>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] ata: ahci: Rename board_ahci_mobile
Date:   Tue, 15 Feb 2022 20:59:32 -0600
Message-ID: <20220216025934.1892723-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ae461c4-2b1f-4b7e-8855-08d9f0f8ab4c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5121:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5121990C6C16FF934751BEEFE2359@CH0PR12MB5121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyNMmxOTd+kMp0Xfkk40bi7BBsI/UPe8nJ/QxnW8xnVvvswsMUojITL/JGnNbnmZMMlEeb1cj4RYRYWhVgdLeQgGMUbe3OEl9TYjO9woRS0f7XQhtB/vdTKhWPYSKaWB//8DaAaFJodfiJ0oiluhkF9BrdrcYa8+epd8FK7w64f+TJ5YFSfhFIQk5n/fBqY1IGtnPN2ASkK/qMooBqp8UGpPUMYncqzrkfA0kcNG4q0jMoh3wcjMIv0iZsshXBmmbTV1ipb3ZZ6Xk8U9jDcYKz8OUIWHjm9Iz2eaWyndS1uMHHBnOizx4S57khtpcjx10/OtOL+hA3w7PKzaS4Q8zHU0mBritp8jH557g/08uZl/kTIxx7Ru0mivXMiD69vfHU8P/tU2AlFr63Lx3wXaCC776bVpJDMVpf+NHbafj9yqyGAQLBCfX2xPEBped3U1hHoNXmgiV8UwKbRzquRZLLM97HsXG9onVYVaVZ2M9SlKbKwUs7Btofv35JORnNPKZd+FYv71JzC5P5NakSdXW9h4X6MgE06AcsJDv8eW4zMeji/3PyO5Hb+OtJ7hWYp/3xKUV09/tIozoU2R9nPZk/jh5kTHu+E2gjl8Q9gu3Q0DVrjxDQ/TlkxZmx5Q8JGO5W3yQPUbDBk7PvVQ3JpVH83k75qamdCeiiNUAA9y+DHxbyabKkz5U6pHtavFfFp2/wSL2cXhTnWAPcLZv4JbkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(40460700003)(6916009)(4326008)(47076005)(54906003)(70586007)(36860700001)(316002)(70206006)(81166007)(36756003)(82310400004)(2616005)(508600001)(8676002)(6666004)(26005)(2906002)(83380400001)(86362001)(1076003)(5660300002)(16526019)(44832011)(336012)(8936002)(30864003)(186003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 03:01:46.5798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae461c4-2b1f-4b7e-8855-08d9f0f8ab4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121
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
board to `board_ahci_default_lpm` to make it clear it is about default
policy.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/ahci.c | 96 +++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ab5811ef5a53..67f3b3b23639 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -49,8 +49,8 @@ enum {
 enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
+	board_ahci_default_lpm,
 	board_ahci_ign_iferr,
-	board_ahci_mobile,
 	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
@@ -135,7 +135,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_mobile] = {
+	[board_ahci_default_lpm] = {
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
+	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_default_lpm }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_default_lpm }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_default_lpm }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_default_lpm }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_default_lpm }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_mobile }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_default_lpm }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
@@ -291,9 +291,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_mobile }, /* PCH M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_default_lpm }, /* PCH M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_mobile }, /* PCH M RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_default_lpm }, /* PCH M RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
@@ -316,9 +316,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_mobile }, /* CPT M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_default_lpm }, /* CPT M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_mobile }, /* CPT M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_default_lpm }, /* CPT M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
@@ -327,29 +327,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_default_lpm }, /* Panther M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_mobile }, /* Panther M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_default_lpm }, /* Panther M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_mobile }, /* Lynx M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_default_lpm }, /* Lynx M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_default_lpm }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_default_lpm }, /* Lynx M RAID */
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
+	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_default_lpm }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_default_lpm }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_default_lpm }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_default_lpm }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_default_lpm }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_default_lpm }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_default_lpm }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_default_lpm }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_default_lpm }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_default_lpm }, /* Cannon Lake PCH-LP AHCI */
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
+	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_default_lpm }, /* Wildcat LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_default_lpm }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_default_lpm }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_default_lpm }, /* Wildcat LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_mobile }, /* 9 Series M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_default_lpm }, /* 9 Series M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_default_lpm }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_default_lpm }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_mobile }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_mobile }, /* Sunrise LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_mobile }, /* Sunrise LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_mobile }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_default_lpm }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_default_lpm }, /* Sunrise LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_default_lpm }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_default_lpm }, /* Sunrise LP RAID */
 	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_mobile }, /* Sunrise M AHCI */
+	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_default_lpm }, /* Sunrise M AHCI */
 	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
+	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_default_lpm }, /* Sunrise M RAID */
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
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_default_lpm }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_default_lpm }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_default_lpm }, /* Cherry Tr. AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_default_lpm }, /* ApolloLake AHCI */
+	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_default_lpm }, /* Ice Lake LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_default_lpm }, /* Comet Lake PCH-U AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_default_lpm }, /* Comet Lake PCH RAID */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -447,7 +447,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_default_lpm }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
-- 
2.34.1

