Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBA64DC52B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiCQL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiCQL7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:59:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5842F1700A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:58:00 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 575D040333
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518275;
        bh=LNamuvhrzviKyHuQ4L0rCxs+G11+opr3Fg5u/5wPXa8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=M7qfrJBjRPqzU/kuhjapww5MYhKz+jKpk8Pov0UF8Qg7j2NvpPtV1tYEpZzQyiP6o
         d3uYhpf6fmRL6U+0ZXsNVRGs8oEADmE68nPN/2ermi55Fui6pqqr5phYYRm6NIiRfU
         /p8wN2NtFaNKaZd11zvywHo/Z1p5koH1DWTanFAntVuo+iVLgXYcvZCJQX+Ne/14HM
         yCokFRCZYxUiu5JFG2AajwQcVRKgHPtqjnz6Xl4pebXoicvIk2iFYc59IoY3n+a8t9
         wDkLL0CiJH2JSfEeGHplFTqwzFF4maUgvv2H65q0sOPForwMmh8RCzzZzWHdIPJ6W/
         32qbHflHLzdfw==
Received: by mail-wm1-f70.google.com with SMTP id c126-20020a1c3584000000b00380dee8a62cso1544526wma.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNamuvhrzviKyHuQ4L0rCxs+G11+opr3Fg5u/5wPXa8=;
        b=p4msY2aGPUOhVNKb1zRX8jJ3gqy4Yz1je+qQwavK3Py+lg3PlJmmnTKSHd4v6EgtpN
         kpDOtegxGUYGrBumJqAzSnosRt1QruQFPUOaIJWsQUJ7iRgg3I8g/iIAFXJ2S1vF4cwE
         FP3wlXjdZcqpyJWZD8oh4/s0V/I4C30usqpwxkpXjdmbIaCKaC1Nj/1fqH8ZGlmmGKUI
         3u7occ3spARFZdglZXpfaPENimMOskRSMQHgyd92Unz4RNlpVLvrwJcfXCvaY8b3SVuS
         PvxM3u/VgJf9YbfZ9Ln4Tn32E+V+Iu+FafdgSoJ2J+mII2yR55nY/JLQ9SRyLHJ1i8p9
         Arpg==
X-Gm-Message-State: AOAM532RHMi5mNqM8YSDIOAtE1v3oJ+r9EzSJUrQ9CAb1PP5xUENtk51
        PhmFnlG3i3ND42BzStcHd4JJl4q7hkoEKqT2xpFgfyU492E2TPWinos5jEt5m50AT/SqN4kECRa
        Iy9kAoLW44edsRPJUjAR8n7X6eiArR57IX/eARCFtbQ==
X-Received: by 2002:adf:ee06:0:b0:203:d69f:ee6a with SMTP id y6-20020adfee06000000b00203d69fee6amr3573324wrn.376.1647518272279;
        Thu, 17 Mar 2022 04:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmlGAG4WbY9Y9ECnGHhG7nICuH9qeB/Pd7q3rLG8W4tmsHHiqlovZiXlafy2xr1sXRMtPxDw==
X-Received: by 2002:adf:ee06:0:b0:203:d69f:ee6a with SMTP id y6-20020adfee06000000b00203d69fee6amr3573270wrn.376.1647518272033;
        Thu, 17 Mar 2022 04:57:52 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:51 -0700 (PDT)
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
Subject: [PATCH 16/18] dt-bindings: irqchip: renesas: include generic schema
Date:   Thu, 17 Mar 2022 12:57:03 +0100
Message-Id: <20220317115705.450427-15-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 .../renesas,intc-irqpin.yaml                  | 28 ++++++++++---------
 .../interrupt-controller/renesas,irqc.yaml    |  5 +++-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.yaml
index f4aae56c6469..2a55581e0f4f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.yaml
@@ -65,19 +65,21 @@ required:
   - '#interrupt-cells'
   - interrupts
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,intc-irqpin-r8a7740
-          - renesas,intc-irqpin-sh73a0
-then:
-  required:
-    - clocks
-    - power-domains
-
-additionalProperties: false
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,intc-irqpin-r8a7740
+              - renesas,intc-irqpin-sh73a0
+    then:
+      required:
+        - clocks
+        - power-domains
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index 620f01775e42..ab827bd8590f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -9,6 +9,9 @@ title: DT bindings for the R-Mobile/R-Car/RZ/G interrupt controller
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     items:
@@ -70,7 +73,7 @@ required:
   - interrupts
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

