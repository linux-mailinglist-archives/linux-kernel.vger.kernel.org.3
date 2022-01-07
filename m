Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4F487AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348466AbiAGRG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348452AbiAGRG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:06:26 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D0DC061574;
        Fri,  7 Jan 2022 09:06:25 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 131so6535512qkk.2;
        Fri, 07 Jan 2022 09:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSlXJjtIKSfDb6/bz97gNWcdnKMzriso15vhT2To94U=;
        b=oDR87RWnjO3hX1R15PH3Vq3hHBsqNMrnQUhvQWvegiNdN2xl6Pw7vv3tos9jddQ/JV
         345J0XACSQsGr8cljL8tlDM4LOZlP35g4xTX25U0xSb+WrrI1rn9nLkfDydUtli2oSSY
         B5JL5POgc07J9dvMIF+AUZkP7rO4FvkOYX6ZUmeQ+jpjNBfKeXWgQTL0lXmAViuMcjP+
         LEd28cyaPfvSD9re08kIPsqZxgCrHaYBBxwH3nFc6KjybpTEzWCq34VDeDW6X2cCLmUV
         GIvHrFdYOQsDlW+zoVxK2Z/SLd11+OPEtumKfZRLBpaTn3drTbQzxj72SJt4XqEkafum
         M4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSlXJjtIKSfDb6/bz97gNWcdnKMzriso15vhT2To94U=;
        b=m/J4+qbOTWjx8BlNuFVh6/V5SyQoPYBvLlbTPjjmHB8jT0yIDJIQmhg/vmTwaTFPwd
         XFt5po8vSUg81TyKyIvKScv5yJ2jPvT15z01mipJoVrMi82OCrjtG4ig9dCAVorJL+zd
         X8iXd4kPgk/4DsqoudX67uunt5gAXCT/Grb7kl80jcdb9iAsGLfJxxIetU3vwGlGkVqn
         g8xgiDm3xOqfOtM8cD6PmrY3IseQEHWLYGRYz0/vCvz9mwwpZAgFSN+XRtYGuXBwBg+v
         3RFAJhz8MLwbO0OfLUDj6R5QqGQohp1k8AtIpiPEpZH12lO6IrIlAbRjF9X+398E9NYr
         29+Q==
X-Gm-Message-State: AOAM532v9gDXzzlvQpRbBmq4wQrFAjPvBdEryFet2g4IJrdotA4JIgBg
        UUqy2B8JaI5OphAz2pK3vn1e7JY4CMvivw==
X-Google-Smtp-Source: ABdhPJy2m2V0SNqI1rlg6Q6UwLGaL+WOl5nI6iXB0D1u2DeNDEWhhf8uWQGmvR4qiJAH6L/QV/3Xcw==
X-Received: by 2002:a05:620a:9dc:: with SMTP id y28mr45328924qky.257.1641575184545;
        Fri, 07 Jan 2022 09:06:24 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d9sm3961085qkn.131.2022.01.07.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:06:24 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v7 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Fri,  7 Jan 2022 12:06:15 -0500
Message-Id: <20220107170616.2041589-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107170616.2041589-1-gsomlo@gmail.com>
References: <20220107170616.2041589-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteSDCard is a small footprint, configurable SDCard core for FPGA
based system on chips.

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

