Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486434C3E44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbiBYGOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiBYGOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:14:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480791B0C71;
        Thu, 24 Feb 2022 22:13:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuQratuyeFPD4zfSqcZo+WNlaqEDzbhinHCDfjWVsFNwx5ep9xaoZ8ejz4PMw0sA9kdD52e7NjFm1gp/yS/qfZHcFgDoDWWBQnN0WFNKzZDgmjcb5dXMn7Y0NXoAZgSIaRfvaaZT59XLOMX1JbugFlT3TiklTHtHE1x1aAPGIye4XtznrjvgouB2uujSilzLJLwowFoX0l1x2h0HP90k1X99cKpa1P8fJSJnAC2QHerfFq2AtWaiQ40boCtUjLQ6F0ix7f9bzWtH+1g6bOjtUmSNKAaI6Ul6QP/F4X/LyKv0CO9ZOY4qVz2FLi1uWH7MHqXhwf0peQIvHNYdfWr3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvP3CjL7lqo/BX54j/PHvvrFgkBpF/b5BqnDvn6sO2I=;
 b=bBGDFUcepGAUSNU+uDB54gQ5Ayb3N+obXmw/sv0CgjlzwW9SLUE2bG9OBCA86QtX726J3IQb0YI0gxaXVRfXnyTZ+jO0mxHfJYYTHi1LFg4pOZUVJ9RmU6IZ0LY2ZZEm66r61zWsyVMgWyLBjoaH33n3UIeNjmu0YkPCx5Si7VXcjWU5oCmvPys5bMMBUBkpDkFOzDDp9hpvT7Kk4QF8dG6bTBVhHBTaHI+biMSttPlq+GF8c8uS6tMlrWxbKnu+E9uP6Ko7SLMRtbRP+D+4se2rStJkkr4yKNLmNywVT3heIMUpkNAtOlxOCHXjIhKkcIv1D1mFLffgeohYaAhq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvP3CjL7lqo/BX54j/PHvvrFgkBpF/b5BqnDvn6sO2I=;
 b=bHgcOEyoxxNtSmqgZhhlrWewNxwM4rmpFN5K8t0u5UpqhfUnF9r58BgctIBn4L8w5iV5BCiyd14i57p5C5hmsLipzu9GT1Uox0ZdzPiyjBCeJ2SKM6F5RZWb6myS6j4qaAv5k+jVJPJsFSqu4Z8j9TUjbPmNGrklFBStzR+fhd8=
Received: from BN9PR03CA0282.namprd03.prod.outlook.com (2603:10b6:408:f5::17)
 by MN2PR12MB3631.namprd12.prod.outlook.com (2603:10b6:208:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 06:13:49 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::ac) by BN9PR03CA0282.outlook.office365.com
 (2603:10b6:408:f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 06:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 06:13:49 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 00:13:46 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <pmenzel@molgen.mpg.de>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item
Date:   Fri, 25 Feb 2022 00:11:13 -0600
Message-ID: <20220225061113.223920-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225061113.223920-1-mario.limonciello@amd.com>
References: <20220225061113.223920-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da658ff-0392-41d7-38c0-08d9f825fd06
X-MS-TrafficTypeDiagnostic: MN2PR12MB3631:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36317B3EBB974342A9F08BC4E23E9@MN2PR12MB3631.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4PbPTYmRzPM8ZVv4Tb3qsZ4uJG/Yz3qJ9cumk/z1IS1JBklZXOko99zD+mxyaPvVIzbcZKxieK7shz8ZfUgJJmyMIl6qU4NFIW9jQD7Bdo/wYarducXg5P5hGxbc+piHCR8UGMdv7KObrcxXyuopDqIohu3Y2h0hPbxzMUusjd7Yi8QfBoZ2eWPbDH/FfFrlj1V9bl7to+X/6TgwzkiB+LF8o0P/Z3ikwBwJjXoec5MU+KNrmkITpgGbj3hBezwZkU1zqaEX2QqYaEjwDJbPG8sWzmdmbLjBqx3nlhbGLulZp/iCjOF/HBzoYVit6UOBATvyH/fnuM/IFKnCoLydYrtaGfc5Je9B05YH4vAyFAdYRnCChLrZ66cSIwcNE7vGS1PgFMKASk8sdVE9CvNaWbd+xF53ASO9G7ao9QVD5CTBFqboPMeBSUBCsejakNIyesIXg1nbP8IelxFMFUcvtDxMUth4eJrztlm7OmNSFkAKO+8O+ASrRg0ySRmGQh20Oysvyasx/JU/69LtCGE1fYHnJGDy5Oqs1sxuWXewvkvBhYp+w/ryS3BNa3k262ho28IA4fwCiHFabcRVSTwlbVP7QVJrMQZsQUfLnOA1bAHsgt7/Qjf3RF9ujcjnY2/kwQc9kAav/B83c6h3qdwjLd0KtB1oyqgPowssrD42KZbfcQ/47CqAeOrLd5XnR0hum8FCQwWVlQ3yxzJIPKYFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(8676002)(70586007)(81166007)(4326008)(356005)(5660300002)(316002)(54906003)(6916009)(508600001)(2906002)(86362001)(40460700003)(82310400004)(44832011)(83380400001)(36756003)(2616005)(16526019)(186003)(26005)(336012)(1076003)(47076005)(6666004)(36860700001)(8936002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 06:13:49.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da658ff-0392-41d7-38c0-08d9f825fd06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`CONFIG_SATA_LPM_MOBILE_POLICY` reflects a configuration to apply only to
mobile chipsets.  As some desktop boards may want to use this policy by
default as well, rename the configuration item to `SATA_LPM_POLICY`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v1->v2:
 * Reword documentation in Kconfig
 * Change configuration item to match earlier patches

 drivers/ata/Kconfig | 6 +++---
 drivers/ata/ahci.c  | 2 +-
 drivers/ata/ahci.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cb54631fd950..cb9e71b4ca4d 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -115,14 +115,14 @@ config SATA_AHCI
 
 	  If unsure, say N.
 
-config SATA_MOBILE_LPM_POLICY
-	int "Default SATA Link Power Management policy for mobile chipsets"
+config SATA_LPM_POLICY
+	int "Default SATA Link Power Management policy for low power chipsets"
 	range 0 4
 	default 0
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
-	  for mobile / laptop variants of chipsets / "South Bridges".
+	  for chipsets / "South Bridges" designated as supporting low power.
 
 	  The value set has the following meanings:
 		0 => Keep firmware settings
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a77e8154b5f0..b84ba95be84a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1592,7 +1592,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 					   struct ahci_host_priv *hpriv)
 {
-	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
+	int policy = CONFIG_SATA_LPM_POLICY;
 
 
 	/* Ignore processing for chipsets that don't use policy */
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1ad48e2fe573..5badbaca05a0 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -236,7 +236,7 @@ enum {
 	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
 							only registers */
 	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
-							SATA_MOBILE_LPM_POLICY
+							SATA_LPM_POLICY
 							as default lpm_policy */
 	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
 							suspend/resume */
-- 
2.34.1

