Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0A55428D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356981AbiFVGFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiFVGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:05:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7176D1834F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:05:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t24so13773009lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+26yanUYFbs+kQoX0xzkIKd301lMCOIGb1lb+5sasSA=;
        b=EpFXFh8CzRnMkuXQkhgC+q9r//mSbtWCjbtErlIJMcrWTrmATPgeloBk8/5C7Y+jrQ
         xsW2zuCVHA+gqM8ly13JXKhpX2UOqrjCSFtc4rL9svF0hBHxvL3j0iCr3+lLdv1WhUht
         SW0CyXvPeJNwL1seqNwXffEubuFOjtFcH9Y0CgvEXOw64wCKsgY1GH0IpF2QbI3IWMx0
         tUvZWxQqQJtMJkKNu42RVoy1sCaY0MDk4cgg17RSD8gj1rIPPjgwbeG5g3oE+9A+Urw8
         OMDK0ouRVhtMEjbhfGptAZQpjKcPvPfwOg5ViE+VQ/5ZGHXeWAzS0O7PaN0yjrC73XTt
         mdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+26yanUYFbs+kQoX0xzkIKd301lMCOIGb1lb+5sasSA=;
        b=UQmKdsK90ATC4w1dksiHNmrMCIdx4sDjT7I5hDijbjikEMbUs5+VkpezICclAH0kLN
         JlWZIEAhXlJWxZJd4F2bdySiX2y/Snrz1bVHpBLIj2nRIN//XoTE0IT6IrIb5aNJegWF
         ru8deJokc4ouhQ/v1+8n56XQLOR8AmL1QKw/uyvzbOZhydgXQLSTxEvYebrlm6VRdxdt
         /siPN1h6JpvmK0Ujw4Gsk/BX6ZFIA40+Ok9yVfGEHeDQaG4p5CvFzoJCumekBQuTPSop
         Moid6cSRCPvtJqoIYA0LcH7D/KQP2i2G2YkoNVcCn+jMi/95MPa+byvr4FiqUmr+oOQo
         vbuA==
X-Gm-Message-State: AJIora+bOy6jOxtpNrGPC+4iqnXruZebdFJrbcJjI33hzXbw5iIJ5SM9
        FkuN5uQdHQM1uE8yqyx1E+iA7K9Suj652QdP4B0=
X-Google-Smtp-Source: AGRyM1s+ypaQ7hBCb8VPVYLOXsxKYMMorT5FU1sVNsmSt8G4e8aYrYC/fKcIrRmJdLIDFzXZk4ZmC0QHhGDjgQdD8ZY=
X-Received: by 2002:a05:6512:ac3:b0:47f:518f:f53e with SMTP id
 n3-20020a0565120ac300b0047f518ff53emr1164793lfu.520.1655877910609; Tue, 21
 Jun 2022 23:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <1653447164-15017-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
 <Yq+PMWlARgDhv8uL@pc638.lan> <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
 <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
 <CAGWkznE5cFfdtmQ2j57goWtpfPGYPsd5Oi3pvb9vcfifodR9OQ@mail.gmail.com>
 <YrGO4cae/03r3PzP@pc638.lan> <CAGWkznFdZ1_jrSWSOPkSDyLY1OSodZBy6MTfdwPKo3VoW67GBg@mail.gmail.com>
 <YrHVsryZlnpO/Vha@pc638.lan> <CAGWkznEha+6aPi6hoqzSt0ZKpY2_0P4gFx-OFxufqDt6sZc9kw@mail.gmail.com>
