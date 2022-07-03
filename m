Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37AF56499D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiGCTl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiGCTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:41:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C149624C;
        Sun,  3 Jul 2022 12:41:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so3168766pjm.2;
        Sun, 03 Jul 2022 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZusAfOqShMCPeI4fl6PdXXLSrPbbUhiptFDPPX9DwwU=;
        b=old0sniP2RKpqGWQhym3YJMH/Kdwoipcp3daTc6keF+8niCm/8DV75hn7xyeyDb2kw
         FGqXhjKIt8fJcUxdR2/ghUMiFMmuMV2vEpRW4RhnIX5cqbaUc/CtTrzcVnGUu3dcFXlE
         4wiQzaJQ236GkmmeDSydYAZ+ZYoChlNNJts27XKLAoMMfdQ6rt9CARav+vGJfsc55eiq
         1caFhMMMOvtJOEkpk5EsJVYVIOLlGp1RHWu5xvWNzHqaXSbTMRAhJqbA0h/YaFc3zCFx
         Y/sN+gXKomJzCigu8jg1uKnOySEgEateP2kyeDq8YlPxC/VVUbmh7L5LPU9kOFWFGFLX
         cthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZusAfOqShMCPeI4fl6PdXXLSrPbbUhiptFDPPX9DwwU=;
        b=jjLCgJhXctnG9RBt0jMg9S/ix6djhBsKxH7imoYDO3VHEJmy0qK0ubMYSUBJLqei6+
         Ws+xAlOgijl3CWkjFcDWLv0qTPr8RC78EaR/BCJZ4po0+LnsgUS3LfykBHMhIVJcwWXP
         UEXZk8Df7kVcN0EntEA/0EXF2YKw0Ngq++I+r1/1RcIJx+1WorAhQ1oouA2dXdx8bsPv
         WbAfLgxffQgxp88Uu4CIy9YQ75VhVyeY6VnFpLmfM9oYUR2wJUdntK+VimeQH6ZIzENQ
         1WGl3gUCCeKBPEFaWHTxZJKuH+8v6tP/9XYvpQgPQ1ZhZB+X12e/QXYU1rLYKndi9f6f
         fTHg==
X-Gm-Message-State: AJIora9DtzSezMaA4zELIYrVNLPrBY0O/oFpC6GEzjhBJN09hyMciXiC
        O5fgG4BCRDTckwPA/8Dq2Dtl5hOB+f8=
X-Google-Smtp-Source: AGRyM1tTdh3JSwBX1i4xFXSzUcD5IW6XObjfRYamNyUoDsAqIsezV2BCORGbK19Yj9X/pd553WAwmg==
X-Received: by 2002:a17:902:aa8a:b0:16a:1ea5:d417 with SMTP id d10-20020a170902aa8a00b0016a1ea5d417mr33238807plr.4.1656877312738;
        Sun, 03 Jul 2022 12:41:52 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.86])
        by smtp.gmail.com with ESMTPSA id y19-20020a17090aca9300b001e0c5da6a51sm10656104pjt.50.2022.07.03.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 12:41:52 -0700 (PDT)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 4/5] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties to handle GPIO IRQ
Date:   Sun,  3 Jul 2022 20:40:19 +0100
Message-Id: <20220703194020.78701-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the required properties to handle GPIO IRQ.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 52df1b146174..997b74639112 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -47,6 +47,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell contains the global GPIO port index, constructed using the
+      RZG2L_GPIO() helper macro in <dt-bindings/pinctrl/rzg2l-pinctrl.h> and the
+      second cell is used to specify the flag.
+      E.g. "interrupts = <RZG2L_GPIO(43, 0) IRQ_TYPE_EDGE_FALLING>;" if P43_0 is
+      being used as an interrupt.
+
   clocks:
     maxItems: 1
 
@@ -110,6 +121,8 @@ required:
   - gpio-controller
   - '#gpio-cells'
   - gpio-ranges
+  - interrupt-controller
+  - '#interrupt-cells'
   - clocks
   - power-domains
   - resets
@@ -126,6 +139,8 @@ examples:
             gpio-controller;
             #gpio-cells = <2>;
             gpio-ranges = <&pinctrl 0 0 392>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
             clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
             resets = <&cpg R9A07G044_GPIO_RSTN>,
                      <&cpg R9A07G044_GPIO_PORT_RESETN>,
-- 
2.25.1

