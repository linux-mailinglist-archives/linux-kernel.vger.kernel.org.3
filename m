Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B657A571D10
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiGLOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiGLOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:43:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318A6BAAAC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:43:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e28so10724904lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Wjg2aNHGHhzVH0rmb+gMIgs2nU+ES+Qag4lawsLAuY=;
        b=puVT3P1p2qJp+NmPSiMqNLoPTA+0Ma9/RXwHTNIccnaJspTHbnbW7GacdWIOtZS3xb
         NjFovWEJweHWtB/B7/MwAjAiPj3FcqFe8FxGrexHv/hXii8LTj6Po7un6Qs+d4OGw/Lh
         +jzZiarCoF+Wn3VpT5ogHARoL1RIp4Gqiv4iXWtPOjaXCc64eVfnoaZqxdZqSwah1qFd
         9wZtGq79QLrbf20QyxxHwDyH9OcU8V+DgdPXoeDjh3dfczmns3kpZd2QGscvA3nDp4O6
         uHi29KLR1SL3H+laWVXpewAERf7Ek/Dc3RkO3lSSN02JHwn4A4DGs2NJvizsgulOj33W
         p7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Wjg2aNHGHhzVH0rmb+gMIgs2nU+ES+Qag4lawsLAuY=;
        b=rplWzQmAftVcu3n5ssMoA6AIBpYsxcGVSbo9qvDzC45BcMEM9YXrIRv3IOarNdfvWB
         VvWMSJjePVFssWVgxCz/R7fyh3+IIIdO3dJzioo+gEcnzveDnqg2DCOpTgCn6tXbmrug
         bVaJj88iSI94A/5xHhnjWeRIFyxU9TJaAnr1lSzZeiPh2XNSduFmvvq0/W4XKvO/6ujk
         rsyZ4JaJfrFC7QgtYpUJ7DuD92X3o+GnJbIx3vF0wcyZOWoC4aOYdg5MmoEveZhYT2h2
         vaSSOA/luwfivkMEz35DmmRQ0Fhaw3B4kMmNo/8FMHZXtDrY9UnW9kriTPNymLnF/LqB
         E/Lg==
X-Gm-Message-State: AJIora9/nwATQY8t/RssnQ+uhdZPGacS1Y1CzoD+WH69XD+69cQPO5nG
        hvR4FfHr14FvNjApStVXyrDgtw==
X-Google-Smtp-Source: AGRyM1uBu2DHJl3HCjTGsddMKmXgr1sdiOfLGZabWUMPxQUPwM9DZ0e4PJfWBLgoYiW1Q9uT1MF3AA==
X-Received: by 2002:a05:6512:b14:b0:482:a9b1:ea3 with SMTP id w20-20020a0565120b1400b00482a9b10ea3mr15787589lfu.353.1657636978549;
        Tue, 12 Jul 2022 07:42:58 -0700 (PDT)
Received: from krzk-bin.. (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651234cf00b00489e88d6a72sm737577lfr.198.2022.07.12.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:42:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 1/5] dt-bindings: mmc: sdhci-msm: fix reg-names entries
Date:   Tue, 12 Jul 2022 16:42:41 +0200
Message-Id: <20220712144245.17417-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
References: <20220712144245.17417-1-krzysztof.kozlowski@linaro.org>
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

Bindings before conversion to DT schema expected reg-names without
"_mem" suffix.  This was used by older DTS files and by the MSM SDHCI
driver.

Reported-by: Douglas Anderson <dianders@chromium.org>
Fixes: edfbf8c307ff ("dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.yaml    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 0853d0c32dc7..fc6e5221985a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -60,22 +60,22 @@ properties:
     maxItems: 4
     oneOf:
       - items:
-          - const: hc_mem
+          - const: hc
       - items:
-          - const: hc_mem
-          - const: core_mem
+          - const: hc
+          - const: core
       - items:
-          - const: hc_mem
-          - const: cqe_mem
+          - const: hc
+          - const: cqhci
       - items:
-          - const: hc_mem
-          - const: cqe_mem
-          - const: ice_mem
+          - const: hc
+          - const: cqhci
+          - const: ice
       - items:
-          - const: hc_mem
-          - const: core_mem
-          - const: cqe_mem
-          - const: ice_mem
+          - const: hc
+          - const: core
+          - const: cqhci
+          - const: ice
 
   clocks:
     minItems: 3
-- 
2.34.1

