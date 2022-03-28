Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AEF4E8DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiC1GRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiC1GRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:17:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89182B276;
        Sun, 27 Mar 2022 23:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD5JoBUr3S4JW1SN1aajh9yS8z8S+VWoL7PdXpOcZFJ+inNLw72cSI+10Exkc7m0aJMDXEwWyKvONWBaLmL/JR3JVf67SlSi66lGmbdnA42eYGroltUN20VIgd6POriJklW5rd+w2KdMf/4GV6v6puRNUddcZhoP6Ue9N7tI9tx02DlKcbvbd9UrZRZCjvHkYO9bwx8qkt9Eln3S5XWxyCOadHYQ+HFUuDycXUB4F/icPnYnVUOkm2t+d3rQJNX4MGB7gdF5NXpRaAJJn9ZqKhq63YU2yOb2sVAeQDw4Ztx/1TQiO60iJQSOOigEIiLNuJSBB0KI2zg/r0i74CjEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkBYi7Bi/sHUSLsgRcl8X+ehZsFuG5iUJZzaW5Cb0po=;
 b=OMBf4LeKGV5Lal0mXvx0nl4ppWvQZwaJqi6VRRoBz4dp6dZjQMdEKW+L2r42cOKB6XoeeYg1Mfns/i1Mzu4sIewT4fo+xELvsLdfwmX1El31ZyyeZ3ESMOpyTSeYmb7VAE21ni5/aQDUHLLcntjolcTTxmEjei8OFLTYoTVdl04aSvrpAyspz3KMdHEVFaaSpP9/y1EGy1pVHL1Xasz34hM1gY+aTvHWb8sf/4rOZg27sajRJaZgbUygz9xBlS15zE+90qvD0+J+ktLI6DCAgVSzUSiPF/OnyDteZeVHsX/l2nKy6Y7aNdwR+aGyn3aDB6ovZb3McoKd7i/yBzeJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkBYi7Bi/sHUSLsgRcl8X+ehZsFuG5iUJZzaW5Cb0po=;
 b=qBPcNtK+gnIqkqtbGtR+9IToJxlmgn1u0QmQGJDZn2jgaCDOsu7/fSPiJp/7/laHQNyEFgj9dZbawzMBdOf4HXG883YzlXQovFdYZf4wDQpsK+ElDnTRNM9wcYyvKJesuoNIQJ5k+9RDLYMD8/pfCr9cqAZe1MEK460q6pzHTo2Lrz2XxLAdkIXXQlRRmlSDAgpeGFxDDewrRkFdzSuQn8ED51LaBor5xkcQ2AhqkeoMbGF5G1kKYQftMpYjAHg4WTUGITG2OKDQ8Ck0CG6vb02r1cdPr2lVcRbZy8tN+9gFp3NSlJfMW1e89YSJ5c1FPxdWCFuCAo8X0ZWTC77yAw==
Received: from BN6PR12CA0029.namprd12.prod.outlook.com (2603:10b6:405:70::15)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 06:15:55 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::2c) by BN6PR12CA0029.outlook.office365.com
 (2603:10b6:405:70::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 06:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:15:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:15:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:15:52 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:15:47 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <peter.ujfalusi@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <oder_chiou@realtek.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH v2 4/6] ASoC: soc-pcm: tweak DPCM BE hw_param() call order
