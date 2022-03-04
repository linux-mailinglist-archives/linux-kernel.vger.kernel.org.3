Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53BB4CD1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiCDKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbiCDKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:04:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB0119E002
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:03:35 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c1so7087836pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJ7+kaESGdNAzAImLBta6phpylHoIMJb1C9yUH40IE0=;
        b=XRvdFl7el/25PA7mmFcR0nR9j3sLUqN75EPFgUDfUYA4aIAEHPsbE+uakszi+zi3FK
         UFa23RawxMsgEyvSS7qMPT+T4yEDukMlYqwgEhF+U8ic2PbC7MOaKz6//nzSZGV9ww5B
         VIGGwpGOmx1ECCUAn+KfOck1FjqZ9HAAtYji4WQgcbfMjnlwVQ2jOUJSdJ6x5Lv/s4vl
         W84eu+JybUxJg+h0nAYcNLgUrUhsVI9lOrjc7Ae8I4RHWyEXxa29owvqHgRodRfxyGx7
         KpitxF3S0WNsajmQMenx3c+9EhjXZypOKlGyOYqmadFIm0Rj9gjHOmuUEvHC/suPr6C1
         Fwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJ7+kaESGdNAzAImLBta6phpylHoIMJb1C9yUH40IE0=;
        b=YgplaWgmRalP+CasNTTblEqB6zbMVzKm1FgsKP5nypM1tLzx/IbhLNXmK6qnooI8+X
         dw/3UbGPKPJc9nyg6iVs3DGkWkjNCtOvMSMw76xI8aUzm4sA/fV1M20m00c3W54kkaIh
         ZNHg0WWrLPn4em/YykOzVVk6u2hP+fpU5Tys1qsiZurEV7shXG2Bnv7wjMoEuY7XhRHZ
         Z/Tt8Y/RiyEvtMRfIyz9c/1ZN9Ym6JkFrC92xSDUdF0rxEr2sW6FGXEX+ipgVGzlwpCX
         PeEXFBDi3ckRhAGNOaR3YPpr4siRVGebhL/3k8xzy51K3V2nRvKvn5IQDXmHGP0DdoY6
         2XCw==
X-Gm-Message-State: AOAM531ke3otE6Cw+nNLK44d0vBzhXeO59wE4+mjqWnlbHdxjQNiqsby
        tLqEfZDea9p5TtC4UxZn4XrJn62R4OkC5A==
X-Google-Smtp-Source: ABdhPJx0WWFoRPseHrDzlawbRLombRu5TBWXnZU8CJ5ltfuldD5/terJjgVkeo1JnwVVL7q6K2w8hg==
X-Received: by 2002:a05:6a00:1c46:b0:4e1:82cb:e39c with SMTP id s6-20020a056a001c4600b004e182cbe39cmr43032010pfw.18.1646388215245;
        Fri, 04 Mar 2022 02:03:35 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00174800b004f26d3f5b03sm5461605pfc.39.2022.03.04.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:03:34 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v2 3/5] riscv: dts: Change the macro name of prci in each device node
Date:   Fri,  4 Mar 2022 18:03:19 +0800
Message-Id: <db92d209fa700f7da8bc8028083476fcc138d80e.1646388139.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646388139.git.zong.li@sifive.com>
References: <cover.1646388139.git.zong.li@sifive.com>
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

We currently change the macro name for fu540 and fu740 by adding the
prefix respectively, these marcos are referenced by some device nodes,
they should be modified as well.

