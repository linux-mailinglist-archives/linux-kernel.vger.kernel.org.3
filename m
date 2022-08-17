Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2859719C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiHQOhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbiHQOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:37:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B49C2DF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:36:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so17717748edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=44iy7ssOSOFDHgG+aTzhL/TF56VP+7fbMIq0O0tw95M=;
        b=kNgAFIpeBNzIEIzbFVEhGVNc7KO9HKliCbkHTpz445TVm6Yny6hJV+Wih/0fAv4Bqj
         KuH7uUi42qxCwJIZBJVlADidAlLgT3c6Air0Y6H/EOzGU6fHZvTmVRGluRGRFCZ3fWVb
         R1IyQ33PnDOl9yt+WqeiOkgpjILvoB8gy5kc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=44iy7ssOSOFDHgG+aTzhL/TF56VP+7fbMIq0O0tw95M=;
        b=vMG/CJ1amJI2eBDIvELN8ik6QSSKHHd2IC0A0cy2oF/7PZN4QBsQ4RxYH7/tem2rgG
         8/c0z64ezu1N+kB0YAA7sXHwYHdWezRr+SDrrjAgHbituljNVIT13ZGLGKIg+g37QHqH
         u9asi1vgQaoWIWbKgY6CgNPUknAW2lljmpXgQXRI/1cHR0VRkvkFjASj+oTDXsYU4mci
         SHlGDhXgX1/MXqt9mZecRqTBfdY0lGyhvzM8iKc4GnAFScZKZ4ttr2BzaTfMLR9S2D22
         Di9If2sA638hFPv505VFWgEhpZsTWnpOE3YIS8iiK3ymmvBrQTJfKcxLDx3G2jKnPXJA
         pEuA==
X-Gm-Message-State: ACgBeo2O/XFgLmwh+6ngHaeGf4ZVhZMf3zkcRP7Gxd+9L0ay+2RSFyRk
        8gA0gBvoKbp3syjKd6ge8kAaAxLBTUGXTw==
X-Google-Smtp-Source: AA6agR5dD/OGPPqsyDoIs+k9yiUHOrfw19O6SnqvGaolDfVmzq9NpxN/wYeQERg8C3RzotAFaDH/cg==
X-Received: by 2002:a05:6402:10d2:b0:445:d9ee:fc19 with SMTP id p18-20020a05640210d200b00445d9eefc19mr2920832edu.81.1660746997217;
        Wed, 17 Aug 2022 07:36:37 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c7c9000000b0043cab10f702sm10711982eds.90.2022.08.17.07.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:36:36 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dario Binacchi <dariobin@libero.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 2/4] ARM: dts: stm32: add CAN support on stm32f429
Date:   Wed, 17 Aug 2022 16:35:27 +0200
Message-Id: <20220817143529.257908-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817143529.257908-1-dario.binacchi@amarulasolutions.com>
References: <20220817143529.257908-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

 arch/arm/boot/dts/stm32f429.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c31ceb821231..28db387ad5e8 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -362,6 +362,36 @@ i2c3: i2c@40005c00 {
 			status = "disabled";
 		};
 
+		can: can@40006400 {
+			compatible = "st,stm32-bxcan-core";
+			reg = <0x40006400 0x800>;
+			resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			can1: can@0 {
+				compatible = "st,stm32-bxcan";
+				reg = <0x0>;
+				interrupts = <19>, <20>, <21>, <22>;
+				interrupt-names = "tx", "rx0", "rx1", "sce";
+				resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+				master;
+				status = "disabled";
+			};
+
+			can2: can@400 {
+				compatible = "st,stm32-bxcan";
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

