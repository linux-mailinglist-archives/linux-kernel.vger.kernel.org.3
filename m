Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEBE5B1864
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIHJU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiIHJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:20:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88DE3FA1A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:19:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m15so7013485lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F43WJbqoo0esyv4lpLD+5bCe2x3EVG4sANVKIPN1Vsw=;
        b=zQXdkzaJpH3Dy0QEpJ6JhbWUiEpS+tM5EPYFFOXmRXUa93CAfsrz5B409kEpR2FMzU
         p4mTJ3hhNZfMGCP36blSU6F7pw2aLhOJpHTqueRdBtHiku5g4ojuDSdIZweBiuIGmFcz
         vFtFfJMRFImyGUC5ZqdwTpxVlv2jiNhi+odnSut+H9ef2UA8S75G1/e70BXy6cBv1dcR
         NLTbs92uOjZ030ooA0Yk0Hsdo+mMb7lB51YwkgpCEmXJxHHC6hgB5bxAVoxYwATqpySE
         dEQz80i5LETf1lIkmBc8MU9KlHhRwRIqyYAGqK8S/Bdh5x0ljbcMHhmmdFyUItt4m0f0
         q/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F43WJbqoo0esyv4lpLD+5bCe2x3EVG4sANVKIPN1Vsw=;
        b=fbo4C7uGCOFajvREJFcB3RLEAQNv3eFZFX1Pm302/U1LfrT14zuBk0OuiPsG4TjH8U
         CHqBG0nGcfafzzf9Xu+6gexY9QL/VD5dCdy9Zpp8US+qHB7HcR9UrGzcjVJdCfdVPQ7t
         iTEVoDPoTry9vtivlJN92+i8C3ewugDLr/kkYnq3ao5ip8nEgWs7+7BtIqwp2eQ2tr1g
         TnrIeaQ76I5iqpdLMoia7GtpY+dFxLmSiRvVxAuCaG8v8K5/5ivG0p8wx/YH4XQZzfZ6
         JvGpDDk5tmO9wWqfznciIsi+chLLzqNADDmZrCdZT3ivezgszzC3qFDU/0hxlkIX8Zga
         2Hfw==
X-Gm-Message-State: ACgBeo3tdRNrHlMYAeb0juSXh9sXqN8H7g9uyO18itwdxPTE4DaFlq7k
        E426shAbLddyTj/eiVeH74PHVg==
X-Google-Smtp-Source: AA6agR5+IYt63VCp1VAO1DzBd8RL1ZAD7wxe1qiLxbeP6L5VtB8VGHJuG1zu7fLWVOHJYfHvFv+VNg==
X-Received: by 2002:a05:6512:20cd:b0:494:6f1f:216 with SMTP id u13-20020a05651220cd00b004946f1f0216mr2331869lfr.617.1662628796956;
        Thu, 08 Sep 2022 02:19:56 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q17-20020a056512211100b004946a758d21sm218219lfr.161.2022.09.08.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:19:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 05/14] arm64: dts: qcom: sdm845: align dai node names with dtschema
Date:   Thu,  8 Sep 2022 11:19:37 +0200
Message-Id: <20220908091946.44800-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
References: <20220908091946.44800-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 132417e2d11e..2110a5893149 100644
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
index 0f470cf1ed1c..68e2a07a01dc 100644
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
index afc17e4d403f..4f6f1ce7286c 100644
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

