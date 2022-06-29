Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1BE55F4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiF2EMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiF2EL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:11:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD4326D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:11:56 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u9so19964574oiv.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFMtqpdghv9Iu/i+C/54b67+Nd1USmA2BqKquNUos/A=;
        b=zVhR4cZ2qzvF9FIzyUP/GuzHubIJQ7QeyuLeUP1Zf5kKzxXPcWKoi4cIjoKiP+TVYa
         iGgP0byytoY0nGckQzizJgGVENcSzf5r06pW26FurNp5Jn3FSwFNWQhx20yZycmXgaGk
         Oj7666qelQ2Jd9lUsRNvIUo6z8laBteO2Y49U9GjQ9MIWf0TNWmYHq/HUcWmqJKq0E6k
         P4zneA2uh8f2lWhOMGy55JCPMcGjbLHDXyhhY/hGql0UFdDDSJx+w2RF39MhGoS9TeTt
         WPZ29Jo1c4q6O/cEQ/ky/AWAb8+LVTWKGpSX4hAtZEQuqhNKuDO8JsLE2GM3/RuiMJy2
         s7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFMtqpdghv9Iu/i+C/54b67+Nd1USmA2BqKquNUos/A=;
        b=eyC1+ZnyFHlSEJL+3xtTITrdeFPWMQXyeBL+jXbfrz5d+6Ej+NK1QoKsQCQAzQHcyL
         CInVkkmYVoYTDT9Xcf6k922mMSLgHdFkJ11IuWcLwS+h3tzMg/r4QSWmnlXf7Rw4nbs6
         ecUJSuJztk5DABdehxertwWxpnX84CLkbFN5osq6EcmFsvIuiV+d2jZhIoQzNRJAHjRR
         NjIKQWzFKuUW0HyZW73PGgLtyYNzpnRazC6AK+mdWDtMtQlfPCElNA8VV37YH/1/4kFl
         mSvVxGZSkPRiXiikf0hpx2xgMl8p7wtdSg73hjdh7Cz1pf4Abejs9t2wJJE3IN/ds6W2
         4QWw==
X-Gm-Message-State: AJIora88LfA2m3Xf4UaOcDg6FGe4C/RrdHtqPbe8XOBEHlcuemt2R1X8
        9SRivmsSQAPJKPpjSaewmB907g==
X-Google-Smtp-Source: AGRyM1t3HsfXDwokoCnoAMkM+w1cPhXi4boARhaCeUHkfO60kkWveHFeDkZIumpA6128HSLpKnsr/w==
X-Received: by 2002:a05:6808:1797:b0:335:1e4e:41bf with SMTP id bg23-20020a056808179700b003351e4e41bfmr851021oib.224.1656475915455;
        Tue, 28 Jun 2022 21:11:55 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d4e0c000000b00616ec82b29bsm1578692otf.35.2022.06.28.21.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 21:11:54 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: arm: qcom: Document additional sc8280xp devices
Date:   Tue, 28 Jun 2022 21:14:34 -0700
Message-Id: <20220629041438.1352536-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629041438.1352536-1-bjorn.andersson@linaro.org>
References: <20220629041438.1352536-1-bjorn.andersson@linaro.org>
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

Add the CRD (Compute Reference Design?) and the Lenovo Thinkpad X13s to
the valid device compatibles found on the sc8280xp platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes since v2:
- None

 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..6ec7521be19d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -238,6 +238,8 @@ properties:
 
       - items:
           - enum:
+              - lenovo,thinkpad-x13s
+              - qcom,sc8280xp-crd
               - qcom,sc8280xp-qrd
           - const: qcom,sc8280xp
 
-- 
2.35.1

