Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C3449C903
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiAZLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbiAZLp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:45:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A316C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:45:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h14so5313033plf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GAM/hX8HgcK0XMc1etnUAnui1b4UtU65gzKDf04W+Y=;
        b=nepeMcuhlOB3I9Ap4vMU01c7Evw9bQuHYUyDEXY/4o/84M2mdIhe847JKmxKqwP8zI
         x8Qm9muzArpkU6LCGMR3IiyCr5OjmHMjFULlSQQDsPwR9lCTq6VdcgUKJf/vgviZULJO
         i3Y3NWYjIlYos/tWCtWUHsF0shN/YJIQ0XFPu/W2VkQ836qnvCcnljOE2JhMooFjZx4+
         Od9VA/xgIwN2zuB+lYOrmpPme/HMF7jP1d4ig2DExAcijH/rzLEUjyQjLY4MyTJc3fx6
         6gNbzoJTfNH2HoMQOFlzlr1C3Z2VvBS5fbHVYcemeiWv8+G11ahA1ccymfEG3V3LWBCg
         QSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GAM/hX8HgcK0XMc1etnUAnui1b4UtU65gzKDf04W+Y=;
        b=MCJkrsuqz+qruGIQnkpiZDAOzHJraanggAHuCr1/5nHiMQ8NOrJwRdyiRGZirtdYtu
         nNGIRN8ndwfUXzATrX0EdXwwvVbMdlEmoI3L4l5LzS/hIs2cU0zHfb+YgWgzX1JJ3epH
         xovvIqFtbiOe0Wi3PGStPmx4kFyEdWwnzhYBG69+PtCBBhOTpi493RtIpgwF5DhVzCQm
         wIDOVJ18FtkGO/eKPG9rN5yAUsFcLdtvyJ1kZvkOXPz72HtsCEhcJEtUBjCZ86pUjqGN
         5JXd5oNFl9F3IpsxUoFlt9ZTcC7O5uYmpYWcW422MzrNBso8/yPpnIIAkNp7hoIZGiHq
         95sQ==
X-Gm-Message-State: AOAM532aNIprO5ZGM5mUgvnLZyXjj838U5yKP67qSXxugxilu5DO2CRq
        HrN0cN4QtfRGoT1RytkxsdcAmg==
X-Google-Smtp-Source: ABdhPJwS77ru0iBcRtRpBrEV7NElV7dd9hCN80VohNjILXD11HDuads3lZ72iDrVfI0mThoLohj1HA==
X-Received: by 2002:a17:90b:1c03:: with SMTP id oc3mr8186678pjb.229.1643197557666;
        Wed, 26 Jan 2022 03:45:57 -0800 (PST)
Received: from localhost.localdomain ([122.167.221.23])
        by smtp.gmail.com with ESMTPSA id nn2sm2994976pjb.35.2022.01.26.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:45:57 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvm-riscv@lists.infradead.org,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 7/8] dt-bindings: Add common bindings for ARM and RISC-V idle states
Date:   Wed, 26 Jan 2022 17:14:51 +0530
Message-Id: <20220126114452.692512-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126114452.692512-1-apatel@ventanamicro.com>
References: <20220126114452.692512-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

The RISC-V CPU idle states will be described in under the
/cpus/idle-states DT node in the same way as ARM CPU idle
states.

This patch adds common bindings documentation for both ARM
and RISC-V idle states.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
 .../devicetree/bindings/arm/psci.yaml         |   2 +-
 .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++++++++++++--
 .../devicetree/bindings/riscv/cpus.yaml       |   6 +
 4 files changed, 219 insertions(+), 19 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
index 6ce0b212ec6d..606b4b1b709d 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
@@ -81,4 +81,4 @@ Example:
 		};
 	};
 
-[1]. Documentation/devicetree/bindings/arm/idle-states.yaml
+[1]. Documentation/devicetree/bindings/cpu/idle-states.yaml
diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 8b77cf83a095..dd83ef278af0 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -101,7 +101,7 @@ properties:
       bindings in [1]) must specify this property.
 
       [1] Kernel documentation - ARM idle states bindings
-        Documentation/devicetree/bindings/arm/idle-states.yaml
+        Documentation/devicetree/bindings/cpu/idle-states.yaml
 
 patternProperties:
   "^power-domain-":
