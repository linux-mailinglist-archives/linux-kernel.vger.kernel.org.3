Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480F4B7E18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiBPDCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:02:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbiBPDCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:02:00 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB166608;
        Tue, 15 Feb 2022 19:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kILeC8v05FK1gCGVF9HcoGNZYILncYPZgMwntsDwMCm8twWX2wsO93CuRYFd6+n/T9z5yp0mIrhN9L5HrXvw7s03zGdg0NlZ9yFMS0TgTmOpp1uBaU6p26O3703nbPnMTnt47zva4lYCfAUyLBdyIL7MRes0N2lYt6ldgGQGGq2SkbBdoOO78fZTH5gZkhE/lwMLvrTf8M6Ll4EpsAgB1EnNxbZGkyfyiHgkFXGRLf5BnmHdNtmD0pZob7vbQGlrfPaugwScDmhJJ5kieTi6OgEdJjI5Jrw4q6E4JVqV9HukedPfHT1KR27jLdokC/mkljNcvNCrIGT5FOu2rlAgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8OZrgbjPl+s633UlbFXIj82sey7jyni3Dj89YWBWOM=;
 b=PSUn+OGCt6LXPwsds+q7T6CZpMb79N0AjaeOXszkudC5DiUjh4i0jNt6fDDJvKjRYzD/yUmh/PW5uz4pBlZVw3lp4sWJMCtLjtJ6R/PdeJC4VuGp/UXT3lQjjujLScTeliQRdK39map5bE7ufOwDfJ/MDTJ4HbMDu3FqYNPGctIAOV3oIfCtjlZqUgiYBSDRnluDB3q6WyPa0OZik7g+isO0ZEE6Z/JZ/DeDIgorhjeD3IAisF+wsBIz12pRHVGb1kgiOcGiN/03AcEvv5cexHE4yvvHaPFjPDHUzOB1D3iYofM3mg0FnWX3+fv0bYwndpK2lnE2Xbc6BfPBpqI7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8OZrgbjPl+s633UlbFXIj82sey7jyni3Dj89YWBWOM=;
 b=5Uamgy1EeIpRWmwUbQnIsnrx4W3nwprE1Pt6mvGcV07xDM0q3pGTkn9GbmXeETnq0wxxwGOjMgtiXcBz6ZgneF0fYtbglNeYOmV15WhaNd54m5CwiwvIzQFm1rcGUSm8SM0FDg80S/4CUNNBzfyJgEOKuZWdhSE4JgWgaHBMC7E=
Received: from BN6PR16CA0031.namprd16.prod.outlook.com (2603:10b6:405:14::17)
 by BN6PR1201MB0034.namprd12.prod.outlook.com (2603:10b6:405:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 03:01:47 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::48) by BN6PR16CA0031.outlook.office365.com
 (2603:10b6:405:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Wed, 16 Feb 2022 03:01:47 +0000
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
 2022 21:01:46 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <pmenzel@molgen.mpg.de>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
Date:   Tue, 15 Feb 2022 20:59:33 -0600
Message-ID: <20220216025934.1892723-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216025934.1892723-1-mario.limonciello@amd.com>
References: <20220216025934.1892723-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b4fc00-c82e-4d70-e56c-08d9f0f8ab8c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0034:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0034674E6A0E525AD07C5464E2359@BN6PR1201MB0034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8A6wxH1QQCt+P2MH1enhS/+U5hRgd600a1qSzcxcpIlfcFe3xi6VY2crhhGfEjxEEQ6Q92D5IGfE8vJA7oiSdNFBha+4qbpPhiYK3iGjdxNHC54mEFzgRx5hhJUCnEeMMKjXOoQOv0nPHW8lL0eUcQP0RVLkdXFp+T+JFZwJavUmc9lucUERq/a8xqRvjD/SzSpfIsmWBvlAGCLcZJWIjRanpXN4HfQ01DL3t1TZ0CMPA4KxbgjxfaYDWRqtOafFvbUeY+e2/SvWC9BCg0+T/jQgBmPKaPexKIFPsepwLQrwdIu9qGRjlRbEB+Bz1RM+4H9iMvZ/DcnKkkPqDXD/73/s5vLZtP0BrcQSyRym0hdefrqBpF93bQ/2EpPyj1bOX1A0Xce7J1NH9TeQF9586x3iEtalDJNaHmEVWoJzbFQDVHUH2HkOFINxdJYP4VfrXNwzFMGgzHp3BJOxX9CM4U9ijP7SfXMdNbXwfzfDngw4foy/0nzv14IL5cDwbG1aaEiwEcWyi7A9P7GgYRPGwX16JCoxlN4w1GuLBV22JUFgFHXyQtgaDBJ6mkPm4I4dEh3YR002+Q/ZWANeA2O+pX/xIvbGSWCmFUyn6hWHecQY+H549EPNzzY67kIgD5moxst28HwpNaz4SoD3ogd1EIKRUBpyeSaU4M9cStG9rXWphtvAue10s80b5pST3SDNw2iL0BsHksiyqM3Z+3BDoyWxh93pb/Fmg9zsXEP5vI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(83380400001)(1076003)(6666004)(426003)(16526019)(186003)(26005)(86362001)(336012)(8936002)(36860700001)(2906002)(5660300002)(316002)(82310400004)(6916009)(47076005)(508600001)(81166007)(44832011)(70206006)(8676002)(70586007)(4326008)(36756003)(40460700003)(356005)(54906003)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 03:01:46.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b4fc00-c82e-4d70-e56c-08d9f0f8ab8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
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
 drivers/ata/ahci.c | 6 +++---
 drivers/ata/ahci.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 67f3b3b23639..5be889de9b1e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -136,7 +136,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.port_ops	= &ahci_ops,
 	},
 	[board_ahci_default_lpm] = {
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

