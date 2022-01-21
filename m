Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841CC496186
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351153AbiAUOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbiAUOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:47:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3DCC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/4JfptqWCgo5zviDV0QcdmoidVe9JypSlmVm9x6vVrg=; b=AOblsX4w9Ofte1v2gveaP3mahu
        JmdSwluekwq94Dgnj/LY1vKDTTfbn75KfJjaZqTtf5uo4NvVVkrZjZzDVOYmWKhXcZxd3yoi809qw
        VvhIdmFRrlBWqQ6zkbMAg98eRUC4fTTotILHV+W95sTv2OJbsFngMvLC6yu71c72nF8Jb0WvGO0L4
        7yh2nBAgc6SnzV2KsNC9HBv05PyU8/v1iYRwvkYD6CfnZK6okx2xfFJw5/SFofzHNDqU3tzmoDb9p
        HYHIpWrZqVNic1LvI2HED5x4DoMKm/R5Z31ZrrRZHPKHB4isD/Z90A91oOliryTlfVEoK1OPgTsLc
        9+xeL7dA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAvC5-00FfsH-6F; Fri, 21 Jan 2022 14:47:13 +0000
Date:   Fri, 21 Jan 2022 14:47:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     khalid.aziz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <YerHceldiYXLk2DE@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220121010806.5607-1-21cnbao@gmail.com>
 <YeoW4CMiU8qbRFST@casper.infradead.org>
 <CAGsJ_4wv144TUSQPNOnHnmNmJrXe4Fn8d14JeAJ5ka-S+dRxRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wv144TUSQPNOnHnmNmJrXe4Fn8d14JeAJ5ka-S+dRxRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 08:35:17PM +1300, Barry Song wrote:
> On Fri, Jan 21, 2022 at 3:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Fri, Jan 21, 2022 at 09:08:06AM +0800, Barry Song wrote:
> > > > A file under /sys/fs/mshare can be opened and read from. A read from
> > > > this file returns two long values - (1) starting address, and (2)
> > > > size of the mshare'd region.
> > > >
> > > > --
> > > > int mshare_unlink(char *name)
> > > >
> > > > A shared address range created by mshare() can be destroyed using
> > > > mshare_unlink() which removes the  shared named object. Once all
> > > > processes have unmapped the shared object, the shared address range
> > > > references are de-allocated and destroyed.
> > >
> > > > mshare_unlink() returns 0 on success or -1 on error.
> > >
> > > I am still struggling with the user scenarios of these new APIs. This patch
> > > supposes multiple processes will have same virtual address for the shared
> > > area? How can this be guaranteed while different processes can map different
> > > stack, heap, libraries, files?
> >
> > The two processes choose to share a chunk of their address space.
> > They can map anything they like in that shared area, and then also
> > anything they like in the areas that aren't shared.  They can choose
> > for that shared area to have the same address in both processes
> > or different locations in each process.
> >
> > If two processes want to put a shared library in that shared address
> > space, that should work.  They probably would need to agree to use
> > the same virtual address for the shared page tables for that to work.
> 
> we are depending on an elf loader and ld to map the library
> dynamically , so hardly
> can we find a chance in users' code to call mshare() to map libraries
> in application
> level?

If somebody wants to modify ld.so to take advantage of mshare(), they
could.  That wasn't our primary motivation here, so if it turns out to
not work for that usecase, well, that's a shame.

> > Think of this like hugetlbfs, only instead of sharing hugetlbfs
> > memory, you can share _anything_ that's mmapable.
> 
> yep, we can call mshare() on any kind of memory. for example, if multiple
> processes use SYSV shmem, posix shmem or mmap the same file. but
> it seems it is more sensible to let kernel do it automatically rather than
> depending on calling mshare() from users? It is difficult for users to
> decide which areas should be applied mshare(). users might want to call
> mshare() for all shared areas to save memory coming from duplicated PTEs?
> unlike SYSV shmem and POSIX shmem which are a feature for inter-processes
> communications,  mshare() looks not like a feature for applications,
> but like a feature
> for the whole system level? why would applications have to call something which
> doesn't directly help them? without mshare(), those applications
> will still work without any problem, right? is there anything in
> mshare() which is
> a must-have for applications? or mshare() is only a suggestion from applications
> like madvise()?

Our use case is that we have some very large files stored on persistent
memory which we want to mmap in thousands of processes.  So the first
one shares a chunk of its address space and mmaps all the files into
that chunk of address space.  Subsequent processes find that a suitable
address space already exists and use it, sharing the page tables and
avoiding the calls to mmap.

Sharing page tables is akin to running multiple threads in a single
address space; except that only part of the address space is the same.
There does need to be a certain amount of trust between the processes
sharing the address space.  You don't want to do it to an unsuspecting
process.
