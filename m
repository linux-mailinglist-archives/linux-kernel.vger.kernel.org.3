Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3253D4F1E9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378709AbiDDVqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380403AbiDDUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:04:17 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802B30F57;
        Mon,  4 Apr 2022 13:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aed1xY76nschRfiHriCNKQacMsb/uQ5xwmsxvXID+ixQPAV3U2+GENsR1Wt/PREqu/IKxW+lRhEmJyme6C/TZMNfSMg359QKJdD10akYsaoeUUwqIzNNU3yCmQedCu8sRgqps4b+L1rz5kLhLUpVTbNLrx86fMPH1rxTigeLiIY7HY6AfWESpgVwQx73E6stjEHabtkK4Sc0z/qRdVEGehcbK6/ovkJSKCmIX+4DnxHaHwNbxwFrrq8xdzLsLMDwQP9vNwQEBW3wWWZMHZBIww8NepC2LZnBn7bWIArffV1oeYxfmLn6VGYI8wVU1GtEnWfAj5aGdLMaybVyKZMebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvKJUxGCVwCOv/sIfseWhgW89G83DX52GAsINugKg+w=;
 b=KBM4UhKn2WcHUWDtTmIoaydzDO98RfceTIV7Tffa8pB3sMGN1F72BDb9x0yqqCNumZ5MM+NrGjy1oYoXC+Sk9ki0PDU/8vF3f3koVhAng58I38tfL40G/ur+3x3c2yVzlFsiNPTJBY5XpUhYZosWm+6Rt2B0yt0OTuiQaz9q+pq3veQUnCG4EJ6rvX2Mq2Ahaf5o8NRr0No9IBfhaVvC9GHtTcSfOtUvA8kFVpRTtux9i8WLyku+XKrI9rUJB2ln64NxKmkDSNnoa3k+l4lNSIdt57K4ptjMSc5Qth/OctMihZjlsrUvUp9yVVNDGgpd3Z+lnM+EZeV4agSa4SuHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvKJUxGCVwCOv/sIfseWhgW89G83DX52GAsINugKg+w=;
 b=N9ZPa2GwhmgkLZcSeVKgtpC7/skIQAJEQM4klcatAWH3j70C8I9GN9y5GU3ErVJ11n3naD3Dea2kK3fuLeB7TbMy3G/701KzIEPnNPVAiYk39oyC97SPV9LKiiGne4R5QG/llO00zvmCHUU6bTnA30SUauTTCRPh5xPR5/H2tRk=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by CH0PR12MB5137.namprd12.prod.outlook.com (2603:10b6:610:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:02:16 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::35) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 20:02:16 +0000
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/2] ata: Kconfig: Update SATA_LPM_POLICY default to "3"
Date:   Mon, 4 Apr 2022 15:02:01 -0500
Message-ID: <20220404200202.9388-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba1677e-7ae1-42f2-0f25-08da167604a0
X-MS-TrafficTypeDiagnostic: CH0PR12MB5137:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51371CDE56AEC785729FD44AE2E59@CH0PR12MB5137.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FmN9DVfXttgWzrmFI/3UCIpTntwYdxZE/jBvV630w83y6D7gxDeHbM5h1kjIrA9H31sSFoVEPdK1xOrXONOMXTEJ5WaDgHHxMB92Z3/DyVLPy9Tgt6fGx5IJ3tpw2cp7h1QHUA6N4dmuTzN0NGSgxUANonsO33VOf9wAPLxLJIeuKLTdJkMpx2ox83lDSJsNaDSmDzHPrvowqB6lsqeKUPoHnlVjAd9yhikxnnw2tReq3yXGeMS/Y4XJOo0zlwE3tmwi5zjB2DdsVj+nVf4igDrI2u8Xd4UViH2dSxPewmMY2BQeOSXefGjWQT8H+xw2LXK983M+zxofblXWZ5BHDTqtqLEg2Up7Px/xqClTfsFUNpXutPe49USKmCxt+tTFBfZwGBLMW4G3WrZyV7RzwraPUu3A6wqVn0grwlJJxOWSUplDKzVrU+aYL5aLBtHqnv31QD7HFHD3i6ziuq0f62WRzwgNT9pnbpeCetX0LwK1+IA6HKjGqmekkPspLE1C/8q3cvd9GZFlQy0d5Q8aNesOGB6m3wwhE0lj0lbM32A1iCRaTKeQpdOJYqmKffjrZ1sqynoYJQm7+Pj5fL90ZKscIbuBp9cqGreZmP4o3nCHdhtTOHmWXb3Ut0UrqWBv0PZUYTtXA5icNMZlzsmeEufOS80gG3/AAmGNSmMbx4tcO4H2vZs9jlHfrmvU1Pb4ZoW7FV0rZtpX18mq5RKOBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(356005)(40460700003)(8676002)(426003)(336012)(81166007)(70586007)(70206006)(2616005)(8936002)(86362001)(7696005)(316002)(16526019)(82310400004)(15650500001)(2906002)(5660300002)(508600001)(44832011)(1076003)(6916009)(36756003)(54906003)(47076005)(6666004)(83380400001)(26005)(186003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:02:16.4803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba1677e-7ae1-42f2-0f25-08da167604a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SATA_LPM_POLICY is a "new" configuration item, but it was renamed from
SATA_LPM_MOBILE_POLICY in commit 4dd4d3deb502 ("ata: ahci: Rename
CONFIG_SATA_LPM_MOBILE_POLICY configuration item")

Since the configuration item was renamed it was mentioned that people
might invisibly lose their chosen defaults for it.  This means it's a
good time to evaluate whether those defaults make sense still.

Historically this was set to "0" to prevent problems with power management
on very old drives.  However it's been observed that almost all modern
Linux distributions either set the policy to "3" in the kernel
configuration or update it to this via userspace policy changes. Update
the policy default in the kernel to "3" to match that behavior as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Rebase on 5.18-rc1
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e5641e6c52ee..3ffe14057ed2 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -118,7 +118,7 @@ config SATA_AHCI
 config SATA_LPM_POLICY
 	int "Default SATA Link Power Management policy for low power chipsets"
 	range 0 4
-	default 0
+	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
-- 
2.34.1

