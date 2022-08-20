Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2059AC9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbiHTIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344474AbiHTIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:30:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADFF19C22
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:30:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so8062355edd.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lWZi59XScjXJ80MDC5jcujdInKKUzRF+AceVZxJZy/4=;
        b=Pl93p40mRr8ZVgXAZEBtmxL0RVPcWJvjmkqG8a948yFu/ef/W2+raIBtyhHGdWm09s
         nU6ic8dp1mnqm5/vjmuSHXbsApqkyjH8ItftqqFupeIyM9/DD0XnM8OYLB73hvXTbU22
         cK+rXh91VdHklECBq3ziG39pN/2/+f7GjRiMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lWZi59XScjXJ80MDC5jcujdInKKUzRF+AceVZxJZy/4=;
        b=jsTkMacxdSIrLcpW4HHOFE1+OsI8rXh2v0+nkcayGzPErfyH+t6GsMQe+8C07yRGgI
         fEamhNrT8UhW7GUdU8jp+n36t/i2mFbxdvarY9lJsFZ8BogSwmlKhDUKmp9nP6Vt2tCd
         TjWw7t9kkvx134QUbMrhnmAkBb48RudPD9FVzO2nymXtCv12taz+iXvYZT3XtcfLlF33
         WjEtv6T8VGrPbaQvhaWoIq2jV/pMPZMJCwmt8F80d15U/out4UE7oxCOiUwoqsyuKrtR
         3NEb8/+S5wD1CNRYRlpDH6bFOF2CtZ9zU3GbPjkIeng3J+jTNB4BqxmA0dYYYeYg+k2p
         cPKQ==
X-Gm-Message-State: ACgBeo3JUAbzuXZH49eYGtx+7zGMZjsnFGo5tJM3LKtkTqEmRpKmK+9e
        WYiZFku8QwqsGSWfQjxyEGfIB6V60DMMkg==
X-Google-Smtp-Source: AA6agR6HoVv6K1JfDzqNlGHyOC7s8UkuUTM/czwKoSt7sLoTofnhIwzulOB9wBrhLPMwFJfWrreqVw==
X-Received: by 2002:a05:6402:3288:b0:446:5d0b:1b26 with SMTP id f8-20020a056402328800b004465d0b1b26mr3270132eda.379.1660984209209;
        Sat, 20 Aug 2022 01:30:09 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id gx14-20020a1709068a4e00b0072b33e91f96sm3336112ejc.190.2022.08.20.01.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 01:30:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 3/4] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date:   Sat, 20 Aug 2022 10:29:35 +0200
Message-Id: <20220820082936.686924-4-dario.binacchi@amarulasolutions.com>
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

Add pin configurations for using CAN controller on stm32f469-disco
board. They are located on the Arduino compatible connector CN5 (CAN1)
and on the extension connector CN12 (CAN2).

Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Remove a blank line.

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 500bcc302d42..3a9c3180fbf9 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -448,6 +448,37 @@ pins2 {
 					slew-rate = <2>;
 				};
 			};
+
+			can1_pins_a: can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_a: can2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 5, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_b: can2-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
 		};
 	};
 };
-- 
2.32.0

