Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558345504A2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiFRMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234715AbiFRMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:32:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B361DA4F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 05:32:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e25so4939408wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzCNuZqg5sJhSSZ4d8it+v4YJ89K4kJOhMYbzqau3T0=;
        b=Q/DW33pApkzDugaxPE3P0mBkLxqeHFjsQF8z1VV2ne8TRKuN2bIqDfzxsSTkLEjBrA
         wpdDJgUWP+1wDHdQ9JS4O1x4Gq88lL49JAWRWB4H62ef/kDIyGqiJWklnIhvj7t3gOgQ
         m1btN41fR+l8tqU5xRyuBWhlJfRunVaRxbUCkNPjxFxCR7fgJ76b5iLyDoxgvaEFgta2
         Y7jzvGqyxY8ynrhbm2wsHOUw8jsjq4R2c+1hs16sLw8LkR/A8wnX+Rcz+CEvY4HTn+12
         wA1hi5h2lS6EglrFG2mc1iaWo2T8RWK90k4OmUe37mNSSxwVnWaTmTTERIaDVuiKnqg6
         uvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzCNuZqg5sJhSSZ4d8it+v4YJ89K4kJOhMYbzqau3T0=;
        b=Q3ra4YWUTbZaYm/dIrgSPIXji3m8o9xZ7tUI2lHSfQ1R1rTdMD0yF/+Z5+EkN2RV/H
         rPYAZHPzrK4BmxJ79TSM2yyW534pPr5VNSdIKETMSURM906QkobECNM54/T+XL3ZL4XD
         D4bhi9CL+1gCxK/ZOVmSOC55BV8dReQwHO2P4XBjhceoHOjFbYxHHCq3Ip7UZ4nukKdX
         4K3YnjGYpRqjr4c+XNbhtrGvDZZSi1tDjI77oYmTI3EIaXULiB+fPRLF1px/LIJaV4pb
         foHOoVCd3yiMcHzI1utcE8rdOQAFaRYQ7il4f+zFImI/pEPlJMX5B6QDzb/yh47Lb1pk
         6Y2w==
X-Gm-Message-State: AJIora9FN4oKxaQU503EONq+qJHBNN/d3xLxyHtD9V3sJJGTMUOAbAlX
        2NAmLwtv7FrlQO0B10Ps0tplSg==
X-Google-Smtp-Source: AGRyM1sSSQqHjZc3Rjokw1+aDQhZh51cPdEwrDgxvVJw3mbh+xunRoRwhQyu4jAgaA6W5FK27IHXAg==
X-Received: by 2002:a5d:598e:0:b0:219:ea16:5a2a with SMTP id n14-20020a5d598e000000b00219ea165a2amr13955140wri.343.1655555528086;
        Sat, 18 Jun 2022 05:32:08 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm9292305wrb.45.2022.06.18.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 05:32:07 -0700 (PDT)
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
Subject: [PATCH 05/14] dt-bindings: timer: add Canaan k210 to Synopsys DesignWare timer
Date:   Sat, 18 Jun 2022 13:30:27 +0100
Message-Id: <20220618123035.563070-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618123035.563070-1-mail@conchuod.ie>
References: <20220618123035.563070-1-mail@conchuod.ie>
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

The Canaan k210 apparently has a Sysnopsys Designware timer but
according to the documentation & devicetree it has 2 interrupts rather
than the standard one. Add a custom compatible that supports the 2
interrupt configuration and falls back to the standard binding (which
is currently the one in use in the devicetree entry).

Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/timer/snps,dw-apb-timer.yaml     | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
index d33c9205a909..9a76acc7a66f 100644
--- a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
@@ -12,6 +12,9 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - const: canaan,k210-apb-timer
+          - const: snps,dw-apb-timer
       - const: snps,dw-apb-timer
       - enum:
           - snps,dw-apb-timer-sp
@@ -21,9 +24,6 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
-
   resets:
     maxItems: 1
 
@@ -41,7 +41,23 @@ properties:
 
   clock-frequency: true
 
-additionalProperties: false
+unevaluatedProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: canaan,k210-apb-timer
+
+then:
+  properties:
+    interrupts:
+      maxItems: 2
+
+else:
+  properties:
+    interrupts:
+      maxItems: 1
 
 required:
   - compatible
@@ -60,8 +76,8 @@ oneOf:
 examples:
   - |
     timer@ffe00000 {
-      compatible = "snps,dw-apb-timer";
-      interrupts = <0 170 4>;
+      compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
+      interrupts = <0 170 4>, <0 170 4>;
       reg = <0xffe00000 0x1000>;
       clocks = <&timer_clk>, <&timer_pclk>;
       clock-names = "timer", "pclk";
-- 
2.36.1

