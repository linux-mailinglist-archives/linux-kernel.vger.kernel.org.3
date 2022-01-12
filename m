Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4848BD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348758AbiALCap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiALCao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:30:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC5C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:30:44 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c10so1511788qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lIP6jXZTWkK4qpyxqcXz8zyKwuUerH2jn69YNiPJK8k=;
        b=gW+B4u4nRrKEaLzuPl2OyYwzbRA42NXsbLP3xKTGOOJBgxt2QTkR7x3XQlVHZBrMjk
         hwrZaSJwHPcVCllDF6fv8uQMjl2ez8atQWji6Jm6rkol3fy9sI+Xe3Hf3XW5GWWrvPj3
         Ki0PfjGP7AUws3e9ma+93kICTVYjeOTwRSY84cmYr/hQXHvG7R+l2R51APFtQfUZR+qB
         XZq00lb6ESPcLGlrjyhohmJ5SmaJrEcT4/pa+xUsVJUoK2AifFnu6AlcPU7JvlyF8Vjr
         ZeLHfggsev1FGj8u88emd72IE9fpctGocRNm97ttbdibhs+7mpkJ9UCO2FjHjc6fYpa9
         r7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=lIP6jXZTWkK4qpyxqcXz8zyKwuUerH2jn69YNiPJK8k=;
        b=IS0icM3d54m2X++g09S2wOnWR6Gepdq2bPk1VTW9zYc1FVKiE+tENTjIv0TmooOVra
         SkEGohdjivE9jVdYUt/ENmY4kDzIqo3w2cXwDVAVCLL0OmsJaiWpualszZhPk5Q9P+K+
         EsBEN10JOgE9wT1fnGGW5KcIJJOzBbgfBU3VAXUgKz3hefLqdDl2D8O5jZUz3/FsV+pv
         mwsAcpmEd2qdz7+AfRQsCtbpNzE9gO3Mnu7yh++tK/GtAgwXa9TMdFgvJNMCTIfT1BFZ
         5wFZM9I68z1QZ+XMieAoLLnmBPJUhD9MzFv/2FILbrQbSCOJwfB7Q7mhTLtZswHNqxX0
         DeGw==
X-Gm-Message-State: AOAM530tJW8w83g0Wb+1LAxKlsksCSuS2Nqi2vpfde9+iFYFN0JO+VFT
        YNGTlhZD8Y0ix8o4HlhP312wvA==
X-Google-Smtp-Source: ABdhPJxEIfWTangXKiPL2HlnhduS4sXYYN6W9hXMNQ+LnksQF5KL2cS6hAS1CuxY9Kr8Lne8KdWSYg==
X-Received: by 2002:ac8:7f8b:: with SMTP id z11mr6225569qtj.396.1641954642725;
        Tue, 11 Jan 2022 18:30:42 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h1sm7653965qta.54.2022.01.11.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:30:42 -0800 (PST)
Date:   Tue, 11 Jan 2022 18:30:31 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peng Liang <liangpeng10@huawei.com>
cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hughd@google.com, xiexiangyou@huawei.com, zhengchuan@huawei.com,
        wanghao232@huawei.com
Subject: Re: [RFC 0/1] memfd: Support mapping to zero page on reading
In-Reply-To: <20211222123400.1659635-1-liangpeng10@huawei.com>
Message-ID: <4b1885b8-eb95-c50-2965-11e7c8efbf36@google.com>
References: <20211222123400.1659635-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021, Peng Liang wrote:

> Hi all,
> 
> Recently we are working on implementing CRIU [1] for QEMU based on
> Steven's work [2].  It will use memfd to allocate guest memory in order
> to restore (inherit) it in the new QEMU process.  However, memfd will
> allocate a new page for reading while anonymous memory will map to zero
> page for reading.  For QEMU, memfd may cause that all memory are
> allocated during the migration because QEMU will read all pages in
> migration.  It may lead to OOM if over-committed memory is enabled,
> which is usually enabled in public cloud.
> 
> In this patch I try to add support mapping to zero pages on reading
> memfd.  On reading, memfd will map to zero page instead of allocating a
> new page.  Then COW it when a write occurs.
> 
> For now it's just a demo for discussion.  There are lots of work to do,
> e.g.:
> 1. don't support THP;
> 2. don't support shared reading and writing, only for inherit.  For
>    example:
>      task1                        | task2
>        1) read from addr          |
>                                   |   2) write to addr
>        3) read from addr again    |
>    then 3) will read 0 instead of the data task2 writed in 2).
> 
> Would something similar be welcome in the Linux?

David has made good suggestions on better avoiding the need for
such a change, for the use case you have in mind.

And I don't care for the particular RFC patch that you posted.

But I have to say that use of ZERO_PAGE for shmem/memfd/tmpfs read-fault
might (potentially) be very welcome.  Not as some MFD_ZEROPAGE special
case, but as how it would always work.  Deleting the shmem_recalc_inode()
cruft, which is there to correct accounting for the unmodified read-only
pages, after page reclaim has got around to freeing them later.

It does require more work than you gave it in 1/1: mainly, as you call
out above, there's a need to note in the mapping's XArray when ZERO_PAGE
has been used at an offset, and do an rmap walk to unmap those ptes when
a writable page is substituted - see __xip_unmap() in Linux 3.19's
mm/filemap_xip.c for such an rmap walk.

Though when this came up before (in the "no-fault mmap" MAP_NOSIGBUS
thread last year - which then got forgotten), Linus was wary of that
unmapping, and it was dropped for a simple MAP_PRIVATE implementation.

And I've never scoped out what is needed to protect the page from
writing in all circumstances: in principle, it ought to be easy by
giving shmem_vm_ops a page_mkwrite; but that's likely to come with
a performance penalty, which may not be justified for this case.

I didn't check what you did for write protection: maybe what you
did was enough, but one has to be very careful about that.

Making this change to ZERO_PAGE has never quite justified the effort
so far: temporarily allocated pages have worked well enough in most
circumstances.

Hugh

> 
> Thanks,
> Peng
> 
> [1] https://criu.org/Checkpoint/Restore
> [2] https://patchwork.kernel.org/project/qemu-devel/cover/1628286241-217457-1-git-send-email-steven.sistare@oracle.com/
> 
> Peng Liang (1):
>   memfd: Support mapping to zero page on reading memfd
> 
>  include/linux/fs.h         |  2 ++
>  include/uapi/linux/memfd.h |  1 +
>  mm/memfd.c                 |  8 ++++++--
>  mm/memory.c                | 37 ++++++++++++++++++++++++++++++++++---
>  mm/shmem.c                 | 10 ++++++++--
>  5 files changed, 51 insertions(+), 7 deletions(-)
> 
> -- 
> 2.33.1
