Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18B549AB28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3416258AbiAYEkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381709AbiAYD0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:26:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4542CC06174E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:16:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id s5so25711048ejx.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxPfP8pNdiwhYtTaz9f4lBwxupGy0qqIDwxrF8YmvL4=;
        b=0lvwqQR2eMER7dNpywxJaMiUqn32TykDwHsFXQbk9QtjkddJz2JxMGMZ7vUIn8qNts
         b4NnCXXnk++9wRjgnjBoj/H8wwHQbeMEeOeFiXKEz1Ghgw9sUe15oV7MQf5g0moLeSDr
         HHQwzSZxyKgDcTjLe+gQyBxqKouzz3a6ZOqPPGvmFR0kxoZSQmhWErOkToPMsq+H6Ece
         e8LzxFG2GXvbEYwqdSuTihLXeFvh6lNrlYwiULzPCsV35seif51vYRYesGdEkjf9RRvZ
         2xcpPXV1xP8ARGPHNtdSNmtDF9vk4RSO4pz23LKFXsjvYns3rjQCRe8CcKkLqLnQCHtZ
         h1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxPfP8pNdiwhYtTaz9f4lBwxupGy0qqIDwxrF8YmvL4=;
        b=cTlXoWTXix8G1xcWkamwKEnJE7jgLt64I0ketvkY5kejfjgeSyc6EmjRjVrRktQEQW
         FAnrTBoE2YmyV4dvNlbnQvl7y6P2b+1JX3aB5nBBCIu+e3ckwryrzaSVu9j3P4i5bqKy
         Go/p2uOoB7fPuZ4eGWu9wQfIRVNrpPmyrFDiUBJJ9vmxdI6WjV7l7AGhQFyeHsfM2oke
         kgswD50l7X5jCATJWgWgkfNvk4+EiQpm+UktX4Dz2x8LyoLeoheAAB2Az0vIUDkHnDto
         fS73Rq0tGRZQGO0jlVaLwpem0OZOeJgTUHN5LXvHgNsmXn67jidsbXDade4SrEF6TAFd
         /8+w==
X-Gm-Message-State: AOAM5326TevcBnqOCKgCw8hM9pHy5pMwa6Mqxx5neLc1RPpZTKFCIKFu
        tenXbIWPXNLsCbHrsKAoIzUhKc9XajpJawxmMWG/Rw==
X-Google-Smtp-Source: ABdhPJw5ZrUO3qCzeWxUtnf+ow/Ga2rQet7PkkHrJWNYwOkFrn2Bn5jHHu8lm5LUBgrkablnldXJANswKhLcg+kcvBE=
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr13841455eji.675.1643066208803;
 Mon, 24 Jan 2022 15:16:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642526745.git.khalid.aziz@oracle.com> <YevrGs3WE7ywB+lH@kernel.org>
 <4d333527-391f-fe6b-eb2d-123d67242d2c@oracle.com> <CALCETrVNrcsLvFwTER8LmgZZdy0Mye7EJXyuOaS5yVQvB5UNpA@mail.gmail.com>
 <e26d2bfd-adbf-16ab-76d4-949f0ebb86cf@oracle.com>
In-Reply-To: <e26d2bfd-adbf-16ab-76d4-949f0ebb86cf@oracle.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 24 Jan 2022 15:16:26 -0800
Message-ID: <CALCETrXjxoEmhyPdtkankPPaKp0r=oYqhnzL1A7rnQEj6xWSig@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
        willy@infradead.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, david@redhat.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 2:34 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 1/24/22 12:45, Andy Lutomirski wrote:
> > On Mon, Jan 24, 2022 at 10:54 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >>
> >> On 1/22/22 04:31, Mike Rapoport wrote:
> >>> (added linux-api)
> >>>
> >>> On Tue, Jan 18, 2022 at 02:19:12PM -0700, Khalid Aziz wrote:
> >>>> Page tables in kernel consume some of the memory and as long as
> >>>> number of mappings being maintained is small enough, this space
> >>>> consumed by page tables is not objectionable. When very few memory
> >>>> pages are shared between processes, the number of page table entries
> >>>> (PTEs) to maintain is mostly constrained by the number of pages of
> >>>> memory on the system. As the number of shared pages and the number
> >>>> of times pages are shared goes up, amount of memory consumed by page
> >>>> tables starts to become significant.
> >>>>
> >>>> Some of the field deployments commonly see memory pages shared
> >>>> across 1000s of processes. On x86_64, each page requires a PTE that
> >>>> is only 8 bytes long which is very small compared to the 4K page
> >>>> size. When 2000 processes map the same page in their address space,
> >>>> each one of them requires 8 bytes for its PTE and together that adds
> >>>> up to 8K of memory just to hold the PTEs for one 4K page. On a
> >>>> database server with 300GB SGA, a system carsh was seen with
> >>>> out-of-memory condition when 1500+ clients tried to share this SGA
> >>>> even though the system had 512GB of memory. On this server, in the
> >>>> worst case scenario of all 1500 processes mapping every page from
> >>>> SGA would have required 878GB+ for just the PTEs. If these PTEs
> >>>> could be shared, amount of memory saved is very significant.
> >>>>
> >>>> This is a proposal to implement a mechanism in kernel to allow
> >>>> userspace processes to opt into sharing PTEs. The proposal is to add
> >>>> a new system call - mshare(), which can be used by a process to
> >>>> create a region (we will call it mshare'd region) which can be used
> >>>> by other processes to map same pages using shared PTEs. Other
> >>>> process(es), assuming they have the right permissions, can then make
> >>>> the mashare() system call to map the shared pages into their address
> >>>> space using the shared PTEs.  When a process is done using this
> >>>> mshare'd region, it makes a mshare_unlink() system call to end its
> >>>> access. When the last process accessing mshare'd region calls
> >>>> mshare_unlink(), the mshare'd region is torn down and memory used by
> >>>> it is freed.
> >>>>
> >>>>
> >>>> API Proposal
> >>>> ============
> >>>>
> >>>> The mshare API consists of two system calls - mshare() and mshare_unlink()
> >>>>
> >>>> --
> >>>> int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)
> >>>>
> >>>> mshare() creates and opens a new, or opens an existing mshare'd
> >>>> region that will be shared at PTE level. "name" refers to shared object
> >>>> name that exists under /sys/fs/mshare. "addr" is the starting address
> >>>> of this shared memory area and length is the size of this area.
> >>>> oflags can be one of:
> >>>>
> >>>> - O_RDONLY opens shared memory area for read only access by everyone
> >>>> - O_RDWR opens shared memory area for read and write access
> >>>> - O_CREAT creates the named shared memory area if it does not exist
> >>>> - O_EXCL If O_CREAT was also specified, and a shared memory area
> >>>>     exists with that name, return an error.
> >>>>
> >>>> mode represents the creation mode for the shared object under
> >>>> /sys/fs/mshare.
> >>>>
> >>>> mshare() returns an error code if it fails, otherwise it returns 0.
> >>>
> >>> Did you consider returning a file descriptor from mshare() system call?
> >>> Then there would be no need in mshare_unlink() as close(fd) would work.
> >>
> >> That is an interesting idea. It could work and eliminates the need for a new system call. It could be confusing though
> >> for application writers. A close() call with a side-effect of deleting shared mapping would be odd. One of the use cases
> >> for having files for mshare'd regions is to allow for orphaned mshare'd regions to be cleaned up by calling
> >> mshare_unlink() with region name. This can require calling mshare_unlink() multiple times in current implementation to
> >> bring the refcount for mshare'd region to 0 when mshare_unlink() finally cleans up the region. This would be problematic
> >> with a close() semantics though unless there was another way to force refcount to 0. Right?
> >>
> >
> > I'm not sure I understand the problem.  If you're sharing a portion of
> > an mm and the mm goes away, then all that should be left are some
> > struct files that are no longer useful.  They'll go away when their
> > refcount goes to zero.
> >
> > --Andy
> >
>
> The mm that holds shared PTEs is a separate mm not tied to a task. I started out by sharing portion of the donor process
> initially but that necessitated keeping the donor process alive. If the donor process dies, its mm and the mshare'd
> portion go away.
>
> One of the requirements I have is the process that creates mshare'd region can terminate, possibly involuntarily, but
> the mshare'd region persists and rest of the consumer processes continue without hiccup. So I create a separate mm to
> hold shared PTEs and that mm is cleaned up when all references to mshare'd region go away. Each call to mshare()
> increments the refcount and each call to mshare_unlink() decrements the refcount.

In general, objects which are kept alive by name tend to be quite
awkward. Things like network namespaces essentially have to work that
way and end up with awkward APIs.  Things like shared memory don't
actually have to be kept alive by name, and the cases that do keep
them alive by name (tmpfs, shmget) can end up being so awkward that
people invent nameless variants like memfd.

So I would strongly suggest you see how the design works out with no
names and no external keep-alive mechanism.  Either have the continued
existence of *any* fd keep the whole thing alive or make it be a pair
of struct files, one that controls the region (and can map things into
it, etc) and one that can map it.  SCM_RIGHTS is pretty good for
passing objects like this around.

--Andy
