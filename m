Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6044F1EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379158AbiDDV6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380402AbiDDUEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:04:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6667330576;
        Mon,  4 Apr 2022 13:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn5IZdF9mFhPstULkP1giLbXTWHsi5iwscva1fqCcTotWTASsrvH5OHEk09m2GpeQJ4R+nCUPNuAC5trt0ECLnPHuQdd7sEu5zNBKxqpdr2w6kkkBHZw2bg1qWzK5d5IOu1I/iiNOeY1gNySEIg1FEt73gCUCM7IyJ9a2fZ4bybPPnNAlHrNBicrjgg+r2LI8cNW5sSxsoab3/M9/0snMuEL0lqM++uMparC4FOPs+OtQNRFb3Eqbpj+0vXflhRlnrt0v3lvUmC2EKHJxzV/kC2WtMEj8M/A+9jtneRTmKSRrkh8tT9b4JMul7flGNiJ5sPth0AK1uG/caWqz0b+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw15EVofQ2pU7gSVUi+dgh0y3/qqIBnNOBYN7wjY/4k=;
 b=kCI1nfcphZ+zC0Nz5x3cWTSiIIEdqNXKQhJ6NSRUco+9UwC2dPNMWhoga19uYr1Olhs1Z2d4Af8vZKTDQKmqPLXYduBegE4HAEhPGDcNMMMtg1nnxI7OteR0BRyOZUHpqJNoAnW2z1W/AKCiUDHVHaVB5VzuTbJn/dxFZW+u9BPBKAwKcyheZs8lNnkiY0JdDmXv1Iuo51r10+de/M4FdayvuWyYEIp1q6IQzgHrdqGpUxZbg7gTP0UsgnKFktsBKW1I4yx3CyI9U/GxZLQ02aSNEFm0kYBguG4oiicReTHJwtCg/BCb9SD6ztlHNS+IQu+G/+ctoA0PuJEN/gtqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw15EVofQ2pU7gSVUi+dgh0y3/qqIBnNOBYN7wjY/4k=;
 b=WZTEBZ5lUxdrispGHwmen4MWXWePeYIpei6oxx7s6My02Q62l9n5JIH+EHTG54opoK0GHl1OFRgiN7jUsLZOqHMGhr1skV5rGIrsK8RjJBCPIK2JgeUs4Ify3vpWVoeVWS66nn5J6nrf5oLislg+vlwdCvY/99RP4I6KwywsvL0=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:02:17 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::e4) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 20:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 20:02:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 15:02:15 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY configuration item back
Date:   Mon, 4 Apr 2022 15:02:02 -0500
Message-ID: <20220404200202.9388-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404200202.9388-1-mario.limonciello@amd.com>
References: <20220404200202.9388-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c1bdfac-7632-49f7-3237-08da167604e5
X-MS-TrafficTypeDiagnostic: BL0PR12MB4883:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4883AAB2D3A4C469C7906332E2E59@BL0PR12MB4883.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C45+Ui0zPCH0HgPbSrVJcQK1j6HUtG8YehFfsrujGb6umhtu8CN8ygWTkQOoesAF7rjdFJGqIHUPaokfpaF2s94ILBD50I8ZQGQ+8VWAGzd9GVCYr5JYCNJ8qPQ5yJFXXEPOZaeXhHO2PS1DZIdMXZT8nqmNWsIG/ErRMDwHMnBQH3BRlFmYTe9DCczNRaieoPF4LI4qatUst1TYgKgC/N2/9DWl3pAhuxQGfUYMqBXDjeA6iTdju7u/GRueiLpCp7a7V/3xX7a0EDqFS/pGDW9XR/3kTOLYLa+9p1Dq8cDRJbHtCu7gHGbRO9aTAlL2bGZYQj5ktOehbXEEctiDUsWVHGB453GFJ22X7oINJ1LlToJBmfx6hvRdu/ayfbTWcNnHrCvOsOEFzwHg7JPlXl71i7HM7tuHk7rYXDs1+YhHLAuPIgXJRZNW0lHm3dgFG3t1pTPx9xKgs25DyhYNMRY+JPxrcT1T/FcGH7LPpR7D4Kr3kvoFG3Gw0mECm90JlC1Sne3JZwf1Ktpgj63bUS3sEsI8GJINJC0tdla5xP3sJStCMOxfID6wqsGkft0DlgtgBvpkAs3kGZdmvFGmdAoIhYJhExkVd6er5cgtwEd0n4qkOi9mCqaqM3fQVb+WckWY93GeXcpjH9ZnYMrEi3aWnQ4ZQqmrEeQTUM1J/u/kvIPGcx2GCbP1mYcdZu9BVht5GNmJMGY1AvMd9EyMwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(2616005)(508600001)(86362001)(6666004)(2906002)(44832011)(7696005)(40460700003)(8936002)(356005)(81166007)(36860700001)(82310400004)(336012)(26005)(16526019)(186003)(1076003)(83380400001)(47076005)(316002)(426003)(4326008)(70586007)(36756003)(8676002)(6916009)(54906003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:02:16.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1bdfac-7632-49f7-3237-08da167604e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SATA_LPM_MOBILE_POLICY was renamed to CONFIG_SATA_LPM_POLICY in
commit 4dd4d3deb502 ("ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY
configuration item").

This caused some pain as users would invisibly lose configuration policy
defaults when they built the new kernel.  To help alleviate that, switch
back to the old name (even if it's wrong).

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * New patch
 drivers/ata/Kconfig | 6 ++++--
 drivers/ata/ahci.c  | 2 +-
 drivers/ata/ahci.h  | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 3ffe14057ed2..c3194b80c655 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -115,14 +115,16 @@ config SATA_AHCI
 
 	  If unsure, say N.
 
-config SATA_LPM_POLICY
+config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for low power chipsets"
 	range 0 4
 	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
-	  for chipsets / "South Bridges" designated as supporting low power.
+	  for chipsets / "South Bridges" supporting low-power modes. Such
+	  chipsets are typically found on most laptops but desktops and
+	  servers now also widely use chipsets with low power modes support.
 
 	  The value set has the following meanings:
 		0 => Keep firmware settings
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 84456c05e845..397dfd27c90d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1595,7 +1595,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 					   struct ahci_host_priv *hpriv)
 {
-	int policy = CONFIG_SATA_LPM_POLICY;
+	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
 
 
 	/* Ignore processing for chipsets that don't use policy */
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 6ead58c1b6e5..ad11a4c52fbe 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -236,7 +236,7 @@ enum {
 	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
 							only registers */
 	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
-							SATA_LPM_POLICY
+							SATA_MOBILE_LPM_POLICY
 							as default lpm_policy */
 	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
 							suspend/resume */
-- 
2.34.1

