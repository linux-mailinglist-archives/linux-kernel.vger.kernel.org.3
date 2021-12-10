Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8754C47033B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbhLJO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbhLJO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:58:16 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE0C061746;
        Fri, 10 Dec 2021 06:54:41 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id u16so8196011qvk.4;
        Fri, 10 Dec 2021 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YV2lqlOI7Bk4A08FnVGA3M7GFT8sr6nV6fbl37p/UnA=;
        b=BTDhPyhZWSWxo8IfO6yKfIzwge+r7krDdOKsIbt2AVj/n9aPB2194BtuUNu/zdoUnk
         uCazB58mQcSnh1WKEgK2B0rzEvcp/soIEUk4w1WYuCHHLJGpGczcy2F/rXVC9krrXJgr
         g2JTih51d8iWkeaKBRrSUj6zMa09aYVC3H0K674ZjCXaNYlO9AMI16Xtux+d4j3Yqsi9
         VIwWGsGcQGUicEgmQK+zjYcJwhXopEo2saqS5jTNbmomxU4oYhYhhZUlbZRnxoNJyuxz
         cXQh76Pr47pbuq8J9AuzVk3cNHKsiflulNANiWd2ojenWNeJo9R9RNtdmLb/z9CeGT6G
         ePdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YV2lqlOI7Bk4A08FnVGA3M7GFT8sr6nV6fbl37p/UnA=;
        b=Y2SFFQO4rHGqQIXBQuAmpHMhvJTVKcG6yG+wbzMG/6Yw6zEiNKeKiR9YLkvNDdfJsG
         6xkkNlztdC2k6I6sq8RUiKA6M/Row7TUQkTPuTMy1N/SrVQRvPhS+18FU2FzlV41WHpN
         MvgI5HSaYNU8metBZk7/++KPW8SeKbeYAaB8jUGUvA4oNnEGagBebp3azlh0Ki9ec0pZ
         SELmnHdkcWGgdmd7tswR7dF1z+YI4FdzKKo4lYYdukR0+umg+mQ1z3AYtzhYlZQfN2ON
         v2ieVp74Qri38EVWv1PasaTU233TKd3z0okjJrXa11FQlJmU/ZDhglJjTcXLutHmasjH
         OY6A==
X-Gm-Message-State: AOAM531fXAAArrvWto+2Tk8ArCu+Y2w0KUjBXJJGpRLIHfca2PQRZDk+
        vUUcqbGxd97vaigUAOts3QwiUE+nHd4P/A==
X-Google-Smtp-Source: ABdhPJzD1kH9R5rGDmXoAPCbpKCc7+Slmj6X7bzQ6kBhh7dLi5aiuGAUREuNKvsmR6xC1o1Vzo5pvQ==
X-Received: by 2002:ad4:5e8b:: with SMTP id jl11mr26843576qvb.18.1639148080053;
        Fri, 10 Dec 2021 06:54:40 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id a3sm2054681qtx.59.2021.12.10.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:54:39 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v4 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Fri, 10 Dec 2021 09:54:29 -0500
Message-Id: <20211210145430.3707463-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210145430.3707463-1-gsomlo@gmail.com>
References: <20211210145430.3707463-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteSDCard is a small footprint, configurable SDCard core for FPGA
based system on chips.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---

New in v4:
  - fixed `dt_binding_check` errors uncovered by Rob's script

> New in v3:
>   - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>     bindings document (please let me know if that was premature, and
>     happy to take further review if needed :)
>   - add dedicated DT property for source clock frequency

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

