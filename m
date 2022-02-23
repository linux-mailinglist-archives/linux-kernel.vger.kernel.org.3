Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8544C0D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbiBWHYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiBWHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:24:41 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041D6EB24
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m87F0rRBu8WazUGIclFVSA+Y9bmucxiyBtLWCszinKiGc/8xGPljncisQt0S6y4KFh05ls0sL8aMTEVGmSTfBsza9h36L3dIbAutkslHVYF32OvYSyUmJCOw67/QSl+iI9jFbuV4bTM38OuK/pbcheKqC9wgyWGOEYBHshkDq+KfhAwKhJUiM4/m2iqC3GxoaChSvoxkqrCKzeD0gsJd5xTunzZkTU9LFSAtjzb+Gxg+M1oUDQX+Hx7iJkYUaisAhnIR/EgAfglzNzhVn7BMejYAyBnJmyUN9OW1yTOOu6ZOy6nIyoMVDlld0j55gGkGzDSqholzws0IhzErveNXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNRvlWPfQIdipH1qhAW8xKtQn594+8w0iwVdP6o9t1c=;
 b=Fvp+RKBlZAM3Oi/4ijMbLfdMfJgThD1rvyKpQ7L3bXZ+DrMjmk5I6X6xlDr/fAvWwvvUsFYQa8ZiWulxzBwpY48dBkIF2XczrJuL/6N8cGAJJbLLfunoD632rMeihEo12q35RcY79N8AamZvBHMlhtMFjuQZypq4Pp6yJXJ/hZmQpJuzJEiJ44JEYF1mvy/d4683PsUF3Q4R1/OwglO4mSveGsiQj5gxR6kv0rrG9sEpmufG1kvaiMAAR4FBmrRdMMxAG78bvm1LbnIWelUUGxfDK+4OBs/uKSBFxMaz/3I4RkSfjI3L9s0kr/r4slyyUJuM6+fbRqPXk9chOVxf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNRvlWPfQIdipH1qhAW8xKtQn594+8w0iwVdP6o9t1c=;
 b=ylc/ZYqqsehnN5wbPHcdqWyTMi3pXQQ6OZ7XIc6tQhvcVkdknr2+F1v+5wh4MhUyEpyaR3C4HKPB/JJ34ArKsxR1OmzNNxsBIUZkqamO+X5DtknjwWTt00QXTEVPlqkwY3t4B1yDYqGpzFovFExmGVlvCj/cTk6AUVWx3GdGhW8=
Received: from BN6PR14CA0031.namprd14.prod.outlook.com (2603:10b6:404:13f::17)
 by DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 07:24:11 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::3a) by BN6PR14CA0031.outlook.office365.com
 (2603:10b6:404:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Wed, 23 Feb 2022 07:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:24:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:23:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 23:23:45 -0800
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Feb 2022 01:23:41 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/9] ASoC: amd: vangogh: refactor i2s master mode clock sequence code
Date:   Wed, 23 Feb 2022 12:49:31 +0530
Message-ID: <20220223071959.13539-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3beeee4e-93a3-4b37-a62a-08d9f69d7cdd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB33560389FDBD75A24B5CF0E0973C9@DM6PR12MB3356.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPEFwL5KBLrnjxXKgcd22ZTmF85zntG/PrcJDsE5xpPikq7Vwn9iQdhbC7ZfoIt1BbKFS3GJiYZY2us9AB7s/9wGetTx3F1ECzFaH22vl4f123XCf2/yNTJM9pMubYesK2MhE2QF28mPApUk5ng7VKIYLBCemaPxtyZG7+VBncHzmOMMqKlfyCogmTZKh+gttolUJYA/WSrUrrXBBeJqDqYOPTTThntJKMZADaNTqCpSI7NzZ/QL62oED58PvNhOXT2/ExIipe1M+wBqL7x6t/ppqgEzL5OUtwT9i3zhgPpepMVABRC1twI48nK+M9KKoxaHL9k+rIm0OzI2CvVCdnt6qxE0/LVknKcnmzFSY8vsuHlHtRuYfz0P27xfgkN3MuVcYwydPeJnB6E+jLRtuIYMgjyjTW2tTOPNhC6MNxZaL2up2Z+S4auwam5SobckUqN5r9kx/lLFPzRc0xCEgx9OH8b2scbbbCQEjvI1w0Ol3+8gwBTVc0m3hG9syx+EyHcMBbh1pqj311vVZoYLBO2wYz75oS7b0T9qf5RvKtqSsjSfbh6qgJsMIwk6X8YtPLF8HVJ8vko2b7g9D+MHx+Cs5M1xE5BYHQHxNSE7IB1nZ4jQSAFzh04pTr5UKFC4T4JpGBOuXlYSxnTWvnLXm/HHY+TXWnR2SyxboIk2+4vKZhD0frXjE+NUvJTYAG9SV35J1B5//gAnBc1dCmk58Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(1076003)(5660300002)(426003)(316002)(86362001)(336012)(36860700001)(54906003)(7416002)(40460700003)(26005)(36756003)(83380400001)(186003)(110136005)(47076005)(356005)(70206006)(8676002)(81166007)(70586007)(2906002)(8936002)(6666004)(4326008)(508600001)(82310400004)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:24:11.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beeee4e-93a3-4b37-a62a-08d9f69d7cdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor I2S Master mode clock programming sequence code.
This will also fix the i2s clocks restore issue during system level
resume.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-i2s.c | 26 +++++++-------------------
 sound/soc/amd/vangogh/acp5x.h     | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-i2s.c b/sound/soc/amd/vangogh/acp5x-i2s.c
