Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9659972F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiHSIcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347158AbiHSIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C2E9905
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id o2so5248338lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=N4cVOvKLw+JRrcyC9iyaAUwD4TmpSDd50ehLIjD+FJ8=;
        b=LTrLSr8d2izE40ursGNIZ1/Uum5CUAczfSeWIwEnU1CtE8uxPAk8+eaNoBuGKnsy1V
         kYQLR4EIDZcZPOrmJuzbkBJAJAt2Be7bAsdjxQYUDhhcPfy/vQb2JLuFpk99eienrX4u
         y06p2PKRXwW72F200b+X0HIavY9rJqtnBxp7otNY5F346lISBkQTjBQKHzBpvn/DDttX
         6uxN9VJpklj/YWZW2ZdwWTrKzxyepXk0Rf/tGJALluMRyd4TiiaaXqZbv2mtDlanPnOO
         1VQRJOFGqaUB99NV2OuZyyzYuOwFZ0rzAF7lYclTtYQah/0FxHurMtrRSxiAc25OyAPr
         n4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N4cVOvKLw+JRrcyC9iyaAUwD4TmpSDd50ehLIjD+FJ8=;
        b=PDh3zYHnIYRlN/Qp/DJpyZ79EZ3tfzFO8A7+Pax1ekPF0qCAhseWvXsBUjuIutgcNv
         m+8Y4UVenbJkllAKI0wgoptKz+sLDWPGU6kCucXR56/GsvP6wfJs1GV3xvxt+/6oSfas
         mjMTcTgtMHfI04WXMsvu51m0T1RqCx34nlztIusQ7I8/azFZifjj12cTNkblgUSGuJiV
         snE4u4l7V2C1/E2bTGvzif3lgy3TBGGbo/wvM4/JYT8EBs9TxgDDACGShxFz3jGtwF1P
         Bn+xczdt7ts9wUB3u06WVjr2srcatpXCVfQtTz2uo5ClMDqs6oofJetMYOp5cwU77Mlx
         yXUw==
X-Gm-Message-State: ACgBeo3KSNbYRPKx3e3/ailtskUc/UUiAW5qAKuH0E+sdyTTB5SP5OYX
        iQeJxr31dUMXjuqVvudgd/pu7g==
X-Google-Smtp-Source: AA6agR5THR1kx33I9E3d3N3nFfvgn8gtcpulk86lo1PcTv3kHAzcJwC2u917khiPO4EROMZsomS9Ag==
X-Received: by 2002:a05:6512:3c9b:b0:48b:40ea:c9f2 with SMTP id h27-20020a0565123c9b00b0048b40eac9f2mr2036846lfv.170.1660897935494;
        Fri, 19 Aug 2022 01:32:15 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 01/16] dt-bindings: mfd: qcom,tcsr: add several devices
Date:   Fri, 19 Aug 2022 11:31:54 +0300
Message-Id: <20220819083209.50844-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
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

Document existing (MSM8996, SC7280) and new compatibles for TCSR syscon
registers (QCS404, SC7180, SDM630, SDM845, SM8150, MSM8998).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Add more compatibles.

Changes since v1:
1. Correct order of compatibles.
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 2f816fd0c9ec..d3c25daa995e 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -18,6 +18,13 @@ properties:
     oneOf:
       - items:
           - enum:
+              - qcom,msm8998-tcsr
+              - qcom,qcs404-tcsr
+              - qcom,sc7180-tcsr
+              - qcom,sc7280-tcsr
+              - qcom,sdm630-tcsr
+              - qcom,sdm845-tcsr
+              - qcom,sm8150-tcsr
               - qcom,tcsr-apq8064
               - qcom,tcsr-apq8084
               - qcom,tcsr-ipq8064
@@ -27,6 +34,7 @@ properties:
               - qcom,tcsr-msm8953
               - qcom,tcsr-msm8960
               - qcom,tcsr-msm8974
+              - qcom,tcsr-msm8996
           - const: syscon
       - items:
           - const: qcom,tcsr-ipq6018
-- 
2.34.1

