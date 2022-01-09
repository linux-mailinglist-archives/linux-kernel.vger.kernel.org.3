Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9F2488A07
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiAIO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbiAIO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:56:47 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0A6C061751;
        Sun,  9 Jan 2022 06:56:46 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id f17so9213795qtf.8;
        Sun, 09 Jan 2022 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=BXXcKQRb3LqFEZEGp6dkyl74u82WqLrnkQYQHeNazbMYZnWeOHYWBsCKNv0429Okxn
         Jv3u3+ozUqTruygmGnaDVwodEkEzRUrTEghNNRqz1RKykzal3wrCkiSHz4pB2e4iA5/E
         VDJ2r8AZrkmRbEcCaUCGSR5BU4zdhTnXCWThbVkmia2V4WGkuvLsWUSM9XYuJrZefE3w
         SgoguBr1ZaZ/OVe38VBEIrC0lSB87X4MN7jLU3h08Hk4m0TYjsMAGhSZGrOeGiAiE5kU
         Al5jgMLx35L8dyj2MwQn8u3vFCMhdS1WLoagrIUQoTmg6lvp+hj0NPcXEYoW0Dpgj4CY
         jJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=o45vwzA4SQaoy6Pvs7ZvfRVM7TlvO6Z/1Znj87ZzpDV7aiGT9f1SvTSPNyFmDrVHc1
         rpTn6K4+F+xC2fQAifsB7t/TvEPzksNTWv/31pltYbMi9O0TplTTbSRfh2ipLHwvYIAD
         +VxdwXFzsqjo5QFhLXE2xWBRfwiTq1SvGJ+cvtsSh3/52eWp6XocnHTIG0R4BByarYLW
         YkvSRdzxsRBLtGYOPLwU5gK3LZH/kgN6TDjvhkTLgzzxHgpdks22nL9RmiZKi10dWwYK
         qn90+8tWkrpg3t6lu42bbCj3qXlqPNLlyDD8RcsHeBKl+cRARIe0LsauZpxnoFEXJBnN
         jNnA==
X-Gm-Message-State: AOAM5326OiX3jMgRdVjAMXJlcBgS/7thdWzJDJepDvkZSnAsKuOpF7lH
        VzUdPGIeTPfqvqzY6Uo7EB8OUe25OEpiWA==
X-Google-Smtp-Source: ABdhPJzwD5OAe7TsZNIhHz78QSE9dBnG40OYj+uQghFAUog560pErDr2jV9V046X/Vq3UVBeLWLw4A==
X-Received: by 2002:a05:622a:1044:: with SMTP id f4mr16408912qte.494.1641740205622;
        Sun, 09 Jan 2022 06:56:45 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j22sm420341qko.117.2022.01.09.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 06:56:45 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v10 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Sun,  9 Jan 2022 09:56:36 -0500
Message-Id: <20220109145637.2506583-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109145637.2506583-1-gsomlo@gmail.com>
References: <20220109145637.2506583-1-gsomlo@gmail.com>
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

