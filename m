Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE92046C8AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbhLHAaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLHAaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:30:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD61C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 16:26:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e3so2552874edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnwaxXWui3gt2JZ+0qiBlm1abRwyk5iLPJHl06L2hAo=;
        b=fs+OLMIuqVipcPWZE3/Kan9ba+o1UYCcof5P++Q0lNetI26biUrgWAU1u4wQOTBmH2
         Qs9ii3iucf1XPjOax/7DnGSGcAr7bOlBWD00sc8HIc4awsYrGsqMbJgBpJwr7RVL/04I
         0nvJBTcYWUFDTs06xIv79MCRDkD3q4BvFyiGs9MAh2jCZxfH0hR/hn8lDtHyT7zAvATV
         ckrL54WHUAunyZ+8HqWq0Le4QYA9n87vKLBTxB9XexhMGtuY4dUP0ySZsCUUzyaxTbze
         1y8Bi83RW+9nXEuVwphHk5l7EwgQOvf+F7Kj9ajx8OMXQWtnd7KbUM9YGhpOOh8iUGz5
         NV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnwaxXWui3gt2JZ+0qiBlm1abRwyk5iLPJHl06L2hAo=;
        b=wMcK2fG8bcTQwxuLHO0WofHm4nRuL1YwjmBdnl9FR+BnQ9nEMIceypMWN9aMeEwOWJ
         gVHxbsTkZi/ZY0LlYt21HdzDkejZOScIaTZciDMlrM+3IsjHqKDpNKN5TojeEtZU26yJ
         XZx0ypBMUvBBWVtkb0QeppCAFBujtpay2NLWYHgPv7rGVRA7fjiZFIzvJmLiLDKOP9eL
         q+qraaSZiY3PAIe5kb7DlsWWJaKu+VhknKoFtZONJXJ+lrsQjFCprKEenmMRd7r6Wu48
         8YNc81KIZWZdU5ac+VOih6O75msFBquViCoRWbw4/1s3QccEt90H19ALnMzZXo9hnS0t
         qOHQ==
X-Gm-Message-State: AOAM530/R8hDCPONhE7IiYa+xAMpbq8iW8PIgBJufw6nHtGDY4yLul1N
        EyRLLjivExGvbF3dinb92shXsSbJamvlcTMGvGQ=
X-Google-Smtp-Source: ABdhPJz+jtrB85elwFzrf6zDVdu64UBvHZuqqVPF14xMHHQth1rGv39AldN5fr0hYfrTAKz9KGYdVAfgFIBWk8TAS/k=
X-Received: by 2002:a17:906:538d:: with SMTP id g13mr3410503ejo.62.1638923200363;
 Tue, 07 Dec 2021 16:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20211207224013.880775-1-npache@redhat.com> <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
In-Reply-To: <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 7 Dec 2021 16:26:28 -0800
Message-ID: <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:
>
> > We have run into a panic caused by a shrinker allocation being attempted
> > on an offlined node.
> >
> > Our crash analysis has determined that the issue originates from trying
> > to allocate pages on an offlined node in expand_one_shrinker_info. This
> > function makes the incorrect assumption that we can allocate on any node.
> > To correct this we make sure the node is online before tempting an
> > allocation. If it is not online choose the closest node.
>
> This isn't fully accurate, is it?  We could allocate on a node which is
> presently offline but which was previously onlined, by testing
> NODE_DATA(nid).
>
> It isn't entirely clear to me from the v1 discussion why this approach
> isn't being taken?
>
> AFAICT the proposed patch is *already* taking this approach, by having
> no protection against a concurrent or subsequent node offlining?

AFAICT, we have not reached agreement on how to fix it yet. I saw 3
proposals at least:

1. From Michal, allocate node data for all possible nodes.
https://lore.kernel.org/all/Ya89aqij6nMwJrIZ@dhcp22.suse.cz/T/#u

2. What this patch does. Proposed originally from
https://lore.kernel.org/all/20211108202325.20304-1-amakhalov@vmware.com/T/#u

3. From David, fix in node_zonelist().
https://lore.kernel.org/all/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com/T/#u

>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >       int size = map_size + defer_size;
> >
> >       for_each_node(nid) {
> > +             int tmp = nid;
>
> Not `tmp', please.  Better to use an identifier which explains the
> variable's use.  target_nid?
>
> And a newline after defining locals, please.
>
> >               pn = memcg->nodeinfo[nid];
> >               old = shrinker_info_protected(memcg, nid);
> >               /* Not yet online memcg */
> >               if (!old)
> >                       return 0;
> >
> > -             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> > +             if(!node_online(nid))
>
> s/if(/if (/
>
> > +                     tmp = numa_mem_id();
> > +             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
> >               if (!new)
> >                       return -ENOMEM;
> >
>
> And a code comment fully explaining what's going on here?
