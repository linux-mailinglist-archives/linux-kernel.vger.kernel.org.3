Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40014E9F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245492AbiC1TNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245494AbiC1TNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:13:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADB66C8F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:12:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bq8so16733700ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jG3Rt4P3Raf9WSo1WvvLrHkpUajHf7ot05DbpWV2Eb0=;
        b=PZXl6pFWIqhq+IGkvc2dvo1z28ViM0/IcQ4ra0LmbQRG+i3q7bJIKzhEv80XtXXLUZ
         waKmqllEWW4P/SrOXG8yhqE5IICerx62efk1JSCHfpiKs9M0/QM9dNIClCclyNZJanlN
         TZxflkCPUVClCsVlNjmTsqPXnB2f4kUt2KCVXGToBybPB04HISvbSsq+UPvv+XpZkzbO
         whfwwhTEOqTOQebiJmWZWGOeOHWu734U2dHqQHsqubey4vfizUddn+ynpeCpeEn24N5b
         B27SV1lynfnOmxFHMiqlmSB0bG9iX3Xx3lZ0RiEhINPXLJ8cfTZsoWfnosBwhV0fNVit
         VWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jG3Rt4P3Raf9WSo1WvvLrHkpUajHf7ot05DbpWV2Eb0=;
        b=h8aGEAVkohWpOVJdGxghtop+/n1yj5jSnzwFvYUKKI3dT7TUpiCbAWrECmzmED3AUN
         X5+8B7JgEZz0V3feINSKdUaoJZOgbNykwXwXlWRkfLX9iW3AUGrb3DXUVjaso+LomLUw
         Dm9+mzYM/WJuD+oYDP3gSQ0Uiv0vnYLKi2EHXyUS9obda4BKQzN/4qylX1LM4QYqXJR5
         RNDlyG7gcsVGJw3cw4HX5MHUrCQhDh/EPBVpX3JTaKL120UbZ9tRFV4EJjbH3UCINDNp
         2r0D3cZvE86PojbceKE+Nu0vNOJC/tdFXZYVr+WH+gQSUSt4BCkOhh7PJG8TX2B7Rh7V
         tjdQ==
X-Gm-Message-State: AOAM530SSBD5gxhoCzRi0NAGjRB6GnI90KJqtdVneOZAkZW6G/Dej/Lu
        Dzdv/jwyWdqgiPrTUWnvJ8FCvg1XuDlaAxO0
X-Google-Smtp-Source: ABdhPJwFwLiR9+MtMZeMy5VDtsZaqzeSjHEJIe4h1TwW5hRcMHYc4oopQ5oF00JoT/EEnuMkQdrKVg==
X-Received: by 2002:a17:907:60d6:b0:6df:a099:e26e with SMTP id hv22-20020a17090760d600b006dfa099e26emr29699586ejc.34.1648494718902;
        Mon, 28 Mar 2022 12:11:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id gn3-20020a1709070d0300b006e1036666bfsm2166989ejc.223.2022.03.28.12.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:11:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: davinci: list contents of GPIO hogs
Date:   Mon, 28 Mar 2022 21:11:53 +0200
Message-Id: <20220328191153.171241-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The hogs children should list allowed properties, otherwise any property
would be accepted.  Simplify also GPIO hog node name pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-davinci.yaml        | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml b/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
index f32e09ef937c..e5b91c65dcb0 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
@@ -76,12 +76,21 @@ properties:
     const: 2
 
 patternProperties:
-  "^(.+-hog(-[0-9]+)?)$":
+  "^.+-hog(-[0-9]+)?$":
     type: object
+    properties:
+      gpio-hog: true
+      gpios: true
+      input: true
+      output-high: true
+      output-low: true
+      line-name: true
 
     required:
       - gpio-hog
 
+    additionalProperties: false
+
 required:
   - compatible
   - reg
-- 
2.32.0

