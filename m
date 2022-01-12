Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA0448CE66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiALW2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbiALW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:27:56 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9A0C06173F;
        Wed, 12 Jan 2022 14:27:56 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g21so4673848qtk.4;
        Wed, 12 Jan 2022 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gvzl0X9+0vOaV4acox61HzKtk00Wi3wKNNgBr1N89qY=;
        b=FouoHeKduHhnQUIY6roPwMWLsVS02CChdfB09tEWN3Yvo0eVZpQPMT5An7og5kh0Hf
         va5qUGTCr9Sr9cFH5rK7cA2kWOgDwtD3/5wF8Scd3anESql3f/scuwyNL6hhc1eA5+ik
         np7AIFvTgwk6gnkprZel3qAHaCTJvNgpvTTC61crEkCEqefLEsvyyZTVG2ywlFKr0MEY
         5XDzw13FjogR9qt9BaY3iKVoJEuu1FT9tJ11x428hs+Hp4d2kVA1V8I9LxpJR96wZqxD
         PCNpMMdHAtZ/0zOro/aJKBEKYlRjz/envQRuhh6jFsxb4OnD9XPeKVsdeKLczz/goN7j
         Jy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gvzl0X9+0vOaV4acox61HzKtk00Wi3wKNNgBr1N89qY=;
        b=c8fjbjjFINHLnIhEXjaQsOj6oKfartBuba+bmQwPNTKhC8T5jGNl8ePbuGxpsQO2GM
         pSd5Amir1OHn2jzLOGrM/k8KOvPqcVujXagxfudM6axajjiSo6jKDFDI14mn5/Z6F46f
         h9hhFfzLmL0TSuxkk/Njwz+pWOGa+MB8QKJOc8XB7MO4Hlqerk7TmwyM5YQGh4SoKzAn
         1lNqwiJXomoJ3gUnh1sO5bUa1KPkpGuEpYQsmBqBLvGiBl3AhDeXtC9E/QM+VPLDNMLW
         4ma3nASGQn5asC60b+tckOWKrihGQJ9X/2yV8feKJaA35A+aYsjO/bd7lcQLY7/5Ix3/
         lWIQ==
X-Gm-Message-State: AOAM532BZ3GBBnkRVkOMPI5AT3Vzy8Bi+JhkbB8NJe4zGHqJjF0liPOJ
        HLXL6/ZPInj/AGuiM5bs65xA1skG+1MTcg==
X-Google-Smtp-Source: ABdhPJwgJ4gnNp4RIDcUwRx58Vt+bmZbM3Wptj69sVigGGYbMiWmem6XAICF2Sh6QdamQ81sWjxsCw==
X-Received: by 2002:ac8:5890:: with SMTP id t16mr1509188qta.236.1642026475466;
        Wed, 12 Jan 2022 14:27:55 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id q27sm611842qki.100.2022.01.12.14.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:27:55 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v13 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Wed, 12 Jan 2022 17:27:46 -0500
Message-Id: <20220112222747.3135585-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112222747.3135585-1-gsomlo@gmail.com>
References: <20220112222747.3135585-1-gsomlo@gmail.com>
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

New in v13:
  - add `vmmc-supply` requirement

 .../devicetree/bindings/mmc/litex,mmc.yaml    | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/litex,mmc.yaml b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
new file mode 100644
index 000000000000..f7bf71165888
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
@@ -0,0 +1,77 @@
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
+  vmmc-supply:
+    description:
+      Handle to fixed-voltage supply for the card power.
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - vmmc-supply
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