In-Reply-To: <CAGWkznEha+6aPi6hoqzSt0ZKpY2_0P4gFx-OFxufqDt6sZc9kw@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 22 Jun 2022 14:04:41 +0800
Message-ID: <CAGWkznFx87C=z0ELALyBXdd=CNHAebG3oMNBbeGTC_j50xrYLw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Jun 22, 2022 at 11:15 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 10:29 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > On Tue, Jun 21, 2022 at 5:27 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > On Mon, Jun 20, 2022 at 6:44 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > > >
> > > > > > > > >
> > > > > > > > Is it easy to reproduce? If so could you please describe the steps? As i see
> > > > > > > > the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
> > > > > > > > glance i do not see how it can accessed twice. Hm..
> > > > > > > It was raised from a monkey test on A13_k515 system and got 1/20 pcs
> > > > > > > failed. IMO, vb->va which out of vmap_purge_lock protection could race
> > > > > > > with a concurrent ra freeing within __purge_vmap_area_lazy.
> > > > > > >
> > > > > > Do you have exact steps how you run "monkey" test?
> > > > > There are about 30+ kos inserted during startup which could be a
> > > > > specific criteria for reproduction. Do you have doubts about the test
> > > > > result or the solution?
> > > > > >
> > > > I do not have any doubt about your test results, so if you can trigger it
> > > > then there is an issue at least on the 5.4.161-android12 kernel.
> > > >
> > > > 1. With your fix we get expanded mutex range, thus the worst case of vmalloc
> > > > allocation can be increased when it fails and repeat. Because it also invokes
> > > > the purge_vmap_area_lazy() that access the same mutex.
> > > I am not sure I get your point. _vm_unmap_aliases calls
> > > _purge_vmap_area_lazy instead of purge_vmap_area_lazy. Do you have any
> > > other solutions? I really don't think my patch is the best way as I
> > > don't have a full view of vmalloc mechanism.
> > >
> > Yep, but it holds the mutex:
I still don't get how _purge_vmap_area_lazy hold vmap_purge_lock?
> >
> > <snip>
> > mutex_lock(&vmap_purge_lock);
> > purge_fragmented_blocks_allcpus();
> > if (!__purge_vmap_area_lazy(start, end) && flush)
> >         flush_tlb_kernel_range(start, end);
> > mutex_unlock(&vmap_purge_lock);
> > <snip>
> >
> > I do not have a solution yet. I am trying still to figure out how you can
> > trigger it.
> >
> > <snip>
> >         rcu_read_lock();
> >         list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> >                 spin_lock(&vb->lock);
> >                 if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
> >                         unsigned long va_start = vb->va->va_start;
> > <snip>
> >
> > so you say that "vb->va->va_start" can be accessed twice. I do not see
> > how it can happen. The purge_fragmented_blocks() removes "vb" from the
> > free_list and set vb->dirty to the VMAP_BBMAP_BITS to prevent purging
> > it again. It is protected by the spin_lock(&vb->lock):
> >
> > <snip>
> > spin_lock(&vb->lock);
> > if (vb->free + vb->dirty == VMAP_BBMAP_BITS && vb->dirty != VMAP_BBMAP_BITS) {
> >         vb->free = 0; /* prevent further allocs after releasing lock */
> >         vb->dirty = VMAP_BBMAP_BITS; /* prevent purging it again */
> >         vb->dirty_min = 0;
> >         vb->dirty_max = VMAP_BBMAP_BITS;
> > <snip>
> >
> > so the VMAP_BBMAP_BITS is set under spinlock. The _vm_unmap_aliases() checks it:
> >
> > <snip>
> > list_for_each_entry_rcu(vb, &vbq->free, free_list) {
> >         spin_lock(&vb->lock);
> >         if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
> >                 unsigned long va_start = vb->va->va_start;
> >                 unsigned long s, e;
> > <snip>
> >
> > if the "vb->dirty != VMAP_BBMAP_BITS". I am missing your point here?
> Could the racing be like bellowing scenario?  vb->va accessed in [2]
> has been freed in [1]
>
> _vm_unmap_aliases
>                 _vm_unmap_aliases
> {
>                                {
>               list_for_each_entry_rcu(vb, &vbq->free, free_list) {
>              __purge_vmap_area_lazy
>                      spin_lock(&vb->lock);
>                                 merge_or_add_vmap_area
>                      if (vb->dirty) {
>
> kmem_cache_free(vmap_area_cachep, va)[1]
>                             unsigned long va_start = vb->va->va_start;
> [2]

reformat the racing graph
 _vm_unmap_aliases
                             _vm_unmap_aliases
 {
                                              {
            list_for_each_entry_rcu(vb, &vbq->free, free_list) {
                   __purge_vmap_area_lazy
                      spin_lock(&vb->lock);
                                        merge_or_add_vmap_area
                      if (vb->dirty) {

kmem_cache_free(vmap_area_cachep, va)[1]
                             unsigned long va_start = vb->va->va_start; [2]

> >
> > > >
> > > > 2. You run 5.4.161-android12 kernel what is quite old. Could you please
> > > > retest with latest kernel? I am asking because on the latest kernel with
> > > > CONFIG_KASAN i am not able to reproduce it.
> > > >
> > > > I do a lot of: vm_map_ram()/vm_unmap_ram()/vmalloc()/vfree() in parallel
> > > > by 64 kthreads on my 64 CPUs test system.
> > > The failure generates at 20s from starting up, I think it is a rare timing.
> > > >
> > > > Could you please confirm that you can trigger an issue on the latest kernel?
> > > Sorry, I don't have an available latest kernel for now.
> > >
> > Can you do: "gdb ./vmlinux", execute "l *_vm_unmap_aliases+0x164" and provide
> > output?
> Sorry, I have lost the vmlinux with KASAN enabled and just got some
> instructions from logs.
>
> 0xffffffd010678da8 <_vm_unmap_aliases+0x134>: sub x22, x26, #0x28
>                x26 vbq->free
> 0xffffffd010678dac <_vm_unmap_aliases+0x138>: lsr x8, x22, #3
> 0xffffffd010678db0 <_vm_unmap_aliases+0x13c>: ldrb w8, [x8,x24]
> 0xffffffd010678db4 <_vm_unmap_aliases+0x140>: cbz w8,
> 0xffffffd010678dc0 <_vm_unmap_aliases+0x14c>
> 0xffffffd010678db8 <_vm_unmap_aliases+0x144>: mov x0, x22
> 0xffffffd010678dbc <_vm_unmap_aliases+0x148>: bl 0xffffffd0106c9a34
> <__asan_report_load8_noabort>
> 0xffffffd010678dc0 <_vm_unmap_aliases+0x14c>: ldr x22, [x22]
> 0xffffffd010678dc4 <_vm_unmap_aliases+0x150>: lsr x8, x22, #3
> 0xffffffd010678dc8 <_vm_unmap_aliases+0x154>: ldrb w8, [x8,x24]
> 0xffffffd010678dcc <_vm_unmap_aliases+0x158>: cbz w8,
> 0xffffffd010678dd8 <_vm_unmap_aliases+0x164>
> 0xffffffd010678dd0 <_vm_unmap_aliases+0x15c>: mov x0, x22
> 0xffffffd010678dd4 <_vm_unmap_aliases+0x160>: bl 0xffffffd0106c9a34
> <__asan_report_load8_noabort>
>
> >
> > --
> > Uladzislau Rezki
