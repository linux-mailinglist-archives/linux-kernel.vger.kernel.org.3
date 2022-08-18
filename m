Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E7597BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiHRDGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiHRDF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:05:58 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D9E4D17D;
        Wed, 17 Aug 2022 20:05:55 -0700 (PDT)
Received: (Authenticated sender: n@nfraprado.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 52B6E60003;
        Thu, 18 Aug 2022 03:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1660791954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mporQ/LMRdbnsbYtlIILmMxfCBfZDzlTdMBUAjIPcsg=;
        b=IcpIcdUTRD7DmskU8pFPNOkmZ5xlc8f7kqV4rN/V1AfHwYOK6Kmdg3vDzbkHwnSwg/Tz1J
        KE9DNgMmdTC9zwE0w4Y3d4bLoliajolZ/VmkQrl9LugMmSTrHpVHBjHznYTIigPc1k0cSI
        BeEJwtG/gooZsFCQphqv7gfwxQ1+BCJTtdcmrRoXufkm5ATwApPIl9G81XTZgujG9S3MVw
        DDFBvVNI16MqHQzZFHF2MkkNnvUfW9m7uqHWKOR++VZK2ndaWtIAFf51ICm4P6DcwYBbER
        Uuaa1zEmLu669G3kTT1pKg+T/0cyCnMvWF1CsDufk3OWPVbXmq0C3wNQ7T2jig==
Date:   Wed, 17 Aug 2022 23:05:47 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Message-ID: <20220818030547.eblbmchutmnn6jih@notapiano>
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

thanks for getting the upstreaming of this DT going. Some comments below.

On Mon, Aug 15, 2022 at 10:30:04PM +1000, Tom Fitzhenry wrote:
> From: Martijn Braam <martijn@brixit.nl>
> 
> This is a basic DT containing regulators and UART, intended to be a
> base that myself and others can add additional nodes in future patches.
> 
> Tested to work: booting from eMMC, output over UART.

You're also adding the SD controller here. Does it work as is? If so add it to
the commit description as well.

> 
[..]
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -0,0 +1,394 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
> + * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
> + */
> +
> +/* PinePhone Pro datasheet:

First comment line should be empty following the coding style [1]. Like you did
for the copyrights above.

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting

> + * https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
> + */
[..]
> +	vcc_sysin: vcc-sysin-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sysin";

This signal is called vcc_sys in the datasheet, so I suggest we keep that name
here. It's not everyday that we get a device with a publicly available datasheet
:^).

> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
[..]
> +	rk818: pmic@1c {
> +		compatible = "rockchip,rk818";
> +		reg = <0x1c>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		clock-output-names = "xin32k", "rk808-clkout2";

What about keeping the datasheet names here too? clk32kout1, clk32kout2

> +		pinctrl-names = "default";
[..]
> +			vcc_1v8: vcc_wl: DCDC_REG4 {

From the datasheet, vcc_wl is actually wired to vcc3v3_sys. But looks like
vcc_wl is only used for bluetooth and you're not enabling it yet anyway, so just
drop this extra label, and it can be added when bluetooth is added (or not, and
then the bluetooth supply just points directly to vcc3v3_sys).

> +				regulator-name = "vcc_1v8";
[..]
> +			vcc_power_on: LDO_REG4 {
> +				regulator-name = "vcc_power_on";

The name on the datasheet for this one is rk818_pwr_on.

> +				regulator-always-on;
[..]
> +&cluster0_opp {
> +	opp04 {
> +		status = "disabled";
> +	};
> +
> +	opp05 {
> +		status = "disabled";
> +	};
> +};

I saw the discussion on the previous version about using the rk3399-opp.dtsi
here, but the thing is, this OPP has greater values for the max voltage than the
maximum allowed on the OPP table you posted previously (for RK3399-T)...

Same thing for the GPU OPP.

> +
> +&cluster1_opp {
> +	opp06 {
> +		status = "disabled";
> +	};

There's actually an opp06 node in the OPP for RK3399-T, only that the frequency
is slightly lower. Maybe you could keep it enabled but override the frequency?

Or given the above point about the max voltages, maybe it would be best to have
a separate OPP table after all?

> +
> +	opp07 {
> +		status = "disabled";
> +	};
> +};
> +
> +&io_domains {
> +	status = "okay";

Let's keep the status at the end of the node for consistency with the rest.

With these points addressed:

Reviewed-by: Nícolas F. R. A. Prado <n@nfraprado.net>

I'll also try to give this a test shortly.

Thanks,
Nícolas

> +
> +	bt656-supply = <&vcc1v8_dvp>;
> +	audio-supply = <&vcca1v8_codec>;
> +	sdmmc-supply = <&vccio_sd>;
> +	gpio1830-supply = <&vcc_3v0>;
> +};
[..]
