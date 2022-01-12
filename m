Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3048BDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350434AbiALDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350350AbiALDd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:33:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E1BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 19:33:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so4418244edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 19:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYq312tqKbOg7PFLNwXB0CwSYMigHjxwSWqrvkkYJTQ=;
        b=Wff6miex+nOrTZ0fO19HXqe39gIw+2MbRg0oGLxv6kz3aCdrvz+Fr724v4uhRiM5KM
         80Pd4P5gQ6wqmtDCOq/0Ii9g08vNeCSMhiEEGJPKctjvj6QE6KzMW5iPUJVfJYM9IrTB
         POVmWhzW/h9Efq3GN9FFK4teCFl3JTyVbJpmus1BsZcpex971DgBPRm6jxLZX4lR+vPx
         EifF87oOkeGRIagEuSZhy19VH0OuLZbzEMdU3edvKeplR5P4mfN6IVxfDxpUlTwBKrfa
         k2UV8nk5k/bD1hwSxycxSCDcSp4x/VmcJ1iNOi9QRDoGMwmmv3pEf80hVh8vFN/IDVX1
         IKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYq312tqKbOg7PFLNwXB0CwSYMigHjxwSWqrvkkYJTQ=;
        b=HKJBwYF0puo3NAxXMkFdz/94mD5zu2frjdOrZ1RxB/Z1DVJYwXkxz3eRT4m4L7pPJ9
         AzoBjWbapm2CWdDV4+iAy7iOjDFbeW32iEGyJddUG+dRHMpxLeiReIP/m6FUgZ94/Yjh
         s5ckbN+MLsXXM5eaeJGIo3DMRIm8/lzhsHmrCrvQs5R4kbmqFXD94b00HZbm9wXKI0YE
         cw+imYrX98iZLaVJD6Vf1KfF9As6QnlkzZ7nH0+et1Ig507IirK3XTXq6lZqNzGhIYgQ
         5pzmmpNrh1LfFYtw/si40PgDYlzvw57gLQh/s0CgGt0gVCN9N/ovGI1t16mJfYYyuPzm
         mLuw==
X-Gm-Message-State: AOAM530KGucsktk2TkpnbyuTVcERhogyNZ/coxKRo9xzOR1GUDVUiWEL
        VbZPZPwHLsgKHHyBT8JQGxpRiA7RLCKnHctgaxA=
X-Google-Smtp-Source: ABdhPJzQv5Jr3gKu995OPL6/o8CeAIlzcDtjgl4pDJqC60kJl/jM6lj9pkviuwvMh7Wdz51+zQ/LQpIJd6glaP8mAnU=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr7039854edw.385.1641958434997;
 Tue, 11 Jan 2022 19:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20211222123400.1659635-1-liangpeng10@huawei.com> <4b1885b8-eb95-c50-2965-11e7c8efbf36@google.com>
In-Reply-To: <4b1885b8-eb95-c50-2965-11e7c8efbf36@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 11 Jan 2022 19:33:42 -0800
Message-ID: <CAHbLzkrt_3vA7h=jYf-RjPv3Myh-Duz62WqsjHmR30csM8MQzQ@mail.gmail.com>
Subject: Re: [RFC 0/1] memfd: Support mapping to zero page on reading
To:     Hugh Dickins <hughd@google.com>
Cc:     Peng Liang <liangpeng10@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xiexiangyou@huawei.com, zhengchuan@huawei.com,
        wanghao232@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 6:30 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 22 Dec 2021, Peng Liang wrote:
>
> > Hi all,
> >
> > Recently we are working on implementing CRIU [1] for QEMU based on
> > Steven's work [2].  It will use memfd to allocate guest memory in order
> > to restore (inherit) it in the new QEMU process.  However, memfd will
> > allocate a new page for reading while anonymous memory will map to zero
> > page for reading.  For QEMU, memfd may cause that all memory are
> > allocated during the migration because QEMU will read all pages in
> > migration.  It may lead to OOM if over-committed memory is enabled,
> > which is usually enabled in public cloud.
> >
> > In this patch I try to add support mapping to zero pages on reading
> > memfd.  On reading, memfd will map to zero page instead of allocating a
> > new page.  Then COW it when a write occurs.
> >
> > For now it's just a demo for discussion.  There are lots of work to do,
> > e.g.:
> > 1. don't support THP;
> > 2. don't support shared reading and writing, only for inherit.  For
> >    example:
> >      task1                        | task2
> >        1) read from addr          |
> >                                   |   2) write to addr
> >        3) read from addr again    |
> >    then 3) will read 0 instead of the data task2 writed in 2).
> >
> > Would something similar be welcome in the Linux?
>
> David has made good suggestions on better avoiding the need for
> such a change, for the use case you have in mind.
>
> And I don't care for the particular RFC patch that you posted.
>
> But I have to say that use of ZERO_PAGE for shmem/memfd/tmpfs read-fault
> might (potentially) be very welcome.  Not as some MFD_ZEROPAGE special
> case, but as how it would always work.  Deleting the shmem_recalc_inode()
> cruft, which is there to correct accounting for the unmodified read-only
> pages, after page reclaim has got around to freeing them later.

I'm wondering if we could use ZERO_PAGE for shmem_getpage() too so
that we have simpler return value? Currently shmem_getpage() returns:
#1. errno and NULL *pagep
#2. 0 and valid *pagep
#3. 0 and NULL *pagep if SGP_READ

Using ZERO_PAGE should be able to consolidate #2 and #3 so that we
know there must be valid *pagep if 0 is returned. This should make
read-fault use ZERO_PAGE automatically.

>
> It does require more work than you gave it in 1/1: mainly, as you call
> out above, there's a need to note in the mapping's XArray when ZERO_PAGE
> has been used at an offset, and do an rmap walk to unmap those ptes when
> a writable page is substituted - see __xip_unmap() in Linux 3.19's
> mm/filemap_xip.c for such an rmap walk.
>
> Though when this came up before (in the "no-fault mmap" MAP_NOSIGBUS
> thread last year - which then got forgotten), Linus was wary of that
> unmapping, and it was dropped for a simple MAP_PRIVATE implementation.
>
> And I've never scoped out what is needed to protect the page from
> writing in all circumstances: in principle, it ought to be easy by
> giving shmem_vm_ops a page_mkwrite; but that's likely to come with
> a performance penalty, which may not be justified for this case.
>
> I didn't check what you did for write protection: maybe what you
> did was enough, but one has to be very careful about that.
>
> Making this change to ZERO_PAGE has never quite justified the effort
> so far: temporarily allocated pages have worked well enough in most
> circumstances.
>
> Hugh
>
> >
> > Thanks,
> > Peng
> >
> > [1] https://criu.org/Checkpoint/Restore
> > [2] https://patchwork.kernel.org/project/qemu-devel/cover/1628286241-217457-1-git-send-email-steven.sistare@oracle.com/
> >
> > Peng Liang (1):
> >   memfd: Support mapping to zero page on reading memfd
> >
> >  include/linux/fs.h         |  2 ++
> >  include/uapi/linux/memfd.h |  1 +
> >  mm/memfd.c                 |  8 ++++++--
> >  mm/memory.c                | 37 ++++++++++++++++++++++++++++++++++---
> >  mm/shmem.c                 | 10 ++++++++--
> >  5 files changed, 51 insertions(+), 7 deletions(-)
> >
> > --
> > 2.33.1
>
