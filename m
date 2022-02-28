Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5324C7C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiB1VgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiB1VgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:36:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63F13D937;
        Mon, 28 Feb 2022 13:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwV4y8QSzrNM/dQwDM0AwkbQciiUx3LVYY20Iiq9+T523wp9d/ofSPHA5EKMZ8QXgJkJgdr2Ia5Q8xqzqxkmyZ5vF7ziCALqJ/9chOnDACG3khlRkt0N5YuanhE1tjXWbdbEsQvEv4AgpUD3Rua5NzDNmFdYPstauYYNqKos9L3ghCCwe4Y8dOhLfWEAPyGAEbJ94Qs9XT2RYZ3TYx099W2daJ87qNG5a6FTpfcYnw8tpXfN8Md18udTza2sqsbx9d2ezYMJ1jYLtKdP1NEoRJcetb/bS0HN6q//ufR++CMDY2eTFEZc+sJo7EDkgLUFWYDYug55F3R+aT+6dsEEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RqyCvJUBc2yQanrUKoCnXz2+9FOPgVsYlFNK/FXX1Y=;
 b=IcTEvi8n+OxDvKYc4p+4YhaxZFIZ4Nr4voHngd4B1joIxai1hVVu0r5m6kynEozkWAaJ6LJZpLNizytuvFdqtVCYXrle8YkrRDwKVhP9BEOn2ypxxb0PJCCFAPpNJNG9cZX0oc0KZxQK0cxHGl4xi7KchJxGSOyO2HArfVRKoaVdWiMVEVFhTNiHJlkkC9MgYUxWH0khwyThEGR72aNapM9CN9hMlBUhlMBTLN5iWhE818+LzMYHxYU1M1sgjdmonIaWwBlWkHAVZaSLDpJuikMrR3jzffZKSQkJJUrYzHIFfeS9jFWsuJayhssg48fXfrZ6ORcSNNUJSjhJcliFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RqyCvJUBc2yQanrUKoCnXz2+9FOPgVsYlFNK/FXX1Y=;
 b=cr7uxUcutxbiwYPGVuyi8R6ETYcHJFVE2+ATuH5u7f/aRKkHNu84lBNDs4xKUG1dZPmsPk47c8vn0kRbTDz5W7JelQQpeCfWvHw/BJMOD4RO2/gvkq0Od0CIk2VD+36bYji/HqwzHEQHQZHEiAZ8i406Whe5yQSOMZjWeE/GmQU=
Received: from MW4PR03CA0237.namprd03.prod.outlook.com (2603:10b6:303:b9::32)
 by BL0PR12MB4689.namprd12.prod.outlook.com (2603:10b6:208:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 21:35:19 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::ec) by MW4PR03CA0237.outlook.office365.com
 (2603:10b6:303:b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 21:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 21:35:18 +0000
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] ata: ahci: Protect users from setting policies their drives don't support
Date:   Mon, 28 Feb 2022 15:33:02 -0600
Message-ID: <20220228213302.2915071-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228213302.2915071-1-mario.limonciello@amd.com>
References: <20220228213302.2915071-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99661adf-e1b7-4444-1717-08d9fb023793
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46897D690B1ED3A55574948EE2019@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DGXDKVHy8sIxwl4jsa4qCCj0YSe8MeL0qJiDwqgOBBihLPlT9qdIK0kwpO/FgMsJZePQ3/xeYGw+iRF2k7bxJVTLll+rKDJYF8FMp58CCjbnJ33ys9K2657PEOjoOgDhdUbV6wEDpQN0wMfLlR5t8Fh2nbe9E/UiVNxBO4DE+ILas/YhhqRkQnOeQP3axZ/ku3YLVHBYFPkL2295t1dRGjZ2IPXhTMwDF2oVNvrnFcpXUscQrvyyk/5eS6ZrENimHAprCXacc7uGkSrshwzeuCuG/v2IMUSI47RrF/pqYxmgfFlqnGv5CpvhzV4jUQ8frcMkSXNeYERx/3qymzQ+sf0XObeFNc2ayIDatD7Ezl3yMHonT6mhi/RetxTBPmNOwTqN3Vty6MHlNh4cTFAMdWCrrauyGFdtieZeZDezFX1/rTTOoVC+Mw01pKS3bJgzGPRUoa0H6MNVc3lBQAgMRnpSgHAY+dVa4z/RfgnLUXt5IpuCZdhbujfmz1dfjPK0iTAEyeZTk5He11oy0W9o0foNjWEhBNORpd7BXesJohorDHP761xKvh4RobWe60f81cbaAYpIohWshnAMQMP86f7Rk1uv6DRi/wMHFuaaDsgNGvi8IkcFf99sxsot8j2RSHpuyoESMzCHb1E3uCGEU1xMbAlFNtmPv1mIgw76gO43XCP6yetSddIDpXw6z1i7igcZqmwu2c6QppH+2+MqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(6666004)(8936002)(1076003)(83380400001)(40460700003)(47076005)(336012)(36860700001)(36756003)(426003)(44832011)(82310400004)(81166007)(2616005)(4326008)(8676002)(70586007)(70206006)(356005)(5660300002)(6916009)(316002)(2906002)(54906003)(508600001)(186003)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 21:35:18.8653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99661adf-e1b7-4444-1717-08d9fb023793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
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

If the drive doesn't support slumber, don't let the default policies
dependent upon slumber (`min_power` or `min_power_with_partial`) affect the
disk.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from RFC v1 -> PATCH v1:
* Move the warning and protection from drives that don't support slumber further
  into the calling path.
 drivers/ata/libahci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0ed484e04fd6..9dee721ed1fe 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -785,7 +785,15 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		pp->intr_mask &= ~PORT_IRQ_PHYRDY;
 		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 
-		sata_link_scr_lpm(link, policy, false);
+		if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
+		   !(hpriv->cap & HOST_CAP_SSC)) {
+			struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+			dev_warn(&pdev->dev,
+				 "This drive doesn't support slumber; ignoring SATA policy\n");
+		} else {
+			sata_link_scr_lpm(link, policy, false);
+		}
 	}
 
 	if (hpriv->cap & HOST_CAP_ALPM) {
-- 
2.34.1

