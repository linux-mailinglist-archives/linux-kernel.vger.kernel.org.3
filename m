Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446FD55A20C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiFXTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiFXTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:47:32 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE1382690
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc9OOprB1q/NUhQAnCaiYq0S6GS83MOWoJcjQxHDqDm90kgBsP38etPgwr72+bhqEZgJcamI1XRVJUi9HkHaJsJNZVrN1rz01cssQS62TOJHigzxDVKC/9UrY/ffQjUBTFs6efqAHrdhi9kJU7SWJ635fxCDmuC4mu6TNdWOWZYvRf+JRvNlqLVY2dQKqDvDCnOBAK5oTP95wJwgZ5ORVaEN2lLJ2UkrTokdgvP7PahCvNyfMli3jVZEbJOXg5t/leRBl+E/zvWmGPQRHFI+Z24vTRSjhPGa0lCzmb6c6F+NXbF6q3wgjCDgUt0R6Oc5eJ5mwZsCujSsgyyi4yE6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1penL7l6Fn/cOMbmHfk1TSOTnTV+GjRuKj+LuNLWDkw=;
 b=Goz6DyJ1L4fdzvTPBeWb+iRfLUfUvoNg4AyGwz9R44KpH2M/J7zjILa+i/VetTg8Vd3FXaFg8j3xmhFlJ8p6mxa1qKMqqjeJ29xKxnrvZmsZ7FcIGpnHXfrPl7xcJFn/x6sjXF7BWqVot2Yr7omNRYmhYnbPVPPw6PTajO5QNZSN/LRphZqvsDyy9WLwmy4xpMWwxacSaBtSUO7Gy1lZuc7/8FLnYYaXpFgWrcQy0BPujZlXjSzyBo2iY4ufiRUEuiHwiyHHZk1ULFiT/U90HHW2mWnDzlU8g7i19b31RUWhFak5YdNXuiX83FgUzaPEdbsgGYIrRHjeCADddf2g6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1penL7l6Fn/cOMbmHfk1TSOTnTV+GjRuKj+LuNLWDkw=;
 b=oiIkZQ/fCejYqnpZ2mqsMrRsy4CfjSW9087cb/uz//4O7VU7NhJBTuW+senHRenG2Zo7emv3FXXewv9ORW+NcrP1giR0qd9o11VQw+Cec7X2VCsnNUREfsEmXMwrhSh/SadErWZkV83IxRB8zc3ITK7lqkGUB6Xnv63O0ujVqPA=
Received: from MWHPR14CA0016.namprd14.prod.outlook.com (2603:10b6:300:ae::26)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Fri, 24 Jun 2022 19:47:28 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::88) by MWHPR14CA0016.outlook.office365.com
 (2603:10b6:300:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Fri, 24 Jun 2022 19:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 19:47:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 24 Jun
 2022 14:47:27 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Fri, 24 Jun 2022 14:47:23 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: amd: acp: Remove rt1019_1 codec conf from machine driver
Date:   Sat, 25 Jun 2022 01:18:19 +0530
Message-ID: <20220624194821.287462-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624194821.287462-1-Vsujithkumar.Reddy@amd.com>
References: <20220624194821.287462-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47cbb6d9-1bfe-4cfc-8b4b-08da561a5ece
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZsNDNXZEmwsbcf2hq5pR1cY98ljkN/73zbYteDYuTDmM0JcZ8kja0OdnkyPJreMg6nD34kUfB0JSifdQrVw3GFOLF5saBNX3uGREkzwo0sN4d/igFd6S4juaRoqHoRLi+p096LMv5vdUKWT+WQxv6gJqTefKc/1GF1nRTRYtOYZ+ZdsHRnQzH8I/PqRcBFT0aomCFEATznaXkp7vygwIYxY4h+Uptfhz1m6yYb66dUTMrk0ElitRvljil8HuE8NQb86UucDSw4kVDuTSh/C6xsw5j/lHD2SGxqfQsL2rhWRMO0FVlNmS9km3KrWEfzW/sDMsaVNy5pmBq9rN2HtXtgW5XANMwzjp882Ogxw1SJyN/D0U7J7XhfotZlqhNa0VwUKT17r1hLOkDkW+l4aVKGT/cnUJ1d8dNjxtSyKX6JaRFjIjm7THLvCaS83E1hG2NCqDWm9BLtRIwCRrmcnT94rSVFeuSPoIrLqRCIs0bcPR+exHrTPoKfnpR/qDMNV2AMRB0UjP8W3mjhFUBDdUkW/z1HsTOJhJ2Z4Vsl6IpyG8U40a0ui8DinX0EuoeDsIERZCo/XdnWM4uv8iNt3SedlrA+pwp65Fb8CLrRi4SUuTQGvEV8k1YEc8QoKsGCOokwv1IGMpgdf5uB1L1dS9tYBM6fw/ZQURZdnSIQKh+MOylBtcS+5tlSfc4uosbBStyYBNI5n6yo6oujX2Ec9qqYq5ikA+vHYgMoRIoFQZVHUVp9wR7RV40e22UDwqz+e8ufWSIKkOb464CBdtIopTDUonKahndqn0Cau/KQL6jVYXm7FYDXweoSpFEdWveVpQhuidwEFmk6A3v9QKsShCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(40470700004)(426003)(316002)(82310400005)(40460700003)(70586007)(47076005)(26005)(40480700001)(83380400001)(8676002)(1076003)(110136005)(186003)(336012)(36756003)(82740400003)(70206006)(5660300002)(2616005)(7696005)(4326008)(8936002)(36860700001)(81166007)(2906002)(478600001)(86362001)(356005)(6666004)(54906003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 19:47:28.4204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cbb6d9-1bfe-4cfc-8b4b-08da561a5ece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rt1019_1 codec configuration which has i2c-10EC1019:01 and
i2c-10EC1019:02 codec components, Now Using default i2c-10EC1019:00
and i2c-10EC1019:01 codec components.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 7530cab24bc8..86145398fa25 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -313,9 +313,6 @@ static const struct snd_soc_ops acp_card_dmic_ops = {
 SND_SOC_DAILINK_DEF(rt1019,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:00", "rt1019-aif"),
 			  COMP_CODEC("i2c-10EC1019:01", "rt1019-aif")));
-SND_SOC_DAILINK_DEF(rt1019_1,
-		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:02", "rt1019-aif"),
-		    COMP_CODEC("i2c-10EC1019:01", "rt1019-aif")));
 
 static const struct snd_soc_dapm_route rt1019_map_lr[] = {
 	{ "Left Spk", NULL, "Left SPO" },
@@ -333,17 +330,6 @@ static struct snd_soc_codec_conf rt1019_conf[] = {
 	},
 };
 
-static struct snd_soc_codec_conf rt1019_1_conf[] = {
-	{
-		.dlc = COMP_CODEC_CONF("i2c-10EC1019:02"),
-		.name_prefix = "Left",
-	},
-	{
-		.dlc = COMP_CODEC_CONF("i2c-10EC1019:01"),
-		.name_prefix = "Right",
-	},
-};
-
 static int acp_card_rt1019_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
@@ -716,10 +702,6 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			links[i].init = acp_card_rt1019_init;
 			card->codec_conf = rt1019_conf;
 			card->num_configs = ARRAY_SIZE(rt1019_conf);
-			links[i].codecs = rt1019_1;
-			links[i].num_codecs = ARRAY_SIZE(rt1019_1);
-			card->codec_conf = rt1019_1_conf;
-			card->num_configs = ARRAY_SIZE(rt1019_1_conf);
 		}
 		i++;
 	}
-- 
2.25.1

