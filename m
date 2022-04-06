Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E24F6BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiDFUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiDFUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:53:28 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FA9FFF76;
        Wed,  6 Apr 2022 12:09:49 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-de3eda6b5dso4037889fac.0;
        Wed, 06 Apr 2022 12:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nkvvt5iU3/huYVMTWpqmeVmasOECJdxAJG738D8isiA=;
        b=OKWvqx7hcaKUS/28ToViBmpMK0cuazkpiIkPLGVzHVCNju/1O0JgfrlscSu44yFLqA
         f59T54LRbdIpBAMUM1TpK6XgrhmaKmtLuGqNJzxiCHQkEMOZvsxNXLCU328KWOEJggNc
         Z2ReyLQ6AhvWz2cVAIanWUQcPBJVNkeXs1/zbxeAU/0V37jp1rmIxF70V4Bsi+2YhStb
         jMcVWu4o5VXUgFQqysqIQFBmJ4vdea3Hqrv4oVk/0LZASYK5SbUFQqbzUau6sZn//eLe
         LZlixLmp/OvajG6ThkWfDKF2HUK5fan3ob0r1EK+0VRuRAEfwN3dDNMIdnTwv7oDYnbL
         DHtw==
X-Gm-Message-State: AOAM532x1LV8EvZEfD3TnYzQPZ5dSXEzREBz4afbcC3RzhGlTOeCvFkJ
        1FGwTORK3dCx+qUpo7vvUg==
X-Google-Smtp-Source: ABdhPJw25u3J4jdicjV95QI6NUKAkXMnWtfFRhrT2nJEQpb3wVemqoBH7x9wlwuPgFzL3oA/pMeSGw==
X-Received: by 2002:a05:6870:2103:b0:de:29de:12c4 with SMTP id f3-20020a056870210300b000de29de12c4mr4829087oae.203.1649272188810;
        Wed, 06 Apr 2022 12:09:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a056808090100b002da82caced5sm6676892oih.3.2022.04.06.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:09:48 -0700 (PDT)
Received: (nullmailer pid 2604082 invoked by uid 1000);
        Wed, 06 Apr 2022 19:09:47 -0000
Date:   Wed, 6 Apr 2022 14:09:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] arm: dts: at91: Fix boolean properties with values
Message-ID: <Yk3leykDEKGBN8rk@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.32.0
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

Boolean properties in DT are present or not present and don't take a value.
A property such as 'foo = <0>;' evaluated to true. IOW, the value doesn't
matter.

It may have been intended that 0 values are false, but there is no change
in behavior with this patch.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Can someone apply this for 5.18 please.

 arch/arm/boot/dts/at91-kizbox3-hs.dts      | 2 +-
 arch/arm/boot/dts/at91-kizbox3_common.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/at91-kizbox3-hs.dts
index 2799b2a1f4d2..f7d90cf1bb77 100644
--- a/arch/arm/boot/dts/at91-kizbox3-hs.dts
+++ b/arch/arm/boot/dts/at91-kizbox3-hs.dts
@@ -225,7 +225,7 @@ pinctrl_pio_zbe_rst: gpio_zbe_rst {
 		pinctrl_pio_io_reset: gpio_io_reset {
 			pinmux = <PIN_PB30__GPIO>;
 			bias-disable;
-			drive-open-drain = <1>;
+			drive-open-drain;
 			output-low;
 		};
 		pinctrl_pio_input: gpio_input {
diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
index abe27adfa4d6..465664628419 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -211,7 +211,7 @@ pinctrl_flx4_default: flx4_i2c6_default {
 		pinmux = <PIN_PD12__FLEXCOM4_IO0>, //DATA
 		<PIN_PD13__FLEXCOM4_IO1>; //CLK
 		bias-disable;
-		drive-open-drain = <1>;
+		drive-open-drain;
 	};
 
 	pinctrl_pwm0 {
-- 
2.32.0

