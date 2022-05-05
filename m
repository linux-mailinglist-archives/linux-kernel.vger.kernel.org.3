Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E25351C3AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381202AbiEEPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242784AbiEEPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:20:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF147054
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651763790; x=1683299790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+0Kh2oRZukAOyD7AwIkqlv+A+XOIzELZ8enH5qUSGh0=;
  b=KVddb6plbpHF00OO/nToZXAuzSmhkWgllQIpbhCeknuRyMBWNRV5htPg
   RrW/f0s5spkrLBg7qrwR62AC/tuwam5Tr8FiOH7huK0zNohW+KSB7AWni
   1BDc/cPLXUJ6r18iGI2JD0SYMzGU4TftTYXvXMSr7y6i/Z6d1NTs197BG
   3Fnf7kr5DIiKSHxLiU7RxWQT5dNRJIWwfXMKCvfX13n6DxeIHDcu4taYo
   JJMnJRpXEVwrrEUFQnV5NZYnrum0PZOejd6aC5d0a32IdNCe2muyjRL5i
   KsbZIl8LCrNyutgmdTMCnWlYeAQpuMZRSo3K205X+/vygmk11TF0dVGX5
   A==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="94676679"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 08:16:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 08:16:29 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 08:16:27 -0700
Message-ID: <a84f9d08-6b08-9968-32a2-dbbd28aadb40@microchip.com>
Date:   Thu, 5 May 2022 17:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ARM: at91: Kconfig: implement PIT64B selection
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220309100802.3610259-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220309100802.3610259-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 at 11:08, Claudiu Beznea wrote:
> Implement PIT64B selection thus it will be available for the necessary
> targets (at the moment SAM9X60 and SAMA7G5) w/o the necessity to
> specify it via defconfig. With this the current CONFIG_TIMER_OF
> dependency of PIT64B driver could be removed. Along with changes
> on AT91 Kconfig removed CONFIG_MICROCHIP_PIT64B from defconfigs.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   arch/arm/configs/at91_dt_defconfig  | 1 -
>   arch/arm/configs/multi_v7_defconfig | 1 -
>   arch/arm/configs/sama7_defconfig    | 1 -
>   arch/arm/mach-at91/Kconfig          | 9 +++++++++

Hi Claudiu,

To match arm-soc flow, this probably would need to be spit in 2 patches: 
one for the Kconfig changes. Then, when it's integrated, we shall queue 
the other defconfig changes (having them around even with the Kconfig 
change doesn't harm).

I let you do this change. Best regards,
   Nicolas

>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 549d01be0b47..04f71dac9c97 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -195,7 +195,6 @@ CONFIG_RTC_DRV_AT91SAM9=y
>   CONFIG_DMADEVICES=y
>   CONFIG_AT_HDMAC=y
>   CONFIG_AT_XDMAC=y
> -CONFIG_MICROCHIP_PIT64B=y
>   # CONFIG_IOMMU_SUPPORT is not set
>   CONFIG_IIO=y
>   CONFIG_AT91_ADC=y
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8863fa969ede..bec62d5aa3c6 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -989,7 +989,6 @@ CONFIG_APQ_MMCC_8084=y
>   CONFIG_MSM_GCC_8660=y
>   CONFIG_MSM_MMCC_8960=y
>   CONFIG_MSM_MMCC_8974=y
> -CONFIG_MICROCHIP_PIT64B=y
>   CONFIG_BCM2835_MBOX=y
>   CONFIG_ROCKCHIP_IOMMU=y
>   CONFIG_TEGRA_IOMMU_GART=y
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 07b0494ef743..2b0f020a18eb 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -182,7 +182,6 @@ CONFIG_RTC_DRV_AT91SAM9=y
>   CONFIG_DMADEVICES=y
>   CONFIG_AT_XDMAC=y
>   CONFIG_STAGING=y
> -CONFIG_MICROCHIP_PIT64B=y
>   # CONFIG_IOMMU_SUPPORT is not set
>   CONFIG_IIO=y
>   CONFIG_IIO_SW_TRIGGER=y
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 279810381256..1531b4625c76 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -165,6 +165,15 @@ config ATMEL_CLOCKSOURCE_TCB
>   	  to make a single 32-bit timer.
>   	  It can also be used as a clock event device supporting oneshot mode.
>   
> +config MICROCHIP_CLOCKSOURCE_PIT64B
> +	bool "64-bit Periodic Interval Timer (PIT64B) support"
> +	default SOC_SAM9X60 || SOC_SAMA7
> +	select MICROCHIP_PIT64B
> +	help
> +	  Select this to get a high resolution clockevent (SAM9X60) or
> +	  clocksource and clockevent (SAMA7G5) based on Microchip 64-bit
> +	  Periodic Interval Timer.
> +
>   config HAVE_AT91_UTMI
>   	bool
>   


-- 
Nicolas Ferre
