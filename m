Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696C94A2F60
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiA2MYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:24:47 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32950
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345634AbiA2MYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:24:39 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C6DB3F1D0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643459078;
        bh=bD5z5ffYf36ZpADiFx82Y+cqZ1Jq4IWx6Gvq+Okhbqw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=a8PXgV6iaqq9y6n1Wn1VxbzYagq3gX3g0YmpRwyKt6VsvtBpvikpVtMrpfHWa0aNO
         FwiJ2MWLxY2g606nEbnGlPFBKbd9YpfGa/TT3bRnoIQu3sP4JYkB3cM+MUl+82oizp
         zohLjQyh3+9Rh9glO0Fnd1RgmS7Uzknf2Twq5rakzI8MVBW4FWi4YqI/NPv100fDsp
         wGHVyp4htoNg/HnYSb2i/XoamWGpw/j0fRXru2LM/Fq+dSur7reldJxe+X4w+miuF+
         7xAKZW7c22o072NLTNacf+KenMIQnlAA6EhWPSU5Yp+F0UGEp7zVM3Hxb9xOS8VQHM
         k6NyEFsita4fg==
Received: by mail-wm1-f72.google.com with SMTP id r82-20020a1c4455000000b00352cf8b74dcso150479wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bD5z5ffYf36ZpADiFx82Y+cqZ1Jq4IWx6Gvq+Okhbqw=;
        b=Tnus56adFMvGKn4xV4SBYblLCpYW6AtXrezz0KQVo+sWoIC3rFGJe3r69IkvWt3lVJ
         LlpwhDZEu/oj+pxR4ELc94UZRWUPO3y8Be37Cf62FsM8cg7tT3zEdoFP5UL1WQIRF9HY
         pqFqDc9SRuqATTVQNyldKGvbkTkol9+5Glc0P407T/qf9p2HJrsl/s+tF835yDVMRhYW
         XpJ5MKOPro+eH75/ST5GnV0IEunPItcwOtuxoZO5NQucKdtLsQznlv9PY7kb13eWlvkt
         dqkaKNVFkbAPe2dh23II5G9MKxAhO4ff7aRmWETlwwpL86fQ4aclVx+xSbGcuURgo6Ft
         ZNbw==
X-Gm-Message-State: AOAM531Pf4LFx9esHAJ6HQHzFcXMw6J7rqrf5uzuGTA5Ra78EInECEln
        Y8GWQkTlnRQa1FfxlXdhEeq5ARvIRhmOXxThLEK7is+AIQiHagukBFY45ALHbrj6Y8tc6VxB4F2
        5fVPoKFCGHlIjr7kyiUYWxexTomt+owX+jrH6lj3Wfg==
X-Received: by 2002:a05:600c:3c9:: with SMTP id z9mr11015919wmd.148.1643459077821;
        Sat, 29 Jan 2022 04:24:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPb7GAtVKBWV4J0Pm7ej5eDXtc7ns7KfzMdGQW666plXAAi8bJ6GsApeCPfihWqlNq7cTw2A==
X-Received: by 2002:a05:600c:3c9:: with SMTP id z9mr11015910wmd.148.1643459077657;
        Sat, 29 Jan 2022 04:24:37 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m28sm1106875wms.34.2022.01.29.04.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 04:24:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ASoC: dt-bindings: samsung,snow: convert to dtschema
Date:   Sat, 29 Jan 2022 13:24:29 +0100
Message-Id: <20220129122430.45694-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the audio complex on Google Snow boards with Samsung Exynos SoC
to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/sound/samsung,snow.yaml          | 74 +++++++++++++++++++
 .../devicetree/bindings/sound/snow.txt        | 31 --------
 2 files changed, 74 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,snow.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/snow.txt

diff --git a/Documentation/devicetree/bindings/sound/samsung,snow.yaml b/Documentation/devicetree/bindings/sound/samsung,snow.yaml
new file mode 100644
index 000000000000..0c3b3302b842
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,snow.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,snow.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Snow audio complex with MAX9809x codec
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    enum:
+      - google,snow-audio-max98090
+      - google,snow-audio-max98091
+      - google,snow-audio-max98095
+
+  codec:
+    type: object
+    properties:
+      sound-dai:
+        description: List of phandles to the CODEC and HDMI IP nodes.
+        items:
+          - description: Phandle to the MAX98090, MAX98091 or MAX98095 CODEC.
+          - description: Phandle to the HDMI IP block node.
+    required:
+      - sound-dai
+
+  cpu:
+    type: object
+    properties:
+      sound-dai:
+        description: Phandle to the Samsung I2S controller.
+        maxItems: 1
+    required:
+      - sound-dai
+
+  samsung,audio-codec:
+    description: Phandle to the audio codec.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
+
+  samsung,i2s-controller:
+    description: Phandle to the Samsung I2S controller.
+    $ref: /schemas/types.yaml#/definitions/phandle
+    deprecated: true
+
+  samsung,model:
+    description: The user-visible name of this sound complex.
+    $ref: /schemas/types.yaml#/definitions/string
+
+required:
+  - compatible
+  - codec
+  - cpu
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "google,snow-audio-max98095";
+        samsung,model = "Snow-I2S-MAX98095";
+
+        cpu {
+            sound-dai = <&i2s0 0>;
+        };
+
+        codec {
+            sound-dai = <&max98095 0>, <&hdmi>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/snow.txt b/Documentation/devicetree/bindings/sound/snow.txt
deleted file mode 100644
index 80fd9a87bb3f..000000000000
--- a/Documentation/devicetree/bindings/sound/snow.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Audio Binding for Snow boards
-
-Required properties:
-- compatible : Can be one of the following,
-			"google,snow-audio-max98090" or
-			"google,snow-audio-max98091" or
-			"google,snow-audio-max98095"
-- samsung,i2s-controller (deprecated): The phandle of the Samsung I2S controller
-- samsung,audio-codec (deprecated): The phandle of the audio codec
-
-Required sub-nodes:
-
- - 'cpu' subnode with a 'sound-dai' property containing the phandle of the I2S
-    controller
- - 'codec' subnode with a 'sound-dai' property containing list of phandles
-    to the CODEC nodes, first entry must be the phandle of the MAX98090,
-    MAX98091 or MAX98095 CODEC (exact device type is indicated by the compatible
-    string) and the second entry must be the phandle of the HDMI IP block node
-
-Optional:
-- samsung,model: The name of the sound-card
-
-Example:
-
-sound {
-		compatible = "google,snow-audio-max98095";
-
-		samsung,model = "Snow-I2S-MAX98095";
-		samsung,i2s-controller = <&i2s0>;
-		samsung,audio-codec = <&max98095>;
-};
-- 
2.32.0

