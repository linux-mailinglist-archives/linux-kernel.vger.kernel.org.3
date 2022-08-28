Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FD5A3CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiH1Ioh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiH1IoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:44:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180D2E9E5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t23so2583094lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w46QTzHiliFXMgbuwtIv8+OqfbhHs2gqUEaLL/ymU0k=;
        b=vHaG3zjD5j+7XpGoP0dGNrXSCEXv1+8DxvjWCGF7yB7+ZJ/ABSyzSPLTKlg9cF4TcZ
         jlKGYtWONeXUtYjJRpwqy0Vz7fhi+iZhADJpQ2HivtzIFS1/ZiEU6ynRKt041qWoehCE
         /Lr6GMVFTgZdNefYtgu/4zzH1SE+NK6yLxUTOcGIiABOhU2o2DfbGuGaAMLl2X3xoWfj
         7wy+po5qIbYdRM4ayZE71TTfWKnnIPADGKgyRezkY+UqJ29XlKTOXn7vVgpFs5El2EO8
         TB7U1n5Q5k51oEUKcrXrnK1RVq6EGsYxUiwntVGQnVD+AP4ScZdJpwW3E61TDfY8Mm/w
         bI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w46QTzHiliFXMgbuwtIv8+OqfbhHs2gqUEaLL/ymU0k=;
        b=KmEWtKjFBQoDqYs3Mn4EMNkMIN1pU99bznOeia6nPLTz6Isg6Wj0oFzy7cqsZRIJt2
         GvmNew9YNqehZGRd9pFHaL/HJ5Rr7QclUu5Pc/uXay1Rgzgh8x5oEEKrujZkSsuuN9+x
         avgrM+n2PI2eqkVEe/7Ss+mQRocezqXiGTIOJtkKaD2tffhj7H2XEbMVlTEgokGKywPM
         4xVJ8XAyXbAK6yyXOMqefdCUu1HAp1/+A20kXBsxn2NFq3f1v6X8JelVwmDEJsDqPl9N
         NqrIY32cyGlrEZhuCRvctT/o5+zqYvl/40t8DMPjkc/HIkPnlYq5q7qx22c1zZ4kDf8w
         EmpA==
X-Gm-Message-State: ACgBeo12l1QcD3OoGrtWdGNxfk7IGviu/mRhWQTkExUETKLYjh3tNjEA
        jKE3cLwgegxxeOTCasFDxWWb6A==
X-Google-Smtp-Source: AA6agR6vJ7epFCfbZJvz8TimxpKRLS/McwkvBhIJ3uhYnlAZbRWvnq2J/ciaL/x/GLIhtM2ioNoRpw==
X-Received: by 2002:ac2:4f02:0:b0:481:43a8:e368 with SMTP id k2-20020ac24f02000000b0048143a8e368mr4597736lfr.65.1661676238293;
        Sun, 28 Aug 2022 01:43:58 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:43:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/14] arm64: dts: qcom: sc7280-idp: correct ADC channel node name and unit address
Date:   Sun, 28 Aug 2022 11:43:38 +0300
Message-Id: <20220828084341.112146-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct SPMI PMIC VADC channel node name:
1. Use hyphens instead of underscores,
2. Add missing unit address.

This fixes `make dtbs_check` warnings like:

  qcom/sc7280-idp.dtb: pmic@0: adc@3100: 'pmk8350_die_temp', 'pmr735a_die_temp' do not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts  | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 6d3ff80582ae..e2e37a0292ad 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -78,7 +78,7 @@ &nvme_3v3_regulator {
 };
 
 &pmk8350_vadc {
-	pmr735a_die_temp {
+	pmr735a-die-temp@403 {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
 		label = "pmr735a_die_temp";
 		qcom,pre-scaling = <1 1>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index a74e0b730db6..27c47ddbdf02 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -264,7 +264,7 @@ &pcie1_phy {
 };
 
 &pmk8350_vadc {
-	pmk8350_die_temp {
+	pmk8350-die-temp@3 {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
-- 
2.34.1

