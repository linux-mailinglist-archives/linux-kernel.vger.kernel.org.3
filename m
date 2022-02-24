Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954FE4C2F78
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiBXPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiBXPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:21:59 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B191B45C9;
        Thu, 24 Feb 2022 07:21:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bq11so3366512edb.2;
        Thu, 24 Feb 2022 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BenUmI5YlFoZ8y7dkLtbgkF8fzK7mypO7kCBy+ysHLY=;
        b=a4YpovKaGp3D4sf23/UFKiiJ0qYs/2HZoPFoKGprlMkFvbllwVwZU/Ls6kf6bvHJdK
         Yz+wVEUHyJvuCn1JAFuUKQSnXFyjQ6IR3ljO4Dmol9Ki7q6NzdZtxUk6OrZL8saE2y8M
         D50KG1xdcOQ6fwiTDdR5jOP6R3q3N94J0kY1UemWiEUdpK9LMT5CcYxCBt22BkNDO4Bh
         3kEE0oFRZRG/fUDztlObehEiM1NcqxLyDz3WdnRv38QWpDMFllY+0/8oldBYwv8BQOc9
         AFuXxYSGH/EOb0ubVnYsTPL5KXzOJBjRqGVPDR+08Efl+p6H5gofpRyqOT2nt5rt7dt1
         ZRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BenUmI5YlFoZ8y7dkLtbgkF8fzK7mypO7kCBy+ysHLY=;
        b=S/49HK6+krpVA30xuD+iHoo+xC6mQC2aLRRPnjT4nheqmW/MQZEvyL6eDxm61la7JV
         hGQC5B+gh2YaJFn0UFEvFw5RGt8OizK7uCq5RUc9DyL5cfrRy+dmNmAzhjTt4USuPXj9
         hpWE7dBSsydKWgS/aiPCpqhMAC9oTcbSPjgP5qXFXrOcGME+qi+Ak7bnuaScxfgMnUsb
         7gXI1TT/q0nz4lEglkvWHsucN8c2Ias+5JIX9prFEdZm8Xn6YU7SmXXk+ohW2b/AkJny
         Luo1y/jtpfRn1TEXSMlSX8/T+D6+sihDEAOOsjBwOajGIvrxES8DeZbuKD1SPngc+rbS
         lW0Q==
X-Gm-Message-State: AOAM533pOupbpc7I4F2SkORd679MkTHBM04+/4WE3k8mJ60v5iLhQpfE
        g/5NZ71phzCdQaY0Nq96mpQTcqC4RJ4=
X-Google-Smtp-Source: ABdhPJz29+csu8N1YY87hVMgulkAFd7SkgNkyf8NP0JgSciPnhGW9ualgEk/g+UskvOTqJ3GHVbVUQ==
X-Received: by 2002:a05:6402:5ce:b0:412:be81:a9d6 with SMTP id n14-20020a05640205ce00b00412be81a9d6mr2861662edx.272.1645716065288;
        Thu, 24 Feb 2022 07:21:05 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.108.128])
        by smtp.googlemail.com with ESMTPSA id x12sm1501980edv.57.2022.02.24.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:21:04 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC RFT PATCH v3 1/2] dt-bindings: mtd: partitions: Document new partition-dynamic nodes
Date:   Thu, 24 Feb 2022 16:20:42 +0100
Message-Id: <20220224152043.27777-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224152043.27777-1-ansuelsmth@gmail.com>
References: <20220224152043.27777-1-ansuelsmth@gmail.com>
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

Document new partition-dynamic nodes used to provide an OF node for
partition registred at runtime by parsers. This is required for nvmem
system to declare and detect nvmem-cells.

With these special partitions, the reg / offset is not required.
The node name must be in the form of "partition name"-dynamic.
If the partition can't be displayed using the node name, it's possible
to use the label binding that will be used instead of the node name.
The node name or the label binding is used to match the partition
allocated by the parser at runtime and the parser will provide reg
and offset of the mtd.

NVMEM will use the data from the parser and provide the NVMEM cells
declared in the DTS, "connecting" the dynamic partition with a
static declaration of cells in them.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../mtd/partitions/partition-dynamic.yaml     | 56 +++++++++++++++++++
 .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
new file mode 100644
index 000000000000..e0efa58e4fac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dynamic Partition
+
+description: |
+  This binding describes a single flash partition that is dynamically allocated
+  by a dedicated parser that is not a fixed-partition parser.
+
+  A dynamic partition require the node ending with the "-dynamic" tag and if the
+  dynamic partition name can't be displayed using the node name, the label
+  properties can be used. The node name or the label have to match the dynamic
+  partition allocated by the parser.
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
+additionalProperties: true
+
+examples:
+  - |
+    flash {
+      partitions {
+        compatible = "qcom,smem-part";
+
+        art-dynamic {
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
index cf3f8c1e035d..1d7d9b3378c3 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
@@ -19,6 +19,10 @@ properties:
   compatible:
     const: qcom,smem-part
 
+patternProperties:
+  "-dynamic$":
+    $ref: "partition-dynamic.yaml#"
+
 required:
   - compatible
 
-- 
2.34.1

