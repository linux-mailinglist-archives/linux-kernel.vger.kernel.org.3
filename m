Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3684E4C4D64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiBYSN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiBYSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:13:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D996A1903E9;
        Fri, 25 Feb 2022 10:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNIeBFlj6GHh/PCwDkOizICs+LMnj/yQf5SjddIqnVHrFyY2lZoXUkjZEOnJCA59Oo+wZRvsp05/CUPMExnQzVkfPB4xryMz/9C0vFGEejClmKSS8/WWd4nXPjuMOGvFsN5/eJ9Yw2tMHyjVXnSnuVCzfZrNGBxciW/bXktTMS9LFDa279vOpNEWxr16HUCxCc3hcqIPrI4tE+gvVyIDi6zsRcDa8y22sluRdbEwsnIyIUvsEPH6ObP7K+PxOL15cXMzf6UMp+4k21upKMpkMrZsT9il4ugw9pjEALOMmATqTT1/9ShHW/I490gztR5lrJ2/JUY9V6ofxP8tn0zpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RofeznYPEhQG6TF+n4sm0ulLEoC+jGbHzJ8ATzHZes=;
 b=Fdvg2BNypUGVWXSeGvsBvhZ4pXYeO6Cq83Oqi7da8P2cz8fXbZOTc7H2SeQEGWqX9BtLWDrv+7W+XbiJ1+0aevzECcQpFuFCDAtifNeGKG++0uXPAaUe44AIOQLTK2DF1OA9jS6ty6oeSxnf1Gy2i6uRddgJaudiZT8KaYa28po84Q7jtabbOxZ6F4e05sUJ1JV/sEytOoWYNwoGzBnnLU+VyMtNRUnn3uUA88ZCFuOFsJRK7Sh1sMZthQ4QeFSvUmAF7GGdnaU/XzpH06FI/71FRpqpvAOE1GnB2vaXWfr5Wjw3eKe0xCf44/p23KbZPGa4Vebd98rFJK1CuGmIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RofeznYPEhQG6TF+n4sm0ulLEoC+jGbHzJ8ATzHZes=;
 b=NTmskX4oZxK1p431ooUMCRiN5rb9MhKGYRgKQytBaa1wLWf25PGhc3tpPiWziAcNSIOwpY4k0LD5ZebIN7biE49CH05qZVzJanrZdHiObHZUPDJxAf2sfwDYwIOLcWofHTailOlqvvZrMR2psU6FrnhDnLhUYpmuAub3pfCkMRA=
Received: from CO2PR04CA0076.namprd04.prod.outlook.com (2603:10b6:102:1::44)
 by PH0PR12MB5452.namprd12.prod.outlook.com (2603:10b6:510:d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 18:12:47 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::83) by CO2PR04CA0076.outlook.office365.com
 (2603:10b6:102:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 18:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:12:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:12:44 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 2/2] ata: ahci: Protect users from setting policies their drives don't support
Date:   Fri, 25 Feb 2022 12:10:30 -0600
Message-ID: <20220225181030.980223-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225181030.980223-1-mario.limonciello@amd.com>
References: <20220225181030.980223-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e1e14c9-b612-46bd-e4fc-08d9f88a6d3e
X-MS-TrafficTypeDiagnostic: PH0PR12MB5452:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54529059F545E96C5A3E1155E23E9@PH0PR12MB5452.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMLBtrE6WQNy2UwtPeWMX5RMSh1QIeA7UvkTkUnlvpRTscbcZprY7e1GL4egV6tPsMWAtIfKtrTNa+dLiQ7cWXx42MuAcoreoifZs4z5ze9TftEynZ4t2nlVQtU9c11o5GYVaZQ4crJg5EKagQxzgmYJAF8xF3L2V1EeyHUWyrJZpfDmKsaUyvE4k4i9KziMBDlKBF5xYcEE9ljlV43+pfou8JYQqJ9A9KMyj2dhhcF13GQ6rw5Ob8TyiuTzUvnm0j0Zk868I9zJE2v6LDXBMMm34XDDaQQrpe6gpdjcp7JnZLczX6JxNfMi7gSaNRVT2smH55l5pmH1grQKdmEZ2IFdQX5CC05/BUx/eVRQM5gHjjuQ5Gjfa9XMp2UHSKpWt5g5MHoZp6pNZq5tvApkqG2Jjz4qV6thoQ724leK8uP8gkr55xgJBXOZbhORwaVkpwfsjhlNgSFX9H+t7Y65Y6gtQ5JqKlhpeXhFlaeiQWPOLsdDx6xlOwkakyd0W3GeAKu7nWl4nEbIpNW5H7R9jDsfOP/X4kHFU+CfXv3SABvxMBwG5T5W+ezTx5UHdJNXjI+8eLjdLMpF77DIiJFXMNJH7/7mrUAWBAFm7xQRSyrXUIPiqpRTCChsj2L2EzesgaNaspvoWvnr/+/sLLsO+OUfRK2oTRq9PZM0jTCWKUK6HkkZraQCtNwzuLFch3r/n2onjIGG4s5fqUaMrKSIaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(2616005)(186003)(26005)(2906002)(6666004)(6916009)(426003)(336012)(47076005)(1076003)(16526019)(82310400004)(54906003)(83380400001)(36860700001)(4326008)(5660300002)(81166007)(356005)(44832011)(36756003)(8936002)(40460700003)(8676002)(86362001)(70206006)(70586007)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:12:46.9774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1e14c9-b612-46bd-e4fc-08d9f88a6d3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the default low power policy applies to more chipsets and drives, it's
important to make sure that drives actually support the policy that a user
selected in their kernel configuration.

If the drive doesn't support slumber, don't let the default policy for the
ATA port be `min_power` or `min_power_with_partial`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/ahci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 17d757ad7111..af8999453084 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1584,8 +1584,16 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 					   struct ahci_host_priv *hpriv)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int policy = CONFIG_SATA_LPM_POLICY;
 
+	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
+	   !(hpriv->cap & HOST_CAP_SSC)) {
+		dev_warn(&pdev->dev,
+			 "This drive doesn't support slumber; ignoring default SATA policy\n");
+		return;
+	}
+
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
 		policy = mobile_lpm_policy;
-- 
2.34.1

