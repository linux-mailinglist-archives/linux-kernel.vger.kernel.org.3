Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD554670AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbhLCDZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232601AbhLCDZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638501712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vzuVgvyhxiBkVbvcwpuOqvhosMeEWn5XKKq2zzIjTdo=;
        b=UW4+lbloSSG5jTOuTeDwEh81yH4QKZAnIEY+O1KzTp34b+Rr4DmCQvaCZTJzASh/4gsNfr
        eocaEFfjdqNUgC4tJ9/8t9i4T/va1j1Mc4X75w91prPF1ln1jwjrRII+9SmkjVxLNUfwiE
        K1RcEVr8UvvfSH+zgY0VKPXqfUh8zj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-zxuB9bvYMneTPoSvZgwksg-1; Thu, 02 Dec 2021 22:21:51 -0500
X-MC-Unique: zxuB9bvYMneTPoSvZgwksg-1
Received: by mail-wm1-f70.google.com with SMTP id 138-20020a1c0090000000b00338bb803204so830434wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzuVgvyhxiBkVbvcwpuOqvhosMeEWn5XKKq2zzIjTdo=;
        b=cT1S4Y3HUiIqO5DJYC99U/EmzI6s6Tr2GYF832n5ijmfDT9gDY6kZLXgNYAvk6sznm
         XaGWJYM828H7sh29VXAUuT1vjd5vL7cRRODGoVJL3jK13Ki6h03FT+Qajd9fkwfoXtP0
         cNbDY/cuMMNZlXg/XqpZQeHLBR81W+BpuPnRYAZ9Hg/xCQdWGh+IQSeWsKn2jpoBEzD5
         8S1SM7Z6AeD301yQr4M1bnC/+RZ+xfTUtaW7SpRn46+x+IFFCYioTRgMq7TsnSpJeoIF
         dpTCtlQ3T1Ef97ZVdsmmqtBhe8vVT1gZUn3PJj4jyUjmbeykqi0xSDXSwL3Z7iQEBRRW
         e2xQ==
X-Gm-Message-State: AOAM532v5nfO/bmnNLzdayclsXtwBb+1cSpNlBm4jM6hHCeS62HKDz9f
        4929Q1fXI8e9OfyXwlyjOLae/a8iq/rzq1zGJrsINnmhtj+BezzDyeiRnkgA29kOrV+oLn1ykus
        /dTDQ5TIDNfM4HO7voKiFOZsh
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr18592836wrt.487.1638501710195;
        Thu, 02 Dec 2021 19:21:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQIEnz7SvNrCA3Y4Vx5xKKG6OXNdeRVpggKagF7Rpozu5MuTOaGKqE2aTuS2skTbD3beoQGw==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr18592813wrt.487.1638501709975;
        Thu, 02 Dec 2021 19:21:49 -0800 (PST)
Received: from xz-m1.local ([64.64.123.26])
        by smtp.gmail.com with ESMTPSA id o12sm2056007wrc.85.2021.12.02.19.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:21:49 -0800 (PST)
Date:   Fri, 3 Dec 2021 11:21:41 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <YamNRcrLDOPjG9wg@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <5393877.lttFOZEo4r@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5393877.lttFOZEo4r@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:06:46PM +1100, Alistair Popple wrote:
> On Tuesday, 16 November 2021 12:49:50 AM AEDT Peter Xu wrote:
> > This check existed since the 1st git commit of Linux repository, but at that
> > time there's no page migration yet so I think it's okay.
> > 
> > With page migration enabled, it should logically be possible that we zap some
> > shmem pages during migration.  When that happens, IIUC the old code could have
> > the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> > without decreasing the counters for the migrating entries.  I have no unit test
> > to prove it as I don't know an easy way to trigger this condition, though.
> > 
> > Besides, the optimization itself is already confusing IMHO to me in a few points:
> 
> I've spent a bit of time looking at this and think it would be good to get
> cleaned up as I've found it hard to follow in the past. What I haven't been
> able to confirm is if anything relies on skipping swap entries or not. From
> you're description it sounds like skipping swap entries was done as an
> optimisation rather than for some functional reason is that correct?

Thanks again for looking into this patch, Alistair.  I appreciate it a lot.

I should say that it's how I understand this, and I could be wrong, that's the
major reason why I marked this patch as RFC.

As I mentioned this behavior existed in the 1st commit of git history of Linux,
that's the time when there's no special swap entries at all but all the swap
entries are "real" swap entries for anonymous.

That's why I think it should be an optimization because when previously
zap_details (along with zap_details->mapping in the old code) is non-null, and
that's definitely not an anonymous page.  Then skipping swap entry for file
backed memory sounds like a good optimization.

However after that we've got all kinds of swap entries introduced, and as you
spotted at least the migration entry should be able to exist to some file
backed memory type (shmem).

> 
> >   - The wording "skip swap entries" is confusing, because we're not skipping all
> >     swap entries - we handle device private/exclusive pages before that.
> > 
> >   - The skip behavior is enabled as long as zap_details pointer passed over.
> >     It's very hard to figure that out for a new zap caller because it's unclear
> >     why we should skip swap entries when we have zap_details specified.
> > 
> >   - With modern systems, especially performance critical use cases, swap
> >     entries should be rare, so I doubt the usefulness of this optimization
> >     since it should be on a slow path anyway.
> > 
> >   - It is not aligned with what we do with huge pmd swap entries, where in
> >     zap_huge_pmd() we'll do the accounting unconditionally.
> > 
> > This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
> > should do the same mapping check upon migration entries too.
> 
> I agree, and I'm not convinced the current handling is very good - if we
> skip zapping a migration entry then the page mapping might get restored when
> the migration entry is removed.
> 
> In practice I don't think that is a problem as the migration entry target page
> will be locked, and if I'm understanding things correctly callers of
> unmap_mapping_*() need to have the page(s) locked anyway if they want to be
> sure the page is unmapped. But it seems removing the migration entries better
> matches the intent and I can't think of a reason why they should be skipped.

Exactly, that's what I see this too.

I used to think there is a bug for shmem migration (if you still remember I
mentioned it in some of my previous patchset cover letters), but then I found
migration requires page lock then it's probably not a real bug at all.  However
that's never a convincing reason to ignore swap entries.

I wanted to "ignore" this problem by the "adding a flag to skip swap entry"
patch, but as you saw it was very not welcomed anyway, so I have no choice to
try find the fundamental reason for skipping swap entries.  When I figured I
cannot really find any good reason and skipping seems to be even buggy, hence
this patch.  If this is the right way, the zap pte path can be simplified quite
a lot after patch 2 of this series.

-- 
Peter Xu

