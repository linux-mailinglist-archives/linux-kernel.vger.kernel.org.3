Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617DB52387B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbiEKQRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbiEKQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:17:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736A925C47;
        Wed, 11 May 2022 09:16:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w17-20020a17090a529100b001db302efed6so2501409pjh.4;
        Wed, 11 May 2022 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SPLvtmhvHirwBvqBEM1pVuSorHBVH9nPBsiOTaHpJtA=;
        b=ofOufYRyJzQL1sfWftDyKN4lKQC7Pgfy7JCtH2/uFAcWUYoLEnLAgOz4UIaooMXCDL
         aRbG49RAV3CGl7DkeGYK9o4FDMWyeVByvqPSDCgSvT0OQ5HEKWLXG+a9EmNHuhg+m2h/
         WXiV9jV1e9m8Mk1QR3vBJbWzs71BvzGD4yf7U7HDl0HOv5i5pI62CViMdwpIav3610ib
         AB+tPICLd1E+DYCV3Jo5hOsYtIGTKaCMbWj+E2xJEF1TIqkLbo8b3qI1mAw5IfxdeyPZ
         5KDd3PrjyRto7+5oxf1gdGy1Bxn2GQuO7cYtKeA67cM482mV5nMcPnVi9oYs0PVCAayN
         MORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPLvtmhvHirwBvqBEM1pVuSorHBVH9nPBsiOTaHpJtA=;
        b=YjdkQUP+eeSSardLmAfL2xtZY7QcBGQGpSnLBbQl5hWZUmV1UlbrRZUepQB7BLLu02
         bLnBORDO2oLgg1qfMVPCTd40RofHgrCqpn9NnFgyUp+hrA9VXy69/CHEYqjH90Di4EnS
         hyRGNAYxRAgL4Jp3LO+mHLyk80KNsJ+XqUgtb9duCUpT4DcBxjo6chCP0N1pQGFRycRC
         YZ+mQtBVjAK5ti4EOgVjD6xN2NmBi1ALYP3mJEwlVbNUZpIk5xmyODdAL3I5PKrla7BP
         symr/saTbrdFae2VIhA3DsnT0Kg4of+oMSJHXcsQUxLAuocrXtCzb4O45nSYw8oex+H1
         TpFw==
X-Gm-Message-State: AOAM531Nfrg7kBa0lmbjp3bC1QQWOAekYqfjDgx9wFRHYAvUt87OjYAs
        /v73F2rupZDQwlu8MVoaJ6ojo7yTqMKAHkZW
X-Google-Smtp-Source: ABdhPJxiChAMt1swA4rsquaHUq/gjfOgg5a93WouXfJXio5ff56QRvZt6L403573NoqFZlFUENUmAw==
X-Received: by 2002:a17:90a:bb0e:b0:1dc:a406:3566 with SMTP id u14-20020a17090abb0e00b001dca4063566mr6172551pjr.135.1652285812736;
        Wed, 11 May 2022 09:16:52 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:52 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 7/9] dt-bindings: remoteproc: qcom: mss: Add MSS on MSM8953
Date:   Wed, 11 May 2022 21:46:00 +0530
Message-Id: <20220511161602.117772-8-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for MSS on the MSM8953 platform, which is used by
SDM450, SDM625, SDM626, APQ8053 and SDM632.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,q6v5.yaml        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml
index 1c67c6cbf417..4882553df8b9 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.yaml
@@ -31,6 +31,7 @@ properties:
               - qcom,qcs404-wcss-pil
               - qcom,msm8916-mss-pil
               - qcom,msm8974-mss-pil
+              - qcom,msm8953-mss-pil
               - qcom,msm8996-mss-pil
               - qcom,msm8998-mss-pil
               - qcom,sc7180-mss-pil
@@ -263,6 +264,27 @@ allOf:
             - const: mem
             - const: xo
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8953-mss-pil
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Interface clock
+            - description: Bus clock
+            - description: Memory clock
+            - description: XO clock
+        clock-names:
+          items:
+            - const: iface
+            - const: bus
+            - const: mem
+            - const: xo
+
   - if:
       properties:
         compatible:
@@ -410,6 +432,7 @@ allOf:
               - qcom,qcs404-wcss-pil
               - qcom,msm8916-mss-pil
               - qcom,msm8974-mss-pil
+              - qcom,msm8953-mss-pil
     then:
       properties:
         interrupts-extended:
@@ -479,6 +502,7 @@ allOf:
           enum:
             - qcom,msm8916-mss-pil
             - qcom,msm8974-mss-pil
+            - qcom,msm8953-mss-pil
             - qcom,msm8996-mss-pil
             - qcom,msm8998-mss-pil
     then:
@@ -573,6 +597,7 @@ allOf:
               - qcom,q6v5-pil
               - qcom,msm8916-mss-pil
               - qcom,msm8974-mss-pil
+              - qcom,msm8953-mss-pil
               - qcom,msm8996-mss-pil
               - qcom,msm8998-mss-pil
     then:
-- 
2.36.0

