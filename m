Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166D551927B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbiECX73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiECX70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:59:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D494186DD;
        Tue,  3 May 2022 16:55:50 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nm2Mp-0004gB-UB; Wed, 04 May 2022 01:55:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v3 8/8] riscv: dts: microchip: add the sundance polarberry
Date:   Wed, 04 May 2022 01:55:42 +0200
Message-ID: <3101012.5fSG56mABF@phil>
In-Reply-To: <20220501192557.2631936-9-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie> <20220501192557.2631936-9-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. Mai 2022, 21:25:59 CEST schrieb Conor Dooley:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add a minimal device tree for the PolarFire SoC based Sundance
> PolarBerry.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[...]

> diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> new file mode 100644
> index 000000000000..96ec589d1571
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020-2022 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +#include "mpfs.dtsi"
> +#include "mpfs-polarberry-fabric.dtsi"
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define MTIMER_FREQ	1000000
> +
> +/ {
> +	model = "Sundance PolarBerry";
> +	compatible = "sundance,polarberry", "microchip,mpfs";
> +
> +	aliases {
> +		serial0 = &mmuart0;
> +		ethernet0 = &mac1;

I guess you could sort them alphabetically (ethernet above serial0)

> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	cpus {
> +		timebase-frequency = <MTIMER_FREQ>;
> +	};
> +
> +	ddrc_cache_lo: memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x2e000000>;
> +		status = "okay";

"okay" is implied I think, so when you only add the node
here, you probably don't need to specify the status.

> +	};
> +
> +	ddrc_cache_hi: memory@1000000000 {
> +		device_type = "memory";
> +		reg = <0x10 0x00000000 0x0 0xC0000000>;
> +		status = "okay";
> +	};
> +};
> +
> +&refclk {
> +	clock-frequency = <125000000>;
> +};
> +
> +&mmuart0 {
> +	status = "okay";
> +};
> +
> +&mmc {
> +	status = "okay";

having the status property last (below sd-uhssdr104) can be helpful
for readability, as readers would know where to expect it.

> +	bus-width = <4>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
> +	card-detect-delay = <200>;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +};
> +
> +&mac1 {
> +	status = "okay";
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy1>;
> +	phy1: ethernet-phy@5 {
> +		reg = <5>;
> +		ti,fifo-depth = <0x01>;
> +	};
> +	phy0: ethernet-phy@4 {
> +		reg = <4>;
> +		ti,fifo-depth = <0x01>;
> +	};
> +};
> +
> +&mac0 {
> +	status = "disabled";

mac0 is already disabled in the mpfs.dtsi, so you either don't
need to duplicate it here, or if it's a reminder of something,
I guess a comment for the "why" would be helpful.

> +	phy-mode = "sgmii";
> +	phy-handle = <&phy0>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&mbox {
> +	status = "okay";
> +};
> +
> +&syscontroller {
> +	status = "okay";
> +};

My personal preference would be alphabetical sorting also for
phandles, so

&mac0 {}
&mac1 {}
&mbox {}
&refclk {}
&rtc {}

etc - makes finding things a lot easier in the long run
especially when files get longer.


Heiko