diff --git a/Documentation/devicetree/bindings/arm/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
similarity index 74%
rename from Documentation/devicetree/bindings/arm/idle-states.yaml
rename to Documentation/devicetree/bindings/cpu/idle-states.yaml
index 52bce5dbb11f..95506ffb816c 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.yaml
+++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
@@ -1,25 +1,30 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/idle-states.yaml#
+$id: http://devicetree.org/schemas/cpu/idle-states.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ARM idle states binding description
+title: Idle states binding description
 
 maintainers:
   - Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+  - Anup Patel <anup@brainfault.org>
 
 description: |+
   ==========================================
   1 - Introduction
   ==========================================
 
-  ARM systems contain HW capable of managing power consumption dynamically,
-  where cores can be put in different low-power states (ranging from simple wfi
-  to power gating) according to OS PM policies. The CPU states representing the
-  range of dynamic idle states that a processor can enter at run-time, can be
-  specified through device tree bindings representing the parameters required to
-  enter/exit specific idle states on a given processor.
+  ARM and RISC-V systems contain HW capable of managing power consumption
+  dynamically, where cores can be put in different low-power states (ranging
+  from simple wfi to power gating) according to OS PM policies. The CPU states
+  representing the range of dynamic idle states that a processor can enter at
+  run-time, can be specified through device tree bindings representing the
+  parameters required to enter/exit specific idle states on a given processor.
+
+  ==========================================
+  2 - ARM idle states
+  ==========================================
 
   According to the Server Base System Architecture document (SBSA, [3]), the
   power states an ARM CPU can be put into are identified by the following list:
@@ -43,8 +48,23 @@ description: |+
   The device tree binding definition for ARM idle states is the subject of this
   document.
 
+  ==========================================
+  3 - RISC-V idle states
+  ==========================================
+
+  On RISC-V systems, the HARTs (or CPUs) [6] can be put in platform specific
+  suspend (or idle) states (ranging from simple WFI, power gating, etc). The
+  RISC-V SBI v0.3 (or higher) [7] hart state management extension provides a
+  standard mechanism for OS to request HART state transitions.
+
+  The platform specific suspend (or idle) states of a hart can be either
+  retentive or non-rententive in nature. A retentive suspend state will
+  preserve HART registers and CSR values for all privilege modes whereas
+  a non-retentive suspend state will not preserve HART registers and CSR
+  values.
+
   ===========================================
-  2 - idle-states definitions
+  4 - idle-states definitions
   ===========================================
 
   Idle states are characterized for a specific system through a set of
@@ -211,10 +231,10 @@ description: |+
   properties specification that is the subject of the following sections.
 
   ===========================================
-  3 - idle-states node
+  5 - idle-states node
   ===========================================
 
-  ARM processor idle states are defined within the idle-states node, which is
+  The processor idle states are defined within the idle-states node, which is
   a direct child of the cpus node [1] and provides a container where the
   processor idle states, defined as device tree nodes, are listed.
 
@@ -223,7 +243,7 @@ description: |+
   just supports idle_standby, an idle-states node is not required.
 
   ===========================================
-  4 - References
+  6 - References
   ===========================================
 
   [1] ARM Linux Kernel documentation - CPUs bindings
@@ -238,9 +258,15 @@ description: |+
   [4] ARM Architecture Reference Manuals
       http://infocenter.arm.com/help/index.jsp
 
-  [6] ARM Linux Kernel documentation - Booting AArch64 Linux
+  [5] ARM Linux Kernel documentation - Booting AArch64 Linux
       Documentation/arm64/booting.rst
 
+  [6] RISC-V Linux Kernel documentation - CPUs bindings
+      Documentation/devicetree/bindings/riscv/cpus.yaml
+
+  [7] RISC-V Supervisor Binary Interface (SBI)
+      http://github.com/riscv/riscv-sbi-doc/riscv-sbi.adoc
+
 properties:
   $nodename:
     const: idle-states
@@ -253,7 +279,7 @@ properties:
       On ARM 32-bit systems this property is optional
 
       This assumes that the "enable-method" property is set to "psci" in the cpu
-      node[6] that is responsible for setting up CPU idle management in the OS
+      node[5] that is responsible for setting up CPU idle management in the OS
       implementation.
     const: psci
 
@@ -265,8 +291,8 @@ patternProperties:
       as follows.
 
       The idle state entered by executing the wfi instruction (idle_standby
-      SBSA,[3][4]) is considered standard on all ARM platforms and therefore
-      must not be listed.
+      SBSA,[3][4]) is considered standard on all ARM and RISC-V platforms and
+      therefore must not be listed.
 
       In addition to the properties listed above, a state node may require
       additional properties specific to the entry-method defined in the
