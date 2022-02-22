Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE44BF847
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiBVMpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBVMpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:45:07 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B012558D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:44:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7BFvjAMyhWma5DbuWRKgfOhMPfvPPoVR+JyEFcKluShVyw9v8lJLaIJfo6LvFNkk/XkrQbO954sSGOL8PGMRBkygnxMY1TTykLh/s+uzRAfVGu1xOAx/OIHxLE8SRgGZ0X9vVfqa0gOitSOvb9ZNP0TZWsu0rlc2l7bxHvzmHoQuxGT90vdz54XvgSuCOysDy1dH+tRicllRreKhB8jDnGNts017rWBbRlzhuYUS1NYEAYoph5cB45wFdUoAdVFG4l4EUJUVQmdg+S4lqb2I5ORFJNhpI6L1OB1JKofxRpyPJialLINi+5MFB9+rFgPCE2IM2e3kve2mW6uOm4uhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiNSGGyM0C1UPk4vM3/QgttQek1MahQKX1tvma+NlQw=;
 b=nt2po3iSlTcC49nL0J133vNshwq7PKt4ZVdSPyASXgJZ5Vo/irGcsR0Zh4kKddY3Hg9AMvNaAI9OKfegKBw9dCAL86Ot8cBOvGVh6yqJtHcER2NMXrjyPFjGGB6GIkr3KYaVCbJhSbt3i4ELdxY5nWC6JgUgpmZCBr4DFQxLniA4JSmzJ6JJ0563stdV67zspHhm/S22Vx+duBLLOYo9rPQdEtGYa5nJquJo0fClPjH82/py55/Y0chIAJ6LamIr2hhW+EQ8UjohJijPe5q//2mM6fXvebtc/GjK9ic3uSRsUROFIJevOtMufvOVvIrId/3ldpdZOz9POHGLAXkGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiNSGGyM0C1UPk4vM3/QgttQek1MahQKX1tvma+NlQw=;
 b=tH4/ssTiNmd7okdtAEharfr+/Oe9NaTlDbFu4+Yywr7o9WyZg9UxdgVblP8Y6cX60TjdPChQKTiBxIGgZ1f8CJJ4wDB/YU8TwPt4o6Lxx9liAAjPlY66oZ5dhK/KFbdoivK4hVWUllZuEC1vfvH8zzZT6QLcrmyRqnlHLTCTFSo=
Received: from MWHPR04CA0050.namprd04.prod.outlook.com (2603:10b6:300:6c::12)
 by BN6PR1201MB0242.namprd12.prod.outlook.com (2603:10b6:405:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 12:44:40 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::88) by MWHPR04CA0050.outlook.office365.com
 (2603:10b6:300:6c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 12:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 12:44:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 06:44:38 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 22 Feb 2022 06:44:35 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "V sujith kumar Reddy" <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH  v2 3/3] ASoC: amd: acp: Add DMIC machine driver ops
Date:   Tue, 22 Feb 2022 18:12:13 +0530
Message-ID: <20220222124213.721224-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222124213.721224-1-AjitKumar.Pandey@amd.com>
References: <20220222124213.721224-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d059d31-2bce-4290-6c04-08d9f6011766
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0242:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0242DBD52B43F7AD30B64314823B9@BN6PR1201MB0242.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0iOlSROiRzrmCs7A86uASQLj0fK+7p2CdcE12DRlWuiqmFwEESsTwWtlttE8/xeMWh12YfrYWH4KA0i/dv70LH+t3d6Rc7Nw92q2+nCIwrRguuF3p3vadJicADP9IfuqV0OFcXWVzOdSv/iiS++wHCS03wpRIcNtiS8pZXxgrVWnl8v90jhb6mxN8OJ0ybGlvE4TdnNL1hM39h/mgl5rorXg3F3QtfPShc5lmG+dSSzArjEEjpAGSuEi36STR2wFvpZ19OjFpLLlGLtRrIjbIgvx5b/ljlKTyIiOACWiALNaLrVXPV7ltGgz1oxbOokCNxni9z3Owxk2j4n+5afef7eeVQ7CYMyqWkMhaCPkc1fjxijEnqSgoEQx3LTbLMywsW8+nz1WyL3P0fZ72+/4zRxOFHT8/6j0RXL7d59ioVz1bw2Llz5o+mRs9hoSl8TizoLLceEyddGrhZDSBfDnhWDg2lOMcdQOZMldISjzOJBiU+76IWiOCpiMxahfzViJT7MvJSrO9YLXzNxX2/HgvpxrBbkxF2gKIw6BFhZM45196G+oCjLRYr1E7lWMnzVpdrqa7wF71k2OTJu7eoBroBY2ZKzzHAHvoa9YppgjtL3toUqIzm5NWgRB9wXnlpxmV8WUrtehJ+R26B9P3OeGda4oLazICLXfSEt3HEL5vK4SbGJz5g1AUhiFWYFzMPHluPGoegxvL2dlXN4oCSDxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(47076005)(336012)(2906002)(36756003)(426003)(5660300002)(36860700001)(508600001)(40460700003)(6666004)(7696005)(26005)(82310400004)(186003)(1076003)(2616005)(86362001)(70206006)(81166007)(356005)(70586007)(4326008)(8676002)(316002)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 12:44:39.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d059d31-2bce-4290-6c04-08d9f6011766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0242
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmic ops and startup callback to add snd_pcm_hw_constraint for
pdm related device node.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index b45442a56c40..d3034ee2ff59 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -291,6 +291,32 @@ static const struct snd_soc_ops acp_card_rt5682s_ops = {
 	.shutdown = acp_card_shutdown,
 };
 
+static const unsigned int dmic_channels[] = {
+	DUAL_CHANNEL, FOUR_CHANNEL,
+};
+
+static const struct snd_pcm_hw_constraint_list dmic_constraints_channels = {
+	.count = ARRAY_SIZE(dmic_channels),
+	.list = dmic_channels,
+	.mask = 0,
+};
+
+static int acp_card_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &dmic_constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
+	return 0;
+}
+
+static const struct snd_soc_ops acp_card_dmic_ops = {
+	.startup = acp_card_dmic_startup,
+};
+
 /* Declare RT1019 codec components */
 SND_SOC_DAILINK_DEF(rt1019,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:00", "rt1019-aif"),
@@ -633,6 +659,7 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		links[i].num_cpus = ARRAY_SIZE(pdm_dmic);
 		links[i].platforms = platform_component;
 		links[i].num_platforms = ARRAY_SIZE(platform_component);
+		links[i].ops = &acp_card_dmic_ops;
 		links[i].dpcm_capture = 1;
 	}
 
-- 
2.25.1

