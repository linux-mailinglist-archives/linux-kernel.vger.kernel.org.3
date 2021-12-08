Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39446C9EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbhLHB1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhLHB1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:27:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB82C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:24:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z5so2934835edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xXQ8Z+aD37LV2ze3gAG6ixrya9vcE7/RlnSGWDE+C4=;
        b=KdqVRucWbgoRDwGAdXwrJam4dyvOrrXi22Z8iEJANkxDzxIZFpiO7xdmt6f4035yE6
         4y38ieaIw62a1gRJPbnlRgv8frB7584T5MyNqD1BUUhdleEr4M/x4gsruq1kg85I7t5L
         Jj6UnbPgU5VZkIdxi83jDd3vhxg4/ye6mxFtaj+fxujqA6fLdJECFu20OBl7sAYa7K1P
         WNpR4XpQe/94liJim3TQ5m5MdtwWBl+AJzLu8KKOyiGlAqxVzi8yEld3TUcUYjxToV9v
         tchKSX9i5WmCfNKIEpI7XF9Ds7ejkjANttd0Osw5+W38ufIwAvx8aVi3I2RuFeH0Gx2N
         b52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xXQ8Z+aD37LV2ze3gAG6ixrya9vcE7/RlnSGWDE+C4=;
        b=gib0EHwJArE+lbJljkgl2ximGSJDqKdg1eWAv8ZsLDseiz1XC/xViQheQTjXtw6a2f
         HXDoe34x7CUSqas5VwRrFqvY2NhNyOahydiRFiuOiO8XYQTxy/jkJhRrByhGWMXoZu2y
         jDAMa7cgKtYQM+9DwVAuod6s2XeACfyGy0oEONOne9A1JFxBMuqHEILb0PLWnhiNr8vX
         KUqadGysYfxLDzpfAa2jM6EBENPonkNo3U1lTZ0gEw/9LjkLsrIElIUZAepQrhzUrGPq
         gWrNPpEFeXJEXI1m2NKJLBmZ8mzqZ3dSJN5+bumTph10mAup3YTn31O7uQIkpcyXhCaR
         e58g==
X-Gm-Message-State: AOAM533iN75/yhOqVY2hhPYsN7ckzLuldnu2wXXRoXUi77AzUIARYsCd
        JR8gSQfHHYdXlBgNhd/uMap0+aldtVzUGfknvR8=
X-Google-Smtp-Source: ABdhPJwz1tcfy+ztYvdslkEPv5S1d3kB2gZn44d4gMIXu3emj/ER2xK6DwrZ9m2zNEp+QDgC9H7h0A+1opeGFjOOXhA=
X-Received: by 2002:a17:907:1b17:: with SMTP id mp23mr3453588ejc.521.1638926649838;
 Tue, 07 Dec 2021 17:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20211207224013.880775-1-npache@redhat.com> <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com> <17a7d9e4-5ebc-1160-1e5e-97707b6e5286@redhat.com>
In-Reply-To: <17a7d9e4-5ebc-1160-1e5e-97707b6e5286@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 7 Dec 2021 17:23:57 -0800
Message-ID: <CAHbLzkokNjJOb2fknm2+5pgf1+PBHviZA73nug5+dCB=7NKF4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     Nico Pache <npache@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Dec 7, 2021 at 4:33 PM Nico Pache <npache@redhat.com> wrote:
>
>
>
> On 12/7/21 19:26, Yang Shi wrote:
> > On Tue, Dec 7, 2021 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>
> >> On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:
> >>
> >>> We have run into a panic caused by a shrinker allocation being attempted
> >>> on an offlined node.
> >>>
> >>> Our crash analysis has determined that the issue originates from trying
> >>> to allocate pages on an offlined node in expand_one_shrinker_info. This
> >>> function makes the incorrect assumption that we can allocate on any node.
> >>> To correct this we make sure the node is online before tempting an
> >>> allocation. If it is not online choose the closest node.
> >>
> >> This isn't fully accurate, is it?  We could allocate on a node which is
> >> presently offline but which was previously onlined, by testing
> >> NODE_DATA(nid).
> >>
> >> It isn't entirely clear to me from the v1 discussion why this approach
> >> isn't being taken?
> >>
> >> AFAICT the proposed patch is *already* taking this approach, by having
> >> no protection against a concurrent or subsequent node offlining?
> >
> > AFAICT, we have not reached agreement on how to fix it yet. I saw 3
> > proposals at least:
> >
> > 1. From Michal, allocate node data for all possible nodes.
> > https://lore.kernel.org/all/Ya89aqij6nMwJrIZ@dhcp22.suse.cz/T/#u
> >
> > 2. What this patch does. Proposed originally from
> > https://lore.kernel.org/all/20211108202325.20304-1-amakhalov@vmware.com/T/#u
>
> Correct me if im wrong, but isn't that a different caller? This patch fixes the
> issue in expand_one_shrinker_info.

Yes, different caller, but same approach. The cons with this approach
is we have to fix all the places. It seems Michal and David are not
fans for this approach IIRC.

>
> > 3. From David, fix in node_zonelist().
> > https://lore.kernel.org/all/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com/T/#u
> >
> >>
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >>>       int size = map_size + defer_size;
> >>>
> >>>       for_each_node(nid) {
> >>> +             int tmp = nid;
> >>
> >> Not `tmp', please.  Better to use an identifier which explains the
> >> variable's use.  target_nid?
> >>
> >> And a newline after defining locals, please.
> >>
> >>>               pn = memcg->nodeinfo[nid];
> >>>               old = shrinker_info_protected(memcg, nid);
> >>>               /* Not yet online memcg */
> >>>               if (!old)
> >>>                       return 0;
> >>>
> >>> -             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> >>> +             if(!node_online(nid))
> >>
> >> s/if(/if (/
> >>
> >>> +                     tmp = numa_mem_id();
> >>> +             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
> >>>               if (!new)
> >>>                       return -ENOMEM;
> >>>
> >>
> >> And a code comment fully explaining what's going on here?
> >
>
