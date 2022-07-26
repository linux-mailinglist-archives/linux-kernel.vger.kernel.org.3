Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED27A58197F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbiGZSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbiGZSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:11:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C242A723;
        Tue, 26 Jul 2022 11:11:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id oy13so27617184ejb.1;
        Tue, 26 Jul 2022 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fDeC2/O0ScVBXWJxW1D+FsTv152EB1H0r+OvJHX10Vo=;
        b=Kk+q4Tfa55cHPQVU+mKj509kkOzr7DwZfj32S5g7TzeYPuMViJr4BApGbwihLxi6JZ
         gIzY4zYSVJod8Naa6cjsImC3bVBp3/AthguHHx7L5WkIrOtIKemJU96VFOuxVtkj0fRv
         oqW5aPzCYqqkuoCji+IPwLYs8Z5Nm9bEFXKKQPtkwc66ZHb7yIGZX1ucjeBhGNWhSUtR
         WnGvXY8vQYIX2g3kWdrwE+waJjer9m2E44bILq43iuyHipaepsK+MM5fEsfOqocsUYfm
         blncBDvXOyMsuv9l/9OZjoZUa4u0WoYqBRfrHo+NQoqXSb3QsRNo3Xf1HIh3ZiCPrLR4
         w/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fDeC2/O0ScVBXWJxW1D+FsTv152EB1H0r+OvJHX10Vo=;
        b=BsByZT2VzaGiWVHkONDEZ9HR7TahtiWG2uqI1I6h1y3g9tZSx7awIk/jM2FluzPCJT
         sQbBxgRE2hN1hnLSPVPD5M3cfgE472UljdNGpxvYZELT1be1ujpwJTt5OWjcZa+kUmG9
         HtAkTa7E/okbl8JIbKHsylXj3zWWFeVDGoPz9v1XtQ8lXFxCI0HHcKv1C2r8Y+hPEaDi
         spzfFk2pf82fNJoY3/38vOiRfYG6OH6x+kiqc92G10V0RXsl7VA/BZn5v9c6DUpWlY1k
         IKjgA2HFAK/pfEYkqXFwLq2+6EpyrpB+0gOJUhBGmAFu0zDee6TvuJrcOECkz9wUvrkL
         B+cA==
X-Gm-Message-State: AJIora/nwyhRKzRevfRFDVrbmG2mJfQ8yU++OzvL7/iullsftK9HODWl
        GxGT/MC7MJG/jU7zGxxiEXY=
X-Google-Smtp-Source: AGRyM1vpBg02hDbmXZ8IR/3/+q4y0Bv6e5Jz5SAbe6SqK6d9nM1zf2iedzqsFArrYOhkXD/CiInu1w==
X-Received: by 2002:a17:906:8479:b0:72b:83cf:4cf3 with SMTP id hx25-20020a170906847900b0072b83cf4cf3mr14726660ejc.90.1658859104872;
        Tue, 26 Jul 2022 11:11:44 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id p9-20020a056402074900b00431962fe5d4sm8851511edy.77.2022.07.26.11.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 11:11:44 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 4/5] regulator: qcom_spmi: Add PM6125 PMIC support
Date:   Tue, 26 Jul 2022 21:11:32 +0300
Message-Id: <20220726181133.3262695-5-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726181133.3262695-1-iskren.chernev@gmail.com>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
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

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 37 ++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index efb3f6fffb4f..ca19b4404ea9 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1993,6 +1993,41 @@ static int spmi_regulator_of_parse(struct device_node *node,
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
 static const struct spmi_regulator_data pm8941_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
@@ -2245,7 +2280,6 @@ static const struct spmi_regulator_data pm660l_regulators[] = {
 	{ }
 };

-
 static const struct spmi_regulator_data pm8004_regulators[] = {
 	{ "s2", 0x1700, "vdd_s2", },
 	{ "s5", 0x2000, "vdd_s5", },
@@ -2288,6 +2322,7 @@ static const struct spmi_regulator_data pms405_regulators[] = {
 };

 static const struct of_device_id qcom_spmi_regulator_match[] = {
+	{ .compatible = "qcom,pm6125-regulators", .data = &pm6125_regulators },
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
 	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
 	{ .compatible = "qcom,pm8226-regulators", .data = &pm8226_regulators },
--
2.37.1

