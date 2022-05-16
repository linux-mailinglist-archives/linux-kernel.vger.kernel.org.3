Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64CA528979
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiEPQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245296AbiEPQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:06:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE0BC0A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIH+lSYhgI1pf1gRflmGMTMvzD5zEFwbQJjddVXZeldbNESNBSycdUl6000gFyi2XOfvziFigzE4ZYtDi9IRoDhMlQosWvrrpUxvUPU5VUwESlyXINIgax902uFTuCqJiX7yXA3xL1A0AvhNulioiefnSXyd+/bSv8OV7n5EwjVY/TNc3a/PALy9+F9J3lju+gcmxt+a1+Guf/FpmNWWiGjsUiBJ8LowsOtwhq0s/13USx9qBV1rAmuWugABNKaJ52M9BKLiMKzPLZE1MFIoOy4HFt+STeVRBIxlOP+HiaHDyPh+40o975gBoMo8rtweBokoTQqJ417YxGUXka3eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqAkpoJWpLRnjjfnuKnFgR4CnuxpYKWLVl7mvSaDMv0=;
 b=lxLGmU8Ws56nTGlgGXcIilMvjCBAEo4rZkTiGXk5LxzpbqjqdheKsrT0HQee88HTf89ppyyad/WzlmJiV1bvnC4y9uYrqggQaYXZtjeXzmfmXGgtdv7Z9FAWcu+bFLttC5HwCmCGt8SUROSU02So65ZhsKOZBOBfJa0fO1tdfoG8kZV4g7JONWS33vXZsGLPeMywKF2Zy6gtbhlEEIE7TQ7nunFl8c/yGzuoj7wpjoviSLL5nObLb9bILKwu2oM1VWNxvoVKM+tz2dUASA0lGhENBMmdMJMCMvqrc1Ve6h7YyGNqd9weHqyOeH5dmNBe6MzK0P+GM4c1E1NMY3wjjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqAkpoJWpLRnjjfnuKnFgR4CnuxpYKWLVl7mvSaDMv0=;
 b=qSkafjHVuvB7AKmkIIaIkDup7gUDCiUSMLSVrB8MzsIdnbhBPWQIST2ypbEUbE1lJ+7e4GmRZE/gBp/9HhY91LlJlmyM2cfy02S0OOWZwTRLUSdVAGIru0h3CKzjZx0ymJ21SYburvZvWCDyCwiGdnUhWCJH72g55tC6tNllt9Y=
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 16:06:09 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::a) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Mon, 16 May 2022 16:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 16:06:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 11:06:07 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Mon, 16 May 2022 11:05:59 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <ajitkumar.pandey@amd.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] Revert "ASoC: amd: acp: Set gpio_spkr_en to None for max speaker amplifer in machine driver"
Date:   Mon, 16 May 2022 21:36:09 +0530
Message-ID: <20220516160619.17832-1-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8476e5-4ed9-4f02-df81-08da3755fd82
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB511946CF508008325D82A73092CF9@DM4PR12MB5119.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fXUeTm/Pbqu/WS2/M1m0UKUv9A4xuyQ2JDeBrYJYINwaNSc4M5s9d4LCUsR8bOaoDv7x+Vtj/6b0cfpr7+l/JjawJESFw183ppEc0QCUXMr1LSlgXLyrruo2B+vgCvlE9n52lXigDofvhrJM0CuLBwCW/EIalbhLEkDqG84nLQQJlneEO9doyFZsAgp9yvXEyJr6/eZcQv2Z8k2ngfO/fnfyE1rTnEde2DZnuU3kvRQicCtHhMDdNRqy4Lz4Fn2lw0mbvOMAKRXmti5P5OUX9TLI0I7ErPJ5TjpRctfCQGMDt2VJvwS23ivLtbGMgBPyAo1HLXpCNijJgRUT3IkgBWDo4P1rsFTEgDYSDL+MOrG3bDRngRiWLoDHAT/NBsFC6vXfMPy3ntM8YYXbyML/YJHqgevphAhnzm4Ulw9498Kz2Ms9qUnTQtEk7HB+0kAS53o/LUtnBKfwLESXG163NfAXhK+QpGZ+PgP9J6a2KphsC6fRPbGuYs+O7Hu7Yis0ybCMYMgnxbMs6qtGX+p/8vbJooX6/vo2w3W1WiYbcERoTU3qoMB2EUkXKEPRsnh+XMSePOlyYmIchMfB9RNi+Wruyg/WVeh8TslBgl8xVE3xuN+3DTEEPcUyjB0LryF16GFOLObs3j46EKrQ4K3+5M+KZxd47gHiLt/KL+p6dhMJQIhuQgSSVztpgE/TciCzyq+76S/SB+1keOSU+dFuAFLhujN0zWd+lNGymZYmuPgNt+fyIeo0T3E5e4asuqe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(426003)(6666004)(36860700001)(86362001)(356005)(83380400001)(70586007)(70206006)(82310400005)(7696005)(2906002)(508600001)(336012)(81166007)(5660300002)(36756003)(54906003)(1076003)(8676002)(40460700003)(8936002)(110136005)(2616005)(186003)(316002)(47076005)(26005)(461764006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 16:06:08.9275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8476e5-4ed9-4f02-df81-08da3755fd82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC: amd : acp : Set Speaker enable/disable pin through rt1019 codec driver.

RT1019 codec has two ways of controlling the en_spkr.
one way is controlling through gpio pin method the another way is through codec register update through driver.

Now Speaker enable/disable is controlled  through codec register updated by codec driver.
This patch reverts gpio logic.

This reverts commit 7fa5c33d043160eba3be9fb8e21588dff2a467c7.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/amd/acp/acp-mach.h     | 1 +
 sound/soc/amd/acp/acp-sof-mach.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index c855f50d6b34..fd6299844ebe 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -21,6 +21,7 @@
 #include <linux/gpio/consumer.h>
 
 #define EN_SPKR_GPIO_GB                0x11F
+#define EN_SPKR_GPIO_NK                0x146
 #define EN_SPKR_GPIO_NONE      -EINVAL
 
 enum be_id {
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index bf61a1726f0e..8243765d490f 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -37,7 +37,7 @@ static struct acp_card_drvdata sof_rt5682_max_data = {
 	.hs_codec_id = RT5682,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_NONE,
+	.gpio_spkr_en = EN_SPKR_GPIO_NK,
 };
 
 static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
@@ -56,7 +56,7 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
 	.hs_codec_id = RT5682S,
 	.amp_codec_id = MAX98360A,
 	.dmic_codec_id = DMIC,
-	.gpio_spkr_en = EN_SPKR_GPIO_NONE,
+	.gpio_spkr_en = EN_SPKR_GPIO_NK,
 };
 
 static const struct snd_kcontrol_new acp_controls[] = {
-- 
2.25.1

