Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354874B7E41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiBPDCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:02:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbiBPDCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:02:03 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F966ACF;
        Tue, 15 Feb 2022 19:01:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogYqxmxgsfre8CK8BGjmXLJSidYxOqM3FviVB6PtXvDXrQr6uMuBNXrgp4yD+9RehkMCYnOE0RLA7ang3ntPbURIWMc37hMBc+vSh5PHHoirvljRO9qE6KNT3ZjA/PAws8c7l6XDLGF2/ktnW96nhw61xjQpKObA9KVy0KKgnK2uoirFpPMSwYpqRnAg3NuBfh7ettimTUe5+LgIWXjWF4+iCu05mO9IIUcvx8SgPIhWovP86zi0PdZqkgGdsOz1XMAr/dBdZMW2fwKnmYqxzBHZgSo3EKLlwi/B5KhPv5+e/bC0YgcDY2SrQMCIeafxiK0W22AWLt6Q4jciiUO6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgfC9L6KTrNGoTcN1Qvmw+L2q7ppu1eCeZlqWB5FCuk=;
 b=JBUzHaQJPUOy9+ogLv/sWu11J0R7BSpG73ZJO2VI3TwG5ojqw2i9u+tA1MLgXJ2pKwNkIy4YCZ7N5qa6MX69snBmOO8hj5T+3tebv6BZc5Ee+7fCZ3DzVTY13S9lBfDGhj+MBe1vBNn6kQxwg1tDGfiT/EOVCtn1sNcghmMcS8MszlGqViD1SFvzMsOa+MEeQ0p3Ojj46WgW9K82CkAaDlrh8MboxkVOLH7Esjgr+ryQYTolciQQsPh/wLLPCxspk0wV/HN48jO6l79Boi8jVTawjmcfwNR7Y/V0e4vOXd462910FkbtnzOwDVl0JFJ7fl2UQu+YFM8qb/q4Nifraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgfC9L6KTrNGoTcN1Qvmw+L2q7ppu1eCeZlqWB5FCuk=;
 b=RVBXwMHpeUF83mxlornCa4FQVVII9Xn5PexhzjB5qboGzdfMCBDH1QUQDa/QqPzFjGA+EQJJ6laWuvdqPEk/U8DgmpW548dEuwFDeMhaVLZE5lDxTVNZPIM37eR6KhkdxgzYbzQYGylY7YFUilc3fItpocpNxOJj/KOi26vzdOg=
Received: from BN6PR16CA0035.namprd16.prod.outlook.com (2603:10b6:405:14::21)
 by BN8PR12MB3394.namprd12.prod.outlook.com (2603:10b6:408:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 03:01:49 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::8a) by BN6PR16CA0035.outlook.office365.com
 (2603:10b6:405:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 03:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 03:01:49 +0000
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
Subject: [PATCH 3/3] ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item
Date:   Tue, 15 Feb 2022 20:59:34 -0600
Message-ID: <20220216025934.1892723-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5791869-cc17-4ffc-b1b4-08d9f0f8ad0c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3394:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3394FFE67BC77DC8ED680F8BE2359@BN8PR12MB3394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X11NCFPT/AkaPuHhnEIyh0kvpBngBDLIlapMfKt0OX4kX70i/mmqeSsugIENxZT1MMQIpKZK/K1bf7rAe0DV+drhpRMBQoRMPqepIQmh+mYugbxg06tmnoqBwLPRJillupRCM7MKO3xjNVJUs//0W70V4WRzwWuhABrF02D46y/hCZpUQO4FOa1FxZfuIM/rMdmEbLL1sIEaL8iBqfrK0wTU3pY+OiPlUjg3cuQCI8nW1lw8OQGCni88OkAfxVqR+mN64u1Ia/Xoo8PhyKw3c2v2Fu0w5wNcer+4PBn1CHNLrHBmCJAA8soQIYa4D7R5x9P8K7UNn91iVqat0NFQk95y3MS4oAL+PTPnmo/tTb5Jd7S7Y28Ij2P51EOsZuGQvVX4QITjwWxfNFRdu6gbgJSLFUOkrlZa6pZrO4Xp/Q/Y7qmhdf4UfXulvDj0kpEfO/s0E5hkmqhaP52uGFSsCUTLg3kCDHatB+orH68JPVHEv3Rgw2sEqSfl+hy0Yj59Z3RJumtZKJILCRgP/xDbzDMuX96jd/69kMBFAXzRl7fKaOUs8DDCNh6FpncJcfFJBcrFw7IeyK1cI2GYCbqnaJDNocZ97BEW60oTIo5Yd0IumJprNgI8OtlbqXQGgbfjGhYhHMJJoQseq4sKKOB4i4oWQX3bDhhdG+3jbdwmp3lI9xU9VfDooZsSE8TrrfNCVF9hFnJURhYmW1PM2rplew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(2616005)(426003)(6666004)(16526019)(1076003)(186003)(26005)(86362001)(336012)(8936002)(54906003)(2906002)(316002)(82310400004)(5660300002)(508600001)(6916009)(47076005)(81166007)(44832011)(70206006)(70586007)(4326008)(36756003)(40460700003)(356005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 03:01:49.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5791869-cc17-4ffc-b1b4-08d9f0f8ad0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3394
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
 drivers/ata/Kconfig | 6 +++---
 drivers/ata/ahci.c  | 2 +-
 drivers/ata/ahci.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cb54631fd950..52c086f155f0 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -115,14 +115,14 @@ config SATA_AHCI
 
 	  If unsure, say N.
 
-config SATA_MOBILE_LPM_POLICY
-	int "Default SATA Link Power Management policy for mobile chipsets"
+config SATA_LPM_POLICY
+	int "Default SATA Link Power Management policy for supported chipsets"
 	range 0 4
 	default 0
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
-	  for mobile / laptop variants of chipsets / "South Bridges".
+	  for certain chipsets / "South Bridges".
 
 	  The value set has the following meanings:
 		0 => Keep firmware settings
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 5be889de9b1e..7a7fa1090bb0 100644
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

