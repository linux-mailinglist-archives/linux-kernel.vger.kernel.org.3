Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFEB544A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbiFILj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiFILjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:39:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C7197984
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so35831512ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n04xRHDLPG5HTJiUoTVbiyOiGV01+5rVdjSb2OnFTXM=;
        b=Ho4w2nM3+Q5bGqtr36/o6zunEJf1I2XT6LKt8qPNLkRCy08ezqkJOGQcvBy5vco1my
         LGBVSuQy2o3zJ3VRCl5ktdED8AwYX9JPpK6G/5qGM8by9MmCH5kjgAac+5wdKBNIpFR8
         xwCEy+untlqCgNrdyjBW7OOwtMZ/fatULZ5sRrG0DbV8h1a8fkBFQZrHUVRrHVTdOMOk
         bFY0Q+lM7yWFhuw7oGtstkGAHtRN906miEa6MNINObX4FBiMpladAqhuYFhntv02FElx
         IpEdpyFjcGNvTY5jsUxfo3i9hgyGqj3e7n/Ht1bGDfF6O7zBd2Gr4mncFJWMEbpebOEc
         /opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n04xRHDLPG5HTJiUoTVbiyOiGV01+5rVdjSb2OnFTXM=;
        b=G/5zMOXEi2kQqGqhBWAzmEcmO0q34AxGrRLEvZYRLMVSj88IJM/kwwAinJeMuxoM/W
         ETU3gfFct6p9mEy4+OywAbf+mwPQHxtx8z63c6yPrfF8clFl3VIhIe/Rmau+haWAAuuw
         YBncQI4k6mNgAIVWv5SXJJp0WGeE+0VvSgO5QTZAu+JLhcYMbmdbxN2GhRjvI1xm4hjn
         EK6y0HfiMmQIqUsJRTCPbtv5is58+ZRGIsbDweEmZxfptLM1NRmRZuDd7SRAIr9SSPXX
         9/Av9vGopqls+g4hyHmTeFuoF68kZVjkhBSiwe05E6t3lV2CwOzgiNDkDoDT5SGzZIS+
         VBoA==
X-Gm-Message-State: AOAM532/3scE2rAlGbpQM9JosecolhGBS8hdb4zX9nW4f/eotTWiU+QT
        wN1ZcRBPtqXvrf+ToOwDjiMhhQ==
X-Google-Smtp-Source: ABdhPJwgFvtD9GYY39BjWKd3xyuHcJYvYead1t+NeA7lJVCKNmpwd5ABumStlG++pLlWR2zP3uaRug==
X-Received: by 2002:a17:906:e202:b0:6fe:478b:7c1 with SMTP id gf2-20020a170906e20200b006fe478b07c1mr35455237ejb.419.1654774757503;
        Thu, 09 Jun 2022 04:39:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d54e000000b0042e21f8c412sm11898495edr.42.2022.06.09.04.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/48] dt-bindings: input: gpio-keys: accept also interrupt-extended
Date:   Thu,  9 Jun 2022 13:39:05 +0200
Message-Id: <20220609113911.380368-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
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

Each key device node might have interrupts-extended instead of
interrupts property:

  fsl-ls1028a-kontron-sl28-var1.dtb: buttons0: power-button: 'anyOf' conditional failed, one must be fixed:
    'interrupts' is a required property
    'gpios' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/input/gpio-keys.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index e722e681d237..17ac9dff7972 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -92,6 +92,8 @@ patternProperties:
     anyOf:
       - required:
           - interrupts
+      - required:
+          - interrupts-extended
       - required:
           - gpios
 
-- 
2.34.1

