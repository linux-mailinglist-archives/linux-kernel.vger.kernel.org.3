Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005A24DC52A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiCQL6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiCQL6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:58:50 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986121E6EB8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:34 -0700 (PDT)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2E81E3F4BE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518253;
        bh=BPmH+sTMtK9KvdlWBUTtE4tsLSFnUjRMwkwF+kfhktM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dpcE5ddsccM+bUoDUvLdS7jadxWpCPXxcgHNwauxZk03Y8h/pezR7o4bwVhVqZaQ4
         VBhSvEx29KU/7xEJMhuEaxE4naByqznEODTtF3rXBEAkRNKIAG+5qayH9+pfytn2RZ
         EmpqT5ZveISZm32xrvM/iunVbNLA1uwfUQYnubhe2th4iMGWyNPt6SUpF24T8Eoris
         3x0CNH2vI4b62YOgTdeBx+Sw/0ZPlbmYR20dlHNX85YED8SESfOi9eSJegTWe8jh5V
         3cbztoBHgPKnUswNDeRp2AXGEpJF1cFWBsHKGP38dPAPhMup9lMTDnvdxdc38GjDf1
         b+HoKgbOkriJg==
Received: by mail-lj1-f198.google.com with SMTP id h21-20020a05651c125500b002464536cf4eso1976099ljh.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPmH+sTMtK9KvdlWBUTtE4tsLSFnUjRMwkwF+kfhktM=;
        b=SgNZecLL6WVR12553D0ZSnrdJttR+NoA/5Yq+xUtacyiiHQ516vTT8fPSauyPISuOc
         PAD31AzJpF+eZlZnPOYDK36bcmVBK+bcYpjWGwiU59K7eKWhrSzWRhrxRFJ3eK/myop7
         xzLKNuI+u5jlC3Q0KLfMtbKpXm5FOYFZ1nFJ9osXDKw5doCFw6eldzO9KJWBVLVtLrtw
         MUE8KpKinQPLD+jBBpLxmrRx9WAV/3Y+Q3iVQ6M10CH0rOp7YWZqK209U4mqv9PoKuyH
         CIcWf5xPvEFJ1LwIHLetwWiDIyFXmIYPJvaq+rywoAk40N7kfj2p7G2sP/sCzanAiFwk
         9zFQ==
X-Gm-Message-State: AOAM533IQ+QfEkjFiDbvLBmyuFiSrwH9x44lLOnu+iC0iaf2K4cSlUSU
        HJ8GQAy22IFwIZ5MRMxWG1nximn8AeCdyxOHrswF359UwxjlYm6Sy4JgXLt4lQEdYgAvbo+IImX
        IZbom1pNTZotavlkMDOQKkNe77p4EDY6cFW7eX4X9Og==
X-Received: by 2002:adf:e746:0:b0:1ef:8476:dab3 with SMTP id c6-20020adfe746000000b001ef8476dab3mr3772429wrn.449.1647518240640;
        Thu, 17 Mar 2022 04:57:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQHNNPp+cT6LCWfeTjsbKn2oDv2UQ8R2ucYLdbIGsLwf9N7IdLuy6eC+hFFDvk8H5WgkaZvQ==
X-Received: by 2002:adf:e746:0:b0:1ef:8476:dab3 with SMTP id c6-20020adfe746000000b001ef8476dab3mr3772388wrn.449.1647518240413;
        Thu, 17 Mar 2022 04:57:20 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:20 -0700 (PDT)
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
Subject: [PATCH 05/18] dt-bindings: irqchip: fsl: include generic schema
Date:   Thu, 17 Mar 2022 12:56:52 +0100
Message-Id: <20220317115705.450427-4-krzysztof.kozlowski@canonical.com>
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

Include generic interrupt-controller.yaml schema, which enforces node
naming and other generic properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,intmux.yaml | 5 ++++-
 .../bindings/interrupt-controller/fsl,irqsteer.yaml          | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
index 1d6e0f64a807..5ead6b7dcb42 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
@@ -9,6 +9,9 @@ title: Freescale INTMUX interrupt multiplexer
 maintainers:
   - Joakim Zhang <qiangqing.zhang@nxp.com>
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     const: fsl,imx-intmux
@@ -45,7 +48,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index bcb5e20fa9ca..4b5080f754ea 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -9,6 +9,9 @@ title: Freescale IRQSTEER Interrupt Multiplexer
 maintainers:
   - Lucas Stach <l.stach@pengutronix.de>
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -70,7 +73,7 @@ required:
   - fsl,channel
   - fsl,num-irqs
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

