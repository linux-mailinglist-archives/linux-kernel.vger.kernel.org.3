Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5D581274
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiGZL6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiGZL57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:57:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7732EF8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:57:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u17so6081507lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwkQZasg6IBuIX69FQ87eiIi43RzDJyxPSLaxovlxC4=;
        b=kYqEifC17FN7TtUjiBjuAmb1wrChjCst87iBC8TDZ7+xc8vNgwBl2B/DHmo4mtsUTk
         ukHgvpU7hg4sndI3GIByDjcaQPJeBlvQr8pYw+n9B7CX8aDi+7QwW8qL+4zmVIHZe9rD
         zDqLjIx9UR84zUhofG2J+SbCH9xpzcmW6j2abK87ChShLIwY+IkusBLVayEyUfEVUuZH
         as5eQOemkZMLR1sbfhY1Sd4wMqv4fw+pvLTxsnhqbpBea6C5A8Qb0jVVqeqLgaqQa/56
         RbYJvEoLI5xxRb9DURsh2h4t39Cy/0nkA3xIDdOUEltZFfLFnouXJb0kFRvTngXQ9Wvf
         BgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZwkQZasg6IBuIX69FQ87eiIi43RzDJyxPSLaxovlxC4=;
        b=6xJQGKL7OICz4izaVkUS5BDk4+mJpFDV0VR9vEHdvRQoRZIUt1NwlPpccm9e0JuHgl
         Vn1kE/OzgjNXTkFb3y4nd40YNwlHUh3DfYEP5Ni9z//q0AIZ9Kiucvld0YrpoJFp2xVz
         i4CM0PVUxo0o3vmwy22HG4UBzUVuagnwTr+DOD6j/bNItivRP51uVl4bK5rhFsx9HQ3f
         fmfeaKfvPIEVndu1cjYcnK6HDJxeqaWI58GpOhhw570NMENftbESMQ0YElIFg/ZML8Fs
         LfqgIjHbMmVquFr5WijhC8mkvlsXeVIA2cNq+otuMmD1PekGiIybHafioStYWOI5j/d5
         oj9A==
X-Gm-Message-State: AJIora8MuNRunsUxLMjGtqtHhqbi3AAjW5NqePhQCEntPVP9/KvwsPo9
        AbHO+8Kpln8n7H9syQtXxlWf8g==
X-Google-Smtp-Source: AGRyM1sbTSItTpSSwTcmlDwnnQpx/0JkNaISSUBsOMOvGMIufatVh9gvLfu9MyNfud5Jhd7RQsdUlg==
X-Received: by 2002:a05:651c:1208:b0:25e:141e:63a7 with SMTP id i8-20020a05651c120800b0025e141e63a7mr1085274lja.513.1658836675690;
        Tue, 26 Jul 2022 04:57:55 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id g24-20020a19e058000000b0048a7d05739asm222219lfj.4.2022.07.26.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:57:55 -0700 (PDT)
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
Subject: [PATCH 1/3] dt-bindings: power: drop quotes when not needed
Date:   Tue, 26 Jul 2022 13:57:46 +0200
Message-Id: <20220726115748.101015-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Id and schema fields do not need quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml      | 4 ++--
 .../devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml     | 4 ++--
 .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml        | 2 +-
 .../devicetree/bindings/power/brcm,bcm63xx-power.yaml         | 4 ++--
 Documentation/devicetree/bindings/power/renesas,apmu.yaml     | 4 ++--
 .../devicetree/bindings/power/renesas,rcar-sysc.yaml          | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index 4e52ef33a986..5390e988a934 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/amlogic,meson-ee-pwrc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/amlogic,meson-ee-pwrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson Everything-Else Power Domains
 
diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
index 86e5f6513bb3..eab21bb2050a 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
@@ -3,8 +3,8 @@
 # Author: Jianxin Pan <jianxin.pan@amlogic.com>
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson Secure Power Domains
 
diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index 19a194980142..94d369eb85de 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Hector Martin <marcan@marcan.st>
 
 allOf:
-  - $ref: "power-domain.yaml#"
+  - $ref: power-domain.yaml#
 
 description: |
   Apple SoCs include PMGR blocks responsible for power management,
diff --git a/Documentation/devicetree/bindings/power/brcm,bcm63xx-power.yaml b/Documentation/devicetree/bindings/power/brcm,bcm63xx-power.yaml
index 63b15ac6dde4..d867bd6976d8 100644
--- a/Documentation/devicetree/bindings/power/brcm,bcm63xx-power.yaml
+++ b/Documentation/devicetree/bindings/power/brcm,bcm63xx-power.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/brcm,bcm63xx-power.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/brcm,bcm63xx-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: BCM63xx power domain driver
 
diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.yaml b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
index d77fc88050c8..f2cc89e7f4e4 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/renesas,apmu.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/renesas,apmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas Advanced Power Management Unit
 
diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
index 8d56bedd3390..0720b54881c2 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/power/renesas,rcar-sysc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/power/renesas,rcar-sysc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas R-Car and RZ/G System Controller
 
-- 
2.34.1

