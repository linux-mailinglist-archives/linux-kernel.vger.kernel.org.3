Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9C5275DB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 07:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiEOFWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 01:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiEOFWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 01:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60501DF5A
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 22:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D783060E8E
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD346C34100;
        Sun, 15 May 2022 05:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652592166;
        bh=SMApoQBrwmguznnu6OZ3wGTSnLpxhB1UNHnIM9qqIW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1R023dFG2+WP4S5Q6tv6yFDBWsKyqf1eEWflFvhGN9juQgRQh+0cF+COpuMz8ai9
         GXdsyIsoCV3LQL2TsMHCU41Tw8Sr30gdFcbYMVysS3VfrcGCtWKkpUVL60EtDIIgUi
         9fzlWcaAibf/eev2XaCjyRscovLRVIgaBU2pfkpqQ68UU0PxCfaIfV3+dxpdSCqgGX
         rMbr2d8hMufOqGDsSpVIAlzmdaS95JHWX+Yn2jHzZAgUajAdI+3G2Thblv1fDl+Cva
         xehQjYcQLyDp7fdmKK5OvohPMGNi0UtJPGD5hdNMrvR11078liDJas9SplZDEBVDIo
         MKVMaNve0l4iQ==
Date:   Sun, 15 May 2022 13:14:14 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: add irq stack support
Message-ID: <YoCMJhH9EP4+01pB@xhacker>
References: <20220307140804.1400-1-jszhang@kernel.org>
 <CAK8P3a33aPwi0hBAyFREqM-BKVJwin=O9cOR4NzWPtr1j2pLiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a33aPwi0hBAyFREqM-BKVJwin=O9cOR4NzWPtr1j2pLiA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:19:35PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 7, 2022 at 3:08 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Currently, IRQs are still handled on the kernel stack of the current
> > task on riscv platforms. If the task has a deep call stack at the time
> > of interrupt, and handling the interrupt also requires a deep stack,
> > it's possible to see stack overflow.
> >
> > Before this patch, the stack_max_size of a v5.17-rc1 kernel running on
> > a lichee RV board gave:
> > ~ # cat /sys/kernel/debug/tracing/stack_max_size
> > 3736
> >
> > After this patch,
> > ~ # cat /sys/kernel/debug/tracing/stack_max_size
> > 3176
> >
> > We reduce the max kernel stack usage by 560 bytes!
> >
> > From another side, after this patch, it's possible to reduce the
> > THREAD_SIZE to 8KB for RV64 platforms. This is especially useful for
> > those systems with small memory size, e.g the Allwinner D1S platform
> > which is RV64 but only has 64MB DDR.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Very nice!
> 
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index ed29e9c8f660..57c9b64e16a5 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -126,12 +126,39 @@ skip_context_tracking:
> >          */
> >         bge s4, zero, 1f
> >
> > -       la ra, ret_from_exception
> > +       /* preserve the sp */
> > +       move s0, sp
> >
> > -       /* Handle interrupts */
> >         move a0, sp /* pt_regs */
> > +
> > +       /*
> > +        * Compare sp with the base of the task stack.
> > +        * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
> > +        * and should switch to the irq stack.
> > +        */
> > +       REG_L t0, TASK_STACK(tp)
> > +       xor t0, t0, s0
> > +       li t1, ~(THREAD_SIZE - 1)
> > +       and t0, t0, t1
> > +       bnez t0, 2f
> > +
> > +       la t1, irq_stack
> > +       REG_L t2, TASK_TI_CPU(tp)
> > +       slli t2, t2, RISCV_LGPTR
> > +       add t1, t1, t2
> > +       REG_L t2, 0(t1)
> > +       li t1, IRQ_STACK_SIZE
> > +       /* switch to the irq stack */
> > +       add sp, t2, t1
> > +
> > +2:
> 
> What is the benefit of doing this in assembler? Is it measurably faster?
> 
> I see that arm64 does the same thing in C code, and it would be best to
> have a common implementation for doing this, in terms of maintainability.
> 

Hi Arnd,

Sorry for delay. The assembler code is mainly to cal the stack ptr then
change the SP to use the stack, which equals to arm64 call_on_irq_stack()
which is implemented in assembler too.

> > +
> > +       for_each_possible_cpu(cpu) {
> > +#ifdef CONFIG_VMAP_STACK
> > +               void *s = __vmalloc_node(IRQ_STACK_SIZE, THREAD_ALIGN,
> > +                                        THREADINFO_GFP, cpu_to_node(cpu),
> > +                                        __builtin_return_address(0));
> > +#else
> > +               void *s = (void *)__get_free_pages(GFP_KERNEL, get_order(IRQ_STACK_SIZE));
> > +#endif
> 
> On a related topic: is there a reason to still keep the non-VMAP_STACK

irq stack is 16KB on RV64 now, vmalloc doesn't gurantee physical
continuous pages, I want to keep the stack physical continuous
characteristic for !VMAP_STACK case.

Thanks

> code path around? I see that it currently is optional for 64-bit with MMU,
> but not available otherwise. The benefits should still outweigh the downside
> (virtual address space usage mainly) on 32-bit, especially when this allows
> a common implementation. Not sure about NOMMU, but I would guess
> that it's not a big issue to use the same code there as well, since nommu
> vmalloc just turns into a kmalloc as well.
> 

