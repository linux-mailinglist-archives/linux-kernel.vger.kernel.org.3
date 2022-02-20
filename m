Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567DE4BD070
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244442AbiBTRkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:40:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiBTRkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:40:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68684A92C;
        Sun, 20 Feb 2022 09:39:41 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so27296705eje.10;
        Sun, 20 Feb 2022 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0XdH+UuoTmIJpoL0GQGXlMfGXdvLAhnJy2/X6+fBU+E=;
        b=I07Ksbcl8KQ5uFjT4EV/NYk5JjRe6BhMypo4Y9zOFfZxj/WZ+eFLJzUTO+RdNclElJ
         z792NtSF3RMaJPITTBXx4scOOj3/oaD/fUwwOiU7ovbrp3zAm+/av+IxmxSXHBrYqFTG
         aq0aHI0lg6+E/+La87DONZzagS9sKMTF12snPBFlDEuB0bjwUDnNM81ZUvjtUx3AEzOi
         xVQ2z3UOkNX/NNPKOyTocVfEuqTSF1i3B56LarHnjBxzsEpf0xM6/HYUwq791e1c6wWv
         rjzNLaxJi9iUZ17mvsqpMDQemxbALVhawzH3K7srpsoZBACrSf81IvJxJo2lmK5SU0Ry
         Y/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XdH+UuoTmIJpoL0GQGXlMfGXdvLAhnJy2/X6+fBU+E=;
        b=Lh2/KgZB6NrI3gm6Q17B2crHs6T5kuZrMX5TEyKCocH9dt2bJ9CUN/bIQ+T9sqCnnP
         LONuAB48FdgIuuWrzJ0LNupzzY53K9u9AroIIVE1vqhuz3Uk979ZJ/KH637zIwO+87UU
         7/2d7P0V0oWemgUiCp0FJkVR3H0KLHDhxa5FTK5YRy4JZJaGEbPh/oCkN156U2MlxsSX
         CAhFYM8JKCEptxSNQBW0WxAgSxiAikp4nnafR0w3UhdpH31SfPhtjaslnT6kqF0Xo02q
         Px+ag0zIcH4ZHl7wOQ5s8BH2gnfICrIIVU20duS2sAQAVIfAjEAhxREZ4Rvkl6CHKm8y
         90EA==
X-Gm-Message-State: AOAM53219HagD9UH6qzmhzDKCulVeMIHvvasJd8jKAViLx3FUZDUWHnn
        s446ikwgJdtfIJkfyMFIvWk=
X-Google-Smtp-Source: ABdhPJya5ibmpCyFDayy/wBqecm2M9yZe1IhqwI6AEh4pXXMSO5Al2QNHYNJr88scIIdJkvdtWMfDQ==
X-Received: by 2002:a17:906:3905:b0:6cf:7ef5:fee0 with SMTP id f5-20020a170906390500b006cf7ef5fee0mr12949599eje.307.1645378780088;
        Sun, 20 Feb 2022 09:39:40 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id i5sm4416721ejo.188.2022.02.20.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:39:39 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC RFT PATCH v2 1/2] dt-bindings: mtd: partitions: Document new partition-dynamic nodes
Date:   Sun, 20 Feb 2022 18:39:04 +0100
Message-Id: <20220220173905.14165-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220173905.14165-1-ansuelsmth@gmail.com>
References: <20220220173905.14165-1-ansuelsmth@gmail.com>
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

With these special partitions, only the label is required as the parser
will provide reg and offset of the mtd. NVMEM will use the data from the
parser and provide the NVMEM cells declared in the DTS, "connecting" the
dynamic partition with a static declaration of cells in them.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../mtd/partitions/partition-dynamic.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
new file mode 100644
index 000000000000..945128e754ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
@@ -0,0 +1,54 @@
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
+  by a dedicated parser that is not a fixed-partition parser. To declare a
+  partition the label is required. This can be used to give a dynamic partition
+  an OF node so that subsystems like NVMEM can work and provide NVMEM Cells to
+  the system. An example is declaring the partition label and all the NVMEM
+  cells in it. The parser will detect the correct reg and offset and the NVMEM
+  will register the cells in it based on the data extracted by the parser.
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
+    partitions {
+      compatible = "qcom,smem-part";
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      art {
+        compatible = "nvmem-cells";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        label = "0:art";
+
+        macaddr_art_0: macaddr@0 {
+          reg = <0x0 0x6>;
+        };
+
+        macaddr_art_6: macaddr@6 {
+          reg = <0x6 0x6>;
+        };
+      };
+    };
-- 
2.34.1

