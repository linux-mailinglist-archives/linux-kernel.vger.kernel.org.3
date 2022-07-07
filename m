Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB12956A7A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiGGQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiGGQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:11:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02E5A471
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdB91tUdDK/50+CAuZqApdjS697wK8L8VOwiwF0h4y+zyiKSLYMsJKfb1LyttxAkZi/yIazhcXtgeHx8iQszuwV/wCOOV8GeCpklU2uV194/N/xa3kByaRKEcYQU2G2JOusQmYe5cCbWphMohFGmSVgpvo/136Zu/Q1R+fW7ekF9n7aIwI4aYTbSPuu10mRV++yOUBoQDJfxHDGoltL/H2x3ZMXtMB6LUnu42ZLbCs7oQA46BbWdrsHJ+rb41WwFx0r1Q9sRCYpnoO16SRGwF9FpS15Zz64DAkwkHZ0jhHhTOmQ+xO6AMFZ0k6HsFATr9AdfSiNSlR5gzL2aOjNfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1penL7l6Fn/cOMbmHfk1TSOTnTV+GjRuKj+LuNLWDkw=;
 b=nocnsS1gD7MWdyYrXB07c1osi0aWPHckcZU6Zw/rjcNiK3NMOgJ7xDt5w9+9ZkDoZ/ZScakBr7UQYcZiQvVm7O0mlXalJlRI32FvbDXAc1ULNMQLonXY3Msk58idifSxCplI/XDAJkEROlnDFU8puUjsybGgO3YSkUnbv+2vMgIqk1FuMfSSK5KRWkz95P5z9eOuRPs1nh56zuQBEmyKE9KuoPiL87Gnp2DqPppKVQod0EAwGIJEK85zVBsU3GsOrUxjmfRsXrJ+3MHnXTSsApvQ3qy2D4utc1yZTbXgWH35fT3ZIYvv1IYsWy4lJ9s4iGNj8H5y6VzHX+VnwMHqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1penL7l6Fn/cOMbmHfk1TSOTnTV+GjRuKj+LuNLWDkw=;
 b=GhOh9a43HDWP9/EEGmKgOmE7SM980u7dRfBQ8KThU79u9q7AF7cPevVDWO/VM+GiEOx4hznWq0pxmGsLA1oyyJvNNwrd1RwqPLpDmrxtUeRs2224SwG/5/cZ5HPsxAwlqd9Plw4ecrcf+u8qk/iUx72t3GkO9M0H6NF61sh7fZk=
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 16:10:33 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3a) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 7 Jul 2022 16:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.16 via Frontend Transport; Thu, 7 Jul 2022 16:10:33 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:10:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 09:10:32 -0700
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 7 Jul 2022 11:10:28 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] ASoC: amd: acp: Remove rt1019_1 codec conf from machine driver
Date:   Thu, 7 Jul 2022 21:41:40 +0530
Message-ID: <20220707161142.491034-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707161142.491034-1-Vsujithkumar.Reddy@amd.com>
References: <20220707161142.491034-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1522a0-74cb-4500-57d6-08da60333896
X-MS-TrafficTypeDiagnostic: DM5PR12MB1276:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ORd7WwBWYvvuT/jX2g9ik7ZyGif7hEZ7BgNKj+wnjMQnk52bjjaRIMiUYfcvv3f+rPVKTo9ts4kzivOU8rT3DtG7kiNpEMINHPndxijRqPFWM3zp37SaciQImrpnFismDokaYsDy0JfDp67UHl4bqOFWMh08SQCBTiOWdbB5G4TB/ZU3/1HGMiHCRvIxNhPUedVPxCK0D43buc9nb+Ygd9l42Ky1UZpOgpqiy7l4SJtIghd5ixRLNOdK+P/6ydkQQa+EBJBm05hle1exA6K5peKE3yIZxSo0KFbueVWtPSt9spZOpStoJJdGdcig2AVHrp3xWU2kYfwOGVQnS0HFeLw/rXHyCVLjpcOvY9ARdNt/V3jbKqNMg7QPdT15HootDxQ74JnkIpO7MUOfPO2jlcBMtG/YaexUqK5YWzGURWBbfAqsohbQZZJ7dHVUGhsW7UN+5vlmguGVf+gxvHBqk1YOAyJS57KURF9N8RbnSgkVnqVY3OQvxaDMIKfHBNPF6lAmpreyjf2WRLKSfTFebwWcNbj9c5/kj/eEj+yp3eRvs9YRNbOfr9mUS9/ZG2uauD0r/EgJdO2y9es4yC4kbZLht+iJFPD+mI39LeoyzCZyDSPsuoQLxnTJdUG5EFBNQ5DuxpAW4B90WBt9umIpwRpbvZRkHbYfx5/UWfGTYyeEjQgM2JAGAJc80tW5sAQmZNg89DQmAWmfaQ9O1huNI8Vweo7tRi6IhmN7DT2zX5DOPpeWKppUvtTRh9BF3i99NkYThFpfhXUCGz/DzUc+QjbUuFG1mVq7tW33tL3+IuJVWmO+7uSBGqofP5OWij+tzLUMUoPPNEO1/PHIe+AHXzTUGoDPQKEuv4U3XFC4xv9mvP5hvrBr38gzlOeiv3G
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(40470700004)(46966006)(47076005)(2906002)(40460700003)(34020700004)(336012)(6666004)(426003)(36860700001)(41300700001)(83380400001)(54906003)(186003)(36756003)(40480700001)(81166007)(82310400005)(5660300002)(8936002)(1076003)(70206006)(70586007)(8676002)(4326008)(26005)(316002)(86362001)(356005)(82740400003)(478600001)(110136005)(2616005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:10:33.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1522a0-74cb-4500-57d6-08da60333896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1276
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

