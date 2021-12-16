Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71366477114
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhLPLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLPLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:49:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001A5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:49:48 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o13so43614902wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 03:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xMPK5FXNG3vuM/72Q175/4nzKlGRl+AzmP2l2hg14BA=;
        b=gN8dNYwP4jmxrcG00NeWvls3mRXMNXMD4BZXPsHik9ZSgLEArKuBCTlHzlN31t4MLN
         9NZehuKx3KyNS9qzT6TEmkIIW3niwzlUonqE3HmyRTI4Cl5Nw+sLSMZDwWguwxno5Dx3
         zl+VFEAUFuX7tzbMUpPFBd9b4pWJlFL5QtyrmyVMNeWAmTY7zmCHUWSLZc6aJFRGeFdC
         G0TVPAWow66YOP1xHWYpWJ+U2qGSaNZQTAbAVAM92DmRl0TXsCJtXmbJhJvx6EdGjaI+
         mwJAAoXPvZlgK5X75auSVlkSdXdUWnvYvhLYMf6FUv587QYacq7MLoLgyxSdJrrjjkN+
         VUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xMPK5FXNG3vuM/72Q175/4nzKlGRl+AzmP2l2hg14BA=;
        b=BvZ7pT431SmsUUgOEMRAp5t8SL/lDWBcTG7ms1RSBDbOMBAVEa/MK9sLtgZCJR/PqJ
         5a9BvGS2Wp5k7HvJKCakZDYEi2Rms7bk3xNNzfCyg7NFHW3vcjpjUXDmruVRWN1GMD9w
         1vcOwKA0TUweI6/b5eot0quRYxXu3SIWZOdmF9mCDtu4VnXYMC59NFyH7Dtqi+3nbZ9r
         g14VxAIRKbssFsdr9+A1wQrcnYfO5dNLODCYhApm2igNHODIwguRrzrmnxcDEdoA5hvc
         YA0vidYSAov293zN3fEkdrxGSYMK9dd2loSkEDRffoaPaoyNjiyg6xK5xqmZHyOMppaT
         J2eA==
X-Gm-Message-State: AOAM530ClSehXL3Y9m3bnGd7p74fpDKnlv5/A/SV4Ep4MgyNKpAjuZUv
        S+QHVUFDEV+1s3IqiHis7tWD8Q==
X-Google-Smtp-Source: ABdhPJxVV9eNB2hO0s67S/kINf4gnqUHNG34R8ojjkrIhYoyEE7Oy6B2+ooZUgswMppmHhultEQp6Q==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr5968393wrt.222.1639655387577;
        Thu, 16 Dec 2021 03:49:47 -0800 (PST)
Received: from localhost ([2a02:8070:41c8:c700:3d3f:77af:d3f0:b7f0])
        by smtp.gmail.com with ESMTPSA id b10sm5267943wrt.36.2021.12.16.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:49:47 -0800 (PST)
Date:   Thu, 16 Dec 2021 12:49:46 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        rientjes@google.com, willy@infradead.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
Message-ID: <Ybsn2hJZXRofwuv+@cmpxchg.org>
References: <20211208212211.2860249-1-surenb@google.com>
 <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz>
 <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
 <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 06:26:11PM -0800, Suren Baghdasaryan wrote:
> On Thu, Dec 9, 2021 at 9:06 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Dec 9, 2021 at 8:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 09-12-21 08:24:04, Suren Baghdasaryan wrote:
> > > > On Thu, Dec 9, 2021 at 1:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > Do we want this on top?
> > > >
> > > > As we discussed in this thread
> > > > https://lore.kernel.org/all/YY4snVzZZZYhbigV@dhcp22.suse.cz,
> > > > __oom_reap_task_mm in exit_mmap allows oom-reaper/process_mrelease to
> > > > unmap pages in parallel with exit_mmap without blocking each other.
> > > > Removal of __oom_reap_task_mm from exit_mmap prevents this parallelism
> > > > and has a negative impact on performance. So the conclusion of that
> > > > thread I thought was to keep that part. My understanding is that we
> > > > also wanted to remove MMF_OOM_SKIP as a follow-up patch but
> > > > __oom_reap_task_mm would stay.
> > >
> > > OK, then we were talking past each other, I am afraid. I really wanted
> > > to get rid of this oom specific stuff from exit_mmap. It was there out
> > > of necessity. With a proper locking we can finally get rid of the crud.
> > > As I've said previously oom reaping has never been a hot path.
> > >
> > > If we really want to optimize this path then I would much rather see a
> > > generic solution which would allow to move the write lock down after
> > > unmap_vmas. That would require oom reaper to be able to handle mlocked
> > > memory.
> >
> > Ok, let's work on that and when that's done we can get rid of the oom
> > stuff in exit_mmap. I'll look into this over the weekend and will
> > likely be back with questions.
> 
> As promised, I have a question:
> Any particular reason why munlock_vma_pages_range clears VM_LOCKED
> before unlocking pages and not after (see:
> https://elixir.bootlin.com/linux/latest/source/mm/mlock.c#L424)? Seems
> to me if VM_LOCKED was reset at the end (with proper ordering) then
> __oom_reap_task_mm would correctly skip VM_LOCKED vmas.
> https://lore.kernel.org/lkml/20180514064824.534798031@linuxfoundation.org/
> has this explanation:
> 
> "Since munlock_vma_pages_range() depends on clearing VM_LOCKED from
> vm_flags before actually doing the munlock to determine if any other
> vmas are locking the same memory, the check for VM_LOCKED in the oom
> reaper is racy."
> 
> but "to determine if any other vmas are locking the same memory"
> explanation eludes me... Any insights?

A page's mlock state is determined by whether any of the vmas that map
it are mlocked. The munlock code does:

vma->vm_flags &= VM_LOCKED_CLEAR_MASK
TestClearPageMlocked()
isolate_lru_page()
__munlock_isolated_page()
  page_mlock()
    rmap_walk() # for_each_vma()
      page_mlock_one()
        (vma->vm_flags & VM_LOCKED) && TestSetPageMlocked()

If we didn't clear the VM_LOCKED flag first, racing threads could
re-lock pages under us because they see that flag and think our vma
wants those pages mlocked when we're in the process of munlocking.

