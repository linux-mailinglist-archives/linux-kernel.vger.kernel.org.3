Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7316857D786
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiGUX5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 19:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGUX5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:57:43 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E960189A87;
        Thu, 21 Jul 2022 16:57:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7DF453F67F;
        Fri, 22 Jul 2022 01:57:38 +0200 (CEST)
Message-ID: <0feb9493-155e-0b0d-0d33-e4d0ebf45977@somainline.org>
Date:   Fri, 22 Jul 2022 01:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab
 4 10.1 (SM-T530)
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721230231.98886-1-matti.lehtimaki@gmail.com>
 <20220721230231.98886-4-matti.lehtimaki@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220721230231.98886-4-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.07.2022 01:02, Matti Lehtimäki wrote:
> Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T530) wifi tablet
> based on the apq8026 platform.
> 
> Currently supported are accelerometer sensor, hall sensor,
> internal storage, physical buttons (power & volume), screen
> (based on simple-framebuffer set up by the bootloader) sdcard,
> touchscreen and USB.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
> Changes in v2:
>   - Change codename to matisse-wifi
>   - Remove msm-id, not needed when lk2nd is used
>   - Remove unused labels from reserved memory regions
>   - Rename muic node
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 469 ++++++++++++++++++
>  2 files changed, 470 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5112f493f494..8bac4f4f8656 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1010,6 +1010,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8016-sbc.dtb \
>  	qcom-apq8026-asus-sparrow.dtb \
>  	qcom-apq8026-lg-lenok.dtb \
> +	qcom-apq8026-samsung-matisse-wifi.dtb \
>  	qcom-apq8060-dragonboard.dtb \
>  	qcom-apq8064-cm-qs600.dtb \
>  	qcom-apq8064-ifc6410.dtb \
> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> new file mode 100644
> index 000000000000..621e0a337724
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> @@ -0,0 +1,469 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "qcom-msm8226.dtsi"
> +#include "qcom-pm8226.dtsi"
> +#include <dt-bindings/input/input.h>
Hello!

I think generally dt-bindings includes go before the DTS ones.
> +
> +/delete-node/ &smem_region;
> +
> +/ {
> +	model = "Samsung Galaxy Tab 4 10.1";
> +	compatible = "samsung,matisse-wifi", "qcom,apq8026";

[...]

> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	vmmc-supply = <&pm8226_l18>;
> +	vqmmc-supply = <&pm8226_l21>;
> +
> +	bus-width = <8>;
I doubt this.. do you have downstream backing this up?

> +	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
> +};

Other than that, this looks good to me.

Konrad
