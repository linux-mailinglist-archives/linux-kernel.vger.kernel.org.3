Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE25773D3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiGQDlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiGQDlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:41:45 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA317E0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:41:43 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id u31-20020a4a9722000000b004356f5f0d8aso1672746ooi.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kr0qGAzm8HBBVFxNB4kybcwM4ZEQ9sSljeQXpuGlPaI=;
        b=ODTfDk0hpjDwRIXQj2Lx0qet0bex/33ZfrclGkb9RVs4eCYslDj2gohhJyI6vR6e5p
         GzJ3Iy/2/9ky+VNYUKWvCESj2w4IK6zJPo1w8hpHGMLWukuGBrM6vzzr6ZSIgf8joJMP
         JCBMJZ3BaBF5GniJ9pWF8wXySfhMxgYYeC0J3g8jIldhGVkeiESkCE37MJwRjki091bj
         J0l1OB77xJb94ViokueacnfqR85DstGNwYiwvADsg/IHD+PStpoJTCyIKuM50iiwCjTr
         wQP0Xsmj/tVwLAeVQc1TM9tkUY3lsA+Bow3gR+cPr7+P3O2LUZvcTVY64tsDly9f9dkh
         xcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kr0qGAzm8HBBVFxNB4kybcwM4ZEQ9sSljeQXpuGlPaI=;
        b=l0HTOYlvaZUpIOAz/pvmNRQMlecfiEoKsjhAHF2eTeJuY182zB9L+SxcSgzl8ZsfH3
         sIfxXsxe5+f1grUGrGpe6U8HZJx/saG8YLs7Bwk5n9w8Pjmk5bgm4BgJfZn/QaxkjeEz
         n2QU4Zcy98hpgK4y+OgWC/KEvBFTRpRBBxIAPkK6dOJQBKze/LIlLvzAQPvo0Of2l98N
         F9E4b8tcS6nubyW1QiIXUbrLozWUUaOL90aQqSpd41rkeiwmb1WHYEQgOOOAMF7edEVe
         SQVt6lI+knZ9iBqCoJTp9JdErWBv/790d+2e1F4kuU5Olfl3J8yylAKZ6JyI7qWOZdFY
         rh+Q==
X-Gm-Message-State: AJIora+FHKJrMzU4T6WF2Jr55IouZh74iNOypOanR128ntH4kseEBp/R
        NB87fTHB+G6kKgysgO8Yh/fKxg==
X-Google-Smtp-Source: AGRyM1vuhjY/pty6OdhIa9rVreiJV2Lat6EJmugCZW/DSbxrH5c2+FatYmQq0ZIA7iwv2G//VYFo3g==
X-Received: by 2002:a4a:d032:0:b0:435:7d2e:7093 with SMTP id w18-20020a4ad032000000b004357d2e7093mr3565409oor.34.1658029302939;
        Sat, 16 Jul 2022 20:41:42 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p4-20020a544604000000b00326cb6225f8sm3218010oip.44.2022.07.16.20.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:41:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vinod.koul@linaro.org
Subject: [PATCH 1/3] arm64: dts: qcom: sdm845: Fill in GENI DMA references
Date:   Sat, 16 Jul 2022 20:44:01 -0700
Message-Id: <20220717034403.2135027-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220717034403.2135027-1-bjorn.andersson@linaro.org>
References: <20220717034403.2135027-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C and SPI might be configured in GPI DMA mode, fill in the
properties needed for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 90 ++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 7fb10c2ef2fb..7735efd233e4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1208,6 +1208,9 @@ i2c0: i2c@880000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1262,6 +1265,9 @@ i2c1: i2c@884000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1278,6 +1284,9 @@ spi1: spi@884000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1313,6 +1322,9 @@ i2c2: i2c@888000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1329,6 +1341,9 @@ spi2: spi@888000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1364,6 +1379,9 @@ i2c3: i2c@88c000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1380,6 +1398,9 @@ spi3: spi@88c000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1415,6 +1436,9 @@ i2c4: i2c@890000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1431,6 +1455,9 @@ spi4: spi@890000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1466,6 +1493,9 @@ i2c5: i2c@894000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1482,6 +1512,9 @@ spi5: spi@894000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1517,6 +1550,9 @@ i2c6: i2c@898000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1533,6 +1569,9 @@ spi6: spi@898000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1580,6 +1619,9 @@ spi7: spi@89c000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1653,6 +1695,9 @@ i2c8: i2c@a80000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1669,6 +1714,9 @@ spi8: spi@a80000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1704,6 +1752,9 @@ i2c9: i2c@a84000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1720,6 +1771,9 @@ spi9: spi@a84000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1755,6 +1809,9 @@ i2c10: i2c@a88000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1771,6 +1828,9 @@ spi10: spi@a88000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1806,6 +1866,9 @@ i2c11: i2c@a8c000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1822,6 +1885,9 @@ spi11: spi@a8c000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1857,6 +1923,9 @@ i2c12: i2c@a90000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1873,6 +1942,9 @@ spi12: spi@a90000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1908,6 +1980,9 @@ i2c13: i2c@a94000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1924,6 +1999,9 @@ spi13: spi@a94000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1959,6 +2037,9 @@ i2c14: i2c@a98000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -1975,6 +2056,9 @@ spi14: spi@a98000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -2011,6 +2095,9 @@ i2c15: i2c@a9c000 {
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>,
 						<&aggre2_noc MASTER_QUP_2 0 &mem_noc SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
 			};
 
 			spi15: spi@a9c000 {
@@ -2026,6 +2113,9 @@ spi15: spi@a9c000 {
 				interconnects = <&aggre2_noc MASTER_QUP_2 0 &config_noc SLAVE_BLSP_2 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_2 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma1 0 7 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 7 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
-- 
2.35.1

