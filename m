Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB594749A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhLNRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:37:13 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33492 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236562AbhLNRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639503432; x=1671039432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VIEhuJg5H0419YEMU5IV/5/qu6XsVBmx1PQ4kc5+mZ4=;
  b=YuKab3TKjdwnmvqvy/qLJOCra0n4JEiccc3r4BkwNhUTtO1NjTISHtCU
   qsCTeYZQr+h2o9hvj0U2QpvS3vxRWAvmmIrnQ6JnqWFtogMNQoOjI1ipe
   RWQJezxDCg2nAt7/Kb/vq4l1Ln28pWmkpIAKSZ3Uhvon9/UxX9ob9JR4B
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Dec 2021 09:37:12 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:37:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 14 Dec 2021 09:37:11 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 14 Dec 2021 09:37:05 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <plai@codeaurora.org>, <bgoswami@codeaurora.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <rohitkr@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v10 03/10] ASoC: qcom: lpass: Add dma fields for codec dma lpass interface
Date:   Tue, 14 Dec 2021 23:06:24 +0530
Message-ID: <1639503391-10715-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639503391-10715-1-git-send-email-quic_srivasam@quicinc.com>
References: <1639503391-10715-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lpass interface memebers to support audio path over codec dma.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass.h | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index f0d21cd..7cc3763 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -20,6 +20,17 @@
 #define LPASS_MAX_MI2S_PORTS			(8)
 #define LPASS_MAX_DMA_CHANNELS			(8)
 #define LPASS_MAX_HDMI_DMA_CHANNELS		(4)
