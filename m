Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80B5581279
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbiGZL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiGZL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:58:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D694232EF8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z13so15837117ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZD4oWR8lLLm0h5UiJTByuHzTZOByI5QF329GLIt5dRk=;
        b=Dlg9Vr86jIDl2AyTMP/rQqeen7cbUiOBxZyLMsFQyBmwc81Qd8pEUVSzSjCGGC7uEu
         D4IOTA6Azi+sAitVNl8HJWRaebZKlLdsfBvAzSybVmWO+m5H19z7yM/b6e/Njujpby7m
         bX1EWkEH6GKJ6o1uxmZHWpH2GmC2o+m/YTc8B89nB/56+tTMOkQ/kw8OpsfIQhjGE/gs
         pqmLDjXg4Kw/antbq70l9seU+6jrNGu0rWiL1/4R9fXdOguf7GtT8yZh4XQCc62wuvMp
         hCOR55O0tiCMpHHPec9kxIixs2GPCbIgWozegDQsRDl+Fr91Q6iXKaffh2Sk7ENprU2i
         4m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZD4oWR8lLLm0h5UiJTByuHzTZOByI5QF329GLIt5dRk=;
        b=yky2kHzKAVMiWVxbERV0qw6B3Gkg9vzKD0uo4tZJIqI9HFyS/tkJf3wCRhrVB55u36
         warrvbHcRo2rAka8+GeBsDNLaFl+VDaGWlaptcIcDkoHJR48bDlkevX7+XdWHNVmHn5G
         vQaSOVTIIG/EOUU5ofCRt+OS1PEVa2VtP9ETS0JpESsiPTXdNxgdXwtMjJS6FjtIsPXA
         c7kn+jP3dv/gjH6JVVvXYF5L6GYc5Kroe4/bdOhurQdvemO8iKyRaNN468FX9sHbEp8R
         R4rT/s8bW+U0HYv1QycjxcGCggyvWCbBb4IoxJ1ckUMr1Kewu96d4HeWD3xHO/L8aW37
         DS+w==
X-Gm-Message-State: AJIora+YkAv/v3ucvzdgijHf+9j3EdQ/wj/r3Bn98ntg7veh108WSrVi
        0erle7SgVVuNfi4kyMstLAYTWA==
X-Google-Smtp-Source: AGRyM1sf7OccntL6OHASCh63UHGBxUSN3DSTt4KunkGAGPRSojU2+jhNffQP1WK+ZRFbxWpKHKPxAQ==
X-Received: by 2002:a2e:a5c5:0:b0:25e:818:34c7 with SMTP id n5-20020a2ea5c5000000b0025e081834c7mr3315066ljp.119.1658836680931;
        Tue, 26 Jul 2022 04:58:00 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id g24-20020a19e058000000b0048a7d05739asm222219lfj.4.2022.07.26.04.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:58:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sebastian Reichel <sre@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        David Lechner <david@lechnology.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Klein <michael@fossekall.de>,
        Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Stephan Gerhold <stephan@gerhold.net>,
        David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: power: supply: drop quotes when not needed
Date:   Tue, 26 Jul 2022 13:57:48 +0200
Message-Id: <20220726115748.101015-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
References: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Id and schema fields do not need quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/supply/active-semi,act8945a-charger.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq2415x.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq24190.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq24257.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq24735.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq2515x.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq256xx.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq25890.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq25980.yaml   | 4 ++--
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml   | 4 ++--
 .../devicetree/bindings/power/supply/cpcap-battery.yaml       | 4 ++--
 .../devicetree/bindings/power/supply/cpcap-charger.yaml       | 4 ++--
 .../devicetree/bindings/power/supply/dlg,da9150-charger.yaml  | 4 ++--
 .../bindings/power/supply/dlg,da9150-fuel-gauge.yaml          | 4 ++--
 .../devicetree/bindings/power/supply/ingenic,battery.yaml     | 4 ++--
 Documentation/devicetree/bindings/power/supply/isp1704.yaml   | 4 ++--
 .../devicetree/bindings/power/supply/lego,ev3-battery.yaml    | 4 ++--
 .../devicetree/bindings/power/supply/lltc,lt3651-charger.yaml | 4 ++--
 .../devicetree/bindings/power/supply/lltc,ltc294x.yaml        | 4 ++--
 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml | 4 ++--
 .../devicetree/bindings/power/supply/maxim,ds2760.yaml        | 4 ++--
 .../devicetree/bindings/power/supply/maxim,max14656.yaml      | 4 ++--
 .../devicetree/bindings/power/supply/maxim,max17040.yaml      | 4 ++--
 .../devicetree/bindings/power/supply/maxim,max17042.yaml      | 4 ++--
 .../devicetree/bindings/power/supply/maxim,max8903.yaml       | 4 ++--
 .../devicetree/bindings/power/supply/nokia,n900-battery.yaml  | 4 ++--
 .../devicetree/bindings/power/supply/olpc-battery.yaml        | 4 ++--
 .../devicetree/bindings/power/supply/power-supply.yaml        | 4 ++--
 .../bindings/power/supply/richtek,rt5033-battery.yaml         | 4 ++--
 .../devicetree/bindings/power/supply/richtek,rt9455.yaml      | 4 ++--
 .../devicetree/bindings/power/supply/sc2731-charger.yaml      | 4 ++--
 Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml | 4 ++--
 .../bindings/power/supply/stericsson,ab8500-btemp.yaml        | 4 ++--
 .../bindings/power/supply/stericsson,ab8500-chargalg.yaml     | 4 ++--
 .../bindings/power/supply/stericsson,ab8500-charger.yaml      | 4 ++--
 .../bindings/power/supply/stericsson,ab8500-fg.yaml           | 4 ++--
 .../bindings/power/supply/summit,smb347-charger.yaml          | 4 ++--
 .../devicetree/bindings/power/supply/tps65090-charger.yaml    | 4 ++--
 .../devicetree/bindings/power/supply/tps65217-charger.yaml    | 4 ++--
 .../devicetree/bindings/power/supply/twl4030-charger.yaml     | 4 ++--
 .../power/supply/x-powers,axp20x-ac-power-supply.yaml         | 4 ++--
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml    | 4 ++--
 .../power/supply/x-powers,axp20x-usb-power-supply.yaml        | 4 ++--
 43 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml b/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
