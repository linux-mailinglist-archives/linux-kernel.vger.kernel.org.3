Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B17472D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbhLMNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:34:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43554 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbhLMNev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639402491; x=1670938491;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=yi4+bdP+vSdGJnr9iOeN/kgJrII3/qrV7L4zI0Sdfi8=;
  b=hWFv9EaR0PCeljZPc/Lt7H2xRtD4tpj6KXhCkZdXkZTHwQwO+V/5S7UY
   gS+As5GdZbgiSImpXJnXOi2G0QEVtuiUePPPrnZjMV7vdFnJ43ejFLvbZ
   QzT+gpaBPvrgfQePul2WVUhf+u/hFr/5TNtnWplryBkp3SrpNSJ+QCkpF
   VQrWKvBNJwKsdAuYv0llOLyfWArGB8/923GDeksLowJxLqLw5+AH+CO6U
   SCV1Te9d8sM2HBSmsjCYBMK1hxqV7t8cbze1It6xGe/bpAQGzSZhSEcMg
   Sj7IPjF9kje2lnfxdY9EiQNTLB3KaDtvfTcIkfpfwsl1b2EGM5ecRWjuf
   g==;
IronPort-SDR: gTe6a5I4MRYftmZ5IrnyQFVkAtM1sgTASsKfz6qqDZ+HIPDsViTXxzxhgbZvmkSeZSU1AlreEC
 kDTxeOtTWZOIW0qQa1D9ewXJELnL2354Co5vVElL+Q8clP74FJmTtqvgL0i3aR+Y/LCuTnBWmC
 GN8FVzb6oiv9RR7qPjormKUuJFKfhiUwbtyhQKTN26hnn1RLYmfTVSh84XWSL+NOayAEf8TXR2
 6Pb640kVwBiYhHchSl7ZcpJxNfSBi+PMLeityHq7Aot1lQIe3gwhYDnaCJTZvgk0J7sN15eQO+
 JxeRJeLQKXtzZr7ujslxovOU
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155267695"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:34:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:34:48 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Dec 2021 06:34:46 -0700
Subject: Re: [PATCH] arm: mach-at91: add missing of_node_put
To:     Qing Wang <wangqing@vivo.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1639388520-63567-1-git-send-email-wangqing@vivo.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <d2cae713-0985-eb98-10a3-c1b26ee74fe7@microchip.com>
Date:   Mon, 13 Dec 2021 14:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1639388520-63567-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2021 at 10:41, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> Fix following coccicheck warning:
> WARNING: Function "for_each_matching_node_and_match"
> should have of_node_put() before return.
> 
> Early exits from for_each_matching_node_and_match should decrement the
> node reference counter.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Wang,

What's the difference between this patch and the one accepted here:
https://lore.kernel.org/all/20211014084555.21422-1-wanjiabing@vivo.com/

Regards,
   Nicolas

> ---
>   arch/arm/mach-at91/pm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 8711d68..ca313fe
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -644,6 +644,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
>                  soc_pm.data.ramc[idx] = of_iomap(np, 0);
>                  if (!soc_pm.data.ramc[idx]) {
>                          pr_err("unable to map ramc[%d] cpu registers\n", idx);
> +                       of_node_put(np);
>                          ret = -ENOMEM;
>                          goto unmap_ramc;
>                  }
> @@ -669,6 +670,7 @@ static __init int at91_dt_ramc(bool phy_mandatory)
>                  soc_pm.data.ramc_phy = of_iomap(np, 0);
>                  if (!soc_pm.data.ramc_phy) {
>                          pr_err("unable to map ramc phy cpu registers\n");
> +                       of_node_put(np);
>                          ret = -ENOMEM;
>                          goto unmap_ramc;
>                  }
> --
> 2.7.4
> 


-- 
Nicolas Ferre
