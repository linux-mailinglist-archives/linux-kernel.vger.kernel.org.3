Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF634D8BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbiCNSVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbiCNSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:21:29 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353B735865
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:20:19 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01066405B3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647282018;
        bh=ZZZmUkbhHody3cQg6YTtcASZbjcHkXRB0CKHR4Vfcs0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Smi1a+olD8MFzZIGaniNbvWQGH7jreHN8dN+Lp9Hx/0d8ofdKlo2S0IugyUAa/S5j
         iyI9up8ozQjPxGbpQ3uBTy4eJL+CjTSY8JKwzVu31qGksUQIatQBy3N+pSQrOS22WS
         DnSYmfPpW62FLnfXl/M0hIju2/qbMm0B3Fje88PhmKmpFGmSZ3jP4zPrDXOfhieblN
         XvxzV0Hge61bO7A6jMF1Mka9pSquwW+tapLUjDWb57io5me0J1zBisX8Ne/E79E9kB
         C8mtFvMxXB4lFNnVVcWCzBjYxy8xYJ5T8o1Yb6WcOZZ/NEVsbzsJwkXBujSk7gBLez
         HgJGrKDWenmAQ==
Received: by mail-ej1-f69.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso8339119ejc.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZZmUkbhHody3cQg6YTtcASZbjcHkXRB0CKHR4Vfcs0=;
        b=raoHQ5+c8vOiqaUwjFXIRFSJzTg35J4zGZq3j9q9V8FUmDznnba4rUiwV8XMC1FKq5
         Lbd6Mv3o1/aCiOFw/NofZpijPmLnWrw67H15xuMxw2AppdlIpY51Qat+EGbl/Dr2oDCC
         JNLQgZ1SbahAIpsA5OnLvjgLbuH4Bcz5VtuD98+xMYNf4/l5iQykzpVX0Zm01ngzDr4T
         JvoL7InjUoPXgge26Eo+ZCRVBRWFY5SnMPoioeXGEV+9b5dpaGmUFKmm9nhZf2PtTv+j
         cA5djXb2ol0tGAGb3eOGdkCFQsTF4EIF9voJNrs/9I8YIthk8/3drx1C5Oc9fi0n8wlD
         9kxA==
X-Gm-Message-State: AOAM5309nGlX1DVlvyFE1u671q/yBbj47oB7lbrlITMx5o0K2aIhKWtl
        lrrKRlGlz9xQspmtZvoeqTufumm1JN+zWOr6I3UMngqTyyY07wMJk2oNiJqRHqWoeO1D8mPjaF/
        MIBJ3GNb1eHQHFcLydVJlUHwuH3RiUKtluJcvh1/eYA==
X-Received: by 2002:a17:906:174f:b0:6d0:5629:e4be with SMTP id d15-20020a170906174f00b006d05629e4bemr19138896eje.525.1647282016653;
        Mon, 14 Mar 2022 11:20:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxilSk6aR5x6eRg2Sw08ds9XOo2mHj9ui0uVFPKjg2yLuwqGtgXaY6G1Ov0G1h2AdMHYrbneQ==
X-Received: by 2002:a17:906:174f:b0:6d0:5629:e4be with SMTP id d15-20020a170906174f00b006d05629e4bemr19138877eje.525.1647282016448;
        Mon, 14 Mar 2022 11:20:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id i25-20020a50fd19000000b0041614eca4d1sm8566449eds.12.2022.03.14.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 11:20:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 5/5] dt-bindings: usb: samsung,exynos-usb2: include usb-hcd schema
Date:   Mon, 14 Mar 2022 19:19:48 +0100
Message-Id: <20220314181948.246434-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
References: <20220314181948.246434-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove parts duplicated with usb-hcd.yaml DT schema and include it
directly.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/usb/samsung,exynos-usb2.yaml         | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-usb2.yaml
index ef42c6fce73c..76e25b9efebd 100644
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
@@ -65,6 +53,7 @@ required:
   - reg
 
 allOf:
+  - $ref: usb-hcd.yaml#
   - if:
       properties:
         compatible:
@@ -74,7 +63,7 @@ allOf:
       properties:
         samsung,vbus-gpio: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

