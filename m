Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A458840A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiHBWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiHBWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:12:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CAF41997;
        Tue,  2 Aug 2022 15:11:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s11so7886969edd.13;
        Tue, 02 Aug 2022 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5jqYykzK2VAPDQ9Ktx3qm63n0ndEZqi3cDc1gNnjf1w=;
        b=I+01BXSMI6H4SdMabksVFqk0engvlwSKNEorbCiUBqDNuFlud4qJtqnO5/Wu0v6iSg
         pgULNisMijgzf9Q3oxVTNf5wLPnomn6LtPH+eB+3Xr2CThkhmaLF7xyh8yGpD+2vNlgx
         hdr9AMWN/Ttcw3nEY1af1vq3+WHxZRec1V7wBPBdLKM5qwjCiQqyE9TwIULZ8NCafSyB
         P7qGLUvp1I0fLITz2zhiYJhEETmI5BsTKQ6sq23WS8Tdzz4jz8KmJW9BJbHgztyC6ywT
         D3L4DMJGuwKIbAl9dlNX0jgT8wrMYdGOyQsORsEbBUWReKYwY2ylm6FEinwxEZmSEPNj
         88cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5jqYykzK2VAPDQ9Ktx3qm63n0ndEZqi3cDc1gNnjf1w=;
        b=I28OisU3hBWS0OVBGtxy1gr53gxvb+4K8k4ftgepvQMBoQVbu2WA6Qq/59kENrzAo0
         6ILXcVRmBLGbwwbgHciO0YcwE18+VBe/iLMvqcxOw6jW0trnNwh49mJPjmPrL6DtnYhm
         gPaqu7YxEB/ZsaZfi5/dk7918d4vXxLnl0e34wjMh6EOgbdXjbgFYTVJ6BDJfSU9uEMJ
         TWE+eTgA4jQyPA7CORYnVQh50Vpks6C+dh2k76D3Ibqj6xIw4yyEhUKU7K2tMInbgBGc
         3BuB7+LEQkBBgzD4GgBPlN4Ztw2y3XKMesc/Y6uAbYdVVaVXYTDldzl9AeJR6703VvZY
         wOqw==
X-Gm-Message-State: ACgBeo3KNneRM9Z6EDNqFTnWz7sgI+WANrS47H9fMdF3lv1jXfZDNal4
        AL8kbAEf15J6CESebFzAaak=
X-Google-Smtp-Source: AA6agR6UcE9wH9pR9PIFKVTk4ikLBFfOWe/oRTHcarffmIOh9S7eARyGCf0/9+TZghdMbLZdMk2Nbw==
X-Received: by 2002:a05:6402:4241:b0:43d:a7c9:8b21 with SMTP id g1-20020a056402424100b0043da7c98b21mr11389161edb.374.1659478310141;
        Tue, 02 Aug 2022 15:11:50 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id t23-20020aa7d4d7000000b0043bbc9503ddsm8833805edr.76.2022.08.02.15.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:49 -0700 (PDT)
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
Subject: [PATCH v4 09/13] regulator: qcom_spmi: Add PM6125 PMIC support
Date:   Wed,  3 Aug 2022 01:11:08 +0300
Message-Id: <20220802221112.2280686-10-iskren.chernev@gmail.com>
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

Add support for PM6125 PMIC which is found on SM4250/6115 SoCs.

S1, S2, S3, S4, S8 are FTS+FTSMPS_510, rev 2
- range is 0.3-1.372V by 4mV increments
S5, S6, s7 are BUCK+HFSMPS_510, rev 4
- range is 0.32-2.04V by 8mV increment
L1, L3, L7 are LDO+N600_510, rev 2
L2, L4, L8, L17, L18 are LDO+N300_510, rev 2
L6 is LDO+N1200_510, rev 2
- range is 0.32-1.304V by 8mV increment
L5 is LDO+MV_P50_510, rev 2
L15, L19, L20 are LDO+MV_P150_510, rev 2
L21, L22, L23, L24 are LDO+MV_P600_510, rev 2
- range is 1.504-3.544V by 8mV increment
L9, L11, L14 are LDO+LV_P600_510, rev 2
L10, L16 are LDO+LV_P150_510, rev 2
L12, L13 are LDO+LV_P300_510, rev 2
- range 1.504-2V by 8mV increment

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index aed818c7a4d4..3e312729741e 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2021,6 +2021,41 @@ static int spmi_regulator_of_parse(struct device_node *node,
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
@@ -2315,6 +2350,7 @@ static const struct spmi_regulator_data pms405_regulators[] = {
 };
 
 static const struct of_device_id qcom_spmi_regulator_match[] = {
+	{ .compatible = "qcom,pm6125-regulators", .data = &pm6125_regulators },
 	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
 	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
-- 
2.37.1

