Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CB455D613
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiF0Hu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiF0Hu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:50:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096E2DD3;
        Mon, 27 Jun 2022 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656316257; x=1687852257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=h/AoKKoXNc3Rq8V2c3hlG/7uD1Te+5Trb9BH8fj762M=;
  b=uM22t4eanplIaWh8mq7RPOSBKNQ73n7vIvzvKQwQstl0Ugr8GgbhTS/g
   6oGSbQQcqI7IcuAhYuYqM9A0FyBLv+xjJDNL1gGL0VkFMvmxxqDMBSkfn
   EbIQ6f1Fbry7qoEit8YkA3fc0BIl7sDzvfeYmrfaA3b6gM57Wl15yHw4F
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jun 2022 00:50:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 00:50:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 00:50:00 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 00:49:54 -0700
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
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 2/2] pinctrl: qcom: sc7280: Add clock optional check for ADSP bypass targets
Date:   Mon, 27 Jun 2022 13:19:24 +0530
Message-ID: <1656316164-28666-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656316164-28666-1-git-send-email-quic_srivasam@quicinc.com>
References: <1656316164-28666-1-git-send-email-quic_srivasam@quicinc.com>
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

Update lpass lpi pin control driver, with clock optional check for ADSP
disabled platforms. This check required for distingushing ADSP based
platforms and ADSP bypass platforms.
In case of ADSP enabled platforms, where audio is routed through ADSP
macro and decodec GDSC Switches are triggered as clocks by pinctrl
driver and ADSP firmware controls them. So It's mandatory to enable
them in ADSP based solutions.
In case of ADSP bypass platforms clock voting is optional as these macro
and dcodec GDSC switches are maintained as power domains and operated from
lpass clock drivers.
Remove redundant private data variable is_clk_optional.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 2 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        | 1 -
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 74810ec..e97ce45 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -401,7 +401,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
 				     "Slew resource not provided\n");
 
-	if (data->is_clk_optional)
+	if (of_property_read_bool(dev->of_node, "qcom,adsp-bypass-mode"))
 		ret = devm_clk_bulk_get_optional(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
 	else
 		ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
index 759d5d8..afbac2a 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
@@ -77,7 +77,6 @@ struct lpi_pinctrl_variant_data {
 	int ngroups;
 	const struct lpi_function *functions;
 	int nfunctions;
-	bool is_clk_optional;
 };
 
 int lpi_pinctrl_probe(struct platform_device *pdev);
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
index 2add9a4..d615b6c5 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -141,7 +141,6 @@ static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
 	.ngroups = ARRAY_SIZE(sc7280_groups),
 	.functions = sc7280_functions,
 	.nfunctions = ARRAY_SIZE(sc7280_functions),
-	.is_clk_optional = true,
 };
 
 static const struct of_device_id lpi_pinctrl_of_match[] = {
-- 
2.7.4

