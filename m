Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915DF4A7A88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiBBVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:33:56 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58536 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiBBVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:33:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212LXkYb003464;
        Wed, 2 Feb 2022 15:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643837626;
        bh=MENJGvQMJhKZZlRtdEePZHOcdyZ+AwPjqCpQzhXC0MA=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=ZrxL9uYwwXyr/cbgTU3sZduqpaMELJ4XTFFi3gMyL2sAm9fysRugVt//DflOA5nT+
         yhsuvfNI29qc8Y9BoeHHeQ2cqEcomNb/YxkILLXGBt+0MAIhSPqF9xcmweBxscfmnR
         O2zqvuj3tq9nYaMglRpLhomFHusASRFLifv5jOjE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212LXkew053030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 15:33:46 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 15:33:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 15:33:46 -0600
Received: from [10.249.37.221] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212LXjXw094550;
        Wed, 2 Feb 2022 15:33:45 -0600
Message-ID: <69b94cab-43fb-23a7-5819-66a37205bd23@ti.com>
Date:   Wed, 2 Feb 2022 15:33:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: fix regression from
 errata i940 fix
Content-Language: en-US
To:     Drew Fustini <dfustini@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <khilman@baylibre.com>
References: <20220202212554.1316032-1-dfustini@baylibre.com>
From:   Suman Anna <s-anna@ti.com>
In-Reply-To: <20220202212554.1316032-1-dfustini@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 15:25, Drew Fustini wrote:
> The existing fix for errata i940 causes a conflict for IPU2 which is
> using timer 3 and 4. From arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi:
> 
>   &ipu2 {
>           mboxes = <&mailbox6 &mbox_ipu2_ipc3x>;
>           ti,timers = <&timer3>;
>           ti,watchdog-timers = <&timer4>, <&timer9>;
>   };
> 
> I discovered the timer conflict from when booting mainline on a
> BeagleBoard X15 (AM5728):
> 
>   remoteproc remoteproc1: 55020000.ipu is available
>   remoteproc remoteproc1: powering up 55020000.ipu
>   remoteproc remoteproc1: Booting fw image dra7-ipu2-fw.xem4
>   omap-rproc 55020000.ipu: could not get timer platform device
>   omap-rproc 55020000.ipu: omap_rproc_enable_timers failed: -19
>   remoteproc remoteproc1: can't start rproc 55020000.ipu: -19
> 
> I modified the errata fix to use timer 15 and 16 instead which resolves
> the timer conflict.
> 
> Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
> Link: https://lore.kernel.org/linux-omap/YfWsG0p6to3IJuvE@x1/

Suggested-by: Suman Anna <s-anna@ti.com>

regards
Suman

> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> Note: I am keeping the device tree and driver change together in one
> patch as that is how the original errata fix commit was structured.
> 
>  arch/arm/boot/dts/dra7-l4.dtsi             | 5 ++---
>  arch/arm/boot/dts/dra7.dtsi                | 8 ++++----
>  drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
> index 956a26d52a4c..0a11bacffc1f 100644
> --- a/arch/arm/boot/dts/dra7-l4.dtsi
> +++ b/arch/arm/boot/dts/dra7-l4.dtsi
> @@ -3482,8 +3482,7 @@ timer14: timer@0 {
>  				ti,timer-pwm;
>  			};
>  		};
> -
> -		target-module@2c000 {			/* 0x4882c000, ap 17 02.0 */
> +		timer15_target: target-module@2c000 {	/* 0x4882c000, ap 17 02.0 */
>  			compatible = "ti,sysc-omap4-timer", "ti,sysc";
>  			reg = <0x2c000 0x4>,
>  			      <0x2c010 0x4>;
> @@ -3511,7 +3510,7 @@ timer15: timer@0 {
>  			};
>  		};
>  
> -		target-module@2e000 {			/* 0x4882e000, ap 19 14.0 */
> +		timer16_target: target-module@2e000 {	/* 0x4882e000, ap 19 14.0 */
>  			compatible = "ti,sysc-omap4-timer", "ti,sysc";
>  			reg = <0x2e000 0x4>,
>  			      <0x2e010 0x4>;
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 6b485cbed8d5..8f7ffe2f66e9 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1339,20 +1339,20 @@ timer@0 {
>  };
>  
>  /* Local timers, see ARM architected timer wrap erratum i940 */
> -&timer3_target {
> +&timer15_target {
>  	ti,no-reset-on-init;
>  	ti,no-idle;
>  	timer@0 {
> -		assigned-clocks = <&l4per_clkctrl DRA7_L4PER_TIMER3_CLKCTRL 24>;
> +		assigned-clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER15_CLKCTRL 24>;
>  		assigned-clock-parents = <&timer_sys_clk_div>;
>  	};
>  };
>  
> -&timer4_target {
> +&timer16_target {
>  	ti,no-reset-on-init;
>  	ti,no-idle;
>  	timer@0 {
> -		assigned-clocks = <&l4per_clkctrl DRA7_L4PER_TIMER4_CLKCTRL 24>;
> +		assigned-clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER16_CLKCTRL 24>;
>  		assigned-clock-parents = <&timer_sys_clk_div>;
>  	};
>  };
> diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
> index b6f97960d8ee..c706d63e9f5c 100644
> --- a/drivers/clocksource/timer-ti-dm-systimer.c
> +++ b/drivers/clocksource/timer-ti-dm-systimer.c
> @@ -695,9 +695,9 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
>  		return 0;
>  	}
>  
> -	if (pa == 0x48034000)		/* dra7 dmtimer3 */
> +	if (pa == 0x4882C000)           /* dra7 dmtimer15 */
>  		return dmtimer_percpu_timer_init(np, 0);
> -	else if (pa == 0x48036000)	/* dra7 dmtimer4 */
> +	else if (pa == 0x4882E000)      /* dra7 dmtimer16 */
>  		return dmtimer_percpu_timer_init(np, 1);
>  
>  	return 0;

