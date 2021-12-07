Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946BE46B859
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhLGKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:07:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41282 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhLGKHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:07:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0374E1FD2F;
        Tue,  7 Dec 2021 10:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638871422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwQ4bZdkWv3+Uy3+p3BVJaw61oSGu/aQTT0I5wfRf18=;
        b=Dqw67D3mF+cEHV+7m1y1Hp2YaRJcrsJe0ESB5PZc1jI4vdiqDOTKgjlJRvkYFhjjU3rvXs
        g9940Xjo5CsQcZAiRZZ3E0oEmjCenXDUy2WQeG1iW6MT0xpc3vRKnZCO14WN5y9VwDGDn3
        paAFNrMNFHerOeu3Z/GYMdxsk1ZXdl0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 018EEA3B91;
        Tue,  7 Dec 2021 10:03:40 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:03:40 +0100
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
Subject: Re: [PATCH v2 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <Ya8xfBAF6erOloMx@dhcp22.suse.cz>
References: <20211124235906.14437-1-surenb@google.com>
 <YaS4KxCSLK+02xaF@dhcp22.suse.cz>
 <CAJuCfpEZi=4V7=nD-4gWi=QyQ8-=ezwmx80twndtoPpZSCzEGQ@mail.gmail.com>
 <Ya5b7NEKGr57rKh3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya5b7NEKGr57rKh3@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-12-21 18:52:28, Matthew Wilcox wrote:
> On Mon, Dec 06, 2021 at 10:35:03AM -0800, Suren Baghdasaryan wrote:
> > > Other than that looks OK to me. Maybe we want to add an explicit note
> > > that vm_ops::close cannot take mmap_sem in any form. The changelog
> > > should also mention that you have considered remove_vma and its previous
> > > no MM locking assumption. You can argue that fput is async and close
> > > callback shouldn't really need mmap_sem.
> > 
> > Should I post another version of this patch with the patch description
> > clarifying these points and additional comments as you suggested?
> 
> fyi, vm_ops->close() is already called with the mmap_sem held for write
> in __split_vma().  If that needs to be documented, it's a separate patch
> because it's absolutely not a consequence of this patch.

Agreed! We definitely want to document that.

-- 
Michal Hocko
SUSE Labs
