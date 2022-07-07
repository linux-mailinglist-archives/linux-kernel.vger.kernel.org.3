Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD14156A9CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiGGRhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiGGRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:37:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43D53D38;
        Thu,  7 Jul 2022 10:37:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r21so4874237eju.0;
        Thu, 07 Jul 2022 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PsjitoP8X4csfgh+EfeOV0/lVCQ3q/lBLUKmsZbTedY=;
        b=er3DVhP5d2eDhPxQBeGJ6kJM6217Xq/EDxUgvtx2xC2pdQ/cDPdlcThuSxybFC3fV0
         eWyw0hX1I1SpIbXtjSOX0lg6TdN7Bc7pD4nkRzECWhHqVg6cJ+os8274sPabghd5XTno
         sX1euRXERpLMW8bcHv8QlR3BnWMis1U+Ag0JF1HAFEfcs8TELLDxTWmhSxDAak4toYiF
         GSzFvNK51GwxjieFV7r4uTf1H6CRUjOdTeCBKkZ+/v9+sAJvjeO25Or55CyPqqdh0Wmz
         RkSitlX6lvI+iGs3geZcrHvXy5BqGrCzmJ3nMw7D9PnqWUQuj76rsDyPCxUdUsUh96s0
         7Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PsjitoP8X4csfgh+EfeOV0/lVCQ3q/lBLUKmsZbTedY=;
        b=MaMI1nHO8PTAdZSqKQWq+4bw761KAeL+b5x+VL1Cak/YwlIF/elEHy3Ct6eS6TaYOz
         vI3OkBg8mml2BlDX+ff/uv7/Xum8CG2O55OjwlTBfxqXz4IQr7h6VGkkytXC976rid/9
         jSXCSZnT9oaWl/K5UcAiDJyQJ8wtCZtcp75Zrbvrj1iEr3Gtj1xF/Izke8y4CWhD+xpw
         iWoV3XYUI/ynFhOu/EFvljuS+IgY2U0DQJpBoFYZs6DrTV9/RHMuRf8LK7ZnVu+pBlbg
         dOJGH8fxst7RtGDJcklmXtWDPGj6CGrxmlaHeBbsnw9+PeVzOGSA1YlPHXnniVxJaB7M
         T5Tg==
X-Gm-Message-State: AJIora+Ipv86VvIBAnLsYZ60TGyLI/CPWdWdZcjQFM8b8YdNodBzuTY7
        y97iLJ1K6GlE7Q2PJRB08YM=
X-Google-Smtp-Source: AGRyM1vuQUcVbv/4yEx/Y2IsTPvKiFjTxTK9IecZiGFAI85ew94nVm2Q7nV3RGRls2/LttaQQY3SLg==
X-Received: by 2002:a17:907:94ca:b0:726:f4de:535b with SMTP id dn10-20020a17090794ca00b00726f4de535bmr46383722ejc.590.1657215456651;
        Thu, 07 Jul 2022 10:37:36 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id l10-20020a1709060cca00b0072b16ea4795sm674715ejh.48.2022.07.07.10.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:37:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 1/4] mailbox: qcom-apcs-ipc: make regmap max_register configurable
Date:   Thu,  7 Jul 2022 19:37:30 +0200
Message-Id: <20220707173733.404947-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APCS register space in IPQ8074 is 0x6000 so regmap max_register needs to
be 0x5ffc.

Instead of making it global, make max_register configurable via match data.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 80a54d81412e..c05f3276d02c 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -27,6 +27,7 @@ struct qcom_apcs_ipc {
 struct qcom_apcs_ipc_data {
 	int offset;
 	char *clk_name;
+	unsigned int max_register;
 };
 
 static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
@@ -53,7 +54,7 @@ static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
 	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
 };
 
-static const struct regmap_config apcs_regmap_config = {
+static struct regmap_config apcs_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -91,12 +92,17 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	apcs_data = of_device_get_match_data(&pdev->dev);
+	if (!apcs_data)
+		return -ENODATA;
+
+	if (apcs_data->max_register)
+		apcs_regmap_config.max_register = apcs_data->max_register;
+
 	regmap = devm_regmap_init_mmio(&pdev->dev, base, &apcs_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	apcs_data = of_device_get_match_data(&pdev->dev);
-
 	apcs->regmap = regmap;
 	apcs->offset = apcs_data->offset;
 
-- 
2.36.1

