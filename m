Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034124B7814
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiBOUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:46:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiBOUqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:46:10 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C13D76EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:45:59 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j12so37671941ybh.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKFnfXICHV30cawWi7Dlo/LToBg+cBNwCh6pYOdTGf0=;
        b=Q4kKNhttlKkyigQfDHvw0u0oIrH6bETkjHPnYObQe8cfPACv/HYb1qa87/AfhartnC
         DRb5T45HVIZv9zWqyym+GKFwvpCSN2ZIlRo+8cOHfPBeDC+jh6HRyW7nC6/I3fljOHgI
         wkS0SZZtZCIZENF9Cuu9JlltisxzuGBDqtFGlDPD3C/QTiZWLOQHhC2I+2/isA0acInx
         N2IRKM8rp/dYdaGwO/bwVIwmvpjC+0ydnqX+XeHN7bmm+GGk3vd7pWxjSuw/hJC0N6aW
         6exJkxIKZik3xAjiGQ7lnntLMNLLo3lKVjxNqhAGyZkIVJ3SP1ZDb0C+pqQNXufBehzE
         5pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKFnfXICHV30cawWi7Dlo/LToBg+cBNwCh6pYOdTGf0=;
        b=L0z+acAjhPKplaqf3Fh2KqykyjZRbUOOfuRvbhZn/1nzgOSZtxPdhhMaYXXf3fvjtD
         P10SmXyGvDGIoixsJGYvzUs/CC4va/i8YcsP3MWfXCfplz8BSLosslCQExFYg56A13y2
         UrIWhZnWQpL3v69vjhHKTj8ZpFMHZfzK4NkqFkDEUY0pDfvsWYl99zqxDuqwYqn6ISLx
         XM3m7bkmCFaPrWvwEXqcpFA1BqYNGlP7N6567lahmz8T1w7Wq7RniE9E1L5MRT7XKbvO
         DpkCxgqVgsffKKN90QoKAUscKmg0p1yLE5cGyPzZweYpHqLi9fqVxW/3CB2CbyA8uZzu
         ms5w==
X-Gm-Message-State: AOAM530U9faKfCj2FZsUG7h6d+3iGm4dmjM5GtbvTv3wro8XSc1NYphz
        sW/CUT5x3P5W9P0McA6gDFE3IAS1C2DTf5yg0ywoWg==
X-Google-Smtp-Source: ABdhPJzUBEInBloOfWBh9K2xofyIht7SdZ1zeb9FbyAO1UXPE90Xf+F5r1PKJc90aQ6IQZvY+QkZd029SNUAKALrCnQ=
X-Received: by 2002:a81:a4d3:: with SMTP id b202mr677950ywh.380.1644957958297;
 Tue, 15 Feb 2022 12:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20220215201922.1908156-1-surenb@google.com> <20220215123741.8e757b337e1f2d32a1766d42@linux-foundation.org>
In-Reply-To: <20220215123741.8e757b337e1f2d32a1766d42@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Feb 2022 12:45:47 -0800
Message-ID: <CAJuCfpHwHRodo00gR=5=p+gvp60T+s04=5XBnCc9xsTOZCSE1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:37 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
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
> >               vma = remove_vma(vma);
> >               cond_resched();
> >       }
> > +     mm->mmap = NULL;
> >       mmap_write_unlock(mm);
> >       vm_unacct_memory(nr_accounted);
> >  }
>
> https://lore.kernel.org/all/00000000000072ef2c05d7f81950@google.com/
>
> It would be nice to have a Fixes: for this.

Oh, right. Should be:

Fixes: 64591e8605d6 ("mm: protect free_pgtables with mmap_lock write
lock in exit_mmap")

>
> Is it specific to process_mrelease(), or should we backport further?

The broken change is recent and was introduced in v5.17-rc1.
