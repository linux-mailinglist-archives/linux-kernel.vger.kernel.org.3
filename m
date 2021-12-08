Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27F46D456
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhLHNYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhLHNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:24:28 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F70C061A72;
        Wed,  8 Dec 2021 05:20:56 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id 8so2137229qtx.5;
        Wed, 08 Dec 2021 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkUfzTMM3SnClyeiWzHwKXUh+YzNvGjYBgOHEh5b08M=;
        b=UF9xQKiOuyrJNsBrlmae7ilbbbOj1VpKerzAqwJXLnPIaBI/AiaO5wZr8GTs7Q/j3w
         pPgQFyRIl33cHTHOjX81Xl8XUkrqNdwTMlfBgVlVMV6rOIConJNCOUzR16RfwwqF9jCo
         ApvnzjRLH4XbWv2IvfjRB3f086Y0ipJhlgRBAGvlp0I510I0ezzE8uLkML7LeHCfGcdq
         mIx2WZjeQI+M0xexq1dSZr9bS2oL5dQyCBcr+Z94WpTUrDr0tDU3QQepC9lwVgmD9vGl
         nb5ntsxCMYTgWQb0oJNAS6uUgKHk+XnycFqu31t38QxdqT7Gq4ysF2ASCWu2buMVziGJ
         NnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkUfzTMM3SnClyeiWzHwKXUh+YzNvGjYBgOHEh5b08M=;
        b=0pK7BMwn7aDOM0IMbuII+WGf3N34C+7tuZ+DE23EIZeYeYWwiuwzCQBCQh+Dz48nxV
         tUpipFx1RNoTEyF8hydclROwLvluiuJWbpIUjiYosTq74cgzpGfGEhV67XmrDhdoQbUu
         rKHyFKIEOMLB9V5oNbbdwXh3bWRPNQTy25iuVue7iMLIrhseYJSrABlTRe9/e3yWITM2
         bnqcIkUnGL0gquWQQ94geJqVISJ5beJyeCA3DTypH3ypogeBpsfNfnwxikPpMKFwDRwU
         ELL5gfC9DWV4QI72u2LbojZ/JTqU5hWCuAoRPokoN4x3oAZTP6thr0dcaH0Zk3HZFR0N
         nXgg==
X-Gm-Message-State: AOAM530CQGsDPZA9WXkP1ZqovYEV7mU2JKhawMaDevPEIo6YERm/5jnr
        VEf1Fu3PJPd5m5IkVgshwRQQe1408uHHeA==
X-Google-Smtp-Source: ABdhPJxFtjRfPVoi4XeiGnP0u2SUTSXorhQiHf87ll+nkzVvY7y7bgfuAwV7KghlicdE43eDXL6lCA==
X-Received: by 2002:a05:622a:651:: with SMTP id a17mr7665350qtb.608.1638969655027;
        Wed, 08 Dec 2021 05:20:55 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id d6sm1544132qtq.15.2021.12.08.05.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:20:52 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v3 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Wed,  8 Dec 2021 08:20:41 -0500
Message-Id: <20211208132042.3226275-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208132042.3226275-1-gsomlo@gmail.com>
References: <20211208132042.3226275-1-gsomlo@gmail.com>
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

New in v3:
  - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
    bindings document (please let me know if that was premature, and
    happy to take further review if needed :)
  - add dedicated DT property for source clock frequency

 .../devicetree/bindings/mmc/litex,mmc.yaml    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/litex,mmc.yaml b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
new file mode 100644
index 000000000000..9b8d4ec30375
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
+      - description: IRQ registers (optional)
+    minItems: 4
+    maxItems: 5
+
+  reg-names:
+    items:
+      - const: phy
+      - const: core
+      - const: reader
+      - const: writer
+      - const: irq (optional)
+    minItems: 4
+    maxItems: 5
+
+  clocks:
+    maxItems: 1
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

