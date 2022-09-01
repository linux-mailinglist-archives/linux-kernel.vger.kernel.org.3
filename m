Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669785A9285
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiIAI4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiIAI4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:56:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3412CB12
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:56:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bt10so23439291lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7mCanjn29Z/rrHV7lcGYwLLR3hfJpckAbbzYP2xrGHY=;
        b=WPhWWn/baRHPBIBTEDEdWZ2nx+15sKff267S+Q6FCaFGh8NLGl2u2ZdG+7cQs30JKD
         zfdalCK+Wf2le44fT7f5mk6UFHaaBnAqj0tb98hVhWSvrS1NZ4OVKHnuUThrlq1Qmo52
         7FTUtGY4cwW8+K82DVBHc0ZHgG8B/FZKZonMgktGavPLOqgB8vHjkHk400bGLRzLmsb3
         Db5ffWVKuGlL9BByhao1ceTrKIIxqPctrXMrphcxCNApQgg2/rZwnQSRTFKXAtyJBoRi
         s9wT7Ip5/U6xvY3Vjx6bpXyzUOtf2ZX6333qshrxiSYAwMWZTGa5v0k8bqYKV2/DVp8u
         5xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7mCanjn29Z/rrHV7lcGYwLLR3hfJpckAbbzYP2xrGHY=;
        b=dvLCXDhA/iLEctFHaZFFlhv2653eEEmYRzB3tl0WNFTd2DwA6aRUvgWYkWK92HkOyu
         eHq9aS2w5H8ybYN65V4gfADLCcKNn5AFdsKrn3/xQw5c/0gLq8bSPIcav5pAKHKVX5X7
         QokN2UsCMXfFi6tXAuuNzYFlQKsX5Sg2erLA60ebaASvEwOB+84h34a8QSxUiQ8fiXvD
         YDC8zuZcTrI7G9kpyxhRLjEcf9VNOjD6oGKPxQqgFe0VDdi5yaIYHA3j7KMf0L9Cn2pR
         Gx+g8yACmQqE5pIh3qaOWjxp6fn+mJbWWzdDyJHM55Sz09MiH5eRSyRNeOLUV1paMr9T
         7JTQ==
X-Gm-Message-State: ACgBeo0PksWELYHcClrz5uvPj28+UGt+IMEy/qFGUbfGmyTrsFoE9inJ
        cCw8oHzfk7nB7hTAI/r16GR1i8ZhLSiE4lwv
X-Google-Smtp-Source: AA6agR7z1Q9kJzKNUjrW5qttM4Ya/9QfDlxxbWpVIibldU9XBDwYcNl6KP/AHntIAF9zWQCYSFv1VQ==
X-Received: by 2002:a05:6512:ad3:b0:492:d78f:2c09 with SMTP id n19-20020a0565120ad300b00492d78f2c09mr9793826lfu.99.1662022571822;
        Thu, 01 Sep 2022 01:56:11 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512075400b004947984bc78sm883856lfs.188.2022.09.01.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 01:56:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT 1/3] dt-bindings: soc: qcom: smd-rpm: add PMIC regulators nodes
Date:   Thu,  1 Sep 2022 11:56:07 +0300
Message-Id: <20220901085609.95624-1-krzysztof.kozlowski@linaro.org>
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

