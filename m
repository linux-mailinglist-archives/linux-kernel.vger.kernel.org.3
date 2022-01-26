Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD249C72A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiAZKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:12:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60374 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiAZKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:12:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E0F26177B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6CFC340E3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643191960;
        bh=ccjGCZoOtKoJYyuXTyfMEeBaTqNpUBC4v5oPj8Lt21Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X4irv7rjiXIgXiM8OvbO6eyW1al5qYwzLzZ908Ala0iUpiAAHxsYf36djejTj3/IF
         3ZZqdtKReh3c97xWW+/KrovdBvhxR806qp8VXhmMb7ZjG6JxPC5yHe7TwQ8Jf2Ai4J
         VH6W4LtmqV4Pfm7cs7QoBNea7w4TMh7NNCOBs9mxU2qqzxgarDUfDOqdxTNaSPAX2/
         6lt++kqL2vivikbaeTSO7wrKH0gzoUVMg3+640xZIkIlaVeVP43jWB2y19EsFpA0vl
         MPxgqkwfb3eh/eqLHoN60x5JqaU9Bl+roPpDnEBoQN+2KvNVzsetPfobjLUsQCzi4a
         kfJYQCcaox7cA==
Received: by mail-wr1-f43.google.com with SMTP id e8so23022048wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 02:12:40 -0800 (PST)
X-Gm-Message-State: AOAM533zhz8/6CVLpq5KVROe1/aOdxUMwRbZcw6qlZ2j6JzkOb5gSAbt
        SEdgIEHOWRv14keb1FlnT9677kzlUXyEPJD+mVI=
X-Google-Smtp-Source: ABdhPJzyqBxCJwFE66pSShlfdBw6USc/daPY7a5frBzVcjJpBHmVgJlAOiGNC0BOEMai/zGiy5mhCrMVkVYF+UPLtB8=
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr22370201wrs.447.1643191958745;
 Wed, 26 Jan 2022 02:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20211216082812.165387-1-jianyong.wu@arm.com> <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com> <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com> <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
 <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com> <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
In-Reply-To: <AM9PR08MB72763D5DA0C5F22D2126ABF4F4209@AM9PR08MB7276.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Jan 2022 11:12:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
Message-ID: <CAMj1kXGjAxd2xb0u1PLSLGAe8jJdhJm3wR+y=7qB4C1J6Ebgcw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud mapping
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     Justin He <Justin.He@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 at 11:09, Jianyong Wu <Jianyong.Wu@arm.com> wrote:
>
> Hi Ard,
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Wednesday, January 26, 2022 4:37 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Jianyong Wu
> > <Jianyong.Wu@arm.com>; will@kernel.org; Anshuman Khandual
> > <Anshuman.Khandual@arm.com>; akpm@linux-foundation.org;
> > david@redhat.com; quic_qiancai@quicinc.com; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > gshan@redhat.com; nd <nd@arm.com>
> > Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
> > pud mapping
> >
> > On Wed, 26 Jan 2022 at 05:21, Justin He <Justin.He@arm.com> wrote:
> > >
> > > Hi Catalin
> > >
> > > > -----Original Message-----
> > > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > > Sent: Friday, January 7, 2022 6:43 PM
> > > > To: Jianyong Wu <Jianyong.Wu@arm.com>
> > > > Cc: will@kernel.org; Anshuman Khandual
> > <Anshuman.Khandual@arm.com>;
> > > > akpm@linux-foundation.org; david@redhat.com;
> > > > quic_qiancai@quicinc.com; ardb@kernel.org;
> > > > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > > > gshan@redhat.com; Justin He <Justin.He@arm.com>; nd <nd@arm.com>
> > > > Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when
> > > > create pud mapping
> > > >
> > > > On Fri, Jan 07, 2022 at 09:10:57AM +0000, Jianyong Wu wrote:
> > > > > Hi Catalin,
> > > > >
> > > > > I roughly find the root cause.
> > > > >  alloc_init_pud will be called at the very beginning of kernel
> > > > > boot in
> > > > create_mapping_noalloc where no memory allocator is initialized. But
> > > > lockdep check may need allocate memory. So, kernel take exception
> > > > when acquire lock.(I have not found the exact code that cause this
> > > > issue) that's say we may not be able to use a lock so early.
> > > > >
> > > > > I come up with 2 methods to address it.
> > > > > 1) skip dead lock check at the very beginning of kernel boot in
> > > > > lockdep
> > > > code.
> > > > > 2) provided 2 two versions of __create_pgd_mapping, one with lock
> > > > > in it and the other without. There may be no possible of race for
> > > > > memory mapping at the very beginning time of kernel boot, thus we
> > > > > can use the no lock version of __create_pgd_mapping safely.
> > > > > In my test, this issue is gone if there is no lock held in
> > > > > create_mapping_noalloc. I think create_mapping_noalloc is called
> > > > > early enough to avoid the race conditions of memory mapping,
> > > > > however, I have not proved it.
> > > >
> > > > I think method 2 would work better but rather than implementing new
> > > > nolock functions I'd add a NO_LOCK flag and check it in
> > > > alloc_init_pud() before mutex_lock/unlock. Also add a comment when
> > > > passing the NO_LOCK flag on why it's needed and why there wouldn't
> > > > be any races at that stage (early boot etc.)
> > > >
> > > The problematic code path is:
> > > __primary_switched
> > >         early_fdt_map->fixmap_remap_fdt
> > >                 create_mapping_noalloc->alloc_init_pud
> > >                         mutex_lock (with Jianyong's patch)
> > >
> > > The problem seems to be that we will clear BSS segment twice if kaslr
> > > is enabled. Hence, some of the static variables in lockdep init
> > > process were messed up. That is to said, with kaslr enabled we might
> > > initialize lockdep twice if we add mutex_lock/unlock in alloc_init_pud().
> > >
> >
> > Thanks for tracking that down.
> >
> > Note that clearing the BSS twice is not the root problem here. The root
> > problem is that we set global state while the kernel runs at the default link
> > time address, and then refer to it again after the entire kernel has been
> > shifted in the kernel VA space. Such global state could consist of mutable
> > pointers to statically allocated data (which would be reset to their default
> > values after the relocation code runs again), or global pointer variables in BSS.
> > In either case, relying on such a global variable after the second relocation
> > performed by KASLR would be risky, and so we should avoid manipulating
> > global state at all if it might involve pointer to statically allocated data
> > structures.
> >
> > > In other ways, if we invoke mutex_lock/unlock in such a early booting stage.
> > > It might be unsafe because lockdep inserts lock_acquire/release as the
> > > complex hooks.
> > >
> > > In summary, would it better if Jianyong splits these early boot and
> > > late boot case? e.g. introduce a nolock version for
> > create_mapping_noalloc().
> > >
> > > What do you think of it?
> > >
> >
> > The pre-KASLR case definitely doesn't need a lock. But given that
> > create_mapping_noalloc() is only used to map the FDT, which happens very
> > early one way or the other, wouldn't it be better to move the lock/unlock
> > into other callers of __create_pgd_mapping()? (and make sure no other
> > users of the fixmap slots exist)
>
> There are server callers of __create_pgd_mapping. I think some of them need no fixmap lock as they are called so early. I figure out all of them here:
> create_mapping_noalloc:   no lock
> create_pgd_mapping:   no lock
> __map_memblock:    no lock
> map_kernel_segment:  no lock
> map_entry_trampoline: no lock
> update_mapping_prot:    need lock
> arch_add_memory:  need lock
>
> WDYT?
>

That seems reasonable, but it needs to be documented clearly in the code.
