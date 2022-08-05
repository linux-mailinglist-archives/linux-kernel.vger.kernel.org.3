Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102EC58A5C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiHEGBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHEGBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:01:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2383113F73
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcLFoBbeRu9NFpSYRmeTXAGZVwnJD2kmXYriimFzEISw6ZNZ4xYu453wjAmdEfCm5eKa/r8uyHO9qiQNdP4Ykslwt7dfHML7wk15i3MdaRTcFcwZsDVcb2cU7YKQQbDUyn7wPSHHKNdjBXGwi1pgNohnLov8deTPpmIeIBcNb2aqUCHWREGib6iyuz4rzRVbeT39upMSDVGKVonyX3OiMPVrBSnfKI5tci850hfJSfXwcsIViueVJKz39a+QnDibTTR8YhXWxYug4n/625MfSaoXbhUqe6DrwIQRewoaydaUc4Z1rqMS+/LXaTUcVd5UlQAu8N6UnK6UZ+wjiXzzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/ZYDF5uOdPvyZx0MrmlhSPuSLml4aoifVOwujBthms=;
 b=QVwJUzn+PASuAO3opEWCjDYNPgBCmwspI0gRe3LlF34+zZN8AlWGWo17XBl41pq/1jT3le+thg688z4j2Pi1dm2ouG7tQaUf4M0FxAzw0tfz0xbuzIMEwxcLR4hsV9JX0GU+f0sYOoIArRmJMzFbtFIJyh++bDit36Npd1yyop4Yo13pWfbxc/KnTxjyI0/+EA6mzXyZoV/wSY+7tLGxDSuFP6AQtAHsE7nwFNNVu1FAukohlvhQdymTuSZCk4A3Mmg+fn7nQbgNFV4nLNGEbigUKLKhIM6tz4N+n+e5IQUS1QXR/uozxnmW0fcs3fAgLwyGHEAbRxuArOQ2w0tJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/ZYDF5uOdPvyZx0MrmlhSPuSLml4aoifVOwujBthms=;
 b=Llwja9AHrnbN1g4UgTyUhMCiKk5cE0Cyg2Nn4wMaYP0uQCXNQNvbKct81tputy92GvChcH+BGb30WofX8uBboMP/VoMGLRnRf/fHSSS5hhsqlBI1xkK806a0akGXUfleqQkvcwhk6obKGGtp7XcLvHc3Vizc7SGDXiWUbfq/fcw=
