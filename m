Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EAE487F77
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiAGXfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiAGXfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:35:06 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45222C061574;
        Fri,  7 Jan 2022 15:35:06 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t66so7561477qkb.4;
        Fri, 07 Jan 2022 15:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=KXFFhYgifbad6vDB4F2wooh+Dhr7AmHzCwy/jFG4fVcr0yesUJR3huRTFTXhXPxq9n
         t5SMW2Uq/Rwb/uwKqKsSe+UriloRdUnEQIh076omLA0IQ0P4kog7vXhRNK9U4t3yVOMq
         yZRoL3e020mWcAE0/zTIRJO1UsnBuGLPmg3P4X8KHaH3yE9dvrdNjok352Jxsx4jGrUk
         vARJOX2Y2WoirjUG8Sp5aclEe3jc4nTZk74rsPCR18FU1B+MMMQwjGoA2XRZKSbOrmj9
         6cIr3OyNj/vbA9H6r3r9MYaBaJ5kGgli1yagQOU9VEXHWOCgs8gyly5sfoE0drrQDcBF
         tGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=fxtPGEUbVIdDNhW1ioNdiq85++DC+PZ244VdmaR/Y/iZ0uuigAJYe5m36vwtoPeBqW
         DrZ3IcyCunfJoOdPjQDKTOyvwexa2ycRd6LK1DeZYuIn9YEoyt7KV5f7KSNF2Rsajtb/
         REIzpBpjMOOwnT6iPUY2iu2S2oLGv54hSMIC5dW0y/zYaTT/gw65haiMIGuGlO3qfesW
         96DWtE582Mx58w86d826bZOW3kJFxOq8xXDNWNY3Pfrj6TGuex5xQmGk5HE72XLXYNpc
         RvWxptF0HGczP4nHEoDa70pue1HL3o72QKRRNs0DA0O54rLlu6gS17DUGNjK+tHQx6EX
         ZP1w==
X-Gm-Message-State: AOAM531F/jv6FKDbAgIiMNeOZmJp0QbFGAii9KkzgkM5hjbSSK6Erj8o
        eZBduSkrHnl85R0x+OxUHULb4OQLmEequQ==
X-Google-Smtp-Source: ABdhPJz3HgSnMKkQjbGoo5uSK2QuaQBq6ur8TxRYrRnNeOwXMedMQvVHFC0ixmG9WL56yeG9fDnPPA==
X-Received: by 2002:a37:9d8f:: with SMTP id g137mr46194321qke.222.1641598505198;
        Fri, 07 Jan 2022 15:35:05 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id l13sm61283qkp.109.2022.01.07.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:35:04 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v8 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Fri,  7 Jan 2022 18:34:57 -0500
Message-Id: <20220107233458.2326512-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107233458.2326512-1-gsomlo@gmail.com>
References: <20220107233458.2326512-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteSDCard is a small footprint, configurable SDCard core for
FPGA based SoCs.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/mmc/litex,mmc.yaml    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/litex,mmc.yaml b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
new file mode 100644
index 000000000000..f57cf42b8db7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/litex,mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteX LiteSDCard device
+
+maintainers:
+  - Gabriel Somlo <gsomlo@gmail.com>
+
+description: |
+  LiteSDCard is a small footprint, configurable SDCard core for FPGA based
+  system on chips.
+
+  The hardware source is Open Source and can be found on at
+  https://github.com/enjoy-digital/litesdcard/.
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: litex,mmc
+
+  reg:
+    items:
+      - description: PHY registers
+      - description: CORE registers
+      - description: DMA Reader buffer
+      - description: DMA Writer buffer
+      - description: IRQ registers
+    minItems: 4
+
+  reg-names:
+    items:
+      - const: phy
+      - const: core
+      - const: reader
+      - const: writer
+      - const: irq
+    minItems: 4
+
+  clocks:
+    maxItems: 1
+    description:
+      Handle to reference clock.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    mmc: mmc@12005000 {
+        compatible = "litex,mmc";
+        reg = <0x12005000 0x100>,
+              <0x12003800 0x100>,
+              <0x12003000 0x100>,
+              <0x12004800 0x100>,
+              <0x12004000 0x100>;
+        reg-names = "phy", "core", "reader", "writer", "irq";
+        clocks = <&reference_clk>;
+        interrupts = <4>;
+    };
-- 
2.31.1

