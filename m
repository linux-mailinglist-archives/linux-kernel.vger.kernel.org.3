Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E054D3EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiCJBnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiCJBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:43:10 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16E1275D1;
        Wed,  9 Mar 2022 17:42:10 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id ay7so4517580oib.8;
        Wed, 09 Mar 2022 17:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9XHwcIRgNF8SmDrShA+gfwbu1KqJ8/ICKtYt0fUEXo=;
        b=g18he6UPiluw3ljVgFlN3p+tu9HUR/DAleF8vcojK86n8Iju13g97nZv3HwD4SI9HD
         +AQhUwpsMXVoUVkw4hAGSaZjGqJCSZGlBVMSJ8Ro82xZhp6mVysXuYqyxn+2d9Pg4qL/
         vTw4Uj0Z2/44FP+u8G7Z5rOI/6KazrfhaeVctlYEOLGzqDKoYzyBm0difoZ5+2Tm+hbW
         qsZE1hqD0rAYrr8ts7+LNjxi/RDu4QHlHY2UmDygLiyX/F/xdjkZWcjsjXPcYgVmRjlW
         ENdYThT91RwOulT6FVza5+7SnG2QZUNIQf+ARY9eQ7FvntFjT0b7eNSE0uximnbNQ+hV
         NfaA==
X-Gm-Message-State: AOAM530YaM0wvgdGx5gZaOBO/TtzpelsnOaKiakGo6PwLM88cYOhLqmS
        ZTYAhT17cWq7faiLK7RkoQ==
X-Google-Smtp-Source: ABdhPJy0o2mUD3gu4wlQpEtY3WUAmx7yoVEOdQL0BTi6mNsVhAVSg6AGagmqPrhU62jDbHZktxd39Q==
X-Received: by 2002:a05:6808:124d:b0:2d7:f6e:74b0 with SMTP id o13-20020a056808124d00b002d70f6e74b0mr8105528oiv.141.1646876529895;
        Wed, 09 Mar 2022 17:42:09 -0800 (PST)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id l15-20020a4ab0cf000000b0031c0494981csm1844151oon.9.2022.03.09.17.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:42:09 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Laszlo Ersek <lersek@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: Convert QEMU fw-cfg to DT schema
Date:   Wed,  9 Mar 2022 19:35:52 -0600
Message-Id: <20220310013552.549590-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the QEMU fw-cfg binding to DT schema format. As this binding is
also used on Risc-V now, drop any architecture references and move to a
common location. The fw-cfg interface has also gained some DMA support
which is coherent, so add the missing 'dma-coherent'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/fw-cfg.txt        | 38 -------------
 .../bindings/firmware/qemu,fw-cfg-mmio.yaml   | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/fw-cfg.txt
 create mode 100644 Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml

diff --git a/Documentation/devicetree/bindings/arm/fw-cfg.txt b/Documentation/devicetree/bindings/arm/fw-cfg.txt
deleted file mode 100644
index fd54e1db2156..000000000000
--- a/Documentation/devicetree/bindings/arm/fw-cfg.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* QEMU Firmware Configuration bindings for ARM
-
-QEMU's arm-softmmu and aarch64-softmmu emulation / virtualization targets
-provide the following Firmware Configuration interface on the "virt" machine
-type:
-
-- A write-only, 16-bit wide selector (or control) register,
-- a read-write, 64-bit wide data register.
-
-QEMU exposes the control and data register to ARM guests as memory mapped
-registers; their location is communicated to the guest's UEFI firmware in the
-DTB that QEMU places at the bottom of the guest's DRAM.
-
-The authoritative guest-side hardware interface documentation to the fw_cfg
-device can be found in "docs/specs/fw_cfg.txt" in the QEMU source tree.
-
-
-Required properties:
-
-- compatible: "qemu,fw-cfg-mmio".
-
-- reg: the MMIO region used by the device.
-  * Bytes 0x0 to 0x7 cover the data register.
-  * Bytes 0x8 to 0x9 cover the selector register.
-  * Further registers may be appended to the region in case of future interface
-    revisions / feature bits.
-
-Example:
-
-/ {
-	#size-cells = <0x2>;
-	#address-cells = <0x2>;
-
-	fw-cfg@9020000 {
-		compatible = "qemu,fw-cfg-mmio";
-		reg = <0x0 0x9020000 0x0 0xa>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml b/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
new file mode 100644
index 000000000000..3aac9448e7f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qemu,fw-cfg-mmio.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qemu,fw-cfg-mmio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QEMU Firmware Configuration bindings
+
+maintainers:
+  - Laszlo Ersek <lersek@redhat.com>
+
+description: |
+  Various QEMU emulation / virtualization targets provide the following
+  Firmware Configuration interface on the "virt" machine type:
+
+  - A write-only, 16-bit wide selector (or control) register,
+  - a read-write, 64-bit wide data register.
+
+  QEMU exposes the control and data register to guests as memory mapped
+  registers; their location is communicated to the guest's UEFI firmware in the
+  DTB that QEMU places at the bottom of the guest's DRAM.
+
+  The authoritative guest-side hardware interface documentation to the fw_cfg
+  device can be found in "docs/specs/fw_cfg.txt" in the QEMU source tree.
+
+
+properties:
+  compatible:
+    const: qemu,fw-cfg-mmio
+
+  reg:
+    maxItems: 1
+    description: |
+      * Bytes 0x0 to 0x7 cover the data register.
+      * Bytes 0x8 to 0x9 cover the selector register.
+      * Further registers may be appended to the region in case of future interface
+        revisions / feature bits.
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+
+    fw-cfg@9020000 {
+        compatible = "qemu,fw-cfg-mmio";
+        reg = <0x9020000 0xa>;
+    };
+...
-- 
2.32.0

