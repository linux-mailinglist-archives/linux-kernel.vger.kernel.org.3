Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5527D46D657
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhLHPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhLHPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:05:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E7DC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VH4twn5IAvnExuTGhr4b1JpOpGzuAOGbSYErzKxVLI4=; b=YX2XGllthBaVbk6S+fBCAUjq62
        dC+4k2DcLhAEA/4LcTL7GkITJ4Npgjgm4I0/04GrcedcC9WlKZBC1g/z9egXtl97/RipbzVrraste
        tjEFxv9579TWkW3xDJCN+rv7FzvWYlDDMu3zr0iS7oI5kWMhZcgHsbfqVwT30mt7/RNNETh1A1ykX
        ecF979xuR95BH7pc57IIQS9smIJO5WfgI7ooHPYzBkPmNRrrAX9JDnSVemnplEaCIw3e0dxCN6ur0
        IqGLPnA/mUL9kZdE3mkTMgCgEioneGdr+fqMOCilj8F7qG760wDxXsU30Xbf2HnXazJL8SQzEtDOI
        FUKdf9tg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muyRg-008VyL-R2; Wed, 08 Dec 2021 15:01:24 +0000
Date:   Wed, 8 Dec 2021 15:01:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <YbDIxA92ln+RTbUK@casper.infradead.org>
References: <20211207215031.2251719-1-surenb@google.com>
 <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:08:19PM -0800, Suren Baghdasaryan wrote:
> > >         /**
> > >          * @close: Called when the VMA is being removed from the MM.
> > >          * Context: Caller holds mmap_lock.
> 
> BTW, is the caller always required to hold mmap_lock for write or it
> *might* hold it?

__do_munmap() might hold it for read, thanks to:

        if (downgrade)
                mmap_write_downgrade(mm);

Should probably say:

	* Context: User context.  May sleep.  Caller holds mmap_lock.

I don't think we should burden the implementor of the vm_ops with the
knowledge that the VM chooses to not hold the mmap_lock under certain
circumstances when it doesn't matter whether it's holding the mmap_lock
or not.
