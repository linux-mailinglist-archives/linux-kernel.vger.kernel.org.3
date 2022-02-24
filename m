Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FB4C2D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiBXNcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiBXNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:32:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D620B29825
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:31:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s13so3068696wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6LhfPN/SlOriyUCx5aiYoAtJnBZB9YS0GDCnHT6f88=;
        b=EfdhZXTEGqY1j92s5JYbuFYEn91qdFGhaA46MqbZjZp9mzNAT1OMXzHKhfDqV05yV0
         uCuCBgS7G8mSrjNVL74V7Y3Bh01ayomtmVO/lxHub3IdItKh9q93BajdGyZWgkcYUtCo
         sZz5ak3OWcChl8Y99qU0smTYsjchB+/BnhEEv/GAmwq5NFS377BPMA/d/XIx2juyRtIk
         StDnsm5t84Q8/n1Q+DzLn6cPQGqavzjbnYmf0CVOwr4TIK8NsFdxa3MXVpqWr/GiXSIR
         Ancgac0hiprCiS89g7MoolC0qVPpfqFuqwT9X57kJBgRiAif4DQLuTYhor0uCB96/bVJ
         XEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6LhfPN/SlOriyUCx5aiYoAtJnBZB9YS0GDCnHT6f88=;
        b=xVVqw1JyKFxW2+y6NUeyQwAk4dxwTM9DU5Qun0hxn/HJTaHyAkv00E60J6F0d3Ue01
         4QJUzVHGNeG+vTRQKGaMptqfCl/U01vYWdDyTKL7lOFjOPd/YysYHlv/93BYFV8UNcio
         mEy5xBCqCd5aCoFFZ4R7AgFLAr67xBRu2gUEpl56egpeY3x1ZYQZLdIR6cAUx2+duafw
         UXgRUThdOmIFsDMTofnsikSCe+DLcE26dGeX75Ab7PLdNvp0WXR+moP38gxpdhvexwfk
         wcbdSoTYr2Ys6MZgh1gaNOi8H6+MpNZLY5J3Mx+Ca4GUpcLU3t7Rh2zeGlMIu7P8rhD2
         JfRg==
X-Gm-Message-State: AOAM5321/eyLKdTWJI/+tML7CXi8SPiJa8rwqsRMC4D+3rioeHJLSskT
        l7sQNgVZIQdpRRctDZuFOOk5DA==
X-Google-Smtp-Source: ABdhPJzqdDrMGga4YXRiYQAa+nqP28LY06kj5k8ZXC3G38EGYBbrjixS3jW+OajRPpeIxjgp5yZk2w==
X-Received: by 2002:a5d:4d4a:0:b0:1ec:fab3:61bb with SMTP id a10-20020a5d4d4a000000b001ecfab361bbmr433380wru.50.1645709501377;
        Thu, 24 Feb 2022 05:31:41 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id e33-20020a05600c4ba100b003810c690ba2sm2019142wmp.3.2022.02.24.05.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:31:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/3] soundwire: qcom: add runtime pm support
Date:   Thu, 24 Feb 2022 13:31:23 +0000
Message-Id: <20220224133125.6674-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220224133125.6674-1-srinivas.kandagatla@linaro.org>
References: <20220224133125.6674-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to runtime PM using SoundWire clock stop Mode0 on supported
controller instances and soft reset on instances that do not support
clock stop.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 152 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 54813417ef8e..2c763a9f088f 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/slimbus.h>
@@ -20,6 +21,9 @@
 #include <sound/soc.h>
 #include "bus.h"
 
+#define SWRM_COMP_SW_RESET					0x008
+#define SWRM_COMP_STATUS					0x014
+#define SWRM_FRM_GEN_ENABLED					BIT(0)
 #define SWRM_COMP_HW_VERSION					0x00
 #define SWRM_COMP_CFG_ADDR					0x04
 #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
@@ -29,6 +33,7 @@
 #define SWRM_COMP_PARAMS_RD_FIFO_DEPTH				GENMASK(19, 15)
 #define SWRM_COMP_PARAMS_DOUT_PORTS_MASK			GENMASK(4, 0)
 #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
+#define SWRM_COMP_MASTER_ID					0x104
 #define SWRM_INTERRUPT_STATUS					0x200
 #define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
 #define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
@@ -111,6 +116,13 @@
 #define SWR_MAX_CMD_ID	14
 #define MAX_FIFO_RD_RETRY 3
 #define SWR_OVERFLOW_RETRY_COUNT 30
+#define SWRM_LINK_STATUS_RETRY_CNT 100
+
+enum {
+	MASTER_ID_WSA = 1,
+	MASTER_ID_RX,
+	MASTER_ID_TX
+};
 
 struct qcom_swrm_port_config {
 	u8 si;
@@ -159,6 +171,7 @@ struct qcom_swrm_ctrl {
 	u32 slave_status;
 	u32 wr_fifo_depth;
 	u32 rd_fifo_depth;
+	bool clock_stop_not_supported;
 };
 
 struct qcom_swrm_data {
@@ -497,6 +510,7 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 	u32 i;
 	int devnum;
 	int ret = IRQ_HANDLED;
+	clk_prepare_enable(swrm->hclk);
 
 	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
 	intr_sts_masked = intr_sts & swrm->intr_mask;
@@ -604,6 +618,7 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 		intr_sts_masked = intr_sts & swrm->intr_mask;
 	} while (intr_sts_masked);
 
+	clk_disable_unprepare(swrm->hclk);
 	return ret;
 }
 
@@ -1017,6 +1032,15 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai;
 	int ret, i;
 
