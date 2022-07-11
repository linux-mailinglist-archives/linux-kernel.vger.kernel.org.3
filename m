Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D756D7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiGKI3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiGKI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:29:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0378B1EEC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m18so7466762lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Wjg2aNHGHhzVH0rmb+gMIgs2nU+ES+Qag4lawsLAuY=;
        b=c/Rbjb8JN/KOgGFpip1vaIMZXn26IWkkX0JXz22/EBl9+ZOAYplF9CYkYImpgLfBcV
         fDRCs8bJnNRN44W/bRjxWkMDC8wj4n8dDrAsJ8sTMlxWNDOJj4M5a3sbnHcCRLxYTZsx
         Os1vRfd2GiFGuyBMtl1QymHDi8I0gJgMJQOuG/hDg7ddp0HtTGcwpHxMhBv8AV/TZ7+q
         sL0JNmrBNEW4G3pkeeAnxI77sjvF7ZMBq2Yc8gn4N4yPrr3BM8+zbtdQDzyX3oiviyRW
         LBj/6dVp+f0yR55COkP6UGOQb0Ohm1Hcezmbdaw7afn+HOOn7sJBiKu4ur01JFGH/z/f
         fBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Wjg2aNHGHhzVH0rmb+gMIgs2nU+ES+Qag4lawsLAuY=;
        b=PBQa5NdAStIvHIC2rr3BkEZW0TyWTsw65oD+j55bN7J3p1QJatnRrRHapuisCSoDYx
         vx/kPCFm1Ri6+3Za6CDEP4Kh7x3/xeqCcJY11enhRbDZuT8eJq5837Zg+a73Rfzjr0iJ
         Dh0h36les4jGab754KEAv1cJCT86qSaWRBBmLNzRvrG1Qw+bVCWIG3cIrdA1xmfDkCjG
         K8ObX8VSSaTgm1DqA5A/z6W3xFTD2zOFLW7r+8FVOoo6Aw1AD7pBGi67haH1jdltHR16
         DpWmqC4wd4J9h1zKKIRZzb7ZOTxzbT/G81Z1ckJ9eOos7Cot5fF4C5U/WzYxNzH4B8y+
         iIog==
X-Gm-Message-State: AJIora9lUcNyvOvq+y2s47HPu9wsXjvulzA7XdmsP8i8ziSAUJdIILiy
        w2R0/yzmcELv+xlP5XITES7pow==
X-Google-Smtp-Source: AGRyM1uO1bbEabxaRwKA9Chd6nXooY4Sq5JJgKPq3Ahox5YbG+Av4DlyL2FhtHN6biEjgssju5ZjLw==
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id x32-20020a056512132000b004888fcce196mr11179813lfu.602.1657528188334;
        Mon, 11 Jul 2022 01:29:48 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u2-20020a05651206c200b00488ab8914b5sm1401504lff.213.2022.07.11.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:29:47 -0700 (PDT)
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
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/5] dt-bindings: mmc: sdhci-msm: fix reg-names entries
Date:   Mon, 11 Jul 2022 10:29:36 +0200
Message-Id: <20220711082940.39539-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
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

