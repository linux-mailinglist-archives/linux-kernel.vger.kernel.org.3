Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEAA51486F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358675AbiD2LrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358638AbiD2Lq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:46:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F2B36B8;
        Fri, 29 Apr 2022 04:43:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e24so10413453wrc.9;
        Fri, 29 Apr 2022 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWKXfiKxqjbcYlfe3kWZvieFF6W0RPqcnKcoAS9f6lc=;
        b=He+Cwlecz1hDBm2IJYt+u0ldkrGLbPIsCcCq6mBPrZGJyMKH1NVkYWUr4WX1ibdXXm
         vQBiuz26ZFKKmcsrnbH+4N3937pwiS7MAgOVq9+VjP03otC84nk2oQFPDpUFfULuYcib
         aSG+5YLEKhTPuY2RHeFMDWPUQSPn37qJmnffO4tYbOyCOA72krUNND4Dtz+1PYaxSE3x
         +Tj3YnJM8ehF7N8WfKNyxZa2DIksUKai58wSgA+ZKMh4zQ0wF1YwGFqvH6pyXA66Cfhp
         tTeHMAw2g1DEcZRaMP5JAPD5X1Fe67/bev3AhaulR0pem+oHnlDnT68F3uGd83eKzNeP
         hLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWKXfiKxqjbcYlfe3kWZvieFF6W0RPqcnKcoAS9f6lc=;
        b=R5mAdPyVRiMWQFCPeXCB/VBkpLJ6o47/eCkempvtFklzwnNGon/VU91CHEuRPYIZJ2
         BeX/DyzeKczkceH98tqM/AMnYQxUdikkWRG3RlB5D7Hh6vU/3rOf0YiKyqXU2Psf2g/B
         WCtd2Omgfytl9CIVjYg6DuV3ckC/l+RrPBJDBXNoGRysdFff5ikCywtStbAeEFesbkhn
         377cA9GFkCHf7Ui+gSdoIecqMLOT32VLWUnmyQDsD/LV9YgEaa3w7CsyI7fweHzMvbeE
         WEb0poT9MDbxiYqvw6OzHtjhibFIDecW+Gjb/F6OFJV+Jw927QVJsAuJjgDS4//UwsgH
         r7yg==
X-Gm-Message-State: AOAM5304JWYWuOLC+fKQIUR/H5jrSoFFvcl2xqy9o+NSJZy766lFmV+S
        UygNZRfDIzb14x4le71d9Nc=
X-Google-Smtp-Source: ABdhPJwlui24U3T83X+XjnY/lJ8e1qD5Ggmuafe91jzYtl9OMwc9D8pBqxPBhn81IJ8nQQbK49vR2g==
X-Received: by 2002:adf:f64b:0:b0:20a:c685:89ee with SMTP id x11-20020adff64b000000b0020ac68589eemr28342607wrp.366.1651232619363;
        Fri, 29 Apr 2022 04:43:39 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-183.xnet.hr. [88.207.99.183])
        by smtp.googlemail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm2990900wml.5.2022.04.29.04.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:43:39 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 5/6] dt-bindings: mailbox: set correct #clock-cells
Date:   Fri, 29 Apr 2022 13:43:29 +0200
Message-Id: <20220429114330.59026-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429114330.59026-1-robimarko@gmail.com>
References: <20220429114330.59026-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

