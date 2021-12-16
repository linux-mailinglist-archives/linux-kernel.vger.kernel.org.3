Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533C847755A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbhLPPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:07:56 -0500
Received: from elvis.franken.de ([193.175.24.41]:50680 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238287AbhLPPHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:07:55 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mxsMK-0001iD-03; Thu, 16 Dec 2021 16:07:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 83873C09A0; Thu, 16 Dec 2021 16:06:35 +0100 (CET)
Date:   Thu, 16 Dec 2021 16:06:35 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     cgel.zte@gmail.com
Cc:     ye.guojin@zte.com.cn, yangyingliang@huawei.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] MIPS: OCTEON: add put_device() after
 of_find_device_by_node()
Message-ID: <20211216150635.GD15172@alpha.franken.de>
References: <20211116081051.155750-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116081051.155750-1-ye.guojin@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 08:10:51AM +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> This was found by coccicheck:
> ./arch/mips/cavium-octeon/octeon-platform.c, 332, 1-7, ERROR missing
> put_device; call of_find_device_by_node on line 324, but without a
> corresponding object release within this function.
> ./arch/mips/cavium-octeon/octeon-platform.c, 395, 1-7, ERROR missing
> put_device; call of_find_device_by_node on line 387, but without a
> corresponding object release within this function.
> ./arch/mips/cavium-octeon/octeon-usb.c, 512, 3-9, ERROR missing
> put_device; call of_find_device_by_node on line 515, but without a
> corresponding object release within this function.
> ./arch/mips/cavium-octeon/octeon-usb.c, 543, 1-7, ERROR missing
> put_device; call of_find_device_by_node on line 515, but without a
> corresponding object release within this function.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c | 2 ++
>  arch/mips/cavium-octeon/octeon-usb.c      | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index d56e9b9d2e43..a994022e32c9 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -328,6 +328,7 @@ static int __init octeon_ehci_device_init(void)
>  
>  	pd->dev.platform_data = &octeon_ehci_pdata;
>  	octeon_ehci_hw_start(&pd->dev);
> +	put_device(&pd->dev);
>  
>  	return ret;
>  }
> @@ -391,6 +392,7 @@ static int __init octeon_ohci_device_init(void)
>  
>  	pd->dev.platform_data = &octeon_ohci_pdata;
>  	octeon_ohci_hw_start(&pd->dev);
> +	put_device(&pd->dev);
>  
>  	return ret;
>  }
> diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
> index 6e4d3619137a..4df919d26b08 100644
> --- a/arch/mips/cavium-octeon/octeon-usb.c
> +++ b/arch/mips/cavium-octeon/octeon-usb.c
> @@ -537,6 +537,7 @@ static int __init dwc3_octeon_device_init(void)
>  			devm_iounmap(&pdev->dev, base);
>  			devm_release_mem_region(&pdev->dev, res->start,
>  						resource_size(res));
> +			put_device(&pdev->dev);
>  		}
>  	} while (node != NULL);
>  
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
