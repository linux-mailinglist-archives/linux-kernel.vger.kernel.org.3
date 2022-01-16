Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6E48FF3B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 22:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiAPVjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 16:39:42 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:33522 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiAPVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 16:39:36 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:fcd:c16e:b544:6e84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 769DB292934;
        Sun, 16 Jan 2022 22:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1642369174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xSjeUcm7m23N21sPciuCTuwHGXybr2E95NnShlF2kA=;
        b=Y3R/n2t7NSzW3w/UqS31gbOEom9LPcFy+GI4U1fzulMl4pwSpEh4i731rdjKK/iMGvd4Is
        xPKcp6t3QRUuhQd1e75FHalkmYsuUBrYpUpataxPFDAUq2tlx8cjzL17DhQovZNFjlQnel
        Vq0DSaQb5DE4BSOYiJavII3isDqCGm11eWfHAR+25A07lIgJbMeX7TOyQzCe7CHpcoPz4G
        c3tstg2QcEjFzbC1CTaxmTasUJdsmu32qZDTGGFOPOJ7mSbQ6pLMsTc0s1zvhd5bXWj2xO
        bYca8IVhY0tnACvscwF1W8KVTOZTwY98HAb8lvaUFWU3f1jPKdxr549GhG1D1g==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 1/2] dt-bindings: timer: Add realtek,otto-tc binding
Date:   Sun, 16 Jan 2022 22:39:24 +0100
Message-Id: <7c53821386b8f4c1c0ac440f1cd186e09f4a0456.1642369117.git.sander@svanheule.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642369117.git.sander@svanheule.net>
References: <cover.1642369117.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New binding for the timer/counter blocks found on the Realtek Otto MIPS
platform.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 .../bindings/timer/realtek,otto-tc.yaml       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml

diff --git a/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml b/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
new file mode 100644
index 000000000000..12971b9ecdf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,otto-tc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/realtek,otto-tc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek Otto platform timer/counter bindings
+
+description:
+  "Up-counting 28-bit timer that can operate in oneshot or repeating mode,
+  providing an interrupt at roll-over.
+
+  The timer is driven by a divided clock, derived from the bus clock. The clock
+  divisor is configurable from 2 to 65535. Divisor values of 0 and 1 disable
+  the timer clock. The timer can also be enabled or disabled independently from
+  the clock (divisor) selection.
+
+  The number of timers supported by the different SoC families is:
+  - RTL8380: 5 timers
+  - RTL8390: 5 timers
+  - RTL9300: 6 timers
+  - RTL9310: 7 timers"
+
+maintainers:
+  - Sander Vanheule <sander@svanheule.net>
+
+properties:
+  compatible:
+    const: realtek,otto-tc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Parent clock from peripheral bus
+
+  clock-names:
+    items:
+      - const: bus
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    timer0: timer@3100 {
+      compatible = "realtek,otto-tc";
+      reg = <0x3100 0x10>;
+
+      interrupts = <29 4>;
+
+      clocks = <&lx_clk>;
+      clock-names = "bus";
+    };
-- 
2.34.1

