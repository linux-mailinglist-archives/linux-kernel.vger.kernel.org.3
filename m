Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15E5A3CD0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiH1Iod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiH1IoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:44:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2A2E9D0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br21so1603888lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JV2YXvwvyqMzto/q6SO+g2woGhq18/GRqDT7Fs8aiqE=;
        b=maaSQWFBEa8G4sTJACk/W7JFvlXLtQNZgbBib2l656o/yKPT2fusd3OS43JS/6ANIR
         6PTJvZlkeNqBl7FNe8uPXFsoypLFvoCZ3V97SnPeG6/tvRRF3N90di8aKJDWoAIUgRbA
         aTz+K1G3L8LhPx2BX7GDTou3dCbqleA5/4v66zqY55ti+c5bXu0hixydyUu9hwdKYAib
         7VYv9IGwjOSO/MKcVBRNj8R+ozYqlJoovdQE4S1WGObxeQar7lDfFxdEccCJfudGwIjb
         Q33B41taWVnJrc/DHAL/WWlTo3J3GLtt6xBSoOlqOEA29zFqDlBZljUG+D628nOLy6yH
         JLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JV2YXvwvyqMzto/q6SO+g2woGhq18/GRqDT7Fs8aiqE=;
        b=efqod/juGhh8WeB6tHB+ZswagOVPT7F88AWciZ+33e7XVpDquAx3pDMIdkV7BJyL4n
         2ko09v1x+7GAXzzcScFI/unHRZJbY9yYcAVQRCyp3KzjmH0GpSusDfc82mU8NmpZ/dno
         +tvbEO+ao6doYqmXlPoULotzpbmmp19/qvYq6MliH6htgh4q2S2jpKgMErw+sZHnSfHn
         xAOrKESDfk2aRkCugkcTXpPZhlgJ3ZBoVTd2ajVJ9U7LOzDJKr6WNSk/veEqpUc+CLlU
         4fEJR3e9KgDHOMq4F827piiET3loP4jkxv43jLSh7qzkWEWYv/+5jgef3PU6yhgHGM7T
         3GcQ==
X-Gm-Message-State: ACgBeo3re1wBfmdUJ68VE0/EWEQprkEkzmwmqBhVF+MRwFSyNpg8F521
        2oHgNwiS+gXVBNnOyWfZ0krD57I9/crU7y8Tm5M=
X-Google-Smtp-Source: AA6agR5tp22AlmMPfTra2aVV/ahG72TIZEzbgfXSJGhBsYciCli+AchbxdW4PFjmZ3A0GYKEL9X4oA==
X-Received: by 2002:a05:6512:21c9:b0:492:f0f7:d82f with SMTP id d9-20020a05651221c900b00492f0f7d82fmr4618408lft.588.1661676237076;
        Sun, 28 Aug 2022 01:43:57 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:43:56 -0700 (PDT)
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
Subject: [PATCH 10/14] arm64: dts: qcom: align PMIC GPIO pin configuration with DT schema
Date:   Sun, 28 Aug 2022 11:43:37 +0300
Message-Id: <20220828084341.112146-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects PMIC GPIO pin configuration nodes to be named with
'-state' suffix:

  qcom/sc7280-herobrine-crd.dtb: pmic@2: gpio@8800: 'edp-bl-reg-en' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts  | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index 7881bbc641a0..269bc4c42791 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -167,7 +167,7 @@ &pm8350c_gpios {
 			  "PMIC_EDP_BL_PWM",
 			  "";
 
-	edp_bl_reg_en: edp-bl-reg-en {
+	edp_bl_reg_en: edp-bl-reg-en-state {
 		pins = "gpio6";
 		function = "normal";
 		bias-disable;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 7747081b9887..56a510b150ab 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -522,7 +522,7 @@ &pmi8998_wled {
 };
 
 &pm8998_gpio {
-	volume_up_gpio: pm8998_gpio6 {
+	volume_up_gpio: pm8998-gpio6-state {
 		pinconf {
 			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 			function = "normal";
-- 
2.34.1

