Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEB257BB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiGTQhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiGTQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:37:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692395B07B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:37:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e28so31116600lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kp8iCiN1Lxt5s2kzJFzxbS/dwJfrlU9B2NVr6P7nJY4=;
        b=cw76WH5XkBndt8XkuIVyL5Z10zdQ9KgHP3PcvXoTiEC3ELZK8dHW/cgRWjpusfaNAP
         yr2HqqYHUgj1WnflMsZa+nxp5qe8ACM2Ao4tsH4SS8NpGRvCJmD3c3XMcSmZoa5gTRV6
         FjF9mG5o4Yui7CqgkyMTD88qrKxhaqwDCbQZrcR/4+kCVj+G3EJ/CfYeiLW2aBFlyVbU
         ffFnGFK9K9hfUS60ffYlTfbs/LSvvZrYWtYzeatqJO3tTxCdQWV4ozrBljSo+pgfrddy
         lKyaQA4mxWe/AYbAYWemtU8efbW921gTgT1oKA/kcWdf0HkrNTVkUmxsDnvXfA7DGrHR
         oZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kp8iCiN1Lxt5s2kzJFzxbS/dwJfrlU9B2NVr6P7nJY4=;
        b=b4sDRqujaj3GGCglVj07cctN+GEv8vrgT64JBlrpqNBTE3xve/l7RpUMaezKIvFqPp
         bvcqXEPccbF91I1PAkGsUsM6LG3qmMTarCUWLulL1iY3DuWHblZ8HhfvJC+DG5L6RBwd
         s7jgFdVdPwMWMGKYoPEVbjzWmVN7vL1nlcd7pWDgwjWqmMkjm3vpCh93DniwCENuyfBV
         nZnVsUjAGhpPey2fRSDBKGWvo0y5PJVCxKppcuLhrn6x3H+9xKyR1zKBLgdewr8gIc5v
         j2wzEoXP/REFbG4fCq//ozOVqkHQPH7B3LbuvFJ02Z+NN1rCLe6gLILb4msrVCaNQCzh
         wldg==
X-Gm-Message-State: AJIora/0kLFUYU/hMfTDT31dlVct7pF53mP7Jgu1IFFqNmjhh/wUVnuP
        E9jgmRUcD35WkxtVjK5ubetTMA==
X-Google-Smtp-Source: AGRyM1u7LbBSTLIdP8XMWj8CWDvGif493sK4UA0Un1erHq3+g9Xxi6JABJUt6y0RHWcWjfA3cBeN+w==
X-Received: by 2002:a19:dc06:0:b0:48a:103a:82ee with SMTP id t6-20020a19dc06000000b0048a103a82eemr19275725lfg.87.1658335050731;
        Wed, 20 Jul 2022 09:37:30 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id 27-20020ac25f5b000000b0047255d210e4sm3913409lfz.19.2022.07.20.09.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:37:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND] dt-bindings: leds: qcom-wled: fix number of addresses
Date:   Wed, 20 Jul 2022 18:37:20 +0200
Message-Id: <20220720163720.7099-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PM660L, PMI8994 and PMI8998, the WLED has two address spaces.  This
also fixes dtbs_check warnings like:

  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb: leds@d800: reg: [[55296], [55552]] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/leds/backlight/qcom-wled.yaml    | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
index 5d66c3e4def5..4c15693f7a01 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
@@ -26,7 +26,8 @@ properties:
       - qcom,pm8150l-wled
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   default-brightness:
     description: |
@@ -171,6 +172,9 @@ allOf:
 
     then:
       properties:
+        reg:
+          maxItems: 1
+
         qcom,current-boost-limit:
           enum: [ 105, 385, 525, 805, 980, 1260, 1400, 1680 ]
           default: 805
@@ -189,6 +193,9 @@ allOf:
 
     else:
       properties:
+        reg:
+          minItems: 2
+
         qcom,current-boost-limit:
           enum: [ 105, 280, 450, 620, 970, 1150, 1300, 1500 ]
           default: 970
-- 
2.34.1

