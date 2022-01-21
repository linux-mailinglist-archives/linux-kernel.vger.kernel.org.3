Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE8496498
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382001AbiAUR4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:56:02 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16]:44017 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiAUR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:56:00 -0500
Date:   Fri, 21 Jan 2022 17:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642787758;
        bh=YiaBJwRSjrUx8z82Haj9JLHse4yRZm0fwjH36xmwLVc=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=qRVa2CU6EIJ44MlRFPrsw3W1s7Tb3OyUV1AlosRA75QCsv5i0Nkbq+os/RZYjZ6tK
         Khmqxb5AsesSJevCjioDR+1gc3dKDEud+weK7xlmpohxL/HMayhOpxb1BW0DbSpZJU
         /pmxTahPOFYBU162fcA7UQgjthc9WEyxiHiBSux32kvrqq3n0+vzLDQNDQMgF0v6QZ
         1R0nnFSRfPU+h1YAahF6oOUfDNYi8ZXk0RyrRFTucQGtUNjZQinAxAzGZXfifsE/1r
         xO9Zdbd9Afu/bNAT2VmHKWB2duyJioaXFOcwruaDTvbjUrHjUqz2oDFydwYUwDJKMs
         l3NeYpG8bUfoA==
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>,
        Rob Herring <robh@kernel.org>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Subject: [PATCH v3 1/3] dt-bindings: clock: Add Apple NCO
Message-ID: <20220121175441.9944-2-povik+lin@protonmail.com>
In-Reply-To: <20220121175441.9944-1-povik+lin@protonmail.com>
References: <20220121175441.9944-1-povik+lin@protonmail.com>
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

The NCO block found on Apple SoCs is a programmable clock generator
performing fractional division of a high frequency input clock.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Povi=C5=A1er <povik+lin@protonmail.com>
---
 .../devicetree/bindings/clock/apple,nco.yaml  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,nco.yaml

diff --git a/Documentation/devicetree/bindings/clock/apple,nco.yaml b/Docum=
entation/devicetree/bindings/clock/apple,nco.yaml
new file mode 100644
index 000000000000..23ee3964fbde
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/apple,nco.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/apple,nco.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoCs' NCO block
+
+maintainers:
+  - Martin Povi=C5=A1er <povik+lin@protonmail.com>
+
+description: |
+  The NCO (Numerically Controlled Oscillator) block found on Apple SoCs
+  such as the t8103 (M1) is a programmable clock generator performing
+  fractional division of a high frequency input clock.
+
+  It carries a number of independent channels and is typically used for
+  generation of audio bitclocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t6000-nco
+          - apple,t8103-nco
+      - const: apple,nco
+
+  clocks:
+    description:
+      Specifies the reference clock from which the output clocks
+      are derived through fractional division.
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    nco_clkref: clock-ref {
+      compatible =3D "fixed-clock";
+      #clock-cells =3D <0>;
+      clock-frequency =3D <900000000>;
+      clock-output-names =3D "nco-ref";
+    };
+
+    nco: clock-controller@23b044000 {
+      compatible =3D "apple,t8103-nco", "apple,nco";
+      reg =3D <0x3b044000 0x14000>;
+      #clock-cells =3D <1>;
+      clocks =3D <&nco_clkref>;
+    };
--
2.33.0


