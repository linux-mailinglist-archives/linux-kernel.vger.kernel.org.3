Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8425971AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiHQOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbiHQOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:37:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C60D9AFF2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:36:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gk3so24884740ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Y2S6KTpUrSCMwTgBob27SzJraLan/JemfvDuj7xYqWU=;
        b=LkqmS/nuTe4L0Rkupi4DsAJtXZkFTQdISkC/iyB9PtyA61yMaF4nlGSkeusqWlMUnt
         r1fpeENu4q1L+v9eZWbahHChXADG73IE+n1pKrNirWQ4scowLEMgKA/qBgXHSlaHne82
         OKYe7NbnNB/MHuqRv+fgyiTrnHazfpqINvQTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Y2S6KTpUrSCMwTgBob27SzJraLan/JemfvDuj7xYqWU=;
        b=cZUIxRWWOUfGRS8Nv6igEGfYh9GSejVKsK1Vj1FPbnJEoIWStmWqqNi2vvVe1NcmLV
         hSswRCHWnmsElLN+auHdYyW0sG/85k7CwK+Zu0on+NJsO8S1vOmNvoyWv3P45eAbLh1Z
         E8KrRWE4ovBpHCSLFsTib/IqWciK7ehYC6amw9FOkKzF6UokxNHscAdFUz/W6aP+J8qj
         KWYsuucq5KjCoQe0wtTY72OUGwMolQtSLRmRgVF/aVhlWgasVfAQQ0ICl+FDSWLnB9gs
         HncnGffRDq57cfDBzl1CT2ItPWBlvZeZHHnSKxHsvvvwxvAMhwEes5wzMdb1m7Xnuwtn
         33Kg==
X-Gm-Message-State: ACgBeo3Iwre73GVZ6CFjH5hOVFpho3BzIc00hP9J4D8jR3jM65Clggnp
        rTQxz1uKs89nks5LwMumDFE5zoqI/ruOmw==
X-Google-Smtp-Source: AA6agR5QoDhPcIJQaxJ2yFbqnXDQ3RBBK8iLVB4b1GWGJHjhlhrI9ZiYMXiQ8QwQXSapwkM9ekdeuA==
X-Received: by 2002:a17:907:2e0b:b0:730:8aee:d674 with SMTP id ig11-20020a1709072e0b00b007308aeed674mr17258033ejc.104.1660747004949;
        Wed, 17 Aug 2022 07:36:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c7c9000000b0043cab10f702sm10711982eds.90.2022.08.17.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:36:44 -0700 (PDT)
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
Subject: [RFC PATCH 3/4] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date:   Wed, 17 Aug 2022 16:35:28 +0200
Message-Id: <20220817143529.257908-4-dario.binacchi@amarulasolutions.com>
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

Add pin configurations for using CAN controller on stm32f469-disco
board. They are located on the Arduino compatible connector CN5 (CAN1)
and on the extension connector CN12 (CAN2).

Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 500bcc302d42..a8709363898a 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -448,6 +448,38 @@ pins2 {
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
+
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

