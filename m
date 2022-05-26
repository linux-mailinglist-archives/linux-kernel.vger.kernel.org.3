Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70BA534999
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbiEZD7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345080AbiEZD7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:59:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E9C0384;
        Wed, 25 May 2022 20:58:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f9so831812ejc.0;
        Wed, 25 May 2022 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vcz1woS/V8hYjYMNg45U+o+J4HSC2868vY4RO60vMw=;
        b=epLA2b0suo+9uDpnG//IXikdMn+Wyxee36k2aA3Kht82S/NLozPxTbhueaH7NO0u29
         a1b1JvkV4pBMjxaLe8sqmLApCvPmjEp0oU/2AMC1mGmmcjThxVGnXOCk/Lejs1lMcejf
         ZhhrqKlBJwf0GdRxkrHmfvzL+JG/bSxzIx6/MoqYmGySrSt7mT8sAxtGh+OKTkqD2ice
         4LcvKvb/azDJH5e8agOWhMT6C1bCUT0CUxt8Gg545XuRKpOMUFsnAUm+BDyHziwnQ0qF
         2wOmY1W+DpEHcY2OdBu61OGRacNUqCzXMSbdMgSx0+V1NaCg3E9tFL4NVrVQssYS0XyA
         o7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vcz1woS/V8hYjYMNg45U+o+J4HSC2868vY4RO60vMw=;
        b=Rh2/j2ed5wixAw7g9dQSpWxZukPnklgJ+kUIEQxaP7cCG66Rat8S1cIunXN37FktR0
         kwl0M8Fn5GpNqAwvwljSGKN4wLdue49tvZsY/Scl9NvARcq5SUtzcXrVl0z4ok1Cciqq
         di9dnq0h4Y3ogaHrWXdAFZiP7Jcf89dAnF5lwxssrvYzMEqJsy/XN3szUiuR/yEICkzo
         ZbSY2o8PgVUSSPxf2sWSiR7jalOs/V85oq8UoRhCf0wOmsBrz/tCi4Ep1qjDVI1Mtxvc
         jnS4nRQO6+QhYy6s0w/7My7VozigeeY+Ze2/17US6JEV2ICdgh5GkQ44eGxsYvGbVZnU
         JcyQ==
X-Gm-Message-State: AOAM531uw97tmv+wbysr3jJGkW8GxRxbNkOWQ3k9J4DzxMC4zPF3GzUv
        Gvd6DlHNBONfw2SXVDu+zgA=
X-Google-Smtp-Source: ABdhPJwqI3vxE35oM5U/7pwVXuajutkWHh5MVFWEkVXgaatShLQx+FQFQRruVUOC49DhkNL5AelnSw==
X-Received: by 2002:a17:907:a420:b0:6ff:2706:592e with SMTP id sg32-20020a170907a42000b006ff2706592emr495520ejc.192.1653537530244;
        Wed, 25 May 2022 20:58:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id c13-20020a50d64d000000b0042617ba63cfsm206621edj.89.2022.05.25.20.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 20:58:49 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: exynos: Correct UART clocks on Exynos7885
Date:   Thu, 26 May 2022 07:58:40 +0200
Message-Id: <20220526055840.45209-3-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526055840.45209-1-virag.david003@gmail.com>
References: <20220526055840.45209-1-virag.david003@gmail.com>
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

The clocks in the serial UART nodes were swapped by mistake on
Exynos7885. This only worked correctly because of a mistake in the clock
driver which has been fixed. With the fixed clock driver in place, the
baudrate of the UARTs get miscalculated. Fix this by correcting the
clocks in the dtsi.

Fixes: 06874015327b ("arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC")
Signed-off-by: David Virag <virag.david003@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos7885.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 3170661f5b67..9c233c56558c 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -280,8 +280,8 @@ serial_0: serial@13800000 {
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_bus>;
-			clocks = <&cmu_peri CLK_GOUT_UART0_EXT_UCLK>,
-				 <&cmu_peri CLK_GOUT_UART0_PCLK>;
+			clocks = <&cmu_peri CLK_GOUT_UART0_PCLK>,
+				 <&cmu_peri CLK_GOUT_UART0_EXT_UCLK>;
 			clock-names = "uart", "clk_uart_baud0";
 			samsung,uart-fifosize = <64>;
 			status = "disabled";
@@ -293,8 +293,8 @@ serial_1: serial@13810000 {
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_bus>;
-			clocks = <&cmu_peri CLK_GOUT_UART1_EXT_UCLK>,
-				 <&cmu_peri CLK_GOUT_UART1_PCLK>;
+			clocks = <&cmu_peri CLK_GOUT_UART1_PCLK>,
+				 <&cmu_peri CLK_GOUT_UART1_EXT_UCLK>;
 			clock-names = "uart", "clk_uart_baud0";
 			samsung,uart-fifosize = <256>;
 			status = "disabled";
@@ -306,8 +306,8 @@ serial_2: serial@13820000 {
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart2_bus>;
-			clocks = <&cmu_peri CLK_GOUT_UART2_EXT_UCLK>,
-				 <&cmu_peri CLK_GOUT_UART2_PCLK>;
+			clocks = <&cmu_peri CLK_GOUT_UART2_PCLK>,
+				 <&cmu_peri CLK_GOUT_UART2_EXT_UCLK>;
 			clock-names = "uart", "clk_uart_baud0";
 			samsung,uart-fifosize = <256>;
 			status = "disabled";
-- 
2.35.1

