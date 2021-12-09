Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7646ED72
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhLIQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:51:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhLIQva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:51:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C708210E9;
        Thu,  9 Dec 2021 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639068476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZPRynoHMDR0DxFfqoxMvZfGGGCg7KDYFSyzRCoZgqGU=;
        b=uBWiPPCULOmL3VAVHx+eWri6bBtn047WWvXJ0YZoFblXVo+ZkkFdrMRYmT/G88q0ozF7NK
        LI9Gvgk2RmaGa4Cx+QX3Ojr8ZoFuowGsYNss4ji49sFwW13lpr+Z0Ig3/GSqx6Ar30Rn/U
        zhlzbbjvjX29cHXajyBDr2QNV3eFhRY=
Received: from suse.cz (mhocko.udp.ovpn1.nue.suse.de [10.163.30.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9FCBCA3B92;
        Thu,  9 Dec 2021 16:47:50 +0000 (UTC)
Date:   Thu, 9 Dec 2021 17:47:53 +0100
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
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
Message-ID: <YbIzOR13uPOI5EMB@dhcp22.suse.cz>
References: <20211208212211.2860249-1-surenb@google.com>
 <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-12-21 08:24:04, Suren Baghdasaryan wrote:
> On Thu, Dec 9, 2021 at 1:12 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > Do we want this on top?
> 
> As we discussed in this thread
> https://lore.kernel.org/all/YY4snVzZZZYhbigV@dhcp22.suse.cz,
> __oom_reap_task_mm in exit_mmap allows oom-reaper/process_mrelease to
> unmap pages in parallel with exit_mmap without blocking each other.
> Removal of __oom_reap_task_mm from exit_mmap prevents this parallelism
> and has a negative impact on performance. So the conclusion of that
> thread I thought was to keep that part. My understanding is that we
> also wanted to remove MMF_OOM_SKIP as a follow-up patch but
> __oom_reap_task_mm would stay.

OK, then we were talking past each other, I am afraid. I really wanted
to get rid of this oom specific stuff from exit_mmap. It was there out
of necessity. With a proper locking we can finally get rid of the crud.
As I've said previously oom reaping has never been a hot path.

If we really want to optimize this path then I would much rather see a
generic solution which would allow to move the write lock down after
unmap_vmas. That would require oom reaper to be able to handle mlocked
memory.
-- 
Michal Hocko
SUSE Labs
