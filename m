Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B075970EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiHQOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHQOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:23:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B89019E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:22:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a9so19175364lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VObf1U/N8UHUESYSVlFmc9b7qCeolOROsEojZwgQxXU=;
        b=gVYndhUj31KN6r5OGRirSYpbDRRhAzMsEQzf9mMnWgzmNuzNcli4K+E1Xc4KsS1oR6
         hwsEy+wxkgcFZXcUT6AnDAK2C2LVRwZNKkRp4H4ElXUXRSZUhLdykBiZ858usfzjH6Go
         NrtIgW7CdarA78voMkYhI6P3hDicr8CtfQ6kQAztgLXAb74ooy7mqpaQiy7mClKVA5Om
         MBd/Ofq48h0KxS5Sa0GP9Mh1YJTXUy1+2Ie5j/Ytov0+A057ulaYiYu+3du9Qn0tmUuI
         yvY+ovsOM1vDhUc9mNrnVCuBgdEHa3x5ZIBqWd8RUvRU1UyvNpsbnc1AbaNKT1kTKDzL
         6I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VObf1U/N8UHUESYSVlFmc9b7qCeolOROsEojZwgQxXU=;
        b=z5Lm2AB5wuP3KBJlRj+DuPGjA6GcUYVNA0klf/cxKDKUKHIjAvdR7qDABf9YEv3wsc
         V2FM9bueHZA25qjXWoW1GoVCKLEhnW4ydyGIhFYffXUOUvaOg3HqRbRNcuEE/HB1sRuF
         Vhtn6o0CGc0Q8LoSA0QzESYYs0f5oMX5LAq3VCfwupj9e7vNo1pa0pUjzRmIrbV2OZ6B
         iwXjUTHuISpqpYoE+hQ9lMZJKHOSLg/U9tFgztFJkYWb6sWF0shpnSNcW9FI26OZ81yS
         yMEPvnWSzqX0a7Iv0VFj5gRCtNxA9+T3Ewzat/mBuoDjmVLLBxiQNLLdefGbBGNXBFH4
         5lQw==
X-Gm-Message-State: ACgBeo2S+7Ftum1+T711M8VC+bFQ75deIwtNZFCf9NNR/M0z9t3oF8kC
        tOYjw5W7uKkN+Uaym/TaRPkyIA==
X-Google-Smtp-Source: AA6agR5kuEiHgb92CIQVal7Vbgb0X96KkKeqdicRbNROnlHSGkaMem5bDkh4iEDOZ9FGxCYJe8GORA==
X-Received: by 2002:ac2:55a7:0:b0:48a:ec71:1e4e with SMTP id y7-20020ac255a7000000b0048aec711e4emr8046413lfg.262.1660746177155;
        Wed, 17 Aug 2022 07:22:57 -0700 (PDT)
Received: from krzk-bin.. (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id u1-20020ac258c1000000b0047f7722b73csm1704647lfo.142.2022.08.17.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:22:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] dt-bindings: mfd: syscon: require specific compatible also for simple-mfd
Date:   Wed, 17 Aug 2022 17:22:46 +0300
Message-Id: <20220817142246.828762-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
References: <20220817142246.828762-1-krzysztof.kozlowski@linaro.org>
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

The syscon bindings require a device specific compatible, beside the
"syscon".  However schema counts "simple-mfd" as such, which allows
simple-mfd+syscon to sneak in.

Adjust the match to be sure simple-mfd also comes with a device specific
compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index c958086a5fc3..a64c7a71e6fe 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -72,7 +72,7 @@ properties:
       - contains:
           const: syscon
         minItems: 2
-        maxItems: 4  # Should be enough
+        maxItems: 5  # Should be enough
 
   reg:
     maxItems: 1
@@ -93,6 +93,18 @@ required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: simple-mfd
+    then:
+      properties:
+        compatible:
+          minItems: 3
+          maxItems: 5
+
 additionalProperties: true
 
 examples:
-- 
2.34.1

