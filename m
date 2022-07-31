Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83D05861C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiGaWic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbiGaWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:38:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55212A9B;
        Sun, 31 Jul 2022 15:38:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss3so17254587ejc.11;
        Sun, 31 Jul 2022 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=S0B2Wpqg941y/P5XqiljbIJ0a4qEDSaqzoahCxJCdDQ=;
        b=fWN9/FXVbpFKUD7ZUiX7ECI+kIDabk60dMXBVdkx6DZOBdPSULN6tonaZmn6YeE/vf
         rXpe4KDYw4vOtP74L/QR8YyiTCH9TMEfGGt79uVhCCCj8Pyry11OcynIy2W3yfyZATmH
         vNOq4ZfZ1O2WcCNie8c/G7ZfyxNFW44mlhq4U9JQrL+yi4rDfDLPfq84MKbHkpK1MN/2
         1EY/xh2VfyI2fOHP9HGaGb2HOBnzTweJyX/NUYqsp7bmjAdzz9qZP3m4M3w5x/rHYQVC
         fllxJ+0vm3ZrA/nZ4TGBfpWDiSv+IVJPg0sOBOs6fS4Osq81Lgqd+LyJhM2L2mS+w4vT
         /Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=S0B2Wpqg941y/P5XqiljbIJ0a4qEDSaqzoahCxJCdDQ=;
        b=G0NThTxF0WEoHg07e8TySN+owNFgh7N+mGghpqTJ5X/XH+OcdJ9XrnLZNkrAM8SstH
         buTcwMZNVF6MkNF/U0oqA3y9xfKXoeY9ThKr4zzBLH6LriWRq1F9qrRP8v/34Za6Lqoa
         8KJg5JEwK+ZAPV9i4oeMDmL8y+LeXwXKdlIRYHE3r5ZiEvswOscD9p7d/vlGi+S4KSal
         QM2KVdgl+FMYOe1sg3ujGNKr49W5vvxsyPqgFsm3PhIo8FUKDJGekTPdMeSmzrQrWcId
         Xuar0zefKwxg8r+xraH8N3g/4viGjLgUL92zOv7Q/MMngHlgH8gP9xLnklRFIuJRHkW+
         TjXw==
X-Gm-Message-State: AJIora8BJH6nLm2fFseu5Z3s/7KRUWwca0YxWFgVs2XKpDkR5SCa+OeZ
        mVjQwI5lhwceZ8bPWP8fn+I=
X-Google-Smtp-Source: AGRyM1uE7Ht91twAmx+3qPJ7FjJrtPoCCctJOpwHjhRs+1pZ6TJcf58eN/N8OPtJt4hCa8/P/GEurQ==
X-Received: by 2002:a17:907:2887:b0:72b:68ce:2fff with SMTP id em7-20020a170907288700b0072b68ce2fffmr10311511ejc.423.1659307081369;
        Sun, 31 Jul 2022 15:38:01 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id h5-20020a056402094500b0043c8ad3c38fsm5893514edz.58.2022.07.31.15.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:38:00 -0700 (PDT)
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
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 07/13] regulator: qcom_spmi: Sort pmics alphabetically (part 1)
Date:   Mon,  1 Aug 2022 01:37:30 +0300
Message-Id: <20220731223736.1036286-8-iskren.chernev@gmail.com>
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

The sorting is split in multiple commits for easier reviewing.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 74 ++++++++++++-------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 19af294a6972..bbb464717afa 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2026,43 +2026,6 @@ static int spmi_regulator_of_parse(struct device_node *node,
 	return 0;
 }
 
