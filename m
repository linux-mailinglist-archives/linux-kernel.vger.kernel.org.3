Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8486D4A2F58
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbiA2MYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:24:37 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54118
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242638AbiA2MYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:24:35 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1DAB23F17B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643459074;
        bh=5FFlQVfiPYwOVz/qR1ttwGkalvSmqMhuguJRa3JpJFQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hsHOsLMG3aed4NV0oYPPTfgR/lCkwJvnTUrQA6BzwuCvIIVuExMaMpDM4jOYOOyp6
         18pxFrxbTk9o/mACp8mX8HMbs6cNc7Xd3pSZ8STLCQ47NiSHyR6R5OgcfexNTQ+uqE
         85uqp3fidMofVOOLy4Alu5153YcyaeKoDm1bne0R8bwsLwMauQX60QD5rmqfeR85nq
         oLZVPNBtAma3k3UR1k7SGBwHwg0c9HzwSMKVGxJfd70HDnjoFdV4hYWB7iQsh2tXOy
         AN9cz1X4HX9FB/yy3LGxBW1KGIp7vbvYFr4mR4buNCwNCxGjAhgbAdP0lw6pk5+ck7
         1vAQNGvPMEjVQ==
Received: by mail-wm1-f70.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so4231071wmi.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FFlQVfiPYwOVz/qR1ttwGkalvSmqMhuguJRa3JpJFQ=;
        b=RdikyoEpHrreaA3SeyXlT4dGVSbi27EvPqK3qrCBvQGnFto1Oge0se86f1rgr+DrPI
         3/cgPItl++UfNQoxj8u0oKhWl4dLZaQTQzhseoisVa0PVfMzyDQEZ8IvpbiardBRb/1M
         nZJaPsT/D6BGUVlEdyZMXu+hHebo1IR1Z/8FMcsAbxfkaCwTWqmkS/PDg84Mk+6FsGJf
         80xt4c+a9XOJDqfc7qi0gUWyV7TKu/P2tOAHvYhRyLR90sXWERPrDWvP1OAVX85nzHlp
         0jJaSAwTu0Wup8iK8aWiK78gTxppds+fpxFOfxciiDZs8ZKge4lGemuXqSI5WP+nXQK+
         xBog==
X-Gm-Message-State: AOAM5305YnLT91R8OxMtozWOYFcLsMGuc+/K5khJSFIoiuUhhpGonK9p
        uzs6puLxEoFxA+UmYGVjdFxpbSPFVXGZe8t9VoXAyGqHtwpjhkl7CcaPPQRz/DvgH7vhaTjuaKA
        1/F+6xNlqV7/ZJD2zXS+ZWFY+H5sPsIz11oXGxM9wgQ==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr10041190wrp.216.1643459073802;
        Sat, 29 Jan 2022 04:24:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxe6dsREF4mKdGOp2shKuhk+vTGgCTqdm3WOG32IIYdm9aRaZQctbPT/4EIxznruMFid33Pw==
X-Received: by 2002:adf:f64e:: with SMTP id x14mr10041176wrp.216.1643459073650;
        Sat, 29 Jan 2022 04:24:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m28sm1106875wms.34.2022.01.29.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 04:24:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ASoC: dt-bindings: samsung,arndale: convert to dtschema
Date:   Sat, 29 Jan 2022 13:24:26 +0100
Message-Id: <20220129122430.45694-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the audio complex on Arndale boards with Samsung Exynos SoC to
DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/sound/arndale.txt     | 25 -----------
 .../bindings/sound/samsung,arndale.yaml       | 44 +++++++++++++++++++
 2 files changed, 44 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/arndale.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,arndale.yaml

diff --git a/Documentation/devicetree/bindings/sound/arndale.txt b/Documentation/devicetree/bindings/sound/arndale.txt
deleted file mode 100644
index 17530120ccfc..000000000000
--- a/Documentation/devicetree/bindings/sound/arndale.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Audio Binding for Arndale boards
-
-Required properties:
-- compatible : Can be one of the following:
-		"samsung,arndale-rt5631",
-		"samsung,arndale-wm1811"
-
-- samsung,audio-cpu: The phandle of the Samsung I2S controller
-- samsung,audio-codec: The phandle of the audio codec
-
-Optional:
-- samsung,model: The name of the sound-card
-
-Arndale Boards has many audio daughter cards, one of them is
-rt5631/alc5631. Below example shows audio bindings for rt5631/
-alc5631 based codec.
-
-Example:
-
-sound {
-		compatible = "samsung,arndale-rt5631";
-
-		samsung,audio-cpu = <&i2s0>
-		samsung,audio-codec = <&rt5631>;
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung,arndale.yaml b/Documentation/devicetree/bindings/sound/samsung,arndale.yaml
new file mode 100644
index 000000000000..e7dc65637f02
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,arndale.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,arndale.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Insignal Arndale boards audio complex
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,arndale-rt5631
+      - samsung,arndale-wm1811
+
+  samsung,audio-codec:
+    description: Phandle to the audio codec.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,audio-cpu:
+    description: Phandle to the Samsung I2S controller.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,model:
+    description: The user-visible name of this sound complex.
+    $ref: /schemas/types.yaml#/definitions/string
+
+required:
+  - compatible
+  - samsung,audio-codec
+  - samsung,audio-cpu
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "samsung,arndale-rt5631";
+        samsung,audio-cpu = <&i2s0>;
+        samsung,audio-codec = <&rt5631>;
+    };
-- 
2.32.0

