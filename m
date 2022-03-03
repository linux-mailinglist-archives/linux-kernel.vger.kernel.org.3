Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD24CC392
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiCCRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiCCRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:19:22 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3DD1768EA;
        Thu,  3 Mar 2022 09:18:36 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id t11so6595060ioi.7;
        Thu, 03 Mar 2022 09:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WF3B5MhmM4VMTKxqIPbUl7+aYszdv2qaJTWGu36x48=;
        b=njhaYPGdjPvmw5QM90U49Q4Ymshn7zeqlSQBGMVtO8tQUksrPUiBsclxp8+rFi9ejq
         sK1nbemdUcaiqMXQFYMBUwIdBdznC7wjzlJ9M6b7OhlpjEyBVitzBw63TroEw8CDOuhK
         VWtY4HTnBwfeY4Wy9e1px7iFzt/SC4fxE9D8R9QPF6l78P5XqwFXbsaL8MV8ld073yOR
         oy4dhyXK+Hsg3NA4RH3uEtni1/kSzGIKbexmIAJ1W/U/9eilRNpDgcpJWllPJ3kC6XVP
         6S10wA+gDKgHCYi+eMf97q7iBP+u/CS5Qp6zhqercoCtowW9znXpTgF2tHVhjptmy3ZZ
         +Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0WF3B5MhmM4VMTKxqIPbUl7+aYszdv2qaJTWGu36x48=;
        b=pKaVR1+lMotTK+Uta4xLqJBFwuvcrSNjYZra4BneIXv5B0/twxEMqzZAH6nGFGVB3A
         OqK9y+ZuAonDljHA2n8CaMx1tnI9rNpdn6PvVKJGD8zBTC3d97GdBFSCLl/uyzKnCAZy
         T5Ydm9bnSPtQ6UUTaV3B1xuJj5g7wk6X5i9IYSNXVPzbJsKUAk0ON04Ev89HYHk+9bwh
         NQDyPEOhrafLHlhyeY97CHRC3yoicREx01bDePmxduduAZsjEXzSMuBN2fGRBovJe+hC
         FaP5cCnEx0lTZGJywFldyNS4FHvt7UWdMXu0LLWC+oFHUGm1aKdytsZTusfSQ9KPMMLh
         xTwQ==
X-Gm-Message-State: AOAM530ohHMc++tPUk6BG7+Qk8wBAcalMiKG6QvBT3pRgAVGv1DM7ajZ
        U98LhBMqOjT5NsbTg44XPM2uAamknowQZA==
X-Google-Smtp-Source: ABdhPJwwZbYuhjgp3vYy95ehiMEQUCMr4P3uLS4JxL0pUCEASWodXfSIWznGeLwWsW6fTXDebSdzig==
X-Received: by 2002:a02:1183:0:b0:314:4120:1fbe with SMTP id 125-20020a021183000000b0031441201fbemr30693303jaf.129.1646327915784;
        Thu, 03 Mar 2022 09:18:35 -0800 (PST)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id b11-20020a92c56b000000b002c5ff65adffsm3016655ilj.31.2022.03.03.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:18:35 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: logicpd-som-lv: Move pinmuxing to peripheral nodes
Date:   Thu,  3 Mar 2022 11:18:18 -0600
Message-Id: <20220303171818.11060-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220303171818.11060-1-aford173@gmail.com>
References: <20220303171818.11060-1-aford173@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some pinmux references to their respective peripherals.
This keeps the pins in safe-mode until they are requested.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/logicpd-som-lv.dtsi
index 55b619c99e24..9ba0ea4eb48a 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -27,6 +27,8 @@
 
 	/* HS USB Host PHY on PORT 1 */
 	hsusb2_phy: hsusb2_phy {
+		pinctrl-names = "default";
+		pinctrl-0 = <&hsusb2_reset_pin>;
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>; /* gpio_4 */
 		#phy-cells = <0>;
@@ -144,6 +146,8 @@
 };
 
 &usbhshost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hsusb2_pins>;
 	port2-mode = "ehci-phy";
 };
 
@@ -151,10 +155,7 @@
 	phys = <0 &hsusb2_phy>;
 };
 
-
 &omap3_pmx_core {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb2_pins>;
 
 	mmc3_pins: pinmux_mm3_pins {
 		pinctrl-single,pins = <
@@ -250,8 +251,7 @@
 };
 
 &omap3_pmx_wkup {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hsusb2_reset_pin>;
+
 	hsusb2_reset_pin: pinmux_hsusb1_reset_pin {
 		pinctrl-single,pins = <
 			OMAP3_WKUP_IOPAD(0x2a0e, PIN_OUTPUT | MUX_MODE4)	/* sys_boot2.gpio_4 */
-- 
2.17.1