index 3f74bc19415d..5220d9cb16d8 100644
--- a/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/active-semi,act8945a-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/active-semi,act8945a-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/active-semi,act8945a-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Active-semi ACT8945A Charger Function
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
index 118cf484cc69..a3c00e078918 100644
--- a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq2415x.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq2415x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for TI bq2415x Li-Ion Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index 402d9d2ed2b9..4884ec90e2b8 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq24190.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq24190.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for TI BQ2419x Li-Ion Battery Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq24257.yaml b/Documentation/devicetree/bindings/power/supply/bq24257.yaml
index 3a0f6cd9015a..c7406bef0fa8 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24257.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24257.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq24257.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq24257.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for bq24250, bq24251 and bq24257 Li-Ion Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yaml b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
index 131be6782c4b..dd9176ce71b3 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24735.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq24735.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq24735.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for TI BQ24735 Li-Ion Battery Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
index 813d6afde606..27db38577822 100644
--- a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq2515x.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq2515x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI bq2515x 500-mA Linear charger family
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
index 92ec7ed25668..91abe5733c41 100644
--- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq256xx.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq256xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI bq256xx Switch Mode Buck Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.yaml b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
index bf823b615439..204c0147188f 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq25890.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq25890.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for bq25890, bq25892, bq25895 and bq25896 Li-Ion Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq25980.yaml b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
index 8367a1fd4057..4883527ab5c7 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25980.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq25980.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq25980.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI BQ25980 Flash Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 6af41da3e055..65fc6049efc1 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/bq27xxx.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/bq27xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI BQ27XXX fuel gauge family
 
diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml b/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
index 7153fd4ce55f..694bfdb5815c 100644
--- a/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/cpcap-battery.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/cpcap-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Motorola CPCAP PMIC battery
 
diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml b/Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
index cb6353683d7b..7e6bf30a0107 100644
--- a/Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cpcap-charger.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/cpcap-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/cpcap-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Motorola CPCAP PMIC charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml b/Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml
index 96336b05d76d..b289388952bf 100644
--- a/Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/dlg,da9150-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/dlg,da9150-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/dlg,da9150-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Dialog Semiconductor DA9150 Charger Power Supply bindings
 
diff --git a/Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml b/Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml
index 30c2fff7cf92..d47caf59d204 100644
--- a/Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml
+++ b/Documentation/devicetree/bindings/power/supply/dlg,da9150-fuel-gauge.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/dlg,da9150-fuel-gauge.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/dlg,da9150-fuel-gauge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
 
diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
index 76c227a7cd5c..46527038bf22 100644
--- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019-2020 Artur Rojek
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/ingenic,battery.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/ingenic,battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Ingenic JZ47xx battery bindings
 
diff --git a/Documentation/devicetree/bindings/power/supply/isp1704.yaml b/Documentation/devicetree/bindings/power/supply/isp1704.yaml
index 4c91da70011d..7e3449ed70d4 100644
--- a/Documentation/devicetree/bindings/power/supply/isp1704.yaml
+++ b/Documentation/devicetree/bindings/power/supply/isp1704.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/isp1704.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/isp1704.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for NXP ISP1704 USB Charger Detection
 
diff --git a/Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml b/Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
index 518eabb63588..a99d989f1450 100644
--- a/Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/lego,ev3-battery.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/lego,ev3-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: LEGO MINDSTORMS EV3 Battery
 