index 002db3971ca9..59a98f89a669 100644
--- a/sound/soc/amd/vangogh/acp5x-i2s.c
+++ b/sound/soc/amd/vangogh/acp5x-i2s.c
@@ -88,10 +88,9 @@ static int acp5x_i2s_hwparams(struct snd_pcm_substream *substream,
 	struct snd_soc_card *card;
 	struct acp5x_platform_info *pinfo;
 	struct i2s_dev_data *adata;
-	union acp_i2stdm_mstrclkgen mclkgen;
 
 	u32 val;
-	u32 reg_val, frmt_reg, master_reg;
+	u32 reg_val, frmt_reg;
 	u32 lrclk_div_val, bclk_div_val;
 
 	lrclk_div_val = 0;
@@ -160,20 +159,6 @@ static int acp5x_i2s_hwparams(struct snd_pcm_substream *substream,
 	acp_writel(val, rtd->acp5x_base + reg_val);
 
 	if (adata->master_mode) {
-		switch (rtd->i2s_instance) {
-		case I2S_HS_INSTANCE:
-			master_reg = ACP_I2STDM2_MSTRCLKGEN;
-			break;
-		case I2S_SP_INSTANCE:
-		default:
-			master_reg = ACP_I2STDM0_MSTRCLKGEN;
-			break;
-		}
-		mclkgen.bits.i2stdm_master_mode = 0x1;
-		if (adata->tdm_mode)
-			mclkgen.bits.i2stdm_format_mode = 0x01;
-		else
-			mclkgen.bits.i2stdm_format_mode = 0x0;
 		switch (params_format(params)) {
 		case SNDRV_PCM_FORMAT_S16_LE:
 			switch (params_rate(params)) {
@@ -238,9 +223,8 @@ static int acp5x_i2s_hwparams(struct snd_pcm_substream *substream,
 		default:
 			return -EINVAL;
 		}
-		mclkgen.bits.i2stdm_bclk_div_val = bclk_div_val;
-		mclkgen.bits.i2stdm_lrclk_div_val = lrclk_div_val;
-		acp_writel(mclkgen.u32_all, rtd->acp5x_base + master_reg);
+		rtd->lrclk_div = lrclk_div_val;
+		rtd->bclk_div = bclk_div_val;
 	}
 	return 0;
 }
@@ -249,9 +233,11 @@ static int acp5x_i2s_trigger(struct snd_pcm_substream *substream,
 			     int cmd, struct snd_soc_dai *dai)
 {
 	struct i2s_stream_instance *rtd;
+	struct i2s_dev_data *adata;
 	u32 ret, val, period_bytes, reg_val, ier_val, water_val;
 	u32 buf_size, buf_reg;
 
+	adata = snd_soc_dai_get_drvdata(dai);
 	rtd = substream->runtime->private_data;
 	period_bytes = frames_to_bytes(substream->runtime,
 				       substream->runtime->period_size);
@@ -300,6 +286,8 @@ static int acp5x_i2s_trigger(struct snd_pcm_substream *substream,
 		}
 		acp_writel(period_bytes, rtd->acp5x_base + water_val);
 		acp_writel(buf_size, rtd->acp5x_base + buf_reg);
+		if (adata->master_mode)
+			acp5x_set_i2s_clk(adata, rtd);
 		val = acp_readl(rtd->acp5x_base + reg_val);
 		val = val | BIT(0);
 		acp_writel(val, rtd->acp5x_base + reg_val);
diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index fe5e1fa98974..b85d3ee369a3 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -105,6 +105,8 @@ struct i2s_stream_instance {
 	dma_addr_t dma_addr;
 	u64 bytescount;
 	void __iomem *acp5x_base;
+	u32 lrclk_div;
+	u32 bclk_div;
 };
 
 union acp_dma_count {
@@ -191,3 +193,30 @@ static inline u64 acp_get_byte_count(struct i2s_stream_instance *rtd,
 	}
 	return byte_count.bytescount;
 }
+
+static inline void acp5x_set_i2s_clk(struct i2s_dev_data *adata,
+				     struct i2s_stream_instance *rtd)
+{
+	union acp_i2stdm_mstrclkgen mclkgen;
+	u32 master_reg;
+
+	switch (rtd->i2s_instance) {
+	case I2S_HS_INSTANCE:
+		master_reg = ACP_I2STDM2_MSTRCLKGEN;
+		break;
+	case I2S_SP_INSTANCE:
+	default:
+		master_reg = ACP_I2STDM0_MSTRCLKGEN;
+		break;
+	}
+
+	mclkgen.bits.i2stdm_master_mode = 0x1;
+	if (adata->tdm_mode)
+		mclkgen.bits.i2stdm_format_mode = 0x01;
+	else
+		mclkgen.bits.i2stdm_format_mode = 0x00;
+
+	mclkgen.bits.i2stdm_bclk_div_val = rtd->bclk_div;
+	mclkgen.bits.i2stdm_lrclk_div_val = rtd->lrclk_div;
+	acp_writel(mclkgen.u32_all, rtd->acp5x_base + master_reg);
+}
-- 
2.17.1

