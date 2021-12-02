Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145994666FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359146AbhLBPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:48:10 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:36160 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359124AbhLBPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:48:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638459880; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2NEf6Kgi3s7d1z0dcSBvT0QYZBp6GS/saQQ5r2jFktY=; b=aYN2AccJlQoIAhR+TljJncg/lYRVXb02vByV0sZQvOVkxKNYJi/MljqHd++7Psfe008VuWbb
 5ErmPs1jKnkmgii82to8mfK/Fhtrad9ia9Qtplom5PpEasPmLD+oNE2hwn6J0vgL2BBdB6xc
 WfcpmRPAOeCFO7Aj72V8XzMPRmM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61a8e9e3135a8a9d0ef300e0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Dec 2021 15:44:35
 GMT
Sender: srivasam=codeaurora.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4365C4363B; Thu,  2 Dec 2021 15:44:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8A79C4361C;
        Thu,  2 Dec 2021 15:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C8A79C4361C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.com
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
Subject: [PATCH v7 07/10] ASoC: qcom: Add regmap config support for codec dma driver
Date:   Thu,  2 Dec 2021 21:13:23 +0530
Message-Id: <1638459806-27600-8-git-send-email-srivasam@codeaurora.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638459806-27600-1-git-send-email-srivasam@codeaurora.com>
References: <1638459806-27600-1-git-send-email-srivasam@codeaurora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

Update regmap configuration for supporting headset playback and
capture and DMIC capture using codec dma interface

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 185 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 81818f0..a5a46bc 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -28,6 +28,8 @@
 #define LPASS_CPU_I2S_SD2_3_MASK	GENMASK(3, 2)
 #define LPASS_CPU_I2S_SD0_1_2_MASK	GENMASK(2, 0)
 #define LPASS_CPU_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
