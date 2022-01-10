Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E613348A346
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbiAJW4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbiAJW4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:56:34 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B433C06173F;
        Mon, 10 Jan 2022 14:56:34 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id kl12so4765584qvb.5;
        Mon, 10 Jan 2022 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=emQQPUnj/liVkbKkNvCkknwhq9nRzw5DlwScgHGvtfW07n0Mi8CJVZ6R/xq2waEzBC
         i05DrBw6qmGri1W/RXyYfPB5iZBGQphOm1KdfX/U2+aBheIgKdbbDmCqVDepi2X7mP+d
         LHVsybif6h7sQbcxG1zFtKUEYqNxE0lYDo0bLUcepqxeJjwlvV7tmsq3zc+jN5sovuBQ
         7VnmiYkJVcq79J18YWBbDIJxEYgLwxxHLV4eNewIuoQjqR6cBHYdAHG6d7ad/7Jz3z47
         2jxHddBn0voOgnnGHq+PP8G51sOIwRS0TzYLhwgIeXonYEKVPbGygba4AAX/0RWGvpQT
         9+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzGV7VYBk0j14T6Qcu245zlbmVPGTLkhIeoiqo+RDYM=;
        b=TR3wnXRpFW+/dVX5kJRFHQS0k0Di3oKPZ+jKRmwT4VL73LJFo80C6/qYn1wIj9k6i8
         P5gI5bK7PuDglS4Qq1i0YsOxGaGDHrrvvVJ1Xw5CvA8v/LOXrBt5mML+h0YMKbcECLyT
         AELhKX3XgYZj1X1MT1HN2ion8b+Cw7Vf0MrElSfZKOZMC+CXhe8W4Bw5SOLdxcPJaLjz
         AF/p/8Q/7ug3uo3MLl0WunVg5p0eGMxJOuzd5qukDm0es7FddfhkhcQbj2GEc5avsajb
         mxaktCdaiJmFLBYYA9DeTe0xV3dFnTGvYMUEjnO09VzLsSHnGH+hmK2DFH4fabpQYWeX
         FrOQ==
X-Gm-Message-State: AOAM530qx6EJdiniEmQUannBKm7MIG0WHKlNkBzx5rTwXX8a9+ZMp/yZ
        RDX5+m3QbdjGyxV3OEGgrpfNBav4MOyVBg==
X-Google-Smtp-Source: ABdhPJyipPZGrckbpzmSIdGw58CpkYJ2B5yKg8uVZsz3vSwAsjR5dRUOJicbWMruLQLlydyqziDTLw==
X-Received: by 2002:ad4:5dc6:: with SMTP id m6mr1537398qvh.1.1641855393127;
        Mon, 10 Jan 2022 14:56:33 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id w12sm986617qtj.64.2022.01.10.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:56:32 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v12 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Mon, 10 Jan 2022 17:56:22 -0500
Message-Id: <20220110225623.2786104-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220110225623.2786104-1-gsomlo@gmail.com>
References: <20220110225623.2786104-1-gsomlo@gmail.com>
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

