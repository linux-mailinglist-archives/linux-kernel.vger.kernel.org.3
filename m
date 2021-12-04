Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1923468565
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhLDOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbhLDOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:40:59 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB90BC061751;
        Sat,  4 Dec 2021 06:37:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id j18so11864305ljc.12;
        Sat, 04 Dec 2021 06:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/X2rHEQd+Ucbeu0Y4aO3xdVUiQaaeBj1J30EhihxKs=;
        b=Hmo2bp0XD7MwfOW5ZCLk2GISHdr/yTvLIohTI7RHWuHGbeHlDJozx/LsdhpQe4yoH8
         A0PJJufbpQT4J4x549rDU6ERWTBWVUy73fRKupA2q9m+vVJnQKVTlHLeQsj2vwG+e2wJ
         YJ5PQvT9yS3tiaRak55w5VFSYMzfh37EbTpqs0XqQvdL8nv/ww6pxCYkv9UOVE+PR0I3
         aqIpYmAw4ZAbbmFphtECxow41rQMlYrds5ECDNmQDY6B5ypKDw30gze6Zm8/AziQAhgU
         1/Oiq9L2G9GM2qOkn/zeMBWjxkuoy84PVTgD+c4beyfgl/LWOn3CKFOUScHNfBdOcYNu
         HgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/X2rHEQd+Ucbeu0Y4aO3xdVUiQaaeBj1J30EhihxKs=;
        b=XdDDWe/37mLoQzj+rl96llBqJK4y5E+LjhafEhULSHIpLpiO7XBzWso41agmCwCqIO
         i55WJK/UQPItE3ZTRJ87rp7pLCgpbNrHtVhrGxcRDe8AGJhB3/rSODCPgTyUVfdg15Bv
         bWHepZKfOhy9koK/ZvIRuJkSyrB8C2gB2mOXX5izVVvnYwsEGQiwXuQqKz16p5dKg5kd
         s2/JGssJ24OYDJxDmlrnvpCsPeOOw+3eY58jOTUivXoSjn11IhrKdbAhGKKUALltjLoE
         34CS3TBDCzbQYuHZC4W73e6k7D+qcsgiLg1s9f/jSvuA6aGDZRvF4vx0gtULd7r1/I6J
         u7Pg==
X-Gm-Message-State: AOAM531t+bJ6g+ZinUUo3ifEUMY4SHAI6vLQ9Be8OsSjR9xMBLH43c5Q
        jWuZT3Zy6hGUJKK27kSufCg=
X-Google-Smtp-Source: ABdhPJwcdgRw44pXn41+KUa5AP/jULS0ohcmHnZPCR7EdYs/LEdBhNkorjhYbQ3H4RJ980OeL+c3Fg==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9mr24035834ljj.27.1638628652007;
        Sat, 04 Dec 2021 06:37:32 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 01/22] ASoC: dt-bindings: Add binding for Tegra20 S/PDIF
Date:   Sat,  4 Dec 2021 17:37:04 +0300
Message-Id: <20211204143725.31646-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding for Tegra20 S/PDIF controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/sound/nvidia,tegra20-spdif.yaml  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml
new file mode 100644
index 000000000000..60a368a132b8
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
+  resets:
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
+  - resets
+  - interrupts
+  - clocks
+  - clock-names
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

