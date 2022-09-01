Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1355A932B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiIAJdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiIAJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:32:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619761314F4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:32:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z25so23571726lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3iiGf3Tyr91E8vi4eGA9o6oUupAxAC01vXvdnh+gkz8=;
        b=Mpv4J11i3z5RjI7+6xVGZBsrAFUaRE3AwnOmijKMdvqzXI56Fv7REz0ErWRZ9+RweZ
         2jHzCGPH4Y71YrLvXTkpWvEl5lfJRHLZXHAXBQVuBnAb9P+akMcdhaTa338OuDIrjqRW
         8w0QYF2dWbbfQ5LzNl9wyboWk3efHS+iD0i7Eh2dZf2x+RLVruP3QW94vMlkleZUr8Id
         6HEei4lj8PoFrqPtTcBVA7/Eu4wlEDVEyPOKjDhYBzLFQzLIwfp9BTxZaLXiBopaUc3d
         vfKftnHKeRtrhEEkqjEb2sQUdd5abSqbDO4WjZKwJ4IyCBFCeULydtR7UGHj7IZfS5yh
         UZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3iiGf3Tyr91E8vi4eGA9o6oUupAxAC01vXvdnh+gkz8=;
        b=rCnVzhdMNywB7ANqOIuuaPrrtlaygRARqfr9srh+MaNkToRKZsQlyouzpiKYUW+tx+
         ExVsruE6Ez32U4dGnOBkr3wZ1otdxuSpEy9Oh/1PJkJbM36W9bdQEEjDPxl4a60O1Srb
         SI+IE58aL/F8uR6Csaa8PdvBBfe/CJetygm4Zp+qU7vJhPLR86LYnCSIoY6L/gY9s8+c
         cQA6zqixVmW5Rk0bLCm9mSIwGukV2mE88PfucgAchrYryfi/mf3SkPoktawR6w9j8P6B
         rQYjwn50nu6F4Frg7CeNHqdkoCLsKSIpDws5OBeXEy0Pa4rIsCnVcTewO2Zh5Tx7c12J
         V89g==
X-Gm-Message-State: ACgBeo1QZxhkmQnww+i0McqcSQnSpW9pXQX9B0QizMB7cSQYERe/Hvum
        4xgYaaYmE0Z6W+/2a507ndhwCw==
X-Google-Smtp-Source: AA6agR7omwfon1PMfnUt3KRiqvGUUOqs0Bxw4whpKcnQjmOyQ5XFbVbNM52giGUfqOdolzDzWE9+BA==
X-Received: by 2002:a05:6512:b12:b0:492:8943:c813 with SMTP id w18-20020a0565120b1200b004928943c813mr9803065lfu.143.1662024769717;
        Thu, 01 Sep 2022 02:32:49 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id e14-20020a2e984e000000b0025e57b40009sm2442960ljj.89.2022.09.01.02.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:32:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT v2 1/4] dt-bindings: soc: qcom: smd-rpm: add PMIC regulators nodes
Date:   Thu,  1 Sep 2022 12:32:40 +0300
Message-Id: <20220901093243.134288-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Qualcomm RPM over SMD contains devices for one or two PMIC
regulators - already used in several DTS files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. None
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 09d5bfa920f2..deccc637b6d4 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -61,6 +61,11 @@ properties:
     items:
       - const: rpm_requests
 
+patternProperties:
+  "^regulators(-[01])?$":
+    $ref: /schemas/regulator/qcom,smd-rpm-regulator.yaml#
+    unevaluatedProperties: false
+
 if:
   properties:
     compatible:
-- 
2.34.1

