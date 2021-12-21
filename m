Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4623947B844
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhLUCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:12:03 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22430 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhLUCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640052721; x=1671588721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1mYZHjSDCP8vzdBYhvhCE1szrN/8Vt0SAmcm/UORrb8=;
  b=Jj097gVyrUnXNjZu4p7WzupDOKrcz6ZRWMYIR8U4vKQJsWJr1mIZSuaZ
   /puUe3HQejkP4C76J9xNxUXs3VA9m4yeQeeqUZjeLoeQFXMOc6m4z4Lf5
   OBGsqdM0XPrGnWh3eh4hAinjVV/MQk/R9AzxFy8oheRQF3uZqFycFW/YM
   5pwc7G8Yi4h3s6i6v+P/C9y7o8sRMsolSfx9Rh77rG7LyxAWPeauzkvAX
   Itk7Je0jzXbcSP6UvNm4TMFbT2j76oDANWzllJqRzLD9ox8wKgxuHNIsO
   w0lfcS5L7mA5n8rLn3pUEj1GeulFIhwmCAmunpNwCaMqi2Sx1bbaQSMBt
   A==;
X-IronPort-AV: E=Sophos;i="5.88,222,1635177600"; 
   d="scan'208";a="292742809"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2021 10:12:01 +0800
IronPort-SDR: MVxmiGch+dBUnTFGV+DgSMriUAS3Sf72EGs2k9q1LR1WJocX1EJxwW05B6JX1lfAVYnsoJi7rB
 7mjVr3HGjV6QyKQyxkEGT6OIvGFHP2YvBpmds4h52wik2Q1snq6ZvHV5+xP8EL6fOAuBb2WJ7w
 NsL20XhivNTtPg7Nrq7d1xKF2AvH6rX2IkngyBVSFBJ2Ifa02uAmN7x9lYgTQY+MVS5+8/JKbl
 yHUn6OkJzv3vG2JyLfteGjByHi4W2++tdgd62BQosyksTIhC1gxQEqDMI3iASQ1Vq52ma1k0Nz
 Wrs+ElZENilTUiUq5H6PXffZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 17:46:16 -0800
IronPort-SDR: eIFz26XK1elS1Uvu+f/Ud7zQTX/knIhl1pmNt6RJSaaRs+cPWT1pnJUcs2Ra59gUz5zBK2Ce2P
 +bcgd8o2vEqTR/PIGOpSMFenXb41LHces+fPzlAxEpJoCtv4rBnBbvddrZAHmwnE8DcjKEqppr
 7YOquIZjHcsLyXV5GxzDO19LTO0W2l8bVCrXR0tu0nm29FZ2Yf0eP3ju1khPsIaNBopFHM+stm
 EjTAo7pQxSAcYlr0z/26nh9nbtu+yRuCmojWJxlVRZBCYYyDDHpOYgu9qtTvSGkxZdsNVaFpyc
 c2U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 18:12:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JJ0MN4B7lz1Rwns
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:12:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1640052720; x=1642644721; bh=1mYZHjSDCP8vzdBYhvhCE1szrN/8Vt0SAmc
        m/UORrb8=; b=E+BDG7LVgzI66y+b7YrV8gvUy5W+O1I70O9t5cp2gkWNXrEKw9i
        uDLS6At3BpShpzq5DwWTlSu0AJizmJktKDnIXcrd4lyNyMSkHPY3zugwOxKFnTyd
        EIq2BbtaB7N4jAk799zssOaZVS36fJhPkug98DqoanN5z2/ofU6Hnrvb0ECD56JH
        2bD+Nc8MGVTkOxSNMfaEWXMiu4JpVOBnfCEypkCerA+z/5hxMOA/5WCIm8j/7tqD
        r3EcP1WwE5rD0b2VfUOcG2wXN2TSWPmnYS4YKKz76UWZdH1Fa63ziT9IA4SeVrKZ
        hqpNjmYhF7du+ifuGX+Mg2ViR7EXifYEwDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cAEiIHY_fMLx for <linux-kernel@vger.kernel.org>;
        Mon, 20 Dec 2021 18:12:00 -0800 (PST)
Received: from [10.225.163.32] (unknown [10.225.163.32])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JJ0MM2WXpz1RtVG;
        Mon, 20 Dec 2021 18:11:59 -0800 (PST)
Message-ID: <d557af74-b166-7365-3949-57c6e1a6d132@opensource.wdc.com>
Date:   Tue, 21 Dec 2021 11:11:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/1] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211217112832.69875-1-andriy.shevchenko@linux.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20211217112832.69875-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 20:28, Andy Shevchenko wrote:
> platform_get_irq() will print a message when it fails.
> No need to repeat this.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: left !irq check untouched (Damien, Sergey)
>  drivers/ata/libahci_platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index bfa267e6f045..18296443ccba 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -579,11 +579,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
>  	int i, irq, n_ports, rc;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "no irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  	if (!irq)
>  		return -EINVAL;
>  

Applied to for-5.17. Thanks !

-- 
Damien Le Moal
Western Digital Research
