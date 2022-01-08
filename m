Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2485488475
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiAHQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 11:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiAHQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:11:43 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0322CC06173F;
        Sat,  8 Jan 2022 08:11:43 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c10so7180742qte.2;
        Sat, 08 Jan 2022 08:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=HHTYCElT5c23m4snOriCDIRaFosBXgaaiteTa8Xe6Vd4yjRy9p44rseeXTEMLqk45z
         zJd9/i7bJAQ9qLMNB7ZEbMCQLDBND9icahZGo0ytZroMvkZ2BjnSmilaAyUUyABW9l5+
         rQI5/QQP+uPp3zyT2pFgHDkmf/fN6nurMQwElLBWExLNM/g5onbN5bm8pc6gHWD+iQ0e
         /F8TiNnqUtiv0UjpXaa5ubdTIs4UnH5sah64tHmMV/YRpoW5ZbJAQZOIW0BFsAX1QwTG
         zW+39/yGzX+XA02U+n6gkEKzEdarGOtsi0KrmK/op2gjZcwQv8Lc+qbmLAgLyqHtXNzo
         XDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=NOVrt0hTkPVV1k8LCKzdelJXrvjoGWxRG1yadX0+Bg8IpE+E53MciB8h10U5G+dBxi
         HZB+Y1TMlV9/i3xhrS91jdEeVsoVWHaWRiPRPCO+1b5i6DVDZAOhXGLA8tviHT0Q8pvn
         6ot8V4mhEFM64ne54fRT1+KsnJRHVMHjLalH6Hg03Yl5piqzJmY7utx+ehmMzHJnaOmj
         qv9ZTexGGij+n5LMpKvBq0GrOVwZ6/qy4vfskFERrLyyUPwUr6mnMLEyqZTRCJboWoPh
         PKS7A+S9xH07OGWaRdFhITbIC6lRqL0GQbCJ4KROmzAZ0u/S/GQ6G5dd7DZ645iedj52
         ublg==
X-Gm-Message-State: AOAM533RZYinZG7lBDKYrTufuXl0GjilDroViqFAr9NJBbXwl4YB3FE+
        HZy4EgddQnswjRlSyMBCQ1YJcscKp4+pyQ==
X-Google-Smtp-Source: ABdhPJxmGtJcG87jrszUJavV3l3CWCTGy/MDU+Gk+4M7S0gZV5WjtiLc3I2zFceug5Q302rsamR5qw==
X-Received: by 2002:a05:622a:1456:: with SMTP id v22mr5377020qtx.310.1641658301968;
        Sat, 08 Jan 2022 08:11:41 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id bs9sm1207435qkb.87.2022.01.08.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:11:41 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v9 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Sat,  8 Jan 2022 11:11:33 -0500
Message-Id: <20220108161134.2419279-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220108161134.2419279-1-gsomlo@gmail.com>
References: <20220108161134.2419279-1-gsomlo@gmail.com>
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

