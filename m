Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555E64F6C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiDFVQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiDFVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:15:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28EE19B06D;
        Wed,  6 Apr 2022 12:59:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so6066711lfb.0;
        Wed, 06 Apr 2022 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UsV1ITimuhURq05XOE0qRsHZpUCDSsJJ67E/Znzm550=;
        b=ldznlsYntX697YHfppKvxltReRjb4PF626sqTcBzNAv2c3S+3/FUwRaU6EAZT/k6th
         Fu3pQ/khq3bN/fPm4/3V3Q2emn1AFsvSvrJ/kjHs8sfbo+HbHIq7/aM8iLvYCQ0S3PXm
         fA8FmfSCMT48DbnVYIfPfKtR1TSxartPcZrxnUTUdMh54EN9B1uPY0xm93jympGQZjaB
         4/CPIJ2lcWXMy3QFlp3Rw2MtkqR1xKdB8FRlwfR1rmgk3xh26pcjNNH2Uu54y+FUKIkv
         UjXspNdE8G7Yan4NF0zeLJaW182lbhJrqDdjFDU2K4z7co74R/rXYmfLkbKtCif9I3fv
         tbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UsV1ITimuhURq05XOE0qRsHZpUCDSsJJ67E/Znzm550=;
        b=D+xwQkQ3ffUOxAVTL9TZLyQK6w1zSMVqnay3SmqIvfwBrFoc/TpRWlse2vwGJbazFi
         n9tHmeiSNwtpsbveB+PZ+ifExsZ3xoyUg1JoZoI/c3wI3m9spN2MSQYJjBQu64dNUF+J
         AQyne2yoyqRNIOKmEC8uElHUgN+yFbGquaoDuTBG42/ddC23lSKTMwA5srHOcaue+ls1
         V34bMH4wtJO/yDQrbloDgmIthX1EVc7fpwwWvy9IOgMamrXcu73yeBHgeeb+hWWHsr7h
         OyLqp7kIO/OUVQcjwz3szIh4TQxJ4cMOoQdJ3bhjQN8r5t2mFCoIbo/Vf2w7n/lLZJUD
         YbYQ==
X-Gm-Message-State: AOAM530cQM3cy0EqZrzux2teZcelJDMlYTd36c1b34Am68o++oPb8J0n
        kjCdERL2DYGylB1L6pTA8aQ=
X-Google-Smtp-Source: ABdhPJyvqgx4F/WKNa5aYwdfb36cRFg+7qpkiAIyoClFgG90ziZXADFI6QbV/PFH3Ao9GtmEc90L8w==
X-Received: by 2002:a05:6512:c03:b0:447:7912:7e6b with SMTP id z3-20020a0565120c0300b0044779127e6bmr7163436lfu.508.1649275190202;
        Wed, 06 Apr 2022 12:59:50 -0700 (PDT)
Received: from vmu1804.lan ([2a09:bac0:87::815:6e3d])
        by smtp.googlemail.com with ESMTPSA id q4-20020a2eb4a4000000b0024985ed51cdsm1772295ljm.114.2022.04.06.12.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:59:49 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: mtd: partitions: Add binding for Sercomm parser
Date:   Wed,  6 Apr 2022 19:59:46 +0000
Message-Id: <20220406195946.2019-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406195557.1956-1-csharper2005@gmail.com>
References: <20220406195557.1956-1-csharper2005@gmail.com>
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

Add YAML binding for Sercomm partition parser.

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 .../mtd/partitions/sercomm,sc-partitions.yaml | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
new file mode 100644
index 000000000000..07ea5596200c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/sercomm,sc-partitions.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/sercomm,sc-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sercomm Partitions
+
+description: |
+  Sercomm is one of hardware manufacturers providing SoCs used in home routers.
+  The Sercomm partition map table contains information about non-standard
+  partition offsets and sizes (depending on the bad blocks presence and their
+  locations). Partition map is used by many Sercomm-based Ralink devices
+  (e.g. Beeline, Netgear).
+
+maintainers:
+  - Mikhail Zhilkin <csharper2005@gmail.com>
+
+properties:
+  compatible:
+    const: sercomm,sc-partitions
+
+  scpart-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Partition id in Sercomm partition map
+
+required:
+  - compatible
+  - scpart-id
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions
+        compatible = "sercomm,sc-partitions", "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            label = "u-boot";
+            reg = <0x0 0x100000>;
+            scpart-id = <0>;
+            read-only;
+        };
+
+        partition@100000 {
+            label = "dynamic partition map";
+            reg = <0x100000 0x100000>;
+            scpart-id = <1>;
+        };
+
+        factory: partition@200000 {
+            label = "Factory";
+            reg = <0x200000 0x100000>;
+            scpart-id = <2>;
+            read-only;
+
+            compatible = "nvmem-cells";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            macaddr_factory_21000: macaddr@21000 {
+                reg = <0x21000 0x6>;
+            };
+        };
+
+        /* ... */
+
+    };
-- 
2.25.1

