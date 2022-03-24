Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5A4E65C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbiCXPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbiCXPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:00:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4D0186F5;
        Thu, 24 Mar 2022 07:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoXAzlQ1/nBYAbQK3cZPpTbrwTcDdyckACAU2LkbxalQwPUsYfw15Q13RI3i1k5+81HlU2Z+8K6hOy9fl3j0A24eLaqp45WAX+KSEATtoZal0VdCHiKoWxJ/Y0yJb4txWJwInHZI9Bt9RGIfbA4VKypZA+6aJfLe83C4mwo26WdVdpxgWhGRTOjQG96JdcYQfmlU7rr/ToPbtXqyZZ/X9sOkgEVPjpZvDJD1W9XaZBKV+s+QIywQD/5CYBqIyOing6fJ3ry75iyU5eOzll0eWIshneeaFEpGP2Z2m5H3UqutdrLtXEcGDfeHTurK+GOcDGK6iLgQ8v+TWVbysWOkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEWrO5sktVhUCaOg+F+2282D40HENNTNshCKLi82Q+0=;
 b=AvADO+gwF+R1yVLfBh+fDVTl95uuaNjQw1Yb+TEY89QsY5sKoNfBAYwnf3JMpiKKh9iBGiEmswSMkvJbZzaByid5+VqCnynDDYD97bMF2pnLwm/MpanDMlT8uvNnL2hrN2IO7kRuc8DtjMzYTRvB33mno8+l40049cmbFS71igapeRtqnLw4Ml5KseryYslfom6V0W0m1g8o0GpaXTXyTzLca/qYp/dza8L+Z5x8fJuLRXvjCmKSkQ2pYrxFcTil5Nk094HCWtTwO4s3iRXc7mZ6peHRaAq/0YLBRAxGPT/TkvDw6jRLBEnoXlHVLhUsJyFmaElHPdJuaYtL5YdK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEWrO5sktVhUCaOg+F+2282D40HENNTNshCKLi82Q+0=;
 b=gAehE7jHVrmn6egHNRMIAyOuBM0SINja/DdpbdaefeVknu/nINty7SnLugBQ5np91gJjXaYu8KPfMa4wJaW7IOy6GGssawlIE9+NbLypeuqwdI0hCRnwxZSGTzEgfRvKlW8Wdca4Zj2KcotUsubiist7pd4g48VtK5mAaC2IqYs=
Received: from MW4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:303:8f::22)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 14:58:44 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::84) by MW4PR03CA0017.outlook.office365.com
 (2603:10b6:303:8f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Thu, 24 Mar 2022 14:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 14:58:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 24 Mar
 2022 09:58:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ata: Kconfig: Update SATA_LPM_POLICY default to "3"
Date:   Thu, 24 Mar 2022 09:59:05 -0500
Message-ID: <20220324145905.4176-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f03e627c-dafc-4593-905b-08da0da6ca8a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572462593608AF863122092E2199@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k581Len1ZATCr2kfwQZUxV3HSY3EuLepL27q9mKsQzWVDIVD5ndM8V6D8Ose212+PheNKhYqfNxlOlv/wRnFQqXiegMeov5CxLqqiSWE8TNEbPJMMAiCt/sNy82XjqIvoBGIwTtY7uUGZC9hMQW25MMVw54O8jndMwZic/+xDIZ9MAOYoNmQGN/fA3gh6Vh5ffOK94RDy8dA6uPxAwmR/hkKyrgnYh0rYk1g7iLORS2QJmaIokSy7SMronqhedTZ5sTuVPIpxsUTZ9OISQ5+rbWpxJU6UG8SxNbVBqGO2FdFkuYonCKAMrJe4TixsXzeYcU43VKZSCPbvfIamJaGs5xs7rx0Gg+Ca7ry3ha7LVp7tTRmDa9n4CejWmxsLazLtef0TjSGkmuPBzFt5ND4mBH/0RFwG8vNIDX7FLku0AP1hO+V7unZtbXFUrv68L10E/bkgusQrLp+M5DNF7dm66HGUlEmuZ/wF6q2EXdifgIq592WMeYCfGfOWwHmcW0UFfGCG46KuHtFXqFBdMl1JtZfSTrN3vBcsuoCgX8YFRcVXbevZTOlCE7ux/8nSfdU5HY7HcRhXjq+GdtalSdFEyXIQiYZf//LOOdc93PbbJEws6alKM7NLf0QoGjumjO8Egc+XB4qTlTrKeOx/iHT8RhnelsQd5SlbqAYmEkOoy+nSFzUXq4iW+IC3X2v/uBvbngaeSk0ZXfCSZ4cMbmfaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(86362001)(356005)(2616005)(110136005)(508600001)(336012)(16526019)(47076005)(426003)(82310400004)(186003)(26005)(316002)(83380400001)(1076003)(15650500001)(40460700003)(81166007)(5660300002)(8936002)(36860700001)(44832011)(7696005)(6666004)(70206006)(70586007)(8676002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:58:43.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03e627c-dafc-4593-905b-08da0da6ca8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
We at least have confirmation from:
* Ubuntu
* RHEL/CentOS/SUSE
* Arch
* Gentoo
* Debian

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

