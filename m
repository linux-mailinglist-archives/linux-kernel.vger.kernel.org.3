Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E345A3DCD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiH1NeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiH1Ndw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 09:33:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035C24F22
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:33:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r4so7268017edi.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=olNapHSIxEXV/j68X2DSb6GA5s0CD+ILvvqYswhlRrM=;
        b=ptcQCXsHLLK3toTiJrVtNK1GifF5qfJRikV8CrxsZ2iTVLvrah6mSolRcQRnLycQ3P
         2dP3PGOipJStLIrORwrRYWysk8kuT3rvjaZt1boB1h/6cJ9L5HimwPp4tZMPDtM5TxOb
         OIRFEAgYPxIOIHEbFztlN6D76NLngRU5Kg8Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=olNapHSIxEXV/j68X2DSb6GA5s0CD+ILvvqYswhlRrM=;
        b=mr0fSAXqrXgbWb7VviJezVRsz+Ei8L5cl4qIS+RZ/DKTiQsSvR6kkgpF+YgXn0JIXd
         6kGXbQj0T39GzPFI0Zih4bzbmrRKQf+2K2/VedbW9weyhG8X6y7oRcX3tWu4LudUDBFb
         lncocCV5AW7rfeRvuC8h6QbR3ZKIsH9+DYNj6gBIZwKDFtBEN91pT2yKReFnXxymeLJL
         DgmLz+jeLBW4HIaovbZ2zJXV+aeYCJnAcZ6nMnEVdRxWomJ4FJDcQlL78wGrqwNL7Kl1
         BCLdaIJlGI7FB6hl03ZeW0aG8C9a1fcpsctEd7A6L84oDS4pvpfHGlNOpGS8qQPoz3nm
         g6bg==
X-Gm-Message-State: ACgBeo1tomPBmJwdx1tkXjqZU/lZzP1zD24WGUIBI+yiKPGOCHAi0gy1
        9gxEMrLdGnlgjzpJYgzcXvceUS553ODlqg==
X-Google-Smtp-Source: AA6agR4C0hyJ+1kxqMtNtBNnuPblwiwNAMjYnzqwkv9YZm3cFwmNajdCri4JsEkrluZM4XKIVzLCfw==
X-Received: by 2002:a05:6402:3596:b0:447:11ea:362d with SMTP id y22-20020a056402359600b0044711ea362dmr13480103edc.117.1661693622388;
        Sun, 28 Aug 2022 06:33:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id u26-20020a1709064ada00b007313a25e56esm3247669ejt.29.2022.08.28.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 06:33:41 -0700 (PDT)
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
Subject: [RFC PATCH v3 3/4] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date:   Sun, 28 Aug 2022 15:33:28 +0200
Message-Id: <20220828133329.793324-4-dario.binacchi@amarulasolutions.com>
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

Add pin configurations for using CAN controller on stm32f469-disco
board. They are located on the Arduino compatible connector CN5 (CAN1)
and on the extension connector CN12 (CAN2).

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Remove a blank line.

Changes in v2:
- Remove a blank line.

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 500bcc302d42..8a4d51f97248 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -448,6 +448,36 @@ pins2 {
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
 		};
 	};
 };
-- 
2.32.0

