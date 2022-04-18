Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81209505588
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiDRNJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbiDRM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:57:11 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531AB1B7B4;
        Mon, 18 Apr 2022 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650285481; x=1681821481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=G6R3PT+c1qljHd/QwpowpiO0WMYWMpqidUIpPs1bHbY=;
  b=mAXyFdocJbFUtutJlNwgHKcwvrGC+oQ5y/7DDqQgkurpWHlPP8RgnsYz
   QIG9S60pHB3cg+ooAqu8O1B+uO4mUfikmJAvy+r75/P9X7Gq6h7CM4qZE
   OprspUEHQGn4AhQTPrSu9pIHzc0MkhLSjfyRSZjDdpv47vMweuzO92xxe
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Apr 2022 05:38:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 05:38:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 05:37:59 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 05:37:53 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v13 4/7] pinctrl: qcom: Update lpi pin group custiom functions with framework generic functions
Date:   Mon, 18 Apr 2022 18:07:04 +0530
Message-ID: <1650285427-19752-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650285427-19752-1-git-send-email-quic_srivasam@quicinc.com>
References: <1650285427-19752-1-git-send-email-quic_srivasam@quicinc.com>
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

Update custom pin group structure members with framework generic
group_desc structure and replace the driver's custom pinctrl_ops
with framework provided generic pin control group functions to avoid
redundant code written in lpass lpi driver.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/pinctrl/qcom/Kconfig             |   1 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 102 +++++++++++++++----------------
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index c51ef54..d2bcf88 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -360,6 +360,7 @@ config PINCTRL_LPASS_LPI
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
 	depends on GPIOLIB
 	help
 	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 3c15f80..3228c45 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -51,11 +51,11 @@
 
 #define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
 	{						\
-		.name = "gpio" #id,			\
-		.pins = gpio##id##_pins,		\
+		.group.name = "gpio" #id,			\
+		.group.pins = gpio##id##_pins,		\
 		.pin = id,				\
 		.slew_offset = soff,			\
-		.npins = ARRAY_SIZE(gpio##id##_pins),	\
+		.group.num_pins = ARRAY_SIZE(gpio##id##_pins),	\
 		.funcs = (int[]){			\
 			LPI_MUX_gpio,			\
 			LPI_MUX_##f1,			\
@@ -67,9 +67,7 @@
 	}
 
 struct lpi_pingroup {
-	const char *name;
-	const unsigned int *pins;
-	unsigned int npins;
+	struct group_desc group;
 	unsigned int pin;
 	/* Bit offset in slew register for SoundWire pins only */
 	int slew_offset;
@@ -150,20 +148,20 @@ enum sm8250_lpi_functions {
 	LPI_MUX__,
 };
 
-static const unsigned int gpio0_pins[] = { 0 };
-static const unsigned int gpio1_pins[] = { 1 };
-static const unsigned int gpio2_pins[] = { 2 };
-static const unsigned int gpio3_pins[] = { 3 };
-static const unsigned int gpio4_pins[] = { 4 };
-static const unsigned int gpio5_pins[] = { 5 };
-static const unsigned int gpio6_pins[] = { 6 };
-static const unsigned int gpio7_pins[] = { 7 };
-static const unsigned int gpio8_pins[] = { 8 };
-static const unsigned int gpio9_pins[] = { 9 };
-static const unsigned int gpio10_pins[] = { 10 };
-static const unsigned int gpio11_pins[] = { 11 };
-static const unsigned int gpio12_pins[] = { 12 };
-static const unsigned int gpio13_pins[] = { 13 };
+static int gpio0_pins[] = { 0 };
+static int gpio1_pins[] = { 1 };
+static int gpio2_pins[] = { 2 };
+static int gpio3_pins[] = { 3 };
+static int gpio4_pins[] = { 4 };
+static int gpio5_pins[] = { 5 };
+static int gpio6_pins[] = { 6 };
+static int gpio7_pins[] = { 7 };
+static int gpio8_pins[] = { 8 };
+static int gpio9_pins[] = { 9 };
+static int gpio10_pins[] = { 10 };
+static int gpio11_pins[] = { 11 };
+static int gpio12_pins[] = { 12 };
+static int gpio13_pins[] = { 13 };
 static const char * const swr_tx_clk_groups[] = { "gpio0" };
 static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
 static const char * const swr_rx_clk_groups[] = { "gpio3" };
@@ -250,38 +248,10 @@ static int lpi_gpio_write(struct lpi_pinctrl *state, unsigned int pin,
 	return 0;
 }
 
-static int lpi_gpio_get_groups_count(struct pinctrl_dev *pctldev)
-{
-	struct lpi_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->data->ngroups;
-}
-
-static const char *lpi_gpio_get_group_name(struct pinctrl_dev *pctldev,
-					   unsigned int group)
-{
-	struct lpi_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->data->groups[group].name;
-}
-
-static int lpi_gpio_get_group_pins(struct pinctrl_dev *pctldev,
-				   unsigned int group,
-				   const unsigned int **pins,
-				   unsigned int *num_pins)
-{
-	struct lpi_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	*pins = pctrl->data->groups[group].pins;
-	*num_pins = pctrl->data->groups[group].npins;
-
-	return 0;
-}
-
 static const struct pinctrl_ops lpi_gpio_pinctrl_ops = {
-	.get_groups_count	= lpi_gpio_get_groups_count,
-	.get_group_name		= lpi_gpio_get_group_name,
-	.get_group_pins		= lpi_gpio_get_group_pins,
+	.get_groups_count	= pinctrl_generic_get_group_count,
+	.get_group_name		= pinctrl_generic_get_group_name,
+	.get_group_pins		= pinctrl_generic_get_group_pins,
 	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
 	.dt_free_map		= pinctrl_utils_free_map,
 };
@@ -582,6 +552,28 @@ static const struct gpio_chip lpi_gpio_template = {
 	.dbg_show		= lpi_gpio_dbg_show,
 };
 
+static int lpi_build_pin_desc_groups(struct lpi_pinctrl *pctrl)
+{
+	int i, ret;
+
+	for (i = 0; i < pctrl->data->npins; i++) {
+		const struct pinctrl_pin_desc *pin_info = pctrl->desc.pins + i;
+
+		ret = pinctrl_generic_add_group(pctrl->ctrl, pin_info->name,
+						  (int *)&pin_info->number, 1, NULL);
+		if (ret < 0)
+			goto err_pinctrl;
+	}
+
+	return 0;
+
+err_pinctrl:
+	for (; i > 0; i--)
+		pinctrl_generic_remove_group(pctrl->ctrl, i - 1);
+
+	return ret;
+}
+
 static int lpi_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct lpi_pinctrl_variant_data *data;
@@ -647,6 +639,10 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
 		goto err_pinctrl;
 	}
 
+	ret = lpi_build_pin_desc_groups(pctrl);
+	if (ret)
+		goto err_pinctrl;
+
 	ret = devm_gpiochip_add_data(dev, &pctrl->chip, pctrl);
 	if (ret) {
 		dev_err(pctrl->dev, "can't add gpio chip\n");
@@ -665,10 +661,14 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
 static int lpi_pinctrl_remove(struct platform_device *pdev)
 {
 	struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
+	int i;
 
 	mutex_destroy(&pctrl->slew_access_lock);
 	clk_bulk_disable_unprepare(MAX_LPI_NUM_CLKS, pctrl->clks);
 
+	for (i = 0; i < pctrl->data->npins; i++)
+		pinctrl_generic_remove_group(pctrl->ctrl, i);
+
 	return 0;
 }
 
-- 
2.7.4

