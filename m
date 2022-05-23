Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C493C530B35
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiEWIRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiEWIRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:17:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D843E25587
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:17:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MODeL-1oCX0i35Dt-00OWyn for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022
 10:17:13 +0200
Received: by mail-yb1-f171.google.com with SMTP id z7so2778842ybf.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:17:13 -0700 (PDT)
X-Gm-Message-State: AOAM530fQqFaZa7WPvH41eeVsuSESxDt2jlk2Wx+sU/vN4ZYujv0Dvbk
        R1/7FJhm7ZdpCRM+CAT3qTohNa2HPT0p5wreXyY=
X-Google-Smtp-Source: ABdhPJwpBo10pOgBdqfC/NkZnjBYRstzV66KiRkOk2ZhvrzK49G4qlPbyegUfcvAyICBzxOuMbxaHVqbOn8oBK9jnSk=
X-Received: by 2002:a25:c747:0:b0:64f:62fb:f55e with SMTP id
 w68-20020a25c747000000b0064f62fbf55emr13378958ybe.106.1653293832593; Mon, 23
 May 2022 01:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220307140804.1400-1-jszhang@kernel.org> <CAK8P3a33aPwi0hBAyFREqM-BKVJwin=O9cOR4NzWPtr1j2pLiA@mail.gmail.com>
 <YoCMJhH9EP4+01pB@xhacker>
In-Reply-To: <YoCMJhH9EP4+01pB@xhacker>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 10:16:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0dNbwyJm3Zq-H6MQDrEcTA+wu01VvSHtFVyBT2NtMRCQ@mail.gmail.com>
Message-ID: <CAK8P3a0dNbwyJm3Zq-H6MQDrEcTA+wu01VvSHtFVyBT2NtMRCQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add irq stack support
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3mvfU8MEw7zAZ2vwDUR0VEJ7gLIarGDDwRYYoWCDsTx7aSH7UVF
 L+lhVqI4BtLrdZjGMDTSA6zkgTgwf08nwlkVjHEGH6BI05upf5gL3ZngWnIE6k0vdYAEtYN
 XoRm/OkEPaDBYpbo7p53Y4njWw8OGG9GeJaGaHHp48YizAGTBDYuIrDMUrWQWtaOLO320Gf
 42daTkxAbeMFEvuiid4xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bnuN2gPifV0=:nOOywJmXYXyGbFHsu4taLO
 lT/TkiL7crpLFLzZV8WqF4MfuJS0onNfklH5hSTQKQat8SER3SJMEkUTEEtHTONSv2WfBzQng
 lCI3Azv2hiDmtIFtS574CK8XvB7ycZuSvaebVV4rfIo+79MHHe5P52c61gjO87L3NC5ozAUji
 76PXab7pZ7BINgjt9lOHcEjdD7ZKUHXKXCllo9sVeu3wx/zeF71NFfuKBGlmkw9vSuJDfCe/A
 drGHBBP02EdRuhSTZrfms7YuUbeTWZgw/+6fnPDfq67WGKGLqIXuXZghwY7eYWj3ON6L/n8QT
 wN+Y4lm71O+OJqe7yI6ztz59aO0hY6AQw44m26x7+GD8+A8B8XsHt6C1f4LreMClQ12VojSJE
 HSA+VPOGv8Iv+0WX1NwybCE1HjLBMZMgBEUMQI442L+mk2hwS7JCbeOQmqgiYpQs6EL7sI0qG
 Pv1ZOKygNhoe3OBT4kKVr+hZZ49rMviE/wFTYntFwBVKDeQl4wCwJwM1d8NWUjEYVRlhO8reG
 UTURwZJUW7Di2Amnc8qSC7N28G49CGexgiktn2tkQW4lLq8/up+vfLnDqHLpGmWAhbZrOHVqB
 yoWcC7ybGIZ1gbh4u11hrpOp8kcm/SKsimzUfYgJ+N3Za9GQqq4PZZnIkamB1IAVZUEXvBdcB
 p0Fxs1mpgmO1rqL5HN3VJgD2afe76iwVyggh1xgktarjfrPUPvXu/wa646WKYJu0lubJnd4CM
 jHc/pz8SO6Nt0g9wyIhrj7D1i9H8kT5tDIqu81/mfabNYB4Yi+6BjKM4cSZH402kEG9i+01bh
 e8ano53UC/bL1Ql7rTGjqZvgvnnQr0GXnIWDhMePNVQ/y/yIoyu2EcNAK5t8MYqmAjmCJbLYt
 44HyoLHbW2M7DSL0OZ2sj4DtcUvIZrJAfYREenA/0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 7:14 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> On Mon, Mar 07, 2022 at 08:19:35PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 7, 2022 at 3:08 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > +2:
> >
> > What is the benefit of doing this in assembler? Is it measurably faster?
> >
> > I see that arm64 does the same thing in C code, and it would be best to
> > have a common implementation for doing this, in terms of maintainability.
> >
>
> Sorry for delay. The assembler code is mainly to cal the stack ptr then
> change the SP to use the stack, which equals to arm64 call_on_irq_stack()
> which is implemented in assembler too.

I understand that you need to be in asm code to switch the stack, it
just felt that the arm64 method is a bit easier to debug here.

I suppose being able to keep using generic_handle_arch_irq() is also
beneficial, so it doesn't make much difference either way.

> > > +       for_each_possible_cpu(cpu) {
> > > +#ifdef CONFIG_VMAP_STACK
> > > +               void *s = __vmalloc_node(IRQ_STACK_SIZE, THREAD_ALIGN,
> > > +                                        THREADINFO_GFP, cpu_to_node(cpu),
> > > +                                        __builtin_return_address(0));
> > > +#else
> > > +               void *s = (void *)__get_free_pages(GFP_KERNEL, get_order(IRQ_STACK_SIZE));
> > > +#endif
> >
> > On a related topic: is there a reason to still keep the non-VMAP_STACK
>
> irq stack is 16KB on RV64 now, vmalloc doesn't gurantee physical
> continuous pages, I want to keep the stack physical continuous
> characteristic for !VMAP_STACK case.

I don't understand. What is the benefit of having a physically continuous
stack? If this is required for something, you could still get that with a VMAP
stack by using alloc_pages() to allocate the stack and them using vmap() to
put it into the vmalloc range with appropriate guard pages.

I think we really want to avoid the case of missing guard pages around
the stack, and eliminate the part where the stack is in the linear map.

        Arnd
