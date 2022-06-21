Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE95B55347B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiFUO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351562AbiFUO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:29:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0B562D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:29:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c4so22659407lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yFwOkX5u5xV89mKMUoEbIG06wYYhgJqYwetvw1ZUjd4=;
        b=owwv9fTp+ThPxppT/bUM8W4zSlE7eydJgrzcdiOBkgF/UzE786XjbBJFh4LNuqzwPV
         FcdKfRDCJwQtYpbddfkj4EJRnCGWNToze0MtV5AojiF0rwwu97Huq6j6JOC8ujvBii5A
         5VRpxLArMhwGEr3fjmfnCXfZSr3a/LX7dswiaox80JZOQHE2zEJXA3Si6p/hfdeklbGZ
         NcCks14qr9KKQuGFmwDUt3jss/F9gqfJ1VdNorGx+lZXQKoR1xigsBvJxQobnYyZE2PS
         mLqZl1SdKlnttpDOp7mvn1w96B16y91XrBcdiUm1043ST2IjdFCqUnudDHurVGHavjM1
         NGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yFwOkX5u5xV89mKMUoEbIG06wYYhgJqYwetvw1ZUjd4=;
        b=gf2cj717QAkqdZnwqP2zROzftlFmdULhg06uh+sC/7lEHfm6+CMNLa7AnhH6uBq7IP
         N+P69ZBhzSg/3XYMZjbJi4KZrYWaPco6qruiR9ZhGTRbqdQVGcnpXS8mHV/11w1q7pRd
         ciPAWqwe+wMjLdx3UB/0j2/W19KE3oj6g5IWiP/Y53eS1UH4o6U95U55eiu7BV2xK2ua
         KPakyy+jB8nMDg74yV0kJbec7bksKTAkH/NSn70H1NS7w+ltY2JoWBP8YsV7wdRfU9z3
         sPwtsnZBRgTPK6a/BIQzEp2FS4RD6UTY8RpNYmFlon1CFLfouLz8z1tCKxDtwKHscwub
         H7+w==
X-Gm-Message-State: AJIora9mW8bKSTgdWZzvM24O/jMQJLHJYl0IFY9pMJb8R51v6JSxH3th
        f0z6BhdEJQTfK55pU7Zcobs=
X-Google-Smtp-Source: AGRyM1u9rwxeINwOLlaQMUTf5uUrbla4nc3wiEJsto1vaZZM6hRcm1M4u2etSfdlQY1qQOSHAUMcUw==
X-Received: by 2002:a05:6512:b1c:b0:47d:df52:b5a9 with SMTP id w28-20020a0565120b1c00b0047ddf52b5a9mr15981152lfu.293.1655821748868;
        Tue, 21 Jun 2022 07:29:08 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id n11-20020a2e878b000000b0025a6e47056csm850841lji.124.2022.06.21.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:29:08 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 21 Jun 2022 16:29:06 +0200
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm: fix racing of vb->va when kasan enabled
Message-ID: <YrHVsryZlnpO/Vha@pc638.lan>
References: <1653447164-15017-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAB8ipk9cAoP6yV_-Gn8bwbn5ezCZujLeMpioa0TiNU5=akBaug@mail.gmail.com>
 <Yq+PMWlARgDhv8uL@pc638.lan>
 <CAGWkznHPdk_yqn2GWPDJaT32+4MnFLnRjdjBkaFv9BLMh4yM=g@mail.gmail.com>
 <CA+KHdyXpdow7SYsbq_7F0zDd5-nYGi6db7R11R3--g3gUu-59w@mail.gmail.com>
 <CAGWkznE5cFfdtmQ2j57goWtpfPGYPsd5Oi3pvb9vcfifodR9OQ@mail.gmail.com>
 <YrGO4cae/03r3PzP@pc638.lan>
 <CAGWkznFdZ1_jrSWSOPkSDyLY1OSodZBy6MTfdwPKo3VoW67GBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFdZ1_jrSWSOPkSDyLY1OSodZBy6MTfdwPKo3VoW67GBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jun 21, 2022 at 5:27 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > On Mon, Jun 20, 2022 at 6:44 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > > >
