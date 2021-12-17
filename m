Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0E479345
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhLQR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbhLQR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:06 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D89C061574;
        Fri, 17 Dec 2021 09:58:06 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b19so4544819ljr.12;
        Fri, 17 Dec 2021 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FB8NrCq6c0f8jOXV4dsj1D+bh3p8PUaX1SHo3nADxp4=;
        b=DTTzqDWsrj8mQnQqF5bFz1nJoz4ryQ+TBjJ62UPxuqmU1c6lfqA3zhDCj1aI/J8Yqs
         u4gpHSQ6WBL0e3X2bV4yz+uI+C+cGQ2tJp14M5lESuw6+Z7rfVgI3VBVB52dUxtP3TrB
         ycu4MtjczH4KO5DLTU3GZCi2sqDRm6qlWUmhyDljTVdpxNNxVrtzG9G6Kr57lYOrljZd
         ElKFgEBwiQalsAuX1UslJcbh/5/cy91pl83mFMkqKhXvvbwzf6fyDCkxPIR4gTeo3VY7
         YSdMIVQ5vGG0fRJvKVjCe7wEnOO28+SvkBQhWLrjsb8iO0qKdgxU5OB+YHlQcu1oBgwf
         S8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FB8NrCq6c0f8jOXV4dsj1D+bh3p8PUaX1SHo3nADxp4=;
        b=53B2JX10QtW241Ew6eWWbRuK4HT4+se9vsXmPKlAM+yp9JB/Wmgel9GUTEGgxXuDKN
         MMh5MtcgyMNG7waTree8YCEsIQZT7j7g0ysvAiDueWFibVUUI0GC9Lkbh2voTRVug/P7
         SIzTio1RDwTOAwu5SpZbtJOWg6dYoUgDKjCU2pw88vr5BcYaQcVRVQYfh6iNPU9aIsx8
         WfAvg7di66AnBFVWnCycoi+pH/1WucFQKnQQSzTo+9AONpIMYeNZ+vRwPj/GyCSU6pG9
         /PKxkVtoaZ9glnHWb0piEAvAKmqRTi/450zL5efElQUqS7UZMjX0iehYWCJQxUaaHLRh
         t8jw==
X-Gm-Message-State: AOAM533OkY21eAP2H48NKFR/5CsTpIs6pPh4qLwy24jFbflpXkgUC+uG
        9iXg0+LjdxfATkN5fC9Rxaw=
X-Google-Smtp-Source: ABdhPJw5GliGY6dDen834MJOvCLphrGd/gm1fsIvCdMW/uW2lbBnsZTOwSnfyo+8Q8xQqR2DeFRK5A==
X-Received: by 2002:a2e:8691:: with SMTP id l17mr3559188lji.119.1639763884754;
        Fri, 17 Dec 2021 09:58:04 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 01/11] ASoC: dt-bindings: Add binding for Tegra20 S/PDIF
Date:   Fri, 17 Dec 2021 20:55:56 +0300
Message-Id: <20211217175606.22645-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding for Tegra20 S/PDIF controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/sound/nvidia,tegra20-spdif.yaml  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml
new file mode 100644
index 000000000000..296248eed0ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra20-spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra20 S/PDIF Controller
+
+description: |
+  The S/PDIF controller supports both input and output in serial audio
+  digital interface format. The input controller can digitally recover
+  a clock from the received stream. The S/PDIF controller is also used
+  to generate the embedded audio for HDMI output channel.
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra20-spdif
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: out
+      - const: in
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    minItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  "#sound-dai-cells":
+    const: 0
+
+  nvidia,fixed-parent-rate:
+    description: |
+      Specifies whether board prefers parent clock to stay at a fixed rate.
+      This allows multiple Tegra20 audio components work simultaneously by
+      limiting number of supportable audio rates.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    spdif@70002400 {
+        compatible = "nvidia,tegra20-spdif";
+        reg = <0x70002400 0x200>;
+        interrupts = <77>;
+        clocks = <&clk 99>, <&clk 98>;
+        clock-names = "out", "in";
+        resets = <&rst 10>;
+        dmas = <&apbdma 3>, <&apbdma 3>;
+        dma-names = "rx", "tx";
+        #sound-dai-cells = <0>;
+    };
+
+...
-- 
2.33.1

