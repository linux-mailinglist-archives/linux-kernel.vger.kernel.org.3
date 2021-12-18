Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1451479884
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 05:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhLREDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 23:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhLREDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 23:03:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 20:03:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z7so15067877edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 20:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDz9wbDMHn9MeIeMeVs1g93TcSMjFNt5KhDPV7GWmW8=;
        b=JZWsZ9zzivWVUnONWc6WXUrfS9G5bbi5gt+peI0yOlau9BFB8rndAwtdKJ2qX2ZnUf
         OQ+2eD5CGCh2TBG+PQVESOHPfQzWG7avZX5F/+5/9t4X10C604kFp0d+2CFTwOowQY+g
         h1Hrnva1kIJXMOMq6KKMozGFUEUYAP+iMVhiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDz9wbDMHn9MeIeMeVs1g93TcSMjFNt5KhDPV7GWmW8=;
        b=cTGczQkST+vmN4oMkMGnyO5dRM/nOpWADbYcb7SA3X8mIWjrLsjEMZZHWTsx1csIpn
         t+OhqbfYhBZ6SJ0C6hvRa6B/upNux3gMp/szqA3/Ihly9+CvdUIOtIbU9h4Qt5HQB3Cw
         Gj7l7twatz2BQ8zckQA84/3WGSvpWEM/xaaq5H12PQ3femrR6SM7vBxIwDKgESdWl+GB
         Sb4iCQs7wAj3xQV5MuPX+JYriBdjvaOTWwv6K370GneYukmnDh1lAHIOIi33qS5/+3js
         Nxp7YewxYG/69rKX/LMWOmhfFhHh1O6MLpwEzVnXGEVaKahTzjkmdLKUQsgDhzMwy5bv
         8yKA==
X-Gm-Message-State: AOAM533Xq+04Bapgb6JKTJe9cfaZt82BoIJwLKxuoukoWV7v/EOko4jo
        Tyg7dfj6pDyDnIXhWiEkSYv0BIhRYgCrf0rA1Ws=
X-Google-Smtp-Source: ABdhPJwKTVDCqnlxC8NvhDVmljlJmi0dEHC1Xk0fFOZh9+Ai2XpmVRoPSyZw4K5qek9Ncp5ax0RqIQ==
X-Received: by 2002:a17:906:9acd:: with SMTP id ah13mr4869180ejc.666.1639800193510;
        Fri, 17 Dec 2021 20:03:13 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id m16sm4236282edd.61.2021.12.17.20.03.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 20:03:11 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so5334219wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 20:03:11 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr12036558wmq.8.1639800191035;
 Fri, 17 Dec 2021 20:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
 <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com> <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
 <0de1a3cb-8286-15bd-aec1-2b284bf8918a@redhat.com> <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
In-Reply-To: <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 20:02:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
Message-ID: <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Fri, Dec 17, 2021 at 3:53 PM Nadav Amit <namit@vmware.com> wrote:
>
> I understand the discussion mainly revolves correctness, which is
> obviously the most important property, but I would like to mention
> that having transient get_page() calls causing unnecessary COWs can
> cause hard-to-analyze and hard-to-avoid performance degradation.

Note that the COW itself is pretty cheap. Yes, there's the page
allocation and copy, but it's mostly a local thing.

So that falls under the "good to avoid" heading, but in the end it's
not an immense deal.

In contrast, the page lock has been an actual big user-visible latency
issue, to the point of correctness.

A couple of years ago, we literally had NMI watchdog timeouts due to
the page wait-queues growing basically boundlessly. This was some
customer internal benchmark code that I never saw, so it wasn't
*quite* clear exactly what was going on, but we ended up having to
split up the page wait list traversal using bookmark entries, because
it was such a huge latency issue.

That was mostly NUMA balancing faults, I think, but the point I'm
making is that avoiding the page lock can be a *much* bigger deal than
avoiding some local allocation and copying of a page of data. There
are real loads where the page-lock gets insanely bad, and I think it's
because we use it much too much.

See commit 2554db916586 ("sched/wait: Break up long wake list walk")
for some of that saga.

So I really think that having to serialize with the page lock in order
to do some "exact page use counting" is a false economy. Yes, maybe
you'd be able to avoid a COW or two, but at what locking cost?

                Linus
