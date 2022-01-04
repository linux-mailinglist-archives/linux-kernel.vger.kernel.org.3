Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D1E484AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiADWZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiADWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:25:02 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D69CC061785
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:25:02 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j83so93613161ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1QBXQhRunHeAehYIycTouhYj3cWM9KC3mhyXs9mkLo=;
        b=o6v1LBQqqRQ1zjkCWy52ZvZ0ojpbkR7cq552qjmx+/nvTq0KeEc9jgIvIn5OXCyCw4
         Wh18TNUQ1uRdDTNTa7GgXUsrFmDVynzlWfVfJaxwdtofFJffId8VrkGYZDle6e7UzHwr
         9X+6zEXV396nLI1t3jmCR/DzYW25hLBvbl+c+hXlGDvwphF14U0K8bzyIm4wsWHJKGid
         20qhKJAOv1YyhM1yl8kqN96nSoBLcOzC3hrI5hfA76i+tvYc2hkgSm2cY2C9VkMS1O4T
         OsOcE1YxbzzzMN3QpLkmsmSB+tln/Ux7x5l5fK/LBMDfVpxUZk9Q+9LKT051MpTA0J91
         dhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1QBXQhRunHeAehYIycTouhYj3cWM9KC3mhyXs9mkLo=;
        b=6hknOCvK322LXDR9ha0VZWb5X/rfaUOSu1M2zLhDBolMdpfcZzLWg3pHwIvuo42f1k
         KcuuRs6BxS7a5cCtEGvJCiKWS34I/fc3CnWWl+w6JyAbkO4f1FUERJBVIs2jZHPw5/j2
         9UeuoAP9QNfFUO3VryROhGGazflc0NcgglT7KG637MyEu5BkiXBISZj/1e51BAWxvlP+
         F1ZBJ3cCGFcyicrHrqam0zYQQ87mvp6Vnlf6EiAU5SRTZ8nWk3o0i1AuOxUHUbQyjXTG
         +dOPZSud8mKtyvd4pYqZKPlGL/0b04DpfsvHyyuosYtcJ849yxOkwSMtVpQpea9aLX3a
         RznQ==
X-Gm-Message-State: AOAM533BKsgE4J5ezZbFkHTqwfRiPuf5UkTNKppEk8Pfxn6ENImhrPX2
        2dlmc5H7jUGG/FoPsNKZKLV9BeTL1U4sbGLczKRgiA==
X-Google-Smtp-Source: ABdhPJzq5ogUegZNf9ozNumlO/uYc6UTXT6bPaLKzFqUs0x82NmJYMfbRfSmN21Zgp2e6BfQHjNyHZidvdhDPxj0jjg=
X-Received: by 2002:a25:d109:: with SMTP id i9mr49121946ybg.1.1641335101172;
 Tue, 04 Jan 2022 14:25:01 -0800 (PST)
MIME-Version: 1.0
References: <YbHIaq9a0CtqRulE@dhcp22.suse.cz> <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com>
 <YbIzOR13uPOI5EMB@dhcp22.suse.cz> <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
 <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
 <Ybsn2hJZXRofwuv+@cmpxchg.org> <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com>
 <CAJuCfpEHJTqG+PkAPJknf5_41ZKFqjk8pY=gTg_VZgsfY-=9Tg@mail.gmail.com>
 <Yc1spBeXal373b4A@dhcp22.suse.cz> <CAJuCfpGNCX=Z=Bi0N7DAj=CXdLqJOqQ_8kq_HQNaLhAvA5tjPw@mail.gmail.com>
 <YdLn+192/0HfNJyl@dhcp22.suse.cz> <35c340a6-96f-28a0-2b7b-2f9fbddc01f@google.com>
In-Reply-To: <35c340a6-96f-28a0-2b7b-2f9fbddc01f@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 4 Jan 2022 14:24:50 -0800
Message-ID: <CAJuCfpFm-4GSu4D_tWMV0a08LNVLjksEnRgRfaYvbciK=wCScA@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
To:     Hugh Dickins <hughd@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 1:16 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 3 Jan 2022, Michal Hocko wrote:
> > On Thu 30-12-21 09:29:40, Suren Baghdasaryan wrote:
> > > On Thu, Dec 30, 2021 at 12:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > It would be really great to make unlock_range oom reaper aware IMHO.
> > >
> > > What exactly do you envision? Say unlock_range() knows that it's
> > > racing with __oom_reap_task_mm() and that calling follow_page() is
> > > unsafe without locking, what should it do?
> >
> > My original plan was to make the page lock conditional and use
> > trylocking from the oom reaper (aka lockless context). It is OK to
> > simply bail out and leave some mlocked memory behind if there is a
> > contention on a specific page. The overall objective is to free as much
> > memory as possible, not all of it.
> >
> > IIRC Hugh was not a fan of this approach and he has mentioned that the
> > lock might not be even really needed and that the area would benefit
> > from a clean up rather than oom reaper specific hacks. I do tend to
> > agree with that. I just never managed to find any spare time for that
> > though and heavily mlocked oom victims tend to be really rare.
>
> I forget when that was, and what I had in mind at that time.
> But yes, by now I am very sure that munlocking needs a cleanup.
>
> And I do have that cleanup (against a much older tree), but never
> the time to rebase or post or shepherd it through N revisions.

How old was that tree?

>
> It was 22 files changed, 464 insertions, 706 deletions:
> which is too much to help with this immediate oom reaper question.
>
> I'd better not drive this discussion further off-course; but it pains
> me to see munlock_vma_pages obstructing, knowing there's a better way.
>
> I wonder: what if I were to steal time and promise to post a
> rebased series against 5.17-rc1 or rc2: not support it thereafter,
> but might there be someone to pick it up and shepherd it through?
> But there's no answer to that, without you seeing what it's like.

I would be interested in taking a look and see if it can be upstreamed
and supported without bugging you too much.
Thanks,
Suren.

>
> Hugh
