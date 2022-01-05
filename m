Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE9485007
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiAEJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:29:24 -0500
Received: from elvis.franken.de ([193.175.24.41]:58348 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238878AbiAEJ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:29:23 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n52be-0006hW-01; Wed, 05 Jan 2022 10:29:18 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 6969AC0DBB; Wed,  5 Jan 2022 09:55:05 +0100 (CET)
Date:   Wed, 5 Jan 2022 09:55:05 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        zhangqing@loongson.cn
Subject: Re: [PATCH -next] MIPS: Loongson64: Add missing of_node_put() in
 ls2k_reset_init()
Message-ID: <20220105085505.GB5406@alpha.franken.de>
References: <20220104133415.805209-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104133415.805209-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 09:34:15PM +0800, Yang Yingliang wrote:
> This node pointer is returned by of_find_compatible_node() with
> refcount incremented in ls2k_reset_init(). Calling of_node_put()
> to aovid the refcount leak.
> 
> Fixes: 7eb7819a2e12 ("MIPS: Loongson64: Add Loongson-2K1000 reset platform driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/platform/mips/ls2k-reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mips/ls2k-reset.c b/drivers/platform/mips/ls2k-reset.c
> index b70e7b8a092c..8f42d5d16480 100644
> --- a/drivers/platform/mips/ls2k-reset.c
> +++ b/drivers/platform/mips/ls2k-reset.c
> @@ -38,6 +38,7 @@ static int ls2k_reset_init(void)
>  	}
>  
>  	base = of_iomap(np, 0);
> +	of_node_put(np);
>  	if (!base) {
>  		pr_info("Failed to map PM register base address\n");
>  		return -ENOMEM;
> @@ -46,7 +47,6 @@ static int ls2k_reset_init(void)
>  	_machine_restart = ls2k_restart;
>  	pm_power_off = ls2k_poweroff;
>  
> -	of_node_put(np);
>  	return 0;
>  }
>  
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
