Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E423553F1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiFFVXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiFFVWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:22:54 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60ABAF1E4;
        Mon,  6 Jun 2022 14:22:50 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id b17so8544689ilh.6;
        Mon, 06 Jun 2022 14:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pf2B4FSJK7608hLvnpAYav2nA2W599D/4iTv+srNSs=;
        b=YvTjLCs/GhdoRBH7K4lGTqEB0qTlWAfNBKifadPiMs4oPpMgrMxttQg5OKXdBDJIBu
         1Wn7Z89jCGeVV/ZrWWvfWcBe7mvrFuF82jpIHb+uJoJbZkLqCN3khPrL2Gq8N0c7yoqn
         JzmPGfTefUVP3Yn2/E96Csd3xRDUBVsdydjuhGBcg02MOYjFpEZORVfC7JaO+YHuExKp
         3NvKWVzx1ZTYJ6UcIjNvETQK4ZtQemELan6gdXOR5H892X1Jqb1DiUZnLcqYTTpivJbr
         fcfRS90MW5/0IJm/2DeP/Gut7Cb6TWoWI77V2/RJ/SFwPKU4/4PxNiBCshZDe2dvwSNp
         P7MQ==
X-Gm-Message-State: AOAM53144PIfOkUO+QhcqqwaWibCBH4lZLt4yDazwSP+f0MyGycGGgPj
        9l1gELRbURAYZ+/ddiw7kA==
X-Google-Smtp-Source: ABdhPJxbW+UpGVuSMf9cBUMN4PnJ2WZCz877Z7QkEw9XczTlKcHB6fCUnLzyGocI9r1qnK6lDx99dg==
X-Received: by 2002:a05:6e02:1a81:b0:2d3:8754:f7ef with SMTP id k1-20020a056e021a8100b002d38754f7efmr14685460ilv.184.1654550569664;
        Mon, 06 Jun 2022 14:22:49 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id o1-20020a056e02102100b002d3ca0d55d0sm6600600ilj.48.2022.06.06.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:22:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: ralink: Fix 'enum' lists with duplicate entries
Date:   Mon,  6 Jun 2022 16:22:39 -0500
Message-Id: <20220606212239.1360877-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to list the same value twice in an 'enum'. This was fixed
treewide in commit c3b006819426 ("dt-bindings: Fix 'enum' lists with
duplicate entries"), but this one got added in the merge window.

A meta-schema change will catch future cases.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/ralink,mt7620-pinctrl.yaml        | 26 +++++++++++-------
 .../pinctrl/ralink,rt305x-pinctrl.yaml        | 27 +++++++++----------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index 4d820df24b89..6f17f3991640 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -32,31 +32,37 @@ patternProperties:
           groups:
             description: The pin group to select.
             enum: [
+              # common
+              i2c, spi, wdt,
+
               # For MT7620 SoC
-              ephy, i2c, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi, spi refclk,
-              uartf, uartlite, wdt, wled,
+              ephy, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi refclk,
+              uartf, uartlite, wled,
 
               # For MT7628 and MT7688 SoCs
-              gpio, i2c, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
+              gpio, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
               p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn, perst, pwm0,
-              pwm1, refclk, sdmode, spi, spi cs1, spis, uart0, uart1, uart2,
-              wdt, wled_an, wled_kn,
+              pwm1, refclk, sdmode, spi cs1, spis, uart0, uart1, uart2,
+              wled_an, wled_kn,
             ]
 
           function:
             description: The mux function to select.
             enum: [
+              # common
+              gpio, i2c, refclk, spi,
+
               # For MT7620 SoC
-              ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa,
-              pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf, refclk,
-              rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite, wdt refclk,
+              ephy, gpio i2s, gpio uartf, i2s uartf, mdio, nand, pa,
+              pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf,
+              rgmii1, rgmii2, sd, spi refclk, uartf, uartlite, wdt refclk,
               wdt rst, wled,
 
               # For MT7628 and MT7688 SoCs
-              antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn,
+              antenna, debug, i2s, jtag, p0led_an, p0led_kn,
               p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
               p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1, pwm_uart2,
-              refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1,
+              rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi cs1,
               spis, sw_r, uart0, uart1, uart2, utif, wdt, wled_an, wled_kn, -,
             ]
 
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 425401c54269..f602a5d6e13a 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -33,32 +33,29 @@ patternProperties:
           groups:
             description: The pin group to select.
             enum: [
+              # common
+              i2c, jtag, led, mdio, rgmii, spi, spi_cs1, uartf, uartlite,
+
               # For RT3050, RT3052 and RT3350 SoCs
-              i2c, jtag, mdio, rgmii, sdram, spi, uartf, uartlite,
+              sdram,
 
               # For RT3352 SoC
-              i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1, uartf,
-              uartlite,
-
-              # For RT5350 SoC
-              i2c, jtag, led, spi, spi_cs1, uartf, uartlite,
+              lna, pa
             ]
 
           function:
             description: The mux function to select.
             enum: [
+              # common
+              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, mdio,
+              pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1, uartf,
+              uartlite, wdg_cs1,
+
               # For RT3050, RT3052 and RT3350 SoCs
-              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio, pcm gpio,
-              pcm i2s, pcm uartf, rgmii, sdram, spi, uartf, uartlite,
+              sdram,
 
               # For RT3352 SoC
-              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, lna, mdio,
-              pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1, uartf,
-              uartlite, wdg_cs1,
-
-              # For RT5350 SoC
-              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, pcm gpio,
-              pcm i2s, pcm uartf, spi, spi_cs1, uartf, uartlite, wdg_cs1,
+              lna, pa
             ]
 
         required:
-- 
2.34.1