+	ret = pm_runtime_get_sync(ctrl->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(ctrl->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(ctrl->dev);
+		return ret;
+	}
+
 	sruntime = sdw_alloc_stream(dai->name);
 	if (!sruntime)
 		return -ENOMEM;
@@ -1044,6 +1068,9 @@ static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
 
 	sdw_release_stream(ctrl->sruntime[dai->id]);
 	ctrl->sruntime[dai->id] = NULL;
+	pm_runtime_mark_last_busy(ctrl->dev);
+	pm_runtime_put_autosuspend(ctrl->dev);
+
 }
 
 static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
@@ -1197,12 +1224,23 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
 static int swrm_reg_show(struct seq_file *s_file, void *data)
 {
 	struct qcom_swrm_ctrl *swrm = s_file->private;
-	int reg, reg_val;
+	int reg, reg_val, ret;
+
+	ret = pm_runtime_get_sync(swrm->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(swrm->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(swrm->dev);
+	}
 
 	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
 		swrm->reg_read(swrm, reg, &reg_val);
 		seq_printf(s_file, "0x%.3x: 0x%.2x\n", reg, reg_val);
 	}
+	pm_runtime_mark_last_busy(swrm->dev);
+	pm_runtime_put_autosuspend(swrm->dev);
+
 
 	return 0;
 }
@@ -1267,6 +1305,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
+	ctrl->bus.clk_stop_timeout = 300;
 
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
@@ -1319,6 +1358,21 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
 		 ctrl->version & 0xffff);
 
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/* Clk stop is not supported on WSA Soundwire masters */
+	if (ctrl->version <= 0x01030000) {
+		ctrl->clock_stop_not_supported = true;
+	} else {
+		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
+		if (val == MASTER_ID_WSA)
+			ctrl->clock_stop_not_supported = true;
+	}
+
 #ifdef CONFIG_DEBUG_FS
 	ctrl->debugfs = debugfs_create_dir("qualcomm-sdw", ctrl->bus.debugfs);
 	debugfs_create_file("qualcomm-registers", 0400, ctrl->debugfs, ctrl,
@@ -1345,6 +1399,101 @@ static int qcom_swrm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *swrm)
+{
+	int retry = SWRM_LINK_STATUS_RETRY_CNT;
+	int comp_sts;
+
+	do {
+		swrm->reg_read(swrm, SWRM_COMP_STATUS, &comp_sts);
+
+		if (comp_sts & SWRM_FRM_GEN_ENABLED)
+			return true;
+
+		usleep_range(500, 510);
+	} while (retry--);
+
+	dev_err(swrm->dev, "%s: link status not %s\n", __func__,
+		comp_sts && SWRM_FRM_GEN_ENABLED ? "connected" : "disconnected");
+
+	return false;
+}
+
+static int swrm_runtime_resume(struct device *dev)
+{
+	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	clk_prepare_enable(ctrl->hclk);
+
+	if (ctrl->clock_stop_not_supported) {
+		reinit_completion(&ctrl->enumeration);
+		ctrl->reg_write(ctrl, SWRM_COMP_SW_RESET, 0x01);
+		usleep_range(100, 105);
+		qcom_swrm_init(ctrl);
+		/* wait for hw enumeration to complete */
+		wait_for_completion_timeout(&ctrl->enumeration,
+					    msecs_to_jiffies(TIMEOUT_MS));
+		qcom_swrm_get_device_status(ctrl);
+		sdw_handle_slave_status(&ctrl->bus, ctrl->status);
+	} else {
+		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
+		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR,
+			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
+
+		ctrl->intr_mask |= SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
+		ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR, ctrl->intr_mask);
+		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
+
+		usleep_range(100, 105);
+	}
+
+	if (!swrm_wait_for_frame_gen_enabled(ctrl))
+		dev_err(ctrl->dev, "link failed to connect\n");
+
+	usleep_range(300, 305);
+	ret = sdw_bus_exit_clk_stop(&ctrl->bus);
+	if (ret < 0)
+		dev_err(ctrl->dev, "bus failed to exit clock stop %d\n", ret);
+
+	return 0;
+}
+
+static int __maybe_unused swrm_runtime_suspend(struct device *dev)
+{
+	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	if (!ctrl->clock_stop_not_supported) {
+		/* Mask bus clash interrupt */
+		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
+		ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR, ctrl->intr_mask);
+		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
+	}
+	/* Prepare slaves for clock stop */
+	ret = sdw_bus_prep_clk_stop(&ctrl->bus);
+	if (ret < 0) {
+		dev_err(dev, "prepare clock stop failed %d", ret);
+		return ret;
+	}
+
+	ret = sdw_bus_clk_stop(&ctrl->bus);
+	if (ret < 0 && ret != -ENODATA) {
+		dev_err(dev, "bus clock stop failed %d", ret);
+		return ret;
+	}
+
+	clk_disable_unprepare(ctrl->hclk);
+
+	usleep_range(300, 305);
+
+	return 0;
+}
+
+static const struct dev_pm_ops swrm_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(swrm_runtime_suspend, swrm_runtime_resume, NULL)
+};
+
 static const struct of_device_id qcom_swrm_of_match[] = {
 	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
 	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
@@ -1359,6 +1508,7 @@ static struct platform_driver qcom_swrm_driver = {
 	.driver = {
 		.name	= "qcom-soundwire",
 		.of_match_table = qcom_swrm_of_match,
+		.pm = &swrm_dev_pm_ops,
 	}
 };
 module_platform_driver(qcom_swrm_driver);
-- 
2.21.0

