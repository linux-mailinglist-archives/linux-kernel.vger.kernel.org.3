Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4706E582ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiG0RRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbiG0RQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:16:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411627B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:43:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bf9so27828519lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dq1uiZkAWa3YJvnfamL8dc9poZEqWN+zXqH3YX0Ei5g=;
        b=qCyMVBkCXFWl1AlJ5rfWeaCJL8jbUT35O7IxR89YvWURkZkpEiIbfagT6bJR1uSTck
         YbU0zVyldV6p6XW6UPlKR00YL+u6oN22qGh3V9lr5RSCTRxlTg+6j/L1shioPpEaS7DM
         ftpLvGyWCZ4+68kqY/LMvV0tyXTclfFKxn0mbsxA8s+4Q6K4RFIO+s856ieFJmBcpnW+
         /D2V4JWTU3+J4p4RgsA9fCq1V2L8dieLqfkcESOSMz5v+uN+0E8rlxc14XXQP5MqGJmq
         uJ5bAEibiJbYXh7hTOYcNgy4qXuk7IeI2q0jqOu2k2ViRQo6nhIypR1TXJ/sh8Xcs7M3
         7PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dq1uiZkAWa3YJvnfamL8dc9poZEqWN+zXqH3YX0Ei5g=;
        b=wuTkZWN5+ue5MdjllRSDGVkeMNPO2bLGjxu6ALD75MIji+agcI8VVpa1N0RlDly6OF
         gQTBmHAVmk80aCz9ir/tDnNDz2ClaKI0Ad6S2kmgvAhOGnKaPuYCna08j5fTEY4f0xMo
         qOogmuX2PxwQpa2Q3DfzzEtO99/s3d9Vk4hSn11V3PoJ+/oZ+EmJfCTGknUCmAF6mmLi
         YnG96lWS8aSAjNspSEYHmCI3VHR7ZheBrEvTPlKRdHnvu0lVDl1auHbPPmh7VMYDdzSH
         S/ddsPGW+32U36jzyoHeTXU8jX76ok/r+6Qgx7TuvcP0tSXaZum6L6G8kmh2YdoZmfU2
         Yy1w==
X-Gm-Message-State: AJIora/R3pceLYGW3s3CbjPF1HymEU1RuJPNVr+jwB2oy7gy4Ylywxu8
        kkN36bKikUb7WN3d0jleXwqGWg==
X-Google-Smtp-Source: AGRyM1tjstljwcPGnQ8nUewAwhzjHnExmu7i325wwT19JRsKZYk7zO7l24iTwuawcmiATp8A/e/MEQ==
X-Received: by 2002:a05:6512:2826:b0:48a:a02c:4a6a with SMTP id cf38-20020a056512282600b0048aa02c4a6amr3196539lfb.29.1658940195058;
        Wed, 27 Jul 2022 09:43:15 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id t17-20020ac243b1000000b0047fae90bfb4sm3869763lfl.56.2022.07.27.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:43:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Lechner <david@lechnology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Heiko Schocher <hs@denx.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:43:12 +0200
Message-Id: <20220727164312.385836-1-krzysztof.kozlowski@linaro.org>
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

Instead of listing directly properties typical for SPI peripherals,
reference the spi-peripheral-props.yaml schema.  This allows using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

Remove the spi-* properties which now come via spi-peripheral-props.yaml
schema, except for the cases when device schema adds some constraints
like maximum frequency.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

The sitronix,st7735r references also panel-common.yaml and lists
explicitly allowed properties, thus here reference only
spi-peripheral-props.yaml for purpose of documenting the SPI slave
device and bringing spi-max-frequency type validation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Technically, this depends on [1] merged to SPI tree, if we want to
preserve existing behavior of not allowing SPI CPHA and CPOL in each of
schemas in this patch.

If this patch comes independently via different tree, the SPI CPHA and
CPOL will be allowed for brief period of time, before [1] is merged.
This will not have negative impact, just DT schema checks will be
loosened for that period.

[1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
---
 .../devicetree/bindings/display/panel/lg,lg4573.yaml       | 2 +-
 .../devicetree/bindings/display/sitronix,st7735r.yaml      | 1 +
 .../devicetree/bindings/display/solomon,ssd1307fb.yaml     | 7 +++----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
index b4314ce7b411..ee357e139ac0 100644
--- a/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
+++ b/Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml
@@ -15,13 +15,13 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
     const: lg,lg4573
 
   reg: true
-  spi-max-frequency: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml b/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
index 157b1a7b18f9..53f181ef3670 100644
--- a/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
+++ b/Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
@@ -15,6 +15,7 @@ description:
 
 allOf:
   - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 3fbd87c2c120..669f70b1b4c4 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -49,9 +49,6 @@ properties:
   vbat-supply:
     description: The supply for VBAT
 
-  # Only required for SPI
-  spi-max-frequency: true
-
   solomon,height:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 16
@@ -153,6 +150,8 @@ required:
   - reg
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
   - if:
       properties:
         compatible:
@@ -223,7 +222,7 @@ allOf:
         solomon,dclk-frq:
           default: 10
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

