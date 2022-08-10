Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9FA58ED23
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiHJN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiHJN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:26:41 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3D31DE5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owtuv0jagRjKpJMpft2T8/hpE2web3jqIv1hAVH9Z9eByIwhsIj/5Chm9t+YZaGxl7D81aJK78GU5VV7dOZT6e1bEMWNIEV0UDrHjJijzyBXnVXZeEvQoURtGnM5rN06GMnWMZPYJmV1kobh1LFrTnn6FtjLVjOKJs0t+aAT4SGiWEGTNteAaXGVDkbON9PtBNnf77sOK4t9R5zgcaZSmp96/Jc2/jN9f3l09nqH+6FXCwkSdr5DE6J4L/AVYoBJeqyupoi9l6a2m+oZRIMaSNqRH1/dT+UvTXoY2k5cljkGN3M1F3Y4Oybl7nAk4jfVLazpSpBrYMXC2qqoNGOZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oB12A43Fbn31nx7F/9xlv1XkstVMJWnHbxcSeYEjEI=;
 b=DCVDifKQSjSS1W5BFXmKhAxSblTf6pb5ALfVAKwBb3joku/n4BSbc8550rnyHSKQuO/xfDq+M18tVF49y+mwoKSgYzz4qJgtpvZLFzhA9BuU1tyfdjy39K3lgX1mHvmIzOdy9m7wHTY3baXNZSCplASJ2E+mLi5/CMaKod8WAJSAMCo8LnBkW1/RiF8ejaGRhiVIBjVYKchKE8AZt4Pu3n7z354+cDHF/FSatRs7M7NOwcEKyStuSqPuf2zI1jiMjURhsfy4I+vyr9Vc0LuxogWA1IRVPKcmBcxSNGnwbUUgVPwn88UElBMNyGd2Un14aT30ubhC6SlTkQO7lSLCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oB12A43Fbn31nx7F/9xlv1XkstVMJWnHbxcSeYEjEI=;
 b=AiImLccYJSxFojoHb15beJwi+RcOXvs14RFlHIbd+SsjF/AHX3MduG0vpmJLE0Y3Y4ihekqZOcQX4x4a/cWfJ2nS5KhfjRTB2GCLxlqyqFx9lMew/KKgGkIIHb0dgwxrLLJ6txkRyXZtB2DIKCtW8gtqnzdj/5mAdsdUwMul5/w=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 10 Aug
 2022 13:26:36 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::50) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 10 Aug 2022 13:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 13:26:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 08:26:34 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 10 Aug 2022 08:26:25 -0500
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
Subject: [RESEND v4 2/2] ASoC: amd: acp: Add TDM support for acp i2s stream
Date:   Wed, 10 Aug 2022 18:59:13 +0530
Message-ID: <20220810132913.1181247-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810132913.1181247-1-venkataprasad.potturu@amd.com>
References: <20220810132913.1181247-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4eda401-c8fb-484f-f808-08da7ad3f31a
X-MS-TrafficTypeDiagnostic: LV2PR12MB5966:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dfxqQDAVVmnDlIfNzbGG/Vg3IJONgh/qOZ76r5ATXp9F4L8h2edtvWYaW0/8rdN8QI4hOOI2qATq49IUYYqNsYZuz1AqvM1oj2+5Uy9/1+Uy/MMYPjaTMuvfJw9/r+7IrhERwIVcYCr5U6QDgvt00n26Ow7vIDO5+AkC9WJHM6Fh/Ciws3TS5SE7SRqmlCPMuApWa9LZzvGms3BbJ/Sf03ZaKrUFUjtJkbO6L+Zw7GfgxL5dw7rKtjLP7cNLV5ML+Hcw8gI9/R+6g9hbR9FDa3f+C32vaZd/ioBG71qFxSZFtGbix2uDE1p5Dm1+pC7TWtE3W+elEWA/86ipHJ9uA9agaUCkDCArAArMHt4njoCcm1khJigQfnnTM89qyM11prf3+ryRvDmlOwN1bQkWl0OnYOsQ5bMrw4P3nlqKZWvW8MLdBPl4ys5iqccEGvPfHgc5yAVXjNcDAxkyaZmLm26avUqeA64gApcC43bCAw1pX06EGHDCq7MiUR2q1h5L/4wemJMxVDjLNwgCSxiaqyI0tD7Txw483Bh1z2/KyX2b2I9f4zOy5kj+4/rViH9uwAMu087vqIxDOCDJLoohY/yONXbBWeL8mSr6XmYiWCFmR02diiPxFqghQKGYMVTldVsoH6AGvs5+nrqae3MzvcrW+c0aWGox38mr8OxKEjiyOdusazyqLHcVC6+7p+P2/xw1payPgc3OKCGiopmDZ55q+cuPsGyL2Zu5QdpbSoVuSctZ8trdf8Zi2hvGHLzhViKZvISl8/fgxPRMRsTPkGDka44vI+UnnFsUDVLXe2hh2mKuy+qEFhBKvDXVQn6vdkYZMXFCQWA+m+8m2pE5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(40470700004)(46966006)(336012)(26005)(41300700001)(7696005)(426003)(6666004)(47076005)(2616005)(2906002)(86362001)(40460700003)(82740400003)(356005)(40480700001)(83380400001)(81166007)(1076003)(36860700001)(82310400005)(8936002)(186003)(70586007)(70206006)(4326008)(5660300002)(54906003)(36756003)(478600001)(110136005)(8676002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 13:26:35.9634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4eda401-c8fb-484f-f808-08da7ad3f31a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

