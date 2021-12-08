Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EF446D3EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhLHNDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:03:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3036 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhLHNDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638968406; x=1670504406;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f1oDBfD7DtcZrQBsGxe+sDg0vBR4ZSBIit9LMG6z1rw=;
  b=qGEDY8/1uZSL2P/Tb0qhotCDBdvKehnLpfMyUs6G00s6AzihVHvraDa4
   I0fZyN32kCtKf4Sz79EiqeyIW72KtxO2lAkWYqeRQptZv5stO8sbMpa5h
   IVCfmz3Z5qfJu5vVqbJl3446mgNbJJulxka131MC3j+N6/VX72p1Avg+q
   8XbiX47c1Kar4zzDoVPgXoG44iP+VYbpE5ZafbihtA4vN922YBSKFCTNx
   JveBnQu4HnH0ZCYLd/gZ+KlWaNWwiKyTbzcQpHqp0ZvbHi07EfPPvvp9m
   nEHCs8R18KsYO++bvg2HhWIkRV1fLvoxLzxFfkjqbx9ru3dg0KfVWoNsF
   g==;
IronPort-SDR: p6HvBX5D8ABKcGlnHKXTR11dwDjpV7Z0xiIW32VHKNU2kM0BRuK7SyEos4MHPxfI8Zr/WcYErV
 A29yOxKanCw23U29mkVBahXgdNgp5px0oBzGXwLEYzomJgt3wOC3EzioSQBwRWS6THTQ/fT9ni
 Lvw8jEDHXD3JuWv51uQGjEk9B0lEX8ei1bNmUwQw10mKn3A7r5BRIeHW1pVi9O+YkWXbisLbC/
 L4xCKZOnJLpO/Cf4FxnfynxgZ41yQSGP5azJkJDfqebfNuNlyFpSnXcRwY5GBlR+skk37aueZK
 uFryc7AhGe7sZORNkcKKmBeH
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="146513043"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 06:00:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Dec 2021 06:00:05 -0700
Received: from [10.12.73.2] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 8 Dec 2021 06:00:04 -0700
Subject: Re: [PATCH] ARM: at91: pm: Add of_node_put() before goto
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <kael_w@yeah.net>, Russell King <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211014084555.21422-1-wanjiabing@vivo.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <71c4c30c-3344-54ad-5aba-cb950bfaaa7b@microchip.com>
Date:   Wed, 8 Dec 2021 14:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211014084555.21422-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2021 at 10:45, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./arch/arm/mach-at91/pm.c:643:1-33: WARNING: Function
> for_each_matching_node_and_match should have of_node_put() before goto
> 
> Early exits from for_each_matching_node_and_match should decrement the
> node reference counter.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Even if I think it doesn't happen after a new SoC DT is in place 
properly, I'm fine with this:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/mach-at91/pm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 8711d6824c1f..dd6f4ce3f766 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -645,6 +645,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
>                  if (!soc_pm.data.ramc[idx]) {
>                          pr_err("unable to map ramc[%d] cpu registers\n", idx);
>                          ret = -ENOMEM;
> +                       of_node_put(np);
>                          goto unmap_ramc;
>                  }
> 
> @@ -670,6 +671,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
>                  if (!soc_pm.data.ramc_phy) {
>                          pr_err("unable to map ramc phy cpu registers\n");
>                          ret = -ENOMEM;
> +                       of_node_put(np);
>                          goto unmap_ramc;
>                  }
>          }
> --
> 2.20.1
> 


-- 
Nicolas Ferre
