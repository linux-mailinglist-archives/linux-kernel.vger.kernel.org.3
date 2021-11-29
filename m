Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB134622D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhK2VFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhK2VDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:03:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD7C12530B;
        Mon, 29 Nov 2021 10:26:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a18so38868883wrn.6;
        Mon, 29 Nov 2021 10:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ttdy58tm+LmXBv1FcpjRYVHwwZt4Hb7jA/LU/P8ugo=;
        b=GT26leHjJpkOtelhjyR9gLeFjKdc7gTo+QE2VS7AFybVpDHwh2PozKE1zwaNK4QzDL
         3dJ/Q50TckmgrhdX20Uc3DNOOh+patKlwsoxAPFpxrob5PwZdyD7qahwm4ZSb11pYRdo
         VmXvg7DHyqxFhQ6vQM63ZmYNJUs8jacafS0cR1lLm6g7ikLbVI94JKwAyxXME52g8V44
         FAaT+sVskEjC3znsRBO/44prR8E29w4CSmA/PfNdXCyX7rRlr87YyOCotYtPHKjDZ0E+
         Eeb3w5YCJeGJSTxbcaYM+FiNMyOrZDhe+PavEpADo8mh+c6gPZON0MYj5PAgbUqs2YdG
         J4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ttdy58tm+LmXBv1FcpjRYVHwwZt4Hb7jA/LU/P8ugo=;
        b=EI0JOQSNFg73BpTpakm/Y08SCCU40PpkF20mCRCcj80USThvq/VJXuz2xP/+f67m7b
         l6kzdV7v1egZvcgtmTTuL7GcrJOXVGfGuWWWLl/7KpgkFrxOUQp3gwc0qyV5iGUeAgHj
         wGu7VHgvrraKWiCj4WG62BGK635yd8EMYoVt8tRW4nM2nUe9qJj5+OQVFZC8bZ74pTQV
         JdUy7YTMMt30gKGrSuebyoNgeFeBok76jGM0KQzSuu8AXEu+1LLDNVdqf9S9SjX0U6eF
         rMaKC9oiBQpl8NbW02/Kk9Ocddu6PDpZSFkWlAOiiBwhggUnq0evomn3mwuVp8Bi9yCe
         /Eww==
X-Gm-Message-State: AOAM532mVLr2K/JzTUw1FQkrQKOcZI0O+fk04PJRSw9zhEI8WvTsY8UE
        vr9TACfiAxAdjZ8pYDvlLL8c9heUy1YBdQ==
X-Google-Smtp-Source: ABdhPJxJjHQhsAjD+1u1olPTV9PDVp6oC2fPjSoeFCbNRtlMuQSFYOaki5HkEpUDwcfnV2Z955wceg==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr36102165wro.461.1638210408159;
        Mon, 29 Nov 2021 10:26:48 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:47 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 7/9] media: dt-bindings: allwinner: document H6 Hantro G2 binding
Date:   Mon, 29 Nov 2021 19:26:31 +0100
Message-Id: <20211129182633.480021-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 contains older Hantro G2 core, primarly used for VP9 video
decoding. It's unclear for now if HEVC is also supported.

Describe it's binding.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/allwinner,sun50i-h6-vpu-g2.yaml     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
new file mode 100644
index 000000000000..24d7bf21499e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/allwinner,sun50i-h6-vpu-g2.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Hantro G2 VPU codec implemented on Allwinner H6 SoC
+
+maintainers:
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+
+description:
+  Hantro G2 video decode accelerator present on Allwinner H6 SoC.
+
+properties:
+  compatible:
+    const: allwinner,sun50i-h6-vpu-g2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sun50i-h6-ccu.h>
+    #include <dt-bindings/reset/sun50i-h6-ccu.h>
+
+    video-codec-g2@1c00000 {
+        compatible = "allwinner,sun50i-h6-vpu-g2";
+        reg = <0x01c00000 0x1000>;
+        interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&ccu CLK_BUS_VP9>, <&ccu CLK_VP9>;
+        clock-names = "bus", "mod";
+        resets = <&ccu RST_BUS_VP9>;
+    };
+
+...
-- 
2.34.1

