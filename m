Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183624985B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiAXRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:04:29 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56884
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbiAXREW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:04:22 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF6F440012
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643043861;
        bh=5FFlQVfiPYwOVz/qR1ttwGkalvSmqMhuguJRa3JpJFQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=S7ysvmqfZX7/qlSUFp/tkuAuMpZ+ZRmLkoXe7GxpjQa5kcRTm0t5c4y1HR5ZUx2J7
         nlfuA98P503ggMpM0nz+TwGnZzke+mF3LE5gcWjFV7OLXcrD1LFe3xTOIF+NM0jxJf
         waCRLGtrypQICpFwECl/LDZBT6g95fbca4wcKGX4fvK5uHchalFh31mKYCQYvbeKnc
         ZCBH1cbib9e0FEHLj1L2IwIG6Vsw4aTYFE/1DUFoNi/0ILKtW8S9qHVFf/OLh4aAvv
         q0RhTEigz0W/LX3lyvyzAMK9TuTQckmuFbSaJ5JXZnnS0UvlciEJRnCifGBJVb0tJR
         nzjIWYxHT2iGw==
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so9401096eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FFlQVfiPYwOVz/qR1ttwGkalvSmqMhuguJRa3JpJFQ=;
        b=JKiPJ+SFvtfRjZtUI/OKohHB8CW3zrJCJhjh8dcRAcq5WAryJelDUpYsHQoTAEoljj
         KKA1ZnQLFZq5Ae/4YRo608LRsy5W/+DumD/IIQZhTDixVxoEof+Wm7JJ2vBKQiRIq/xh
         Uv15rtdkIjm0rCkfsHq7FnZ+gxT1lHpDZ8YeHj2WjL6nFsCbWnROpsMSp6IkwH1BgKE6
         RiGsrHg0+RPJwbbjl6LsAvEKaRrxlJgiTyaVPRtDYRA8dj+aYcYxRJWzhucucblohUyi
         fjlpKw5ljm5Hdfofaf84HD6Gd3ZhA/bPY4HbbvR9SigzfyHp77EnmLe5EkWaBe9AvNc8
         NqWg==
X-Gm-Message-State: AOAM5336ZhbsiKOhynt0gNORpF4GaN7199sTJnmQ22SGlWVtAimORhlx
        9vwG+4ogsaDUVxz4OYOrGRj8x4scPcB9ZzTBu0LmRSpen7uSGfxOz95n0ZNsjuh8NXvi66Hlm9f
        NPZN5UxxjfQFuZrwgg1199If5qmh4MYn8mYALfP6Gag==
X-Received: by 2002:a17:906:7003:: with SMTP id n3mr13196773ejj.160.1643043861300;
        Mon, 24 Jan 2022 09:04:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSHmcPIiDwaWIhrNLyt3hgJ6DEahlcrBImfV1TaDHD72Fiq6kwC/08hZHQNxbcb99lYE/AuA==
X-Received: by 2002:a17:906:7003:: with SMTP id n3mr13196752ejj.160.1643043861075;
        Mon, 24 Jan 2022 09:04:21 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o11sm6903846edh.75.2022.01.24.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:04:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ASoC: dt-bindings: samsung,arndale: convert to dtschema
Date:   Mon, 24 Jan 2022 18:03:32 +0100
Message-Id: <20220124170336.164320-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
References: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
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

