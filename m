Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0F468788
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349997AbhLDUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhLDUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:44:57 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F36C061751;
        Sat,  4 Dec 2021 12:41:31 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id i12so6237073qvh.11;
        Sat, 04 Dec 2021 12:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/2fR1DEOwOnIt2ZN3aYDVK8fDwuingfzb4Dn02cKyM=;
        b=G95/CbtamLUyOKF9wPyAuqNT5DRWRL+vja+Lud5fsEG6KWTdo+/5L73Cs1I3PpzDwM
         yt352D/qegXoWsDL3OzzdQi6GKI7VwyBZNk8UV8yRarsRP1f9siElU7Wk4Kh7V+lnf5S
         Uj49YgaykhxJ8a6Ug+iJcFtBoUE/VY0vBjqGMk88BiUeVexTomYqNfm/J+E/mJORbrpo
         eAGcDlq5hu6OzjCIShGYMJ6OsKZvVNcPG5wXc0Uu0FhqjBHOnQUsdtAVL0kU2OeDvdui
         uoLYnURQJ8l9SrhNtChbqRPmUaXzBsnxi4DOQF7t0sFiIhRYnjx0aN8dz7m+sUshGARa
         lRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/2fR1DEOwOnIt2ZN3aYDVK8fDwuingfzb4Dn02cKyM=;
        b=qk4sdPUpXTjZdJLFSMfhXXo54DpSFX7BnfgIuUdyHeu1WkGF6p5PCQZy/gPLFmcJhs
         ZI2vfCBTCqziQ3Bu71eGPgDcepaEh1sem3/I0HpobLJwCgzbx0zi2X53ifJ4rgx8Msar
         6qTrjmUvgH3IXYk9ICDthm0DJNzLRP1l60ojgZMCON8PGq4FWkTTZgmewwF9/HQCIay3
         UASw/omSoV1yCc1/o9cRqVJDcCeGj3BsI8GViQO5v132iHy+6t8JK3pyVeH2Y0TxmYCc
         YEHcDZoY9fC/FoRL2/JavdulU0G6GYNjPGHoA10mnTvIJL81OQG7u6CpUCzyFyAcVWYO
         A4Jg==
X-Gm-Message-State: AOAM531ngl7mbBuqxXOtr7qLk/fuiTmOB5FT2EAJfn5zfQnIr37w1G3u
        3kz5DsaJ0mAhpmV8Nqawr9TIGTYTKGNzog==
X-Google-Smtp-Source: ABdhPJzq9/PHKrMFV2MC5CtdYAUIAZS7TSqML00ao44s//n4wJDSso4wuU0aZZAM75u3pTtjjoIeug==
X-Received: by 2002:a05:6214:c6f:: with SMTP id t15mr27134309qvj.6.1638650490095;
        Sat, 04 Dec 2021 12:41:30 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id c22sm4862480qtd.76.2021.12.04.12.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:41:29 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org
Subject: [PATCH v2 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Sat,  4 Dec 2021 15:41:20 -0500
Message-Id: <20211204204121.2367127-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211204204121.2367127-1-gsomlo@gmail.com>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LiteSDCard is a small footprint, configurable SDCard core for FPGA
based system on chips.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 .../devicetree/bindings/mmc/litex,mmc.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/litex,mmc.yaml b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
new file mode 100644
index 000000000000..edc5ab7f359b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
@@ -0,0 +1,63 @@
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
+
+  reg-names:
+    items:
+      - const: phy
+      - const: core
+      - const: reader
+      - const: writer
+      - const: irq
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        interrupts = <4>;
+    };
-- 
2.31.1

