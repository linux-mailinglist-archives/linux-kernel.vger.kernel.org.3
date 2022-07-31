Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7001F5861CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiGaWim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiGaWiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:38:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE81612D02;
        Sun, 31 Jul 2022 15:38:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k26so1584737ejx.5;
        Sun, 31 Jul 2022 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zzQtmXYo19tTnoTp3E47XRnsCLGiHaHOS6TlMKpVgLs=;
        b=VBV7feyRAdDqQY+DMgGfCLt4vt0saT0aHANbmDE8ieiaHJsbSAZA92r6XRGM2SIz/X
         ITupTNMVA9UrBFdWMPyo78kfLG0k3UrJOsATnCr5P05J2uWzufO+5dBIL7+TKAH3zUFo
         v8NF0fw85hbKLjQPM8Ox40bg0jnF8WumKDrn4MluZZMRkGcTDGbc2T2kHqnBOWCSNgBN
         FA6m4ueiNPRgOjYeeHBKka9Trmhlt/3Hhtg5TCyJnUja6YxTvGvC82Wsc6oVoz+6N8oL
         n6i7jjmzatn8l4BJm6z1DVClOlm5kpqdP1VRTcGgDE0nGMBPtnjimbGl8Eya96WOx6Q8
         P/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zzQtmXYo19tTnoTp3E47XRnsCLGiHaHOS6TlMKpVgLs=;
        b=qbAMSlBKNjmKLpkXq3Gw0m5kgwZ0Ana11YWAxjPOdO7hX0IryzFoQmT/5LiseH5OLo
         5OPYlx92IfP1OF+fjBD0GSPJRYZXv3sUQoXR/mmGCqGcUcIg5YVMz/HifJVfkihWvanq
         qkMcrVTWXwgBWI9olG8GpjY7ctImRP8+SAQsB6nPch/ZeGzbsFHNLL7HdZnZ+7WPW3TF
         HOKsjleCmPyhctSqQyQXtneb5gs4IaDsfxEZOe9d4UHX2GWe4sUN36BFLOCy5bWJuOE5
         9PhDiFdO9QxJEpfwn+KhP+zVYc1eCJBDp5YTQ1GZyZtEjGwDSHkFxfNWFiSxBveK/pcb
         OxUQ==
X-Gm-Message-State: AJIora+DpTnHbis40kaAqlLAYBAjux8c/IRnI0D+EGDn6bZleXDh14dl
        IteO6VjWvms2jepRzMrhiHs=
X-Google-Smtp-Source: AGRyM1vziHhGNp4mKEQxzfiD7GX/kqH2DTFYIRu0DIrZ7Al/off6On8VNUlyrg5rOXjh8JXiFcsiQQ==
X-Received: by 2002:a17:907:9483:b0:72f:6e4f:f54c with SMTP id dm3-20020a170907948300b0072f6e4ff54cmr10458502ejc.471.1659307086939;
        Sun, 31 Jul 2022 15:38:06 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7d88f000000b0043ccd4d15eesm5867466edq.64.2022.07.31.15.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:38:06 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 09/13] regulator: qcom_spmi: Add PM6125 PMIC support
Date:   Mon,  1 Aug 2022 01:37:32 +0300
Message-Id: <20220731223736.1036286-10-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731223736.1036286-1-iskren.chernev@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pm6125 regulators and their sources in the QCom SPMI driver.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index d4dba02ad6a6..85afcb55c4ec 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2026,6 +2026,41 @@ static int spmi_regulator_of_parse(struct device_node *node,
 	return 0;
 }
 
+static const struct spmi_regulator_data pm6125_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1" },
+	{ "s2", 0x1700, "vdd_s2" },
+	{ "s3", 0x1a00, "vdd_s3" },
+	{ "s4", 0x1d00, "vdd_s4" },
+	{ "s5", 0x2000, "vdd_s5" },
+	{ "s6", 0x2300, "vdd_s6" },
+	{ "s7", 0x2600, "vdd_s7" },
+	{ "s8", 0x2900, "vdd_s8" },
+	{ "l1", 0x4000, "vdd_l1_l7_l17_l18" },
+	{ "l2", 0x4100, "vdd_l2_l3_l4" },
+	{ "l3", 0x4200, "vdd_l2_l3_l4" },
+	{ "l4", 0x4300, "vdd_l2_l3_l4" },
+	{ "l5", 0x4400, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l6", 0x4500, "vdd_l6_l8" },
+	{ "l7", 0x4600, "vdd_l1_l7_l17_l18" },
+	{ "l8", 0x4700, "vdd_l6_l8" },
+	{ "l9", 0x4800, "vdd_l9_l11" },
+	{ "l10", 0x4900, "vdd_l10_l13_l14" },
+	{ "l11", 0x4a00, "vdd_l9_l11" },
+	{ "l12", 0x4b00, "vdd_l12_l16" },
+	{ "l13", 0x4c00, "vdd_l10_l13_l14" },
+	{ "l14", 0x4d00, "vdd_l10_l13_l14" },
+	{ "l15", 0x4e00, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l16", 0x4f00, "vdd_l12_l16" },
+	{ "l17", 0x5000, "vdd_l1_l7_l17_l18" },
+	{ "l18", 0x5100, "vdd_l1_l7_l17_l18" },
+	{ "l19", 0x5200, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l20", 0x5300, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l21", 0x5400, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l22", 0x5500, "vdd_l5_l15_l19_l20_l21_l22" },
+	{ "l23", 0x5600, "vdd_l23_l24" },
+	{ "l24", 0x5700, "vdd_l23_l24" },
+};
+
 static const struct spmi_regulator_data pm660_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
@@ -2320,6 +2355,7 @@ static const struct spmi_regulator_data pms405_regulators[] = {
 };
 
 static const struct of_device_id qcom_spmi_regulator_match[] = {
+	{ .compatible = "qcom,pm6125-regulators", .data = &pm6125_regulators },
 	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
 	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
-- 
2.37.1

