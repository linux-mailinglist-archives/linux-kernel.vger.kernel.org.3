Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220EA5B019D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiIGKRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIGKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:17:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2935EB9412
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:16:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q21so7444315lfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hnmXzvjIzn/KGbEWap9g0ZuckOp+5W2/ARJz1gMjBQE=;
        b=F+T18O7i1RR3RmnLodjnbrXR4Ld1HD4FYmpTjxTsAKaHH8c8XtjwcUOmyQba73z37w
         CQDItukJUP65Qdg0f2pXpHgPuv0MYhPsYwwx+tswenTByeHg6S+VI1tNl6A3eYRK8RxQ
         dkr2i2BZhFDNmfqITk+OXeaIhC4teIpEv2Dc9CNaXP0n07RsXrlLkxwU3f0FLhJbWL5L
         0ddmgoCM/boRUTLDHQTg8lhjQerJ+EMvZWBqIm7GzkCQu0bqjwJD5phi3I/Q4iR4rMM5
         Z2crU6iRdflUza1bi09FoWMotYFWeZdPN4f/jT/bBX8Ror6Rb+1cn9VC4E0X5pXC9g1k
         LlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hnmXzvjIzn/KGbEWap9g0ZuckOp+5W2/ARJz1gMjBQE=;
        b=NlRkSCh4yBkv2rnS4uZcKjICB2iY60kVNJ13kvYWPfZR+RUVM4YZ//hs78FrQwMXTS
         xglqtN0ScIbZw0EE0Q+Hp3jO4dUUg0ru74x0m0bMExx4+Hz8lYR3eRdlWfQkzSW392yB
         2B17xP5VO5t0Qx66CfL0Cpx9FvCxeScpAuWC/ZrPMCbjQoEJGXV8Ub6YNq5qI2PCnBM9
         +1SRq3QFR9inn3uAz6Tv12EqYhDmU9fRg1hYK0AFLZ6Qe8nnS7GBLR7aGkV2bA/j/fjQ
         NVC/rdjc14U07g4SiD9jiKvFm6RK9EJyIoVGL1gyawfHMjFUdGg1tSrIFnrY+14Pt+G7
         GPWw==
X-Gm-Message-State: ACgBeo3yKgafGABcvEqBIf3HtA6gfGalmT8fP6T/UnLS+1fSGp5DTJyu
        LOF3o8FyeAjbaYDnt9J6kuvPbg==
X-Google-Smtp-Source: AA6agR62nrQ6HPltqeNhqkdVFoggD8qRZIG68KGK6gXuvRJCmVSgv9rIlppYQJZP7PeYZi5RbQESIg==
X-Received: by 2002:ac2:4f02:0:b0:496:d15:ea89 with SMTP id k2-20020ac24f02000000b004960d15ea89mr827601lfr.69.1662545770290;
        Wed, 07 Sep 2022 03:16:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u9-20020a2ea169000000b0026ab0e480bcsm960734ljl.39.2022.09.07.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:16:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/14] arm64: dts: qcom: msm8996: fix APR services nodes
Date:   Wed,  7 Sep 2022 12:15:46 +0200
Message-Id: <20220907101556.37394-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects APR services node names to be "service" and to have an
unit address (as it has a "reg" property):

  qcom/msm8996-xiaomi-gemini.dtb: apr: 'power-domains', 'q6adm', 'q6afe', 'q6asm', 'qcom,smd-channels' do not match any of the regexes: '^service@[1-9a-d]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1e6b70582866..abc17c905bfe 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3389,12 +3389,12 @@ apr {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					q6core {
+					service@3 {
 						reg = <APR_SVC_ADSP_CORE>;
 						compatible = "qcom,q6core";
 					};
 
-					q6afe: q6afe {
+					q6afe: service@4 {
 						compatible = "qcom,q6afe";
 						reg = <APR_SVC_AFE>;
 						q6afedai: dais {
@@ -3408,7 +3408,7 @@ hdmi@1 {
 						};
 					};
 
-					q6asm: q6asm {
+					q6asm: service@7 {
 						compatible = "qcom,q6asm";
 						reg = <APR_SVC_ASM>;
 						q6asmdai: dais {
@@ -3420,7 +3420,7 @@ q6asmdai: dais {
 						};
 					};
 
-					q6adm: q6adm {
+					q6adm: service@8 {
 						compatible = "qcom,q6adm";
 						reg = <APR_SVC_ADM>;
 						q6routing: routing {
-- 
2.34.1

