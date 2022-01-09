Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC6488D55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 00:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiAIXUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 18:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiAIXUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:20:13 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C21C06173F;
        Sun,  9 Jan 2022 15:20:13 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id q4so12678889qvh.9;
        Sun, 09 Jan 2022 15:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=pfkfeX4HWeZGwOSpBWUyUuG8VDckrYrIls03a3RYRrrJhcHaHjccSpXITmUhCxhJh5
         caH08irxsC536T+N/Xvl+cM2i1MItFQuTxQzGLYsLBWYbMs39CnKPBVHShcLjJU72mXU
         P9nUo/uvM8n9JFV4fKUaI/8vnb0fYahNwfrg+JDu0ZlkqK4jK4Ibt/vvyFPadTl/n3wv
         ki5lJugVu010mMPrh5QxfEzvs64GWXNvkSn+RPsKw51xhOopR7KdfMfSPtkLYT9r82b+
         ZnQc7R/08/HLdX+J1IQ6tFtNA3y0nzq1j5nlwYcDLRrmT/YrOQBQWkWoKe1ovUy360rF
         VoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=22l3f/bJQkpJ4pNrJ/1MhounanOXK4/xBqdowRAdAdb9GuEtR5/UL38w8l8eDAqLlL
         ySAry2UE1y3IRw1I2/jG8RlJUxS1CJ9gH52lLbjpE2x9Evt9Q5b85sKj/bFE2QwWqRXy
         TmZ0VD+U/uY8s5KkAOOmqd8YmsJtdxdhaLVqYR34fHfD5N6u+9aq8/+Tr6MuPCJpD/xe
         MySWNvGXopWOhMJOg4yng8QEa98jNSsoGqZWN49uy5IkF7GiDEUuPRxGZp0qRGpCvQKN
         8GezTprHAgzqer2vmpZ19vzls9BJLqIrvqNVY/jWv8ri2Uoi+J63j+hbwnJz1jwLYoPS
         Jbqw==
X-Gm-Message-State: AOAM533UjtjnmTOCCPt1a83HPKLM7Eb1JDp9FiTKtp1kI4/vhabKj+ZB
        KJcyCrTyMWL1ca1DIjulD2w1+WmkqaraXg==
X-Google-Smtp-Source: ABdhPJwOCVvrpwGT4TkulISZkC1yy0/tV6mh31iITguXEx+c1IDwtJxT6nbmMIfnG1wW61ffeDXjww==
X-Received: by 2002:a05:6214:627:: with SMTP id a7mr13008672qvx.103.1641770411999;
        Sun, 09 Jan 2022 15:20:11 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h9sm96061qkn.60.2022.01.09.15.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 15:20:11 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v11 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Sun,  9 Jan 2022 18:20:02 -0500
Message-Id: <20220109232003.2573924-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109232003.2573924-1-gsomlo@gmail.com>
References: <20220109232003.2573924-1-gsomlo@gmail.com>
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

