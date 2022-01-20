Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BB495568
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377651AbiATU02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377635AbiATU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:26:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52FC06161C;
        Thu, 20 Jan 2022 12:26:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id w26so14496354wmi.0;
        Thu, 20 Jan 2022 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BU6QG1pcbtiezVEs71fXj8uW5BmpzUpTu00HX48AVes=;
        b=C9cRX0L3KktFSggGD3oPSst1A6JSeiEjti+f7jeM/dT0acrhWyF60/Bb+B8Fa1wzCn
         ANZOMXsDoZg1m1FVOrl7yYdG6ZherCMau9B6psHFBQlO2vP0Bijw/nB/J33I2dnUSE+U
         qp0M+V44pf/Q9vlaHUFh1K8lIQEuRUBu7SgenqVD1CEHoe/JtIbMrCSZ/dg5nYb1Nupe
         SJZKgQdgKWLl7dzYDyE1M6c0MM7malWiTmNGXJec5ey/6x4ls76eZE2X0M3ma5ISAWSn
         zVeRG1M574KuiXT2Ur0r/3U9IYhuE9VgYfSX5d/ooiXsPk8FrpxNGwT7G4NUYGzkntyD
         JmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BU6QG1pcbtiezVEs71fXj8uW5BmpzUpTu00HX48AVes=;
        b=4vtI11g91aUUNaFyKG2AIyPgAX/CIsJL6rX2p7bQh5YlS0RZn7erf55A9NRrWjoFza
         CbQJE2UtsFxpDUeeOKHeaJJ8R+e/LDYfNey3ub8gNQ5vki758+pd8pOHgxrf+wbsdWTf
         7lxDEHU/aBvn1c4fzZeGblDxw4Fo9g9BRflbyKD6UB+CzzkqrYV8qfXtImoD+oY+UHW0
         nwnExE0QN17U6NonzKkPgg12gi2lU4XdkXHCemcBtS0UWdix74w2Qlf04boSFqFvSGRT
         xPzf+fX0EUQJlxo4TtdJmpsJOMb5aDTdlHg/CxrT5UzikwcO8JYqflmuvTdaA/dwG/nq
         lv3Q==
X-Gm-Message-State: AOAM533xjoxym4FL4l8aOkI0HIdQIIoVoyONtrIrMHl2fFgfeuxInCz2
        kkNBzPsgV/yF1xSIlx75O/E=
X-Google-Smtp-Source: ABdhPJxniIQsGh7ZQrt5BO1i77UUotIRau7Ve2ypejLfqZTMAC4M7yvn+a6dt+yDU0WQIkeJiE70Kg==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13mr684134wrt.641.1642710380687;
        Thu, 20 Jan 2022 12:26:20 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n11sm862919wms.3.2022.01.20.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:26:20 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: mtd: partitions: Document new dynamic-partitions node
Date:   Thu, 20 Jan 2022 21:26:14 +0100
Message-Id: <20220120202615.28076-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120202615.28076-1-ansuelsmth@gmail.com>
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new dynamic-partitions node used to provide an of node for
partition registred at runtime by parsers. This is required for nvmem
system to declare and detect nvmem-cells.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../mtd/partitions/dynamic-partitions.yaml    | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
new file mode 100644
index 000000000000..7528e49f2d7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/dynamic-partitions.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/dynamic-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dynamic partitions
+
+description: |
+  This binding can be used on platforms which have partitions registered at
+  runtime by parsers or partition table present on the flash. Example are
+  partitions declared from smem parser or cmdlinepart. This will create an
+  of node for these dynamic partition where systems like Nvmem can get a
+  reference to register nvmem-cells.
+
+  The partition table should be a node named "dynamic-partitions".
+  Partitions are then defined as subnodes. Only the label is required
+  as any other data will be taken from the parser.
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: dynamic-partitions
+
+patternProperties:
+  "@[0-9a-f]+$":
+    $ref: "partition.yaml#"
+
+additionalProperties: true
+
+examples:
+  - |
+    partitions {
+        compatible = "qcom,smem";
+        #address-cells = <1>;
+        #size-cells = <1>;
+    };
+
+    dynamic-partitions {
+      compatible = "dynamic-partitions";
+
+      art: art {
+        label = "0:art";
+        read-only;
+        compatible = "nvmem-cells";
+        #address-cells = <1>;
+        #size-cells = <1>;
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
2.33.1

