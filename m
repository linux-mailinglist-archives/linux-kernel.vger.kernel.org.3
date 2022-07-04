Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD9565F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiGDVYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiGDVYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4310FF9;
        Mon,  4 Jul 2022 14:24:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v12so422725edc.10;
        Mon, 04 Jul 2022 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpQYDqqTMKvAHgyQOKIaDAZVZin4gTd/M2O8Q7thQ0s=;
        b=nscnq7g5yJ446rTwwf868cT0pibJ9Z/WeiMwSVkbo1s/s3xxa+H6jggyp6hP/1FzgS
         WQ5u+05UkLqpn1J00oSp2gy3TcLij3+CSTb7pF7IshU1ztmMtwSG+xtjZHiJ7ukyTCDq
         zz+VC9rQjPHYWHVaXWR8r5Igrvrs21VQTER+ZBJWAxqowaB7eDvLAQDVWOP4jLdGINpq
         jNoZKsS93uQHvc7AG+66lCJLz2I0jFiXVYwk3ihGPXCYATgJ8Rs5BR84cNUCryw3PDRr
         10EE/SNyOrcEhfSRetGbxcBC6+KchZzg7sq5HKbABlzyAFYjvLYjyy0Oz8u9Rr9rBfWR
         jxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpQYDqqTMKvAHgyQOKIaDAZVZin4gTd/M2O8Q7thQ0s=;
        b=NINTrIqEx+TwMulR5ozoHuhqXz2lrn1SaL1OTjmBIXrqLVZjOD3pURW0hgHQJjqv0M
         0N5dU3hEOE3J0psOHCWNzFLgLuysDZuTxgf0JM/BxDPn1Jyhq1MhQMB2G4oKGiX3rrrd
         xK2Dal0O9Oig5JdutGu4qZTqhBB2gWe5G4MysmptA4iUkQJihdC0ZohusyeegqYii3Mt
         eXJ2JUzmlxxd7GC88P2plyV7kXsfzXmLOiWy7z3iWw4g2fd8Jv97a3D1DJMJ+CerQsju
         tL6BreBn0ks/IIBYS4zrJojwij/22b0i3Tf8RD99GLqhqp0k9FDPSp4RSTRF2cezh7RW
         IT6A==
X-Gm-Message-State: AJIora94DABQzZFrd/wpd8bj/hprgccSYeWowZn0IyIlgVgnkRIqxDeC
        +INRoCuiY8RbyzZj/ni7ZXQ=
X-Google-Smtp-Source: AGRyM1s0i2L45cDGqJO0VCVY9JRf7+PMoiq0E5AZSKuGA06grf+X2ZsTKHkeTSEskkPW1PUeT/nqFA==
X-Received: by 2002:a05:6402:c47:b0:437:ce2d:c30d with SMTP id cs7-20020a0564020c4700b00437ce2dc30dmr41785629edb.395.1656969852690;
        Mon, 04 Jul 2022 14:24:12 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:12 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 07/12] regulator: qcom_spmi: add support for PMP8074 regulators
Date:   Mon,  4 Jul 2022 23:23:57 +0200
Message-Id: <20220704212402.1715182-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
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

HF-SMPS regulators are Buck HFS430 regulators.
L1, L2 and L3 are HT_N1200_ST subtype LDO regulators.
L4 is HT_N300_ST subtype LDO regulator.
L5 and L6 are HT_P600 subtype LDO regulators.
L7, L11, L12 and L13 are HT_P150 subtype LDO regulators.
L10 is HT_P50 subtype LDO regulator.

This commit adds support for all of the buck regulators and LDO-s except
for L10 as I dont have documentation on its output voltage range.

S3 is the CPU cluster voltage supply, S4 supplies the UBI32 NPU cores
and L11 is the SDIO/eMMC I/O voltage regulator required for high speeds.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Add remaining regulators, minus L11
* Sort structure and compatible
---
 drivers/regulator/qcom_spmi-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index ad9ad9f4be8e..a2d0292a92fd 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2139,6 +2139,28 @@ static const struct spmi_regulator_data pm8005_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pmp8074_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1"},
+	{ "s2", 0x1700, "vdd_s2"},
+	{ "s3", 0x1a00, "vdd_s3"},
+	{ "s4", 0x1d00, "vdd_s4"},
+	{ "s5", 0x2000, "vdd_s5"},
+	{ "l1", 0x4000, "vdd_l1_l2"},
+	{ "l2", 0x4100, "vdd_l1_l2"},
+	{ "l3", 0x4200, "vdd_l3_l8"},
+	{ "l4", 0x4300, "vdd_l4"},
+	{ "l5", 0x4400, "vdd_l5_l6_l15"},
+	{ "l6", 0x4500, "vdd_l5_l6_l15"},
+	{ "l7", 0x4600, "vdd_l7"},
+	{ "l8", 0x4700, "vdd_l3_l8"},
+	{ "l9", 0x4800, "vdd_l9"},
+	/* l10 is currently unsupported HT_P50 */
+	{ "l11", 0x4a00, "vdd_l10_l11_l12_l13"},
+	{ "l12", 0x4b00, "vdd_l10_l11_l12_l13"},
+	{ "l13", 0x4c00, "vdd_l10_l11_l12_l13"},
+	{ }
+};
+
 static const struct spmi_regulator_data pms405_regulators[] = {
 	{ "s3", 0x1a00, "vdd_s3"},
 	{ }
@@ -2156,6 +2178,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pmi8994-regulators", .data = &pmi8994_regulators },
 	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
 	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
+	{ .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
 	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
 	{ }
 };
-- 
2.36.1

