Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9652C798
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiERXdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 19:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiERXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:33:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C683C66C96;
        Wed, 18 May 2022 16:33:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r30so4754175wra.13;
        Wed, 18 May 2022 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tPbG+1Qsh5nbAzaiZ8E/pw1mS5ghkz1deStVQwXqkP4=;
        b=VGx115cjLF+9JtQTO0M/Lx7jnhO4p03qIpnSdOE2KVl7vxxeYJVK2X5ZzA7yvUv0ur
         xqm0VeAv67/JQtCQgEDee0y7tlGRr7Ixxe5+ViQutEgQeZeNYXlrYEf5c3xZOUB3Hd/l
         QBA0aas54guBiLOl4xXwaUraYBlfmn1Pt0JF5aBxhiFgFSYlWxfvZBouDoVJ3PcQgI1Y
         Nwcc8L77SG82PVtThUiPjS1tzr/MaaUngdlSdwxyIRItD+x91p5JKRPsXdc8QYCh1Fbw
         Xq2CB6g/gHrgeXPZ56PMsTlLjE5r0l3cyqvW89gMikJ/3qG4kE3Ps2dFZe8YSq3Ys/17
         HZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPbG+1Qsh5nbAzaiZ8E/pw1mS5ghkz1deStVQwXqkP4=;
        b=Vm+YHmCb6Zbx61j2v7WLbgcjli1zZ5jqW0PogIrxMtmbL7bqVenwQWo7q+0E1brE3A
         qyBWLLC0T23WRzdB0Xc//1Bn//tGcPNmvxcaYs7dhQrBlcgcd2brGx+ChLz3nTctwbWC
         n0XHLgdVXd8fPKwCE0yfuy11fD6Z+SA4NL+zW095RVIWsdPXq+eZlzakFTDA700TyHJk
         k4VvA2rp1ZGCiPfPjdEd4+IRv9noKNpj0P10hNquFqhHIvpWBqs/GPJMBHvASEzUtMeP
         52KJRmWTorXyOmQGhAPMXNdYt6SmOSiuGEYbZSC1QD7YJRfdjOivFYIcZbV/IbG2OmDM
         iK7w==
X-Gm-Message-State: AOAM533aug/6apL0PmVP653ZpTLH1KPDJOQEdov+YLnptAI7+g+Pedvi
        SgcmNSV8nJ3L51BLXHnB6y9NpPyPONM=
X-Google-Smtp-Source: ABdhPJzqihmw4n6FOdPzo7A6p0tJo0zukMbN/45Svsp6+TcDeaV6CrpCCK1wVn2iJ59bOG1ZpBaV1g==
X-Received: by 2002:adf:f001:0:b0:20d:22b:183c with SMTP id j1-20020adff001000000b0020d022b183cmr1538233wro.313.1652916792084;
        Wed, 18 May 2022 16:33:12 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id j25-20020adfa799000000b0020d042efd11sm3217476wrc.61.2022.05.18.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:33:11 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: mtd: partitions: Document new dynamic-partition nodes
Date:   Thu, 19 May 2022 01:32:57 +0200
Message-Id: <20220518233258.5483-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518233258.5483-1-ansuelsmth@gmail.com>
References: <20220518233258.5483-1-ansuelsmth@gmail.com>
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

Document new dynamic-partition nodes used to provide an OF node for
partition registred at runtime by parsers. This is required for nvmem
system to declare and detect nvmem-cells.

With these special partitions, the reg / offset is not required.
The label binding is used to match the partition allocated by the
parser at runtime and the parser will provide reg and offset of the mtd.

NVMEM will use the data from the parser and provide the NVMEM cells
declared in the DTS, "connecting" the dynamic partition with a
static declaration of cells in them.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../mtd/partitions/dynamic-partition.yaml     | 57 +++++++++++++++++++
 .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
new file mode 100644
index 000000000000..f57d7b9cae7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partition.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dynamic Partition
+
+description: |
+  This binding describes a single flash partition that is dynamically allocated
+  by a dedicated parser that is not a fixed-partition parser.
+
+  Each child of the parser partition node is then compared and if a match with
+  the provided label is found then the OF node is assigned.
+
+  These special partition definition can be used to give a dynamic partition
+  an OF node to declare NVMEM cells. An example is declaring the partition
+  label and all the NVMEM cells in it. The parser will detect the correct reg
+  and offset and the NVMEM will register the cells in it based on the data
+  extracted by the parser.
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+properties:
+  label:
+    description: The label / name for the partition assigned by the parser at
+      runtime. This is needed for sybsystem like NVMEM to define cells and
+      register with this OF node.
+
+required:
+  - label
+
+additionalProperties: true
+
+examples:
+  - |
+    flash {
+      partitions {
+        compatible = "qcom,smem-part";
+
+        partition-art {
+          compatible = "nvmem-cells";
+          #address-cells = <1>;
+          #size-cells = <1>;
+          label = "0:art";
+
+          macaddr_art_0: macaddr@0 {
+            reg = <0x0 0x6>;
+          };
+
+          macaddr_art_6: macaddr@6 {
+            reg = <0x6 0x6>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
index cf3f8c1e035d..b6fa25949fe2 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -19,6 +19,10 @@ properties:
   compatible:
     const: qcom,smem-part
 
+patternProperties:
+  "^partition-[0-9a-z]+$":
+    $ref: dynamic-partition.yaml#
+
 required:
   - compatible
 
-- 
2.34.1

