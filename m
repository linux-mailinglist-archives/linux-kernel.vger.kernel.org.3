Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1264E47A271
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhLSVx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhLSVxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:53:55 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:53:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w16so2342110edc.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAgesZZJa26Bm2+E00Dh9seobav1+GXMEZLymAQhgzU=;
        b=gsjwrXj2w0PENdQQkCa2rD0AoN5eybLTDPVKaNWI3oveMnHkJeYULHxnPZR8jEPUXz
         2VgREYiEmTj6XFUmXOdED+a6eiho5jBOe8M0znZs6ggvlED8KRyZLucTpAkJHWPI/fhJ
         XA8WmKRbS/hpUl5G6RUMdFiiig2J33ddEVHpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAgesZZJa26Bm2+E00Dh9seobav1+GXMEZLymAQhgzU=;
        b=Y5b5CkM9uTWLMAH2o1E7v/qLC0wPYAZbuFu7sEVfWa/ewxewPFLPLFdIQ1XbQxHdSq
         FGJKBSdi5her8kDOJsSthHS7mbJGVwhoUD16+521icvdJheTOrxjON7co6L6zckDwOj+
         vjzHlLsooQAStt+XD4wOTMJV5/ZhflcZRTSXchHUy1rvDOOh5BVtrW5buXV2aqX58wUS
         ZCjQ1M82Nzp/p+pheYR3nbxaZB3prK69O/LdYeTvbhGJ4Obcr/uqZXrBBb34bWcWbcuo
         Jj/UvzIY2Y8iSAnHLIsWI5t9HvsIjPaSlYBkNR3M41jkesK+z64+xXtKWCKBeJ3dQHKs
         Bafg==
X-Gm-Message-State: AOAM530o3ruro9krN6kaqlcLqt75MHg7lNawV/Itm8ROw8QaT4fTtPW0
        kdWw8QYwifF1+bLuQRB4ihBARfRQHe2T3HrF7Hg=
X-Google-Smtp-Source: ABdhPJzMWSVDZUTRRrCMPsGmvmB7s0oAdX1/zpGX9R2UMGpHHs1cEa1GvNiZRryFqBWCp5xDni23Ww==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr13210534edb.203.1639950833858;
        Sun, 19 Dec 2021 13:53:53 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id hd14sm4623795ejc.195.2021.12.19.13.53.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 13:53:53 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso5452753wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:53:53 -0800 (PST)
X-Received: by 2002:a1c:7312:: with SMTP id d18mr3505400wmb.8.1639950832965;
 Sun, 19 Dec 2021 13:53:52 -0800 (PST)
MIME-Version: 1.0
References: <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <Yb+gId/gXocrlJYD@casper.infradead.org>
 <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com> <Yb+oi8fg1dJe1uBm@casper.infradead.org>
In-Reply-To: <Yb+oi8fg1dJe1uBm@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 13:53:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLLRT_KeM5Se1AxGcf-g5MkCS-JmPy169Rpdeky_YkXg@mail.gmail.com>
Message-ID: <CAHk-=wgLLRT_KeM5Se1AxGcf-g5MkCS-JmPy169Rpdeky_YkXg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 1:48 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Yes, agreed, I was thinking that we could use "not mapped at all"
> as an optimisation to avoid doing rmap walks.  eg __unmap_and_move().

So the thing is, it's a very dodgy optimization for a rather simple
reason: what if somebody pages the page in?

So even "not mapped at all" is questionable.

You have to check that it's also not a swapcache page, and hold the
page lock for that check, at the very least.

And by then, you're really in a very unusual situation - and my gut
feel says not one worth optimizing for (because anon pages are
_usually_ mapped at least once).

But I dunno - it might depend on your load. Maybe you have some very
special load that happens to trigger this case a lot?

              Linus
