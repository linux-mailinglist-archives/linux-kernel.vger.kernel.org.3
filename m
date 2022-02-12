Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F89A4B34F1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiBLMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:25:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiBLMZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:25:02 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A408F24BE5;
        Sat, 12 Feb 2022 04:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644668699; x=1676204699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TEMYFhk0n4HsdRun8CXSQrSB6m779nzdiTPZlRDB+Wo=;
  b=O0LhFV/AaChJia2RE+/lriTBELZjJm+URj0QglwvWEWkOVaeHql4XxJM
   PW7BG7OSAFzimF85VBMrWg5kzU4O7HjLkvU++xB4F5skzZhAtXoZW009M
   a4JAud1KIMsX7R5Omr8QEIN0pibt4mFP+om6r4IJyuc66RSsdOhJ69Yac
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Feb 2022 04:24:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 04:24:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 12 Feb 2022 04:24:58 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sat, 12 Feb 2022 04:24:52 -0800
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
Subject: [PATCH 1/2] ASoC: codec: wcd938x: Add switch control for selecting CTIA/OMTP Headset
Date:   Sat, 12 Feb 2022 17:54:31 +0530
Message-ID: <1644668672-29790-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644668672-29790-1-git-send-email-quic_srivasam@quicinc.com>
References: <1644668672-29790-1-git-send-email-quic_srivasam@quicinc.com>
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

Add switch control for selecting CTIA or OMTP Headset by swapping
gnd and mic with the help of GPIO.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index eff200a..08d16a9 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -194,6 +194,7 @@ struct wcd938x_priv {
 	int ear_rx_path;
 	int variant;
 	int reset_gpio;
+	int us_euro_gpio;
 	u32 micb1_mv;
 	u32 micb2_mv;
 	u32 micb3_mv;
@@ -4196,6 +4197,33 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
 		dev_info(dev, "%s: Micbias4 DT property not found\n", __func__);
 }
 
+static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool active)
+{
+	int value;
+
+	struct wcd938x_priv *wcd938x;
+
+	if (!component) {
+		dev_err(component->dev, "%s component is NULL\n", __func__);
+		return false;
+	}
+
+	wcd938x = snd_soc_component_get_drvdata(component);
+	if (!wcd938x) {
+		dev_err(component->dev, "%s private data is NULL\n", __func__);
+		return false;
+	}
+
+	value = gpio_get_value(wcd938x->us_euro_gpio);
+
+	gpio_set_value(wcd938x->us_euro_gpio, !value);
+	/* 20us sleep required after changing the gpio state*/
+	usleep_range(20, 30);
+
+	return true;
+}
+
+
 static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device *dev)
 {
 	struct wcd_mbhc_config *cfg = &wcd938x->mbhc_cfg;
@@ -4208,6 +4236,16 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 		return wcd938x->reset_gpio;
 	}
 
+	wcd938x->us_euro_gpio = of_get_named_gpio(dev->of_node, "us-euro-gpios", 0);
+	if (wcd938x->us_euro_gpio < 0) {
+		dev_err(dev, "Failed to get us-euro-gpios gpio: err = %d\n", wcd938x->us_euro_gpio);
+	} else {
+		cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
+		gpio_direction_output(wcd938x->us_euro_gpio, 0);
+		/* 20us sleep required after pulling the reset gpio to LOW */
+		usleep_range(20, 30);
+	}
+
 	wcd938x->supplies[0].supply = "vdd-rxtx";
 	wcd938x->supplies[1].supply = "vdd-io";
 	wcd938x->supplies[2].supply = "vdd-buck";
-- 
2.7.4

