Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679974B2D48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiBKTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:08:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:08:52 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECCBCC8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:08:51 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id w7so12607329ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JLd28e+NLvwE6yBfdYj8gXKTpz4aPz6HX1YLob6zz0=;
        b=jIFPSDD96puT+vw0LNhv65wJ7YEr8bY0vCv0LpBkiGlx1SUSYLO/sLfHDFyIHImAzG
         /h9SSrDWWiozdtKRfir2pG3HSAc90J3C/9KERDnq9jG3lTGrtP7aVb3ziTBtGoHdfj/q
         7LmJIVTzpgc5HNz+bMGjINrAQPe2fKiCjgFUFNXz7yw9a3jgFEbvUsnsRUu8cuh8bZ8K
         rL2t2vQ3cizHS10jO8/dyGu1UC8D5FYveJq2yDA+rJDK+bfzVc9wryyGK9LlPvHBJyFM
         6MdgIi1bXRDUPMpUcQjkmrAXjgqi5mhTK9Bk7CBw52FEu+qGUiO32Vq4extSiJGWreYY
         4Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JLd28e+NLvwE6yBfdYj8gXKTpz4aPz6HX1YLob6zz0=;
        b=3aicVfjx/eqDan7MtC0I4vjguQWGUcFwz3huznXeoJBSBWrrdNqbxMkoZoIWis8r6m
         CSKFZaWxXSFbalpEH+BsK4FQvH7DPvGsRaqE0K9IaQkum4/c/Ko1c9jcJ5+S5UbtslOS
         ReZBvryK/H21eZ1ZGs6veS5Vk5ogH1d9ZzDPnGX+4PiVydAclqAg0yURbtYXlZ3cX6Wd
         raRYmttPQGol8nnf4KnVbdvEDFxwoSHlLwewFqaIvdy96Gf2gcr+V/eDQpm5vfkJYcJn
         K6aAzw6HDYQ4fwUUW/0WjgnLqSR/dYRvQIdt7pC/44uM3udn+67GEYXSlfiL8LPbd8KK
         wjlA==
X-Gm-Message-State: AOAM530AnW13qu/CMpV2Fl8FdYbu8CzU6NxSxmY8i8FUHZ6bPN3HPNMv
        8UCGcSBwqRPnAV/XnkWSUNNje3zh9vX+b+j/q1KxQw==
X-Google-Smtp-Source: ABdhPJwjPPoE2UoJiEd8CP47TnFE6isPn/wYwMgodNPtAkYB93NtYOfaYYWutD3xTmMDsmWURym++djWJJ9Mz1VKR0Y=
X-Received: by 2002:a5e:a70e:: with SMTP id b14mr1625729iod.171.1644606530262;
 Fri, 11 Feb 2022 11:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com> <YgSDcmXya7vTvvZE@xz-m1.local>
 <bf1f7a47-5d57-492a-03dd-e42afe186d47@oracle.com> <YgXJ4VjYBJC9ZfbF@xz-m1.local>
In-Reply-To: <YgXJ4VjYBJC9ZfbF@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 11 Feb 2022 11:08:14 -0800
Message-ID: <CAJHvVcg1pFfFSggGjDCNKt6ZzS07HYNHHQMcmguZACECpBGf=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 6:29 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 10, 2022 at 01:36:57PM -0800, Mike Kravetz wrote:
> > > Another use case of DONTNEED upon hugetlbfs could be uffd-minor, because afaiu
> > > this is the only api that can force strip the hugetlb mapped pgtable without
> > > losing pagecache data.
> >
> > Correct.  However, I do not know if uffd-minor users would ever want to
> > do this.  Perhaps?

I talked with some colleagues, and I didn't come up with any
production *requirement* for it, but it may be a convenience in some
cases (make certain code cleaner, e.g. not having to unmap-and-remap
to tear down page tables as Peter mentioned). I think Peter's
assessment below is right.

>
> My understanding is before this patch uffd-minor upon hugetlbfs requires the
> huge file to be mapped twice, one to populate the content, then we'll be able
> to trap MINOR faults via the other mapping.  Or we could munmap() the range and
> remap it again on the same file offset to drop the pgtables, I think. But that
> sounds tricky.  MINOR faults only works with pgtables dropped.
>
> With DONTNEED upon hugetlbfs we can rely on one single mapping of the file,
> because we can explicitly drop the pgtables of hugetlbfs files without any
> other tricks.
>
> However I have no real use case of it.  Initially I thought it could be useful
> for QEMU because QEMU migration routine is run with the same mm context with
> the hypervisor, so by default is doesn't have two mappings of the same guest
> memory.  If QEMU wants to leverage minor faults, DONTNEED could help.).
>
> However when I was measuring bitmap transfer (assuming that's what minor fault
> could help with qemu's postcopy) there some months ago I found it's not as slow
> as I thought at all..  Either I could have missed something, or we're facing
> different problems with what it is when uffd minor is firstly proposed by Axel.

Re: the bitmap, that matters most on machines with lots of RAM. For
example, GCE offers some VMs with up to 12 *TB* of RAM
(https://cloud.google.com/compute/docs/memory-optimized-machines), I
think with this size of machine we see a significant benefit, as it
may take some significant time for the bitmap to arrive over the
network.

But I think that's a bit of an edge case, most machines are not that
big. :) I think the benefit is more often seen just in avoiding
copies. E.g. if we find a page is already up-to-date after precopy, we
just install PTEs, no copying or page allocation needed. And even when
we have to go fetch a page over the network, one can imagine an RDMA
setup where we can avoid any copies/allocations at all even in that
case. I suppose this also has a bigger effect on larger machines, e.g.
ones that are backed by 1G pages instead of 4k.

>
> This is probably too out of topic, though..  Let me go back..
>
> Said that, one thing I'm not sure about DONTNEED on hugetlb is whether this
> could further abuse DONTNEED, as the original POSIX definition is as simple as:
>
>   The application expects that it will not access the specified address range
>   in the near future.
>
> Linux did it by tearing down pgtable, which looks okay so far.  It could be a
> bit more weird to apply it to hugetlbfs because from its definition it's a hint
> to page reclaims, however hugetlbfs is not a target of page reclaim, neither is
> it LRU-aware.  It goes further into some MADV_ZAP styled syscall.
>
> I think it could still be fine as posix doesn't define that behavior
> specifically on hugetlb so it can be defined by Linux, but not sure whether
> there can be other implications.
>
> Thanks,
>
> --
> Peter Xu
>
