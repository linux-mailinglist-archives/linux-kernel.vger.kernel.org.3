Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6BC47934C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbhLQR6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbhLQR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:07 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F647C06173E;
        Fri, 17 Dec 2021 09:58:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id k37so6299811lfv.3;
        Fri, 17 Dec 2021 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B10/DVlO3DNsnWTrb5zfh6CpHUm8NxkT51bMpGLaM+c=;
        b=Z9Pva736dbKy/rOtsePTw7Xth8b3Lg3wqHgEYOO2gg0DYuezuwlJtF51rIxsJ7Fbnw
         LGB3DV4NVssVDFZCiFxxKfB1tiE0JWGyLsXngQCqnqz/IPEG99n/bKTNbcOYtLfpyjIY
         LGp8l/ZOrW+gFktdcMPq3Rj6l1Dr56MR72X3atHoridzffcqFYMLUVjMFGdIkq3MBxuu
         g3js8GcgDvBnvr8QofIZKicUZBsjRCZU5mPqSh6NjIelJB+8Wx1rOQzibEMUxz/NeY2t
         Qrs20DzJk8DgSrt/jLK6UakPCgHl9gA7p6P7pPLZ+zMf8YUlQYUXC2h4hyiF1PbxTW5J
         q1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B10/DVlO3DNsnWTrb5zfh6CpHUm8NxkT51bMpGLaM+c=;
        b=fI7dGRlCdFteEjGBkZblQslfQ3pFzxOagZJNAp5clFazC/AyTKojPr0aTZrVUktXAb
         PvQvaJJ7quG1engoPlzw1uKiwbaCUCcW4QnRWhHauUE8gwaCb2ePX49zUFHJOda1isCK
         1pnBymdfDOeGjSZboJGWrbEHBBobAI+2mBddrTjr8xJBOLQ5ojeJEQ9w2HLRGCEuyRjs
         jqrgj1I9YCPAyIvRL3K+GCb7vwqdiTi3EbsimYswlde7kdJ07CyCjXOCk0gZFblyTldv
         q1lX2xF/zVQyrdPFe+/1+9U9ra7feGodwca6B44jPsr2j/ikkb9PgV3PEMAnRTsdnF61
         aWqQ==
X-Gm-Message-State: AOAM532vZSi9IVu41gn/AJgkFZIGkDmyF421zlKy0K1pz85jj/BQML2I
        7Ji8Ugi2X5BC0meVOg8UtXw=
X-Google-Smtp-Source: ABdhPJzIDoIHo8AsB3EFB9eSksV0BQgYDEVpLjZQEglYFnulSrS5VzlTtEYKH8rFNpDfkaj/f+ZS8A==
X-Received: by 2002:a05:6512:1047:: with SMTP id c7mr1147851lfb.2.1639763885445;
        Fri, 17 Dec 2021 09:58:05 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 02/11] ASoC: dt-bindings: tegra20-i2s: Convert to schema
Date:   Fri, 17 Dec 2021 20:55:57 +0300
Message-Id: <20211217175606.22645-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert NVIDIA Tegra20 I2S binding to schema.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/sound/nvidia,tegra20-i2s.txt     | 30 --------
 .../bindings/sound/nvidia,tegra20-i2s.yaml    | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
deleted file mode 100644
index dc30c6bfbe95..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-NVIDIA Tegra 20 I2S controller
-
-Required properties:
-- compatible : "nvidia,tegra20-i2s"
-- reg : Should contain I2S registers location and length
-- interrupts : Should contain I2S interrupt
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - i2s
-- dmas : Must contain an entry for each entry in clock-names.
-  See ../dma/dma.txt for details.
-- dma-names : Must include the following entries:
-  - rx
-  - tx
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-Example:
-
-i2s@70002800 {
-	compatible = "nvidia,tegra20-i2s";
-	reg = <0x70002800 0x200>;
-	interrupts = < 45 >;
-	clocks = <&tegra_car 11>;
-	resets = <&tegra_car 11>;
-	reset-names = "i2s";
-	dmas = <&apbdma 21>, <&apbdma 21>;
-	dma-names = "rx", "tx";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
new file mode 100644
index 000000000000..4c00fd0943c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra20-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra20 I2S Controller
+
+description: |
+  The I2S Controller streams synchronous serial audio data between system
+  memory and an external audio device. The controller supports the I2S Left
+  Justified Mode, Right Justified Mode, and DSP mode formats.
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra20-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: i2s
+
+  dmas:
+    minItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    i2s@70002800 {
+        compatible = "nvidia,tegra20-i2s";
+        reg = <0x70002800 0x200>;
+        interrupts = <45>;
+        clocks = <&tegra_car 11>;
+        resets = <&tegra_car 11>;
+        reset-names = "i2s";
+        dmas = <&apbdma 21>, <&apbdma 21>;
+        dma-names = "rx", "tx";
+    };
+
+...
-- 
2.33.1

