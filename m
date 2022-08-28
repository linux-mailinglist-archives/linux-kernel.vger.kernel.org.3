Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2FE5A3CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiH1IoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiH1Inw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:43:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160591705B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p5so4230768lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eZ+8ZlZ0u81q9rc+wlfRE++/gm574l12fgjcIj9JVAc=;
        b=KlVWHl+5veyg6IqIwNBwBrktPbz6rtK+Jva/UhXaqKBZWgxTDPm6qR6HKWQxBu6a5S
         UMCR3zL7TFCgZRYdwhOs06uJ6vi//fYKl96dRX5T24IUzrrghB+0FfFRhXa0X/qijbzV
         YyOzhyq5fJaeb+JOJMiu2b7Kyap6WHY/P542KW/f79uGcc3hKfdnNxAFHx2APKVb3/nE
         +t9bpN1aF2vfc3VyOvKnkyayJT4cHQBfjhTs+B1f5kNkGmMc0wKPtQh6ZiVN/e0eA1T/
         kwB2NnN04KT3Sf9ERyhc0EmEO1N6wAJnh/vxLyhayYb6hreKlrB8J+yeld1hNqSeU1je
         dJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eZ+8ZlZ0u81q9rc+wlfRE++/gm574l12fgjcIj9JVAc=;
        b=Nm+xCg3wU5yYvQHjUG1Qh61u3pywAY3+PsjrsxYfCS4s73ioWqZ4ydbrM13+SsTDY3
         rm9SQD/bRa+BUXaifH7XptLwwgO4ZbJGD1G1raSum40jo8ehSw+nyldXXL/NT/N5tbxH
         vmNHoQyDc0+ntZchj1f6lQtl92xbRBxtTg/BXWIdX0xu2jF0lLKj+VCdJU2dV5WcHiZI
         H+hEm5c+07SYalJfUVTE/vN3EG+JwrInwYDo3W4ZIOE5OJ+wZ3leF2YDhzo8xt3L4B+C
         Y8+E1I3fbN7XgE0FcA5EKNkUazGszDa2VDCsngfg4ub4vsjL+k7wn+smHJKbZEHRU4pA
         rLAg==
X-Gm-Message-State: ACgBeo1a5Ra9hTRb5x/b/kIbRonEc0ufoJMUp9KrX1xqQyaD7RJtX/xq
        MJvpOhY/kTgJWfppiBmR2p6lDg==
X-Google-Smtp-Source: AA6agR7iIB6KSEABh2zZtl/gnACuIKLnZ46kp3g5G3Cu7i9SRKUQwuXZaqRaXMx860YnpL3OHhYUjg==
X-Received: by 2002:a05:6512:259f:b0:494:65bd:7188 with SMTP id bf31-20020a056512259f00b0049465bd7188mr1196078lfb.501.1661676230654;
        Sun, 28 Aug 2022 01:43:50 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:43:50 -0700 (PDT)
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
Subject: [PATCH 05/14] arm64: dts: qcom: pmk8350: drop interrupt-names from ADC
Date:   Sun, 28 Aug 2022 11:43:32 +0300
Message-Id: <20220828084341.112146-6-krzysztof.kozlowski@linaro.org>
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

The SPMI PMIC VADC and Thermal Monitoring ADC have only one interrupt
line and their bindings do not allow interrupt-names.  None of other
variants use them, so drop it from DTSI.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 97c9f8ece2a6..a7ec9d11946d 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -39,7 +39,6 @@ pmk8350_vadc: adc@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "eoc-int-en-set";
 			#io-channel-cells = <1>;
 		};
 
@@ -47,7 +46,6 @@ pmk8350_adc_tm: adc-tm@3400 {
 			compatible = "qcom,adc-tm7";
 			reg = <0x3400>;
 			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "threshold";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#thermal-sensor-cells = <1>;
-- 
2.34.1

