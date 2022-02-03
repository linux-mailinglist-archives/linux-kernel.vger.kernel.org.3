Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD44A89E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352799AbiBCRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiBCRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:25:08 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC69C061714;
        Thu,  3 Feb 2022 09:25:08 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 32E1181F0B;
        Thu,  3 Feb 2022 18:25:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1643909104;
        bh=m+N3MoX1/LE+15s/+NTNTKxRDOY/z4DDw+htkzNgE3M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bjoCLfODyyae88W21rRnORrVj+1mQQh9CW3ha4R4Gvo6vqM6j7YWesMa/Y5/pCFMy
         DHhx4WHz5jChtGRckwKV3B/SkN+ta4efiguIbI3OXY+KAw2xGbZJgLolGYvJA3s/ab
         J5GN164KC1qhxoLbox4UW1kyhTmRkcA0CnIna3Z0us1J0l5DeKMr1pHLQ7MCvG/tSD
         vi/fvJmH7/myw2w23DIG+nSxGrTRf+vFS0Efnk+2MmuazgRKOpgXZ5CZlfLTyUHUL+
         vs8KISFPwmT6r87KyjfHLMdnL9K/XRMnQGsmyobopttpgnIrpKMLzGl7MFPgtlfync
         iW2TNft8rPn6g==
Message-ID: <0b0cdffe-b4cc-e125-f3ea-4ece582f806b@denx.de>
Date:   Thu, 3 Feb 2022 18:25:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 16/16] ARM: dts: stm32: keep uart nodes behavior on
 stm32mp15xx-dhcor-avenger96
Content-Language: en-US
To:     Erwan Le Ray <erwan.leray@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220203171114.10888-1-erwan.leray@foss.st.com>
 <20220203171114.10888-17-erwan.leray@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220203171114.10888-17-erwan.leray@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 18:11, Erwan Le Ray wrote:
> DMA configuration is added to uart nodes in stm32mp15x device tree.
> Delete uart4 DMA property in stm32mp15xx-dhcor-avenger96 board device
> tree to keep console in irq mode, as DMA support for console has been
> removed from the driver by commit e359b4411c28 ("serial: stm32: fix
> threaded interrupt handling").
> Delete also usart2 and uart7 DMA property to keep current behavior.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> index 6885948f3024..61e17f44ce81 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
> @@ -376,6 +376,8 @@
>   	label = "LS-UART1";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart4_pins_b>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
>   	status = "okay";
>   };
>   
> @@ -385,6 +387,8 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart7_pins_a>;
>   	uart-has-rtscts;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
>   	status = "okay";
>   };
>   
> @@ -394,6 +398,8 @@
>   	pinctrl-0 = <&usart2_pins_a>;
>   	pinctrl-1 = <&usart2_sleep_pins_a>;
>   	st,hw-flow-ctrl;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
>   	status = "okay";
>   
>   	bluetooth {

Maybe you can squash all the DHSOM board changes into a single patch ?

That said, the change is fine on DHSOM.