> > > > > > Is it easy to reproduce? If so could you please describe the steps? As i see
> > > > > > the freeing of the "vb" is RCU safe whereas vb->va is not. But from the first
> > > > > > glance i do not see how it can accessed twice. Hm..
> > > > > It was raised from a monkey test on A13_k515 system and got 1/20 pcs
> > > > > failed. IMO, vb->va which out of vmap_purge_lock protection could race
> > > > > with a concurrent ra freeing within __purge_vmap_area_lazy.
> > > > >
> > > > Do you have exact steps how you run "monkey" test?
> > > There are about 30+ kos inserted during startup which could be a
> > > specific criteria for reproduction. Do you have doubts about the test
> > > result or the solution?
> > > >
> > I do not have any doubt about your test results, so if you can trigger it
> > then there is an issue at least on the 5.4.161-android12 kernel.
> >
> > 1. With your fix we get expanded mutex range, thus the worst case of vmalloc
> > allocation can be increased when it fails and repeat. Because it also invokes
> > the purge_vmap_area_lazy() that access the same mutex.
> I am not sure I get your point. _vm_unmap_aliases calls
> _purge_vmap_area_lazy instead of purge_vmap_area_lazy. Do you have any
> other solutions? I really don't think my patch is the best way as I
> don't have a full view of vmalloc mechanism.
>
Yep, but it holds the mutex:

<snip>
mutex_lock(&vmap_purge_lock);
purge_fragmented_blocks_allcpus();
if (!__purge_vmap_area_lazy(start, end) && flush)
	flush_tlb_kernel_range(start, end);
mutex_unlock(&vmap_purge_lock);
<snip>

I do not have a solution yet. I am trying still to figure out how you can
trigger it. 

<snip>
	rcu_read_lock();
	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
		spin_lock(&vb->lock);
		if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
			unsigned long va_start = vb->va->va_start;
<snip>

so you say that "vb->va->va_start" can be accessed twice. I do not see
how it can happen. The purge_fragmented_blocks() removes "vb" from the 
free_list and set vb->dirty to the VMAP_BBMAP_BITS to prevent purging
it again. It is protected by the spin_lock(&vb->lock):

<snip>
spin_lock(&vb->lock);
if (vb->free + vb->dirty == VMAP_BBMAP_BITS && vb->dirty != VMAP_BBMAP_BITS) {
	vb->free = 0; /* prevent further allocs after releasing lock */
	vb->dirty = VMAP_BBMAP_BITS; /* prevent purging it again */
	vb->dirty_min = 0;
	vb->dirty_max = VMAP_BBMAP_BITS;
<snip>

so the VMAP_BBMAP_BITS is set under spinlock. The _vm_unmap_aliases() checks it:

<snip>
list_for_each_entry_rcu(vb, &vbq->free, free_list) {
	spin_lock(&vb->lock);
	if (vb->dirty && vb->dirty != VMAP_BBMAP_BITS) {
		unsigned long va_start = vb->va->va_start;
		unsigned long s, e;
<snip>

if the "vb->dirty != VMAP_BBMAP_BITS". I am missing your point here?

> >
> > 2. You run 5.4.161-android12 kernel what is quite old. Could you please
> > retest with latest kernel? I am asking because on the latest kernel with
> > CONFIG_KASAN i am not able to reproduce it.
> >
> > I do a lot of: vm_map_ram()/vm_unmap_ram()/vmalloc()/vfree() in parallel
> > by 64 kthreads on my 64 CPUs test system.
> The failure generates at 20s from starting up, I think it is a rare timing.
> >
> > Could you please confirm that you can trigger an issue on the latest kernel?
> Sorry, I don't have an available latest kernel for now.
>
Can you do: "gdb ./vmlinux", execute "l *_vm_unmap_aliases+0x164" and provide
output?

--
Uladzislau Rezki
