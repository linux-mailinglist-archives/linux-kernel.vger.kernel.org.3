Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08714DCE65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiCQTET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbiCQTEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:04:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064888EB4D;
        Thu, 17 Mar 2022 12:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keFBon2DW/XIf5LBeuvrABTV+FncyRwHCcXBskTzECZvqARudi6VmR7KVH4APysZ4ZHLrwVamOThaLXtjSbeybNrcQNlqvlfAsh7PVnxot3A9/4XDbeWuqpfA3auPU0nkmaO6hDKKDIgEwgXBcR7tAiMa7MNmNB2XbWGvaT7alqif5eX3TygZ8/mmNh4RX9QHjGzWN4z4hepQ3v5/xFdmP7JA2m+DgIer0A7gITC4nbxCRlF03BGPHroZiXKFim4UCsQaD/iMEHVKVwkPUltSBB8bV7oO7elALOI2nVjU9N0W564TQjxK3G4xmFWYJrWILTkMUp3tMoAKikbniqdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YZCVAS13XWCqAMMjziu03zE/mjgYzF+1js3HXAwLWw=;
 b=l7cwF7FDCUalZuYWC+dc/zvSFe7AHTmbNMLCG6DVpxvmYR4wW382Q9M5jS4vrZxQfGuHsOlCpFMDfzgNX1cNEklC+ngGhoyJ4s/gLExNEw+zcuVv4MQCAKGjJzesxkH06XrEBG7oNc5EN2m2vK5eC5e5dxxSZpkVY3t96Gs9MB2Sk33skFDgz9p5RHkpxJlgPgtq1qByoM5gSpcvc28h1XGBCrUYVJQcKiEnX0HF0YanmDSnsvXLPosvSuEEn/Y5OsI4V+AoUTsKrnQ1jM+eVJA9i/V8YJkXLoi3vexh08Eh+s8kYp4CMO08N7o0YvlpVHh2Moc1pmKi3ahtw3yhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YZCVAS13XWCqAMMjziu03zE/mjgYzF+1js3HXAwLWw=;
 b=RjB6lpQMOlEt65+InB1djvReGmMTSrcsW/q5lPqnZ5vKVf3hrxZoAYpoNSQEZHbZEnnrK5kp0y63+4Qo5umfryLE2pzx46XVJCRSXUeBJAAOVcoTSqXl8kW0R5kQgeSEekwnlNhf+u8GveDem+RsMRqYUFsWY15ulJaopXVKuBQ=
Received: from DM6PR14CA0039.namprd14.prod.outlook.com (2603:10b6:5:18f::16)
 by BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 19:02:56 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::40) by DM6PR14CA0039.outlook.office365.com
 (2603:10b6:5:18f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Thu, 17 Mar 2022 19:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 19:02:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 14:02:55 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:AMD PMC DRIVER" <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86: amd-pmc: Only report STB errors when STB enabled
Date:   Thu, 17 Mar 2022 14:03:01 -0500
Message-ID: <20220317190301.6818-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ffd4426-876a-4330-3efd-08da0848bf28
X-MS-TrafficTypeDiagnostic: BN8PR12MB2946:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB294607922464E2673A983C85E2129@BN8PR12MB2946.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8VzkrPt32UskhykRruL/F1MFVDvuZANzOckTrJ2LBvKuZ+kG6M3rK3dtgi3g1X6uj/PnDi83hZJKLl2d+qoRnG+gytCIYb7iuBspJnf3C+t+bTykQBY8vwk4GnSBjhBqaZtAE7p/B65eePJOTsUKf+TBkdjJgdwstpmxKaGJeK7q+Mq0tfrKjtWH4T2uLy62q3zXF5OE7vPUApuRHHh8CYYe0tfekeh+estzx/uNJwsM+9V2KhXotEtqMzVGzlexuKGnQ1SJ7x2SGqP2xeLUDethKcPgjgocjOZI7SSPjXYzG3c7LDmJF8Aa+sVvCgTPtZg6aAyjiUQ9RBMu53hBOeObC90qDmttUmx9oUka3RXqGs4LQNmKBIvmv7J3SUqJDBacHeGD3vAimFSknT+xhY5wTmEjl0DN1/zYEDg4TB5YloprTE1S1Bl6vP6Ixzu7gAMLKsEyi+6uSI86wajEB5L7zeB6TrOo7wEFpownh4OveOpxcK/MbbUrVnhhxJt35jRHIfqf55R9UWXVmk69IxAw0OsJuH+yBV2yKaFibgrCgqzH4ixPZVY2nAU5yyDkvIFry7W3Uu/uLYzBx/uSyQvfhgSEvz15AUlQei13fLBHUj/5kvJONlUybZnBj0G52lwm/B6XkUUp1tgXYQpgyVxPxi/4N+bqGbYPxz+HT1HoWbVLdkouk9umiRrc5HyNIzWzVP1HuT+GTE4mQ59yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(70586007)(70206006)(81166007)(316002)(110136005)(508600001)(86362001)(36756003)(82310400004)(83380400001)(40460700003)(2906002)(16526019)(426003)(2616005)(336012)(1076003)(186003)(26005)(47076005)(8676002)(36860700001)(44832011)(7696005)(6666004)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 19:02:56.3162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd4426-876a-4330-3efd-08da0848bf28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if STB is disabled but an earlier function reported an
error an incorrect error will be emitted about failing to write to
STB.

Correct this logic error by only showing errors when STB is enabled.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 7317993cd91b..e9d0dbbb2887 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -655,10 +655,11 @@ static void amd_pmc_s2idle_prepare(void)
 		return;
 	}
 
-	if (enable_stb)
+	if (enable_stb) {
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
-	if (rc)
-		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+		if (rc)
+			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+	}
 }
 
 static void amd_pmc_s2idle_restore(void)
@@ -679,10 +680,11 @@ static void amd_pmc_s2idle_restore(void)
 	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 
 	/* Write data incremented by 1 to distinguish in stb_read */
-	if (enable_stb)
+	if (enable_stb) {
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
-	if (rc)
-		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+		if (rc)
+			dev_err(pdev->dev, "error writing to STB: %d\n", rc);
+	}
 
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
-- 
2.34.1

