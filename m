Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8D46D7B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhLHQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLHQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:09:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C38C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXGrGkg5NtXQdY+5+PcWCQctwATeg/9zpNpzAdgrs5s=; b=sNEb/78ju3Vr/GEz17BRIjSBCp
        fMKLn1vqWX9wIcveNYbpvy4BSPQbE3OzfqZh0+pdaY+mBba8NCAPY7A888RUaGktOAvnQhIjjLphV
        cm1rWfpfXm8tVtmMs7rvngNHjCWreru0F/AYUV2GEnyEMp9VxAKcd7XIAopmzw5WwB5v1hK8piQU0
        fTrIwxiLeTj7xg5RjRSRHAjZ7Mr9lCqIspxdNstc+D+NyEPKyMuIpVfcKXClu7Z0zLHZYtNhIt4S+
        9nZclyuXgmqiJUsNa58CA3TF6QPADq5TYrYNDDBXz/ww6vhBLfNz6JqIzjRv+pwWfHcnKl1cCRbCb
        umuXbO2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muzRR-008YzV-Ti; Wed, 08 Dec 2021 16:05:13 +0000
Date:   Wed, 8 Dec 2021 16:05:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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
Message-ID: <YbDXuegc6BtRzs/5@casper.infradead.org>
References: <20211207215031.2251719-1-surenb@google.com>
 <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
 <YbDIxA92ln+RTbUK@casper.infradead.org>
 <YbDUnkmQP3nxd5bv@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbDUnkmQP3nxd5bv@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:51:58PM +0100, Michal Hocko wrote:
> On Wed 08-12-21 15:01:24, Matthew Wilcox wrote:
> > On Tue, Dec 07, 2021 at 03:08:19PM -0800, Suren Baghdasaryan wrote:
> > > > >         /**
> > > > >          * @close: Called when the VMA is being removed from the MM.
> > > > >          * Context: Caller holds mmap_lock.
> > > 
> > > BTW, is the caller always required to hold mmap_lock for write or it
> > > *might* hold it?
> > 
> > __do_munmap() might hold it for read, thanks to:
> > 
> >         if (downgrade)
> >                 mmap_write_downgrade(mm);
> > 
> > Should probably say:
> > 
> > 	* Context: User context.  May sleep.  Caller holds mmap_lock.
> > 
> > I don't think we should burden the implementor of the vm_ops with the
> > knowledge that the VM chooses to not hold the mmap_lock under certain
> > circumstances when it doesn't matter whether it's holding the mmap_lock
> > or not.
> 
> If we document it like that some code might depend on that lock to be
> held. I think we only want to document that the holder itself is not
> allowed to take mmap sem or a depending lock.

The only place where we're not currently holding the mmap_lock is at
task exit, where the mmap_lock is effectively held because nobody else
can modify the task's mm.  Besides, Suren is changing that in this patch
series anyway, so it will be always true.
