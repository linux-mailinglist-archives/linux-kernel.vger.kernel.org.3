Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C276F46C019
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbhLGQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:00:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59278 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbhLGQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:00:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26D74B80DBF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC755C341C1;
        Tue,  7 Dec 2021 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638892633;
        bh=wrbsse3acJeCEeYR4Lf4gAc+9H0xGhKHL3PYig774uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYTC/d+sMyDJri6M/pu7iG487aY5RcwzshvKFeGeMoZGIIYmZft9eFvHfPkWZs3z6
         qzKs+7uCVeqNNugstO/Ax+j0iF1wEbzzn0Kq7l3SoLXAKDTWUfvR7xxSGY4RN+7c+A
         pg3D5v7ARfUVmr2Lzhi6sQyN7IaHiAj/vISAm5qZ60bTUz9vXeIvP2/KAdAeFSHQde
         7tScDMEeJlcYgPNqxKUCdeGL67jY2lFDuIEXowt1a1B8nhiWK6cbFYWDr45q1+MY38
         5B96Ll9Q0cUXVxZ0SbyqvqOtwzBnCrZ23kvRkoWNNKe6cpazYAtmISTr8Q5zEb+WnM
         XVLZ6ffgL2+AQ==
Date:   Tue, 7 Dec 2021 17:57:04 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     linux@armlinux.org.uk, matthias.bgg@gmail.com,
        rmk+kernel@armlinux.org.uk, arnd@arndb.de,
        akpm@linux-foundation.org, linux@roeck-us.net,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] arm: remove [_text, _stext) from kernel code resource
Message-ID: <Ya+EUDVYdBvRa7xI@kernel.org>
References: <20211203141416.31121-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203141416.31121-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 10:14:16PM +0800, Mark-PK Tsai wrote:
> Remove the [_text, _stext) from Kernel Code.
> Although there are some startup code in head.text, they
> are freed to the buddy system after kernel boot.

Hmm, I don't see it is being freed anywhere. Can you elaborate when and how
the range [_text, _stext) is freed?

> And we have memory protection mechanism use this
> which have false alarm when some other IPs doing dma
> if the dma page frame is in the [_text, _stext).
> 
> Below are my iomem resource and reserved memory information:
> console:/ # grep Kernel /proc/iomem
>   20208000-219fffff : Kernel code
>   21b00000-21c2e76f : Kernel data
> 
> console:/ # cat /sys/kernel/debug/memblock/reserved
> 0: 0x20201000..0x20207fff
> 1: 0x20300000..0x21c2e76f
 
What are the addresses of _text and _stext in your configuration? 
What these dumps are supposed to show here?

> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  arch/arm/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 284a80c0b6e1..85ffc9501e38 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -851,7 +851,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
>  	struct resource *res;
>  	u64 i;
>  
> -	kernel_code.start   = virt_to_phys(_text);
> +	kernel_code.start   = virt_to_phys(_stext);
>  	kernel_code.end     = virt_to_phys(__init_begin - 1);
>  	kernel_data.start   = virt_to_phys(_sdata);
>  	kernel_data.end     = virt_to_phys(_end - 1);
> -- 
> 2.18.0
> 

-- 
Sincerely yours,
Mike.
