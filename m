Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2FC47C4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbhLURTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:19:35 -0500
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:15073
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240304AbhLURTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:19:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQHes5i8jOjICQAo31TIGLvuSo5yRX9DZM93+NJXEvzMvIprnqbErP8OAsgO9+2miip9DyXn1Kx0mnCKBTbIZP2aNeYhd8JP87jlZl8Slz2D0gNmswrs73pRYlBv4L7hTrAPXP7KGkfwFLv4bHAa9XQImIgxiuy6RmnqW3cvmpHyjxOsNnTZmbM/GwLNPD/lKfJIayH8uwdrM217ILncDZVkSdLmRJ8gOu8Ndbur3+ht54eEOsVMYTVuAZDIdR6ZGqOZ1O8ZEyYpwfiMyBEhMdkY6aN3RPIdfoLMskH+dZjTYGifOU2RQDV+EG6TPjnYCptDAS6gdN831IzsheCbTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRhvx5HVyPvEJJU/a6Uhp135SVr3xPHcWh82ZGyb/tM=;
 b=R7uLWheDu8y+UZEwGOGJAvGdM3tgRGyAfnym2CZUBn9xegx6OrMJvRdDyKOaNU2wlQvWLsHycTZLYiZmyKqhrPKSo+lJ7FvtrM2EbdwjGGHtICkwHjL287TrGN9jbeKYUmugUKR+UCd3SqRGFLK73IFD83hUrd/k7JllwHYKQUK2uIA1TLmxpk76cPu1okyJ1MTUjLrDUCOClh9YWPO8t6X4/YNOae+mJ9G2KKSqgsODF3H2IalfAj51EQc5xGkUu9o18VXFJ8A8HFQQYHzLqMEgpusbLOTzyQ1CnAEeFq7qSP4SSCEHTqEPC6LlxK/c89TVREed8F9Dm1HuoR12Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRhvx5HVyPvEJJU/a6Uhp135SVr3xPHcWh82ZGyb/tM=;
 b=Tr7hAdyPy3A79/zHOX0Ah+1E9BASpv3pncYdR/g6mt898T/gCulHqGW/u0dsGiYPPhu15LKV28a6RqF32slGpczR+dZ+t7Zn93o58KwlWP7XrwNn52hFUOdn0sdZYGTnztFPeclUa/eDpzLs49lW6wdK2rRdtTDIWsRJ4vJg8Xw=
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 17:19:32 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::5f) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17 via Frontend
 Transport; Tue, 21 Dec 2021 17:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 17:19:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 11:19:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 21 Dec
 2021 09:19:31 -0800
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Dec 2021 11:19:27 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Remove duplicate dependency in Kconfig
Date:   Tue, 21 Dec 2021 22:49:10 +0530
Message-ID: <20211221171912.237792-1-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022cf220-c8f9-42f6-e998-08d9c4a60dae
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB50461DB427630E114673B012827C9@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMRRURdoXVI9m8t0p7In/yZyZY0wFdJWuz0V8mAVJsY3mzorVU91VsmpLLSxRaGYO/VAUVay7+aBLCg/mJl+3c/C9k2KHOLMu4a2Jdm5qqK1gKyofNtq880NbbsFVbdezvtrf8+Rr6PzInZPZzktnaprLoput3VPjET01U1u1yBjOfO+ORctXu1yyso9d/obE4qqqftVr4yQk28Pp0zMu8S6bUhQEM3dCIK2nYh8/Gah7TfnN4bqM/RGs8SbTf4DxO8tw0wEF7jqpI/EEc6s3Lw3KA2yXNod3HaJLmTYkQQr9jKUQFiun2Chb8bf8AScn7Ng9erX0qcPzwzngMqBwaweRzJqFmLbAngDNwfI4FBCm2Zn5DPdyYEwtcSIK25Q9E86w9a+t4Bz2UbE7beGfHH29xVCfTsIRR+vO5lKaXBWGX7G7ubJcuPzKjTdyhCh1BfWUtLnZhMjAYpCJM68dS/+pwdEbm4M3ZtpmrFbc6hzvpwpCzd+ec5GvQXjcrFPF48K1Ij8scA3IkpwMT+jhJwjY6dMI13cB2NJrJ85f2YSTw24kBlTSEsSq01XCuzEsp0l5CNcydwFZTiAn0+YryxWFyDkSyOUhCCr+mgvgNyA1cx4x0zxm/LJ/KVX0seEpqbuFEQO7/PwfSC4daU3l6hd8Eg/rUnH/s7GUbg5l4Ve9FSd9BBy3KcdgUzGEtjOzCX240zZMxoJRPM5uxV/uoFEOCsiJ684noySvyPY0n7/poDoKa0l5ftL9cpdM1cQ1ZaaOp52UIxQTJLoTbhYe5kfBnDx4x/JxFvn+yO+LP4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(70586007)(336012)(36756003)(5660300002)(8936002)(4744005)(2616005)(83380400001)(70206006)(7696005)(2906002)(508600001)(186003)(47076005)(316002)(4326008)(426003)(26005)(36860700001)(8676002)(1076003)(81166007)(54906003)(86362001)(40460700001)(110136005)(6666004)(356005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 17:19:32.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022cf220-c8f9-42f6-e998-08d9c4a60dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate depends on statement in Kconfig file.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 52a1371f9e61..154be5e70821 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -46,7 +46,6 @@ config SND_SOC_AMD_LEGACY_MACH
 	tristate "AMD Legacy Machine Driver Support"
 	depends on X86 && PCI && I2C
 	select SND_SOC_AMD_MACH_COMMON
-	depends on X86 && PCI && I2C
 	help
 	  This option enables legacy sound card support for ACP audio.
 
@@ -54,7 +53,6 @@ config SND_SOC_AMD_SOF_MACH
 	tristate "AMD SOF Machine Driver Support"
 	depends on X86 && PCI && I2C
 	select SND_SOC_AMD_MACH_COMMON
-	depends on X86 && PCI && I2C
 	help
 	  This option enables SOF sound card support for ACP audio.
 
-- 
2.25.1

