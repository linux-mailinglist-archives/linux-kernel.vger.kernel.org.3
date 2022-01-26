Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1F49C563
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbiAZIhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAZIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:37:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EFBC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:37:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB038B81C0D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980E1C340E3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643186229;
        bh=nU5jmwWazR01s92QPi4k3fGl7IngBGdBXIhFjpFuwbI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aGIaqXdd2mvUSHY9qUdwgWMKlGcx3THAvR72ghCpkU6uOZ05Uf86V1Htit6hj5jX0
         RD8g2MiDmHJ8nMQzS1uQ7MqEWZ1qbFUZs/zmqrG8QPxk6V2zLBgt3o/JmI+bJ6IwWV
         OSc0zZgNHhMr+Xy0vOLRsC2SiY+8rVoInyzZIz9xBknDsc35K3Q07pqLmmzA+q3msO
         oyUCfT2cQTfJUJYevGuPZpnnSFyHcl5y2jl83oLC5WHOp0pDMV/BQQsZDRrUvFCDza
         JQjRuxH3ILwxDrUnsrLrkd5ekrTD84rv4r5D0cn3fHA4E+3Mu3kFCz1qVSbArAuQNf
         o8t1ek/DRx71Q==
Received: by mail-wm1-f46.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso3247746wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:37:09 -0800 (PST)
X-Gm-Message-State: AOAM530j2W8hvtDxNTFVm7n5ILguk4biUwgbgsHw3kb5WRnN6bfvTtUs
        ygCHxIyG6MSKAHguenJFqkED0tkDaemlFpJOfI8=
X-Google-Smtp-Source: ABdhPJwPYxV+iFz0IaHFKT5bwvtJ6Tz8Y5rHTgkl96Wb2uV1vtfpvRzqCZloEH0OI40ZI7hsXy2h2EitHxpVCugsKAE=
X-Received: by 2002:a05:600c:4f46:: with SMTP id m6mr4817868wmq.32.1643186227882;
 Wed, 26 Jan 2022 00:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20211216082812.165387-1-jianyong.wu@arm.com> <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com> <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdgZJ/mBG+BCxmEv@arm.com> <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
In-Reply-To: <DB7PR08MB3737631DEE8D6625D3A9E393F7209@DB7PR08MB3737.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Jan 2022 09:36:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
Message-ID: <CAMj1kXF7DJ5UeMn=9gw_Hs3Fa525OFEPsriO=ZprT3rN83=qtQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud mapping
To:     Justin He <Justin.He@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Jianyong Wu <Jianyong.Wu@arm.com>,
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

On Wed, 26 Jan 2022 at 05:21, Justin He <Justin.He@arm.com> wrote:
>
> Hi Catalin
>
> > -----Original Message-----
> > From: Catalin Marinas <catalin.marinas@arm.com>
> > Sent: Friday, January 7, 2022 6:43 PM
> > To: Jianyong Wu <Jianyong.Wu@arm.com>
> > Cc: will@kernel.org; Anshuman Khandual <Anshuman.Khandual@arm.com>;
> > akpm@linux-foundation.org; david@redhat.com; quic_qiancai@quicinc.com;
> > ardb@kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; gshan@redhat.com; Justin He
> > <Justin.He@arm.com>; nd <nd@arm.com>
> > Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create
> > pud mapping
> >
> > On Fri, Jan 07, 2022 at 09:10:57AM +0000, Jianyong Wu wrote:
> > > Hi Catalin,
> > >
> > > I roughly find the root cause.
> > >  alloc_init_pud will be called at the very beginning of kernel boot in
> > create_mapping_noalloc where no memory allocator is initialized. But
> > lockdep check may need allocate memory. So, kernel take exception when
> > acquire lock.(I have not found the exact code that cause this issue)
> > that's say we may not be able to use a lock so early.
> > >
> > > I come up with 2 methods to address it.
> > > 1) skip dead lock check at the very beginning of kernel boot in lockdep
> > code.
> > > 2) provided 2 two versions of __create_pgd_mapping, one with lock in
> > > it and the other without. There may be no possible of race for memory
> > > mapping at the very beginning time of kernel boot, thus we can use the
> > > no lock version of __create_pgd_mapping safely.
> > > In my test, this issue is gone if there is no lock held in
> > > create_mapping_noalloc. I think create_mapping_noalloc is called early
> > > enough to avoid the race conditions of memory mapping, however, I have
> > > not proved it.
> >
> > I think method 2 would work better but rather than implementing new
> > nolock functions I'd add a NO_LOCK flag and check it in
> > alloc_init_pud() before mutex_lock/unlock. Also add a comment when
> > passing the NO_LOCK flag on why it's needed and why there wouldn't be
> > any races at that stage (early boot etc.)
> >
> The problematic code path is:
> __primary_switched
>         early_fdt_map->fixmap_remap_fdt
>                 create_mapping_noalloc->alloc_init_pud
>                         mutex_lock (with Jianyong's patch)
>
> The problem seems to be that we will clear BSS segment twice if kaslr
> is enabled. Hence, some of the static variables in lockdep init process were
> messed up. That is to said, with kaslr enabled we might initialize lockdep
> twice if we add mutex_lock/unlock in alloc_init_pud().
>

Thanks for tracking that down.

Note that clearing the BSS twice is not the root problem here. The
root problem is that we set global state while the kernel runs at the
default link time address, and then refer to it again after the entire
kernel has been shifted in the kernel VA space. Such global state
could consist of mutable pointers to statically allocated data (which
would be reset to their default values after the relocation code runs
again), or global pointer variables in BSS. In either case, relying on
such a global variable after the second relocation performed by KASLR
would be risky, and so we should avoid manipulating global state at
all if it might involve pointer to statically allocated data
structures.

> In other ways, if we invoke mutex_lock/unlock in such a early booting stage.
> It might be unsafe because lockdep inserts lock_acquire/release as the complex
> hooks.
>
> In summary, would it better if Jianyong splits these early boot and late boot
> case? e.g. introduce a nolock version for create_mapping_noalloc().
>
> What do you think of it?
>

The pre-KASLR case definitely doesn't need a lock. But given that
create_mapping_noalloc() is only used to map the FDT, which happens
very early one way or the other, wouldn't it be better to move the
lock/unlock into other callers of __create_pgd_mapping()? (and make
sure no other users of the fixmap slots exist)
