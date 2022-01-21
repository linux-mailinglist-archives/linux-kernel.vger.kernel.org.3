Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0491495ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379036AbiAUHfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379040AbiAUHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:35:30 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741C7C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:35:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j2so39252404edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RP302OUQarqJcKlS/8U/UoHcxHB/87qXxuKZS5RzpFU=;
        b=RYeMyMypdwPcT6x0u3IHpo9uVGKAHlUmZMpJlcV90hHzqRU6odtfB9sRHxDRNHvXFP
         s/zENm+ToIMnjD/m2uZdeKP1NkhKuJqb5LORO1wgUa1EgrM89wCzq3fYLTSxhjCzHmqD
         oyN0jnACc8N03BmUxGn2a4kRUYInNwNrSSs7uvdjk3SUXvvK0wBUrhQlrJUk9IMuhqOZ
         5iRvlbzTIoYgucR+FXlvPy4jp3ChdS44Dzp0TCOSikdg+jv+93aFhGOqRLZyZcxmnQDx
         ymoIwadBur0wpHSYPBbyU6PN5AIpDf4/akzZKP375NppFOI8LUvAb8u8eeJeACz2ZrDg
         A2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RP302OUQarqJcKlS/8U/UoHcxHB/87qXxuKZS5RzpFU=;
        b=IQM1DhyBM9971zzgydLmGfgHRhyzNkvpmaqKuYZIERM7NFyqb7R6p0+Dp8sOogMOpJ
         S7mBqdwzKcuspoA2HXJUiAvYX2Xyz+W1oXM5UxhfMKD8dQZhzZ98nGd9K56liF9KkjLM
         tV7K0PAiv9rmfRYq6dZff48sweMlXtLiL7yXDE9DTt6rJqpDmUMZIL6pbKTwAN9Nf0sX
         pt0BAVXd69bRAw3mpuUw+8+9i/YCh0+lkIOFVKPKyiSsWXPiHnbfY/41m/lmfywA/Z3N
         0byXm7Rf4vtXYL0VtvA2xlXm97ovSTQZda1BF8hR2rHmdSy7SodwGKfYODfsKKSsmMX6
         Ls2A==
X-Gm-Message-State: AOAM5303NEWRAfYt7n9OrpvEQsuet4I+9fRGy8/+dE8dXnTDVzZzrZSZ
        Kyjy8GWT9cXqQYTyZBDENfpUZ8KQyH2cuuWjWMA=
X-Google-Smtp-Source: ABdhPJx6nhfumz35Z0K9DwZnIQuhwfPKh7CTID41/qxla6epld7pxIMQ+ihoBQ6hS3ICWXTGhGR292rZKUqJsbVJKcs=
X-Received: by 2002:a17:907:c1c:: with SMTP id ga28mr849719ejc.502.1642750528776;
 Thu, 20 Jan 2022 23:35:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642526745.git.khalid.aziz@oracle.com> <20220121010806.5607-1-21cnbao@gmail.com>
 <YeoW4CMiU8qbRFST@casper.infradead.org>
In-Reply-To: <YeoW4CMiU8qbRFST@casper.infradead.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 21 Jan 2022 20:35:17 +1300
Message-ID: <CAGsJ_4wv144TUSQPNOnHnmNmJrXe4Fn8d14JeAJ5ka-S+dRxRA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
To:     Matthew Wilcox <willy@infradead.org>
Cc:     khalid.aziz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 3:13 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 21, 2022 at 09:08:06AM +0800, Barry Song wrote:
> > > A file under /sys/fs/mshare can be opened and read from. A read from
> > > this file returns two long values - (1) starting address, and (2)
> > > size of the mshare'd region.
> > >
> > > --
> > > int mshare_unlink(char *name)
> > >
> > > A shared address range created by mshare() can be destroyed using
> > > mshare_unlink() which removes the  shared named object. Once all
> > > processes have unmapped the shared object, the shared address range
> > > references are de-allocated and destroyed.
> >
> > > mshare_unlink() returns 0 on success or -1 on error.
> >
> > I am still struggling with the user scenarios of these new APIs. This patch
> > supposes multiple processes will have same virtual address for the shared
> > area? How can this be guaranteed while different processes can map different
> > stack, heap, libraries, files?
>
> The two processes choose to share a chunk of their address space.
> They can map anything they like in that shared area, and then also
> anything they like in the areas that aren't shared.  They can choose
> for that shared area to have the same address in both processes
> or different locations in each process.
>
> If two processes want to put a shared library in that shared address
> space, that should work.  They probably would need to agree to use
> the same virtual address for the shared page tables for that to work.

we are depending on an elf loader and ld to map the library
dynamically , so hardly
can we find a chance in users' code to call mshare() to map libraries
in application
level?

so we are supposed to modify some very low level code to use this feature?

>
> Processes should probably not put their stacks in the shared region.
> I mean, it could work, I suppose ... threads manage it in a single
> address space.  But I don't see why you'd want to do that.  For
> heaps, if you want the other process to be able to access the memory,
> I suppose you could put it in the shared region, but heaps aren't
> going to be put in the shared region by default.
>
> Think of this like hugetlbfs, only instead of sharing hugetlbfs
> memory, you can share _anything_ that's mmapable.

yep, we can call mshare() on any kind of memory. for example, if multiple
processes use SYSV shmem, posix shmem or mmap the same file. but
it seems it is more sensible to let kernel do it automatically rather than
depending on calling mshare() from users? It is difficult for users to
decide which areas should be applied mshare(). users might want to call
mshare() for all shared areas to save memory coming from duplicated PTEs?
unlike SYSV shmem and POSIX shmem which are a feature for inter-processes
communications,  mshare() looks not like a feature for applications,
but like a feature
for the whole system level? why would applications have to call something which
doesn't directly help them? without mshare(), those applications
will still work without any problem, right? is there anything in
mshare() which is
a must-have for applications? or mshare() is only a suggestion from applications
like madvise()?

>
> > BTW, it seems you have different intention with the below?
> > Shared page tables during fork[1]
> > [1] https://lwn.net/Articles/861547/
>
> Yes, that's completely different.

Thanks for clarification.

Best Regards.
Barry
