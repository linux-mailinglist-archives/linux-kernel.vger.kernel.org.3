Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB59467960
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381294AbhLCO3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhLCO3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:29:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15808C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0100B82807
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 14:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82960C53FAD;
        Fri,  3 Dec 2021 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638541576;
        bh=opBMB9qQImOjDNakCrK7fCffd36SQEgbiRGDXcaTTEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q++9iK8wtWGYY/4+mLRyXrl2ZC+yeYhu+mkNx4WYb8fAsfRKKUVLBNtWb+JRJyGgq
         rRV9zPyQ+3UA1TRi+ptWn03B3fCx2xNNt154QJY2bxwYEjqHggm7cVfZszPlmJlrqb
         CrID9dh+vakNPSAJbCQ35iG6vS+rM0oyGIEl/wnQ3fNEiIcw2fp4lmvv1BJ9keLlrt
         BMD5nLtrc6B12f0FRNYulr6u+0E2ObyIm4KdlpYuhlJg+AnbmBFJKHB2Y8QtpOoEST
         4LsIQalce4muh6O3ZgI+lUuj1ckeYa3qjqbkwOlVuVEPCkS3VphVGxVCXWmPpLMuKq
         +MyUqSfdp7mFQ==
Date:   Fri, 3 Dec 2021 22:18:57 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Alexandre ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] riscv: mm: init: remove _pt_ops and use pt_ops
 directly
In-Reply-To: <bdb6b231-2b1d-61c9-35a6-d5545bd667c6@ghiti.fr>
References: <20211203050317.2102-1-jszhang@kernel.org>
        <20211203050317.2102-4-jszhang@kernel.org>
        <bdb6b231-2b1d-61c9-35a6-d5545bd667c6@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20211203142614.82960C53FAD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 09:57:35 +0100
Alexandre ghiti <alex@ghiti.fr> wrote:

> On 12/3/21 06:03, Jisheng Zhang wrote:
> > Except "pt_ops", other global vars when CONFIG_XIP_KERNEL=y is defined
> > as below:
> >
> > |foo_type foo;
> > |#ifdef CONFIG_XIP_KERNEL
> > |#define foo	(*(foo_type *)XIP_FIXUP(&foo))
> > |#endif
> >
> > Follow the same way for pt_ops to unify the style and to simplify code.  
> 
> 
> _dtb_early_pa and _dtb_early_va have the same 'issue' too. I thought 
> there was a reason for those variables to be declared this way but I 
> can't find it :)

Hi Alexandre

I may know the reason: the dtb_early_pa|va are used not only in init.c
but also in other source files, so they are not static vars. Then if they
are defined as the unified style, compiler will emit errors.

Thanks

> 
> 
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   arch/riscv/mm/init.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index bd445ac778a8..4d4fcd7ef1a9 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -227,12 +227,10 @@ static void __init setup_bootmem(void)
> >   }
> >   
> >   #ifdef CONFIG_MMU
> > -static struct pt_alloc_ops _pt_ops __initdata;
> > +static struct pt_alloc_ops pt_ops __initdata;
> >   
> >   #ifdef CONFIG_XIP_KERNEL
> > -#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
> > -#else
> > -#define pt_ops _pt_ops
> > +#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
> >   #endif
> >   
> >   unsigned long riscv_pfn_base __ro_after_init;  
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

