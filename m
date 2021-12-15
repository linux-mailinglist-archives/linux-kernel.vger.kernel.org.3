Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25FA475965
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbhLONI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbhLONI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:08:57 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC8C06173E;
        Wed, 15 Dec 2021 05:08:56 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i13so20200943qvm.1;
        Wed, 15 Dec 2021 05:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Ox43oa+Czh+mlWTXv9jvCVoTil02NguQK6rBzom3hc=;
        b=I0KFfgIZFb1T7eTuywu5QbAamTrX+2ytSV7bWKy1n3ilDoGD/JT2dbXHlbwsn6D0EC
         1P9/688AKbmHM/rCQJwusHK7j68Cp9+LD2Sl/iZpB0JMFc359tQBwtFQvzvf67lI3EDu
         4exq0vshwqABczmbmBBkaGJA0Wh3QqOuyEOzFxkVxIwDsejjw8X0Ik06BBPDF4BCpZ9K
         nTRnSaMEQFZ3OP+UkOIwnL8+vE2sNtakrOygZACE7/oJ3CCf4Eg8dvRx9r3Doy/oUBSG
         upPmAO3J6QB4gYn8iRO487Dw+w4PhgtkOBCTAVybzhZud953vmnBRALo76GJVUAKqYY7
         2sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Ox43oa+Czh+mlWTXv9jvCVoTil02NguQK6rBzom3hc=;
        b=xpJrzkDX2RTvAu67X59OCxz16c5T8ntCJw7uHKr3MjvJ/Lfrmh9tq4sMD/+Cdb9KjZ
         Z353/gAtQOHewQs/gC3Q2DxUGf08Utw3oAYH6Ud1ozxgFrptlwAuG8jO+rJ+1ZI9nQEd
         AkUAXhLKLTl1vwyZCDquGzQaPH+mWP2SN0NMQp0JeAbz7sx5bImqXMcXWzL8cfL0if23
         2yGR2CwQW9UHxyyUVD8m5dTGz5PWl7KBxK3xlYbvDx9hszlv/scJhGSnA1sulCwisdjg
         5htfgDpTVGB63j+p4NkYeO2KDyPY2y0EYy297Jl2eXvjqYqd32Lqx4e28AKhAT0OX6Fa
         GmCA==
X-Gm-Message-State: AOAM530nGCaMTJJolAht6MCxpR7MgeoxS2Rr2ipeSGy7isF4SrVRBuy0
        VC5qiCz4CXKzX2BX4VbLi4tN5dBLRBnY2w==
X-Google-Smtp-Source: ABdhPJz0DDQyYhZVT+X3Lgm2ZsSxatdTzUtOT8BizsJ4OLjdmc2x74jMk8KsUfWCF8Xr2T7b9ywjFQ==
X-Received: by 2002:a05:6214:1cc7:: with SMTP id g7mr10915864qvd.79.1639573735642;
        Wed, 15 Dec 2021 05:08:55 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j12sm1594897qta.54.2021.12.15.05.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:08:40 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v5 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Wed, 15 Dec 2021 08:07:10 -0500
Message-Id: <20211215130711.111186-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215130711.111186-1-gsomlo@gmail.com>
References: <20211215130711.111186-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteSDCard is a small footprint, configurable SDCard core forFPGA
based system on chips.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---

New in v5:
  - picked up reviewd-by Rob, Joel

>New in v4:
>  - fixed `dt_binding_check` errors uncovered by Rob's script
>
>> New in v3:
>>   - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>>     bindings document (please let me know if that was premature, and
>>     happy to take further review if needed :)
>>   - add dedicated DT property for source clock frequency

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

