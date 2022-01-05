Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1F485CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbiAEX4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:56:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37284 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245586AbiAEX4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:56:17 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 917F06181D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 23:56:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3F6860E8D;
        Wed,  5 Jan 2022 23:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641426976;
        bh=FjLhYNPIXm5K8QpAnWqx2tru94VewUjMx/27feOHfMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ci17J0QjY8Jt5WTe3ENSwbU33iK8tOQckXIsqDmb027A0xU83rz73D3EIU719TpXa
         tPvwvhH761GP6ufANWz3bLdXQl110YlJVBbjnnuV5oJAgfzJ2drE+lxxhiWBVtUfuO
         tk0h4xq3Y3qFQLo7OtyWmOUso83OC1MRlVjE8BQg=
Date:   Wed, 5 Jan 2022 15:56:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] userfaultfd/selftests: clean up hugetlb allocation code
Message-Id: <20220105155613.45d7dcb81e19bd42deefab79@linux-foundation.org>
In-Reply-To: <CAJHvVci5sSC-1TEiCBKe8uKQ=0uwCsoBJT_fsG1Rfq6ffy6Obg@mail.gmail.com>
References: <20220104021729.111006-1-mike.kravetz@oracle.com>
        <CAJHvVci5sSC-1TEiCBKe8uKQ=0uwCsoBJT_fsG1Rfq6ffy6Obg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 14:35:34 -0800 Axel Rasmussen <axelrasmussen@google.com> wrote:

> On Mon, Jan 3, 2022 at 6:17 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > The message for commit f5c73297181c ("userfaultfd/selftests: fix hugetlb
> > area allocations") says there is no need to create a hugetlb file in the
> > non-shared testing case.  However, the commit did not actually change
> > the code to prevent creation of the file.
> >
> > While it is technically true that there is no need to create and use a
> > hugetlb file in the case of non-shared-testing, it is useful.  This is
> > because 'hole punching' of a hugetlb file has the potentially incorrect
> > side effect of also removing pages from private mappings.  The
> > userfaultfd test relies on this side effect for removing pages from the
> > destination buffer during rounds of stress testing.
> >
> > Remove the incomplete code that was added to deal with no hugetlb file.
> > Just keep the code that prevents reserves from being created for the
> > destination area.
> >
> >         *alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> > -                          map_shared ? MAP_SHARED :
> > -                          MAP_PRIVATE | MAP_HUGETLB |
> > +                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> > +                          MAP_HUGETLB |
> >                            (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> > -                          huge_fd,
> > -                          *alloc_area == area_src ? 0 : nr_pages * page_size);
> > +                          huge_fd, *alloc_area == area_src ? 0 :
> > +                          nr_pages * page_size);
> 
> Sorry to nitpick, but I think it was slightly more readable when the
> ternary was all on one line.

When you have that many arguments I think it's clearer to put one per
line, viz.

	*alloc_area = mmap(NULL,
			   nr_pages * page_size,
			   PROT_READ | PROT_WRITE,
			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
			   	MAP_HUGETLB |
			   	(*alloc_area == area_src ? 0 : MAP_NORESERVE),
			   huge_fd,
			   *alloc_area == area_src ? 0 : nr_pages * page_size);


But whatever...
