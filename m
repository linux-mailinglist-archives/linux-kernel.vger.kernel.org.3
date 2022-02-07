Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EDC4AC1B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiBGOnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388570AbiBGOSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:18:50 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF4C0401C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:18:49 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y6so25628465ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQXY/DFSzqSNiVJeW4YwRdZR282rLknOMgBOkiHlEuo=;
        b=eqZySNxgAC+V7zE2YiRr2Y9mnP8lRJIrlS+tGhinaC15YHjOoTsGJwBnVsXf0B6NPx
         YoWp47SjGQYVmjV8lABWJ8YqNaSpKrcTi/2vztpYX/wQroANiEtD856l4F2g+1JDSVrv
         L0nf/aNHHx+EVI5VQUly+ostgLOm5beWcM4se/YujE4oM/L4wOPOUmQ0k4M95Pp8TX1L
         u3yPO199MtLQmksfv+99T2WCa/ehY/y1k7AL9eNapnKJlKB3yeQnCvBcQBIM6pRI3YC/
         bh1Noa0mAThMliVmAKLKxLZRchcLlmb6fZu3dQKO92z+u4yR5ht9g6gF+H4BtjYqlCkK
         F3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQXY/DFSzqSNiVJeW4YwRdZR282rLknOMgBOkiHlEuo=;
        b=e1RhRCKv3gspY9SzcfAbtYSOY97eNxPmZk5xoChAJFmd7NuH9/ImwaHmOHf6MSlq03
         bp1t6FzNO+AV8KFHGllxhMCFq85bT6WFuOTa0YedcFsIop+oOVlunTNijaCvvzub3tTA
         XKwZExsaN8jgNYJxi+Oo7yLtrCzBp3S6VFMlt7Kn8bUOO+Q057v1tWhB3PSPlYfr0LcC
         A/QRZlFJ/8dICtDUypMKq8oPOeup87PX2h1aRud27yQ7YDjH7lxRbJzk1BvVLWNem9DF
         g8Kx2X1weMzYreDl77XEg7jYXSf3ihzkz1KwGitxRLofIX/xKx/g5H4FbCRwWA7tU5ky
         Cb8w==
X-Gm-Message-State: AOAM532lcjllzY+sc+2dvxd8fV+QoMvvV6hA1GKkcHgjmFXYOUT8bFNM
        lnzTlne5l3B8H8fyt8kifIg7FgPj4htkFtackAM=
X-Google-Smtp-Source: ABdhPJxy2MlXd9a/hyL/9UP4akGZbizEHVkkHC+bD8k0rI38YcLVHvIGoctdFBk1N/JfyL+Aw2UCzknoksUVSEFofbA=
X-Received: by 2002:a0d:f0c7:: with SMTP id z190mr11108005ywe.61.1644243528608;
 Mon, 07 Feb 2022 06:18:48 -0800 (PST)
MIME-Version: 1.0
References: <CAGj4m+4QPE7uHzbsQbG6Fp3Ke2eQRQQ2z2-1rsKDPtXqs-vpGg@mail.gmail.com>
 <a6916dea7c771b04d8c97d25214b6918524ab9ea.camel@redhat.com>
In-Reply-To: <a6916dea7c771b04d8c97d25214b6918524ab9ea.camel@redhat.com>
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
Date:   Mon, 7 Feb 2022 16:18:36 +0200
Message-ID: <CAGj4m+6u=TvH-nOqf38Tz=8+FDOx57h2n8-ZumHDKa=hZ1AkAw@mail.gmail.com>
Subject: Re: gdb switches to __sysvec_apic_timer_interrupt or
 __default_send_IPI_dest_field with KVM enabled
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     qemu-discuss@nongnu.org, linux-kernel@vger.kernel.org,
        gdb@sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for these fixes which I can use, and for detailed explanation.

On Mon, Jan 31, 2022 at 12:42 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> I recently fixed that, and the code AFAIK is upstream, but probably, the qemu
> side of it didn't yet made it to the release.

You are right, I have observed some unrelated gdb issue when debugging
kernel under QEMU and prepared packaging backport:
https://salsa.debian.org/gdb-team/gdb/-/merge_requests/9

> I patched the lx-symbols script to at least work with recent gdb, but this no doubt relies on at least some undefined
> behavier in gdb, therefore I didn't push this futher.
>
> https://patchwork.kernel.org/project/kvm/patch/20210811122927.900604-5-mlevitsk@redhat.com/

What a coincidence, I use lx-symbols with an external kernel module. I
have noticed that it behaves strangely sometimes, but somehow I found
a proper order of comments when it works for me.

On Mon, Jan 31, 2022 at 12:42 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Sat, 2022-01-29 at 23:06 +0200, Vasyl Vavrychuk wrote:
> > Hello,
> >
> > I run Linux kernel under qemu-system-x86_64 via the "-kernel" option.
> >
> > Also, I added the "-s" option to accept the gdb connection.
> >
> > After Linux boot up I connect with gdb and set a breakpoint in some
> > function, for example "device_del", does not matter really.
> >
> > The problem is if I also use "--enable-kvm", then after breakpoint
> > triggered and sending "n" from gdb, it switches to
> >
> >     __sysvec_apic_timer_interrupt (regs=0xffffc90000297de8) at
> > arch/x86/kernel/apic/apic.c:1102
> >     1102            trace_local_timer_entry(LOCAL_TIMER_VECTOR);
> >
> > or to
> >
> >     __default_send_IPI_dest_field (mask=<optimized out>,
> > vector=<optimized out>, dest=dest@entry=2048) at
> > arch/x86/kernel/apic/ipi.c:161
> >     161             cfg = __prepare_ICR2(mask);
> >
> > I am stepping over kernel code that does not perform any waiting or blocking.
> >
> > Everything works fine with "--enable-kvm" removed.
>
> I recently fixed that, and the code AFAIK is upstream, but probably, the qemu
> side of it didn't yet made it to the release.
>
> The problem you are seeing is that every time you single step, an interrupt
> occures because you are not as fast as computer is - timer interrupt happens
> like 1000 times in a second, so after each single step you do it will be pending.
>
> That makes GDB land you in the interrupt handler, which is correct
> technically but makes single stepping pretty much impossible.
>
> The solution is to tell kernel to mask interrupts regardless
> if they are masked by the guest, something that qemu even does when TCCG
> is used but was not implemented for KVM.
>
> Best regards,
>         Maxim Levitsky
>
> PS: you might also want to patch kernel's lx-symbols gdb script to fix loadable module support,
> which currently doesn't work well - I run out of time to upstream it,  I'll get to it
> someday.
>
> There problem here is that kernel's gdb script uses a breakpoint in the function that
> loads modules and when it hits, it reloads gdb symbols - that is frowned upon in gdb docs,
> but pretty much the only way to do it.
>
> I patched the lx-symbols script to at least work with recent gdb, but this no doubt relies on at least some undefined
> behavier in gdb, therefore I didn't push this futher.
>
> https://patchwork.kernel.org/project/kvm/patch/20210811122927.900604-5-mlevitsk@redhat.com/
>
>
>
> >
> > Thanks,
> > Vasyl
> >
>
>
