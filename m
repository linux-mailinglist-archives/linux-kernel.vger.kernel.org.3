Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A072F48DC82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiAMRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiAMRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:03:15 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7034C061748;
        Thu, 13 Jan 2022 09:03:14 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id hu2so7247000qvb.8;
        Thu, 13 Jan 2022 09:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUGM1wgx0CylrfJ3S8QjRVCzbUpeTn65OpoHNw1/5BI=;
        b=MYku/drkbjjL9X6ob7kI89nvlSCaoULGDxTZ51nH9yZOEUDDtyrOk2fNe5bl1SIbXJ
         a8vllS9jz3T2M70NTEFHec8AxEXMUsAY51bDl3QUp6foEzjH5Dydwd3pjSX7AyON0Ui6
         wWcZr/2JuYRWZ/flYmv8ymhNyXD16pitZRHeMZdC2O0BZ6Kum+Tk7RUFiCDNAeXwFM/S
         rc6JDepDUaoeb5eXLyK5JRHMxEZCbZzj/fiHOMfkU0oMKP7ydvZegAiwB7jr5Rx1bsi7
         dEKzZjmtwusPNw+glzNAgndV6gmIL931W9C0bBffcsoLvjklc9PJSSLUFFjpV1H+yUrG
         LhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUGM1wgx0CylrfJ3S8QjRVCzbUpeTn65OpoHNw1/5BI=;
        b=4hQ0se0v5E6f7hPrTslEvzW453FtnZX2KD5hoJPBKmxFa78TZiWO7Issd7b5IhvADn
         Arbqv/C5G6AJyhs+7Il6iBApUFhwT72NMDGVSd7nOYel76So64C+EA1NxjdE9xNk7PvA
         f9P1VHQk4MhY7ML+64am5zTJUqfYcxs7HKFD2/LePxNf2PsE6wNFp0O3RCzaaHLpNzES
         rZAyN/gGJpomsdG0cRfeTnJQDQJrWPx4cTYP5oY6JSi743bC9ErRegb/PQR+OrvvFDM2
         dd9Af3l8MZ0Ay95s0ya4ZyeycGZHIM+qjY+/csVu/lf9cK415ugee0acL8okdBFmwF6c
         m3Cg==
X-Gm-Message-State: AOAM531lVm27A/9KO/ZvfuqyzRBc/Ien5ovfnPwSDiFXiAS8uQCv4SWy
        vK8mDJPXLBcV+VZevjScPxBHh2V0xKhhvg==
X-Google-Smtp-Source: ABdhPJxjkVO/4RNVt1gKhdBv4CfB8eG87DxZQnVpQ0xBuzgomrMgB7L5SO0c7cp55iG3lIO83otxFw==
X-Received: by 2002:a05:6214:2aaa:: with SMTP id js10mr1007386qvb.115.1642093390189;
        Thu, 13 Jan 2022 09:03:10 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id j22sm2021931qko.117.2022.01.13.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 09:03:09 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: [PATCH v14 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Thu, 13 Jan 2022 12:02:59 -0500
Message-Id: <20220113170300.3555651-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220113170300.3555651-1-gsomlo@gmail.com>
References: <20220113170300.3555651-1-gsomlo@gmail.com>
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

New in v14:
  - add missing `vmmc-supply = ...` property to example section

>New in v13:
>  - add `vmmc-supply` requirement

 .../devicetree/bindings/mmc/litex,mmc.yaml    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/litex,mmc.yaml b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
new file mode 100644
index 000000000000..ef9e0da44bf8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
@@ -0,0 +1,78 @@
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
+        vmmc-supply = <&vreg_mmc>;
+        interrupts = <4>;
+    };
-- 
2.31.1

