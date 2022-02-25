Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84B4C4210
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiBYKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbiBYKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:18:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFB6B2E34
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:17:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 044C71F383;
        Fri, 25 Feb 2022 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645784256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sLcVCRb+1Z6S+qUcBP1X6RE7IX0nXiVeuQij3kNY+MY=;
        b=pb0YBCQt38vYZ5wB508BwadF5K806XNyG1wLNJl/9j28n0g8mDYIYpbJjzh3RHfYbtQddp
        J7nPF7Ymjahnxco/EPRkPTLTf9Vwv+5SfmCig7DenJGwwn9hljHLT7a6+tMp62G5kcvfKu
        h2DiM2/RH/4BVjJ42pLk3pZdOSaprBo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A5FF1A3B84;
        Fri, 25 Feb 2022 10:17:34 +0000 (UTC)
Date:   Fri, 25 Feb 2022 11:17:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, shy828301@gmail.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Message-ID: <YhisviDOip+axLDe@dhcp22.suse.cz>
References: <20220215201922.1908156-1-surenb@google.com>
 <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-02-22 20:18:59, Andrew Morton wrote:
> On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> > otherwise it points to a vma that was freed and when reused leads to
> > a use-after-free bug.
> > 
> > ...
> >
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> >  		vma = remove_vma(vma);
> >  		cond_resched();
> >  	}
> > +	mm->mmap = NULL;
> >  	mmap_write_unlock(mm);
> >  	vm_unacct_memory(nr_accounted);
> >  }
> 
> After the Maple tree patches, mm_struct.mmap doesn't exist.  So I'll
> revert this fix as part of merging the maple-tree parts of linux-next.
> I'll be sending this fix to Linus this week.

But this is a regression introduced in this release cycle so the patch
should be merged before Maple tree patches, no?
-- 
Michal Hocko
SUSE Labs
