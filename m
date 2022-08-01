Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D23586FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiHASBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiHASAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:00:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E61F2DF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9kQBhHCeGBSFYDsbhN6Hjt9RXwioUXi1wCBHZdzXhL30sBOmUBZZS+LfyVGjItG8kfJn/BHgcjYBbDwxhNYt0/i8hsHMZIVfZ9baxVTHFvz3DnrOMZkSyC+3oZLetzrhBjJ6OE5X4iPYHk1AMEtD65qkrDlQbEYcaol/n0ZVrR7gX5En9leH/qewLVrP3g3m7Uvc1+7Dj7jyvX97DqOF8mAU8ZzrRAk1Q7fTV61yLNCw0KibsunpP9andDWcOya7XHURPJSYo3p+q1g2qDZA60RBiYn8PpBeNDJ0PSXzaSdhVltvjVjEKXuEhAEUhSu70mvG++lmhyEo/wAQZhuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0Cc9I/ihuZ8iSM87yQUClB9wboqApBdTYpqSYDXQ1w=;
 b=E+QBTaJhFdowDKRlphbv6guRMvm4hXhjxyduBbIP+Om/UnDuk2e4NXC9WSke0hLDE3rsFM737shdRUhAXVtIV5AJSaaGRVAV9lCkVUooABu3BTMxQX2+ispqTJZeJvwy01EhMhxXU/um4HvaFjIcz9ck9WBwr7IxqA7z3hPgioVHbHS3Z5bCXRdpr+v5fZ5H8UXuzQHQgKtKbyN8Ja4ovAZi9F+aViNQGFcHDT3kMObiphOUId6V3wirnwRWnouzZ+PpO0JJpKJ1HmzIhZXOgHPxo2e78tNRj5+dh+Aylh5IxMUMv+emsmOTfHLMs613XNiOV6IYG3KxlH5XB3sZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0Cc9I/ihuZ8iSM87yQUClB9wboqApBdTYpqSYDXQ1w=;
 b=y3IdrhC+rCY5j2beEEqZFpzt6CuFdZSR2FYyHLWsKMtZzrcy6pkwrSEsNBODqBuBcwtUcWUop9PgF/U2IoOgS7ZSr5Nhw4vKzxA36cBXLq10PSc6MfJEaUEbqpL3z/P1i9M+z62W6nRfoyR7WVlHcYN8Xrzvdf3hzwgsZH4GIVA=
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.13; Mon, 1 Aug
 2022 18:00:41 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::a2) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14 via Frontend
 Transport; Mon, 1 Aug 2022 18:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 18:00:40 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 13:00:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 11:00:25 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 1 Aug 2022 13:00:16 -0500
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
Subject: [PATCH] ASoC: amd: acp: Add TDM support for acp i2s stream
Date:   Mon, 1 Aug 2022 23:33:23 +0530
Message-ID: <20220801180330.288356-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be00aab-0a5d-433b-3f52-08da73e7bf49
X-MS-TrafficTypeDiagnostic: BN9PR12MB5353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZMmSZiCOx4Y05QNr819gTbOTcsLP4Nj9uhYQpIgIz3rPj8fTkRhUv8RF/57KR3Z7SFrf09tD6bX3eqYREwq+4hWOlVUe/XeJM2wKuJBsOBcKR89vkbDMeyCi6PgofVHOY/w+hnMH7J8h1vwcZCNF5G+gxVuPu1FeamYZYmyS1Ul45pTyakwmc+qdNNfu+Nzibdc2VfZPL6o/lswgayUiQEPPpGGBK84X2YowJZIsmENQ/2WiCYjxcaB9Oway+WXGVpbeAzAeN6GD1i88cFvO+ISMXL5H8Ck3tKDwEyafEr5KyXJ7xP42FCODm6lqmQE6WhcwQvdpUuprt0bMRzC2QhbuhnW88AUbBax4IzlGOFugJtSuYaZtcBZHYu0xihOlfWD7D0vMJLTeassw7WFLrwMSinUZ/YB0prvf3wDiXcs0k2taeAnMq78QuaAwftuTucYiL5fHB9PCfbRgsDKK6sT2qeY6ov+YxzqzlkFiQiOM8bQNlnv34JiNAPy0OH/CCl6j7nB67SliaVDxwu7D7mz1ps/PUCjjfscZ1bpFpJQXYXd3kBf9g118fxqghPTE9ITikw8qNvtrjr8AGlZ4xiZQXyoyiVKH6hK/TrLJ0GGoNzw35Xtb2fiDN5ar+b6pssInpjCpV6tyGOFIvfWWDq+zQ8ZaA5RHc9GB7vMpcx3fwnhL+MVrZGWWtIWlg6jJdlkCUVBMyle1KOEoY7sIHTUhbbxf0oOoqlt2uZPK7xIJ0MCh+6oZnnSjbszywDGx/0CRwfuQqjPPSMJs61YLTYljbfoSBLh41vjv5gH440uhPxlGJLlTgmwU9H+0LuAKYBXdOGknIS7tr2RYyhIDPhdkmx6x922QXWL1otJ6RFyM6YN3MnRvI5B8piIssbF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(40470700004)(36840700001)(478600001)(966005)(316002)(54906003)(40460700003)(70586007)(4326008)(110136005)(8676002)(70206006)(82740400003)(40480700001)(82310400005)(356005)(81166007)(8936002)(86362001)(2906002)(36860700001)(5660300002)(2616005)(1076003)(186003)(336012)(426003)(47076005)(41300700001)(83380400001)(26005)(7696005)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 18:00:40.8203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be00aab-0a5d-433b-3f52-08da73e7bf49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
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
    -- https://patchwork.kernel.org/project/alsa-devel/patch/20220728124057.54259-1-venkataprasad.potturu@amd.com/

 sound/soc/amd/acp/acp-i2s.c | 78 ++++++++++++++++++++++++++++++++++++-
 sound/soc/amd/acp/amd.h     | 12 ++++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 393f729ef561..b1257923b225 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -25,6 +25,63 @@
 
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
+	list_for_each_entry(stream, &adata->stream_list, list) {
+		if (tx_mask && stream->dir == SNDRV_PCM_STREAM_PLAYBACK)
+			adata->tdm_tx_fmt[stream->dai_id - 1] =
+					FRM_LEN | (slots << 15) | (slot_len << 18);
+		else if (rx_mask && stream->dir == SNDRV_PCM_STREAM_CAPTURE)
+			adata->tdm_rx_fmt[stream->dai_id - 1] =
+					FRM_LEN | (slots << 15) | (slot_len << 18);
+	}
+	return 0;
+}
+
 static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
@@ -33,7 +90,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 	struct acp_resource *rsrc;
 	u32 val;
 	u32 xfer_resolution;
-	u32 reg_val;
+	u32 reg_val, fmt_reg, tdm_fmt;
 	u32 lrclk_div_val, bclk_div_val;
 
 	adata = snd_soc_dai_get_drvdata(dai);
@@ -62,12 +119,15 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
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
@@ -77,12 +137,15 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
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
@@ -95,6 +158,16 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
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
@@ -443,6 +516,7 @@ static int acp_i2s_startup(struct snd_pcm_substream *substream, struct snd_soc_d
 	stream->id = dai->driver->id + dir;
 	stream->dai_id = dai->driver->id;
 	stream->irq_bit = irq_bit;
+	stream->dir = substream->stream;
 
 	return 0;
 }
@@ -452,6 +526,8 @@ const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops = {
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

