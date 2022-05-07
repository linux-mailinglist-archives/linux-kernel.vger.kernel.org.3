Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D0D51E9B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446999AbiEGTxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446917AbiEGTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:53:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EABD17A9D
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:49:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so8650366wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/B2BPBwtGOTsOAaX2PA1j2rtkaGO4jKX4DEuOwWcco=;
        b=imZXB/jtCgUwydHjuBZ9MEWwQzzDDf9iKhVGxm834+kqsznW3v2LwnRte69OiimP+9
         RlqbqcctI1OSfNFRSWpjvFmqstble12Oxqdp/sO36DcyzsGeFWEA0WaXxO0cLO4DJpp0
         SIKBwp1sWc91rcNQJze02oZV2ajsTpEI3GDogklXllTZlbPNgwuGf9U+ahrCreJyhtLL
         T+uUyZn5jYGrkDvbWLoGMAmMT1bFUPncmzLwTnKIOOvyQCz6ZXedaV4yQUp0SrNcI8Vl
         oyOQQE60CRYJmltKfGGEVJCuIgd5qyzhx5SiMkYhBeqWkmOGK9WIQ7sBVCioXPN2Ogn4
         IAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/B2BPBwtGOTsOAaX2PA1j2rtkaGO4jKX4DEuOwWcco=;
        b=vpOObTIQ/Sqaxfo8PwuEwdq/RZa95nPo3cvwoEOAZkSiz7s9VAD0DxHwBlmPUjkDTh
         52EtmVQLJjBBUiVMopoFtnfCiRjsgQCSEC//+5lVxPVNzcTGzOQFWx23uBnmxireZ5Av
         wtZyydlwMff3YljqPVmW8Lhu657HEuMG98l+EqpMIDT1LdrSrAPgDs1fliRLWXQE5cus
         vf6nZpjlgmsV9RR+u88PE2ohgXRmhx7szrs5ewwGH8UtfQF8qqhgCh91EvbTDy7WrvkX
         R3Vi7VWKOUNyzd6KsRYtVYjmiNQwEG5uHekAIRICeDdGVLBCqFEzP0hVA6RBSWlAUEPc
         Y24A==
X-Gm-Message-State: AOAM531xy1zgWzdHSRvPS0H9raMhpmoJq3M3ZqSMgtlzEWIqFhR8LtPY
        Z9wa3kEugFn10jZDpT47v/4TKA==
X-Google-Smtp-Source: ABdhPJzfHOoernJuqTo4FR2Vpvrj5oWfxqubn0lV6puau8hejQ+FgKfIcVxnFMzlUODRse458AJ4aA==
X-Received: by 2002:a05:600c:3546:b0:394:77c7:edd4 with SMTP id i6-20020a05600c354600b0039477c7edd4mr9653554wmq.37.1651952967742;
        Sat, 07 May 2022 12:49:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003942a244ec4sm8535027wms.9.2022.05.07.12.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 12:49:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/11] arm64: dts: qcom: apq8096-db820c: add PM8994 pin function
Date:   Sat,  7 May 2022 21:49:09 +0200
Message-Id: <20220507194913.261121-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
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

The bindings require that every pin configuration comes with 'function'
property.  Add such to PM8994 GPIO5.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index e0e965f4dd2f..ad6780151b4f 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -558,6 +558,7 @@ &pm8994_gpios {
 	ls_exp_gpio_f: pm8994-gpio5-state {
 		pinconf {
 			pins = "gpio5";
+			function = PMIC_GPIO_FUNC_NORMAL;
 			output-low;
 			power-source = <2>; // PM8994_GPIO_S4, 1.8V
 		};
-- 
2.32.0

