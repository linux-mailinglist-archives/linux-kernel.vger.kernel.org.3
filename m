Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A54CD1FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiCDKE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbiCDKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:04:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A419D75E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:03:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e15so5635400pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 02:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJQeczGCyde6fs+sGcXvqejtqL/oWjg9SsCj9ixzkS8=;
        b=h2zhJkz4ejNA9UZn2qKXICuQVZ5crdHCD3aL0FrHrgAipBUZruvyGxutNpSmGwvz4h
         q2FYeIflyxi4WjnT1UHwy9sb7CPF0FWUfW2O1BijSPjrnOD1yVt7ojVuUP/v0+2TCfAL
         rs1N2rEApj2CSLe+gsoapMAQO4EkBHtlllYjOEFKYvfb/NDrscO1HTxxTeVEix4iUUa8
         3h6v4pv7OGj36rQJ/IikLWbPoEHIc9Vk4xXIapdKiWk3BTZEVK92IhGdRfShRPWFcngL
         +qGv/J6YvIILTX4Ob/dGgmHl/zUSRENL5K3ZB7dRlHITceMzo3AJ0CfM+HNbSbyHDjsL
         aBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJQeczGCyde6fs+sGcXvqejtqL/oWjg9SsCj9ixzkS8=;
        b=nkVSvjC5KNQCV1sfd3KT4Cl+hJo25l7iijSSjeEZG8Av95lgO365Jph0I3xMc3t9mP
         lzDeOeLIGfQf+VnT3388aXZhWQR1BL+POmd4CCGTVuhjfOt8Fp1Dp1C6YfDj9hfU7Tug
         PXrNjOfQOP/3CXgEQLn4332xnjgrT2ZjYRIEdo/1pcmjxqacX0PaZ7clV+k52jFEG3f6
         P3B/a0t+hwc4SbZCwL54Ww556mAwon5eKcp7giIi1j9eRJqD4huGk3k3FKlf/ELg+ATl
         GiueWTrF0JDniRTytJ+CnfT0MwYSrUArB3c8e5GUpwh4wLL/j7XgZQpgkbUsn57v1ZIF
         quXw==
X-Gm-Message-State: AOAM530WRc66iWVP3Qyhocfl0vzW1ntIn4vwrqpoL/s46sMmhQeb0PQW
        a0m7Se8hEpOev7yoRzA51zvGBw==
X-Google-Smtp-Source: ABdhPJw8Wc3eKaZofkKh8W3VECbyxA6H4ZwEDiEWFzFFuLSB0crgYHjPTZ+vrcmF6tTgikJwX+lEtw==
X-Received: by 2002:a63:85c6:0:b0:37e:61ff:863e with SMTP id u189-20020a6385c6000000b0037e61ff863emr602220pgd.412.1646388212452;
        Fri, 04 Mar 2022 02:03:32 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00174800b004f26d3f5b03sm5461605pfc.39.2022.03.04.02.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:03:31 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v2 2/5] dt-bindings: change the macro name of prci in header files and example
Date:   Fri,  4 Mar 2022 18:03:18 +0800
Message-Id: <f9284873c2993a9952d9fe4f8dd5e89f20daab75.1646388139.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently change the macro name for fu540 and fu740 by adding the
prefix respectively, the dt-bindings should be modified as well.

Signed-off-by: Zong Li <zong.li@sifive.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../devicetree/bindings/gpio/sifive,gpio.yaml  |  2 +-
 .../bindings/pci/sifive,fu740-pcie.yaml        |  2 +-
 .../bindings/serial/sifive-serial.yaml         |  2 +-
 include/dt-bindings/clock/sifive-fu540-prci.h  |  8 ++++----
 include/dt-bindings/clock/sifive-fu740-prci.h  | 18 +++++++++---------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
index 427c5873f96a..939e31c48081 100644
--- a/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sifive,gpio.yaml
@@ -79,7 +79,7 @@ examples:
         interrupts = <7>, <8>, <9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>,
                      <17>, <18>, <19>, <20>, <21>, <22>;
         reg = <0x10060000 0x1000>;
