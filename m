Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DD522126
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbiEJQ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbiEJQ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:28:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9F132A03;
        Tue, 10 May 2022 09:24:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s27so21491950ljd.2;
        Tue, 10 May 2022 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+YkSbV6bjoznxMCuUfht3UUoaizx6Wbg5BycQIS6zs=;
        b=A05ZxnXVAWmmDDGxBx9E47mbX7S0Lb5kx3BXIz0LE4ucreSY1X5yTdw7uft1fPn42/
         aSTUlBrV3mgtTEgdylYx+nll563rrNB3yLv3YfpwcocKTTB2nJlHQuPPZGDOFo9FkApv
         /nt7jSKjA7VUx7/6XV8T/FD/6BPbfx5kbcMXuaFE9qU1KY5ooZyFiGQsQQjAxe8SV26L
         n4CchBQ/O/UQcRId+lmCaDgNha4pS/0skcAe5ggQpZbwwC2dvFNIifmWQZeGdp+Mn/9X
         3IfuPe7QNMlHO9mJiWu7xumyVo9xH3sYL1B7a3UvEOfhiosc9MogVya8LuVtSls1mevH
         u79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+YkSbV6bjoznxMCuUfht3UUoaizx6Wbg5BycQIS6zs=;
        b=Htqzv5IVAxLwP1XzYTQ6YO2Lsz6FFFGZ6B5mDH7uj/4KEoBSh6TLd1ic4zdA67r1aW
         fjeNXvS1y0G4SW8YvUqJZWny+4IKVa2rggdPsA766U8/d7eYUBbb4O/ttdU4tGp8wBgI
         Aic0r1e1yGoy3gOupr0bfMG25iZ5vcLf3nDqR7z4+FofFDcn5S0vbHJ2e8uonGR1fYdR
         6DQibOtNdpb9FtTPFVO/6c4RDFb7m7PVb4MHNnGkWGIVn6d5YIw7xGKm5wZbq89S4h+r
         7v1jPo839tvsf6RCeBcutfDjKubUN8EAHufbuLjxZ5e+oRdrASgznW32enJLTZD93Mv+
         cY6A==
X-Gm-Message-State: AOAM531mrVl8ApK1hwInPPCtECZeZoz+7w8unnyh0vjHEuJJ4v6+pnh/
        v7V6JtNJDo1a8jdK+yPNWw4=
X-Google-Smtp-Source: ABdhPJyJMk2lXCJXghy02HIfIaweFY01KpQ6Pmd5e5ocPKNv1uom8v6aOVxqjQNPks87LU5Q4KIkog==
X-Received: by 2002:a2e:a30a:0:b0:24f:cf6:11ab with SMTP id l10-20020a2ea30a000000b0024f0cf611abmr14027237lje.461.1652199855528;
        Tue, 10 May 2022 09:24:15 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a003:501a:a7ce::887])
        by smtp.googlemail.com with ESMTPSA id r12-20020a19ac4c000000b0047255d2111fsm2338420lfc.78.2022.05.10.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:24:15 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: mtd: partitions: Extend fixed-partitions binding
Date:   Tue, 10 May 2022 16:24:03 +0000
Message-Id: <20220510162403.20861-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510161641.20655-1-csharper2005@gmail.com>
References: <20220510161641.20655-1-csharper2005@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

