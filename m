Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFD540516
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbiFGRVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345708AbiFGRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:19:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7E1053CE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:19:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq6so23530104ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKwByyPfxfr/n1cC+oLGoBG4NlLo51IgX3L05P+HJI8=;
        b=Dy8vTNOUCL6SeBYk2LMOat+XlBHFSivtmw8Z3inXucd2HorZz4R7Vb+zYOT5076sDQ
         eUmMt+Z96T//xNLlmqwLvPIz0d/ISgC1WQcJs1P1g3eS6Io+SdcH3AnFmuIyv45TxwkU
         a8TC5HBI9aG3CaPUv+zlkd/TKcL8wD1Fwtxw6BUDXawuhDWzE/qR0H+QIcUwajleND+X
         mZECitUnjhpVdyQAZ0AIVNw9VhpVMba40eBEU6O5sFcwOMAfFSJPu1HnOwjxDaH/WcwF
         z5U9aqSprPrs2eHBpCga2xQMWpU9YKXgKPBtc6zbgLcWcUM7JEV8LmiZpeEVRKWmYVPa
         xM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKwByyPfxfr/n1cC+oLGoBG4NlLo51IgX3L05P+HJI8=;
        b=pY5YztJ2p3UtVVRzOSgF8ji9VBltict3BqJ49m6r6NCqvpCdE6tFXbOVsklrN1Jmib
         NfEXNqgtbw+7BElt8vt8vjavdfYTHOCYqUN8bq8voRv1Iy2vYUyTThGBVutiO2Pnw5NI
         hjobDTmxeZ/ZvkwHTrdCp/Z1Ar54aCs8vFHMWO86xuOS0umos2pwoFMZByRnbzNl7tcM
         56NzmObRHttGi2fZgDYTPPsgsN/Hlh1VPF6HKWWthOzXfdyyglF9u2fn+utj+dnxeWWN
         uwqDTGAYZLwnGOTM8Ub/XxavzktAqPoqMRPjHWz4LUbclEqapg4Aax3PN23P6Vwqc+6K
         Q6oA==
X-Gm-Message-State: AOAM530NIc0hkqXpmH5I5bkh4NxQ94H8FCTcKbDRD71q0LlTKIvON7FI
        Q/UhqUVxVE59BwjA5QMW9WIf0w==
X-Google-Smtp-Source: ABdhPJzSL/dwq6r3E9jWuUXk3PD0vK74fSqk9KX+ypDiU5Yy6dbsNXhfI1NXAO7sDxCZ0lIAYdKNEg==
X-Received: by 2002:a17:907:9615:b0:708:a422:c9c2 with SMTP id gb21-20020a170907961500b00708a422c9c2mr28113240ejc.217.1654622343543;
        Tue, 07 Jun 2022 10:19:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm5876540ejp.96.2022.06.07.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:19:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/14] arm64: dts: qcom: sdm630: add dedicated IMEM and syscon compatibles
Date:   Tue,  7 Jun 2022 19:18:46 +0200
Message-Id: <20220607171848.535128-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
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

Add proper compatibles to the IMEM device node:
1. syscon to allow accessing memory from other devices,
2. dedicated compatible as required for syscon and simple-mfd nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 8d38c3d3c940..771f74dec826 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1830,7 +1830,7 @@ blsp_i2c8: i2c@c1b8000 {
 		};
 
 		sram@146bf000 {
-			compatible = "simple-mfd";
+			compatible = "qcom,sdm630-imem", "syscon", "simple-mfd";
 			reg = <0x146bf000 0x1000>;
 
 			#address-cells = <1>;
-- 
2.34.1

