Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69505481C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiFMIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiFMIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:16:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58AD13D20;
        Mon, 13 Jun 2022 01:16:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g25so9607194ejh.9;
        Mon, 13 Jun 2022 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sX3VNzAmkYzYiqkFhxZchgXDARr628j7uPugdvraEco=;
        b=Hkwr/8vIIXL5Mip8iO4G4zSC+ar+w5ErL+9CwekPh9QYH2qjWB6EiXfLYOWiDwwRrc
         xkRYPUR51bdxfw1B+LF6b/efmygJuHEPYCdsJRIxwH4bRin4O0794/gYtYNyOvVqvvcK
         Dq0kS2hy3ByK32doeyvTQmaPVfGC+I4/z+wM/bJ3lUfu98dP+P+QMZ85bzDvyqSXGX/L
         wr6HKiimrQXasbAeW1BTuAFa/dcadKri1AEk7q5Ztq1T0WQTyZGHWho/QkGY7DSCAAT1
         JUcZaaO/Wr9DNZirpYsfWdMcGd4SCLcvuo/Lmwi31lrjOtIwS3bG0MYdfkc9IcvsKqqy
         lcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sX3VNzAmkYzYiqkFhxZchgXDARr628j7uPugdvraEco=;
        b=cn5uka6eCGM2yiXWga3pUgA1/4xv6Luqesr/xOYjbAL3iqweMZLGlLuA5ZQX/qwHzO
         IRPljrmrB3cMNG1P8Ixixe4SwwZxM6FlHSvNnCRiBxQGfLHYoUSlieXYLVDyVjaw5rcQ
         PGytAe7AhKI4ZPxwyIb0E99lHE4/gpGnYndRmJia983ORrTmyw1zgMNRdlTA/pJ+gtuD
         DJWIsjjNmHQEx6r6d5fe5niBzGsd4Du//4izHaSMl0Oc/PvYdUcMVnNjUBbnBTt0GL91
         nyoYsxXA4yZlvwoMVIh5jHXy+aI8eEdVLtymj9FG7FvPbMnc2RrEHOZ/MTa30CapfzNe
         Onyw==
X-Gm-Message-State: AOAM531ytvHndYYS2zVEQEvKI5Lc7auT9xHkwclSockYfjY7RKNnaoIt
        IE8+Dtyoc5B/OQ5NNoH7wG0=
X-Google-Smtp-Source: ABdhPJwxwsPJ+0RsHyGuX9PvEr4j71MqXSuHPr4kTLQFvDVZMWdBiEtg0GVEXKn4ubv+3k/XkujCKw==
X-Received: by 2002:a17:906:5347:b0:712:24cb:b414 with SMTP id j7-20020a170906534700b0071224cbb414mr12953423ejo.341.1655108209302;
        Mon, 13 Jun 2022 01:16:49 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50089ef6db2443adc92.dip.versatel-1u1.de. [2001:16b8:260d:f500:89ef:6db2:443a:dc92])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7d38f000000b0042dd1584e74sm4397781edq.90.2022.06.13.01.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:16:48 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] dt-bindings: clock: Move versaclock.h to dt-bindings/clock
Date:   Mon, 13 Jun 2022 10:16:32 +0200
Message-Id: <20220613081632.2159-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
References: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the clock related dt-binding header files are located in
dt-bindings/clock folder. It would be good to keep all the similar
header files at a single location.

This was discovered while investigating the state of ownership of the
files in include/dt-bindings/ according to the MAINTAINERS file.

This change here is similar to commit 8e28918a85a0 ("dt-bindings: clock:
Move ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
("dt-bindings: clock: Move at91.h to dt-bindigs/clock").

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml | 4 ++--
 arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi          | 2 +-
 drivers/clk/clk-versaclock5.c                                | 2 +-
 include/dt-bindings/{clk => clock}/versaclock.h              | 0
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename include/dt-bindings/{clk => clock}/versaclock.h (100%)

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index 7c331bfbe370..c1b838524064 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -108,7 +108,7 @@ patternProperties:
     properties:
       idt,mode:
         description:
-          The output drive mode. Values defined in dt-bindings/clk/versaclock.h
+          The output drive mode. Values defined in dt-bindings/clock/versaclock.h
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 6
@@ -151,7 +151,7 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clk/versaclock.h>
+    #include <dt-bindings/clock/versaclock.h>
 
     /* 25MHz reference crystal */
     ref25: ref25m {
diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
index 63e7a39e100e..8166e3c1ff4e 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-#include <dt-bindings/clk/versaclock.h>
+#include <dt-bindings/clock/versaclock.h>
 
 / {
 	backlight_lvds: backlight-lvds {
diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
index f5c1d74b738b..d3fc8ffd5b4c 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
@@ -4,7 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clk/versaclock.h>
+#include <dt-bindings/clock/versaclock.h>
 
 / {
 	memory@48000000 {
diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index e7be3e54b9be..b8c556dbeba0 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -24,7 +24,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/clk/versaclock.h>
+#include <dt-bindings/clock/versaclock.h>
 
 /* VersaClock5 registers */
 #define VC5_OTP_CONTROL				0x00
diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindings/clock/versaclock.h
similarity index 100%
rename from include/dt-bindings/clk/versaclock.h
rename to include/dt-bindings/clock/versaclock.h
-- 
2.17.1

