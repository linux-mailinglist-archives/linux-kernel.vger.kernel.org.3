Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561004DC544
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiCQMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiCQL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:59:31 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64B1728A0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:58:12 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 316963F94B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518289;
        bh=Se1x08TIKnomHmbPOsCcljQ9abxNVpGR1lbzQcpKc/g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BKlAww1Ak/xk0I5iXWUh8YZcrfI/iNP6m5rC6fBoW+yYkP+rdWNWDFEk89uO3lGlN
         mDCKVHPGNZlAzXfvGZaBn06/Jxyxgs4IiAm7cVjyoq9LNWJEn1aWQlJnQrHXsb+1h+
         702oAGN7V3fHEG6YZFDwHzoJWQpteQ6BFqxJLCgsKVuMiFSxQn7hLBrvvmRsXZcLFe
         Xj35YuRB2pyJi9mrDAT4XjC/gtTo41UArR2rCNSIaWGoG4pHQ5EppouqnZ9GDQFNl+
         sQTYrKU7tT7xbiVrOP9wIIcWk25Y1VDaK3tnd/Gwj2OhfrzCzsIAhU+aAyJ2f2Xq3c
         oJlZb13S+L8Sw==
Received: by mail-wm1-f71.google.com with SMTP id v184-20020a1cacc1000000b0038a12dbc23bso4182013wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Se1x08TIKnomHmbPOsCcljQ9abxNVpGR1lbzQcpKc/g=;
        b=RrnqkQxRYAno46WtagHJ99jbrYjwJlUumDbO5g9I9ocKJrr4QC2zzqVnwiulLZgdeS
         P7PhiLvtvDVpHXB9/D7zB+MXNO4oLBhGxnDt6aPdY/he7bkTmMCIOJsfjDaaHV99zt+R
         Wnt+oq96YS1qjoFXjiwPgLH/79rxXSBfug4oBPqHGYvMNkSqlR2/ZguYvRjr9ehipjk5
         sb0gmcoH117vbG30X3mmhjO+o2NTsVP34J2qnCuUT+5OwYbNPq94ovcoi716+u/6MuwR
         Y6LTGxtkxXnHujKlJxha/o/eVhrLckuEss9eH13DlPDCadQl4tG1UuiBT760Q7TNCi2I
         p8EQ==
X-Gm-Message-State: AOAM532+dOvcsfKQSj4+xa3tgkQ6dk4ezeGDoeUb76ZMqcqjGVyGmwxE
        TWMyK2nVnCnPZcd7xKypm0SHmN31vt2HZNhnsJ0lFBMzqNGULMfCuQfQy8z220LRy81X+nxgYna
        T9e2GUqJ9aDnF7YK/4T9jqz/8dmNZ/adb6GbVDYADvQ==
X-Received: by 2002:a1c:7312:0:b0:38c:6f75:ab28 with SMTP id d18-20020a1c7312000000b0038c6f75ab28mr5970876wmb.19.1647518276637;
        Thu, 17 Mar 2022 04:57:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzGz1twNJ92VnBy+RepCLy4U1K/Q67OukVWGeTcahnkhBl7wcOvPZo8IwHXQJMuUSC1th66Q==
X-Received: by 2002:a1c:7312:0:b0:38c:6f75:ab28 with SMTP id d18-20020a1c7312000000b0038c6f75ab28mr5970841wmb.19.1647518276425;
        Thu, 17 Mar 2022 04:57:56 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 18/18] dt-bindings: irqchip: ti: include generic schema
Date:   Thu, 17 Mar 2022 12:57:05 +0100
Message-Id: <20220317115705.450427-17-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include generic interrupt-controller.yaml and msi-controller.yaml
schema, which enforces node naming and other generic properties.
The schema requires now proper naming of node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/interrupt-controller/ti,pruss-intc.yaml         | 5 ++++-
 .../bindings/interrupt-controller/ti,sci-inta.yaml           | 1 +
 .../bindings/interrupt-controller/ti,sci-intr.yaml           | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
index 65523d9459d8..983d10da4463 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
@@ -32,6 +32,9 @@ description: |
   This interrupt-controller node should be defined as a child node of the
   corresponding PRUSS node. The node should be named "interrupt-controller".
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   $nodename:
     pattern: "^interrupt-controller@[0-9a-f]+$"
@@ -106,7 +109,7 @@ required:
   - interrupt-controller
   - "#interrupt-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index 88c46e61732e..935a61504aa0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+  - $ref: msi-controller.yaml#
 
 description: |
   The Interrupt Aggregator (INTA) provides a centralized machine
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
index e12aee42b126..0d35a5e21a64 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
+  - $ref: /schemas/interrupt-controller.yaml#
 
 description: |
   The Interrupt Router (INTR) module provides a mechanism to mux M
@@ -92,7 +93,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    main_gpio_intr: interrupt-controller0 {
+    main_gpio_intr: interrupt-controller {
         compatible = "ti,sci-intr";
         ti,intr-trigger-type = <1>;
         interrupt-controller;
-- 
2.32.0

