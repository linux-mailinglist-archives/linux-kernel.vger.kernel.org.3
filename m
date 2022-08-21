Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3643259B2E4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiHUJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHUJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 05:00:13 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF1029C97;
        Sun, 21 Aug 2022 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1661072405; bh=ynJQrqcBA9pxR9yUbyxuuuDFYSKz2yTPBE1A5rCk+mA=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=omGMGkba3UMpAQ8gwj4+7Dk42+KAOtRtaobizJUb0ORoBQVFC0PeROZOE2gyxxRLg
         IfQZYNErFxS2lkmZWxzYR1AsoGLdEvV72/uxGXTIOYD8BbnNQhy/8YtgawDIJGURxG
         KvZ6VUp5IGjI7Hw+vqLcSbsTwl68c/FUhOJcdAXA=
Date:   Sun, 21 Aug 2022 11:00:05 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>
Cc:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Message-ID: <20220821090005.tshf7z2kklaet7ll@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
 <20220818030547.eblbmchutmnn6jih@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818030547.eblbmchutmnn6jih@notapiano>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nícolas,

On Wed, Aug 17, 2022 at 11:05:47PM -0400, Nícolas F. R. A. Prado wrote:
> Hi Tom,
> 
> thanks for getting the upstreaming of this DT going. Some comments below.
> 
> On Mon, Aug 15, 2022 at 10:30:04PM +1000, Tom Fitzhenry wrote:
> > From: Martijn Braam <martijn@brixit.nl>
> > 
> > This is a basic DT containing regulators and UART, intended to be a
> > base that myself and others can add additional nodes in future patches.
> > 
> > Tested to work: booting from eMMC, output over UART.
> 
> You're also adding the SD controller here. Does it work as is? If so add it to
> the commit description as well.
> 
> > 
> [..]
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > @@ -0,0 +1,394 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
> > + * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
> > + */
> > +
> > +/* PinePhone Pro datasheet:
> 
> First comment line should be empty following the coding style [1]. Like you did
> for the copyrights above.
> 
> [1] https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
> 
> > + * https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
> > + */
> [..]
> > +	vcc_sysin: vcc-sysin-regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_sysin";
> 
> This signal is called vcc_sys in the datasheet, so I suggest we keep that name
> here. It's not everyday that we get a device with a publicly available datasheet
> :^).
> 
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> [..]
> > +	rk818: pmic@1c {
> > +		compatible = "rockchip,rk818";
> > +		reg = <0x1c>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
> > +		#clock-cells = <1>;
> > +		clock-output-names = "xin32k", "rk808-clkout2";
> 
> What about keeping the datasheet names here too? clk32kout1, clk32kout2

Rather not. My guess is that trying to change the names will break the clock
tree, because xin32k is hardcoded in the rk3399 clk driver as parent for
mux_pll_p.

https://elixir.bootlin.com/linux/latest/source/drivers/clk/rockchip/clk-rk3399.c#L109

These names are not just a cosmetic thing.

> 
> > +		pinctrl-names = "default";
> [..]
> > +			vcc_1v8: vcc_wl: DCDC_REG4 {
> 
> From the datasheet, vcc_wl is actually wired to vcc3v3_sys. But looks like
> vcc_wl is only used for bluetooth and you're not enabling it yet anyway, so just
> drop this extra label, and it can be added when bluetooth is added (or not, and
> then the bluetooth supply just points directly to vcc3v3_sys).
> 
> > +				regulator-name = "vcc_1v8";
> [..]
> > +			vcc_power_on: LDO_REG4 {
> > +				regulator-name = "vcc_power_on";
> 
> The name on the datasheet for this one is rk818_pwr_on.
> 
> > +				regulator-always-on;
> [..]
> > +&cluster0_opp {
> > +	opp04 {
> > +		status = "disabled";
> > +	};
> > +
> > +	opp05 {
> > +		status = "disabled";
> > +	};
> > +};
> 
> I saw the discussion on the previous version about using the rk3399-opp.dtsi
> here, but the thing is, this OPP has greater values for the max voltage than the
> maximum allowed on the OPP table you posted previously (for RK3399-T)...

Max voltages in OPP table are irreleavant for Pinephone Pro DT, because the CPU
regulators in the PMIC are capable of setting the preferred voltage or very
close to it.

The actual min/max limits that are enforced by the kernel for the board are set
on the CPU regulator, which are actually wrongly set in this DT. See:

https://dl.radxa.com/rockpi4/docs/hw/datasheets/Rockchip%20RK3399-T%20Datasheet%20V1.0-20210818.pdf

+			vdd_cpu_l: DCDC_REG1 {
+				regulator-name = "vdd_cpu_l";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;

Should be 975000 (or at most 1300000 to fit within absmax)

+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};


+	vdd_cpu_b: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel1_pin>;
+		regulator-name = "vdd_cpu_b";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};

Should be 1150000 (or at most 1300000 to fit within absmax)

+	vdd_gpu: regulator@41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vsel2_pin>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;

Should be 975000 (or at most 1300000 to fit within absmax)

+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};

The max values in OPP table also still fit within abs. max values for RK3399-T,
so they are safe in any case.

> Same thing for the GPU OPP.
> 
> > +
> > +&cluster1_opp {
> > +	opp06 {
> > +		status = "disabled";
> > +	};
> 
> There's actually an opp06 node in the OPP for RK3399-T, only that the frequency
> is slightly lower. Maybe you could keep it enabled but override the frequency?
> 
> Or given the above point about the max voltages, maybe it would be best to have
> a separate OPP table after all?

No separate OPP table, please, unless absolutely necessary.

kind regards,
	Ondrej

> > +
> > +	opp07 {
> > +		status = "disabled";
> > +	};
> > +};
> > +
> > +&io_domains {
> > +	status = "okay";
> 
> Let's keep the status at the end of the node for consistency with the rest.
> 
> With these points addressed:
> 
> Reviewed-by: Nícolas F. R. A. Prado <n@nfraprado.net>
> 
> I'll also try to give this a test shortly.
> 
> Thanks,
> Nícolas
> 
> > +
> > +	bt656-supply = <&vcc1v8_dvp>;
> > +	audio-supply = <&vcca1v8_codec>;
> > +	sdmmc-supply = <&vccio_sd>;
> > +	gpio1830-supply = <&vcc_3v0>;
> > +};
> [..]