+#define LPASS_MAX_CDC_DMA_CHANNELS		(8)
+#define LPASS_MAX_VA_CDC_DMA_CHANNELS		(8)
+#define LPASS_CDC_DMA_INTF_ONE_CHANNEL		(0x01)
+#define LPASS_CDC_DMA_INTF_TWO_CHANNEL		(0x03)
+#define LPASS_CDC_DMA_INTF_FOUR_CHANNEL		(0x0F)
+#define LPASS_CDC_DMA_INTF_SIX_CHANNEL		(0x3F)
+#define LPASS_CDC_DMA_INTF_EIGHT_CHANNEL	(0xFF)
+
+#define LPASS_MAX_CDC_CLKS			(9)
+#define LPASS_ACTIVE_PDS			(4)
+#define LPASS_PROXY_PDS			(8)
 
 #define QCOM_REGMAP_FIELD_ALLOC(d, m, f, mf)    \
 	do { \
@@ -51,6 +62,12 @@ struct lpaif_dmactl {
 	struct regmap_field *burst8;
 	struct regmap_field *burst16;
 	struct regmap_field *dynburst;
+	struct regmap_field *codec_enable;
+	struct regmap_field *codec_pack;
+	struct regmap_field *codec_intf;
+	struct regmap_field *codec_fs_sel;
+	struct regmap_field *codec_channel;
+	struct regmap_field *codec_fs_delay;
 };
 
 /* Both the CPU DAI and platform drivers will access this data */
@@ -65,6 +82,8 @@ struct lpass_data {
 	/* MI2S bit clock (derived from system clock by a divider */
 	struct clk *mi2s_bit_clk[LPASS_MAX_MI2S_PORTS];
 
+	struct clk *cdc_dma_clks[LPASS_MAX_CDC_CLKS];
+
 	/* MI2S SD lines to use for playback/capture */
 	unsigned int mi2s_playback_sd_mode[LPASS_MAX_MI2S_PORTS];
 	unsigned int mi2s_capture_sd_mode[LPASS_MAX_MI2S_PORTS];
@@ -73,38 +92,61 @@ struct lpass_data {
 	bool mi2s_was_prepared[LPASS_MAX_MI2S_PORTS];
 
 	int hdmi_port_enable;
+	int codec_dma_enable;
 
 	/* low-power audio interface (LPAIF) registers */
 	void __iomem *lpaif;
 	void __iomem *hdmiif;
+	void __iomem *rxtx_lpaif;
+	void __iomem *va_lpaif;
+
+	u32 rxtx_cdc_dma_lpm_buf;
+	u32 va_cdc_dma_lpm_buf;
 
 	/* regmap backed by the low-power audio interface (LPAIF) registers */
 	struct regmap *lpaif_map;
 	struct regmap *hdmiif_map;
+	struct regmap *rxtx_lpaif_map;
+	struct regmap *va_lpaif_map;
 
 	/* interrupts from the low-power audio interface (LPAIF) */
 	int lpaif_irq;
 	int hdmiif_irq;
+	int rxtxif_irq;
+	int vaif_irq;
+
 	/* SOC specific variations in the LPASS IP integration */
 	struct lpass_variant *variant;
 
 	/* bit map to keep track of static channel allocations */
 	unsigned long dma_ch_bit_map;
 	unsigned long hdmi_dma_ch_bit_map;
+	unsigned long rxtx_dma_ch_bit_map;
+	unsigned long va_dma_ch_bit_map;
 
 	/* used it for handling interrupt per dma channel */
 	struct snd_pcm_substream *substream[LPASS_MAX_DMA_CHANNELS];
 	struct snd_pcm_substream *hdmi_substream[LPASS_MAX_HDMI_DMA_CHANNELS];
+	struct snd_pcm_substream *rxtx_substream[LPASS_MAX_CDC_DMA_CHANNELS];
+	struct snd_pcm_substream *va_substream[LPASS_MAX_CDC_DMA_CHANNELS];
 
 	/* SOC specific clock list */
 	struct clk_bulk_data *clks;
 	int num_clks;
+	struct clk_bulk_data *cdc_clks;
+	int cdc_num_clks;
 
 	/* Regmap fields of I2SCTL & DMACTL registers bitfields */
 	struct lpaif_i2sctl *i2sctl;
 	struct lpaif_dmactl *rd_dmactl;
 	struct lpaif_dmactl *wr_dmactl;
 	struct lpaif_dmactl *hdmi_rd_dmactl;
+
+	/* Regmap fields of CODEC DMA CTRL registers*/
+	struct lpaif_dmactl *rxtx_rd_dmactl;
+	struct lpaif_dmactl *rxtx_wr_dmactl;
+	struct lpaif_dmactl *va_wr_dmactl;
+
 	/* Regmap fields of HDMI_CTRL registers*/
 	struct regmap_field *hdmitx_legacy_en;
 	struct regmap_field *hdmitx_parity_calc_en;
@@ -131,6 +173,24 @@ struct lpass_variant {
 	u32	wrdma_reg_base;
 	u32	wrdma_reg_stride;
 	u32	wrdma_channels;
+	u32	rxtx_irq_reg_base;
+	u32	rxtx_irq_reg_stride;
+	u32	rxtx_irq_ports;
+	u32	rxtx_rdma_reg_base;
+	u32	rxtx_rdma_reg_stride;
+	u32	rxtx_rdma_channels;
+	u32	rxtx_wrdma_reg_base;
+	u32	rxtx_wrdma_reg_stride;
+	u32	rxtx_wrdma_channels;
+	u32	va_irq_reg_base;
+	u32	va_irq_reg_stride;
+	u32	va_irq_ports;
+	u32	va_rdma_reg_base;
+	u32	va_rdma_reg_stride;
+	u32	va_rdma_channels;
+	u32	va_wrdma_reg_base;
+	u32	va_wrdma_reg_stride;
+	u32	va_wrdma_channels;
 	u32	i2sctrl_reg_base;
 	u32	i2sctrl_reg_stride;
 	u32	i2s_ports;
@@ -234,12 +294,66 @@ struct lpass_variant {
 	struct reg_field wrdma_enable;
 	struct reg_field wrdma_dyncclk;
 
+	/*CDC RXTX RD_DMA */
+	struct reg_field rxtx_rdma_intf;
+	struct reg_field rxtx_rdma_bursten;
+	struct reg_field rxtx_rdma_wpscnt;
+	struct reg_field rxtx_rdma_fifowm;
+	struct reg_field rxtx_rdma_enable;
+	struct reg_field rxtx_rdma_dyncclk;
+	struct reg_field rxtx_rdma_burst8;
+	struct reg_field rxtx_rdma_burst16;
+	struct reg_field rxtx_rdma_dynburst;
+	struct reg_field rxtx_rdma_codec_enable;
+	struct reg_field rxtx_rdma_codec_pack;
+	struct reg_field rxtx_rdma_codec_intf;
+	struct reg_field rxtx_rdma_codec_fs_sel;
+	struct reg_field rxtx_rdma_codec_ch;
+	struct reg_field rxtx_rdma_codec_fs_delay;
+
+	/*CDC RXTX WR_DMA */
+	struct reg_field rxtx_wrdma_intf;
+	struct reg_field rxtx_wrdma_bursten;
+	struct reg_field rxtx_wrdma_wpscnt;
+	struct reg_field rxtx_wrdma_fifowm;
+	struct reg_field rxtx_wrdma_enable;
+	struct reg_field rxtx_wrdma_dyncclk;
+	struct reg_field rxtx_wrdma_burst8;
+	struct reg_field rxtx_wrdma_burst16;
+	struct reg_field rxtx_wrdma_dynburst;
+	struct reg_field rxtx_wrdma_codec_enable;
+	struct reg_field rxtx_wrdma_codec_pack;
+	struct reg_field rxtx_wrdma_codec_intf;
+	struct reg_field rxtx_wrdma_codec_fs_sel;
+	struct reg_field rxtx_wrdma_codec_ch;
+	struct reg_field rxtx_wrdma_codec_fs_delay;
+
+	/*CDC VA WR_DMA */
+	struct reg_field va_wrdma_intf;
+	struct reg_field va_wrdma_bursten;
+	struct reg_field va_wrdma_wpscnt;
+	struct reg_field va_wrdma_fifowm;
+	struct reg_field va_wrdma_enable;
+	struct reg_field va_wrdma_dyncclk;
+	struct reg_field va_wrdma_burst8;
+	struct reg_field va_wrdma_burst16;
+	struct reg_field va_wrdma_dynburst;
+	struct reg_field va_wrdma_codec_enable;
+	struct reg_field va_wrdma_codec_pack;
+	struct reg_field va_wrdma_codec_intf;
+	struct reg_field va_wrdma_codec_fs_sel;
+	struct reg_field va_wrdma_codec_ch;
+	struct reg_field va_wrdma_codec_fs_delay;
+
 	/**
 	 * on SOCs like APQ8016 the channel control bits start
 	 * at different offset to ipq806x
 	 **/
 	u32	dmactl_audif_start;
 	u32	wrdma_channel_start;
+	u32	rxtx_wrdma_channel_start;
+	u32	va_wrdma_channel_start;
+
 	/* SOC specific initialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
@@ -251,10 +365,12 @@ struct lpass_variant {
 	int num_dai;
 	const char * const *dai_osr_clk_names;
 	const char * const *dai_bit_clk_names;
+	const char * const *cdc_dma_clk_names;
 
 	/* SOC specific clocks configuration */
 	const char **clk_name;
 	int num_clks;
+	int cdc_dma_num_clks;
 };
 
 struct lpass_pcm_data {
-- 
2.7.4

