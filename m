Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44FF4C4C22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbiBYR25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiBYR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:28:41 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00503C73F;
        Fri, 25 Feb 2022 09:28:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFL1WKz2otNOnxDiFC3dtMkOJNWh9hZZGHZLHo0D4Z4gR+rTMV+0DQui1L3xlsyIVO0uCNp7+FpZsjSMjSeYECs+0ammc5W6uHFybS0QxaaaN7/d9Apzhhh2Y2u5HlE15cvtQNOZxF0k5kBYRA75Fycd4JubHI23zWfN5nmaKiv75HqmW2OhVVdUUS9QzDMW4mvrP/mifCbjXdAnIeVcOHzrzhIluU2AP8Sb4auc46q6Sv/jgqS0mVV2Y2h12z9K9hwOaO+4cSAL7oDvwS+Mx/CINqCPnmcMBItbejhksdVSFM5QVmumj4PtI5CrNavLKhpw4Bz3FttuiWPCwBWVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr/1XPFLbMW4ojzLqwNhUkn8i9Hz0OhA8OYCXVJaLto=;
 b=axFGL3781wIQZPtZ9qTl0lnEJhf1WHhc4xKvdr/PZeWCT3cm03htKCb7CfBkYmv7elGz0WQwvUeMC3xzKUsgaQda5pXXqaO3cLRpQBQFB+WM/RtxNoid77E1SJb5HV5z9OtM5LW8rawp7HDT9XH8I4oSiJtvHUWjpdwEojeoFfJhxLesRG4x21vTFisEdZPvMw7YsSKGZ99pFSte0uasZV0Mfc+O5whLSGhaaXWXKQHHNw/hasx2VF+YxTm5t5ZkJHe+2p4/jcq0Y1K1Jh6LVR7H0yu3a7QySanJVe3WOUrbigBNWpk0uwL3UgirLelLQIZEE3OdSqVmQqNOYeZMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr/1XPFLbMW4ojzLqwNhUkn8i9Hz0OhA8OYCXVJaLto=;
 b=ROQKug3tWccu6ztojyuL8Ak6O81bmYk8PiHohzDK2GzNsmBIWg2FZHOsqYXxE3oCYYX4Gfj6VdTlZulCQHq4nNN2I+XmDTpS4J7t86D7VR6JoJpBzhJ6DrhJx0KMwufwi6OvknqW0LKUj+oKJOqFaJVq+mXkvYsy6BcpNdnTp1o=
Received: from DM5PR18CA0074.namprd18.prod.outlook.com (2603:10b6:3:3::12) by
 DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Fri, 25 Feb 2022 17:28:03 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::38) by DM5PR18CA0074.outlook.office365.com
 (2603:10b6:3:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Fri, 25 Feb 2022 17:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 17:28:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 11:28:00 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <pmenzel@molgen.mpg.de>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item
Date:   Fri, 25 Feb 2022 11:23:19 -0600
Message-ID: <20220225172319.846891-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172319.846891-1-mario.limonciello@amd.com>
References: <20220225172319.846891-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe12e517-23e3-4eb3-4556-08d9f8842d32
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3836D36AB8B5DB064536D28AE23E9@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUk35o5yUQ0QEaVbaggVtISFvZVoA6L6bFN30GEWH10nC6GCwcTVm5TFYqrxaoSC3Qfif0y7kd6Gix1qi2SUbUkJmHmU6/+D7glisMu65X6VpiQSC/Z3bMpqVIlm6iRcXpkv7HnyLIJs6uEdp0IPBRD/87SfXKqkq4M9X+z14BZzMs+WTKcAZulYQf11WxxqRKTCUwQt7/dBQiyyffyzZmGnMc4bp8sZdBVlFOGkrmOgSMMqodlkzHNPbtBWl0imYZTe2UEkNd4ztLyAhYATEfZBvQGYL+ugmSodr0DuMI7oTkckV+YJUrZU0X97stS3sMFwvim7diRQ9e7PL0PA8naoV/9fMJmFLjMkzS+sUtcnr2AvEY8foa5j2+BOEArglgKMUH4zRxUktlOvHlaoLQSGecCR/CifD9a/ckFHyltg5DAIjuNnodFGQGe4FV6MkIIOSRVlRXhSS9Gd1c5BskcnPoR3q2etJywvRTu7zS+tFsiufZt3QkY/+7dUAFOHr5OizvBvsb+UXYZs04OpLKWTEk2aJ/Foiyn/gMCUd45o5YA5WVR7u5oPrduorZX3qHW/s9Z6lF6zCQcPw0hZ0/zSSxN6GQxArZ78REFcI4vayHvDGGIddkIttIghI+NP25/slE9FruGGfq1B0EKCzOAmHjndgtl3784NfsfE60108T75EVnNsk88X/oqLFaW9EDxQ4KRjmhbbU5vwcwMXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(8676002)(16526019)(4326008)(36860700001)(36756003)(356005)(83380400001)(2906002)(44832011)(426003)(336012)(47076005)(40460700003)(6666004)(8936002)(54906003)(70206006)(6916009)(81166007)(26005)(70586007)(508600001)(1076003)(2616005)(82310400004)(316002)(86362001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 17:28:02.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe12e517-23e3-4eb3-4556-08d9f8842d32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * Add tags
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
index 3a6db73d28d0..ffaad9eaa79d 100644
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

