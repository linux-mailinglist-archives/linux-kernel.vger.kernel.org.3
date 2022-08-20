Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4C59AC98
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiHTIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343915AbiHTIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:30:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0474BC823
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:30:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u6so3014471eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nx1RKbMsizbVSq8+ylCW9JB51IkfG+D4F3ijLXe6P6M=;
        b=GV/gDBX5HvPzHyu9Zsc8RdMfDQlo0FHjGGb+Mcsoq3z0kRRQTnrFYX20EeoG2lz97P
         dDL48H2CB1tQLOUalco/1fgcBMsWIgIvFoxfgWZyJY/qPNHcXurEO0FfQrUPDiasbatF
         2QlUM53CNt+JRSdMP+zkMoE6T4lJtJbIX/HgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nx1RKbMsizbVSq8+ylCW9JB51IkfG+D4F3ijLXe6P6M=;
        b=M7v0SKbCoH5DYUp6cyUQDZLtMCdiWqBEqLJqiw2LeOvEkaoYFfsSclHU+JUEaXyb/N
         DCu8uGZFrJFhx8N3FzjOTlAzdKiprRWs4dSnGMwg4przFQtWySCeKIeW18m8GbdxIxSj
         rtubSwbONhjbOAzMwRNN+hhaXNEaneCrcw1/MoP6lQe3Cw9pwEEgf1GvtxkHKMgxxg63
         2BrxVZWkc+t4GBClYko1/6qnIBBAv4ypWhTeXLegH/jFVxn8KQKd2HcScE9duWNHQo5n
         28ZHJiI7sqn1KnQ1MbbqWJjKfqsIq3O23lV2r0j5Tu4T9qJEgzgWOEKxLQf+F9jVt0lk
         C9hw==
X-Gm-Message-State: ACgBeo341o2CIViikpxUv8JNaRa4aWLgP/pYa1ywygH/F78CR9Ckc5kb
        GUgb7juiwrHJTbC+PhYDCAVCWnK/a0Npqw==
X-Google-Smtp-Source: AA6agR7v51mT41Dg8/amu63uXwTPDbEapJMLdnkaqwWUDzIhJtimgGroEloCmS/m+JLyAdhmUyqtqA==
X-Received: by 2002:a05:6402:5249:b0:43c:cb3e:d7f8 with SMTP id t9-20020a056402524900b0043ccb3ed7f8mr9073398edd.56.1660984207889;
        Sat, 20 Aug 2022 01:30:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id gx14-20020a1709068a4e00b0072b33e91f96sm3336112ejc.190.2022.08.20.01.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 01:30:07 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dario Binacchi <dariobin@libero.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v2 2/4] ARM: dts: stm32: add CAN support on stm32f429
Date:   Sat, 20 Aug 2022 10:29:34 +0200
Message-Id: <20220820082936.686924-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220820082936.686924-1-dario.binacchi@amarulasolutions.com>
References: <20220820082936.686924-1-dario.binacchi@amarulasolutions.com>
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

Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/stm32f429.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c31ceb821231..da46d13e7ad4 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -362,6 +362,36 @@ i2c3: i2c@40005c00 {
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