-static const struct spmi_regulator_data pm8941_regulators[] = {
-	{ "s1", 0x1400, "vdd_s1", },
-	{ "s2", 0x1700, "vdd_s2", },
-	{ "s3", 0x1a00, "vdd_s3", },
-	{ "s4", 0xa000, },
-	{ "l1", 0x4000, "vdd_l1_l3", },
-	{ "l2", 0x4100, "vdd_l2_lvs_1_2_3", },
-	{ "l3", 0x4200, "vdd_l1_l3", },
-	{ "l4", 0x4300, "vdd_l4_l11", },
-	{ "l5", 0x4400, "vdd_l5_l7", NULL, 0x0410 },
-	{ "l6", 0x4500, "vdd_l6_l12_l14_l15", },
-	{ "l7", 0x4600, "vdd_l5_l7", NULL, 0x0410 },
-	{ "l8", 0x4700, "vdd_l8_l16_l18_19", },
-	{ "l9", 0x4800, "vdd_l9_l10_l17_l22", },
-	{ "l10", 0x4900, "vdd_l9_l10_l17_l22", },
-	{ "l11", 0x4a00, "vdd_l4_l11", },
-	{ "l12", 0x4b00, "vdd_l6_l12_l14_l15", },
-	{ "l13", 0x4c00, "vdd_l13_l20_l23_l24", },
-	{ "l14", 0x4d00, "vdd_l6_l12_l14_l15", },
-	{ "l15", 0x4e00, "vdd_l6_l12_l14_l15", },
-	{ "l16", 0x4f00, "vdd_l8_l16_l18_19", },
-	{ "l17", 0x5000, "vdd_l9_l10_l17_l22", },
-	{ "l18", 0x5100, "vdd_l8_l16_l18_19", },
-	{ "l19", 0x5200, "vdd_l8_l16_l18_19", },
-	{ "l20", 0x5300, "vdd_l13_l20_l23_l24", },
-	{ "l21", 0x5400, "vdd_l21", },
-	{ "l22", 0x5500, "vdd_l9_l10_l17_l22", },
-	{ "l23", 0x5600, "vdd_l13_l20_l23_l24", },
-	{ "l24", 0x5700, "vdd_l13_l20_l23_l24", },
-	{ "lvs1", 0x8000, "vdd_l2_lvs_1_2_3", },
-	{ "lvs2", 0x8100, "vdd_l2_lvs_1_2_3", },
-	{ "lvs3", 0x8200, "vdd_l2_lvs_1_2_3", },
-	{ "5vs1", 0x8300, "vin_5vs", "ocp-5vs1", },
-	{ "5vs2", 0x8400, "vin_5vs", "ocp-5vs2", },
-	{ }
-};
-
 static const struct spmi_regulator_data pm8226_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
@@ -2139,6 +2102,43 @@ static const struct spmi_regulator_data pm8916_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pm8941_regulators[] = {
+	{ "s1", 0x1400, "vdd_s1", },
+	{ "s2", 0x1700, "vdd_s2", },
+	{ "s3", 0x1a00, "vdd_s3", },
+	{ "s4", 0xa000, },
+	{ "l1", 0x4000, "vdd_l1_l3", },
+	{ "l2", 0x4100, "vdd_l2_lvs_1_2_3", },
+	{ "l3", 0x4200, "vdd_l1_l3", },
+	{ "l4", 0x4300, "vdd_l4_l11", },
+	{ "l5", 0x4400, "vdd_l5_l7", NULL, 0x0410 },
+	{ "l6", 0x4500, "vdd_l6_l12_l14_l15", },
+	{ "l7", 0x4600, "vdd_l5_l7", NULL, 0x0410 },
+	{ "l8", 0x4700, "vdd_l8_l16_l18_19", },
+	{ "l9", 0x4800, "vdd_l9_l10_l17_l22", },
+	{ "l10", 0x4900, "vdd_l9_l10_l17_l22", },
+	{ "l11", 0x4a00, "vdd_l4_l11", },
+	{ "l12", 0x4b00, "vdd_l6_l12_l14_l15", },
+	{ "l13", 0x4c00, "vdd_l13_l20_l23_l24", },
+	{ "l14", 0x4d00, "vdd_l6_l12_l14_l15", },
+	{ "l15", 0x4e00, "vdd_l6_l12_l14_l15", },
+	{ "l16", 0x4f00, "vdd_l8_l16_l18_19", },
+	{ "l17", 0x5000, "vdd_l9_l10_l17_l22", },
+	{ "l18", 0x5100, "vdd_l8_l16_l18_19", },
+	{ "l19", 0x5200, "vdd_l8_l16_l18_19", },
+	{ "l20", 0x5300, "vdd_l13_l20_l23_l24", },
+	{ "l21", 0x5400, "vdd_l21", },
+	{ "l22", 0x5500, "vdd_l9_l10_l17_l22", },
+	{ "l23", 0x5600, "vdd_l13_l20_l23_l24", },
+	{ "l24", 0x5700, "vdd_l13_l20_l23_l24", },
+	{ "lvs1", 0x8000, "vdd_l2_lvs_1_2_3", },
+	{ "lvs2", 0x8100, "vdd_l2_lvs_1_2_3", },
+	{ "lvs3", 0x8200, "vdd_l2_lvs_1_2_3", },
+	{ "5vs1", 0x8300, "vin_5vs", "ocp-5vs1", },
+	{ "5vs2", 0x8400, "vin_5vs", "ocp-5vs2", },
+	{ }
+};
+
 static const struct spmi_regulator_data pm8950_regulators[] = {
 	{ "s1", 0x1400, "vdd_s1", },
 	{ "s2", 0x1700, "vdd_s2", },
-- 
2.37.1

