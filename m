Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0551A0CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350481AbiEDNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350486AbiEDNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEAC1AF12
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:19:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so2840748ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LP0boZM960tMKw61ptITfkUb9H0O0vIQhKa4zQvzjA=;
        b=w4cyYNikfx+UmgSVEYJzPHrYaFIQ8UoeyCgqKpZqtkQQF721o37eqZTwgGepliwWHt
         wTPgTZSBH0hvlEsdfzTw+z/O4TAlfJuRt5VaVPpMMCI6vWEQuMWVZ3SfvpKA2QWl3eaP
         mNsS0HUuQQ5nU8yCWVlirenVEdBjP3sWDUSVQOrYUVBxb1cQ9pNnVkGwK+nAfax4vNo/
         nR5nzIJOAXY53+1gsPp7o6r03uJI8YK/SVjdAViilHgChP6O/oMvoTg2ScDhRxrY68xv
         8M2Ku6bHGlxsblC5vVqdUqROE/R6V/o0cvBmwr3nAs1geAdyFzXU5SxZijIETZJYGJmT
         YKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LP0boZM960tMKw61ptITfkUb9H0O0vIQhKa4zQvzjA=;
        b=LP8QpGR+Ps47st+OEULoaUIC5MDs5KfR0xjFmrPs+sbdv7pfzLKkXqJ4ALz7JDLiy7
         SZo+sTlNE7XMG0me2jMGEXhZXr7M85GGsb3JL/Dod51N+Q/spUdPz8+sAHAtX6qFspSL
         uEvKVy8msWaBmCh5DtxFqFWddu3xKHwlzgFjGSF2ZbfRYXQ5hnsxDvhy3R9HpHG4yFpL
         x1MF0t2yUQ231/OzVzyl+5F+xF6Ldp6Xre8hea9yN6TZGhzCah5DOcL2Ys+7v+h4fyJ2
         HBXIJd6MqWunIS9Nb0TftUwpFWtVTJxb7kObtV+/fAMPOLJ671jDwmV+SXzk1T+DIDa8
         yEOw==
X-Gm-Message-State: AOAM532tJ9B3KeA+ivlQjQNQvpLqLdx9AN7ULFWNvl5bSP20eUYB8aCV
        b8phz9JZN2d4NaJYF2VrHECFRw==
X-Google-Smtp-Source: ABdhPJw+EEGLGalZ/eEwWqsNp7BUw8GjNWPpmOoHcPJ1kmrbxMj4PJ4PTT5WNehpyVr4w4SLufDq0g==
X-Received: by 2002:a17:907:7216:b0:6f4:70d4:a3c4 with SMTP id dr22-20020a170907721600b006f470d4a3c4mr10253408ejc.529.1651670377591;
        Wed, 04 May 2022 06:19:37 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214dc4sm5660924ejc.42.2022.05.04.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:19:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/13] arm64: dts: qcom: sm6125: add dedicated qcom,sm6125-dwc3 compatible
Date:   Wed,  4 May 2022 15:19:19 +0200
Message-Id: <20220504131923.214367-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
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

Add dedicated compatible for DWC3 USB node name to allow more accurate
DT schema matching.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index e81b2a7794fb..50def880bc87 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -481,7 +481,7 @@ sdhc_2: sdhci@4784000 {
 		};
 
 		usb3: usb@4ef8800 {
-			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
+			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.32.0

