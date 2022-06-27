Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBE55D872
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiF0Tlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiF0TlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:41:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F9915A3A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:41:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v14so14489447wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+tGP5Kq7UIoKfqvhhTL1feo63GGQB6sV6O4YA0h7fw=;
        b=TY3zxo6VkLsIUdTKjBItn+/z8AdzcodR3qzEG//3XMYrcKS1k9ne/bka4gXxqXaQnp
         2A7+CWc2r5jHxfXLCYbs1PZlU4HHPOUgQ1rseP1dGYAxgMuz3QBtCgscrP20WA5683HF
         7DkBrqQ3cTdsOlJMk8LlpZ1sL4rLpwtH5c+0J1NR5w6oUFO9qMV2hs2XXgqe3IcaGcfj
         8r05RuxtHhutZ2YZG6ECMl6/y9ahK5t/H0x7DgLIqJyfuVdALl46lW0xRlvkJ20t3Vcl
         ZMUSRO1erAmX6lUgkQPLaSV9s+0p93XNH7HN5iFsEhgotSM/ZV3rJgj9Q45PHW2rpdNw
         hH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+tGP5Kq7UIoKfqvhhTL1feo63GGQB6sV6O4YA0h7fw=;
        b=6F4ydvueuXr54Eo0r8kHUpI94DL09iehbHblS5tRKbDx2ay4P9L4N2QrUvHaAf8Kt+
         vpwTuJLhj1Xkobhctqk6QJyv1rQfIbCfYpOF6JckKcpbwWBB/K3lhRiNBCll+BTb18Ud
         z5m+k+yGbJ0KJGyyROe5aoKlaZ/Q5FqFhcczf7YENU9yY+dpP4VFG+QRwprTAeV98kPb
         bBvuFmyVSQzphxKA/6e/wyq2llagBfDKo+kRfFapURVdqoRlc3LggK/yjDi72O3JCRy9
         I5TQntifDK4/+/Muh1/x0oCkro+b6Jx/PIsxkFqepCiypEAkLc8w0RmLtv1YXyyXmbt8
         w9Zg==
X-Gm-Message-State: AJIora9YmorqIWQEPpkO20fEs3+5mXPnJ8rlPQ//IvRoMaJ+05uO9bVx
        OiBzUhyELkHLIpFsjlU9n6DCyQ==
X-Google-Smtp-Source: AGRyM1vJuw4zmcv+tO3VLNG3qwSgFi4f30I8dOa3KRcph1tZdQYK/eqiVVbCh1Yv7auGf7Z85mjobg==
X-Received: by 2002:a5d:644a:0:b0:21a:75f3:ac7c with SMTP id d10-20020a5d644a000000b0021a75f3ac7cmr13433488wrw.506.1656358880472;
        Mon, 27 Jun 2022 12:41:20 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:19 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 03/16] ASoC: dt-bindings: convert designware-i2s to dt-schema
Date:   Mon, 27 Jun 2022 20:39:51 +0100
Message-Id: <20220627194003.2395484-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Convert the Synopsys DesignWare I2S controller binding to dt-schema.
There was no listed maintainer but Jose Abreu was the last editor of the
txt binding so add him as maintainer.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/sound/designware-i2s.txt         | 35 -------
 .../bindings/sound/snps,designware-i2s.yaml   | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
deleted file mode 100644
index 6a536d570e29..000000000000
--- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-DesignWare I2S controller
-
-Required properties:
- - compatible : Must be "snps,designware-i2s"
- - reg : Must contain the I2S core's registers location and length
- - clocks : Pairs of phandle and specifier referencing the controller's
-   clocks. The controller expects one clock: the clock used as the sampling
-   rate reference clock sample.
- - clock-names : "i2sclk" for the sample rate reference clock.
- - dmas: Pairs of phandle and specifier for the DMA channels that are used by
-   the core. The core expects one or two dma channels: one for transmit and
-   one for receive.
- - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
-
-Optional properties:
- - interrupts: The interrupt line number for the I2S controller. Add this
-   parameter if the I2S controller that you are using does not support DMA.
-
-For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
-properties please check:
-	* resource-names.txt
-	* clock/clock-bindings.txt
-	* dma/dma.txt
-
-Example:
-
-	soc_i2s: i2s@7ff90000 {
-		compatible = "snps,designware-i2s";
-		reg = <0x0 0x7ff90000 0x0 0x1000>;
-		clocks = <&scpi_i2sclk 0>;
-		clock-names = "i2sclk";
-		#sound-dai-cells = <0>;
-		dmas = <&dma0 5>;
-		dma-names = "tx";
-	};
diff --git a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
new file mode 100644
index 000000000000..5ac9c00157bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/snps,designware-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare I2S controller
+
+maintainers:
+  - Jose Abreu <joabreu@synopsys.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: canaan,k210-i2s
+          - const: snps,designware-i2s
+      - enum:
+          - snps,designware-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The interrupt line number for the I2S controller. Add this
+      parameter if the I2S controller that you are using does not
+      support DMA.
+    maxItems: 1
+
+  clocks:
+    description: Sampling rate reference clock
+
+  clock-names:
+    const: i2sclk
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+    minItems: 1
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+    minItems: 1
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: canaan,k210-i2s
+
+then:
+  properties:
+    "#sound-dai-cells":
+      const: 1
+
+else:
+  properties:
+    "#sound-dai-cells":
+      const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+oneOf:
+  - required:
+      - dmas
+      - dma-names
+  - required:
+      - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc_i2s: i2s@7ff90000 {
+      compatible = "snps,designware-i2s";
+      reg = <0x7ff90000 0x1000>;
+      clocks = <&scpi_i2sclk 0>;
+      clock-names = "i2sclk";
+      #sound-dai-cells = <0>;
+      dmas = <&dma0 5>;
+      dma-names = "tx";
+    };
-- 
2.36.1

