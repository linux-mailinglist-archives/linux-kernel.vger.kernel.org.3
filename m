Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6034AFC08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbiBISws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiBISux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:50:53 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C32C004385;
        Wed,  9 Feb 2022 10:46:12 -0800 (PST)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ED23F223E9;
        Wed,  9 Feb 2022 19:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644432371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3kgxFS1ym2jMG+9772IZvkBEpGz3sFlMVSHxffUrWM=;
        b=bJT1JRSM2O9qHpztX4cECW3hufKFDmYDWAKTl3bYHw5U2ms5EDJuWTPy3RGOnlfiC+anaT
        vKS8NNFLNbIUYKnfSEdo3eCTOWv26E8r5rlCRfubzZFuVw4k7dzqRTc8oLhgpCQHVvf4xS
        YkE90e82Qx7jjxuOQXjx558m49hAlgk=
From:   Michael Walle <michael@walle.cc>
To:     kavyasree.kotagiri@microchip.com
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        olof@lixom.net, robh+dt@kernel.org, soc@kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board pcb8291
Date:   Wed,  9 Feb 2022 19:46:00 +0100
Message-Id: <20220209184600.1230365-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
References: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +	clocks {
[..]
> +
> +		nic_clk: nic_clk {

What does nic_clk stand for? If I had to guess, it
has something to do with network. But..

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +
> +	clks: clock-controller@e00c00a8 {
> +		compatible = "microchip,lan966x-gck";
> +		#clock-cells = <1>;
> +		clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> +		clock-names = "cpu", "ddr", "sys";
> +		reg = <0xe00c00a8 0x38>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <37500000>;
> +		arm,cpu-registers-not-fw-configured;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		flx0: flexcom@e0040000 {
> +			compatible = "atmel,sama5d2-flexcom";
> +			reg = <0xe0040000 0x100>;
> +			clocks = <&clks GCK_ID_FLEXCOM0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe0040000 0x800>;
> +			status = "disabled";
> +		};
> +
> +		flx1: flexcom@e0044000 {
> +			compatible = "atmel,sama5d2-flexcom";
> +			reg = <0xe0044000 0x100>;
> +			clocks = <&clks GCK_ID_FLEXCOM1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe0044000 0x800>;
> +			status = "disabled";
> +		};
> +
> +		trng: trng@e0048000 {
> +			compatible = "atmel,at91sam9g45-trng";
> +			reg = <0xe0048000 0x100>;
> +			clocks = <&nic_clk>;

.. it is used here..


> +		};
> +
> +		aes: aes@e004c000 {
> +			compatible = "atmel,at91sam9g46-aes";
> +			reg = <0xe004c000 0x100>;
> +			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(13)>,
> +			       <&dma0 AT91_XDMAC_DT_PERID(12)>;
> +			dma-names = "rx", "tx";
> +			clocks = <&nic_clk>;

.. and here. and so on.

So, is it some kind of internal clock?

> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		watchdog: watchdog@e0090000 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0xe0090000 0x1000>;
> +			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&nic_clk>;

Btw. can we disable all nodes by default and enable them
in the board dts files?