-        clocks = <&tlclk PRCI_CLK_TLCLK>;
+        clocks = <&tlclk FU540_PRCI_CLK_TLCLK>;
         gpio-controller;
         #gpio-cells = <2>;
         interrupt-controller;
diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 392f0ab488c2..195e6afeb169 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -104,7 +104,7 @@ examples:
                             <0x0 0x0 0x0 0x2 &plic0 58>,
                             <0x0 0x0 0x0 0x3 &plic0 59>,
                             <0x0 0x0 0x0 0x4 &plic0 60>;
-            clocks = <&prci PRCI_CLK_PCIE_AUX>;
+            clocks = <&prci FU740_PRCI_CLK_PCIE_AUX>;
             resets = <&prci 4>;
             pwren-gpios = <&gpio 5 0>;
             reset-gpios = <&gpio 8 0>;
diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
index 09aae43f65a7..b0a8871e3641 100644
--- a/Documentation/devicetree/bindings/serial/sifive-serial.yaml
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
@@ -59,7 +59,7 @@ examples:
         interrupt-parent = <&plic0>;
         interrupts = <80>;
         reg = <0x10010000 0x1000>;
-        clocks = <&prci PRCI_CLK_TLCLK>;
+        clocks = <&prci FU540_PRCI_CLK_TLCLK>;
       };
 
 ...
diff --git a/include/dt-bindings/clock/sifive-fu540-prci.h b/include/dt-bindings/clock/sifive-fu540-prci.h
index 3b21d0522c91..5af372e8385f 100644
--- a/include/dt-bindings/clock/sifive-fu540-prci.h
+++ b/include/dt-bindings/clock/sifive-fu540-prci.h
@@ -10,9 +10,9 @@
 
 /* Clock indexes for use by Device Tree data and the PRCI driver */
 
-#define PRCI_CLK_COREPLL	       0
-#define PRCI_CLK_DDRPLL		       1
-#define PRCI_CLK_GEMGXLPLL	       2
-#define PRCI_CLK_TLCLK		       3
+#define FU540_PRCI_CLK_COREPLL		0
+#define FU540_PRCI_CLK_DDRPLL		1
+#define FU540_PRCI_CLK_GEMGXLPLL	2
+#define FU540_PRCI_CLK_TLCLK		3
 
 #endif
diff --git a/include/dt-bindings/clock/sifive-fu740-prci.h b/include/dt-bindings/clock/sifive-fu740-prci.h
index 7899b7fee7db..672bdadbf6c0 100644
--- a/include/dt-bindings/clock/sifive-fu740-prci.h
+++ b/include/dt-bindings/clock/sifive-fu740-prci.h
@@ -11,14 +11,14 @@
 
 /* Clock indexes for use by Device Tree data and the PRCI driver */
 
-#define PRCI_CLK_COREPLL	       0
-#define PRCI_CLK_DDRPLL		       1
-#define PRCI_CLK_GEMGXLPLL	       2
-#define PRCI_CLK_DVFSCOREPLL	       3
-#define PRCI_CLK_HFPCLKPLL	       4
-#define PRCI_CLK_CLTXPLL	       5
-#define PRCI_CLK_TLCLK		       6
-#define PRCI_CLK_PCLK		       7
-#define PRCI_CLK_PCIE_AUX	       8
+#define FU740_PRCI_CLK_COREPLL		0
+#define FU740_PRCI_CLK_DDRPLL		1
+#define FU740_PRCI_CLK_GEMGXLPLL	2
+#define FU740_PRCI_CLK_DVFSCOREPLL	3
+#define FU740_PRCI_CLK_HFPCLKPLL	4
+#define FU740_PRCI_CLK_CLTXPLL		5
+#define FU740_PRCI_CLK_TLCLK		6
+#define FU740_PRCI_CLK_PCLK		7
+#define FU740_PRCI_CLK_PCIE_AUX		8
 
 #endif	/* __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H */
-- 
2.31.1

