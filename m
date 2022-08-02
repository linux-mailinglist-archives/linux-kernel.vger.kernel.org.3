Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A3F5883F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiHBWMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiHBWLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D22253D07;
        Tue,  2 Aug 2022 15:11:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z22so19304180edd.6;
        Tue, 02 Aug 2022 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ed0Ad0nciEmXYGJt+qJauirkeATlYcY80YbKrudCPfA=;
        b=lH8+uaI1CrXeuEzXXgj9uVO4R5HmAoIBQdwFcRcy+VePNsFGRyVhpleHGu8edlekHE
         jSFW11SaLG3g5oursu9ZOKkyx3ACZxRQ2g81Hb9KRsOaZVa1Ob3524pDCBMVWKp+gEc2
         +/jrAGRWiaTxAyo85o9yri0zjWPaiytk6q+45LvfvxPzvFBSoyzIAu81FwNqNgw9tzmi
         nr552YWvzRTzCMDGH+6UL36sQYv2EjtLAWbYkBcp56964myXUo6cV8SsEN3SKwO8+ZqL
         wWWBvhlvL5uLx+dutMolY+5mPkUqmIFA6H6GdyUuS17qycNYK6uKVLS4dZXv0iv983yC
         Uw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ed0Ad0nciEmXYGJt+qJauirkeATlYcY80YbKrudCPfA=;
        b=EgadJj35cQhiZAVmOIRfPQ8TmwlUDyxnfxoW6+3jJsqK0XRLY4vDerEnWLGXSBoHHD
         QkNyZzKCchCoWKAefjpZqaJcCHrSc62zBDO5cO93H8f9tn3ESt7udc3cc/VYBuyEWoCZ
         R6yg+k66VpCQRFLfan3X2BowfFsJeYqZKcdCtJvP4z1arN5weVsb+Ix6UbG0WI6wPfPw
         8cXHD4eOaLm3v/3PNxurB72Qx9WyFZsQ3VS9NGFxTSqoL5Qp5jSBbRAVGCjJRXgCYfzQ
         2hdVa7xsLQ5QYHY8wlK7/esKvXdC63E7tsxqihoPCRQRyfGE/1y/6lPXJsvUNKlpS/F9
         lREA==
X-Gm-Message-State: AJIora8TAedVA3oM+l9OC7a8623mNFHvchNAjfYDJ+E5mXFVvJoRug9H
        ZiFbFbBHH2WQDLuUNnUxClE=
X-Google-Smtp-Source: AGRyM1tDP5YLzMArNOlBAoIgHZzB2YaM+6q+12HjEpoh4XbsF0avk0eXRYRnixEjkTiiQrSCV743KA==
X-Received: by 2002:a05:6402:4cc:b0:43c:cd5c:dcfb with SMTP id n12-20020a05640204cc00b0043ccd5cdcfbmr21918562edw.277.1659478305648;
        Tue, 02 Aug 2022 15:11:45 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906304700b0072b92daef1csm6741500ejd.146.2022.08.02.15.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:45 -0700 (PDT)
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
Subject: [PATCH v4 07/13] regulator: qcom_spmi: Sort pmics alphabetically (part 1)
Date:   Wed,  3 Aug 2022 01:11:06 +0300
Message-Id: <20220802221112.2280686-8-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802221112.2280686-1-iskren.chernev@gmail.com>
References: <20220802221112.2280686-1-iskren.chernev@gmail.com>
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
index 0763a5b7a2ce..4c6494e3bbf6 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2021,43 +2021,6 @@ static int spmi_regulator_of_parse(struct device_node *node,
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
@@ -2134,6 +2097,43 @@ static const struct spmi_regulator_data pm8916_regulators[] = {
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

