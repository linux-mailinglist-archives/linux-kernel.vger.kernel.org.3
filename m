Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC827486917
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242404AbiAFRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbiAFRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:48:14 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DFDC061245;
        Thu,  6 Jan 2022 09:48:14 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id f9so2287016qtk.3;
        Thu, 06 Jan 2022 09:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSlXJjtIKSfDb6/bz97gNWcdnKMzriso15vhT2To94U=;
        b=J5FnpnGdUYNV6YhYnJRRG7VmshfBQoazYRyp0qGICGwFFrymY+wcxL2mIe+m5Y2NTE
         Bluj6KsaD/GPKoRt/zP5zMc8UmohjcklksiUYM39q7L1V2wHluFR8yQ8odB3/bG9fV4f
         aPDfb2kRubkp4PjMjAwcGnAAZoCNu7cfUMKaT+nBdei1rmoKggvU8REW67Fk4MgVvOIM
         76G7VXP1SZO2zos6/eyafyJ3KdAspbNj+zDyq6thWEkW8hSKSceHTVZtxHAcNTz69Omk
         qSFkGp85huVoKz8yVNsW8yKV1kOrFS219nFYsQVnUzeotpqLgPftEqqND6BAlgcbMMlD
         AM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSlXJjtIKSfDb6/bz97gNWcdnKMzriso15vhT2To94U=;
        b=jkuFEOj/4hpQS6FtkcoNj+W5xK/Gt1bWLQAHRexP9fZ1DG4kCM0Z9wbt7t/AOvQ3Sv
         Vkkb7eX8hOdjNDY12EhLLRUu5IODHYBZE3PD93xTtzGee/m25buzPy3zoVgfe6cTIXUf
         jSzbPBJDwKtjaFrt2nLOrvmh2ZJjJDHip/+v2AbSBir40B33nESDxohue0OAxO0ivr0O
         hKeFWr8TzqYWFC+4CvJWASpbMHVuCfcakIRrMMlxn2v6tC/A1+Lya210Unpg+idzsJhe
         MJnW+zCdb6uyI9eopa4ARHDZDL+RTj5HQSWsWsBmhHQdhCvkt7fjgjxeO2EpsQ43Y2H6
         3JEg==
X-Gm-Message-State: AOAM533CETUNcw2LjntTjp7TEM3LKCo8BEf2oH+1QkUCQ4gpvmWMQOQQ
        zuqzmgB7g19+uEoLIsrZBAfl4pWodHyp2w==
X-Google-Smtp-Source: ABdhPJyiYsYZHLdAIfkgR+R4x5A98oLMAIQpHzh7x8ZOY9Zn3QJYjsrwXyrfsll4NhAwcHgsATMYGA==
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr54010877qtb.379.1641491292956;
        Thu, 06 Jan 2022 09:48:12 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id u19sm1709227qke.1.2022.01.06.09.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:48:12 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com
Subject: [PATCH v6 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Thu,  6 Jan 2022 12:48:02 -0500
Message-Id: <20220106174803.1773876-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106174803.1773876-1-gsomlo@gmail.com>
References: <20220106174803.1773876-1-gsomlo@gmail.com>
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

