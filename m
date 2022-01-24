Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C54985BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiAXREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:04:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40354
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244105AbiAXRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:04:29 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 484A33F1BE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643043868;
        bh=tXqK0pipG2DbLRjVtcGxzSWNM2TWL5POjuuSkj4vEW8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EWFYGV2p+2GL4wQtsiUJYZHWkg5WIaCg25/EHkxISl4WqWuwZ6RF96X91ANBSj5OJ
         3e4TuIWHer5gF195xw44h4SAQchXPQz0RtWgUMJ/odJSreODXRnFYo34DKkY+GoLy9
         9vK5ESFDeeWy+Z/tvxzRv86vVlj3pLN66WtyU1e5HEOx1l7mATvo0eT0QMZo6jdRM6
         0pPQnBBBLXX1na+5gb5bH22T5xbWi/F5xYNxq26MqlHIbJIqhv6WOeZnLjcPIXfJH2
         nxAVxmSdmZNEsixEosvmyokcdNNGiWmQpgRp6rxQfKteZ7slUIY1crH2am2yhE5nNt
         ZTXxasEtOc8OQ==
Received: by mail-ed1-f70.google.com with SMTP id c23-20020a056402159700b00406aa42973eso6299099edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXqK0pipG2DbLRjVtcGxzSWNM2TWL5POjuuSkj4vEW8=;
        b=phZINltbsQO8dT8D/1XwiG0PJ7qAdLqPXz5NYUXRW7xtBWHoVaElotzalwQmfzR7mh
         MJFulCtHC9j4mdI9TDtjAKimctkb7jaodLo1+1IPzP9lxjJqwCDfTQOdlHi7nHQBuBcq
         AHFMTP8Gmb1MEMzqmpg4jGf/U8KwwZqTt3ElUCQ+KoBO+OjLNwI3P25dAh1oHajO+ugh
         UtqYpaxqxjniWApByzrylQboqnPY56iLS4C0g60MZY5c4bBWqEFWWB+ARWiLhF1bC0xr
         7U2ENdc+7yjcYWGzwQK9gAZ9zv5UO+j1HF1xOKhFGiTfXEZnKaCYho/+MUqkSGIPKK9x
         Nl7A==
X-Gm-Message-State: AOAM532yxmihvm1z7OokqZcIfE/sakJf7m1U9oH/J7hiInVZlA4bVcPV
        B4eRhirTsVQHEI4JvXyfW6DtpxvDCxuHKFf2pRxPn+70MF95TBwPU6XMcqQPKIDFqtMpq9+BxNq
        FU6G2KT9eYCbisIbzTxjCOjq2E47mLq62GYbKDnr7Aw==
X-Received: by 2002:a17:907:62a1:: with SMTP id nd33mr13076917ejc.578.1643043867795;
        Mon, 24 Jan 2022 09:04:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXf92USALcbrXLrv5+/4JqlVrxe0UnW/ZBZv+jrm84Km565mZiaUpixrWAnqJJLbn1fOdrOw==
X-Received: by 2002:a17:907:62a1:: with SMTP id nd33mr13076897ejc.578.1643043867500;
        Mon, 24 Jan 2022 09:04:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o11sm6903846edh.75.2022.01.24.09.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:04:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ASoC: dt-bindings: samsung,tm2: convert to dtschema
Date:   Mon, 24 Jan 2022 18:03:36 +0100
Message-Id: <20220124170336.164320-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
References: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the audio complex on Samsung TM2 boards with Samsung Exynos SoC
to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
 .../bindings/sound/samsung,tm2.yaml           | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
deleted file mode 100644
index f5ccc12ddc00..000000000000
--- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
-
-Required properties:
-
- - compatible		 : "samsung,tm2-audio"
- - model		 : the user-visible name of this sound complex
- - audio-codec		 : the first entry should be phandle of the wm5110 audio
-			   codec node, as described in ../mfd/arizona.txt;
-			   the second entry should be phandle of the HDMI
-			   transmitter node
- - i2s-controller	 : the list of phandle and argument tuples pointing to
-			   I2S controllers, the first entry should be I2S0 and
-			   the second one I2S1
- - audio-amplifier	 : the phandle of the MAX98504 amplifier
- - samsung,audio-routing : a list of the connections between audio components;
-			   each entry is a pair of strings, the first being the
-			   connection's sink, the second being the connection's
-			   source; valid names for sources and sinks are the
-			   WM5110's and MAX98504's pins and the jacks on the
-			   board: HP, SPK, Main Mic, Sub Mic, Third Mic,
-			   Headset Mic
- - mic-bias-gpios	 : GPIO pin that enables the Main Mic bias regulator
-
-
-Example:
-
-sound {
-	compatible = "samsung,tm2-audio";
-	audio-codec = <&wm5110>, <&hdmi>;
-	i2s-controller = <&i2s0 0>, <&i2s1 0>;
-	audio-amplifier = <&max98504>;
-	mic-bias-gpios = <&gpr3 2 0>;
-	model = "wm5110";
-	samsung,audio-routing =
-		"HP", "HPOUT1L",
-		"HP", "HPOUT1R",
-		"SPK", "SPKOUT",
-		"SPKOUT", "HPOUT2L",
-		"SPKOUT", "HPOUT2R",
-		"Main Mic", "MICBIAS2",
-		"IN1R", "Main Mic";
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
new file mode 100644
index 000000000000..74712d6f3ef4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,tm2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    const: samsung,tm2-audio
+
+  audio-amplifier:
+    description: Phandle to the MAX98504 amplifier.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  audio-codec:
+    description: Phandles to the codecs.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to the WM5110 audio codec.
+      - description: Phandle to the HDMI transmitter node.
+
+  samsung,audio-routing:
+    description: |
+      List of the connections between audio components; each entry is
+      a pair of strings, the first being the connection's sink, the second
+      being the connection's source; valid names for sources and sinks are the
+      WM5110's and MAX98504's pins and the jacks on the board: HP, SPK, Main
+      Mic, Sub Mic, Third Mic, Headset Mic.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+
+  i2s-controller:
+    description: Phandles to the I2S controllers.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to I2S0.
+      - description: Phandle to I2S1.
+
+  mic-bias-gpios:
+    description: GPIO pin that enables the Main Mic bias regulator.
+
+  model:
+    description: The user-visible name of this sound complex.
+    $ref: /schemas/types.yaml#/definitions/string
+
+required:
+  - compatible
+  - audio-amplifier
+  - audio-codec
+  - samsung,audio-routing
+  - i2s-controller
+  - mic-bias-gpios
+  - model
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    sound {
+        compatible = "samsung,tm2-audio";
+        audio-codec = <&wm5110>, <&hdmi>;
+        i2s-controller = <&i2s0 0>, <&i2s1 0>;
+        audio-amplifier = <&max98504>;
+        mic-bias-gpios = <&gpr3 2 GPIO_ACTIVE_HIGH>;
+        model = "wm5110";
+        samsung,audio-routing = "HP", "HPOUT1L",
+                                "HP", "HPOUT1R",
+                                "SPK", "SPKOUT",
+                                "SPKOUT", "HPOUT2L",
+                                "SPKOUT", "HPOUT2R",
+                                "RCV", "HPOUT3L",
+                                "RCV", "HPOUT3R";
+    };
-- 
2.32.0

