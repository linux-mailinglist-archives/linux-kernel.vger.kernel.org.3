Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9805846D04A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhLHJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhLHJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:47:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD0AC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8EC6CE2046
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6445C00446;
        Wed,  8 Dec 2021 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638956614;
        bh=7KVwmZP4kb/OUL12BsPtaww8tTdt2wLQUh9C2RS84eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3Ux8Mz5MdK0z6YQ5WyzALFAKVKmQEk0+7u4MYenjEKWSdYay/H+eLFSqkJpThpsd
         bDunlql+anSvbDj8enIYHVUWygu7gb0yIhW8VuaUKBhHQ0cSGVTBz/q6RZxD61C6Tm
         ZVA2ZmG8uOUATKSkIM399mZiH9XyecKC9qUhI8Lt4O8YONu7SD1bcv+5ipJB05m8uZ
         mBJcZ7XF6g1rEOpN52UZyGYDpy+oCY4dx2nUqIzbE+tXg1bu7qNCTq/XZCk2FkZzSR
         x2egKSR4V2pU37yAhQPbjdEdrkJhHr5Vc+ZO05KFmkY6I2LEZb6wFZ53nV/O1KK91d
         +tW5Upq2wb+lw==
Date:   Wed, 8 Dec 2021 11:43:23 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux@armlinux.org.uk,
        linux@roeck-us.net, matthias.bgg@gmail.com,
        rmk+kernel@armlinux.org.uk, wangkefeng.wang@huawei.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] arm: remove [_text, _stext) from kernel code resource
Message-ID: <YbB+O80Th2QI8sTl@kernel.org>
References: <Ya+EUDVYdBvRa7xI@kernel.org>
 <20211208022623.15103-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208022623.15103-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:26:23AM +0800, Mark-PK Tsai wrote:
> > On Fri, Dec 03, 2021 at 10:14:16PM +0800, Mark-PK Tsai wrote:
> > > Remove the [_text, _stext) from Kernel Code.
> > > Although there are some startup code in head.text, they
> > > are freed to the buddy system after kernel boot.
> >
> > Hmm, I don't see it is being freed anywhere. Can you elaborate when and how
> > the range [_text, _stext) is freed?
> 
> arm_memblock_init() reserve [KERNEL_START, KERNEL_END) which are defined as following.
> 
> #define KERNEL_START            _stext
> #define KERNEL_END              _end
> 
> free_low_memory_core_early() free all the non-reserved range in lowmem,
> so the range [_text, _stext) is also freed here.

Right, I've misread KERNEL_START as if it was _text...
 
> >
> > > And we have memory protection mechanism use this
> > > which have false alarm when some other IPs doing dma
> > > if the dma page frame is in the [_text, _stext).
> > >
> > > Below are my iomem resource and reserved memory information:
> > > console:/ # grep Kernel /proc/iomem
> > >   20208000-219fffff : Kernel code
> > >   21b00000-21c2e76f : Kernel data
> > >
> > > console:/ # cat /sys/kernel/debug/memblock/reserved
> > > 0: 0x20201000..0x20207fff
> > > 1: 0x20300000..0x21c2e76f
> >
> > What are the addresses of _text and _stext in your configuration?
> 
> va	 pa
> c0008000 20208000 _text
> c0100000 20300000 _stext
> 
> >
> > What these dumps are supposed to show here?
> >
> 
> Below is the dump info after applied this patch.
> 
> console:/ # grep Kernel /proc/iomem
>   20300000-219fffff : Kernel code
>   21b00000-21c2e76f : Kernel data
> 
> console:/ # cat /sys/kernel/debug/memblock/reserved
> 0: 0x20201000..0x20207fff
> 1: 0x20300000..0x21c2e76f
> 
> The difference is that Kernel Code resource match the reserved memblock 1
> which is reserved in arm_memblock_init().

For that I'd extend the reservation in arm_memblock_init() to include
[_text, _stext). 

Even if the code there is not needed after init, at least we'll keep this
consistent with other architectures.
 

-- 
Sincerely yours,
Mike.
