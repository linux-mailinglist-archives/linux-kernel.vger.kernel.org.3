Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F005B46FD94
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhLJJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:23:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58096 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbhLJJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:23:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D8811F3A1;
        Fri, 10 Dec 2021 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639128008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDjp6nHahr/gQejvxC0DydQpWXBPwmoZeSh1rjN3KPY=;
        b=Xa3gad8UdHYNjT6v8zs4Y+hmpmuy5AAQRylzfTUZ97yLKl3e8/6Uc3H0b/Pj9aySJZr9Zl
        QJYAt76fByzuNLu0GJ/OnqSqip4UxCWLM+hVqnAN7VIleVPWiXzuMtXhG543XgtlZ1X2N0
        9vuKHxfPvnC7D7sao8ATRYxK8vQSz6Y=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7EA75A3B9A;
        Fri, 10 Dec 2021 09:20:07 +0000 (UTC)
Date:   Fri, 10 Dec 2021 10:20:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 1/3] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <YbMbxh0RaKkykHHT@dhcp22.suse.cz>
References: <20211208212211.2860249-1-surenb@google.com>
 <YbHEgLi1g1XtsOgh@dhcp22.suse.cz>
 <CAJuCfpE4CWMAAFGPjvEz=a6_2kpMSY8hhUMWJ5GtfDv7uD8jng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE4CWMAAFGPjvEz=a6_2kpMSY8hhUMWJ5GtfDv7uD8jng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-12-21 11:03:11, Suren Baghdasaryan wrote:
> On Thu, Dec 9, 2021 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 08-12-21 13:22:09, Suren Baghdasaryan wrote:
> > > oom-reaper and process_mrelease system call should protect against
> > > races with exit_mmap which can destroy page tables while they
> > > walk the VMA tree. oom-reaper protects from that race by setting
> > > MMF_OOM_VICTIM and by relying on exit_mmap to set MMF_OOM_SKIP
> > > before taking and releasing mmap_write_lock. process_mrelease has
> > > to elevate mm->mm_users to prevent such race. Both oom-reaper and
> > > process_mrelease hold mmap_read_lock when walking the VMA tree.
> > > The locking rules and mechanisms could be simpler if exit_mmap takes
> > > mmap_write_lock while executing destructive operations such as
> > > free_pgtables.
> > > Change exit_mmap to hold the mmap_write_lock when calling
> > > free_pgtables and remove_vma. Operations like unmap_vmas and
> > > unlock_range are not destructive and could run under mmap_read_lock
> > > but for simplicity we take one mmap_write_lock during almost the entire
> > > operation.
> >
> > unlock_range is not safe to be called under read lock. See 27ae357fa82b
> > ("mm, oom: fix concurrent munlock and oom reaper unmap, v3").
> 
> Ok, I'll remove the sentence above.
> Is my understanding correct that it is unsafe only because oom-reaper
> can't deal with VM_LOCKED, otherwise it would be fine?

The commit message (27ae357fa82b) goes into details that I have forgot already. 
-- 
Michal Hocko
SUSE Labs
