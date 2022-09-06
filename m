Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582985AE7E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiIFMUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbiIFMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:19:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF1B23F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:17:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q7so17080502lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sOpMJZzTBxmKg0bL2Da/S0t+3gjvGnp5/eRVN6wwRsY=;
        b=DH5vqlZ3DifzAndE1WGjlqndkv4nMInSyP6CFlEl76F7fCWDZcHAKn9mLr4o3J/eWx
         qAV6M9ZtcA2X3pW5/FTrABXz42GEfA0cf9q0qrkzJupxBUd2mUSWH29FeHkdVc9CRX2U
         dUj/IxfiRCdClux06EmYQRnlpIuKfO64L4//SXxpl6rqxo0iX4nQKUpgOyzlgjFBGl0y
         qFqkJDi0uNUVOa8ocGR5ZVgrHdOSnhF9v4kHsAEhX4O3HWKTdEznPiqAxGs84v0FT5/Y
         bstnJVpF9rV77fD84yTkk1K8XldhEbIyfeESqhSqkxEgb14pLOsDslZrbjs1sWl2kml/
         IPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sOpMJZzTBxmKg0bL2Da/S0t+3gjvGnp5/eRVN6wwRsY=;
        b=PWTGK0h+16MRo5hlOuD9cz4LixRALf8tmCA9Cb9XCHr8IgyHUbx/drZt7Kour0X4yL
         nn5yR3NJFeEpSUJPXwq2SJBY9UvaBnMT5fFy8H6EkV4R6PAfl0YUEkaDwhLMhDSPUA/Z
         30MnE0Epr93z6AvIA5wIX44d/UzIOZfUQqZFFGYdZxUnvbwRI4EUOGuYJxQ1znPPB1c1
         0hIFxNVSP9q0+cPt2V9lpnTjTWjoqUvqdA8sB/9Sl5i0dFJZ8oDxHgvtMPREZItTHwMt
         7erFcFiwfwhZkv116RVQfcMyigRWaPjD7Ae7xjbFFA7G4tn2TTxCqGVcShI++J16z5M2
         iAlw==
X-Gm-Message-State: ACgBeo2LKhObbToo44soidjohKN3+EYShhbIJz+7c6LZNsHyZBJVCkhd
        KWEmqkNucYE9NVBBlEMxVsKF/Q==
X-Google-Smtp-Source: AA6agR6CJKjLHiqlHiUhS+ULbbF714b92DT6khPT9a5Rz4zXQvjha6yveYrpJ7N528FZdOnuLpL8Uw==
X-Received: by 2002:a05:6512:3f94:b0:496:5e1b:a1c5 with SMTP id x20-20020a0565123f9400b004965e1ba1c5mr2095193lfa.483.1662466625098;
        Tue, 06 Sep 2022 05:17:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651c131100b0025df5f38da8sm1882802lja.119.2022.09.06.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 05:17:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/12] arm64: dts: qcom: sdm845: align dai node names with dtschema
Date:   Tue,  6 Sep 2022 14:16:48 +0200
Message-Id: <20220906121655.303693-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
References: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects DAI node names to be "dai":

  qcom/sdm845-xiaomi-beryllium.dtb: dais: 'qi2s@22' does not match any of the regexes: '^dai@[0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c6e2c571b452..308a154d2ec0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -651,7 +651,7 @@ led@5 {
 
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
-	qi2s@22 {
+	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0 1 2 3>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 82c27f90d300..067559c7f624 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -338,7 +338,7 @@ resin {
 
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
-	qi2s@22 {
+	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 56a510b150ab..f2ddb2847101 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -544,8 +544,8 @@ resin {
 };
 
 &q6afedai {
-	qi2s@22 {
-		reg = <22>;
+	dai@22 {
+		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
 };
-- 
2.34.1

