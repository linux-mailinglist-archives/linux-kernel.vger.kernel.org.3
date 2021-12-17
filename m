Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2D4792E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhLQRcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhLQRca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:32:30 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437B0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:32:29 -0800 (PST)
Received: from [192.168.1.101] (83.6.165.42.neoplus.adsl.tpnet.pl [83.6.165.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 177C33ED3F;
        Fri, 17 Dec 2021 18:32:28 +0100 (CET)
Message-ID: <e2ed8317-a656-f6ac-9fc5-810588f33105@somainline.org>
Date:   Fri, 17 Dec 2021 18:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC/patch 2/2] arm64: boot: dts: qcom: surface duo: add minimal
 framebuffer
Content-Language: en-US
To:     Felipe Balbi <balbi@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
References: <20211217125757.1193256-1-balbi@kernel.org>
 <20211217125757.1193256-3-balbi@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211217125757.1193256-3-balbi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17.12.2021 13:57, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@microsoft.com>
>
> Add a minimal framebuffer device so we can use the display on the
> Surface Duo device.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
> ---
>  .../dts/qcom/sm8150-microsoft-surface-duo.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> index a73317e1a824..c629ec115fec 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts
> @@ -25,6 +25,17 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	framebuffer0: framebuffer@9c000000 {
> +		compatible = "simple-framebuffer";
> +		reg = <0 0x9c000000 0 0x02400000>;

You can remove the leading 0 in the size cell.



> +		status = "okay";

This line is unnecessary, as it's enabled by default



> +
> +		height = <1800>;
> +		width = <1350>;
> +		stride = <(1350 * 4)>;
> +		format = "a8r8g8b8";
> +	};
> +
>  	vph_pwr: vph-pwr-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vph_pwr";
> @@ -472,6 +483,14 @@ &pon_resin {
>  	linux,code = <KEY_VOLUMEDOWN>;
>  };
>  
> +&reserved_memory {
> +	splash_region: splash_region@9c000000 {
> +		/* We expect the bootloader to fill in the size */

Would it be different than the framebuffer size?



> +		reg = <0x0 0x9c000000 0x0 0x0>;
> +		no-map;
> +	};
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <126 4>;
>  


Konrad

