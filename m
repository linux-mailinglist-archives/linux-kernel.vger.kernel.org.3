Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FBE47F5CC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhLZISj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhLZISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:18:37 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FB60C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=0UhNzxT9Vlw81dA+elTicyI9XerVlvhOGP
        OKLmgF/eE=; b=LCP8e3WUPymwrHGJA1ZMN6wq9HMwMm8ED9Hxe8SIHnECNqn0aI
        PHThwZejbk1qQjfgo8mBnaEvyhEPObyi6SuGfArde8d0vyLYFFMYfeZOfB4wpwwu
        610hWAdrzQu+jxenfi7E/XyD36dqIvWnptyOMPm+PTdu8QC27q22m8D70=
Received: from xhacker (unknown [101.86.42.35])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAXSGVGJchhY3_CAA--.2281S2;
        Sun, 26 Dec 2021 16:18:17 +0800 (CST)
Date:   Sun, 26 Dec 2021 16:10:56 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: fix wrong phys_ram_base value for RV64
Message-ID: <20211226161056.5ef4a5d9@xhacker>
In-Reply-To: <baa3e6dc-cfbc-c491-384a-639867734a7f@ghiti.fr>
References: <20211202153641.1961-1-jszhang@kernel.org>
 <baa3e6dc-cfbc-c491-384a-639867734a7f@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAXSGVGJchhY3_CAA--.2281S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zryruw45GF1kZrWftr1DZFb_yoW8XF1xpr
        WxGanakFW8Xry8ua9Fvw4rWF4DJ3Z2ga4Sgr4UCry5uFyYqr47ta1vqw12gryqyFWxua1S
        vrn8Cryru3WqyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyYb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 16:52:08 +0100
Alexandre ghiti <alex@ghiti.fr> wrote:

> On 12/2/21 16:36, Jisheng Zhang wrote:
> > Currently, if 64BIT and !XIP_KERNEL, the phys_ram_base is always 0,
> > no matter the real start of dram reported by memblock is. The original
> > patch[1] is correct, I believe it's not corrected merged due to lots
> > of #ifdef in arch/riscv/mm/init.c, I plan to send a clean up series
> > soon.
> >
> > [1] http://lists.infradead.org/pipermail/linux-riscv/2021-July/007650.html
> >
> > Fixes: 6d7f91d914bc ("riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address conversion")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   arch/riscv/mm/init.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 24b2b8044602..3c0649dba4ff 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -187,10 +187,10 @@ static void __init setup_bootmem(void)
> >   
> >   
> >   	phys_ram_end = memblock_end_of_DRAM();
> > -#ifndef CONFIG_64BIT
> >   #ifndef CONFIG_XIP_KERNEL
> >   	phys_ram_base = memblock_start_of_DRAM();
> >   #endif
> > +#ifndef CONFIG_64BIT
> >   	/*
> >   	 * memblock allocator is not aware of the fact that last 4K bytes of
> >   	 * the addressable memory can not be mapped because of IS_ERR_VALUE  
> 
> 
> Good catch, you can add:
> 
> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
> 

Hi Palmer,

I noticed this patch is missing in recent riscv fixes pull.

Thanks

