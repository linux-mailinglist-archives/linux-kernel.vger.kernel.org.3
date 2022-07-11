Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB256D7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiGKI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiGKI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:27:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710C1C10D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:27:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so5293350ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j2+S7E+CabtwiK8hc0ACQPd7RS/hy1Qx0vqSDzlS7lY=;
        b=Rx9zfM0IYWP0XUUuzPV+ffsO42Y3s+UyZXpxrI22V43s5jlc8K8dhOZU3cCuAAR3jT
         P6j7ed1peYYwEBsfz67q51rNIjbqZr15TRO1avHWZddHpV/dBZ5tLjHS5PFFAcSnhObx
         4mIAh+GVsYqLpZmnIIlZ1d0I5j4DTaZnCwvDkDFQFGvD93RNoPEv4/H+q0dCugGcOU70
         07K93vjTayk5nQKtK2gtEpJm3Pk/OHNrDEbADwmEfkXB90PLpgWhcN+EXNdE4Vjv6F+4
         Vg8XRolAcMGtc5zYm42OlCHkRWBOw6lfiCWHSqsT6cuXlXUvzdFrmxUzpAVCqgFR+upq
         6jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j2+S7E+CabtwiK8hc0ACQPd7RS/hy1Qx0vqSDzlS7lY=;
        b=WO91EgANVauyn3ipPoB+qrBJKMm0taCWJOlzmYqoJAh6oTLDDcVNaMu/3BDiDZia2y
         LtdBfbbSl8Lv2omepkT7T2hhBvtWBMbZZyJDeo7bApel6ds9739fTk5KyKnaFFtMfOCM
         Fy0p+dewdaU2E7HJ/RAOEULRpPhStOO2YjD8RY1Z8rxqQEgRfQoEVPNY91egq9PAffzv
         xJuPR57LOuN4/tNuCic42XhZsHr92r6RYGyOjln+2UFSWDG31w8fue8CpNJxbEPSHYWj
         Km3zqPpPXPXy9+Jio/sts7vxhk3eCy9Z99ieA8XJbvp+D7VWKycmU3iy74w6Qrv13VUZ
         XmXQ==
X-Gm-Message-State: AJIora+5hWLiw1MPIDso4wgbvfhsGSx7jHaJgaAiGQTGzm8m6In/5m0k
        8TBgR93fj4cVc3DK8/F2+xN37w==
X-Google-Smtp-Source: AGRyM1tAoSbEsl1IRZQMJqzFuW/8ocXXGszqpzEyAsJgpmHkH5GhSNfANnC71IPGslFuqZnWTE8fMQ==
X-Received: by 2002:a2e:6e0c:0:b0:255:98fb:cb45 with SMTP id j12-20020a2e6e0c000000b0025598fbcb45mr9240302ljc.55.1657528035065;
        Mon, 11 Jul 2022 01:27:15 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id c30-20020a05651200de00b00473c87152bcsm1408994lfp.127.2022.07.11.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:27:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: add MSM8998
Date:   Mon, 11 Jul 2022 10:27:07 +0200
Message-Id: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MSM8998-specific SDCC compatible, because using only a generic
qcom,sdhci-msm-v4 fallback is deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 01a1f8b79e8e..2f0fdd65e908 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -30,6 +30,7 @@ properties:
               - qcom,msm8992-sdhci
               - qcom,msm8994-sdhci
               - qcom,msm8996-sdhci
+              - qcom,msm8998-sdhci
           - const: qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
       - items:
           - enum:
-- 
2.34.1

