Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAAB46A4D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347245AbhLFSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhLFSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:46:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D0C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:43:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so46368445edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUDt5s3yuSBQveVT1cZ1FoCgWl/bAqtAkIA9KkAetDM=;
        b=C80Rp8/K+bnXHiPfRxJQ2mTYHjKtvNQ10cnhRZ35QUWgxWI9N9ZDI5QSjQuh57Gs0m
         pWco7+93KyLC2lir/jwKaCzLea/mtUGnmJNDmB6hv69dP2saKYTPdYNlAMg+TVuJgfkx
         mht3PZFhid69rCWdZ+7JJkU211eaEIUyuwHBVvB6bwSs14fMR1Aem/ecWaDndjMFgtRz
         jAIRy8fYM4eoAFTXcbT+4X5nRKkjudpYozY2N0+yygjfEbLiVivsUCqau9D1GWyfqPkM
         QJkA5qdwYgbs6yFmtgbIHuuQNdlsYMytmsTDq5e90/E8+jFPOfAnkHwiWUAdk2UJba0O
         ScQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUDt5s3yuSBQveVT1cZ1FoCgWl/bAqtAkIA9KkAetDM=;
        b=CIhfplYWjRami8t2cgAfHbuR9VyzRM4+7jSAhGy2JIBku99NOugOiFtrENBdvzx60w
         QIdE3eFXYKRRYzqSowjugWybhHcFJqe99b84H3JYnwSvtYYEycN+u2LEV2TvGpKb28Rp
         FjxIaOrntCGeFOidixJHslTzXirQ5aDYiO0XgOQTC+C+TBQjWk6cpk8Cb8sU8RXhlb7x
         pdeH3CYs3mjIYxlyPHnOdLnqXg/NiV+WT9xFN+7y6F7ovCjotPOcb2KL4+uW/2hm1/uH
         5JuKIeRaJ0L/UjyXcvSAo+cnG8EengYNmb6fr8GTiMTUBwaOHxHARyECW/1DlcAYLS/m
         VXow==
X-Gm-Message-State: AOAM530FP9r2MS9Fj0WR7nq3Ez83LVkBQ+61wYv2h+1t4ZLogsnFbFLd
        7/jS3sMekr6eeTrelbOGJCb+fkCo3yIs6H4sY8o=
X-Google-Smtp-Source: ABdhPJx7A/zcKRpwWEX7JqrJh6F7F6b/HCnn7W2yCUL4Uu0NagdU+gAY5vTIY4ymivNRS6hJU6ZxUdG/5TfNadP+P7Y=
X-Received: by 2002:a50:c38c:: with SMTP id h12mr1337733edf.72.1638816178961;
 Mon, 06 Dec 2021 10:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20211206033338.743270-1-npache@redhat.com> <20211206033338.743270-3-npache@redhat.com>
 <Ya3WcYKcej8XEI0W@dhcp22.suse.cz> <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
In-Reply-To: <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 6 Dec 2021 10:42:47 -0800
Message-ID: <CAHbLzko0UeNadswXEnwr6EtuKAZT4T-fnC5F7xnFcH4RbjhAiA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 5:19 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.12.2021 13:45, David Hildenbrand wrote:
> >> This doesn't seen complete. Slab shrinkers are used in the reclaim
> >> context. Previously offline nodes could be onlined later and this would
> >> lead to NULL ptr because there is no hook to allocate new shrinker
> >> infos. This would be also really impractical because this would have to
> >> update all existing memcgs...
> >
> > Instead of going through the trouble of updating...
> >
> > ...  maybe just keep for_each_node() and check if the target node is
> > offline. If it's offline, just allocate from the first online node.
> > After all, we're not using __GFP_THISNODE, so there are no guarantees
> > either way ...
>
> Hm, can't we add shrinker maps allocation to __try_online_node() in addition
> to this patch?

I think the below fix (an example, doesn't cover all affected
callsites) should be good enough for now? It doesn't touch the hot
path of the page allocator.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..1252a33f7c28 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -222,13 +222,15 @@ static int expand_one_shrinker_info(struct
mem_cgroup *memcg,
        int size = map_size + defer_size;

        for_each_node(nid) {
+               int tmp = nid;
                pn = memcg->nodeinfo[nid];
                old = shrinker_info_protected(memcg, nid);
                /* Not yet online memcg */
                if (!old)
                        return 0;
-
-               new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
+               if (!node_online(nid))
+                       tmp = -1;
+               new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
                if (!new)
                        return -ENOMEM;

It used to use kvmalloc instead of kvmalloc_node(). The commit
86daf94efb11d7319fbef5e480018c4807add6ef ("mm/memcontrol.c: allocate
shrinker_map on appropriate NUMA node") changed to use *_node()
version. The justification was that "kswapd is always bound to
specific node. So allocate shrinker_map from the related NUMA node to
respect its NUMA locality." There is no kswapd for offlined node, so
just allocate shrinker info on node 0. This is also what
alloc_mem_cgroup_per_node_info() does.

Making memcg per node data node allocation memory hotplug aware should
be solved in a separate patchset IMHO.
