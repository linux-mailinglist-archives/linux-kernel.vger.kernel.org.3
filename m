Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD66F518D9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiECUAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiECUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:00:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDB3FDBC;
        Tue,  3 May 2022 12:56:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l18so35387383ejc.7;
        Tue, 03 May 2022 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WS2x6vv6JnON45ABgr8Q7FnMIDw6+iA8Ls1Rj6RQoYU=;
        b=LSkejewlqQFT8gb9JKB7TL3S1JFmeYCUHswXIYLiTKvro72gWS+sGYEafs1Kql5tF/
         1hqr+LxKrrenxMGT8Sil4npeW6ReD6OpttSKqI7byNIHGgUcVfQnyedeQIkveMLf9Fwy
         +5+UjIjIEUVA7m6fwsxxca2RF8OqdkyQOpFRwpVoCGoabeFGreuvfLUVUFMWKelPfrkx
         ybqIJcUEwhz+ZUYWzxH3pTPDPiHVy9CM4E19JLQp/dZdOjgRKv1YkOYZy48kKI1DMYiy
         ZCJ/31fGTBeq3euZ74godW7NVoZEFB7AzJo2PF/2YqdbbUkBd6g/cFRlXsM54u+GQ+ip
         4yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WS2x6vv6JnON45ABgr8Q7FnMIDw6+iA8Ls1Rj6RQoYU=;
        b=DLhrq4s2C9u2y6jVrI+zrb2auEa3HRyRMbn6OJE1FFrSlU680Cs8Iza/J/bL1S4qmv
         GEDVoNwV5/0iY/Ew0qroWzQDunOzU6p+jk79LEXJplzIgKSS4u2MYdfhMEVPrrmPHJ1e
         ax02QGW73ZfKj9faIfLLHxpv3ET6yWAGcQXQWm3ZSVi04PPLMhtSwTn+p1HqXaHb1VFo
         99Jjjj6vHtLB3kz7I5xM6ATrp/EVvI8pZqbTGkQeHQGS5HG4VOd/IINNagydXeodcjBJ
         pz3haFQaJlYLJGhvhTDwa4vB32GULv7ihStESrELkA9QjFFttLVtZvQBDwFqZy9FVt+c
         ufkg==
X-Gm-Message-State: AOAM531g9apmGzqTdy9V/OSrj8UGLN9UzhI/ih2W+wNsmnattlq8VnNC
        4IkmY7kW8vYWdU5fDwDfxDI=
X-Google-Smtp-Source: ABdhPJxSulwPskI+0w5Vl/tR1QNiHfne6DWxJBJ/WeaZ+v3SFGPAkFGTyjpNMKKo0L42P4bHOW8A9w==
X-Received: by 2002:a17:906:358a:b0:6f4:2903:417e with SMTP id o10-20020a170906358a00b006f42903417emr14821442ejb.592.1651607798403;
        Tue, 03 May 2022 12:56:38 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id i8-20020aa7c708000000b0042617ba63absm8229270edq.53.2022.05.03.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:56:38 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 5/6] dt-bindings: mailbox: qcom: set correct #clock-cells
Date:   Tue,  3 May 2022 21:56:04 +0200
Message-Id: <20220503195605.4015616-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503195605.4015616-1-robimarko@gmail.com>
References: <20220503195605.4015616-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018 and IPQ8074 require #clock-cells to be set to 1 as their APSS
clock driver provides multiple clock outputs.

So allow setting 1 as #clock-cells and check that its set to 1 for IPQ6018
and IPQ8074, check others for 0 as its currently.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
* Correct subject name
---
 .../mailbox/qcom,apcs-kpss-global.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 3b5ba7ecc19d..1f803925867e 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -50,7 +50,7 @@ properties:
     const: 1
 
   '#clock-cells':
-    const: 0
+    enum: [0, 1]
 
   clock-names:
     minItems: 2
@@ -96,6 +96,22 @@ allOf:
       properties:
         clocks:
           maxItems: 3
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,ipq6018-apcs-apps-global
+            - qcom,ipq8074-apcs-apps-global
+    then:
+      properties:
+        '#clock-cells':
+          const: 1
+
+    else:
+      properties:
+        '#clock-cells':
+          const: 0
+
 examples:
 
   # Example apcs with msm8996
-- 
2.35.1

