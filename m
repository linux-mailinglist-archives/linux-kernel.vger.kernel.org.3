Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A5596E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiHQMEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbiHQMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:04:20 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037024CA1B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z20so13361657ljq.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IB+sPWwaEMPz1OqOHo1E0jzt4v44qohfF0waJg4s+1w=;
        b=hbHSmbOgPrUflh2qJIINqXaOfHaRrEN3He2IRoZyS/a2LnHvI3KNsB9xVvigmWcXF7
         giImKKhZxRbfuZiDPxdX7TRaSyIbb8fvK8tGXezscV3a0j0MGJ2+c7i6RYfB0ddzxCMm
         8DkZ1vUgktzWgRTB7GifTszH+WjixTZhz7FYtJdwrt/V+iyec9LmXX/Uzow8Ai7nSxIK
         3YxqNOlQyEA5MDmtIc4w5jogg5QusEgFEEEFyCpiRSQ54xA0MxIrUW8M16LmuioQwyhB
         vikAeo6nAuvfa3bdWK9m62LqP+IuOPZARrHd5KQ91goclHHZs9CrJirjXdu601zFfQ/M
         h+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IB+sPWwaEMPz1OqOHo1E0jzt4v44qohfF0waJg4s+1w=;
        b=W9sFKlE60W2UFRyFso0BZ1BvPQKQnVdloUBh4WyNR5FVgBTsA/heAjjuofl4c8NMvW
         VIWFBIEJJ88A6Sm9fbmQ6QwWIzLrXm5RAeKaj3dC5VvQewZ1JebR8NsCdi8gow2tExIt
         4A5nHOT2t6ZNazZHfOZworswnhCVmX7VWSltFS9Zj9EKRRBpJYmRAKi/da4hOd14BsaF
         VLjtZFBvunKXvA2klZ+aB/H7fiVkSJNB8cvKh5r1dlLLru1/pLvvidUj3aG85orS2N7n
         KJ7yOGn/Xq7obHtcoD2eFAr6tX4rUtYoSVF56Zn1jwVGIK/k9c30WkeeE/uEnAQsJHXh
         t9UQ==
X-Gm-Message-State: ACgBeo0mhUVdYX7Im+haEyFtKSXfZbINs5tHBWZX+kBBvmw4HYD7AT7J
        MpSVbnkAx5aNZK1BBLJS226Mlg==
X-Google-Smtp-Source: AA6agR5fKkvGxBwkL0hj6yQpGY56qpuYYqOvN2B34Y3KlAtc0/6tWAnB8u6Xx03g8ffThw4Yks6DwQ==
X-Received: by 2002:a2e:82d5:0:b0:25e:4d8d:4c67 with SMTP id n21-20020a2e82d5000000b0025e4d8d4c67mr7425426ljh.490.1660737855398;
        Wed, 17 Aug 2022 05:04:15 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id d15-20020a05651221cf00b0048a97042251sm1670496lft.22.2022.08.17.05.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 05:04:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 01/14] dt-bindings: mfd: qcom,tcsr: add SC7x80, SDM845 and MSM8996/8
Date:   Wed, 17 Aug 2022 15:03:50 +0300
Message-Id: <20220817120403.458000-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
References: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document existing (MSM8996, SC7280) and new compatibles for TCSR syscon
registers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index 2f816fd0c9ec..19bc1cc5e0c5 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -18,6 +18,10 @@ properties:
     oneOf:
       - items:
           - enum:
+              - qcom,sc7180-tcsr
+              - qcom,sc7280-tcsr
+              - qcom,sdm845-tcsr
+              - qcom,msm8998-tcsr
               - qcom,tcsr-apq8064
               - qcom,tcsr-apq8084
               - qcom,tcsr-ipq8064
@@ -27,6 +31,7 @@ properties:
               - qcom,tcsr-msm8953
               - qcom,tcsr-msm8960
               - qcom,tcsr-msm8974
+              - qcom,tcsr-msm8996
           - const: syscon
       - items:
           - const: qcom,tcsr-ipq6018
-- 
2.34.1

