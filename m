Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778657071F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiGKPax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGKPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:30:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B3A32BB6;
        Mon, 11 Jul 2022 08:30:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dn9so9437936ejc.7;
        Mon, 11 Jul 2022 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6aF44242Cbhj9tJR/zWLAwI/ThWjZFM50mDO0hgdDw=;
        b=TibOBdGSO+jHYEmqxPBPE1v1o5zW0g08biNvyyHtM881mmqbCne/CjOxui4UEFwRWR
         A2Q0c+jZHCx+iZ85vHjuwX5V7LaLcCqPHBzSxIYTnssGOM+yUfdvUpKOdr7sJNyDnPgm
         GwDDF8EX99oAPiVMlI8IIKuhgLJgi85qmKWdbtZXLnFZem5YwG4ig3H3rXxC3QYLZ0/z
         UjMWEYkBAmbcKoz62i/wIqxOEfvmXasyFer2ubzqmixLwSf+6W6qVpAumtf37KP+HWBw
         yG8JNTz/NwkjmUT/pU9ogR9ggTQsyTNbhPSqdKcKXCs8yutTTi/qQEZKtHGS+4L6dbXk
         fJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6aF44242Cbhj9tJR/zWLAwI/ThWjZFM50mDO0hgdDw=;
        b=IkaqnpC2xFG+En3dvkwgW98thqEJp2adpyS8nXS/rZvB/ih9Ct/vQjgXPMoa6J7c2b
         EjhIwBm5PnmGUPD81L//jq2GmrxPp5HQAa/FQl1xLiDo8lnOIlGhxuFI1XwU8pS2rSg0
         P6OH+hiXIqEuzhq4sHlftJMvrP/73glkCZlf2heIRDgwd4br4heKamWBxHcnT+QQ2ukF
         KXkUa0jQbVpYMHXsaoRgiT0FvpCLuot1vkaMnOkAGxBcMBtG6ChEqz9eGyYsdnBuYgNR
         Hv7xYbstCQ6q1qGMDr/Id+iYjOfygtbeflGanuZMexCVkB9hLQCcKU3SIpW869tqC8Nf
         s7Pg==
X-Gm-Message-State: AJIora/SbG5hGO8fqe87yiAr8KdUbvhiudR4rpLF2EL17aAbLK+o22wP
        r8RaQenq0cidhYp6ZnbuwGc=
X-Google-Smtp-Source: AGRyM1sYTryv3yld+nlU+GdWG1yQan42JMaJm5Jywwitmg3LUbNCUrIISFIjjUn7j1QFZGdlrtc5dg==
X-Received: by 2002:a17:907:1dc4:b0:72b:4d85:c7c4 with SMTP id og4-20020a1709071dc400b0072b4d85c7c4mr7409903ejc.258.1657553447551;
        Mon, 11 Jul 2022 08:30:47 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906725700b00722e603c39asm2773917ejk.31.2022.07.11.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 08:30:47 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: mtd: partitions: add binding for U-Boot bootloader
Date:   Mon, 11 Jul 2022 17:30:40 +0200
Message-Id: <20220711153041.6036-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Right now there is no (known) real reason for a custom binding for
standard U-Boot partitions. Broadcom's U-Boot however requires extra
handling - looking for environment variables subblocks. This commit adds
Broadcom specific binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/mtd/partitions/u-boot.yaml       | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
new file mode 100644
index 000000000000..8a88e7d16524
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/u-boot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot bootloader partition
+
+description: |
+  U-Boot is a bootlodaer commonly used in embedded devices. It's almost always
+  located on some kind of flash device.
+
+  Device configuration is stored as a set of environment variables that are
+  located in a (usually standalone) block of data.
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: partition.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: brcm,u-boot
+        description: |
+          Broadcom stores environment variables inside a U-Boot partition. They
+          can be identified by a custom header with magic value.
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+            compatible = "brcm,u-boot";
+            reg = <0x0 0x100000>;
+            label = "u-boot";
+        };
+
+        partition@100000 {
+            reg = <0x100000 0x1ff00000>;
+            label = "firmware";
+        };
+    };
-- 
2.34.1

