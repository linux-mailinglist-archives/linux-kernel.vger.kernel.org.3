Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F044C4C20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbiBYR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbiBYR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:28:40 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9942F039;
        Fri, 25 Feb 2022 09:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZyOvcNanQtZ/9vfpKffP7lcoKpCsCKqpIz++jxz6J5B008M9Tpw7snPJ73NdOuwHAT9rc64WMoVsIVV565MFePozlWH1j+7oqHZVfOrsVc0sVBvdwxR2f26jvdOqlwogontNrKNN4kaHcuHnLpd5xHOTtdfwt6ML9V3lFSlza9Z7r1eLectkntulGqt/OhKxva23ympGkOI6QHR72xuxq/TFHB9xTLBKOX7UfHrLVkiKaOof5+P9lXRJYec3meAJuO0sepkFRBwYvnc5uX7aB2jJjE7ZULoMgqoL+ZVcV0p2U/ss2a9nzED9XGQJOWnKgYAvOE34i+edFQ1daRkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uKpWSVR8rT3fvg2Wgia0xB8EinHUgDHUxB3HvV4wdI=;
 b=n4YwY+5qfko3Y//JG1rv75zJh6E/Jhy3ZKemeEB+sbxUY9tqTZx9G5352VJwtf5Pl+NvdLIah2teRn0YfGeDxve1/tjgMAr9JRRYuP5h9R3C6iyXm0Cfsb6L+tGk+1P8qOpM+KoM4n6M73hsZ+W9j9+HkOIoTAkM/aPy81i2aGMNCkAk9vJB8JGMLClMzNdxNH7J0eQh8XS5VPT1pbCtOghP0iUx2AD8fGa3X9En5/8MccNcEZDLm22ZfjqNag0bNUXgiFYIRb6HwgPE9zRrt/VZk6YZgXAFfuz6GpvTkMGHFvTmdoKVs9qhz8lYmBov2iWr/fmbkjfABXp6UjCrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uKpWSVR8rT3fvg2Wgia0xB8EinHUgDHUxB3HvV4wdI=;
 b=mm1WdjKTD3ejIu5jepOyQeE9l67hFn/epNQQlxae7gH2Xm+NlHauSAB2zAQjRI2c3AiDsX+oZlrg1g2LVPe8sUHRgnK+NXzguhOOBEvhAzvy0qcJRJtlTyPdhRO+i1FA8mu3b2XTN3LHxgjNTwEV3ojko6+6FQoirh6+04rmH7A=
Received: from DM5PR18CA0088.namprd18.prod.outlook.com (2603:10b6:3:3::26) by
 LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 25 Feb 2022 17:28:02 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ef) by DM5PR18CA0088.outlook.office365.com
 (2603:10b6:3:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Fri, 25 Feb 2022 17:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 17:28:01 +0000
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
Subject: [PATCH v3 2/3] ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
Date:   Fri, 25 Feb 2022 11:23:18 -0600
Message-ID: <20220225172319.846891-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f60ff2d-a0a5-441e-d8ba-08d9f8842ca0
X-MS-TrafficTypeDiagnostic: LV2PR12MB5822:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5822F07454538D2933C05853E23E9@LV2PR12MB5822.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThXUP9zJS4mVHPz/JV+cGQ4dpU8Y5eh9W/XiAuuuv3noe8Yrgh2VBPzcoTQQns6WD/O0cfNzodCNmTc+Bng7lpaRaHJM8SQf5WkOTq3mb8PrMVt2kVhjuLiiHUlKRPU01KVHVMUS/ol8uD6FkWhI7qk9r9l/1VOw9XuooFDJbJhM1Z8SZxWz9shHL/1N9xgTvidFCgg+yjcR+GPGVgEdhRrSzBi8E2m/mj6317fRR6abtBFNAGq5fktjIjx20Pq5YkNQsgu5d80Yy+cA7EUTEcv3rqey8apHEClBV7IYcdaUO18ZfQRiDe5+8cN1UNfeIPl7bUxrJuX1kA20/h1vsB9HBODRmDhWvLrPpfIyS9lBM+0H/BQ63dGEGO3tOXLgC/GsS5GS50Y9iHwULJKJEAGf20lTsUI8isLnQbRy/2pCEYAn1DB5U6Br4nySSYP0ceqeeSOExA8pcQFLy3COyKzJKwH9GNaFn0BOE8vX4eTcAgF30p3/+7PsteRq4JXt9Q5iDx7ScFAt/bwdQhF+QGJ0sjOOjtUJJ32i6+ltM2ita7k5dChSaOH2czLWceU/NeRfyLirHUYVg6d1v/cK9HqQBLSNWPk26EtFbSas7XcwAxAbyOSEalHjCwJDadsKXBsPkq1Mh2yuUUKVt4u+5SeryRITotfi8Z2nmKgRwKqNkZKOF5s1bG0NurU300Ve7g5Hwe+B6ezX1c8j6BsNvGn7aZOBdW3bjIAmEmzddAk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(426003)(70206006)(70586007)(36756003)(5660300002)(82310400004)(83380400001)(86362001)(40460700003)(2616005)(16526019)(186003)(26005)(4326008)(8936002)(1076003)(36860700001)(6666004)(8676002)(44832011)(47076005)(508600001)(356005)(81166007)(2906002)(6916009)(316002)(54906003)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 17:28:01.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f60ff2d-a0a5-441e-d8ba-08d9f8842ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`AHCI_HFLAG_IS_MOBILE` designates that a chipset should be using the
default link power management policy from a kernel configuration item.

As desktop chipsets may also be interested in this default policy
configuration, rename the flag to `AHCI_HFLAG_USE_LPM_POLICY` to more
accurately reflect that a chipset doesn't have to be mobile to adopt it.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3
 * Add tags
 drivers/ata/ahci.c | 6 +++---
 drivers/ata/ahci.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8f38244eda23..3a6db73d28d0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -136,7 +136,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.port_ops	= &ahci_ops,
 	},
 	[board_ahci_low_power] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_IS_MOBILE),
+		AHCI_HFLAGS	(AHCI_HFLAG_USE_LPM_POLICY),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
@@ -1595,8 +1595,8 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
 
 
-	/* Ignore processing for non mobile platforms */
-	if (!(hpriv->flags & AHCI_HFLAG_IS_MOBILE))
+	/* Ignore processing for chipsets that don't use policy */
+	if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
 		return;
 
 	/* user modified policy via module param */
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index eeac5482f1d1..1ad48e2fe573 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -235,7 +235,7 @@ enum {
 	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
 	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
 							only registers */
-	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
+	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
 							SATA_MOBILE_LPM_POLICY
 							as default lpm_policy */
 	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
-- 
2.34.1

