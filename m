Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78334B53E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355514AbiBNO7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:59:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355497AbiBNO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:59:12 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07539A;
        Mon, 14 Feb 2022 06:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644850745; x=1676386745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VIEhuJg5H0419YEMU5IV/5/qu6XsVBmx1PQ4kc5+mZ4=;
  b=O2uBIfAJ6FG54qtWZ5RVrsmki0CSTZeBj/Bn6ywyCKT6PfrdYgn5eIoD
   AqUOy0xkvvLVYGn/XiaAonGEX6/2dgo82fvuY8LDlniFkwP0m/TDZepd1
   m2srFp9/MSz8vxJvMY5KvCG0I69xH0Xfc7CgNgiKpNdD5QmNZ+e3ZfErH
   s=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 06:59:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:59:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 06:59:04 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 06:58:58 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [RESEND v13 03/10] ASoC: qcom: lpass: Add dma fields for codec dma lpass interface
Date:   Mon, 14 Feb 2022 20:28:21 +0530
Message-ID: <1644850708-11099-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

