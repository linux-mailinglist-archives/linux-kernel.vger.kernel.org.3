Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1666A535058
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbiEZOFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiEZOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:05:52 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B48CB2B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:05:50 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MderZ-1nKcFp3xi5-00Zh0u for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022
 16:05:49 +0200
Received: by mail-yb1-f180.google.com with SMTP id v26so3108945ybd.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:05:48 -0700 (PDT)
X-Gm-Message-State: AOAM532DpvcBb1OfsOZ1cphC/IyQWjVdyc5oGk437NxjSpWKth6POb38
        nfioOA9fsQ38SLUT2Vw03ZeJF7ZHQuqXvs72hXc=
X-Google-Smtp-Source: ABdhPJyW6T0HxS8nRfGN2cj5Oi1n80F2UiMCqhaJN6XDQc/NZEUlfe2VDIsdY5cT/6NAmJsBfTfBFsZDS2WvmRY6bXM=
X-Received: by 2002:a25:bd8b:0:b0:657:8392:55c3 with SMTP id
 f11-20020a25bd8b000000b00657839255c3mr1620326ybh.452.1653573947731; Thu, 26
 May 2022 07:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220307140804.1400-1-jszhang@kernel.org> <CAK8P3a33aPwi0hBAyFREqM-BKVJwin=O9cOR4NzWPtr1j2pLiA@mail.gmail.com>
 <YoCMJhH9EP4+01pB@xhacker> <CAK8P3a0dNbwyJm3Zq-H6MQDrEcTA+wu01VvSHtFVyBT2NtMRCQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0dNbwyJm3Zq-H6MQDrEcTA+wu01VvSHtFVyBT2NtMRCQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 May 2022 16:05:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ezympZ0EDJPV9ipLWxqcNKm5QC-O44uA0oRhbFvMnqQ@mail.gmail.com>
Message-ID: <CAK8P3a1ezympZ0EDJPV9ipLWxqcNKm5QC-O44uA0oRhbFvMnqQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add irq stack support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:J/Q0vdQD2zUADWcAM74XBXdR5U/hkYwYQvAmqesjg7yujDiXDxV
 zzP4u0iFL80GPxQPKUfOlqADCZhwEQJyizbrKD7rXwEdPvfZ4LbXUhzSqHxVH5RoUJKHzgJ
 gCNtyvT5JbS8UqrMBtGfa8Cj/k+873I8pqGpf/Vm6odrLU3AqIzrG2afMEGz3GPL+Hgxaze
 w7jjEAQi9m4whSGz+S9sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3i/TE4Evtmg=:PlHG1pQyF3PkK/dy5ov6Dr
 e8LBqruJHSapyxZjTORXDQvKmhVlIy6u8vTHBYcKd8A8Ah4bPw0hk46p8fpFY4JvdYr/IzeW3
 E2827WVVgzSX2+yBX2rxaStm6Qc/j1cKxpNLbS/9p24DRRLyNFQugJJPBefKiOyptfjiFW53y
 RfBHyjDO//rhYzSR+VcHiZSin2YPmAr9j5BnxMKkV7VsRUDlP+k3qjoq4m51d5mg3s2UyvcdR
 MAvpyruxtv3Mq9sT6l7GPKuNZWfx6KRAd4PIMX0tmfj/eeJl3L+dQFdu7O+1irBN/rFHKsulL
 Ddn892V3l5F5gfN1UpAeFQiIuLfzNMO27ZoSB1/UliiE/0UhnPzwjvupvZhthm1V2+iVI/eRa
 oRe9xgj1z7A8P2NACGJdzzNEsJVEHgs0fpqNS41gnFUO4Nyc8aOxLs2SgN/1Ki7JrNQtJlJc7
 jZh80yxtU8gJKXrP2xlLyC4aQxdxwdRjI3LQnoy0XCQT8b2Km63j8QGgrdwQwvnVFgOrDdVGT
 hpEpZ8dFHn1cfmqBw1e4z+kKs2RwKu4ndWz2Rfayeq4hl68MqcWzzn8Zgwu5Fke+/zTrfkWob
 2/KnD0UV2Cexneko/hKNxgkmFdzVvf7KGcWO66Q+4UVQTJS37CuxdQv8WM4RGouqFiHtCWvJT
 eHgDDMOl4d/HcPaDcSAvj1HL/ecSP9IrLLNSNBUobA2EQVKy9CicqzcjnbFqKpf4UnG16M/Ae
 9QzQV5286odozgDUs8g9j2GxxqAWICRVTk3wTQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 10:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > +       for_each_possible_cpu(cpu) {
> > > > +#ifdef CONFIG_VMAP_STACK
> > > > +               void *s = __vmalloc_node(IRQ_STACK_SIZE, THREAD_ALIGN,
> > > > +                                        THREADINFO_GFP, cpu_to_node(cpu),
> > > > +                                        __builtin_return_address(0));
> > > > +#else
> > > > +               void *s = (void *)__get_free_pages(GFP_KERNEL, get_order(IRQ_STACK_SIZE));
> > > > +#endif
> > >
> > > On a related topic: is there a reason to still keep the non-VMAP_STACK
> >
> > irq stack is 16KB on RV64 now, vmalloc doesn't gurantee physical
> > continuous pages, I want to keep the stack physical continuous
> > characteristic for !VMAP_STACK case.
>
> I don't understand. What is the benefit of having a physically continuous
> stack? If this is required for something, you could still get that with a VMAP
> stack by using alloc_pages() to allocate the stack and them using vmap() to
> put it into the vmalloc range with appropriate guard pages.
>
> I think we really want to avoid the case of missing guard pages around
> the stack, and eliminate the part where the stack is in the linear map.

I was actually confused here and mixed up a few things: I thought this
was about whether to use vmap stacks unconditionally, and this is in
fact not even an architecture specific decision, it's a global option as you
are probably aware.

Since one can still turn off VMAP_STACK for normal thread stacks,
it doesn't make much of a difference whether one can do the same for
IRQ stacks. Please just ignore what I said above. I see you already
sent a modified v3, and I think either way is fine, feel free to revert back
to this method if it makes life easier.

       Arnd
