Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7705154E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380425AbiD2Tz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiD2Tz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:55:56 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EBD89331;
        Fri, 29 Apr 2022 12:52:37 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id x8-20020a056830114800b00605fa3c9e90so1149873otq.2;
        Fri, 29 Apr 2022 12:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9Vjs85xufky4aYHkz/e+mx0EVbxLmlUBWCH/SDU9N0=;
        b=SQHEch20euMKuTSXy3R69ZKlNlOm1LSsUJROmmJTBSaEYGAu0Sz+SvfMdgNqcS2iqI
         bfAWUenKtw2bsNck/7hYNRTaeLecKKlcFAV+m8KxmZ/PqIu8X/B/TvNIvyG1Jiy3U/SR
         BuhyoL0artH6wETt/riyQB2i2DoR8O0ZzN3m023J2nUcpOJrCBmGanxcXB+I9jY1/zHP
         RV9b0QTAOpJrEcRJzWvpA+4D8BlF2KNH20TLySic9G4rWJWXjIMW+SkJ2z8LahHkpx0e
         a0j8i+YsL5dSaFyOU9lJ1f+CuboPQuwurmy0PExflG9kNw3QjcmyrfrGiaYKz/TDVEuV
         VvNg==
X-Gm-Message-State: AOAM533v5MIjPXRF7G5GGix9WucFrjOaIrhDaNm2+6vSgf3Mk6wXT5Wh
        jQGNrHDtHgmuZrzy5PbLRg==
X-Google-Smtp-Source: ABdhPJzn35H2MS02cc8yGaHGcxHK11y6uZhf2K7MMyY/rbTIg05isBDCaeiyEjVzOMpsxaGopmMCjw==
X-Received: by 2002:a9d:6ac2:0:b0:605:d9b6:b150 with SMTP id m2-20020a9d6ac2000000b00605d9b6b150mr385127otq.50.1651261956341;
        Fri, 29 Apr 2022 12:52:36 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id f11-20020a4ae60b000000b0035eb4e5a6bdsm831129oot.19.2022.04.29.12.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:52:35 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: Allow values for drive-push-pull and drive-open-drain
Date:   Fri, 29 Apr 2022 14:46:11 -0500
Message-Id: <20220429194610.2741437-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few platforms, at91 and tegra, use drive-push-pull and
drive-open-drain with a 0 or 1 value. There's not really a need for values
as '1' should be equivalent to no value (it wasn't treated that way) and
drive-push-pull disabled is equivalent to drive-open-drain. So dropping the
value can't be done without breaking existing OSs. As we don't want new
cases, mark the case with values as deprecated.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/pincfg-node.yaml     | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
index 4b22a9e3a447..f5a121311f61 100644
--- a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
@@ -52,11 +52,19 @@ properties:
       hardware supporting it the pull strength in Ohm.
 
   drive-push-pull:
-    type: boolean
+    oneOf:
+      - type: boolean
+      - $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [ 0, 1 ]
+        deprecated: true
     description: drive actively high and low
 
   drive-open-drain:
-    type: boolean
+    oneOf:
+      - type: boolean
+      - $ref: /schemas/types.yaml#/definitions/uint32
+        const: 1    # No known cases of 0
+        deprecated: true
     description: drive with open drain
 
   drive-open-source:
-- 
2.34.1

