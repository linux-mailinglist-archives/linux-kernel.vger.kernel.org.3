Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE62562932
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiGACdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiGACdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:37 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C98313AD;
        Thu, 30 Jun 2022 19:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfaT78x058Pc5wgKMvf1RvxkuWtRnJj53Uz01efv5IRhpadI0b14j+6x1kEPh8UCBUCCqYcklIp6zoVw1uDSOdOa03HHSHzewdmfjHJUC6GN27OXi3f4eH4d7b/LgP8Wtn6vS3ELxkMxYCgccKLOiRHjRppMM9mdeE81uFw9DNtDHrBBYY77qrlou3VCMRH7yKIrqCdowftO0RBb1A3c2zb2HtL2fOHD7a3o38VfzVpjHjK9WwlQD6tCXCj65etjC3MqJy9L1MOh47FJ8PmbXCOhG2joZrqneVDN6en+tSeM/9XdsuVdrh4euwtuayUHO37WYJ3RvBnKGA//A6Xhfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2fjv8LuM0gFTP5c2H1wFK7j+ZshOClw+rZZ+a65VYM=;
 b=E1FrMSY0tVI9dhl/HiDH3tyD3iOK9RZ97r7WZ0ljsRWOBzYpn1nAULxyLFxkCvppa2oQ9W2d0E8P483MpUVYvX5M48I0Ho9NRYceMdu5AOlIvWcL0UULkhy2CwTCY/QesI3B6suMiLtfgrxpbQibte5XJf3WsHKZWQEnv+Upy4D4wSuy42hPajn7x0IfnDieDYSOaJGY4uL9BI7yMteft7HARYEwXiZ3jpoIwA8IrHpuPEpEnSESE7/GaBrWbOKagcBQXq2gX126c7XSUnUnx7kgNB4/1NFSIgF56/mAJFVeZgnckphELE2M+J1NKrLdPR7x/4WtRgmmMSsigAMnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2fjv8LuM0gFTP5c2H1wFK7j+ZshOClw+rZZ+a65VYM=;
 b=RO+q6i5/yHsRS/KNcNsKwYz5oSqO1kjBBrv4/Nb4/EP0WQJiEw9gUMeHH3yLzwFleiSBBCNl7LWRe0rOw2phrQ2awLdUWR362a2EYXrLe8gglkaReVpL12/QScvuymKgHgmPzpfC73A5P7WOJ2JKoDLn0Wjcc6r+pmFsH32zQQ4=
Received: from BN9PR03CA0989.namprd03.prod.outlook.com (2603:10b6:408:109::34)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 02:33:31 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::6e) by BN9PR03CA0989.outlook.office365.com
 (2603:10b6:408:109::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     <linux-pm@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 04/10] ata: ahci: Use `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:22 -0500
Message-ID: <20220701023328.2783-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701023328.2783-1-mario.limonciello@amd.com>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e637f2f-230f-44fd-f414-08da5b0a1670
X-MS-TrafficTypeDiagnostic: DS7PR12MB6191:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tQZhuQf14BztUUQ+UMX9OUDX9EfiyLWuA0TU+Pre/M1IfnIuk+KmrBrGMoDrEtLRS0YhiRAuccWi7UlPEhAV6a3Ib2qr35xafOLp0Kp8/fIqyTESgXOSbV7qrE6wlcQv8Q44C65jGq18IWCnjq3/EFfDOA+OxThTM7MrFWFJMXd/OQ+N8ZEL9f1J/J73vOvbKv95IeTcXOIUBTzIo33uOxiKD7h3mlTxCz8wmYir32NNpGPyioCPNmCQAle+4wH3bloTvTsGblsJCllRFtYwtLdCnimewDEvLZKtnub0mQFUJpvj+MiNJ6D2xfgtwbDUYqlm9kx71HVTfkJKbxqDZdmly8OBsxXPlUBwnpm/OBfdrA8pWxNnUAF//0+Fb4Ku/4kRz8BLW1xSk16s/sOq4uQoDOGEQrbB4xapfbwSiGkT5XauKTED0PHMc8xsCCa040dljU9Esk9bafRvYsO4n62oVG1uNq7gt82RbVYq8ZKb0POcx+Z4HYNI3Cgx9BYsddmZJdqwGnHtz5jKO0L3Lzgtkt8HrkK5oLYkJ/WPtRJ55eZo2b3DrRhvK/qYPsYa0LKoFvBfPTS6wId2wQ+YZCsP1b8fQ3kemECgHqH8bk/+rHnrMx1AvNAWilSkEPv8zwA8ZNtt5pwhuovPLheZpfKKg31YVGMkypNN+0ls3t8is12raU6b/7+lJLQWSVvBYsW3UKfPv0h0hOlQwJf//v2/TovPxBs2affyHxHzLJDGVhOR7UTp6MDenVidT1wYeyPmPqRxZ0cdlnUPtJmqJYVn5pqHKjTxqSufRuhNgsfuV41Zc4gXTWn5py07eM9fcNQztKxb7HW/vf3d0MT7kr0lhovZm06CpUDvet5gij6VIZwlgcvonf/Np0CHz+e
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(40480700001)(8936002)(82740400003)(40460700003)(6666004)(81166007)(83380400001)(356005)(16526019)(86362001)(5660300002)(186003)(47076005)(7696005)(336012)(426003)(316002)(4326008)(26005)(4744005)(82310400005)(2906002)(41300700001)(36756003)(110136005)(70206006)(2616005)(54906003)(8676002)(70586007)(1076003)(44832011)(36860700001)(478600001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:30.9867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e637f2f-230f-44fd-f414-08da5b0a1670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the direct check from the FADT and use the helper instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c1eca72b4575..3f79b732dd00 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1611,7 +1611,7 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 
 #ifdef CONFIG_ACPI
 	if (policy > ATA_LPM_MED_POWER &&
-	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+	    pm_suspend_preferred_s2idle()) {
 		if (hpriv->cap & HOST_CAP_PART)
 			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
 		else if (hpriv->cap & HOST_CAP_SSC)
-- 
2.34.1

