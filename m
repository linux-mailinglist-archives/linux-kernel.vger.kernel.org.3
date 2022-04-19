Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E5507058
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiDSO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353461AbiDSO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0575A1A6;
        Tue, 19 Apr 2022 07:25:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q12so24004693pgj.13;
        Tue, 19 Apr 2022 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7BT9llr4g/+oDP3xKYg2jTAN9BitQ9N2nDaLRe4C9L8=;
        b=l0s1/fgYGGMkUDpubImf9KtVthkStloJXQpzF5HwjXY0rva98rf3OF/6VXv2HkPsFj
         ian/TOBXVkkRpEj9mMMF+2fg8nNIv+7b56pwHHT4tUmRt8x/YEoUpE532f5cHjtMCbfv
         Dp04EsHqbHRH7DeDK8cqeGGGT0tzIohpjEmtjspkXjPrSu1lCxtXRctAy1YYSGTS0dj+
         4zTYOhrUqexuJ65J4cJiIamY1lEmhAhyALrXc+tmDLjze5OBgkhOBnTDUnLobSJVGEDd
         5Lo07ewYnKjHw5aJgIIhWXuCggGuL7QPGDEHw7lCSZ1Uzw0Ksste3HgQATHFHaGMrbtX
         Il0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7BT9llr4g/+oDP3xKYg2jTAN9BitQ9N2nDaLRe4C9L8=;
        b=OvgZyKPnPsvSzWfR7wuzhUTzIhHoaieLgcRkufQcmYMflUxN4SXEKQI+OPpMlooCU0
         dIKOW29tfxsPg2tMZ8GvupKtRRJ3Hqwx0YMNhfWX4F/Da7+h4LThaIwBuhyDXbdFUIOG
         FhLO6twvD8e4pCiUYI/qiW3i5KIhyX3CUgTrlY5Ulk2iI12G3dt95W/wmQqXir9FWgVI
         I/rO21Paa9HGYH2i68+GxHF7xpjZbiK15hJFQPD9soPMmCa/ZJzY6HixSPX5oyn9JP0u
         b4nbvZDP++ZBEzRkWHxlb3RpvSPrP5w1JEqZ7kphYXsJtuz52QQCFwJXHUnwh6fX4F5N
         0kkA==
X-Gm-Message-State: AOAM531f+C/CDjs6HMQ2MfavwyrTQSo8tzGIJjwfge02IGhYzb5Xih8f
        UVB+2ebTRz2GmHYIgL+jl9g=
X-Google-Smtp-Source: ABdhPJydiHl3BqNtdyLwusS44ht++WhRYH+DcOAaqrNiELtQN5avq7CPRxgWc4m7Y+0K8ytnIDf/Rw==
X-Received: by 2002:a63:4a48:0:b0:3a9:21ea:458d with SMTP id j8-20020a634a48000000b003a921ea458dmr11226733pgl.557.1650378319230;
        Tue, 19 Apr 2022 07:25:19 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:18 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
Date:   Tue, 19 Apr 2022 22:24:52 +0800
Message-Id: <20220419142458.884933-2-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419142458.884933-1-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
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

From: Cixi Geng <cixi.geng1@unisoc.com>

sprd,ump9620-adc is one variant of sc27xx series, add ump9620
description and sample in dt-bindings.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 59 +++++++++++++++++--
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
index caa3ee0b4b8c..c9fe45c1c0d8 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
@@ -20,6 +20,7 @@ properties:
       - sprd,sc2723-adc
       - sprd,sc2730-adc
       - sprd,sc2731-adc
+      - sprd,ump9620-adc
 
   reg:
     maxItems: 1
@@ -33,13 +34,38 @@ properties:
   hwlocks:
     maxItems: 1
 
-  nvmem-cells:
-    maxItems: 2
+  nvmem-cells: true
 
-  nvmem-cell-names:
-    items:
-      - const: big_scale_calib
-      - const: small_scale_calib
+  nvmem-cell-names: true
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - sprd,ump9620-adc
+then:
+  properties:
+    nvmem-cells:
+      maxItems: 2
+    nvmem-cell-names:
+      items:
+        - const: big_scale_calib
+        - const: small_scale_calib
+
+else:
+  properties:
+    nvmem-cells:
+      maxItems: 6
+    nvmem-cell-names:
+      items:
+        - const: big_scale_calib1
+        - const: big_scale_calib2
+        - const: small_scale_calib1
+        - const: small_scale_calib2
+        - const: vbat_det_cal1
+        - const: vbat_det_cal2
 
 required:
   - compatible
@@ -69,4 +95,25 @@ examples:
             nvmem-cell-names = "big_scale_calib", "small_scale_calib";
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@504 {
+            compatible = "sprd,ump9620-adc";
+            reg = <0x504>;
+            interrupt-parent = <&ump9620_pmic>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+            #io-channel-cells = <1>;
+            hwlocks = <&hwlock 4>;
+            nvmem-cells = <&adc_bcal1>, <&adc_bcal2>,
+                          <&adc_scal1>, <&adc_scal2>,
+                          <&vbat_det_cal1>, <&vbat_det_cal2>;
+            nvmem-cell-names = "big_scale_calib1", "big_scale_calib2",
+                               "small_scale_calib1", "small_scale_calib2",
+                               "vbat_det_cal1", "vbat_det_cal2";
+        };
+    };
 ...
-- 
2.25.1

