Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0954247F25B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 06:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhLYFyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 00:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLYFyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 00:54:06 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4AAC061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:54:06 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n16so7808675plc.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 21:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xGL5DCtywrgA9gA0wQaLdXwTlM4BhcumR5fKoiJ4h1o=;
        b=DRrT5d1LHWwNi0/QWomg1aUMv+ZZG6l4oKuxv0Y6qYmdyj0mQ+BfV8ztVUKEVlim3+
         SFgWXJJooShQxHMuMr0X1+CrlVqaDUt3d39NDp3pzCXDNbTd9MRjizTRqHXEB9rmRwuM
         yTPogYiMv6fCz77PS9RrhmmVthX1WrzFVDxQjmv3lv0K09eJqDcwJZjtdigpZub8bV11
         GsEbehx6MaE3UJ2XBV4qCujdIsBty8PE073D+cOeVM2GHH4hjQd0XSiRg1zy3VrftTp9
         ROBukqKtvn1NxjM2q5Vd7L7xi+lqQaBJ6+i/3pEjUqWn8jJPbZPHBE//wjBorkOIGoqm
         2NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xGL5DCtywrgA9gA0wQaLdXwTlM4BhcumR5fKoiJ4h1o=;
        b=Fqbq0i7FYTXPhIjRja8AI86yj0IbyNA5XNcxl4/TbhSAgvUYKSh+dPAYaNjxvmOCw7
         d2gZfIXq+y/6FRtD+XxomBqN1MO5OFHsIB+Nsn5ovIQgq/b4vzqLdfQQ9NMcyMlHm+RW
         Ae1HE+BSYa/wNT7bZLNhEs3k/sxBg+JOdpbnj+epdA4DJKXhcTMq5NQJps6eb17lqJhu
         Ns6npzfECowSM04itybFtRnc6T9kdTvtEmZWXJDzaP/LnXDXFiEbpU+J2gTBuL3par9Z
         /OKetZbMC+/Kb/ZSSQByRdU3/b0TiN7Mx3iD8XYFPoU2lr++eAF9481f+WRY0ASea4Ds
         W+Dg==
X-Gm-Message-State: AOAM533aNk+BRvQCDeLdHVVYg2QLPUtzRHuFYhX4y73i6GWLfBa/iQye
        WYM2VAR0NJZoAvatKL2daEs=
X-Google-Smtp-Source: ABdhPJx5c0iBBckVdWb7TvLiqBFuoxPzrz3WfCy7vdQ6o5KOzu7eV8gMymihbNvQLwlMgRFMbzcYWg==
X-Received: by 2002:a17:90a:b30a:: with SMTP id d10mr11163474pjr.92.1640411645748;
        Fri, 24 Dec 2021 21:54:05 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id h3sm4713611pjk.48.2021.12.24.21.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 21:54:05 -0800 (PST)
Date:   Sat, 25 Dec 2021 05:53:59 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, cl@linux.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@aculab.com, david@redhat.com,
        x86@kernel.org, bp@alien8.de
Subject: Re: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure
 on zone DMA if no managed pages
Message-ID: <Ycax90Xex3THEZTi@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211223094435.248523-1-bhe@redhat.com>
 <20211223094435.248523-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223094435.248523-4-bhe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 05:44:35PM +0800, Baoquan He wrote:
> In kdump kernel of x86_64, page allocation failure is observed:
> 
>  kworker/u2:2: page allocation failure: order:0, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
>  CPU: 0 PID: 55 Comm: kworker/u2:2 Not tainted 5.16.0-rc4+ #5
>  Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
>  Workqueue: events_unbound async_run_entry_fn
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x48/0x5e
>   warn_alloc.cold+0x72/0xd6
>   __alloc_pages_slowpath.constprop.0+0xc69/0xcd0
>   __alloc_pages+0x1df/0x210
>   new_slab+0x389/0x4d0
>   ___slab_alloc+0x58f/0x770
>   __slab_alloc.constprop.0+0x4a/0x80
>   kmem_cache_alloc_trace+0x24b/0x2c0
>   sr_probe+0x1db/0x620
>   ......
>   device_add+0x405/0x920
>   ......
>   __scsi_add_device+0xe5/0x100
>   ata_scsi_scan_host+0x97/0x1d0
>   async_run_entry_fn+0x30/0x130
>   process_one_work+0x1e8/0x3c0
>   worker_thread+0x50/0x3b0
>   ? rescuer_thread+0x350/0x350
>   kthread+0x16b/0x190
>   ? set_kthread_struct+0x40/0x40
>   ret_from_fork+0x22/0x30
>   </TASK>
>  Mem-Info:
>  ......
> 
> The above failure happened when calling kmalloc() to allocate buffer with
> GFP_DMA. It requests to allocate slab page from DMA zone while no managed
> pages at all in there.
>  sr_probe()
>  --> get_capabilities()
>      --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
> 
> Because in the current kernel, dma-kmalloc will be created as long as
> CONFIG_ZONE_DMA is enabled. However, kdump kernel of x86_64 doesn't have
> managed pages on DMA zone since commit 6f599d84231f ("x86/kdump: Always
> reserve the low 1M when the crashkernel option is specified"). The failure
> can be always reproduced.
> 
> For now, let's mute the warning of allocation failure if requesting pages
> from DMA zone while no managed pages.
> 
> Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7c7a0b5de2ff..843bc8e5550a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  	va_list args;
>  	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
>  
> -	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
> +	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
> +		(gfp_mask & __GFP_DMA) && !has_managed_dma())
>  		return;
>

Warning when there's always no page in DMA zone is unnecessary 
and it confuses user.

The patch looks good.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

And there is some driers that allocate memory with GFP_DMA
even if that flag is unnecessary. We need to do cleanup later.

Baoquan Are you planning to do it soon?
I want to help that.

Merry Christmas,
Hyeonggon

>  	va_start(args, fmt);
> -- 
> 2.26.3
> 
> 
