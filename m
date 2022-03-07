Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E24D0781
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbiCGTUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiCGTUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:20:49 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173264BFCC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:19:53 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MkpOZ-1nsh2F18yF-00mMak for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022
 20:19:52 +0100
Received: by mail-wr1-f42.google.com with SMTP id h15so583824wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:19:52 -0800 (PST)
X-Gm-Message-State: AOAM5331trPxMI0z9CUx0AB5/O4ttkIkjk30ocKxUz+dG8JmcykojdIC
        74b9RV5AOBjCXQGvBWJb3uAz1Iw9b/fweZWWXcU=
X-Google-Smtp-Source: ABdhPJzugW3wqq7bgZleIsw6WIjwPuqv53jTQLFcNaq6BqgwsHEjfMrkyX4v0qxF4jXII18ANWrsX5DUh0KlJJ9XJac=
X-Received: by 2002:adf:e181:0:b0:1f7:7d5e:c3bb with SMTP id
 az1-20020adfe181000000b001f77d5ec3bbmr2691351wrb.12.1646680791862; Mon, 07
 Mar 2022 11:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20220307140804.1400-1-jszhang@kernel.org>
In-Reply-To: <20220307140804.1400-1-jszhang@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Mar 2022 20:19:35 +0100
X-Gmail-Original-Message-ID: <CAK8P3a33aPwi0hBAyFREqM-BKVJwin=O9cOR4NzWPtr1j2pLiA@mail.gmail.com>
Message-ID: <CAK8P3a33aPwi0hBAyFREqM-BKVJwin=O9cOR4NzWPtr1j2pLiA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add irq stack support
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hwyX4Gvy848HRPlMRNZlxfSfUvlAYzLl1fopcAeyIkzTRSuVJT7
 D8KrhWHtzNdaK2eaR649rb2nlZigyvjgxVbuvfwJ8pJt1GyAUoBI+7a9+fcK3JNx1FvAu9z
 ZIqYaX4yeT9LN2qL2UhIQvsR3Tdnty2ujA3tWBAehMvUoxxOQXbdBn86LT428tXaNm1a3Gd
 5GmsjJq94BTz0l7qSHM1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9LXoIPdE+HM=:MEeSw7reOIjpF/bAKrEy9A
 xXspghhL5RcC7DZmhMGvmprvNyeTuEQuOSWIfoeLDchvzXNleSMRP9N2cvA4fXYE1P2fl/IXI
 7zWUekB701OrWR+hm9lhDkCzaSMKXwCmysaB63R2QuQLJnOEtazlTWdXwekBPUDcAFMijoReQ
 dsfhH9TKr57QehIpHeco3LdJffZFsXu5k44D61iE6kL9QGj9+0pIAsDdEZ1IS/izfsW/P0rY7
 49lbEZvcVNrIgOcm7eWCRcBGLmc8stvuJx+1eNV5bjrf/fMh3bHYz1zvKqFhsDwvQ6kDF+KEn
 vShvelhyefp8yeLgf8+bTQydCg8NgBbYSHfNOdPB/6yRRxHZjWb63nxEnMC4IZK53LWTXjOfZ
 ZatkOfPM785933uaNLeM7tZePEv/7ggrW968CwnxnDWagseLwTuneHc4vGckxdaaNw9gn/Qyn
 VpsXgxQ7yW2fYcyomUDqhTxREoeMWNj+WVl9SzK0xjS0FAP7z4bImY/6Xq3vwLvJgyP11ZVPg
 dThi4krzN4CohmjR2+pDlFqmw1T2Fkr0025NY1ivpPtzsOZGm5L3aMJIxXdceUmgCRegI54RY
 bu6XCyIuAqvDk/80NNorn4P1xBDzBlo5V07LrxbGvQyDFgzz5iJdeqUIoLXDCIpvKLxnzz0f8
 AG3rRUINvmhbPrBu+BfEEHIxEX7a4vpwA3L26YteWu87MqfHOsBidxxmwxTxj2ZdbzJM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 3:08 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Currently, IRQs are still handled on the kernel stack of the current
> task on riscv platforms. If the task has a deep call stack at the time
> of interrupt, and handling the interrupt also requires a deep stack,
> it's possible to see stack overflow.
>
> Before this patch, the stack_max_size of a v5.17-rc1 kernel running on
> a lichee RV board gave:
> ~ # cat /sys/kernel/debug/tracing/stack_max_size
> 3736
>
> After this patch,
> ~ # cat /sys/kernel/debug/tracing/stack_max_size
> 3176
>
> We reduce the max kernel stack usage by 560 bytes!
>
> From another side, after this patch, it's possible to reduce the
> THREAD_SIZE to 8KB for RV64 platforms. This is especially useful for
> those systems with small memory size, e.g the Allwinner D1S platform
> which is RV64 but only has 64MB DDR.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Very nice!

> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index ed29e9c8f660..57c9b64e16a5 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -126,12 +126,39 @@ skip_context_tracking:
>          */
>         bge s4, zero, 1f
>
> -       la ra, ret_from_exception
> +       /* preserve the sp */
> +       move s0, sp
>
> -       /* Handle interrupts */
>         move a0, sp /* pt_regs */
> +
> +       /*
> +        * Compare sp with the base of the task stack.
> +        * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
> +        * and should switch to the irq stack.
> +        */
> +       REG_L t0, TASK_STACK(tp)
> +       xor t0, t0, s0
> +       li t1, ~(THREAD_SIZE - 1)
> +       and t0, t0, t1
> +       bnez t0, 2f
> +
> +       la t1, irq_stack
> +       REG_L t2, TASK_TI_CPU(tp)
> +       slli t2, t2, RISCV_LGPTR
> +       add t1, t1, t2
> +       REG_L t2, 0(t1)
> +       li t1, IRQ_STACK_SIZE
> +       /* switch to the irq stack */
> +       add sp, t2, t1
> +
> +2:

What is the benefit of doing this in assembler? Is it measurably faster?

I see that arm64 does the same thing in C code, and it would be best to
have a common implementation for doing this, in terms of maintainability.

> +
> +       for_each_possible_cpu(cpu) {
> +#ifdef CONFIG_VMAP_STACK
> +               void *s = __vmalloc_node(IRQ_STACK_SIZE, THREAD_ALIGN,
> +                                        THREADINFO_GFP, cpu_to_node(cpu),
> +                                        __builtin_return_address(0));
> +#else
> +               void *s = (void *)__get_free_pages(GFP_KERNEL, get_order(IRQ_STACK_SIZE));
> +#endif

On a related topic: is there a reason to still keep the non-VMAP_STACK
code path around? I see that it currently is optional for 64-bit with MMU,
but not available otherwise. The benefits should still outweigh the downside
(virtual address space usage mainly) on 32-bit, especially when this allows
a common implementation. Not sure about NOMMU, but I would guess
that it's not a big issue to use the same code there as well, since nommu
vmalloc just turns into a kmalloc as well.

         Arnd
