Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392A2567790
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiGETNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiGETNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:13:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396C2201AF;
        Tue,  5 Jul 2022 12:13:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r6so5101531edd.7;
        Tue, 05 Jul 2022 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=BJi4dy++yYkYfw9mIOBT/DKU5/ltwPEfKmIyzz3TDhIc20i15feyhZ6tbpigNzYzCK
         csTeXuB1g1LesRvuV9eWFO9AVRtluoBTuZKGA4TVH+tFHjTtNY6z3SWo+6WeddtyGBnw
         7Fw91iPZEx9aK8Yri4iM6RKPiiLt3fUC0XERT+quHJGtSdOJ/6FS2MCNotRJ3sNvO0H6
         9i3AfZpgsJ2a92TdyCQmj8eP8MBcsMmUipfEBlNmDi5eIOjiFJ60TAof6BRHicvwj7KP
         2oulxjvxBot3QJ1/am/mGq3dGbqBqnK484GX+OkNDixWbQTRVNhlEBjqskT40saEwBzW
         PBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=uOYS79lMj7kIDEk7hUqaOw7vmjlIh0YL5tGPFEnMvDGtsYtaWtZJf+SWufdN5bLywG
         G3vyymlrXKmQPvhf/NhewpRqBlBiprA9mdO2Oa/X6Eo+EfSzYJeX5yPx3kY3n896B8K9
         /nXa8NDuZPgB2yAvAvE90U0Ui6qC2SXJ5W6exKhK3og3uDzFoQpdzfYQIGchgjdf/hVG
         vR0LFLvh5zFmfb11PEfZffXa6+1LYuqwASW7L2m8+U+iFKIxDhr4UjOJUCiwz15FtWt2
         YLBxqxCVROVPc9ZdjlrONdF//wWMPeG5o52Op+axJdk6tTF2IOgwPjdBSIoFHMDkwpgI
         C6Lg==
X-Gm-Message-State: AJIora+Esj3OuBgrBd35iuX5VLjZ3zttrazOf74D3AHQu2yBkHZaKFaj
        24yUxfZ4EaXU5VCuuP6e2k7tofPoK8soFg==
X-Google-Smtp-Source: AGRyM1v8rHFh59Aj98gkfcojtUkb7p3z+Paz1dUIu1De2HfL/cqGlTLQisvp3pgFQZGaU+bZbwt7SQ==
X-Received: by 2002:a05:6402:26cb:b0:436:2173:3f7 with SMTP id x11-20020a05640226cb00b00436217303f7mr49255730edd.61.1657048410831;
        Tue, 05 Jul 2022 12:13:30 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-13.xnet.hr. [88.207.99.13])
        by smtp.googlemail.com with ESMTPSA id o19-20020aa7c7d3000000b0043a75f62155sm2480365eds.86.2022.07.05.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:13:30 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: mailbox: qcom: set correct #clock-cells
Date:   Tue,  5 Jul 2022 21:13:26 +0200
Message-Id: <20220705191327.1684277-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705191327.1684277-1-robimarko@gmail.com>
References: <20220705191327.1684277-1-robimarko@gmail.com>
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

