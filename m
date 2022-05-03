Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D44518916
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiECPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiECPxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:53:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170DA6317;
        Tue,  3 May 2022 08:50:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e2so23956207wrh.7;
        Tue, 03 May 2022 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kp0I+fDrNRZ+kcOulyBqIwYKgrX5Pypr91NpoQc/0zE=;
        b=ZFBOAaAsyVFB3azHklpMGisviv1wFqvgeuS+yXrkzNpI26aW8Rx4DIz/LT7mfLZjPt
         bdSXl4i53f+OSdYghJLapyYcckMhm1aIWxAOhQJWj9MXjGBcX1mpRpKOV1Vn8qMxL+uT
         rbpSVr+q9XpCTyISVuUqjbeBbgQyt4Mb7cVIlawXk/UCnggkV8Hm2nphDs5FQJAzITBY
         oVOiFW48hIk39EbzTqNOrPIxn6DY1w8fyciLm7M60NL5RxX91a2ZBhLOcd/UO2Ps2NYy
         AG5Z1NBvTY2N+gZkwta6wGhtU8KQYzrSLNGfezKuY0g5WSEwdseZf75KgGLAxa/faj0V
         O4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kp0I+fDrNRZ+kcOulyBqIwYKgrX5Pypr91NpoQc/0zE=;
        b=8Q9Z5I5gd7jHBo1oJbt5X1k48MziwjLBRU+hrXKBqAdSWCV8YcewlSTmH7onHf26mn
         OvaG2LTjCo0PwSRU+2hdvXOwt7JMs0d/U3JmRRlfbk/8fjxTi6qUhmzDF7LJbcf1nUZq
         M1I2t4o0V5XTsGVDsHaACQYwRB4VYQVqqovGXv+yNdLI1yVr2SNJEsuIgxqWzefnOyc0
         vW0v1AFlVIRp1ZPKQYitItn+TgDYETyVl39z4OLCSfQ46frzZ6+uDON+OhxfxSqwEA+U
         CifXTf53NFrCz7PyZsUVhFZAwnqut7nnUzANPO8A/jbuuDy92kQ4oCrwHwprbkyZMqB+
         1WBw==
X-Gm-Message-State: AOAM530v7mGyVtHQAPUeBiJpGpLpHGU6VKSLelvNC1ZYo6DssSpExl3Z
        LoprFRJBLzJZ39V1P/uFs3Y=
X-Google-Smtp-Source: ABdhPJwW896RxEFOdbJcnn2DEmhLXrdedi9FVjmGiZViAFZp1PCH+C2fCuq498nQlWo9yP0OdCiwUA==
X-Received: by 2002:a5d:690c:0:b0:20a:d9d1:f5ce with SMTP id t12-20020a5d690c000000b0020ad9d1f5cemr13436892wru.295.1651593015655;
        Tue, 03 May 2022 08:50:15 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a004:d009:c8fa:102c:912a:a6e3:41ea])
        by smtp.googlemail.com with ESMTPSA id p26-20020adfa21a000000b0020c5253d8ecsm9523482wra.56.2022.05.03.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:50:15 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: mtd: partitions: Extend fixed-partitions binding
Date:   Tue,  3 May 2022 15:50:07 +0000
Message-Id: <20220503155007.2339847-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503154254.2339744-1-csharper2005@gmail.com>
References: <20220503154254.2339744-1-csharper2005@gmail.com>
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

Extend fixed-partitions binding for support of Sercomm partition parser
(add "sercomm,sc-partitions" compatible).

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 .../mtd/partitions/fixed-partitions.yaml      | 55 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ea4cace6a955..ad3ccd250802 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -19,7 +19,11 @@ maintainers:
 
 properties:
   compatible:
-    const: fixed-partitions
+    oneOf:
+      - const: fixed-partitions
+      - items:
+          - const: sercomm,sc-partitions
+          - const: fixed-partitions
 
   "#address-cells": true
 
@@ -27,7 +31,24 @@ properties:
 
 patternProperties:
   "@[0-9a-f]+$":
-    $ref: "partition.yaml#"
+    allOf:
+      - $ref: "partition.yaml#"
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: sercomm,sc-partitions
+        then:
+          properties:
+            sercomm,scpart-id:
+              description: Partition id in Sercomm partition map. Mtd
+                parser uses this id to find a record in the partition map
+                containing offset and size of the current partition. The
+                values from partition map overrides partition offset and
+                size defined in reg property of the dts. Frequently these
+                values are the same, but may differ if device has bad
+                eraseblocks on a flash.
+              $ref: /schemas/types.yaml#/definitions/uint32
 
 required:
   - "#address-cells"
@@ -52,6 +73,7 @@ examples:
             reg = <0x0100000 0x200000>;
         };
     };
+
   - |
     partitions {
         compatible = "fixed-partitions";
@@ -64,6 +86,7 @@ examples:
             reg = <0x00000000 0x1 0x00000000>;
         };
     };
+
   - |
     partitions {
         compatible = "fixed-partitions";
@@ -82,6 +105,7 @@ examples:
             reg = <0x2 0x00000000 0x1 0x00000000>;
         };
     };
+
   - |
     partitions {
         compatible = "fixed-partitions";
@@ -119,3 +143,30 @@ examples:
             };
         };
     };
+
+  - |
+    partitions {
+        compatible = "sercomm,sc-partitions", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "u-boot";
+            reg = <0x0 0x100000>;
+            sercomm,scpart-id = <0>;
+            read-only;
+        };
+
+        partition@100000 {
+            label = "dynamic partition map";
+            reg = <0x100000 0x100000>;
+            sercomm,scpart-id = <1>;
+        };
+
+        partition@200000 {
+            label = "Factory";
+            reg = <0x200000 0x100000>;
+            sercomm,scpart-id = <2>;
+            read-only;
+        };
+    };
-- 
2.25.1

