Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956D34985B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbiAXREw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:04:52 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56922
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244092AbiAXRE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:04:26 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4E68A40045
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643043865;
        bh=aFma7LFfbMy+pdLU8XgqpfQtVODFsB45EwHFjG4cPHo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qmdjNcFbBKU9NJhyE9s+u0X5mL1uIxQbmkkC65ihCxeMedg6xNwISTlZOMCkhUKJz
         2+SeK/7QSsn/vPoQE+iR6luAK34KObLp0JxdNkkY2p/rVcZ47lN5S/ye/7iK1abp6Y
         jFA9k9iBPFEkSHpD0tfXT8/keFRmTtAVkuXjl55w8HNGLBRP6wuLePReiuvySIvkYq
         IGm8ZMu01DfPVypZxwbEWr2VvJvbpip98dnIf464c8eq9z94MN0EbO9PM/qxY3AfHG
         /BpuEvn6NEEYg8bX3wd8al05nJrIuzqqbClrjsPAAVfenJC5pGR6z5NT1ZrVVn2Lew
         0Mwm1o7GcS07Q==
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so13475753edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFma7LFfbMy+pdLU8XgqpfQtVODFsB45EwHFjG4cPHo=;
        b=Xs8urJo33A44ve7104Y2oJijgihIihf1ELQN32pdZfMqu3imV4rTwSv926bSKyIEUi
         XrBF97hzaVyYh8ft1gahDWwO+vc/6XidruCcbnAHGQX1LLCTCnia50K5jxjH5W7KXHoo
         t9h0eLs07fC9O/F1hhuanY9N4TCArx4dVmTHTsY8rYeYqFcoMKYY3HLnXczfq5czJSzK
         s6wc3IPz6nmFxwytW2yjOaViir2BKYG6Kv//CbUhlRn/W4F++1tb6llxTZ8+xfgTfOTJ
         azsU/apb69lDtddNCYAxDwM8ZUdQPGFB8s88QfbEvbbJHjX6rx3pxffuEEGOpl5mf2cl
         m8Gg==
X-Gm-Message-State: AOAM531Wqrq8lozwXwJ0Lm9YDB4lpwwAVfBsAyb9qRdUE0G4eFd7ILVz
        725NF8bF1j0PnBdk1NcKgMp//llAqq32CAJhkDXJ8Sn1cKhz6wwrOayvlG2mjmA7KnGUR9LQg2s
        vVkHhj3PQUS3/9AgNWHhkom5ICX9dhAL4jLpOv775Qw==
X-Received: by 2002:a17:907:160d:: with SMTP id hb13mr2478837ejc.609.1643043864499;
        Mon, 24 Jan 2022 09:04:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8dy0UNUYy8V7YlFigpm3/abtk7yXYoxh8/7MuNjbTZltb26qnfPnsmVYy3oKPQLI1sLWBSA==
X-Received: by 2002:a17:907:160d:: with SMTP id hb13mr2478820ejc.609.1643043864305;
        Mon, 24 Jan 2022 09:04:24 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o11sm6903846edh.75.2022.01.24.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 09:04:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ASoC: dt-bindings: samsung,smdk5250: convert to dtschema
Date:   Mon, 24 Jan 2022 18:03:34 +0100
Message-Id: <20220124170336.164320-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
References: <20220124170336.164320-1-krzysztof.kozlowski@canonical.com>
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

