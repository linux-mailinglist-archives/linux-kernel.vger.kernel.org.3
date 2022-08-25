Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E055A184C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiHYSFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiHYSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:05:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E2174CCB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:05:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso3152942wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5kPI6Qs1t3E/Vre1WWWz4/JhFarqPVXyanwUw3KaQHk=;
        b=NZc4I9raPbnA1Ar1KT9PpzcSORFhiRGZW00QQnnsNCfX+UA9fN8e25WfeTa2gIAszy
         yYh6YEmHrE28o56XN6T99ABnc3BSAk5dlqkn1tzopVXhxfMTXfKofWOXMAQCiTb7O7SB
         35NF/0DLWKOipmiXt0UsyVRYkwVNQlnuhpy7pRyPXLPav0JxXZWXFz7RmFsyUb6OG3TK
         Smx+eSOJbGKcGQzEF4fROCh0FJY5p6s8lkAmTP4fNau84OQYtDXNbJkgZj93UpEho0b2
         Pagl00f0USQNmgRJZ3+CmaSU9OuSNPuvnzgkr4Gb6gjo9089EdKp2dB1zBLn5rUwHnyi
         vCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5kPI6Qs1t3E/Vre1WWWz4/JhFarqPVXyanwUw3KaQHk=;
        b=0RCIb8ZCCDRncreohgJBa/8PdJHukoGKG/dcQYbA5CI26UQx4T8ddxhQqhb6wRVOUI
         03bdEomM1uiHs2WkYZ+c3ydC8Cp7D91lDvPcpQMkOOXVXoAKEqZ5TJcPd6xBs5+C93N1
         4JLnsV794Y8moFziWu/wHZB3BhuTcsDa5LVhdl9BC+zE2ZvOInlRnOKvpdVnIKYQcEUP
         7ygIU5o86mS6J799oLBb0XYB1VtfStybc8bhLKO9a0b2RyZMh6XZCOGF+x5++eLrp7bE
         wDvLlRx1BAyXMFjCUpMbTGSyNthFI9hchn4s3CBWMhpba4gXkfOSMxwqkE26MCC9/1Gd
         qxig==
X-Gm-Message-State: ACgBeo1394T+80OI9lKsxbb5WwVD52SpPqrwrN7RhuwHKC431ZPvXKqQ
        LbeYlh/kr43hkTVFjWZnw+O9vA==
X-Google-Smtp-Source: AA6agR4YnT0SvuQmkQdKdz4yxQ9gsM05hvgrTnIF0ZSrNkirKKaE92hf/lz+3Y5yEEfdR7RcHv+3mQ==
X-Received: by 2002:a05:600c:34d3:b0:3a5:fea5:1be8 with SMTP id d19-20020a05600c34d300b003a5fea51be8mr8888820wmq.106.1661450726491;
        Thu, 25 Aug 2022 11:05:26 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6044000000b002254a7f4b9csm14967970wrt.48.2022.08.25.11.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:05:26 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Sagar Kadam <sagar.kadam@sifive.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC compatible
Date:   Thu, 25 Aug 2022 19:04:17 +0100
Message-Id: <20220825180417.1259360-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220825180417.1259360-1-mail@conchuod.ie>
References: <20220825180417.1259360-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

The l2 cache on PolarFire SoC is cross between that of the fu540 and
the fu740. It has the extra interrupt from the fu740 but the lower
number of cache-sets. Add a specific compatible to avoid the likes
of:

mpfs-polarberry.dtb: cache-controller@2010000: interrupts: [[1], [3], [4], [2]] is too long

Fixes: 34fc9cc3aebe ("riscv: dts: microchip: correct L2 cache interrupts")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/riscv/sifive-l2-cache.yaml       | 79 ++++++++++++-------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index 69cdab18d629..ca3b9be58058 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -17,9 +17,6 @@ description:
   acts as directory-based coherency manager.
   All the properties in ePAPR/DeviceTree specification applies for this platform.
 
-allOf:
-  - $ref: /schemas/cache-controller.yaml#
-
 select:
   properties:
     compatible:
@@ -33,11 +30,16 @@ select:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sifive,fu540-c000-ccache
-          - sifive,fu740-c000-ccache
-      - const: cache
+    oneOf:
+      - items:
+          - enum:
+              - sifive,fu540-c000-ccache
+              - sifive,fu740-c000-ccache
+          - const: cache
+      - items:
+          - const: microchip,mpfs-ccache
+          - const: sifive,fu540-c000-ccache
+          - const: cache
 
   cache-block-size:
     const: 64
@@ -72,29 +74,46 @@ properties:
       The reference to the reserved-memory for the L2 Loosely Integrated Memory region.
       The reserved memory node should be defined as per the bindings in reserved-memory.txt.
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: sifive,fu540-c000-ccache
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
 
-then:
-  properties:
-    interrupts:
-      description: |
-        Must contain entries for DirError, DataError and DataFail signals.
-      maxItems: 3
-    cache-sets:
-      const: 1024
-
-else:
-  properties:
-    interrupts:
-      description: |
-        Must contain entries for DirError, DataError, DataFail, DirFail signals.
-      minItems: 4
-    cache-sets:
-      const: 2048
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - sifive,fu740-c000-ccache
+              - microchip,mpfs-ccache
+
+    then:
+      properties:
+        interrupts:
+          description: |
+            Must contain entries for DirError, DataError, DataFail, DirFail signals.
+          minItems: 4
+
+    else:
+      properties:
+        interrupts:
+          description: |
+            Must contain entries for DirError, DataError and DataFail signals.
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sifive,fu740-c000-ccache
+
+    then:
+      properties:
+        cache-sets:
+          const: 2048
+
+    else:
+      properties:
+        cache-sets:
+          const: 1024
 
 additionalProperties: false
 
-- 
2.37.1

