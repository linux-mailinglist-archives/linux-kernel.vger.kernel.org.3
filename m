Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3FD46D767
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhLHPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:55:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36262 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhLHPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:55:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A5D5A212C0;
        Wed,  8 Dec 2021 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638978722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=03iT3JOIAlZ/O0MVJX1U57cSlZ33//YmQ2NpDHKCjg0=;
        b=cxpbasfR/L7CTP08RCsxC6XO1un52mKs02QCLJ7IXcbyaB6ugHis+2QkaYvVF/wnNXT3WW
        jEKQCH+n0hKSQPkMPGVgURi0TXpnlACK3DL4l3aZYCbMABJSBKT/2tmWXD0AIhRUSuHjWy
        RoFZK8WpFXunmf1DFWzaYHD3sjWegvU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A68AA3B92;
        Wed,  8 Dec 2021 15:52:02 +0000 (UTC)
Date:   Wed, 8 Dec 2021 16:51:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <YbDUnkmQP3nxd5bv@dhcp22.suse.cz>
References: <20211207215031.2251719-1-surenb@google.com>
 <Ya/bFLcnqyvlVzuO@casper.infradead.org>
 <CAJuCfpFwR+uO0GJvCLGQrCaFzB42wNg-FpeOnx2VnxipONkpmg@mail.gmail.com>
 <CAJuCfpG-CU4AywZGDfMRiEtxMWkL4KMJ-xD1eM15C_z5eYdCJA@mail.gmail.com>
 <YbDIxA92ln+RTbUK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbDIxA92ln+RTbUK@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-12-21 15:01:24, Matthew Wilcox wrote:
> On Tue, Dec 07, 2021 at 03:08:19PM -0800, Suren Baghdasaryan wrote:
> > > >         /**
> > > >          * @close: Called when the VMA is being removed from the MM.
> > > >          * Context: Caller holds mmap_lock.
> > 
> > BTW, is the caller always required to hold mmap_lock for write or it
> > *might* hold it?
> 
> __do_munmap() might hold it for read, thanks to:
> 
>         if (downgrade)
>                 mmap_write_downgrade(mm);
> 
> Should probably say:
> 
> 	* Context: User context.  May sleep.  Caller holds mmap_lock.
> 
> I don't think we should burden the implementor of the vm_ops with the
> knowledge that the VM chooses to not hold the mmap_lock under certain
> circumstances when it doesn't matter whether it's holding the mmap_lock
> or not.

If we document it like that some code might depend on that lock to be
held. I think we only want to document that the holder itself is not
allowed to take mmap sem or a depending lock.

-- 
Michal Hocko
SUSE Labs