+#define LPASS_REG_READ 1
+#define LPASS_REG_WRITE 0
 
 /*
  * Channel maps for Quad channel playbacks on MI2S Secondary
@@ -798,6 +800,189 @@ static struct regmap_config lpass_hdmi_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
+static bool __lpass_rxtx_regmap_accessible(struct device *dev, unsigned int reg, bool rw)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
+	int i;
+
+	for (i = 0; i < v->rxtx_irq_ports; ++i) {
+		if (reg == LPAIF_RXTX_IRQCLEAR_REG(v, i))
+			return true;
+		if (reg == LPAIF_RXTX_IRQEN_REG(v, i))
+			return true;
+		if (reg == LPAIF_RXTX_IRQSTAT_REG(v, i))
+			return true;
+	}
+
+	for (i = 0; i < v->rxtx_rdma_channels; ++i) {
+		if (reg == LPAIF_CDC_RXTX_RDMACTL_REG(v, i, LPASS_CDC_DMA_RX0))
+			return true;
+		if (reg == LPAIF_CDC_RXTX_RDMABASE_REG(v, i, LPASS_CDC_DMA_RX0))
+			return true;
+		if (reg == LPAIF_CDC_RXTX_RDMABUFF_REG(v, i, LPASS_CDC_DMA_RX0))
+			return true;
+		if (rw == LPASS_REG_READ) {
+			if (reg == LPAIF_CDC_RXTX_RDMACURR_REG(v, i, LPASS_CDC_DMA_RX0))
+				return true;
+		}
+		if (reg == LPAIF_CDC_RXTX_RDMAPER_REG(v, i, LPASS_CDC_DMA_RX0))
+			return true;
+		if (reg == LPAIF_CDC_RXTX_RDMA_INTF_REG(v, i, LPASS_CDC_DMA_RX0))
+			return true;
+	}
+
+	for (i = 0; i < v->rxtx_wrdma_channels; ++i) {
+		if (reg == LPAIF_CDC_RXTX_WRDMACTL_REG(v, i + v->rxtx_wrdma_channel_start,
+							LPASS_CDC_DMA_TX3))
+			return true;
+		if (reg == LPAIF_CDC_RXTX_WRDMABASE_REG(v, i + v->rxtx_wrdma_channel_start,
+							LPASS_CDC_DMA_TX3))
+			return true;
+		if (reg == LPAIF_CDC_RXTX_WRDMABUFF_REG(v, i + v->rxtx_wrdma_channel_start,
+							LPASS_CDC_DMA_TX3))
+			return true;
+		if (rw == LPASS_REG_READ) {
+			if (reg == LPAIF_CDC_RXTX_WRDMACURR_REG(v, i, LPASS_CDC_DMA_RX0))
+				return true;
+		}
+		if (reg == LPAIF_CDC_RXTX_WRDMAPER_REG(v, i + v->rxtx_wrdma_channel_start,
+							LPASS_CDC_DMA_TX3))
+			return true;
+		if (reg == LPAIF_CDC_RXTX_WRDMA_INTF_REG(v, i + v->rxtx_wrdma_channel_start,
+							LPASS_CDC_DMA_TX3))
+			return true;
+	}
+	return false;
+}
+
+static bool lpass_rxtx_regmap_writeable(struct device *dev, unsigned int reg)
+{
+	return __lpass_rxtx_regmap_accessible(dev, reg, LPASS_REG_WRITE);
+}
+
+static bool lpass_rxtx_regmap_readable(struct device *dev, unsigned int reg)
+{
+	return __lpass_rxtx_regmap_accessible(dev, reg, LPASS_REG_READ);
+}
+
+static bool lpass_rxtx_regmap_volatile(struct device *dev, unsigned int reg)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
+	int i;
+
+	for (i = 0; i < v->rxtx_irq_ports; ++i) {
+		if (reg == LPAIF_RXTX_IRQCLEAR_REG(v, i))
+			return true;
+		if (reg == LPAIF_RXTX_IRQSTAT_REG(v, i))
+			return true;
+	}
+
+	for (i = 0; i < v->rxtx_rdma_channels; ++i)
+		if (reg == LPAIF_CDC_RXTX_RDMACURR_REG(v, i, LPASS_CDC_DMA_RX0))
+			return true;
+
+	for (i = 0; i < v->rxtx_wrdma_channels; ++i)
+		if (reg == LPAIF_CDC_RXTX_WRDMACURR_REG(v, i + v->rxtx_wrdma_channel_start,
+							LPASS_CDC_DMA_TX3))
+			return true;
+
+	return false;
+}
+
+static bool __lpass_va_regmap_accessible(struct device *dev, unsigned int reg, bool rw)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
+	int i;
+
+	for (i = 0; i < v->va_irq_ports; ++i) {
+		if (reg == LPAIF_VA_IRQCLEAR_REG(v, i))
+			return true;
+		if (reg == LPAIF_VA_IRQEN_REG(v, i))
+			return true;
+		if (reg == LPAIF_VA_IRQSTAT_REG(v, i))
+			return true;
+	}
+
+	for (i = 0; i < v->va_wrdma_channels; ++i) {
+		if (reg == LPAIF_CDC_VA_WRDMACTL_REG(v, i + v->va_wrdma_channel_start,
+							LPASS_CDC_DMA_VA_TX0))
+			return true;
+		if (reg == LPAIF_CDC_VA_WRDMABASE_REG(v, i + v->va_wrdma_channel_start,
+							LPASS_CDC_DMA_VA_TX0))
+			return true;
+		if (reg == LPAIF_CDC_VA_WRDMABUFF_REG(v, i + v->va_wrdma_channel_start,
+							LPASS_CDC_DMA_VA_TX0))
+			return true;
+		if (rw == LPASS_REG_READ) {
+			if (reg == LPAIF_CDC_VA_WRDMACURR_REG(v, i + v->va_wrdma_channel_start,
+							LPASS_CDC_DMA_VA_TX0))
+				return true;
+		}
+		if (reg == LPAIF_CDC_VA_WRDMAPER_REG(v, i + v->va_wrdma_channel_start,
+							LPASS_CDC_DMA_VA_TX0))
+			return true;
+		if (reg == LPAIF_CDC_VA_WRDMA_INTF_REG(v, i + v->va_wrdma_channel_start,
+							LPASS_CDC_DMA_VA_TX0))
+			return true;
+	}
+	return false;
+}
+
+static bool lpass_va_regmap_writeable(struct device *dev, unsigned int reg)
+{
+	return __lpass_va_regmap_accessible(dev, reg, LPASS_REG_WRITE);
+}
+
+static bool lpass_va_regmap_readable(struct device *dev, unsigned int reg)
+{
+	return __lpass_va_regmap_accessible(dev, reg, LPASS_REG_READ);
+}
+
+static bool lpass_va_regmap_volatile(struct device *dev, unsigned int reg)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+	struct lpass_variant *v = drvdata->variant;
+	int i;
+
+	for (i = 0; i < v->va_irq_ports; ++i) {
+		if (reg == LPAIF_VA_IRQCLEAR_REG(v, i))
+			return true;
+		if (reg == LPAIF_VA_IRQSTAT_REG(v, i))
+			return true;
+	}
+
+	for (i = 0; i < v->va_wrdma_channels; ++i) {
+		if (reg == LPAIF_CDC_VA_WRDMACURR_REG(v, i + v->va_wrdma_channel_start,
+							LPASS_CDC_DMA_VA_TX0))
+			return true;
+	}
+
+	return false;
+}
+
+static struct regmap_config lpass_rxtx_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.writeable_reg = lpass_rxtx_regmap_writeable,
+	.readable_reg = lpass_rxtx_regmap_readable,
+	.volatile_reg = lpass_rxtx_regmap_volatile,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static struct regmap_config lpass_va_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.writeable_reg = lpass_va_regmap_writeable,
+	.readable_reg = lpass_va_regmap_readable,
+	.volatile_reg = lpass_va_regmap_volatile,
+	.cache_type = REGCACHE_FLAT,
+};
+
 static unsigned int of_lpass_cpu_parse_sd_lines(struct device *dev,
 						struct device_node *node,
 						const char *name)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

