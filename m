Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86CC525491
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357535AbiELSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357418AbiELSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:18:36 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B660B95;
        Thu, 12 May 2022 11:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7eV7phhaN6vCh+QRg+vn6NZ9iFtRYmEYJWq7CuwVlLDuCg78OiZPfu0RI7dOd+jcLt4dsMQTHmtqjewB1GYB+cUyXZ3SPdVDbqbxs99h5HCIBNatZFsvnG3F2IbHkZRX3/D+74xGcsknYdLB0mOghQGbqXlE86yG0iY4Ldm+qkWBsldmfb5BWr6PukgiQxutmyjx9xLIyBQvqDu8cYR4maq19KZXT2IGZTs//9IOzcSc637VniyrrXH78//PS7IOKaSFPTb8uh1EN6GhkFyzhzl3FlnzBl+gl3EUnX8wLKggr5S7uyCq760UdIjdeYiITSZTUsA8U+TV6+lPlsnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1/zsxOlfQzi3veTVk7BfeMPiNa5EK+lv8Z+hEZxuU0=;
 b=WIW8jBJL3U+kAC6SGaScAEuvpdZKOb3eWheGKp7ShG7bVw7MF7ehD79uzM0T3SFZqxhRSM7LGmIlEWqrTArbBHiTfJF2XOUmRH0p00dTqc/wPm1DbZjUhsQo/mBKDXaItZQ3n5u1oY8PpKjhoLgO+ChGtVljuZi3HPH2PRqC4WTnYGGktWXI+/FuCnGp+FCd2SOqJCO71m2CKvfDLcAnACSra7biZuUfj2u+P7vvIKWmWg8glxvWXMNx3nB2/xh6hwYGwgVWPfByharWOz5Bl3cwvj2Z84NpnsFq9eUYpD162vr6W/9yaovxV1ANJvG5rttfgwZ5p0OPtFWjxASjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1/zsxOlfQzi3veTVk7BfeMPiNa5EK+lv8Z+hEZxuU0=;
 b=smyoJw3EUr024vxfzWgZSF5VnKTyBvsGvPHeKye2oy1wx0ornyBgAn+eBhLzZdVp5Cs/Esqsie5pQ1Ci7G3MOs3I11xMOeZ8SEUGvQJo8r6grI+oBx9evXuKOS9bW4pcIrJDTCdQPd0qvV+N7Z4XV6CtnwA51XdNi3fffAXJSwI=
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by CY4PR12MB1624.namprd12.prod.outlook.com (2603:10b6:910:a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 18:18:33 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::da) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Thu, 12 May 2022 18:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 18:18:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 13:18:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jikos@kernel.org>
CC:     <basavaraj.natikar@amd.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Chang <David.Chang@amd.com>
Subject: [PATCH v2] HID: amd_sfh: Don't show client init failed as error when discovery fails
Date:   Thu, 12 May 2022 13:18:48 -0500
Message-ID: <20220512181848.27347-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd75679-b825-455a-03cd-08da3443d2e4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1624:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1624B6F958C65AA402A6339FE2CB9@CY4PR12MB1624.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IltmUmIvGqnyIKb0hjUZEbVGHVM+0Hzyx8vFt/S7tZXSYwZVf7zPjG0IQXAtqSCC+LoAtArUG3SKbQWww/0MQNX67ERggbGGzoUgbdNxlctzL2evmd1tn71inyp+dbkvihSsnYT7FK4+o8B/ZzHLfFtBgXmEhEpjkUZW2ONlP7RlBaWqylqKelxsvpqnyDPeBAz1bbsDNWncnlz9wekdqlAZBf/xCTYn665MB8Az3sId4q4y+rU/4Z6STL4utbZhhFBX0Yo2RnXstyCOHD9qGJKm8TEe8lLP11A/2Yr1Xp+p0BGEPfepRZEjNypBTdD8TQhTcbGBnxQcDLU4XkbTunpKsqHb/ojpGKIOvyKj65ya9KCmazmDMw1TSRFDekzfn8LFxNIfZfjz51gFMCVnEXUKx/mN0Czfx+rUGnlung+gXERMSQpoVMbRmouZbGYhmE/EN4QLtO+PdRBjie3UKS2IvV9c0U/yFgsc+/yUb7rjkRaEjtw7W4u12cHeNU8hXVCkow3nti3DTh8R7g6Eg3ANGQbegH/+ZME8FLykwjhsx3RGsUeQ6XWHu1Tlo2jI5Jm3nRLI+XpWaDgwMmAAJeQ2roVrtGPh9lVpGZIi5GkJXyavCqRIAscJOPQPme3V1DOGQf1HC1MgAtgvZfpkj6VX9yohd/zYiHopdH2HWeeU1veV39JVjH+43FxZ2FPs1egS23leiXXEX8Xz1PJhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(336012)(8676002)(86362001)(70206006)(70586007)(6666004)(186003)(4326008)(16526019)(426003)(7696005)(508600001)(44832011)(5660300002)(2616005)(1076003)(2906002)(40460700003)(54906003)(26005)(83380400001)(316002)(81166007)(8936002)(6916009)(82310400005)(36756003)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 18:18:33.1177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd75679-b825-455a-03cd-08da3443d2e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sensor discovery fails, this means that the system doesn't have
any sensors connected and a user should only be notified at most one time.
A message is already displayed at WARN level of "failed to discover,
sensors not enabled".  It's pointless to show that the client init failed
at ERR level for the same condition.

Check the return code and don't display this message in those conditions.

Fixes: b5d7f43e97da ("HID: amd_sfh: Add support for sensor discovery")
Reported-by: David Chang <David.Chang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * fix some fat finger typos in commit message

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index dadc491bbf6b..1441787a154a 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -327,7 +327,8 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	rc = amd_sfh_hid_client_init(privdata);
 	if (rc) {
 		amd_sfh_clear_intr(privdata);
-		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
+		if (rc != -EOPNOTSUPP)
+			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed\n");
 		return rc;
 	}
 
-- 
2.34.1