diff --git a/Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml b/Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml
index e2d8d2aebb73..76cedf95a12c 100644
--- a/Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/lltc,lt3651-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/lltc,lt3651-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analog Devices LT3651 Charger Power Supply bindings
 
diff --git a/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml b/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
index 043bf378040f..109b41a0d56c 100644
--- a/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
+++ b/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/lltc,ltc294x.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/lltc,ltc294x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for LTC2941, LTC2942, LTC2943 and LTC2944 battery fuel gauges
 
diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
index 6d7aa97a6475..cfffaeef8b09 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Topic Embedded Products
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/ltc4162-l.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/ltc4162-l.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Linear Technology (Analog Devices) LTC4162-L Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml
index 818647edf63d..c838efcf7e16 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/maxim,ds2760.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/maxim,ds2760.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Maxim DS2760 DT bindings
 
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml
index 0a41078ebd99..070ef6f96e60 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max14656.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/maxim,max14656.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/maxim,max14656.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Maxim MAX14656 DT bindings
 
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
index 6b4588a3253b..3a529326ecbd 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/maxim,max17040.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/maxim,max17040.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Maxim 17040 fuel gauge series
 
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 971b53c58cc6..aff5d0792e0f 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/maxim,max17042.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/maxim,max17042.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Maxim 17042 fuel gauge series
 
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
index 4828ca0842ae..a8d625f285f1 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/maxim,max8903.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/maxim,max8903.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Maxim Semiconductor MAX8903 Battery Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml b/Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
index 4a1489f2b28d..5178e6207271 100644
--- a/Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/nokia,n900-battery.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/nokia,n900-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Nokia N900 battery
 
diff --git a/Documentation/devicetree/bindings/power/supply/olpc-battery.yaml b/Documentation/devicetree/bindings/power/supply/olpc-battery.yaml
index 0bd7bf3b8e1b..dd89e2532a07 100644
--- a/Documentation/devicetree/bindings/power/supply/olpc-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/olpc-battery.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/olpc-battery.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/olpc-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: OLPC Battery
 
diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
index 9a490fbd32e1..2f672e6e8d72 100644
--- a/Documentation/devicetree/bindings/power/supply/power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/power-supply.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/power-supply.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Power Supply Core Support
 
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
index ae647d3355a2..756c16d1727d 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/richtek,rt5033-battery.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/richtek,rt5033-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Richtek RT5033 PMIC Fuel Gauge
 
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
index e1c233462f29..bce15101318e 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/richtek,rt9455.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/richtek,rt9455.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Binding for Richtek rt9455 battery charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
index b62c2431f94e..eeb043f9bb4f 100644
--- a/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/sc2731-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/sc2731-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Spreadtrum SC2731 PMICs battery charger binding
 
diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
index e019cffd1f38..d90a838a1744 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
 
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
index 4b8a00cec39c..525abdfb3e2d 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-btemp.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-btemp.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/stericsson,ab8500-btemp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: AB8500 Battery Temperature Monitor
 
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
index 6799224f7fb4..10bbdcfc87b6 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-chargalg.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-chargalg.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/stericsson,ab8500-chargalg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: AB8500 Charging Algorithm
 
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
index 9518eb7289d0..e33329b3af61 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/stericsson,ab8500-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: AB8500 Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
index 2ce408a7c0ae..6a724ca90e99 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-fg.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2021 Sebastian Reichel
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/stericsson,ab8500-fg.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/stericsson,ab8500-fg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: AB8500 Fuel Gauge
 
diff --git a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
index ce0bca4689f6..2d552becbfe6 100644
--- a/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/summit,smb347-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/summit,smb347-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Battery charger driver for SMB345, SMB347 and SMB358
 
diff --git a/Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml b/Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml
index f2dd38bf078c..586745426341 100644
--- a/Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/tps65090-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/tps65090-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TPS65090 Frontend PMU with Switchmode Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
index 2c2fe883bb48..7ccf0cdffd3e 100644
--- a/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/tps65217-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/tps65217-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TPS65217 Charger
 
diff --git a/Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml b/Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml
index fe3f32a0ea79..d8d3154f9cb1 100644
--- a/Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/twl4030-charger.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/twl4030-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TWL4030 BCI (Battery Charger Interface)
 
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
index de6a23aee977..5c8369fd3ef7 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-ac-power-supply.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/x-powers,axp20x-ac-power-supply.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/x-powers,axp20x-ac-power-supply.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: AXP20x AC power-supply
 
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index d055428ae39f..e0b95ecbbebd 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/x-powers,axp20x-battery-power-supply.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/x-powers,axp20x-battery-power-supply.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: AXP20x Battery power-supply
 
diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index 0c371b55c9e1..3ce648dd91bd 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/supply/x-powers,axp20x-usb-power-supply.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/supply/x-powers,axp20x-usb-power-supply.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: AXP20x USB power-supply
 
-- 
2.34.1

