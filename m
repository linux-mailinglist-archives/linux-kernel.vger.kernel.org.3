Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37325A3CE2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiH1IoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiH1Inx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:43:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD62E6BE
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by6so5333808ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9Hj3dBxPs1I/xudtwJl9ZkeYWMTT191cJQDIMj/Eo/g=;
        b=kpwZFStIL2lme0oe5dsO3T7jfnBSL4krpcARe4bebS9wN7B//RR4qFG98uv0bPMgKB
         Zy3xqqk1yi3HsMaHPSITQWbgdEP5KCX9hz4wt4ETo5z17oZwOqYK8RMKdJmgDorzqSYQ
         YdhY6sgQoKx9YJyy93tMitI8+6PQBxSzXNsx43UqJ8BnUyPtyfDDfkFvHM4LSDl2vzm+
         jPx4u2aoVTVygoPNbGv3QmujkV5XMJ132PjnfV6dwPKYUXw9WthtvUhdGWZLF5ej7eGK
         6aiEV1CuCb6O7lB+9eghPnvPTpaRX/MKvWWmkL7tciToUYXiA/uFv92+ZvXKdk+o5SPk
         0/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9Hj3dBxPs1I/xudtwJl9ZkeYWMTT191cJQDIMj/Eo/g=;
        b=mMb8XVVcK4UYRYf88Bo9lzWTgfDCod8eRJ9Ag1nIBK0Ph2VNGA8yLGoNAw01tRbn9+
         kwdJO7xDH4H0bleKBQGDbQ5Z2bOG0q59+0SWRrRoV0y90VVDbFAXYVZSXHOQXJPYAytG
         4iPhdKh/a0i3FKZAz9/Oetewr9bmGGHU+dgq5dJrQk4grtbuen2f5YhErWd/illiXiGj
         Xo2eEDBjVk4Ai2nlXYt1kiAvDH3iWH8JEmqPRI9pLqqJ7ck7wCPSdl+M167xFFqrZ2SF
         XqMghXD8/7ndtSLuvluSmHx1aJQyJAwGfjs8H0ETbkvPxoOy1QJQBC0Tteq8kmWeDacz
         /9xw==
X-Gm-Message-State: ACgBeo0bP4w188p98k1JaPJrI6w+pXGINQnaVGKI+ziSkqR+78YL7T1r
        8LxccMG4KWDu3Lkvz4dj0qu/jdxdJNhMlg3xjbs=
X-Google-Smtp-Source: AA6agR76k6aECfbGIJWFn9B0kGSwydVkrXQyATrz/ZTiaJAP9MU86rZnW4ki8HWvsbxSnzIoqLwY8w==
X-Received: by 2002:a2e:3c13:0:b0:263:63d3:b498 with SMTP id j19-20020a2e3c13000000b0026363d3b498mr1404645lja.487.1661676231619;
        Sun, 28 Aug 2022 01:43:51 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:43:51 -0700 (PDT)
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
Subject: [PATCH 06/14] arm64: dts: qcom: align SPMI PMIC ADC node name with dtschema
Date:   Sun, 28 Aug 2022 11:43:33 +0300
Message-Id: <20220828084341.112146-7-krzysztof.kozlowski@linaro.org>
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

Bindings expect VADC node name to be "adc":

  pmic@0: 'vadc@3100' does not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8953.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index 741c538a9cee..a1d36f9ebbd2 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -45,7 +45,7 @@ temp-alarm@2400 {
 			#thermal-sensor-cells = <0>;
 		};
 
-		pm8953_vadc: vadc@3100 {
+		pm8953_vadc: adc@3100 {
 			compatible = "qcom,spmi-vadc";
 			reg = <0x3100>;
 			interrupts = <0x00 0x31 0x00 0x01>;
-- 
2.34.1