Date:   Mon, 28 Mar 2022 11:44:08 +0530
Message-ID: <1648448050-15237-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25187317-a0ec-4c08-8cd0-08da10826abc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2379CF0304D5CBC378B83927A71D9@MW2PR12MB2379.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNa/xL/uNU/juMw9tV6U1iD2cHJWbCPX/StepQkzsL1t/3gyUh/Bul/lLV2qIqXX6n4yj0USe6pNdvWlvXCL1utziHkegnCvwq87Mkfbn9EFcj76PQqGtg1lx1EqwNixCvQ2ECKAzirCjWYM2WjjFvjZ7C+RGVjY6/TUD5ufR2NDZUXlAv1rnZ0s6+kZmVYbwbxMWyVe10352QJc6h6fZzcjzLzcgFBqhWFMFXCdOaCnarfq52iexPI6lWqvn6IgF2FOnVH6kXaH32+iVmDJnOY9aiXGcY0uV0VqwDClWmoNrEctNUpa4wZr+iiZPbUYgT35TV2pnXSapPEo8U7TuTgfEM8YT7ZqVbGBEctDVsMcW/Apau8loVLdFWoCvO7rQZ+nCU4OWHssT6albTOh4EbxsA/lo4pZGkerIL6cu/1rMB8SFGNQkk4vqDTK6pZXLiNL7OG7Xtzed+vPBJXqKUrpp9Ic4DVE24IRnaZXTm5/S+izGonJ/ziLsLumTosuFwuCOBFD+aC1NFfTdGV4mxrQqjC1YS5E4IN/rddYP5S1jUo7w0w66R7k6sm87c+wmtiR8vFB2eLPN9RYO84vWQYR1Whjq0ijF1XvedlxrZP010tKMJGv3uA1wG5DNtqlLXPQn6MKSF4KtDP2s+6m0uGZQCdk9g0jlDaCd1zrSXlEt/RLUfjWUf04CQXeXP+8aDwu8ESCqA3aQnyZu50H/A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(81166007)(508600001)(356005)(2616005)(70206006)(186003)(26005)(40460700003)(86362001)(7696005)(54906003)(36756003)(8936002)(110136005)(82310400004)(7416002)(2906002)(316002)(36860700001)(6666004)(70586007)(4326008)(47076005)(107886003)(336012)(426003)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:15:54.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25187317-a0ec-4c08-8cd0-08da10826abc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DPCM links, the order of hw_param() call depends on the sequence of
BE connection to FE. It is possible that one BE link can provide clock
to another BE link. In such cases consumer BE DAI, to get the rate set
by provider BE DAI, can use the standard clock functions only if provider
has already set the appropriate rate during its hw_param() stage.

Presently the order is fixed and does not depend on the provider and
consumer relationships. So the clock rates need to be known ahead of
hw_param() stage.

This patch tweaks the hw_param() order by connecting the provider BEs
late to a FE. With this hw_param() calls for provider BEs happen first
and then followed by consumer BEs. The consumers can use the standard
clk_get_rate() function to get the rate of the clock they depend on.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 TODO:
  * The FE link is not considered in this. For Tegra it is fine to
    call hw_params() for FE at the end. But systems, which want to apply
    this tweak for FE as well, have to extend this tweak to FE.
  * Also only DPCM is considered here. If normal links require such
    tweak, it needs to be extended.

 sound/soc/soc-pcm.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 9a95468..5829514 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1442,6 +1442,29 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	return prune;
 }
 
+static bool defer_dpcm_be_connect(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai;
+	int i;
+
+	if (!(rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK))
+		return false;
+
+	if ((rtd->dai_link->dai_fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) ==
+	    SND_SOC_DAIFMT_CBC_CFC) {
+
+		for_each_rtd_cpu_dais(rtd, i, dai) {
+
+			if (!snd_soc_dai_is_dummy(dai))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+#define MAX_CLK_PROVIDER_BE 10
+
 static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dapm_widget_list **list_)
 {
@@ -1449,7 +1472,8 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dapm_widget_list *list = *list_;
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dapm_widget *widget;
-	int i, new = 0, err;
+	struct snd_soc_pcm_runtime *prov[MAX_CLK_PROVIDER_BE];
+	int i, new = 0, err, count = 0;
 
 	/* Create any new FE <--> BE connections */
 	for_each_dapm_widgets(list, i, widget) {
@@ -1489,6 +1513,40 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
 			continue;
 
+		/* Connect clock provider BEs at the end */
+		if (defer_dpcm_be_connect(be)) {
+			if (count >= MAX_CLK_PROVIDER_BE) {
+				dev_err(fe->dev, "ASoC: too many clock provider BEs\n");
+				return -EINVAL;
+			}
+
+			prov[count++] = be;
+			continue;
+		}
+
+		/* newly connected FE and BE */
+		err = dpcm_be_connect(fe, be, stream);
+		if (err < 0) {
+			dev_err(fe->dev, "ASoC: can't connect %s\n",
+				widget->name);
+			break;
+		} else if (err == 0) /* already connected */
+			continue;
+
+		/* new */
+		dpcm_set_be_update_state(be, stream, SND_SOC_DPCM_UPDATE_BE);
+		new++;
+	}
+
+	/*
+	 * Now connect clock provider BEs. A late connection means,
+	 * these BE links appear first in the list maintained by FE
+	 * and hw_param() call for these happen first.
+	 */
+	for (i = 0; i < count; i++) {
+
+		be = prov[i];
+
 		/* newly connected FE and BE */
 		err = dpcm_be_connect(fe, be, stream);
 		if (err < 0) {
-- 
2.7.4

