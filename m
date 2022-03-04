Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD14A4CDEC9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiCDU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiCDU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:26:04 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA31D0070;
        Fri,  4 Mar 2022 12:25:15 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so10741026ooi.0;
        Fri, 04 Mar 2022 12:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2leSR+w5bTctzREP5AnWxoEwKFay0mOm19jh++azBk=;
        b=nbK7kqYN2YHK5xI76tQlbSP3S1uFTj64kfvvv31vlL3wlCenUv6wJs6So+hO/+skPo
         CYVCymzw6MPCQaJMiDjuV228zmoeqr3IVIvbwm2YKO2cg/bYVI5gdZ8Rlmaw5S8v8J0w
         S+tLKxZUv2clILrmVKIzUjZcM1yTlrgEJHcKKYr5czaKUTwZeddZnEQMR8CnSXmw1TTK
         lUNHhpNqL0DVChv/ZVUH0U7+MWJHT6zWNbXeX6bsOgh0sKbf6oFTLbkotI0KauMy0S0k
         jDqCjdmtJvsntHNrwiyvjCdcv8EutOJq3kreoZwWcy7KhRF47B2BI8MVr26yqpx9v1zM
         YGKw==
X-Gm-Message-State: AOAM532B0o6nylP7Tv4P7uSZ9+mA+WrUBr6sA0OdvVy85e9Xty/JvST/
        VwV+HqcKosmCPdt6rJW8bpaifNhdTg==
X-Google-Smtp-Source: ABdhPJyLpo2AhNqZ8/s2T2daPmQdsOu4VP0Zxnm76QtpOqDn0uZgHGyVGjzAJVxNT1OmzYVIrXVF4g==
X-Received: by 2002:a05:6870:648a:b0:da:b3f:3264 with SMTP id cz10-20020a056870648a00b000da0b3f3264mr104650oab.276.1646425514795;
        Fri, 04 Mar 2022 12:25:14 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x14-20020a05680801ce00b002d97bda386fsm2963324oic.52.2022.03.04.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:25:14 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: at91: Fix boolean properties with values
Date:   Fri,  4 Mar 2022 14:24:45 -0600
Message-Id: <20220304202446.315085-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

