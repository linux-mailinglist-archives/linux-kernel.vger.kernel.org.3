Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF24C2046
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbiBWXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244968AbiBWXwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:52:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB59289AB;
        Wed, 23 Feb 2022 15:51:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so366998wra.12;
        Wed, 23 Feb 2022 15:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwWZUUDsswrZA948f1HZKCXBpwnf3xULN67HcuVPzLg=;
        b=X19i23nJVEeDiq9/hstKiwqUZwyJTvZpq+vlM+fCTYV8KWV+W9KfAW/bCucDzpVZps
         Wp2WIx0FnPIBxoIsg+rdX88BBpNHFe0ueio+ofll7AyvCUO4m/rmlla4CmKE60H2Ng/s
         zb2jXhQsxcR8XJzWZC2ZnugYy4kuI0Ny4s/ILfwpx+Ijbm8b1hJLe6nNrWwQjeoWIUa2
         3xWUIfMEEtObrD7xiUKAkA9GIMW/tFe9qbHCsweGBQ+07+M7mrJHdogW1bgdnDU1MbPx
         gV/8dzEtFvkvJRPF7vbfTb/Ej5iC5H4bQ5IBhW/Jfm0mKSR3Z/8R6yJCiRTcW5v7YEw0
         qRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwWZUUDsswrZA948f1HZKCXBpwnf3xULN67HcuVPzLg=;
        b=HuOeraHnWCDVMw2sJ7HRduWQurUIGX141ftILaW41REdzUagZC8C6Cpvia+q32m8yX
         od8UbEGgvjJ9BdxbFGgEaGHieFdHA1JW2VM//EsyA4GEMm9bEnHJzG8GNFXIqCfb9G4B
         J1yx2sTkOgaQX9qwRrAhRSGxlrl6BABL8rwlXVeCWtBNl8+Kw9FXaDiV0Wr34lXw3wsX
         b8HSGVI3ILcRcuy7aX4iFcePyogc1VcS7PfGAdmXBZKCljPpO3WbkDV7K2Zrs1uXI369
         5UGp5z5fpulBzZu2IGrzVqSTer30vQOw3UUB+sDIAiN2oGi9DnWisEE2CFKqtp2aAiAn
         1IhQ==
X-Gm-Message-State: AOAM531UoRo/2+6qpENRaWzv/jRnEkfsjRXfpj3h+uSCHOHcs9PnX9HF
        UL5Amd9WwJ6MVxhSSHbNTrU=
X-Google-Smtp-Source: ABdhPJy6/DkkUk1vrQvaC0Ly/sVOrK6KcVVXxlaLeNxXJiSnrahLCzz06pQxrZlSSwAJLlBtUWA07w==
X-Received: by 2002:a5d:4381:0:b0:1ed:c412:e7cc with SMTP id i1-20020a5d4381000000b001edc412e7ccmr87579wrq.66.1645660296382;
        Wed, 23 Feb 2022 15:51:36 -0800 (PST)
Received: from localhost.localdomain ([2603:c020:c001:7eff:ffff:ffff:ffff:ff00])
        by smtp.googlemail.com with ESMTPSA id s7sm943591wri.5.2022.02.23.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:51:36 -0800 (PST)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: NSP: MX6X: correct LED function types
Date:   Wed, 23 Feb 2022 23:50:40 +0000
Message-Id: <20220223235041.2542331-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220223235041.2542331-1-mnhagan88@gmail.com>
References: <20220223235041.2542331-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the amber LED will remain always on. This is due to a
misinterpretation of the LED sub-node properties, where-by "default-state"
was used to indicate the initial state when powering on the device. When in
use, however, this resulted in the amber LED always being on. Instead change
this to only indicate a fault state.

Assign LED_FUNCTION_POWER to the green PWM LED.

These changes bring the MX64/65 in line with the MR32's devicetree.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi       | 3 +--
 arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi     | 3 +--
 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
index ba01054a76cf..58b7d9fc7574 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -57,10 +57,9 @@ led-3 {
 
 		led-4 {
 			/* amber:power */
-			function = LED_FUNCTION_POWER;
+			function = LED_FUNCTION_FAULT;
 			color = <LED_COLOR_ID_AMBER>;
 			gpios = <&gpioa 3 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
 		};
 
 		led-5 {
diff --git a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
index 7c487c74fd10..576cfc52567b 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-kingpin.dtsi
@@ -106,10 +106,9 @@ led-9 {
 
 		led-a {
 			/* amber:power */
-			function = LED_FUNCTION_POWER;
+			function = LED_FUNCTION_FAULT;
 			color = <LED_COLOR_ID_AMBER>;
 			gpios = <&gpioa 0 GPIO_ACTIVE_LOW>;
-			default-state = "on";
 		};
 
 		led-b {
diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
index 5de727de6a4b..b0854d881ac6 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
@@ -22,7 +22,7 @@ led-1 {
 		};
 
 		led-2 {
-			function = LED_FUNCTION_INDICATOR;
+			function = LED_FUNCTION_POWER;
 			color = <LED_COLOR_ID_GREEN>;
 			pwms = <&pwm 2 50000>;
 			max-brightness = <255>;
-- 
2.27.0

