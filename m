Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378FB4C3E47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiBYGO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbiBYGOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:14:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC77C1B0C7E;
        Thu, 24 Feb 2022 22:13:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS1Hq2CUZvfT6uHVNgSMbAnnTv6roY8SmxXP83rVPhALaT41RF4tq6SgEkEl2fo6YniBlnxxg36gWoXgMJgvxkPNXHRfKeWgqSPUw+qDZmBnYhMKcr89D/aEQycGsVU3OO8JS+qsoDDJpd2SfoBxCirYpE6pqwTRDI76RmJIi6bdrS/uNVUDJG+ZKBaUTac/ZVGQgZyRXsSNwQOIeJ5M4AvK9TY8JMBFUdPzJuvzbR8vwq6RZp2I3rChjfdGj6ZDWVSrJq4ZxTq2JfROrSayWUR0rZQHS2d7hCd6CbcAMY4k3uNKdm6ZZlgaHASp+03iopiJVVt0jfpUiFeBARzV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlbqGBaIymVkR7UjspnKwfk3h6zb0zG7VCHSooF0Sjk=;
 b=DVbgxy6SzIgi9fI7GDAY+uhPF139ZeePVxnwUsx3rSs60b9tm6Ieuytvz8mNvK5X2E9W2fhH+qZHA21UFRkrhZ7dMakG7F3bRFAtxVF46Zq0uoDTbWnQZ+dVSZKmeXJ7/gnwvnw5v97kM+MBp4OmV0yZYBGEd+a4EdnRg33hbkFADO/5n8n5hjBpPMGwTMIHhEW6zBCyn3NoSrPhMgIzIKRXLmqRR5JNe3Tl29esgrki2rxmzTqkfDeFOEdHH+BuddR4kt/DgcvDh19j3H2K/N79Uvb4zrKV0L+hqwmOjNAtRvn2fXgB8nYGcsBYZiKXso/5dM9N3pI6mmZVPrMsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlbqGBaIymVkR7UjspnKwfk3h6zb0zG7VCHSooF0Sjk=;
 b=UWc2b+BeAHNzl9lkxIGoUspt7WIWf+2pjRacDs3ZARCgL0y4HPjrFN7DbU87SMlkeuDGk49bpehQnYGOaymhhvnzifz3VVBa54r/wCi3CwYCKioPm7y+7Oo8M9C9CExgk4idpKaIkDKSB/A2sq4MwoFCUen4eOY/DB9mmBhHfkU=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by BYAPR12MB3557.namprd12.prod.outlook.com (2603:10b6:a03:ad::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 06:13:48 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::33) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 06:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 06:13:47 +0000
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
Subject: [PATCH v2 2/3] ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
Date:   Fri, 25 Feb 2022 00:11:12 -0600
Message-ID: <20220225061113.223920-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 81909d3e-8a11-4ef5-6bf7-08d9f825fc53
X-MS-TrafficTypeDiagnostic: BYAPR12MB3557:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB355799E95EB657CEA819FBE1E23E9@BYAPR12MB3557.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8Qr0B1AXkHtI/qtiqA7Nln9ZFYy6vJRiBfj6nePhA1eXzyxJzVmbOhylyUX8xBX1rneCC/F0VEZeNo23l+uzSH2GatfpqSGkBIsY2DYuER9j6oidFKQz7bLYMG70NzdsoU8TnvcFZLAgXN10R5yfQnP2MHe406tXD/JtSC9sKt8kAg86zEr7ycUKx5gH8kcqUi4Y4FO458eSil3fJbQlaFd+GxcjtG5JqQEN+3XKKQ1lddJQgLIJPzboUFsuh+up//08WA7z+BYS3TQ4uw7tTTCPvMfsdMtMPrvcCHZl1RVzzWdc9ap2frhGOuB9CGayQNM+DgA6qbDVSAT7LUgREEvYCevdAj1svgH9UcZD03iVCglveOUGT23EKm6ZR3l2SrcRAoSaPfvo4poJV3MJTBlhq0Eka6WPyxqJZ7NOoZ9bFJ1uLjfIvQtvzXORHDG76usQwJX5dZFajj50+wxXurKGNTQsvbZCKXJ2TVakUdCumrUKFf4m4uiwM2y1RlaSujFMkPMKxXoziZhJ7RqNA7WBrm/ZxzA5bEJBzdLyal3qaRlIA3W/OamI6qzTq6sXf2MtzpTijynaZbwzgV66vw6TAZl+qe/TWb8oHyKpH97mLQ8XvjehXZzA07StSx4sodJuwxaS7I/609/ro/lhDrK1SaPTdgsTkijk4qq9Q/1ibuUw4IZ68pxLnsPanMQ7ltp1QubZMM9qonjzHWNdcEnwiJngzxEXy2HKgEN/cU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(36756003)(508600001)(86362001)(83380400001)(336012)(316002)(186003)(16526019)(6916009)(2906002)(426003)(2616005)(44832011)(8936002)(1076003)(8676002)(81166007)(70206006)(40460700003)(70586007)(54906003)(4326008)(356005)(5660300002)(6666004)(26005)(82310400004)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 06:13:47.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81909d3e-8a11-4ef5-6bf7-08d9f825fc53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3557
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v1->v2:
 * rebase on changes from first patch
 drivers/ata/ahci.c | 6 +++---
 drivers/ata/ahci.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 995ef962eb92..a77e8154b5f0 100644
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

