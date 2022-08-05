Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3058A888
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiHEJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiHEJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:13:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7590C7390A;
        Fri,  5 Aug 2022 02:13:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z187so1707402pfb.12;
        Fri, 05 Aug 2022 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/PmbKSoXlx8NE7NhxNR03vLeN9/hI3MbHe4vmiJGS3I=;
        b=ju8lg4x69mTNAkCCDTfZWjhjst9l8SDoGxK6JuJD0Ih3O3yJRMXmzAKcSPpRQoFpn1
         xCjhyrVJ6h0CVlm1bHIetKQklYN7qY4sBPft6l7tDTD8sPii7pJkNtcr+d9LT5oJOhC7
         sA+VbxhSgcNna+FSLSEqiqonPrOKBurxfMY8XefewziseeiHQyWn/oOqAnrQAdUsM5NS
         rPHPlNNANeObt/bhpL33i7ju/CHCgxvXrclPqXvwTSdmVwtYuff2ZXpr7qJg7w51BkN2
         H9dLJfluS8xAbylTTJTKd4BObtKEeNNq+8cacsFxbkz+Bn9nmjCK1cdo9kb98G0iGE4m
         XL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/PmbKSoXlx8NE7NhxNR03vLeN9/hI3MbHe4vmiJGS3I=;
        b=k9hvP0WSdagzY5zd7lC1daxtQUU9FMyV7eEF0bc7XtyUmpGJethKAQVDYvU++VRVCa
         QBQi3mK9hJ/TezEmHZifwItjyqUARkOXs/DQzyWCLNgvFEnjMOtGFvJJc5D7/ToJ7Ubk
         1npWIgEP4Z3cDl0w/A6JDl1XCfxDpdgM707y/HhkuwmOkD+SjZbLSrjqGOzw81h8Hspx
         5P8+oPJrs2ogL6Y/CVg5oCTxMuwRN67TOrhOLqTBI6KhhxTseKM8h1MQIMrgQNDLq3GS
         5aa2lrFaLlhhLxz7iKsV1evxbBFj3CmQTXjknYR3jQhZFjyFYtrfBRSwSRcnYgEjK0wL
         caYw==
X-Gm-Message-State: ACgBeo0HDoHR5uxpf0Nw4G18LuC4RpgBO7allqVURgDKYkd4TKTORDc7
        eYfddPI5az4oairJqavyrJ0=
X-Google-Smtp-Source: AA6agR5lgFgOB+298Wl0efTElU46gL/YUYfFXwuI3pGMyz1POF1VWbYaYQ7E4QZ9LvQwWaPCoMwI3Q==
X-Received: by 2002:a63:5f09:0:b0:41c:da4f:e498 with SMTP id t9-20020a635f09000000b0041cda4fe498mr5144661pgb.276.1659690780835;
        Fri, 05 Aug 2022 02:13:00 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id p2-20020a170903248200b001635b86a790sm2491334plw.44.2022.08.05.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 02:13:00 -0700 (PDT)
From:   Ken Chen <j220584470k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin.Lai@quantatw.com, Cosmo.Chou@quantatw.com,
        Michael Garner <garnermic@fb.com>,
        Ken Chen <j220584470k@gmail.com>
Subject: [PATCH 1/1] ARM: dts: aspeed-g6: enable more UART controllers
Date:   Fri,  5 Aug 2022 17:09:57 +0800
Message-Id: <20220805090957.470434-1-j220584470k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup the configuration of UART6, UART7, UART8, and UART9 in
aspeed-g6.dtsi.

Signed-off-by: Ken Chen <j220584470k@gmail.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 64 +++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 8c0de3f27883b..fe7cef6b5e976 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -34,8 +34,12 @@ aliases {
 		serial2 = &uart3;
 		serial3 = &uart4;
 		serial4 = &uart5;
-		serial5 = &vuart1;
-		serial6 = &vuart2;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		serial8 = &uart9;
+		serial9 = &vuart1;
+		serial10 = &vuart2;
 	};
 
 
@@ -745,6 +749,62 @@ uart4: serial@1e78f000 {
 				status = "disabled";
 			};
 
+			uart6: serial@1e790000 {
+				compatible = "ns16550a";
+				reg = <0x1e790000 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART6CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart6_default>;
+
+				status = "disabled";
+			};
+
+			uart7: serial@1e790100 {
+				compatible = "ns16550a";
+				reg = <0x1e790100 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART7CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart7_default>;
+
+				status = "disabled";
+			};
+
+			uart8: serial@1e790200 {
+				compatible = "ns16550a";
+				reg = <0x1e790200 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART8CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart8_default>;
+
+				status = "disabled";
+			};
+
+			uart9: serial@1e790300 {
+				compatible = "ns16550a";
+				reg = <0x1e790300 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART9CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart9_default>;
+
+				status = "disabled";
+			};
+
 			i2c: bus@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
2.31.1

