Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D51527A12
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiEOUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbiEOUpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:45:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF3237F7;
        Sun, 15 May 2022 13:45:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba17so15978626edb.5;
        Sun, 15 May 2022 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=MSt+yA9UObHIij1xVVg4RTUH2jMag/OwB28Wu8QfsAQNaTK5nf1ksC/oYINGPWVSqV
         mfi6QMLICcODgE3o6MD4Tb/eJcUwC4eoP/dbUIiJzBAin1m9tD+0zUFHHKNRnKp1BrG0
         JCJkXDvKaOMuhCCtjDS3h/p/v9SvjfdADcoTv757ggs3OUtzlsyG9gV/SC+WYWeCjWYv
         2CPi4zA6PCyNNAoMI5Ok++98pHxe69ywYrkFiVW6J3F3d0sKTlKNTeJib1ZyEvICd4zY
         mB5W+3V02/NNgqxBZ47FeKMBx0LMFuRIOFn130aCdx5J6pVkK0JJXuKcO+hJy+vj5zXT
         sv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=jOAZ2GMKwn4sgxtDF7OsYwi002lZwQSjXztXss34tZuPUvobjS1BHsSZYDrUQGdDaX
         IPrmFjViCa6YhOrEdm9fPG/f+hGnkRwfAvc+KHqp+TYAG867TL+I7dSzWPzMnEMc4mYq
         nmT1uf2IoIDZdqUsB/xSIASktuInS0X5eClrKBg5/31AlAkrLRpHYCCUMHzM21Tag79f
         bO863zF1Yque1qf0v225ubjXp4C/sx0ozeNIw/3hyh0raNwxTeFngvFDz3I51JHvWZtm
         Fdy7BHwKiwbgjwMIjY9M9zpVj9wWl1VyzUzM+OAharVEZqKbETPDDA4lVFBcvF0DPSuU
         GqNQ==
X-Gm-Message-State: AOAM532Tx6ODwdDrKsnlbdVcwirJXy6taSROKE/u2oXL6aqEjFALqihW
        x2QMWByGOttukIMc68CtGDY=
X-Google-Smtp-Source: ABdhPJyOhpjy4y4MN973lMI8n7XZxjzdpJA17yIuMf1aZuyrIVc8kWO1k5snlIzepWrct8pGphQsOg==
X-Received: by 2002:a05:6402:1910:b0:428:1817:6f2f with SMTP id e16-20020a056402191000b0042818176f2fmr9839144edz.354.1652647549502;
        Sun, 15 May 2022 13:45:49 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id i10-20020a50870a000000b0042617ba63cdsm4174156edb.87.2022.05.15.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:45:49 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/6] dt-bindings: mailbox: qcom: set correct #clock-cells
Date:   Sun, 15 May 2022 22:45:39 +0200
Message-Id: <20220515204540.477711-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515204540.477711-1-robimarko@gmail.com>
References: <20220515204540.477711-1-robimarko@gmail.com>
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
Changes in v3:
* Drop not needed blank line

Changes in v2:
* Correct subject name
---
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 3b5ba7ecc19d..95ecb84e3278 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -50,7 +50,7 @@ properties:
     const: 1
 
   '#clock-cells':
-    const: 0
+    enum: [0, 1]
 
   clock-names:
     minItems: 2
@@ -96,6 +96,21 @@ allOf:
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
+    else:
+      properties:
+        '#clock-cells':
+          const: 0
+
 examples:
 
   # Example apcs with msm8996
-- 
2.36.1

