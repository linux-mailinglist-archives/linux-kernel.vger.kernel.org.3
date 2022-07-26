Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68574581261
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiGZLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGZLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:52:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B05F32DB0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:52:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q23so9041879lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g610o0FM4Xw34WWwumLukW80tQhkdeJbk6IaR7mFIqk=;
        b=kBaF0r4YaHJRbh5V44q5o03GzLpcEOucr3ltIn+UMm8T1eWReUQCvBsbF8Y5x5QtOR
         scCfkR9n5Uwnr2AjYj85NH33ytoJKPJ0b9zDRxxPxE/zu17lUJFiKsSAHD5aGJ6o7GjK
         uDZBcQd7P68AHKj7f/PZhfqLE/68EPfGuoy/zIy9omHg2orn5je+EEMuk8WSFW/0Oh19
         2Ww1+RxsDgmytwiKcrt7YAjX85OE0H85p1CoUQ5DaV/V9dZIy1qp8iZKlcvn+J2Z0Eo+
         KPCaVODtAZ0jpGpmVhrPU+icGqEm8Lc+0ghzVZaECdADXaL/gBTo7DibxL3Rn7abYKQq
         0OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g610o0FM4Xw34WWwumLukW80tQhkdeJbk6IaR7mFIqk=;
        b=LBBPPFr0iMPq7r+v0SBa6u52EWBQ5n/eQRePJIUl+m+hFlOAWxhHPbkHgz6l0/F1UV
         QL3gnVosjpcKgTHpyIyiDjw6c4WWkpcTG6wPZvqUXDy2p37zmYCDENxeLrnr7mf1mFRx
         vsgIccDwC5Yk+7mUsD4tTUtfPw6TDBynZzuebpRVnLTIPbwMZfmn35dsP/LXV8QxJND0
         t3nGtz+4HNcMBOHLcn5HiyJxaEBT3avZRLRpox4qfbZUJci6AaR8uKHOkpEuZPUvOP+V
         oOtrnRR7DQQP68BDj32joARdKa6U8ZYY2pjGCpBF58VuKD767Voil1Wtyi4SU13m192l
         Mljg==
X-Gm-Message-State: AJIora+vJk/HAxUTZO/rwyDwxi5g/fnNMRrFmQgVA434Isn+VP1lers1
        gG/9QS60VQRZxG8L23Mlva0kjg==
X-Google-Smtp-Source: AGRyM1sCMrmSP9VlJQn02f5I/simnfIKZufl6hZipxlZUYnQ70rZOTTXLPYi/1iTbOhE0FA560kovQ==
X-Received: by 2002:a05:6512:2821:b0:48a:6a01:3d29 with SMTP id cf33-20020a056512282100b0048a6a013d29mr6564937lfb.649.1658836325541;
        Tue, 26 Jul 2022 04:52:05 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id s17-20020a05651c201100b0025d30dba34asm2163679ljo.113.2022.07.26.04.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:52:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: add PM8226 constraints
Date:   Tue, 26 Jul 2022 13:52:02 +0200
Message-Id: <20220726115202.99108-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the constraints (number of GPIOs) for PM8226 variant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 6bc84779b092..694898f382be 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -159,6 +159,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pm8226-gpio
               - qcom,pm8350b-gpio
               - qcom,pm8950-gpio
     then:
-- 
2.34.1

