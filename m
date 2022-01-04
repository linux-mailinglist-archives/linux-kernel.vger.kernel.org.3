Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB04484284
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiADNaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:30:12 -0500
Received: from mail-40138.protonmail.ch ([185.70.40.138]:57813 "EHLO
        mail-40138.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiADNaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:30:10 -0500
X-Greylist: delayed 35665 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 08:30:10 EST
Date:   Tue, 04 Jan 2022 13:30:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641303007;
        bh=97wQXlXCtKxla8N9kEZKHjtHuhTiUUceuubpdXxdQlE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=LDRKuJNWQ20PFqsyTBaQ2KHQLuPU2iwF9y5mFv+5qNFWAhRsTTQpjfW8TkzW208em
         5rv0ScS2Z0nukb4i9/bj5gUU9KjBBdopPnSs1TS/ZPtkRsfVHy75G71Wl/gQJ/+XaO
         eecdkN9CdYI4t7jFuh1BAqcnaLBieDsuj5s7P/pecvcqDo4/bVtqHK+scAsRL2xObA
         8CrtgWdkE1piFMdAmYNdI5tbtCiU5p+ZY6SXz7po6xYHkh323uAzFRgB9DYlR+pHt5
         Ig5Na+StKG6ulKzjNuZS72dui7icK47x5t4OMghhfBggyvptDycPB2P3M/OuYrJu1L
         gKDiUg686QxBg==
To:     Rob Herring <robh+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 7/7] dt-bindings: power: avs: qcom,cpr: Convert to DT schema
Message-ID: <20220104132618.391799-8-y.oudjana@protonmail.com>
In-Reply-To: <20220104132618.391799-1-y.oudjana@protonmail.com>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom,cpr.txt to DT schema format.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Changes since v1:
 - Remove allOf from compatible.

 .../bindings/power/avs/qcom,cpr.txt           | 130 --------------
 .../bindings/power/avs/qcom,cpr.yaml          | 160 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 161 insertions(+), 131 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.tx=
t
 create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.ya=
ml

diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Doc=
umentation/devicetree/bindings/power/avs/qcom,cpr.txt
deleted file mode 100644
index ab0d5ebbad4e..000000000000
--- a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
+++ /dev/null
@@ -1,130 +0,0 @@
-QCOM CPR (Core Power Reduction)
-
-CPR (Core Power Reduction) is a technology to reduce core power on a CPU
-or other device. Each OPP of a device corresponds to a "corner" that has
-a range of valid voltages for a particular frequency. While the device is
-running at a particular frequency, CPR monitors dynamic factors such as
-temperature, etc. and suggests adjustments to the voltage to save power
-and meet silicon characteristic requirements.
-
-- compatible:
-=09Usage: required
-=09Value type: <string>
-=09Definition: should be "qcom,qcs404-cpr", "qcom,cpr" for qcs404
-
-- reg:
-=09Usage: required
-=09Value type: <prop-encoded-array>
-=09Definition: base address and size of the rbcpr register region
-
-- interrupts:
-=09Usage: required
-=09Value type: <prop-encoded-array>
-=09Definition: should specify the CPR interrupt
-
-- clocks:
-=09Usage: required
-=09Value type: <prop-encoded-array>
-=09Definition: phandle to the reference clock
-
-- clock-names:
-=09Usage: required
-=09Value type: <stringlist>
-=09Definition: must be "ref"
-
-- vdd-apc-supply:
-=09Usage: required
-=09Value type: <phandle>
-=09Definition: phandle to the vdd-apc-supply regulator
-
-- #power-domain-cells:
-=09Usage: required
-=09Value type: <u32>
-=09Definition: should be 0
-
-- operating-points-v2:
-=09Usage: required
-=09Value type: <phandle>
-=09Definition: A phandle to the OPP table containing the
-=09=09    performance states supported by the CPR
-=09=09    power domain
-
-- acc-syscon:
-=09Usage: optional
-=09Value type: <phandle>
-=09Definition: phandle to syscon for writing ACC settings
-
-- nvmem-cells:
-=09Usage: required
-=09Value type: <phandle>
-=09Definition: phandle to nvmem cells containing the data
-=09=09    that makes up a fuse corner, for each fuse corner.
-=09=09    As well as the CPR fuse revision.
-
-- nvmem-cell-names:
-=09Usage: required
-=09Value type: <stringlist>
-=09Definition: should be "cpr_quotient_offset1", "cpr_quotient_offset2",
-=09=09    "cpr_quotient_offset3", "cpr_init_voltage1",
-=09=09    "cpr_init_voltage2", "cpr_init_voltage3", "cpr_quotient1",
-=09=09    "cpr_quotient2", "cpr_quotient3", "cpr_ring_osc1",
-=09=09    "cpr_ring_osc2", "cpr_ring_osc3", "cpr_fuse_revision"
-=09=09    for qcs404.
-
-Example:
-
-=09cpr_opp_table: cpr-opp-table {
-=09=09compatible =3D "operating-points-v2-qcom-level";
-
-=09=09cpr_opp1: opp1 {
-=09=09=09opp-level =3D <1>;
-=09=09=09qcom,opp-fuse-level =3D <1>;
-=09=09};
-=09=09cpr_opp2: opp2 {
-=09=09=09opp-level =3D <2>;
-=09=09=09qcom,opp-fuse-level =3D <2>;
-=09=09};
-=09=09cpr_opp3: opp3 {
-=09=09=09opp-level =3D <3>;
-=09=09=09qcom,opp-fuse-level =3D <3>;
-=09=09};
-=09};
-
-=09power-controller@b018000 {
-=09=09compatible =3D "qcom,qcs404-cpr", "qcom,cpr";
-=09=09reg =3D <0x0b018000 0x1000>;
-=09=09interrupts =3D <0 15 IRQ_TYPE_EDGE_RISING>;
-=09=09clocks =3D <&xo_board>;
-=09=09clock-names =3D "ref";
-=09=09vdd-apc-supply =3D <&pms405_s3>;
-=09=09#power-domain-cells =3D <0>;
-=09=09operating-points-v2 =3D <&cpr_opp_table>;
-=09=09acc-syscon =3D <&tcsr>;
-
-=09=09nvmem-cells =3D <&cpr_efuse_quot_offset1>,
-=09=09=09<&cpr_efuse_quot_offset2>,
-=09=09=09<&cpr_efuse_quot_offset3>,
-=09=09=09<&cpr_efuse_init_voltage1>,
-=09=09=09<&cpr_efuse_init_voltage2>,
-=09=09=09<&cpr_efuse_init_voltage3>,
-=09=09=09<&cpr_efuse_quot1>,
-=09=09=09<&cpr_efuse_quot2>,
-=09=09=09<&cpr_efuse_quot3>,
-=09=09=09<&cpr_efuse_ring1>,
-=09=09=09<&cpr_efuse_ring2>,
-=09=09=09<&cpr_efuse_ring3>,
-=09=09=09<&cpr_efuse_revision>;
-=09=09nvmem-cell-names =3D "cpr_quotient_offset1",
-=09=09=09"cpr_quotient_offset2",
-=09=09=09"cpr_quotient_offset3",
-=09=09=09"cpr_init_voltage1",
-=09=09=09"cpr_init_voltage2",
-=09=09=09"cpr_init_voltage3",
-=09=09=09"cpr_quotient1",
-=09=09=09"cpr_quotient2",
-=09=09=09"cpr_quotient3",
-=09=09=09"cpr_ring_osc1",
-=09=09=09"cpr_ring_osc2",
-=09=09=09"cpr_ring_osc3",
-=09=09=09"cpr_fuse_revision";
-=09};
diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml b/Do=
cumentation/devicetree/bindings/power/avs/qcom,cpr.yaml
new file mode 100644
index 000000000000..3301fa0c2653
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/avs/qcom,cpr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Core Power Reduction (CPR) bindings
+
+maintainers:
+  - Niklas Cassel <nks@flawful.org>
+
+description: |
+  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
+  or other device. Each OPP of a device corresponds to a "corner" that has
+  a range of valid voltages for a particular frequency. While the device i=
s
+  running at a particular frequency, CPR monitors dynamic factors such as
+  temperature, etc. and suggests adjustments to the voltage to save power
+  and meet silicon characteristic requirements.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,qcs404-cpr
+      - const: qcom,cpr
+
+  reg:
+    description: Base address and size of the RBCPR register region.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Reference clock.
+
+  clock-names:
+    items:
+      - const: ref
+
+  vdd-apc-supply:
+    description: APC regulator supply.
+
+  '#power-domain-cells':
+    const: 0
+
+  operating-points-v2:
+    description: |
+      A phandle to the OPP table containing the performance states
+      supported by the CPR power domain.
+
+  acc-syscon:
+    description: A phandle to the syscon used for writing ACC settings.
+
+  nvmem-cells:
+    items:
+      - description: Corner 1 quotient offset
+      - description: Corner 2 quotient offset
+      - description: Corner 3 quotient offset
+      - description: Corner 1 initial voltage
+      - description: Corner 2 initial voltage
+      - description: Corner 3 initial voltage
+      - description: Corner 1 quotient
+      - description: Corner 2 quotient
+      - description: Corner 3 quotient
+      - description: Corner 1 ring oscillator
+      - description: Corner 2 ring oscillator
+      - description: Corner 3 ring oscillator
+      - description: Fuse revision
+
+  nvmem-cell-names:
+    items:
+      - const: cpr_quotient_offset1
+      - const: cpr_quotient_offset2
+      - const: cpr_quotient_offset3
+      - const: cpr_init_voltage1
+      - const: cpr_init_voltage2
+      - const: cpr_init_voltage3
+      - const: cpr_quotient1
+      - const: cpr_quotient2
+      - const: cpr_quotient3
+      - const: cpr_ring_osc1
+      - const: cpr_ring_osc2
+      - const: cpr_ring_osc3
+      - const: cpr_fuse_revision
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - vdd-apc-supply
+  - '#power-domain-cells'
+  - operating-points-v2
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cpr_opp_table: opp-table-cpr {
+        compatible =3D "operating-points-v2-qcom-level";
+
+        cpr_opp1: opp1 {
+            opp-level =3D <1>;
+            qcom,opp-fuse-level =3D <1>;
+        };
+        cpr_opp2: opp2 {
+            opp-level =3D <2>;
+            qcom,opp-fuse-level =3D <2>;
+        };
+        cpr_opp3: opp3 {
+            opp-level =3D <3>;
+            qcom,opp-fuse-level =3D <3>;
+        };
+    };
+
+    power-controller@b018000 {
+        compatible =3D "qcom,qcs404-cpr", "qcom,cpr";
+        reg =3D <0x0b018000 0x1000>;
+        interrupts =3D <0 15 IRQ_TYPE_EDGE_RISING>;
+        clocks =3D <&xo_board>;
+        clock-names =3D "ref";
+        vdd-apc-supply =3D <&pms405_s3>;
+        #power-domain-cells =3D <0>;
+        operating-points-v2 =3D <&cpr_opp_table>;
+        acc-syscon =3D <&tcsr>;
+
+        nvmem-cells =3D <&cpr_efuse_quot_offset1>,
+            <&cpr_efuse_quot_offset2>,
+            <&cpr_efuse_quot_offset3>,
+            <&cpr_efuse_init_voltage1>,
+            <&cpr_efuse_init_voltage2>,
+            <&cpr_efuse_init_voltage3>,
+            <&cpr_efuse_quot1>,
+            <&cpr_efuse_quot2>,
+            <&cpr_efuse_quot3>,
+            <&cpr_efuse_ring1>,
+            <&cpr_efuse_ring2>,
+            <&cpr_efuse_ring3>,
+            <&cpr_efuse_revision>;
+        nvmem-cell-names =3D "cpr_quotient_offset1",
+            "cpr_quotient_offset2",
+            "cpr_quotient_offset3",
+            "cpr_init_voltage1",
+            "cpr_init_voltage2",
+            "cpr_init_voltage3",
+            "cpr_quotient1",
+            "cpr_quotient2",
+            "cpr_quotient3",
+            "cpr_ring_osc1",
+            "cpr_ring_osc2",
+            "cpr_ring_osc3",
+            "cpr_fuse_revision";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8a024490a1f8..e365a6903787 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15889,7 +15889,7 @@ M:=09Niklas Cassel <nks@flawful.org>
 L:=09linux-pm@vger.kernel.org
 L:=09linux-arm-msm@vger.kernel.org
 S:=09Maintained
-F:=09Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
+F:=09Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
 F:=09drivers/soc/qcom/cpr.c
=20
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
--=20
2.34.1


