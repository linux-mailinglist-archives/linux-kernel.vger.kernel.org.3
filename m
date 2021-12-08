Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A446D460
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhLHN1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLHN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:27:39 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB0C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 05:24:07 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i6so2198326ila.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hwpYW1fSLpY7upb+3/zEof4IWOihAsLuJGqUjdGP2w=;
        b=C9HHvlTCn801Ml1Oky3DTqTPoNVywgoylirQDMtlEgWM2n39Q5DX9igGsvhLzFQDHQ
         knUBg75dyPO8Wmz+Jl/XrxlMRUxan9eHmQEhTuVm1oHECvncSOrwM3pbnpBTJcD4T0K8
         o0yD920n5ZsrbVaJTSL4IzHTmnTBx+8G6MD6NGnpJlSrZSO1xaaK83OeMkROnvSBbiRt
         DriRoGhkj/zQFnxvqNn8NkFDLSDYMFErIsT9h5MSouv1EbP6b6TM6FI6OhjIwoW46J34
         d/JC6Ka7RZLfhTF61ZTRvS4MDvWjoJ8MsBK9K/C+AQS3SKOrsi/IABMv/L4+0RfT3j51
         aNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hwpYW1fSLpY7upb+3/zEof4IWOihAsLuJGqUjdGP2w=;
        b=foNoNI72BfbOW9hcf92P340mWMzUel9o+oz3scVGuBdAuiUfv3NDa4CjhBqor0PxTW
         /9KL3h5J/6/ulxIyKKG8kk3aKM+ZmW8a6Rlsrn2jLiuARQnWi63PrE8HDrpm8XHEoJNy
         FMKO153pNId1jAbaD6xFTRzewMkKNup1lA8TytRHFz9DNMurskH0KGIpY7uGRigddLen
         HSq5KjDhLiVhKNQTWGYm6uSVzxI4R5Nm1zsCkN84c6QEglW5HOSqVOV5/3TYFFJHILu2
         +FWGHjaZkUIzHyfjSJjxHvZCD0bwZEyJ9OVtg5xk7mb+3ZwB3W1STcqFL5s0fvcG6Bgv
         n1Yw==
X-Gm-Message-State: AOAM533cMHKOg7Meixe+NjJQHMfOaUxY0abSiMerDbnEzX4QYBzaRj7S
        QU18+cUx4nY2b0dEO43Z8v6ItITh90I3BvAWY2I=
X-Google-Smtp-Source: ABdhPJyiDRDC1BYPpzq5X39uBmslh4AEGsPHR94MBQo9F/89FitwQ7zivjGuj3vCNlO7nvyswGWJffTObizKpi4IXHM=
X-Received: by 2002:a92:c562:: with SMTP id b2mr6949815ilj.108.1638969847133;
 Wed, 08 Dec 2021 05:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <YZsi+RFed3hX9T8w@casper.infradead.org>
 <861f98b5-9211-98c7-b4f7-fd71146aa64c@redhat.com>
In-Reply-To: <861f98b5-9211-98c7-b4f7-fd71146aa64c@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 8 Dec 2021 14:23:55 +0100
Message-ID: <CAM9Jb+jkod+qL+xdSGrnqrOqHYM+bEa4JZ=Hqyt0WGzsdJPa_A@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Many applications do sophisticated management of their heap memory for
> >> better performance but with low cost. We have a bunch of such
> >> applications running on our production and examples include caching and
> >> data storage services. These applications keep their hot data on the
> >> THPs for better performance and release the cold data through
> >> MADV_DONTNEED to keep the memory cost low.
> >>
> >> The kernel defers the split and release of THPs until there is memory
> >> pressure. This causes complicates the memory management of these
> >> sophisticated applications which then needs to look into low level
> >> kernel handling of THPs to better gauge their headroom for expansion. In
> >> addition these applications are very latency sensitive and would prefer
> >> to not face memory reclaim due to non-deterministic nature of reclaim.
> >>
> >> This patch let such applications not worry about the low level handling
> >> of THPs in the kernel and splits the THPs synchronously on
> >> MADV_DONTNEED.
> >
> > I've been wondering about whether this is really the right strategy
> > (and this goes wider than just this one, new case)
> >
> > We chose to use a 2MB page here, based on whatever heuristics are
> > currently in play.  Now userspace is telling us we were wrong and should
> > have used smaller pages.
>
> IIUC, not necessarily, unfortunately.
>
> User space might be discarding the whole 2MB either via a single call
> (MADV_DONTNEED a 2MB range as done by virtio-balloon with "free page
> reporting" or by virtio-mem in QEMU). In that case, there is nothing to
> migrate and we were not doing anything wrong.
>
> But more extreme, user space might be discarding the whole THP in small
> pieces shortly over time. This for example happens when a VM inflates
> the memory balloon via virtio-balloon. All inflation requests are 4k,
> resulting in a 4k MADV_DONTNEED calls. If we end up inflating a THP
> range inside of the VM, mapping to a THP range inside the hypervisor,
> we'll essentially free a THP in the hypervisor piece by piece using
> individual MADV_DONTNEED calls -- this happens frequently. Something
> similar can happen when de-fragmentation inside the VM "moves around"
> inflated 4k pages piece by piece to essentially form a huge inflated
> range -- this happens less frequently as of now. In both cases,
> migration is counter-productive, as we're just about to free the whole
> range either way.
>
> (yes, there are ways to optimize, for example using hugepage ballooning
> or merging MADV_DONTNEED calls in the hypervisor, but what I described
> is what we currently implement in hypervisors like QEMU, because there
> are corner cases for everything)

It seems this can happen when guest using huge pages or THP. If we end
up not freeing
hypervisor memory(THP) till memory pressure mounts, this can be a
problem for "free page reporting"
as well?

>
> Long story short: it's hard to tell what will happen next based on a
> single MADV_DONTNEED call. Page compaction, in comparison, doesn't care
> and optimized the layout as it observes it.