Signed-off-by: Zong Li <zong.li@sifive.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 22 +++++++++---------
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 26 +++++++++++-----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 3eef52b1a59b..aad45d7f498f 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -164,7 +164,7 @@ uart0: serial@10010000 {
 			reg = <0x0 0x10010000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <4>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			status = "disabled";
 		};
 		dma: dma@3000000 {
@@ -180,7 +180,7 @@ uart1: serial@10011000 {
 			reg = <0x0 0x10011000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <5>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			status = "disabled";
 		};
 		i2c0: i2c@10030000 {
@@ -188,7 +188,7 @@ i2c0: i2c@10030000 {
 			reg = <0x0 0x10030000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <50>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
 			#address-cells = <1>;
@@ -201,7 +201,7 @@ qspi0: spi@10040000 {
 			      <0x0 0x20000000 0x0 0x10000000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <51>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -212,7 +212,7 @@ qspi1: spi@10041000 {
 			      <0x0 0x30000000 0x0 0x10000000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <52>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -222,7 +222,7 @@ qspi2: spi@10050000 {
 			reg = <0x0 0x10050000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <6>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -235,8 +235,8 @@ eth0: ethernet@10090000 {
 			      <0x0 0x100a0000 0x0 0x1000>;
 			local-mac-address = [00 00 00 00 00 00];
 			clock-names = "pclk", "hclk";
-			clocks = <&prci PRCI_CLK_GEMGXLPLL>,
-				 <&prci PRCI_CLK_GEMGXLPLL>;
+			clocks = <&prci FU540_PRCI_CLK_GEMGXLPLL>,
+				 <&prci FU540_PRCI_CLK_GEMGXLPLL>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -246,7 +246,7 @@ pwm0: pwm@10020000 {
 			reg = <0x0 0x10020000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <42>, <43>, <44>, <45>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
@@ -255,7 +255,7 @@ pwm1: pwm@10021000 {
 			reg = <0x0 0x10021000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <46>, <47>, <48>, <49>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
@@ -281,7 +281,7 @@ gpio: gpio@10060000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			clocks = <&prci PRCI_CLK_TLCLK>;
+			clocks = <&prci FU540_PRCI_CLK_TLCLK>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index 8464b0e3c887..7b77c13496d8 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -166,7 +166,7 @@ uart0: serial@10010000 {
 			reg = <0x0 0x10010000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <39>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			status = "disabled";
 		};
 		uart1: serial@10011000 {
@@ -174,7 +174,7 @@ uart1: serial@10011000 {
 			reg = <0x0 0x10011000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <40>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			status = "disabled";
 		};
 		i2c0: i2c@10030000 {
@@ -182,7 +182,7 @@ i2c0: i2c@10030000 {
 			reg = <0x0 0x10030000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <52>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
 			#address-cells = <1>;
@@ -194,7 +194,7 @@ i2c1: i2c@10031000 {
 			reg = <0x0 0x10031000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <53>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			reg-shift = <2>;
 			reg-io-width = <1>;
 			#address-cells = <1>;
@@ -207,7 +207,7 @@ qspi0: spi@10040000 {
 			      <0x0 0x20000000 0x0 0x10000000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <41>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -218,7 +218,7 @@ qspi1: spi@10041000 {
 			      <0x0 0x30000000 0x0 0x10000000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <42>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -228,7 +228,7 @@ spi0: spi@10050000 {
 			reg = <0x0 0x10050000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <43>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -241,8 +241,8 @@ eth0: ethernet@10090000 {
 			      <0x0 0x100a0000 0x0 0x1000>;
 			local-mac-address = [00 00 00 00 00 00];
 			clock-names = "pclk", "hclk";
-			clocks = <&prci PRCI_CLK_GEMGXLPLL>,
-				 <&prci PRCI_CLK_GEMGXLPLL>;
+			clocks = <&prci FU740_PRCI_CLK_GEMGXLPLL>,
+				 <&prci FU740_PRCI_CLK_GEMGXLPLL>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -252,7 +252,7 @@ pwm0: pwm@10020000 {
 			reg = <0x0 0x10020000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <44>, <45>, <46>, <47>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
@@ -261,7 +261,7 @@ pwm1: pwm@10021000 {
 			reg = <0x0 0x10021000 0x0 0x1000>;
 			interrupt-parent = <&plic0>;
 			interrupts = <48>, <49>, <50>, <51>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
@@ -287,7 +287,7 @@ gpio: gpio@10060000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			clocks = <&prci PRCI_CLK_PCLK>;
+			clocks = <&prci FU740_PRCI_CLK_PCLK>;
 			status = "disabled";
 		};
 		pcie@e00000000 {
@@ -316,7 +316,7 @@ pcie@e00000000 {
 					<0x0 0x0 0x0 0x3 &plic0 59>,
 					<0x0 0x0 0x0 0x4 &plic0 60>;
 			clock-names = "pcie_aux";
-			clocks = <&prci PRCI_CLK_PCIE_AUX>;
+			clocks = <&prci FU740_PRCI_CLK_PCIE_AUX>;
 			pwren-gpios = <&gpio 5 0>;
 			reset-gpios = <&gpio 8 0>;
 			resets = <&prci 4>;
-- 
2.31.1

