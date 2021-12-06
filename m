Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9D46A4DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbhLFStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLFStB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:49:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1569C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:45:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so47375172edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41srTfGlpmehHbwCLS1GDP+h5wFdKS7hsnX5LLmG86s=;
        b=eXDg6LoKQorLywqL78L+ebDdU1ljYhE26JEcTS7Sbt4q6p5ThMcQWAMkcZIp8mQOJU
         HaQH4nLYGwVakrpHwGbQSeRJqnH74i3wgAadZBIEi1nnz1c+LF++uGtJc2bH23w8ibUL
         4Ls9dkZDu5z33VHYeE9xJML0zqUJ3EGiLOGnseDhH1ixjxoVWejKqbbaXFEkdZqPJwrX
         R6bt/IgTRrhbxySd6vrhB4MDuyMV2O5jrThBPYPPo77LsHJ7mFQpYZQ+myJu1yTHPyYV
         DKpuqNjX/NrLlFOi9+CJuyYMnAgsPP7vbVa/spYVxHPYccwXbA9hgTr8m6k5C8kw6wMY
         X/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41srTfGlpmehHbwCLS1GDP+h5wFdKS7hsnX5LLmG86s=;
        b=wAV5pUjUsRyBAiMk5Ug0clq3qCXRcGSg9xxL0GPjEF3pc1Rxc+GJVaeSmqDghs/k74
         x+SAZMLL2D5BJJiWck7LFBhpJ9Dl0FBicDQbVng0QPEooYQIPwXBHyKJuzIj4Ov/inKj
         si1GTlL7ubDOcmZ+Uh0ZbVVnYszpvRwyzMrojb0MsV7KqUixYEXwpDlSn1oocUswLdqW
         ZyHL6ccAJnJTplRI3UND8NDaVNtBAa2rm9jpkuHQC1bk/0q82jHfhV2kv52YlJg5Xd2L
         oMqBP9tfCSowZrWCzTi2EKEMcnyKILubSZE1jLukjnUC6doQBqSWAL0oBV1KW2h2+IoZ
         DMpQ==
X-Gm-Message-State: AOAM532GCytnL4viSSrcleOwhsRJPUPOE+RrGlvUJqh+V7/zqnRN0D+z
        a/TL0xIk6M5kj/sRcrTpRoIuB94F1j8/kKbAsxU=
X-Google-Smtp-Source: ABdhPJyRLG3PGoi6znWxe/JyociTUb66Zzsvm7EmV4RN4Ro1h8iAhdSQUTYaj00vAYyvqoqqhxsnre6YVPkXHlxmTa0=
X-Received: by 2002:a17:906:4787:: with SMTP id cw7mr50552630ejc.311.1638816331464;
 Mon, 06 Dec 2021 10:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20211206033338.743270-1-npache@redhat.com> <20211206033338.743270-3-npache@redhat.com>
In-Reply-To: <20211206033338.743270-3-npache@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 6 Dec 2021 10:45:19 -0800
Message-ID: <CAHbLzkrwXYxZz37g-4aW1Gbs8sxTB72X6rH8DM+V+WKuwEg2fA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
To:     Nico Pache <npache@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 7:34 PM Nico Pache <npache@redhat.com> wrote:
>
> We have run into a panic caused by a shrinker allocation being attempted
> on an offlined node.
>
> Our crash analysis has determined that the issue originates from trying
> to allocate pages on an offlined node in expand_one_shrinker_info. This
> function makes the incorrect assumption that we can allocate on any node.
> To correct this we make sure we only itterate over online nodes.
>
> This assumption can lead to an incorrect address being assigned to ac->zonelist
> in the following callchain:
>         __alloc_pages
>         -> prepare_alloc_pages
>          -> node_zonelist
>
> static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> {
>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> }
> if the node is not online the return of node_zonelist will evaluate to a
> invalid pointer of 0x00000 + offset_of(node_zonelists) + (1|0)
>
> This address is then dereferenced further down the callchain in:
>         prepare_alloc_pages
>         -> first_zones_zonelist
>          -> next_zones_zonelist
>           -> zonelist_zone_idx
>
> static inline int zonelist_zone_idx(struct zoneref *zoneref)
> {
>         return zoneref->zone_idx;
> }
>
> Leading the system to panic.
>
> We also correct this behavior in alloc_shrinker_info, free_shrinker_info,
> and reparent_shrinker_deferred.
>
> Fixes: 2bfd36374edd ("mm: vmscan: consolidate shrinker_maps handling code")
> Fixes: 0a4465d34028 ("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")

I think the correct fix tag should be: 86daf94efb11 ("mm/memcontrol.c:
allocate shrinker_map on appropriate NUMA node") regardless of how we
will fix this problem.

> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/vmscan.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..731564b61e3f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -221,7 +221,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>         int nid;
>         int size = map_size + defer_size;
>
> -       for_each_node(nid) {
> +       for_each_online_node(nid) {
>                 pn = memcg->nodeinfo[nid];
>                 old = shrinker_info_protected(memcg, nid);
>                 /* Not yet online memcg */
> @@ -256,7 +256,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>         struct shrinker_info *info;
>         int nid;
>
> -       for_each_node(nid) {
> +       for_each_online_node(nid) {
>                 pn = memcg->nodeinfo[nid];
>                 info = rcu_dereference_protected(pn->shrinker_info, true);
>                 kvfree(info);
> @@ -274,7 +274,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>         map_size = shrinker_map_size(shrinker_nr_max);
>         defer_size = shrinker_defer_size(shrinker_nr_max);
>         size = map_size + defer_size;
> -       for_each_node(nid) {
> +       for_each_online_node(nid) {
>                 info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
>                 if (!info) {
>                         free_shrinker_info(memcg);
> @@ -417,7 +417,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>
>         /* Prevent from concurrent shrinker_info expand */
>         down_read(&shrinker_rwsem);
> -       for_each_node(nid) {
> +       for_each_online_node(nid) {
>                 child_info = shrinker_info_protected(memcg, nid);
>                 parent_info = shrinker_info_protected(parent, nid);
>                 for (i = 0; i < shrinker_nr_max; i++) {
> --
> 2.33.1
>
