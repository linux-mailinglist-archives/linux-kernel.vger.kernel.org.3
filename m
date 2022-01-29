Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00A4A2F5F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346728AbiA2MYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:24:44 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32938
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345572AbiA2MYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:24:37 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D4FF73F1D0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643459076;
        bh=aFma7LFfbMy+pdLU8XgqpfQtVODFsB45EwHFjG4cPHo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RCuxcgW+KUeRyLhFSOEFTrmg6B6VRtdisIDeQRW5TqPHMAnxNKqJeLKpqMb7rKlzl
         yX4g4mGfttHR42wdG5pnCLDk843xf1279O2BiwgpbqCa5JTVsVsBd+RYO4swED3nE1
         08t9J7Yam/2jYTja/NpJa+FC8SPfvqABSQt8fb5ffn5lhdryR9rC7i/TmZAk5KExzU
         sctskBNEz6gp558TZWpKkhcNn7XooCkTGk61VgXfcsmB3BXRcYwKt/EfmmkWVSpRQU
         Bg+MRYkdcJden+f9XVKdUJpOF7BfQNLgUdK/BgJW+u3NnuwQlW9CjlUMv2CyXchijL
         hhSstXI7Bz2rg==
Received: by mail-wr1-f70.google.com with SMTP id w7-20020adfbac7000000b001d6f75e4faeso2982258wrg.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFma7LFfbMy+pdLU8XgqpfQtVODFsB45EwHFjG4cPHo=;
        b=ISoZOL+g0iJsZJ43T6Ysg+/V6HaoLCDPr2jB+/R6723juFQGsvobBxYHVUuocy5BYA
         u1qiNXk7QRVdioqzAEER6g8gox8+rklb9cpV843rr8EepW3AqdIOAg9pdmEf/KQ+BQHV
         M8AckKivQtUEK5vLXljzpsvUWmt9+YNbEcdJNTSZDph+TxdMsDpSGKMXBb7QNqJbowUZ
         4X3n0qFZsLb98DMSs3DD3FSX3wDHzB44K1Pzj2yfYHPVPBwsac+lme/PZm9iW6cNSWS9
         5vFq/BmOIPifRk0rhZcZzb29GepLZNzyQs2/649TEdSWOnClr/K26tSewX+ZyQ8xzs5s
         nt2Q==
X-Gm-Message-State: AOAM533FWJ3rSnyeYojYFl93IvIrsbRf24cdryGxuUBvv6oX3k/cYnUw
        rUPH3wuwwquNN7Dwa4Q/b/WV/kmgxfbvYT0ZvnNbf3wtmtBNVP4ykLPEA1AGFDtTdmmVOgMYy3s
        35MkF1qkq4HjTW59hl68K5GVAPKV+EvaQo9MbzGehnA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr10225198wro.684.1643459076553;
        Sat, 29 Jan 2022 04:24:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6uVQv1yZoAqdrgKAJVhPpKtEPV3VRQWrLgTAFRKnvJZBUsYggRfijpP0h3y5+sFPo0x/DpA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr10225189wro.684.1643459076349;
        Sat, 29 Jan 2022 04:24:36 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m28sm1106875wms.34.2022.01.29.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 04:24:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ASoC: dt-bindings: samsung,smdk5250: convert to dtschema
Date:   Sat, 29 Jan 2022 13:24:28 +0100
Message-Id: <20220129122430.45694-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the audio complex on SMDK5250 boards with Samsung Exynos SoC to
DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/sound/samsung,smdk-wm8994.txt    | 14 -------
 .../bindings/sound/samsung,smdk5250.yaml      | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk5250.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
deleted file mode 100644
index 4686646fb122..000000000000
--- a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Samsung SMDK audio complex
-
-Required properties:
-- compatible : "samsung,smdk-wm8994"
-- samsung,i2s-controller: The phandle of the Samsung I2S0 controller
-- samsung,audio-codec: The phandle of the WM8994 audio codec
-Example:
-
-sound {
-		compatible = "samsung,smdk-wm8994";
-
-		samsung,i2s-controller = <&i2s0>;
-		samsung,audio-codec = <&wm8994>;
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung,smdk5250.yaml b/Documentation/devicetree/bindings/sound/samsung,smdk5250.yaml
new file mode 100644
index 000000000000..cb51af90435e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,smdk5250.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,smdk5250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SMDK5250 audio complex with WM8994 codec
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    const: samsung,smdk-wm8994
+
+  samsung,audio-codec:
+    description: Phandle to the audio codec.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  samsung,i2s-controller:
+    description: Phandle to the Samsung I2S controller.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - samsung,audio-codec
+  - samsung,i2s-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "samsung,smdk-wm8994";
+        samsung,i2s-controller = <&i2s0>;
+        samsung,audio-codec = <&wm8994>;
+    };
-- 
2.32.0

