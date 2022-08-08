Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD558CA7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiHHO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbiHHOZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:25:55 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991722AC4;
        Mon,  8 Aug 2022 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1659968749; bh=tQJR0APZve8GyPCYp1vfEqZlsyI/nEE7VyB1CAlKPeI=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=f818sH6UcK1WUegmdhIZbwewDaHR1AEl0lKmQ29R9MWgjp6OrIEhLiAaQpyhNjYU5
         DezgoSLvqLXib3CofzfF8KmS4fgK86zCENkh8uBmTjbx2SllWSEPjqYYi6SZRuG3vw
         RJ9B4vZhWQz7Uk2MaAcrfN9mt6y9Qhqht6wCa8qI=
Date:   Mon, 8 Aug 2022 16:25:49 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Dionne-Riel <samuel@dionne-riel.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: rockchip: Add RK3399-T opp
Message-ID: <20220808142549.tdoc76vrcqcf2dxu@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Dionne-Riel <samuel@dionne-riel.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-2-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805234411.303055-2-tom@tom-fitzhenry.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 06, 2022 at 09:44:09AM +1000, Tom Fitzhenry wrote:
> From: Samuel Dionne-Riel <samuel@dionne-riel.com>
> 
> These tables were derived from the regular RK3399 table, by dropping
> entries exceeding recommended operating conditions from the datasheet,
> and clamping the last exceeding value where it made sense.

Do we really need to duplicate the whole OPP table of rk3399-opp.dtsi
just to disable a few top opp## entries?

This will make it more annoying to add PVTM/eFuse leakage based voltage
selection support later on, because then there would have to be identical
multi-level operating points across multiple files. And that sounds like
a LOT of dupplication for little benefit.

Also Pinephone Pro has RK3399S not -T. RK3399 seems to be RK3399 selected for
low leakage (values I've seen from eFuses indicate the leakage is half that of
RK3399 available in Pinebook Pro)

I'd suggest just adding references to select operating point nodes that
are "too much" and disabling them with status = "disabled". This
can be done from the pinephone device tree file directly.

Otherwise we'll eventually end up with several files containing
something like this [1] and only differing in absence of some opp## nodes
and not their actual useful content.

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi#L6

kind regards,
	o.

> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> ---
>  .../arm64/boot/dts/rockchip/rk3399-t-opp.dtsi | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
> new file mode 100644
> index 0000000000000..ec153015d9d13
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
> + * Copyright (c) 2022 Samuel Dionne-Riel <samuel@dionne-riel.com>
> + */
> +
> +/ {
> +	cluster0_opp: opp-table-0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <825000 825000 925000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <825000 825000 925000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <850000 850000 925000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <925000 925000 925000>;
> +		};
> +	};
> +
> +	cluster1_opp: opp-table-1 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <408000000>;
> +			opp-microvolt = <825000 825000 1150000>;
> +			clock-latency-ns = <40000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <825000 825000 1150000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <825000 825000 1150000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <875000 875000 1150000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <950000 950000 1150000>;
> +		};
> +		opp05 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <1025000 1025000 1150000>;
> +		};
> +		opp06 {
> +			opp-hz = /bits/ 64 <1500000000>;
> +			opp-microvolt = <1100000 1100000 1150000>;
> +		};
> +	};
> +
> +	gpu_opp_table: opp-table-2 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <825000 825000 975000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <297000000>;
> +			opp-microvolt = <825000 825000 975000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <825000 825000 975000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <875000 875000 975000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <600000000>;
> +			opp-microvolt = <925000 925000 975000>;
> +		};
> +	};
> +};
> +
> +&cpu_l0 {
> +	operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_l1 {
> +	operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_l2 {
> +	operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_l3 {
> +	operating-points-v2 = <&cluster0_opp>;
> +};
> +
> +&cpu_b0 {
> +	operating-points-v2 = <&cluster1_opp>;
> +};
> +
> +&cpu_b1 {
> +	operating-points-v2 = <&cluster1_opp>;
> +};
> +
> +&gpu {
> +	operating-points-v2 = <&gpu_opp_table>;
> +};
> -- 
> 2.37.1
> 
