Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF25279E6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiEOUbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiEOUb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:31:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05E5FEC;
        Sun, 15 May 2022 13:31:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd25so3355819edb.3;
        Sun, 15 May 2022 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzxGK66oNP5EqUefEbuvx65uQZvfKjOjhE65FjoDOMc=;
        b=hoKt9d8+dKND6Y6Bwsc8ypDLly19+Ewi/s13gjFFKg67ZgbfWM+I8A8eJQ4bJhwNw3
         NZ1IDZPxtmBRBIlzAiefyAtajH2ZmXa+Ut+d5Y+7sHoSQD0xkFd6YK8c36hJ4rxGTqlm
         /IfM3fFQXty9jCWH83xiSPU/zexhOZnWRaI4yyQw8u2Pd7/izbovPn3FPp1W8H7u+pv9
         MBgz4DtiFyIccF5tGPCZoSPt2fES4ZWesMtg1uEJzeg2XKXH++i6RT/JcXOQ+VjdKjF3
         yglYZ4i+acrqy627qTQRy4swy8RytTXqhjdAZwNeSngYEWB+BF7WzxD5os2f81dTbnjh
         genQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzxGK66oNP5EqUefEbuvx65uQZvfKjOjhE65FjoDOMc=;
        b=L7qp3oAafX/afOZCH4MZvqh5O0cjgJUSXL6NOuTK8g0XL6cx5eRZyf5rRjfCPCblKn
         jRbegtBgq74EXYoZD8g/PFVAAh/+gEohtlGa0nWePQTwGqlpoXzxfQqzb0BMryC0NZBB
         WBVcGGvy1JxLbHxAPTKYWp0xW7Lhl+RGVOdyvhoJiF3Qf8rpwmSD7izLcQoPrrrVi5YJ
         N7QR0qH4Qrv/3DQReMFt1SaZ45CQ9cQXkPjMKQk/IH/Gb0TMY8ESYx82rfoXi48NydPI
         S9BpevNODK46jvIByvYfVqcUluRE0ZI8rOlKAt4qdyNIEFWowjL6sgTnMbgcZdvoEPYf
         vh7w==
X-Gm-Message-State: AOAM533M69bOAO39D/c6n2ifRsojtgbgo18zhPVuLPGz+ZTY/ke/idYZ
        jj80B81pW6XHrSQFDXPQbsdc75n0XpA=
X-Google-Smtp-Source: ABdhPJyb74RJcWIEYubGmbz8xaQt2Fz2l8jFS1qtV6F7iSnoqELAjmlPQcyYwdu8RxTezVJrLvKbYA==
X-Received: by 2002:a05:6402:90d:b0:428:bda9:3e6b with SMTP id g13-20020a056402090d00b00428bda93e6bmr9829164edz.132.1652646685338;
        Sun, 15 May 2022 13:31:25 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e4esm2944884ejb.180.2022.05.15.13.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:31:25 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 4/6] regulator: qcom_spmi: Add support for PMP8074 regulators
Date:   Sun, 15 May 2022 22:31:16 +0200
Message-Id: <20220515203118.474684-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515203118.474684-1-robimarko@gmail.com>
References: <20220515203118.474684-1-robimarko@gmail.com>
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

PMP8074 is a companion PMIC for the Qualcomm IPQ8074 WiSoC-s.

It features 5 HF-SMPS and 13 LDO regulators.

This commit adds support for S3 and S4 HF-SMPS buck regulators of
the HFS430 type and LDO11 of the HT_P150 type.
S3 is the CPU cluster voltage supply, S4 supplies the UBI32 NPU cores
and LDO11 is the SDIO/eMMC I/O voltage regulator required for high speeds.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 38bbc70241ae..696b088aae40 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2137,6 +2137,13 @@ static const struct spmi_regulator_data pms405_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pmp8074_regulators[] = {
+	{ "s3", 0x1a00, "vdd_s3"},
+	{ "s4", 0x1d00, "vdd_s4"},
+	{ "l11", 0x4a00, "vdd_l10_l11_l12_l13"},
+	{ }
+};
+
 static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
 	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
@@ -2150,6 +2157,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
 	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
+	{ .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
-- 
2.36.1