Received: from MW3PR06CA0010.namprd06.prod.outlook.com (2603:10b6:303:2a::15)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 06:01:13 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::cb) by MW3PR06CA0010.outlook.office365.com
 (2603:10b6:303:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 06:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 06:01:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 01:01:11 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Fri, 5 Aug 2022 01:01:02 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: amd: acp: Add TDM support for acp i2s stream
Date:   Fri, 5 Aug 2022 11:34:12 +0530
Message-ID: <20220805060420.813053-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210c6c59-055e-4677-8a7c-08da76a7e6e8
X-MS-TrafficTypeDiagnostic: SA1PR12MB6703:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6StbtSMYacWG1zj8v3iqXre1/O7kgQCfb+pCGBIO78pyCPAVYkcPFwbSJmgNTficzcvMq4z2RwHJ0oZnI5S9ESx8Mnr7sNP6sIesOMA2Pw9zHks8o6b8gK+zM6npuTLkSyGB7B/59QBZAwz3JqZJ2+uKsgc7+t+RiH+DIfSJ1w1+MLU0/H5LoihlLB2PIZZWeYZdVlt7pOL0IHSlxjGmH51kSs3P/DMoqQQrtdPZhwEU8VMDjyaaTa3d5k/+nc3fQDZGVBz25baCPVRG7rpS7nZJjSi0PIejfuw1ivUEnB/IJfRUnQbTFrliEG4WM938RGQUprWAqzeIPtVCtzGR0ztjxm+nqctmSQcoPX7CMhWYLfPMsOd5EutZTd+EsibrZbdWjKMsB1wXZvYTez5lmhHqq9/4ixp+ujqKkZTJP/0lmSwI9koTPh5yZ8gMbqj7Ciw/XdjPIf4uAePMv94o/+4PQvGzeWUY95QXEOXB+LSMbJ4Eu5FxunEUG3jVGZifXFS53U5DKLuJ1UcaXF04wyukkkdqc9wvIKm3zFeQ9KIP5hGD+vnkUG7NOM0THpvj4NpGdG7QfxkUsUABp8UfBm+f7i5q439hnC4TvIuYsVIi73WSDxFQpIbOQxCaRgc+/2IwJw+15Mo7488yX1wav+tP13CwJz0P3obfj/FppgPwa75hiTmUK39Xc8sFimIzi2bqftnWXkhmc1FzjEF4VN9Yx6AKUQwfYYSUEbK0Tn68aMUfU5iK/FYVD4P/x0CSXWZLXafJUZgt5Azn6uXujvfjJXhwLCxufprKtxcQOl8BoTDuM4YoZy4P/9XarbCuqlP6x+30E/43Q5kToFWeC4uX8ZZ1Jbs2ODPwwfSn8SQPtpwWzRVu9M1iWfPPe0EVpqAfeZ5CiDctKHxzlYJkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(41300700001)(47076005)(186003)(2616005)(5660300002)(4326008)(1076003)(82740400003)(36756003)(36860700001)(336012)(26005)(478600001)(6666004)(7696005)(966005)(83380400001)(426003)(40460700003)(54906003)(2906002)(316002)(110136005)(86362001)(8676002)(70206006)(70586007)(81166007)(356005)(8936002)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 06:01:13.0243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 210c6c59-055e-4677-8a7c-08da76a7e6e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add callback and code changes to enable ACP I2S controller in TDM
mode. Add new fields in acp_stream and acp_dev_data struct to configure
tdm related registers for ACP i2s controllers.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---

Depends on:-
    -- https://patchwork.kernel.org/project/alsa-devel/patch/20220804072556.601396-1-venkataprasad.potturu@amd.com/
    -- https://patchwork.kernel.org/project/alsa-devel/patch/20220801063501.51439-1-venkataprasad.potturu@amd.com/

Changes since v1:
    -- Add spin lock where linked list is referring.
    
 sound/soc/amd/acp/acp-i2s.c | 80 ++++++++++++++++++++++++++++++++++++-
 sound/soc/amd/acp/amd.h     | 12 ++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 393f729ef561..ac416572db0d 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -25,6 +25,65 @@
 
 #define DRV_NAME "acp_i2s_playcap"
 
+static int acp_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+			   unsigned int fmt)
+{
+	struct acp_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
+	int mode;
+
+	mode = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+	switch (mode) {
+	case SND_SOC_DAIFMT_I2S:
+		adata->tdm_mode = TDM_DISABLE;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		adata->tdm_mode = TDM_ENABLE;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mask,
+				int slots, int slot_width)
+{
+	struct device *dev = dai->component->dev;
+	struct acp_dev_data *adata = snd_soc_dai_get_drvdata(dai);
+	struct acp_stream *stream;
+	int slot_len;
+
+	switch (slot_width) {
+	case SLOT_WIDTH_8:
+		slot_len = 8;
+		break;
+	case SLOT_WIDTH_16:
+		slot_len = 16;
+		break;
+	case SLOT_WIDTH_24:
+		slot_len = 24;
+		break;
+	case SLOT_WIDTH_32:
+		slot_len = 0;
+		break;
+	default:
+		dev_err(dev, "Unsupported bitdepth %d\n", slot_width);
+		return -EINVAL;
+	}
+
+	spin_lock_irq(&adata->acp_lock);
+	list_for_each_entry(stream, &adata->stream_list, list) {
+		if (tx_mask && stream->dir == SNDRV_PCM_STREAM_PLAYBACK)
+			adata->tdm_tx_fmt[stream->dai_id - 1] =
+					FRM_LEN | (slots << 15) | (slot_len << 18);
+		else if (rx_mask && stream->dir == SNDRV_PCM_STREAM_CAPTURE)
+			adata->tdm_rx_fmt[stream->dai_id - 1] =
+					FRM_LEN | (slots << 15) | (slot_len << 18);
+	}
+	spin_unlock_irq(&adata->acp_lock);
+	return 0;
+}
+
 static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
@@ -33,7 +92,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 	struct acp_resource *rsrc;
 	u32 val;
 	u32 xfer_resolution;
-	u32 reg_val;
+	u32 reg_val, fmt_reg, tdm_fmt;
 	u32 lrclk_div_val, bclk_div_val;
 
 	adata = snd_soc_dai_get_drvdata(dai);
@@ -62,12 +121,15 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 		switch (dai->driver->id) {
 		case I2S_BT_INSTANCE:
 			reg_val = ACP_BTTDM_ITER;
+			fmt_reg = ACP_BTTDM_TXFRMT;
 			break;
 		case I2S_SP_INSTANCE:
 			reg_val = ACP_I2STDM_ITER;
+			fmt_reg = ACP_I2STDM_TXFRMT;
 			break;
 		case I2S_HS_INSTANCE:
 			reg_val = ACP_HSTDM_ITER;
+			fmt_reg = ACP_HSTDM_TXFRMT;
 			break;
 		default:
 			dev_err(dev, "Invalid dai id %x\n", dai->driver->id);
@@ -77,12 +139,15 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 		switch (dai->driver->id) {
 		case I2S_BT_INSTANCE:
 			reg_val = ACP_BTTDM_IRER;
+			fmt_reg = ACP_BTTDM_RXFRMT;
 			break;
 		case I2S_SP_INSTANCE:
 			reg_val = ACP_I2STDM_IRER;
+			fmt_reg = ACP_I2STDM_RXFRMT;
 			break;
 		case I2S_HS_INSTANCE:
 			reg_val = ACP_HSTDM_IRER;
+			fmt_reg = ACP_HSTDM_RXFRMT;
 			break;
 		default:
 			dev_err(dev, "Invalid dai id %x\n", dai->driver->id);
@@ -95,6 +160,16 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 	val = val | (xfer_resolution  << 3);
 	writel(val, adata->acp_base + reg_val);
 
+	if (adata->tdm_mode) {
+		val = readl(adata->acp_base + reg_val);
+		writel(val | BIT(1), adata->acp_base + reg_val);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			tdm_fmt = adata->tdm_tx_fmt[dai->driver->id - 1];
+		else
+			tdm_fmt = adata->tdm_rx_fmt[dai->driver->id - 1];
+		writel(tdm_fmt, adata->acp_base + fmt_reg);
+	}
+
 	if (rsrc->soc_mclk) {
 		switch (params_format(params)) {
 		case SNDRV_PCM_FORMAT_S16_LE:
@@ -443,6 +518,7 @@ static int acp_i2s_startup(struct snd_pcm_substream *substream, struct snd_soc_d
 	stream->id = dai->driver->id + dir;
 	stream->dai_id = dai->driver->id;
 	stream->irq_bit = irq_bit;
+	stream->dir = substream->stream;
 
 	return 0;
 }
@@ -452,6 +528,8 @@ const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops = {
 	.hw_params = acp_i2s_hwparams,
 	.prepare = acp_i2s_prepare,
 	.trigger = acp_i2s_trigger,
+	.set_fmt = acp_i2s_set_fmt,
+	.set_tdm_slot = acp_i2s_set_tdm_slot,
 };
 EXPORT_SYMBOL_NS_GPL(asoc_acp_cpu_dai_ops, SND_SOC_ACP_COMMON);
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index be8bb8247c4e..5f2119f42271 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -84,6 +84,14 @@
 
 #define ACP_MAX_STREAM			8
 
+#define TDM_ENABLE	1
+#define TDM_DISABLE	0
+
+#define SLOT_WIDTH_8	0x8
+#define SLOT_WIDTH_16	0x10
+#define SLOT_WIDTH_24	0x18
+#define SLOT_WIDTH_32	0x20
+
 struct acp_chip_info {
 	char *name;		/* Platform name */
 	unsigned int acp_rev;	/* ACP Revision id */
@@ -96,6 +104,7 @@ struct acp_stream {
 	int irq_bit;
 	int dai_id;
 	int id;
+	int dir;
 	u64 bytescount;
 	u32 reg_offset;
 	u32 pte_offset;
@@ -120,6 +129,7 @@ struct acp_dev_data {
 	void __iomem *acp_base;
 	unsigned int i2s_irq;
 
+	bool tdm_mode;
 	/* SOC specific dais */
 	struct snd_soc_dai_driver *dai_driver;
 	int num_dai;
@@ -134,6 +144,8 @@ struct acp_dev_data {
 	u32 lrclk_div;
 
 	struct acp_resource *rsrc;
+	u32 tdm_tx_fmt[3];
+	u32 tdm_rx_fmt[3];
 };
 
 union acp_i2stdm_mstrclkgen {
-- 
2.25.1