@@ -275,7 +301,27 @@ patternProperties:
 
     properties:
       compatible:
-        const: arm,idle-state
+        enum:
+          - arm,idle-state
+          - riscv,idle-state
+
+      arm,psci-suspend-param:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          power_state parameter to pass to the ARM PSCI suspend call.
+
+          Device tree nodes that require usage of PSCI CPU_SUSPEND function
+          (i.e. idle states node with entry-method property is set to "psci")
+          must specify this property.
+
+      riscv,sbi-suspend-param:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          suspend_type parameter to pass to the RISC-V SBI HSM suspend call.
+
+          This property is required in idle state nodes of device tree meant
+          for RISC-V systems. For more details on the suspend_type parameter
+          refer the SBI specifiation v0.3 (or higher) [7].
 
       local-timer-stop:
         description:
@@ -317,6 +363,8 @@ patternProperties:
         description:
           A string used as a descriptive name for the idle state.
 
+    additionalProperties: false
+
     required:
       - compatible
       - entry-latency-us
@@ -658,4 +706,150 @@ examples:
         };
     };
 
+  - |
+    // Example 3 (RISC-V 64-bit, 4-cpu systems, two clusters):
+
+    cpus {
+        #size-cells = <0>;
+        #address-cells = <1>;
+
+        cpu@0 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x0>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
+                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
+
+            cpu_intc0: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        cpu@1 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x1>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
+                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
+
+            cpu_intc1: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        cpu@10 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x10>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
+                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
+
+            cpu_intc10: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        cpu@11 {
+            device_type = "cpu";
+            compatible = "riscv";
+            reg = <0x11>;
+            riscv,isa = "rv64imafdc";
+            mmu-type = "riscv,sv48";
+            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
+                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
+
+            cpu_intc11: interrupt-controller {
+                #interrupt-cells = <1>;
+                compatible = "riscv,cpu-intc";
+                interrupt-controller;
+            };
+        };
+
+        idle-states {
+            CPU_RET_0_0: cpu-retentive-0-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x10000000>;
+                entry-latency-us = <20>;
+                exit-latency-us = <40>;
+                min-residency-us = <80>;
+            };
+
+            CPU_NONRET_0_0: cpu-nonretentive-0-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x90000000>;
+                entry-latency-us = <250>;
+                exit-latency-us = <500>;
+                min-residency-us = <950>;
+            };
+
+            CLUSTER_RET_0: cluster-retentive-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x11000000>;
+                local-timer-stop;
+                entry-latency-us = <50>;
+                exit-latency-us = <100>;
+                min-residency-us = <250>;
+                wakeup-latency-us = <130>;
+            };
+
+            CLUSTER_NONRET_0: cluster-nonretentive-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x91000000>;
+                local-timer-stop;
+                entry-latency-us = <600>;
+                exit-latency-us = <1100>;
+                min-residency-us = <2700>;
+                wakeup-latency-us = <1500>;
+            };
+
+            CPU_RET_1_0: cpu-retentive-1-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x10000010>;
+                entry-latency-us = <20>;
+                exit-latency-us = <40>;
+                min-residency-us = <80>;
+            };
+
+            CPU_NONRET_1_0: cpu-nonretentive-1-0 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x90000010>;
+                entry-latency-us = <250>;
+                exit-latency-us = <500>;
+                min-residency-us = <950>;
+            };
+
+            CLUSTER_RET_1: cluster-retentive-1 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x11000010>;
+                local-timer-stop;
+                entry-latency-us = <50>;
+                exit-latency-us = <100>;
+                min-residency-us = <250>;
+                wakeup-latency-us = <130>;
+            };
+
+            CLUSTER_NONRET_1: cluster-nonretentive-1 {
+                compatible = "riscv,idle-state";
+                riscv,sbi-suspend-param = <0x91000010>;
+                local-timer-stop;
+                entry-latency-us = <600>;
+                exit-latency-us = <1100>;
+                min-residency-us = <2700>;
+                wakeup-latency-us = <1500>;
+            };
+        };
+    };
+
 ...
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index aa5fb64d57eb..f62f646bc695 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -99,6 +99,12 @@ properties:
       - compatible
       - interrupt-controller
 
+  cpu-idle-states:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description: |
+      List of phandles to idle state nodes supported
+      by this hart (see ./idle-states.yaml).
+
 required:
   - riscv,isa
   - interrupt-controller
-- 
2.25.1

