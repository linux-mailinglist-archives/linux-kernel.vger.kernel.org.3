Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9F506C04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349894AbiDSMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352481AbiDSMNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:13:15 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E921117C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:10:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t25so20975295edt.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OaKvm/W3cKidhNGVbz7NvOQrnP1XfFv4Gbw7iAfrpxw=;
        b=eN3JkimOu45Rmub3ypPp1BNOx4qdGugKn99CdMW8MppBShq4X02yTvyUJnfmHr5YqQ
         owFaPoT9YeLxuBI4+4vPZGULAZS++COZEsOMsiUddzqjPv7frjxhsGhrWhq1s6Fs0jCk
         0SrGV9eOsmerW3Oo3OMUV2+n3JJ4BDiyusn1S26WqbtWnN6bFM2pYO1aTRYUtnq3ysas
         JVxSDCWTGbmyvTMISNZ2ZgGXUPte09z/ZmkJzCinAsvMZFcq/9eoaMxrdjy+LCBwMJvZ
         Z3iMQwq31beglT406+DWCSZK+RYrxgaU5tTr1tqykP850GxSMoAja01sRk0B66ojBEys
         Ebfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OaKvm/W3cKidhNGVbz7NvOQrnP1XfFv4Gbw7iAfrpxw=;
        b=vhp3W06SvPkozSm87PaJEVoOVatwFUtbN4ACXEcW0B9iInACSsVnJU3ZxD9/VZPYa4
         XpmyTc/T0KR8Wcv5ehxFucO7zq8xN8Nsnx2UAN4o2tiJlyyNzB4CL06U/b1GEyVD0v3P
         eGZTZxiE+LcvuKzYZmPiC6oOJQDk+8mMmGClepahpU3RC1SJCwQBgJAgKGf/eM38XWk6
         o6Ds2dWtrY0100kDp77urA/QHN3uXUMARDCvJSV1h3KQPZYHVsp82reO+B73PCNOIx6q
         uSUVdGYkrjd9LO9v+vzEFl0Rf/Z82meTLr8tpty6vECN92G8Eq6CoNQvEkTGCInySDHi
         23ow==
X-Gm-Message-State: AOAM533YRoS9ii4tpUiv/T/99V1Zb8FmHf68zdR66EpZEz6lG/TOxG7V
        ipfZP6RRjOQQ4b19+IJkfjcesQ==
X-Google-Smtp-Source: ABdhPJwJZ/XSXzOYW0xlv/zRQtleA4Prm2xP4nZUTHR3tY+lmJWKVt+UBSW6Zzqrw69Rjh0M9+wPmw==
X-Received: by 2002:a05:6402:d4:b0:418:7193:da1 with SMTP id i20-20020a05640200d400b0041871930da1mr17290663edu.57.1650370215390;
        Tue, 19 Apr 2022 05:10:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b00422f5d9762fsm5954466edb.67.2022.04.19.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 05:10:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH RESEND] dt-bindings: usb: samsung,exynos-usb2: include usb-hcd schema
Date:   Tue, 19 Apr 2022 14:10:13 +0200
Message-Id: <20220419121013.250023-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Remove parts duplicated with usb-hcd.yaml DT schema and include it
directly.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

---

Hi Greg,

Could you pick this one up for usb-next?
---
 .../bindings/usb/samsung,exynos-usb2.yaml         | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
index 340dff8d19c3..d51f91d1139f 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
@@ -15,9 +15,6 @@ properties:
       - samsung,exynos4210-ehci
       - samsung,exynos4210-ohci
 
-  '#address-cells':
-    const: 1
-
   clocks:
     maxItems: 1
 
@@ -46,15 +43,6 @@ properties:
       Only for controller in EHCI mode, if present, specifies the GPIO that
       needs to be pulled up for the bus to be powered.
 
-  '#size-cells':
-    const: 0
-
-patternProperties:
-  "^.*@[0-9a-f]{1,2}$":
-    description: The hard wired USB devices
-    type: object
-    $ref: /usb/usb-device.yaml
-
 required:
   - compatible
   - clocks
@@ -64,6 +52,7 @@ required:
   - phy-names
 
 allOf:
+  - $ref: usb-hcd.yaml#
   - if:
       properties:
         compatible:
@@ -73,7 +62,7 @@ allOf:
       properties:
         samsung,vbus-gpio: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

