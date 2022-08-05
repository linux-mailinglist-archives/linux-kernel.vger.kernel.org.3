Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9121258AAAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiHEMTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbiHEMTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:19:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65127858B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:19:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t5so3114075edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=MAf7g1yH66QfElwkollldhEjdf2FGegN5lxrXOLWjy0=;
        b=q53Kv+UgtLvMRTdzxh7yngF2st+EZQIAQtMXeXYFgUN80qdO1a5yYwmUS7OwbjzNh/
         TdghSQa8ufvvm0/kCWPmT01tq8rASXhI2s0DIPASdUfhD4g4xsh5rb6daUv+Rknl4tTM
         0XIo8FTW2bzLaZF5pBjfIJbt/i/mMktQ/fxJ6J33QE/wNROxAV1OhVJRi8x6er8VUyD+
         cz8+s6fTZ0hBw6zGQNcjoKTtO+bM88BYp2zn5+RCZVgTe5Y7NR8NQ4e7SToZQ3pxwGVW
         5AH+2DW1LTcJpsSfvL782ZAj32oP7FXQ714N5fTz8gpgu2V2BGt/LCyIa3jBME5ZLlrL
         4MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=MAf7g1yH66QfElwkollldhEjdf2FGegN5lxrXOLWjy0=;
        b=dSJAti/QdoMDiwVYm1AffE06fwg0I2tXK+5q10aakQbr1u54368UhNllOIctY5zkAb
         9ALMqqUNwbvL8meukFcg0kNlcpJqoOG9WoiSJMePYbSjqtELVl0avfXR0PAn+fQJuuEM
         asOgq5dTHNTAzrdd+wnOrf7CWduu9qWl5iNVTVoqewqrAvBTiX9DkHOrO3kiy1qWQGRV
         uprl8y+N4lo77fnFxn912d4epg+ipdE4qa9Y+ouYDufdIG7EtvmFvZIXrlM1LRVAeHXA
         2p04cb1TXhBo+hIKMOhSkcyP/uDJJuliWZvKgjMLu0f92jSwZV0BApMvjfLLV3AOt7oA
         JgQw==
X-Gm-Message-State: ACgBeo0EvSBop4LTgErTVSytvTyoszj9Fs7d62Sf4PoKoSYJtTEh5Ro6
        bmqI8H0oMq62H/WxQbv4BOZjmg==
X-Google-Smtp-Source: AA6agR7RIEEwPz8yN/vPznJuUdG7h5rxeImCRN2lvUK0/EQKUts6mozrxr0q7hOnmN7p3Svvhff7Sw==
X-Received: by 2002:a05:6402:611:b0:43c:cb2d:76c0 with SMTP id n17-20020a056402061100b0043ccb2d76c0mr6436094edv.425.1659701948521;
        Fri, 05 Aug 2022 05:19:08 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-5241-be09-b892-f882-607f-7a79.rev.sfr.net. [2a02:8440:5241:be09:b892:f882:607f:7a79])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0072b3464c043sm1506111ejc.116.2022.08.05.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:19:08 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Subject: [PATCH v3 02/10] DONOTMERGE: arm64: dts: ti: Add pinmux and irq mapping for TPS65219 external interrupts
Date:   Fri,  5 Aug 2022 14:18:44 +0200
Message-Id: <20220805121852.21254-3-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220805121852.21254-1-jneanne@baylibre.com>
References: <20220805121852.21254-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt occurring on PMIC TPS65219 is propagated to SOC
through EXTINTn pin connected to gic500 interrupt controller

Needed for driver testing but official board support pending.
TI commitment is required before board upstream kick-off.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 565b50810579..1f7ce60ecb57 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -294,6 +294,12 @@
 			AM64X_IOPAD(0x00b8, PIN_INPUT, 7) /* (Y7) PRG1_PRU0_GPO0.GPIO0_45 */
 		>;
 	};
+
+	pmic_irq_pins_default: pmic-irq-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0278, PIN_INPUT, 0) /* (C19) EXTINTn */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -352,6 +358,10 @@
 		compatible = "ti,tps65219";
 		reg = <0x30>;
 		system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 
 		buck1-supply = <&vcc_3v3_sys>;
 		buck2-supply = <&vcc_3v3_sys>;
-- 
2.17.1

