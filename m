Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB955A3DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiH1Nd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiH1Ndo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 09:33:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E224F0A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:33:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 2so7287283edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RJr2H0obYN3pbdXZsdt8e1JbQn4d3baYnjPncxC8Sds=;
        b=J46e2leNHzPU4TQrl7M2tfofAsrAQ/U9ei/aP9tvHa5eHX1ABsGsXCprvYYIAGt+/S
         RLg1sDK21NULsyjqqNbkPTRCFdCxlXxSad2gXYyJ4hfNyEQk67PEb41jERPh/zgG/ZVo
         f88xaaVo36j8JDCJqp+4IJbtf+VZnvmG1hgzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RJr2H0obYN3pbdXZsdt8e1JbQn4d3baYnjPncxC8Sds=;
        b=pDOjFga2HYeXnhperjaEhNCidvRdz5+UfC4R+mHFvkoYE1MfunCgaHvNGnnU/twJLX
         wIkJXw7nUd7UbwDger9t0WI6ykPH1JPEnHGwu4HPeXY+Az0gsAuC0McoHo1GTJorEaGp
         IwL2FSYoADBCN3lZjy4dxyr7ieEY5p8IkHtrJg4k+4G+kDgp241skBcJv6DYnt3awGcY
         /ZmQhy5idHB/GmQXaO88KNeeoajogkNvHMZYG3DNt7Dxm4bQK0qvWjxsY1+WIaV4Qih2
         MZIprbdYEj9Rkdyi4FzTs0+G7N71isMtYWkZGAL9dMoBIs+uJBU+bNmvd+H7L4f/1Xkv
         7dig==
X-Gm-Message-State: ACgBeo0pd+RZmXtVJgvTLe1Er7+QYOykZ3/jyNs+UMG26Ox4k8GZjY3i
        83ExH63DpRgQB5BRDNeOgcmJ15iuMGJ+5w==
X-Google-Smtp-Source: AA6agR6pEdfi+YcBAUXSwmbacRCfYOgXN1othTOfvrhzGRq2bayOsuG5Mnhl9CV1tJrsk8vlN3hMNA==
X-Received: by 2002:aa7:cfcb:0:b0:447:b4e5:22fb with SMTP id r11-20020aa7cfcb000000b00447b4e522fbmr12466111edy.190.1661693620710;
        Sun, 28 Aug 2022 06:33:40 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id u26-20020a1709064ada00b007313a25e56esm3247669ejt.29.2022.08.28.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 06:33:40 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v3 2/4] ARM: dts: stm32: add CAN support on stm32f429
Date:   Sun, 28 Aug 2022 15:33:27 +0200
Message-Id: <20220828133329.793324-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220828133329.793324-1-dario.binacchi@amarulasolutions.com>
References: <20220828133329.793324-1-dario.binacchi@amarulasolutions.com>
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

Add support for bxcan (Basic eXtended CAN controller) to STM32F429. The
chip contains two CAN peripherals, CAN1 the master and CAN2 the slave,
that share some of the required logic like clock and filters. This means
that the slave CAN can't be used without the master CAN.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Add "clocks" to can@0 node.

 arch/arm/boot/dts/stm32f429.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c31ceb821231..e04cf73a8caa 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -362,6 +362,37 @@ i2c3: i2c@40005c00 {
 			status = "disabled";
 		};
 
+		can: can@40006400 {
+			compatible = "st,stm32f4-bxcan-core";
+			reg = <0x40006400 0x800>;
+			resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			can1: can@0 {
+				compatible = "st,stm32f4-bxcan";
+				reg = <0x0>;
+				interrupts = <19>, <20>, <21>, <22>;
+				interrupt-names = "tx", "rx0", "rx1", "sce";
+				resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+				clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+				st,can-master;
+				status = "disabled";
+			};
+
+			can2: can@400 {
+				compatible = "st,stm32f4-bxcan";
+				reg = <0x400>;
+				interrupts = <63>, <64>, <65>, <66>;
+				interrupt-names = "tx", "rx0", "rx1", "sce";
+				resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
+				clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
+				status = "disabled";
+			};
+		};
+
 		dac: dac@40007400 {
 			compatible = "st,stm32f4-dac-core";
 			reg = <0x40007400 0x400>;
-- 
2.32.0

