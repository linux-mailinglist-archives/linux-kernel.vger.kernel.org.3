Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994956AA74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiGGSZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiGGSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:25:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDF93120C;
        Thu,  7 Jul 2022 11:25:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q82so12830215pgq.6;
        Thu, 07 Jul 2022 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWodpiWQQkmXlbhQ6Hum7yJMbf/CRHimuamMgEhZ7AQ=;
        b=b70THC5Z6MHec4fmPJUFbmYsUEX3pkNt3ZYkut4gnCMU42M/vawk+RGYbkI4xfI1Ux
         sirXuUcvJxHAbkLsTckkqagXKB5AOoExuVCdb9mdbMRaDyInzBcDcWJsd8enMVKW4ktp
         qqnlN6YKZTNk/O762Yr50xBoVSisvbHV+bWwdKQCrMpwGYJRm74FrIm8Yc34Zq/TuwvF
         kHy6o8Bad7KMp463yoxkbNYjF6whZFbAHHDuv3v4oSJ0u/P3PoRmNKFZyC79xO6hXv8M
         2Pgv7ztomQ0/jSdC1INsabJQMgiEN1GTXZ38DXR9l9j+s4A7gMT8Xtr7SHwiPvg/tVJy
         KDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWodpiWQQkmXlbhQ6Hum7yJMbf/CRHimuamMgEhZ7AQ=;
        b=iVm9FNb88wGxvF9BNfBBvNvRuRa8h0Ep/0lCipYw6+8+hVAujAR0jww1dFa/MPoAd5
         b8F0EhnEr2y1J416VVijrjNCM85B7FMeOZDC0APkuxXy4gHAHWJQqqkkiBoke7g48KED
         hsuxuj/9h0GsPQTSvssYOpm9wNbBzdfm6oyjvTDSTbjmN7+rvvCxEqP9me5fkObzWfXc
         bYLBnkFtSdJzB86eWT+unAmZriObSOR0qXqEltIoEpmg+YLyxIj2goN6JZ+57jq2k4He
         aNHPJvzZEpNe0RF20aNiGo16PKcnE87ZDMLVYbcsL9dqUBcoclIf3wPilqnQhALnewBh
         6cjA==
X-Gm-Message-State: AJIora/kvCvW2/SshT0kIZGui9SBhI9om3a/tfM7yfwJ3D01Nb2vI3ZV
        ubqJIBA3hWCbwWGHYs3GMWs=
X-Google-Smtp-Source: AGRyM1v2U5zQROTYH7xRziokWUvcFLZSoYz7ukjiigrTBkvh+tkrk0Eg54cszcr/pTa63y+PkRMvUQ==
X-Received: by 2002:a17:902:db0c:b0:16a:4b7e:af5e with SMTP id m12-20020a170902db0c00b0016a4b7eaf5emr54445993plx.145.1657218304145;
        Thu, 07 Jul 2022 11:25:04 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.85])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016a3f9e4865sm28589279plg.148.2022.07.07.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:25:03 -0700 (PDT)
From:   prabhakar.csengg@gmail.com
X-Google-Original-From: prabhakar.mahadev-lad.rj@bp.renesas.com
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
Subject: [PATCH v8 5/6] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties to handle GPIO IRQ
Date:   Thu,  7 Jul 2022 19:23:13 +0100
Message-Id: <20220707182314.66610-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

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

